Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E37EC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0A420801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxrEMRPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0A420801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SpZ-0000x6-6V
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOJ-0003CF-7E
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOH-00085D-Eh
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:03 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SOH-00084f-6a
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:01 -0500
Received: by mail-pj1-x1044.google.com with SMTP id f2so258273pjq.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7RppIHsUBx+sMUATckkjKS/fMgtzYfrRf6rL6C92oB4=;
 b=uxrEMRPDI4OXMJQZdOigni0/MA+4Xdv2uZiAysEpP0kA0+6JpNw+XmQaoK7TPjLNs0
 wP5zZJZNbZTuKfAQx1VRmOeGvu0TI2pVB57i3ubYpiut+2isqnYMJjaJdF2xS4EThn36
 XeB5YtQv7xJkSkU5d3yfemMTqIVWcHoAXNPiynyrlqUwHcGN+Cxduswb3bWr8EL4FAiD
 7rPzXHDL2hKBHaSwtQNyD7BYExxhroRdQ6u1LbpZ8pCkpD4NUJ76oLKfk44Uns2WJz4c
 21r9CsiqXyQwb/vPUgif3JDnlUS6Ykgz5ZJaNQ3EQpAV6Mg/y2D6jNCEwXG2ej/JNv4c
 Tfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7RppIHsUBx+sMUATckkjKS/fMgtzYfrRf6rL6C92oB4=;
 b=qXvEE13bYzHJJoVvraBGKfS382l8nHXcf+Dhb1shTeyGAYHxwm5stGEHGqfZqD/+Hy
 LybPEBkeXW1fX2NQ6l8cocOwgFQrcwB5hxDFjWb59CsMiY1xzxr6WKHmks8k6QLtez7G
 5yK6BCL21k2yCIkSdY0kRgWV6JOdb+QepzZkc90wO9Ht7xBzr14J9GXbSAYgz5seJvv2
 W9bbyoi6c+XD7Hc5CRdow1ASVO9jqaGlna8qEXse3ftAN8B1ITP/QHrI4qL5KusXOmco
 a9zrBwKwGUG+/T6zPcGRZRDDa56s4QF55wEUAj8b9mEJ7j52I5S8gFGeYqU0vIZaxedO
 XWHg==
X-Gm-Message-State: APjAAAUwtd1EjbM/zTemNJn7VsdpI607kUPOobJjoj6WbZk1E3i/hiSL
 x94bxsU4Dd9wy5h665mu4bYijwH/XXU=
X-Google-Smtp-Source: APXvYqzXKW/487/6schOn0OS0C7pXXKaHXKL1vcuyhZnmkcq+1PvlF+zqRStFrDliyJhDRhzqOhQGw==
X-Received: by 2002:a17:902:fe10:: with SMTP id
 g16mr26507709plj.93.1582130399673; 
 Wed, 19 Feb 2020 08:39:59 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:39:59 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/14] tests/vm: Added configuration file support
Date: Wed, 19 Feb 2020 11:35:31 -0500
Message-Id: <20200219163537.22098-9-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219163537.22098-1-robert.foley@linaro.org>
References: <20200219163537.22098-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes to tests/vm/basevm.py to allow accepting a configuration file
as a parameter. Allows for specifying VM options such as
cpu, machine, memory, and arbitrary qemu arguments for specifying options
such as NUMA configuration.
Also added an example conf_example_aarch64.yml and conf_example_x86.yml.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/Makefile.include         |  2 ++
 tests/vm/basevm.py                | 29 +++++++++++++++++-
 tests/vm/conf_example_aarch64.yml | 51 +++++++++++++++++++++++++++++++
 tests/vm/conf_example_x86.yml     | 50 ++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 76a1bd7fe8..e19072f303 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -36,6 +36,8 @@ vm-help vm-test:
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
+	@echo "    QEMU_CONFIG=/path/conf.yml   - Change path to VM configuration .yml file."
+	@echo "                                   See conf_example_*.yml for file format details."
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index ed1b56bcea..a24ce090c7 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -29,6 +29,7 @@ import tempfile
 import shutil
 import multiprocessing
 import traceback
+import yaml
 
 SSH_KEY_FILE = os.path.join(os.path.dirname(__file__),
                "..", "keys", "id_rsa")
@@ -474,9 +475,31 @@ class BaseVM(object):
                                cwd=cidir,
                                stdin=self._devnull, stdout=self._stdout,
                                stderr=self._stdout)
-
         return os.path.join(cidir, "cloud-init.iso")
 
+def parse_config(config, args):
+    """ Parse yaml config and populate our config structure.
+        The yaml config allows the user to override the
+        defaults for VM parameters.  In many cases these
+        defaults can be overridden without rebuilding the VM."""
+    if args.config:
+        config_file = args.config
+    elif 'QEMU_CONFIG' in os.environ:
+        config_file = os.environ['QEMU_CONFIG']
+    else:
+        return config
+    if not os.path.exists(config_file):
+        raise Exception("config file {} does not exist".format(config_file))
+    with open(config_file) as f:
+        yaml_dict = yaml.safe_load(f)
+
+    if 'qemu-conf' in yaml_dict:
+        config.update(yaml_dict['qemu-conf'])
+    else:
+        raise Exception("config file {} is not valid"\
+                        " missing qemu-conf".format(config_file))
+    return config
+
 def parse_args(vmcls):
 
     def get_default_jobs():
@@ -513,6 +536,9 @@ def parse_args(vmcls):
                       help="run tests with a snapshot")
     parser.add_option("--log-console", action="store_true",
                       help="Log console to file.")
+    parser.add_option("--config", "-c", default=None,
+                      help="Provide config yaml for configuration. "\
+                           "See config_example.yaml for example.")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -524,6 +550,7 @@ def main(vmcls, config=None):
         if not argv and not args.build_qemu and not args.build_image:
             print("Nothing to do?")
             return 1
+        config = parse_config(config, args)
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
         vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
diff --git a/tests/vm/conf_example_aarch64.yml b/tests/vm/conf_example_aarch64.yml
new file mode 100644
index 0000000000..9d44ae356f
--- /dev/null
+++ b/tests/vm/conf_example_aarch64.yml
@@ -0,0 +1,51 @@
+#
+# Example yaml for use by any of the scripts in tests/vm.
+# Can be provided as an environment variable QEMU_CONFIG
+#
+qemu-conf:
+
+    # If any of the below are not provided, we will just use the qemu defaults.
+
+    # Login username and password(has to be sudo enabled)
+    guest_user: qemu
+    guest_pass: "qemupass"
+
+    # Password for root user can be different from guest.
+    root_pass: "qemupass"
+
+    # If one key is provided, both must be provided.
+    #ssh_key: /complete/path/of/your/keyfile/id_rsa
+    #ssh_pub_key: /complete/path/of/your/keyfile/id_rsa.pub
+
+    cpu: max
+    machine: virt,gic-version=max
+    memory: 16G
+
+    # The below is a example for how to configure NUMA topology with
+    # 4 NUMA nodes and 2 different NUMA distances.
+    qemu_args: "-smp cpus=16,sockets=2,cores=8
+                -numa node,cpus=0-3,nodeid=0 -numa node,cpus=4-7,nodeid=1
+                -numa node,cpus=8-11,nodeid=2 -numa node,cpus=12-15,nodeid=3
+                -numa dist,src=0,dst=1,val=15 -numa dist,src=2,dst=3,val=15
+                -numa dist,src=0,dst=2,val=20 -numa dist,src=0,dst=3,val=20
+                -numa dist,src=1,dst=2,val=20 -numa dist,src=1,dst=3,val=20"
+
+    # By default we do not set the DNS.
+    # You override the defaults by setting the below.
+    #dns: 1.234.567.89
+
+    # By default we will use a "block" device, but
+    # you can also boot from a "scsi" device.
+    # Just keep in mind your scripts might need to change
+    # As you will have /dev/sda instead of /dev/vda (for block device)
+    boot_dev_type: "block"
+
+    # By default the ssh port is not fixed.
+    # A fixed ssh port makes it easier for automated tests.
+    #ssh_port: 5555
+
+    # To install a different set of packages, provide a command to issue
+    #install_cmds: "apt-get update ; apt-get build-dep -y qemu"
+
+    # Or to skip the install entirely, just provide ""
+    #install_cmds: ""
diff --git a/tests/vm/conf_example_x86.yml b/tests/vm/conf_example_x86.yml
new file mode 100644
index 0000000000..78d3f5830f
--- /dev/null
+++ b/tests/vm/conf_example_x86.yml
@@ -0,0 +1,50 @@
+#
+# Example yaml for use by any of the x86 based scripts in tests/vm.
+# Can be provided as an environment variable QEMU_CONFIG
+#
+qemu-conf:
+
+    # If any of the below are not provided, we will just use the qemu defaults.
+
+    # Login username and password(has to be sudo enabled)
+    guest_user: "qemu"
+    guest_pass: "qemupass"
+
+    # Password for root user can be different from guest.
+    root_pass: "qemupass"
+
+    # Provide default ssh keys of current user.
+    # You need to edit the below for your user.
+    #ssh_key_file: /home/<user>/.ssh/id_rsa
+    #ssh_pub_key_file: /home/<user>/.ssh/id_rsa.pub
+
+    cpu: max
+    machine: pc
+    memory: 8G
+
+    # The below is a example for how to configure NUMA topology with
+    # 4 NUMA nodes and 2 different NUMA distances.
+    qemu_args: "-smp cpus=8,sockets=2,cores=4
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=0,id=ram-node0
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=0,id=ram-node1
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=1,id=ram-node2
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=1,id=ram-node3
+                -numa node,cpus=0-1,nodeid=0 -numa node,cpus=2-3,nodeid=1
+                -numa node,cpus=4-5,nodeid=2 -numa node,cpus=6-7,nodeid=3
+                -numa dist,src=0,dst=1,val=15 -numa dist,src=2,dst=3,val=15
+                -numa dist,src=0,dst=2,val=20 -numa dist,src=0,dst=3,val=20
+                -numa dist,src=1,dst=2,val=20 -numa dist,src=1,dst=3,val=20"
+
+    # By default we do not set the DNS.
+    # You override the defaults by setting the below.
+    #dns: "1.234.567.89"
+
+    # By default we will use a "block" device, but
+    # you can also boot from a "scsi" device.
+    # Just keep in mind your scripts might need to change
+    # As you will have /dev/sda instead of /dev/vda (for block device)
+    boot_dev_type: "block"
+
+    # By default the ssh port is not fixed.
+    # A fixed ssh port makes it easier for automated tests.
+    ssh_port: 5555
-- 
2.17.1


