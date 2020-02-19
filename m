Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C86C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E566924656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpF6qa9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E566924656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SbT-0007ND-2P
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOQ-0003Ut-R1
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOO-0008BY-Mw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:10 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:35901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SOO-0008B7-Dr
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:08 -0500
Received: by mail-pf1-x42a.google.com with SMTP id 185so332156pfv.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NX9h8pD+23hYiUkVbRsk8kJJ4NVy28DePqm6/XUwIAo=;
 b=fpF6qa9neTsqXj8bEMartarTfACRvdZyqKUH26PtlvUrvgL/npoSKrsOcPt7Gtm3Tz
 EGNdn4nUScf7ahCtVNvsVeVH3RPdLYEZY91VmcojOuGzYwbfjtE0zSqPByTuqk0qbklF
 6x4aPJa4TaytZ3c3fy0IaiLUv5j1IF6LqBbzFXHoaxBq06IN1VPo2p/Q7BNVJbgmOhxA
 UzXe9PsdBqJfdgx4yocwdbLRvk8ZCLnFBQiONfpMr2hOkFyg7CBmOLeTESx6OdJOeWSO
 F5nFQJDQndZnHznVfOYLZ0Z5yZRD7VVlddVz4YKkgTAyl+ObWLZuevj7zF5xZAkKTwD7
 BVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NX9h8pD+23hYiUkVbRsk8kJJ4NVy28DePqm6/XUwIAo=;
 b=FJa0p0SMHtP0drwpj0Y93LMXgALFkgG6jwt1SPqDcYZfOdPJnod93ffQBSPhU3/Q1g
 FbdcddoIkWDgB8vPusiC5KZ2Yr93s1mbpr+29sqHC4YPfMUCNUHWBOSgdZBEDYy5LfSl
 EHoH55Wuz+6aLtL0YxfWEwb2jH8wBXLnA+tXodwGCqMzuFnS/LOM60/LWU/Q8EgwJvUc
 +DJWcnrvc09mfZOZmOALgL2QZkbDIARSXBX8v63p3+2my5btpFFp1ZLtqttj+8mnTwoy
 l0cX60FvjVYud4uVppKPemXm3CITp0mGBsGNeIxfsxGOeVJegLRylrHUFYOcZomv2rnb
 MGMg==
X-Gm-Message-State: APjAAAWhSRs39ClYEEHzix5Xy8fyuXrANI/ubb3G8h3HEU1mR3TlYwyF
 z0BJ+1E2G1Z1vaaLc9KKvvQuSSPX9nI=
X-Google-Smtp-Source: APXvYqyCw2LWtfckRKv8ZVgMs/qhm0Ia96KXNsJEQgf7TQmU47nQQe3S0m8PqcrSerNuNaftgwPeaQ==
X-Received: by 2002:a63:7453:: with SMTP id e19mr1078954pgn.50.1582130406869; 
 Wed, 19 Feb 2020 08:40:06 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:40:06 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/14] tests/vm: Added a new script for ubuntu.aarch64.
Date: Wed, 19 Feb 2020 11:35:35 -0500
Message-Id: <20200219163537.22098-13-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219163537.22098-1-robert.foley@linaro.org>
References: <20200219163537.22098-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42a
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

ubuntu.aarch64 provides a script to create an Ubuntu 18.04 VM.
Another new file is also added aarch64vm.py, which is a module with
common methods used by aarch64 VMs, such as how to create the
flash images.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/Makefile.include |   3 +-
 tests/vm/aarch64vm.py     | 100 ++++++++++++++++++++++++++++++++
 tests/vm/basevm.py        |   8 +++
 tests/vm/ubuntu.aarch64   | 117 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100755 tests/vm/ubuntu.aarch64

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 7557c154a1..9dfa517936 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -2,7 +2,7 @@
 
 .PHONY: vm-build-all vm-clean-all
 
-IMAGES := ubuntu.i386 freebsd netbsd openbsd centos fedora
+IMAGES := ubuntu.i386 freebsd netbsd openbsd centos fedora ubuntu.aarch64
 IMAGES_DIR := $(HOME)/.cache/qemu-vm/images
 IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 
@@ -18,6 +18,7 @@ vm-help vm-test:
 	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
 	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
 	@echo "  vm-build-fedora                 - Build QEMU in Fedora VM"
+	@echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu aarch64 VM"
 	@echo ""
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
diff --git a/tests/vm/aarch64vm.py b/tests/vm/aarch64vm.py
new file mode 100644
index 0000000000..fd48735b3a
--- /dev/null
+++ b/tests/vm/aarch64vm.py
@@ -0,0 +1,100 @@
+#!/usr/bin/env python3
+#
+# VM testing aarch64 library
+#
+# Copyright 2020 Linaro
+#
+# Authors:
+#  Robert Foley <robert.foley@linaro.org>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+import os
+import sys
+import subprocess
+import basevm
+from qemu.accel import kvm_available
+
+# This is the config needed for current version of QEMU.
+# This works for both kvm and tcg.
+CURRENT_CONFIG = {
+    'cpu'          : "max",
+    'machine'      : "virt,gic-version=max",
+}
+
+# The minimum minor version of QEMU we will support with aarch64 VMs is 3.
+# QEMU versions less than 3 have various issues running these VMs.
+QEMU_AARCH64_MIN_VERSION = 3
+
+# The DEFAULT_CONFIG will default to a version of
+# parameters that works for backwards compatibility.
+DEFAULT_CONFIG = {'kvm' : {'cpu'          : "host",
+                           'machine'      : "virt,gic-version=host"},
+                  'tcg' : {'cpu'          : "cortex-a57",
+                           'machine'      : "virt"},
+}
+
+def get_config_defaults(vmcls, default_config):
+    """Fetch the configuration defaults for this VM,
+       taking into consideration the defaults for
+       aarch64 first, followed by the defaults for this VM."""
+    config = default_config
+    config.update(aarch_get_config_defaults(vmcls))
+    return config
+
+def aarch_get_config_defaults(vmcls):
+    # Set the defaults for current version of QEMU.
+    config = CURRENT_CONFIG
+    args, argv = basevm.parse_args(vmcls)
+    qemu_path = basevm.get_qemu_path(vmcls.arch, args.build_path)
+    qemu_version = basevm.get_qemu_version(qemu_path)
+    if qemu_version < QEMU_AARCH64_MIN_VERSION:
+        error = "\nThis major version of QEMU {} is to old for aarch64 VMs.\n"\
+                "The major version must be at least {}.\n"\
+                "To continue with the current build of QEMU, "\
+                "please restart with QEMU_LOCAL=1 .\n"
+        print(error.format(qemu_version, QEMU_AARCH64_MIN_VERSION))
+        exit(1)
+    if qemu_version == QEMU_AARCH64_MIN_VERSION:
+        # We have an older version of QEMU,
+        # set the config values for backwards compatibility.
+        if kvm_available('aarch64'):
+            config.update(DEFAULT_CONFIG['kvm'])
+        else:
+            config.update(DEFAULT_CONFIG['tcg'])
+    return config
+
+def create_flash_images(flash_dir="./"):
+    """Creates the appropriate pflash files
+       for an aarch64 VM."""
+    flash0_path = get_flash_path(flash_dir, "flash0")
+    flash1_path = get_flash_path(flash_dir, "flash1")
+    subprocess.check_call(["dd", "if=/dev/zero", "of={}".format(flash0_path),
+                           "bs=1M", "count=64"])
+    # A reliable way to get the QEMU EFI image is via an installed package.
+    efi_img = "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"
+    if not os.path.exists(efi_img):
+        sys.stderr.write("*** {} is missing\n".format(efi_img))
+        sys.stderr.write("*** please install qemu-efi-aarch64 package\n")
+        exit(3)
+    subprocess.check_call(["dd", "if={}".format(efi_img),
+                           "of={}".format(flash0_path),
+                           "conv=notrunc"])
+    subprocess.check_call(["dd", "if=/dev/zero",
+                           "of={}".format(flash1_path),
+                           "bs=1M", "count=64"])
+
+def get_pflash_args(flash_dir="./"):
+    """Returns a string that can be used to
+       boot qemu using the appropriate pflash files
+       for aarch64."""
+    flash0_path = get_flash_path(flash_dir, "flash0")
+    flash1_path = get_flash_path(flash_dir, "flash1")
+    pflash_args_str = "-drive file={},format=raw,if=pflash "\
+                      "-drive file={},format=raw,if=pflash"
+    pflash_args = pflash_args_str.format(flash0_path, flash1_path)
+    return pflash_args.split(" ")
+
+def get_flash_path(flash_dir, name):
+    return os.path.join(flash_dir, "{}.img".format(name))
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 792e4a3fb2..6ed04a2a4b 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -495,6 +495,14 @@ def get_qemu_path(arch, build_path=None):
         qemu_path = "qemu-system-" + arch
     return qemu_path
 
+def get_qemu_version(qemu_path):
+    """Get the version number from the current QEMU,
+       and return the major number."""
+    output = subprocess.check_output([qemu_path, '--version'])
+    version_line = output.decode("utf-8")
+    version_num = re.split(' |\(', version_line)[3].split('.')[0]
+    return int(version_num)
+
 def parse_config(config, args):
     """ Parse yaml config and populate our config structure.
         The yaml config allows the user to override the
diff --git a/tests/vm/ubuntu.aarch64 b/tests/vm/ubuntu.aarch64
new file mode 100755
index 0000000000..0413971d33
--- /dev/null
+++ b/tests/vm/ubuntu.aarch64
@@ -0,0 +1,117 @@
+#!/usr/bin/env python3
+#
+# Ubuntu aarch64 image
+#
+# Copyright 2020 Linaro
+#
+# Authors:
+#  Robert Foley <robert.foley@linaro.org>
+#  Originally based on ubuntu.i386 Fam Zheng <famz@redhat.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import sys
+import subprocess
+import basevm
+from qemu.accel import kvm_available
+import time
+import aarch64vm
+
+DEFAULT_CONFIG = {
+    'cpu'          : "cortex-a57",
+    'machine'      : "virt,gic-version=3",
+    'install_cmds' : "apt-get update,"\
+                     "apt-get build-dep -y qemu,"\
+                     "apt-get install -y libfdt-dev flex bison",
+    # We increase beyond the default time since during boot
+    # it can take some time (many seconds) to log into the VM
+    # especially using softmmu.
+    'ssh_timeout'  : 60,
+}
+
+class UbuntuAarch64VM(basevm.BaseVM):
+    name = "ubuntu.aarch64"
+    arch = "aarch64"
+    image_name = "ubuntu-18.04-server-cloudimg-arm64.img"
+    image_link = "https://cloud-images.ubuntu.com/releases/18.04/release/" + image_name
+    login_prompt = "ubuntu-aarch64-guest login:"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d);
+        sudo chmod a+r /dev/vdb;
+        tar --checkpoint=.10 -xf /dev/vdb;
+        ./configure {configure_opts};
+        make --output-sync {target} -j{jobs} {verbose};
+    """
+    def boot(self, img, extra_args=None):
+        aarch64vm.create_flash_images(self._tmpdir)
+        default_args = aarch64vm.get_pflash_args(self._tmpdir)
+        if extra_args:
+            extra_args.extend(default_args)
+        else:
+            extra_args = default_args
+        # We always add these performance tweaks
+        # because without them, we boot so slowly that we
+        # can time out finding the boot efi device.
+        if '-smp' not in extra_args and \
+           '-smp' not in self._config['extra_args'] and \
+           '-smp' not in self._args:
+            # Only add if not already there to give caller option to change it.
+            extra_args.extend(["-smp", "8"])
+
+        # We have overridden boot() since aarch64 has additional parameters.
+        # Call down to the base class method.
+        super(UbuntuAarch64VM, self).boot(img, extra_args=extra_args)
+
+    def build_image(self, img):
+        os_img = self._download_with_cache(self.image_link)
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", os_img, img_tmp])
+        subprocess.check_call(["qemu-img", "resize", img_tmp, "+50G"])
+        ci_img = self.gen_cloud_init_iso()
+
+        self.boot(img_tmp, extra_args = ["-cdrom", ci_img])
+        if self._boot_console:
+            self.wait_boot()
+        # First command we issue is fix for slow ssh login.
+        self.wait_ssh(wait_root=True,
+                      cmd="chmod -x /etc/update-motd.d/*")
+        # Wait for cloud init to finish
+        self.wait_ssh(wait_root=True,
+                      cmd="ls /var/lib/cloud/instance/boot-finished")
+        self.ssh_root("touch /etc/cloud/cloud-init.disabled")
+        # Disable auto upgrades.
+        # We want to keep the VM system state stable.
+        self.ssh_root('sed -ie \'s/"1"/"0"/g\' /etc/apt/apt.conf.d/20auto-upgrades')
+        # If the user chooses *not* to do the second phase,
+        # then we will jump right to the graceful shutdown
+        if self._config['install_cmds'] != "":
+            self.ssh_root("sync")
+            # Shutdown and then boot it again.
+            # Allows us to know for sure it is booting (not shutting down)
+            # before we call wait_ssh().
+            self.graceful_shutdown()
+            self.boot(img_tmp)
+            if self._boot_console:
+                self.wait_boot()
+            self.wait_ssh(wait_root=True)
+            self.wait_ssh(wait_root=True, cmd="locale")
+            # The previous update sometimes doesn't survive a reboot, so do it again
+            self.ssh_root("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
+
+            # Issue the install commands.
+            # This can be overriden by the user in the config .yml.
+            install_cmds = self._config['install_cmds'].split(',')
+            for cmd in install_cmds:
+                self.ssh_root(cmd)
+        self.graceful_shutdown()
+        self.wait()
+        os.rename(img_tmp, img)
+        return 0
+
+if __name__ == "__main__":
+    defaults = aarch64vm.get_config_defaults(UbuntuAarch64VM, DEFAULT_CONFIG)
+    sys.exit(basevm.main(UbuntuAarch64VM, defaults))
-- 
2.17.1


