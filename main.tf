terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://api.dev.am/localstack/"
    cloudformation = "http://api.dev.am/localstack/"
    cloudwatch     = "http://api.dev.am/localstack/"
    dynamodb       = "http://api.dev.am/localstack/"
    es             = "http://api.dev.am/localstack/"
    firehose       = "http://api.dev.am/localstack/"
    iam            = "http://api.dev.am/localstack/"
    kinesis        = "http://api.dev.am/localstack/"
    lambda         = "http://api.dev.am/localstack/"
    route53        = "http://api.dev.am/localstack/"
    redshift       = "http://api.dev.am/localstack/"
    s3             = "http://api.dev.am/localstack/"
    secretsmanager = "http://api.dev.am/localstack/"
    ses            = "http://api.dev.am/localstack/"
    sns            = "http://api.dev.am/localstack/"
    sqs            = "http://api.dev.am/localstack/"
    ssm            = "http://api.dev.am/localstack/"
    stepfunctions  = "http://api.dev.am/localstack/"
    sts            = "http://api.dev.am/localstack/"
  }
}

variable "s3_bucket_tag" {
  description = "the team tag when creating a s3 bucket"
  default = "motor"
  type = string
}

resource "aws_s3_bucket" "localstack-s3" {
  bucket = "my-first-local-s3-bucket"
  tags = {
    Name        = "My Bucket"
    Environment = "Local"
    Team        = var.s3_bucket_tag
  }
}

resource "aws_s3_bucket" "localstack-s3-second" {
  bucket = "my-second-local-s3-bucket"
  tags = {
    Name        = "My Bucket"
    Environment = "Local"
    Team        = "Motor"
  }
}

data "aws_s3_bucket" "selected_s3_bucket" {
  bucket = "my-first-local-s3-bucket"
  depends_on = [aws_s3_bucket.localstack-s3]
}

output "foo" {
  value = aws_s3_bucket.localstack-s3.id
}