module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  name = "something"

  # Launch configuration
  lc_name = "${var.lc_name}"

  image_id        = "${var.image_id}"
  instance_type   = "${var.instance_type}"
  security_groups = [aws_security_group.allow_80_443.id]


  # Auto scaling group
  asg_name                  = "${var.asg_name}"
  vpc_zone_identifier       = ["${var.vpc_zone_identifier1}","${var.vpc_zone_identifier2}","${var.vpc_zone_identifier3}"]
  health_check_type         = "EC2"
  min_size                  = "${var.min_size}"
  max_size                  = "${var.max_size}"
  desired_capacity          = "${var.desired_capacity}"
  wait_for_capacity_timeout = 0

ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]
tags = [
    {
      key                 = "Environment"
      value               = "${var.tag_value1}"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "${var.tag_value2}"
      propagate_at_launch = true
    },
  ]

}
