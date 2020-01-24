Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF88C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D08B20709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwOm5ktl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D08B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2JH-0002L8-Mf
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iv2G1-0003sO-0D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iv2Fz-00034o-Ii
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:32 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iv2Fz-00034B-CP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:31 -0500
Received: by mail-pg1-x544.google.com with SMTP id r11so1409434pgf.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MwX8tXxSDd35fuy08I41Y0xncP6DuvbsklPwCAUTvwA=;
 b=MwOm5ktlM7+HK+md2zbDxrdFdZfbx2+qbTdvOyBSQA1OBh3wIeUNrRPCaZDSm9C9L6
 /Nv1MerRi0T/0gl9mKv3FDe178tLcWOrgP3vLhpd7Qdj1D4Pim+MzjAEnm8aJb1oZsKT
 b34Ql4pzMWQDi33+s+zVzSe5u2eUJnZoK/DtiH5ozn8XpFjE7l8ovrNlCCRLKZsoVdNQ
 iwsP+oiAdhJ2eEr5QSfUJx0zyaQZwZVgUUkYEMB0EtQuPZtfPkWcFSw+1biFW9NNZC9P
 X84hDb9+D+wzMliptZf+lpqEPt3lDM9BTnuSVpslfdHLIcExtGh1t4bhipLG2Tetud8v
 +Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MwX8tXxSDd35fuy08I41Y0xncP6DuvbsklPwCAUTvwA=;
 b=oq9oXS0voZg9PXUU8R0uKQjBcYOCghbzQxu0mqc83pFLn1LJ987mV9Km5NxeU3U7JW
 Tnwg5Ow5UHoIkVF/6YFP5FprGN3LBK+rP/bgqr28nCQAG1gpCOH1Gb0xNVW+2mAAEYD/
 iZGQ7pL8E2Po3zcoXk00Zk7ypHA7sl7pMHZEFfDVg+H5syOzJqWBSSWHcSJkAPqetz24
 fToOq7p0QvkIHk9ui4R5MEicntEa5m5FqhfqLXmV9Ufn/S+55elVXFYwdE6mcpbvqBGu
 7MjELj2H4H0UhivacZJlSvIQUcSizKvP8X/Pwc3oxUULwlqdRa5AhDe+OUG5rPtbfgDa
 B4dg==
X-Gm-Message-State: APjAAAVGR6MfT74Z89Rlpp6Px/bWzrhfeCw6u1NNef2xvYkKxcjYrrLz
 8jMo4CMT0B/dECj8w6Hyhg9tHZAbmi4=
X-Google-Smtp-Source: APXvYqz6XTm6Q7cEUEXsTcSRzl3A9hx23I9QsHtea3slJvyXe3SiKJcRDeHVXLRku/Y1UDxsdZE6mA==
X-Received: by 2002:a63:364f:: with SMTP id d76mr5175232pga.215.1579884990017; 
 Fri, 24 Jan 2020 08:56:30 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id l10sm6969953pjy.5.2020.01.24.08.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:56:29 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] tests/vm: Added configuration file support
Date: Fri, 24 Jan 2020 11:53:32 -0500
Message-Id: <20200124165335.422-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124165335.422-1-robert.foley@linaro.org>
References: <20200124165335.422-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes to tests/vm/basevm.py to allow accepting a configuration file
as a parameter. Allows for specifying VM options such as
cpu, machine, memory, and arbitrary qemu arguments for specifying options
such as NUMA configuration.
Also added an example config_example.yml.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/basevm.py          | 60 +++++++++++++++++++++++++++++++++++++
 tests/vm/config_example.yml | 52 ++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 tests/vm/config_example.yml

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index ec92c8f105..08a8989ac0 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -31,6 +31,7 @@ import tempfile
 import shutil
 import multiprocessing
 import traceback
+import yaml
 
 SSH_KEY_FILE = os.path.join(os.path.dirname(__file__),
                "..", "keys", "id_rsa")
@@ -396,6 +397,61 @@ class BaseVM(object):
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
 
+
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
+    if 'target-conf' in yaml_dict:
+        target_dict = yaml_dict['target-conf']
+        if 'username' in target_dict and target_dict['username'] != 'root':
+            config['guest_user'] = target_dict['username']
+        if 'password' in target_dict:
+            config['root_pass'] = target_dict['password']
+            config['guest_pass'] = target_dict['password']
+        if any (k in target_dict for k in ("ssh_key","ssh_pub_key")) and \
+           not all (k in target_dict for k in ("ssh_key","ssh_pub_key")):
+            missing_key = "ssh_pub_key" \
+              if 'ssh_key' in target_dict else "ssh_key"
+            raise Exception("both ssh_key and ssh_pub_key required. "
+                            "{} key is missing.".format(missing_key))
+        if 'ssh_key' in target_dict:
+            config['ssh_key_file'] = target_dict['ssh_key']
+            if not os.path.exists(config['ssh_key_file']):
+                raise Exception("ssh key file not found.")
+        if 'ssh_pub_key' in target_dict:
+            config['ssh_pub_key_file'] = target_dict['ssh_pub_key']
+            if not os.path.exists(config['ssh_pub_key_file']):
+                raise Exception("ssh pub key file not found.")
+        if 'machine' in target_dict:
+            config['machine'] = target_dict['machine']
+        if 'qemu_args' in target_dict:
+            qemu_args = target_dict['qemu_args']
+            qemu_args = qemu_args.replace('\n', ' ').replace('\r', '')
+            config['extra_args'] = qemu_args.split(' ')
+        if 'memory' in target_dict:
+            config['memory'] = target_dict['memory']
+        if 'dns' in target_dict:
+            config['dns'] = target_dict['dns']
+        if 'cpu' in target_dict:
+            config['cpu'] = target_dict['cpu']
+        if 'ssh_port' in target_dict:
+            config['ssh_port'] = target_dict['ssh_port']
+        if 'install_cmds' in target_dict:
+            config['install_cmds'] = target_dict['install_cmds']
+    return config
+
 def parse_args(vmcls):
 
     def get_default_jobs():
@@ -430,6 +486,9 @@ def parse_args(vmcls):
                       help="Interactively run command")
     parser.add_option("--snapshot", "-s", action="store_true",
                       help="run tests with a snapshot")
+    parser.add_option("--config", "-c", default=None,
+                      help="Provide config yaml for configuration. "\
+                           "See config_example.yaml for example.")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -441,6 +500,7 @@ def main(vmcls, config=None):
         if not argv and not args.build_qemu and not args.build_image:
             print("Nothing to do?")
             return 1
+        config = parse_config(config, args)
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
         vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config)
diff --git a/tests/vm/config_example.yml b/tests/vm/config_example.yml
new file mode 100644
index 0000000000..0a1fec3824
--- /dev/null
+++ b/tests/vm/config_example.yml
@@ -0,0 +1,52 @@
+#
+# Example yaml for use by any of the scripts in tests/vm.
+# Can be provided as an environment variable QEMU_CONFIG
+#
+target-conf:
+
+    # If any of the below are not provided, we will just use the qemu defaults.
+
+    # Login username (has to be sudo enabled)
+    #username: qemu
+
+    # Password is used by root and default login user.
+    #password: "qemupass"
+
+    # If one key is provided, both must be provided.
+    #ssh_key: /complete/path/of/your/keyfile/id_rsa
+    #ssh_pub_key: /complete/path/of/your/keyfile/id_rsa.pub
+
+    cpu: max
+    machine: virt,gic_version=3
+    memory: 16G
+
+    # The below is an example for how to configure NUMA topology with
+    # 4 NUMA nodes and 2 different NUMA distances.
+    qemu_args: "-smp cpus=16,sockets=2,cores=8
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=0,id=ram-node0
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=0,id=ram-node1
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=1,id=ram-node2
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=1,id=ram-node3
+                -numa node,memdev=ram-node0,cpus=0-3,nodeid=0 -numa node,memdev=ram-node1,cpus=4-7,nodeid=1
+                -numa node,memdev=ram-node2,cpus=8-11,nodeid=2 -numa node,memdev=ram-node3,cpus=12-15,nodeid=3
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
+    #boot_dev_type: "scsi"
+
+    # By default the ssh port is not fixed.
+    # A fixed ssh port makes it easier for automated tests.
+    #ssh_port: 5555
+
+    # To install a different set of packages, provide a command to issue
+    #install_cmds: "apt-get update ; apt-get build-dep -y qemu"
+
-- 
2.17.1


