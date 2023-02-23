resource "kubernetes_namespace" "example" {
  metadata {
    name = "tf"
  }
}

resource "kubernetes_deployment" "example" {
  metadata {
    name = "terraform-example"
    labels = {
      test = "app"
    }
    namespace = "tf"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = "app"
      }
    }

    template {
      metadata {
        labels = {
          test = "app"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "example"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}