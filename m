Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D213C47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DE42076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZwq++7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DE42076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBnL-0000kH-FL
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBdT-0000T4-IC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBaC-0003C1-7r
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:02:03 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:41496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jUBaB-0003Bg-Os
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:58:39 -0400
Received: by mail-qt1-x843.google.com with SMTP id h26so5386033qtu.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YCSiLeyYTeL4ASqV7GKK96BGQv7O117PTDXpRucreq4=;
 b=VZwq++7L4VlPvwUWqQLxL6IBKZQPViQKm1C8e0toYx5CzI2xt2InSarHVNP/S2pxAc
 jLH4BOLaeGdgs4aXbNNWn9UwP89CV0b871x5UFUUiDk57dMECSzS0DZTgvR5VgX80tam
 M8vrS1mfLbQYSV5DfR2Tyap7b8PC7tMsT4f1DTAStMnwlqrazSlAFsuUHxIs7hyWE6r0
 eWLMqnmSQAmVELhZHCPSwzu/MhZBKjWMvd3kakwl6PUUU1GwcKCmxQf5mQASd0ehmSuH
 9MHhYYrlwW0Wg+eh20bfl3OszGW2oYMB6Y5VdLnyX3/TK7O9vao+96R+7IFTz6daDCAk
 JI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YCSiLeyYTeL4ASqV7GKK96BGQv7O117PTDXpRucreq4=;
 b=KnrGzx6JTcVKzFRfaoJ0t8dxf4MsoqcgPE2lGy8VJhQJtXM1cRCMWksixLyYrMAoi7
 yI/90X7lNJg9Y8MGf3QOL552ElSJpUAc4m/ALbam9MPIxnh5FyA1VLER0Us0TdLHlybf
 33Nr1t3v/cKM06kFiwh0VgljoUno3QJhFFu6yNUXPmf5pDgnSI2GNN4YZaC2RyvDge+p
 KfALJhjtwStShNYmzqehO8Mt+xYfJNL8IBI6BXSmyl0bV5Ww9Hn3hHvAETTW9tVYbRKa
 qa4HW1XbHTn27yxFjFwXvicON1RPN4y8DvMjRiN6l0vjf6JkqfuAIEEG5EGR0NhjdO78
 s9Pw==
X-Gm-Message-State: AGi0PuYrLOblZEwEY3DbLwl/E/Yt9xf0EH4Pd29jFXfKFUkz1nKyPixz
 MQXvdxm5sAUqqbXhz/JLnqTHitBpLP53NA==
X-Google-Smtp-Source: APiQypLKJ4QWscw3ACFVbCRbjTFrzoC8voLGqgOYIypNMKbRaLZgqGRv8UPI5zxYU9/Gkhs1hquZyQ==
X-Received: by 2002:ac8:6751:: with SMTP id n17mr4560171qtp.16.1588262317813; 
 Thu, 30 Apr 2020 08:58:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:7489:3328:3806:7c3])
 by smtp.gmail.com with ESMTPSA id v16sm305254qkf.80.2020.04.30.08.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 08:58:37 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/9] tests/vm: Added configuration file support
Date: Thu, 30 Apr 2020 11:57:11 -0400
Message-Id: <20200430155718.212-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430155718.212-1-robert.foley@linaro.org>
References: <20200430155718.212-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::843
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
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 configure                         |  9 ++++++
 tests/vm/Makefile.include         |  6 ++++
 tests/vm/basevm.py                | 40 +++++++++++++++++++++++-
 tests/vm/conf_example_aarch64.yml | 51 +++++++++++++++++++++++++++++++
 tests/vm/conf_example_x86.yml     | 50 ++++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml

diff --git a/configure b/configure
index 23b5e93752..eec6615b81 100755
--- a/configure
+++ b/configure
@@ -950,6 +950,13 @@ do
     fi
 done
 
+# Check for existence of python3 yaml, needed to
+# import yaml config files into vm-build.
+python_yaml="no"
+if $(python3 -c "import yaml" 2> /dev/null); then
+    python_yaml="yes"
+fi
+
 : ${smbd=${SMBD-/usr/sbin/smbd}}
 
 # Default objcc to clang if available, otherwise use CC
@@ -6581,6 +6588,7 @@ if test "$docs" != "no"; then
     echo "sphinx-build      $sphinx_build"
 fi
 echo "genisoimage       $genisoimage"
+echo "python_yaml       $python_yaml"
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
     echo "smbd              $smbd"
@@ -7642,6 +7650,7 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
+echo "PYTHON_YAML=$python_yaml" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=$iasl" >> $config_host_mak
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 1bf9693d19..78a2de1f82 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -43,6 +43,12 @@ endif
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
+ifeq ($(PYTHON_YAML),yes)
+	@echo "    QEMU_CONFIG=/path/conf.yml   - Change path to VM configuration .yml file."
+else
+	@echo "    (install python3-yaml to enable support for yaml file to configure a VM.)"
+endif
+	@echo "                                   See conf_example_*.yml for file format details."
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index fb93a111c1..97f8ac4218 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -477,9 +477,43 @@ class BaseVM(object):
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
+    # We gracefully handle importing the yaml module
+    # since it might not be installed.
+    # If we are here it means the user supplied a .yml file,
+    # so if the yaml module is not installed we will exit with error.
+    try:
+        import yaml
+    except ImportError:
+        print("The python3-yaml package is needed "\
+              "to support config.yaml files")
+        # Instead of raising an exception we exit to avoid
+        # a raft of messy (expected) errors to stdout.
+        exit(1)
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
@@ -514,6 +548,9 @@ def parse_args(vmcls):
                       help="Interactively run command")
     parser.add_option("--snapshot", "-s", action="store_true",
                       help="run tests with a snapshot")
+    parser.add_option("--config", "-c", default=None,
+                      help="Provide config yaml for configuration. "\
+                           "See config_example.yaml for example.")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -525,6 +562,7 @@ def main(vmcls, config=None):
         if not argv and not args.build_qemu and not args.build_image:
             print("Nothing to do?")
             return 1
+        config = parse_config(config, args)
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
         vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config)
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


