Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ECCC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45AA20709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aW2nE3Xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45AA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2I4-0008R9-Vc
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iv2G5-00044c-GC
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iv2G3-000378-Gh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:37 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:44763)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iv2G3-00036Y-8q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:35 -0500
Received: by mail-pf1-x42a.google.com with SMTP id 62so1385028pfu.11
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=caK2mLT/TcZir8e4gOeKsOqEnAOnx33niuYDtDOksDI=;
 b=aW2nE3Xc3Q3q9wkRhAj4PfEuVaxvGFPnMjrl7BdXQTyOVjWGKe6F9j+S5XInmko+GA
 hAl4t1828P9699ufEK7iGIX/2ki4VJPTQ3bBlL9NutgkhBKwooNHlCsTYt7GN/wD/HpK
 GshPVroPqyk7K4FN6Z4P3wQUTigPnX5jlYjcpmMHy9G6KAMGRI8V5gf4p1WqK5AG/DjQ
 EwhJCnNEIj8hUCoeGvKlAY/uREth1GWm6Yse4HMo5KsuzeqnBxhhDhuitDjb2oAOlvHL
 5OMDrtM547W4BVxNhUeUH0hzTnhQ4XS2r4XgkaUZihI80hMbU4bkypOP2Lr/zbIrWdxN
 Q+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=caK2mLT/TcZir8e4gOeKsOqEnAOnx33niuYDtDOksDI=;
 b=D7g03+KxNNiHkwPKqhSECTqTIO19YaJFsoeljtIpEMG21RY2Dz4Ell4nxGu8HLg6o5
 ya1nAir9Wy2p6p2UW9oAciRJfJ+z2IlqTLNSnVQCiGPwkhq30tpzt1SJvVLyB9c+EPzW
 Y7tJzhRf4Hh4KY94JnRIJEKx4dEOU32WYpeBpN4i3copTn/aBJ80c9R7UDIW9a1yHbiA
 MbIdPW9ukk3Y0w5Gvtt36/dCptcxe4a4POuua1zmxhxAYz+zxpTYeXR20Q/016Ag46+g
 hjUlO536LiIIugj8VQYS+DhGnd2VLRKuMVzCMk9+WvQnidGNt4+fbiTdptO7Gqu1WSgF
 +5lw==
X-Gm-Message-State: APjAAAWgNE/qKIk3RmfIrYAm6m984qpuIuTwQHEH9vkkAgYCbYbrA3D7
 HsE26XvM0AigXSUhJEz5XFbs9lQpDao=
X-Google-Smtp-Source: APXvYqyz1Pom4Eb2bwkMvAF7qYQelfvNrq8sf5W4IkbW/kgj6kmWrtsZt/SSq9rBMIY+/pNDl0JgRg==
X-Received: by 2002:a63:1756:: with SMTP id 22mr5175326pgx.109.1579884993843; 
 Fri, 24 Jan 2020 08:56:33 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id l10sm6969953pjy.5.2020.01.24.08.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:56:33 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] tests/vm: Added a new script for ubuntu.aarch64.
Date: Fri, 24 Jan 2020 11:53:34 -0500
Message-Id: <20200124165335.422-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124165335.422-1-robert.foley@linaro.org>
References: <20200124165335.422-1-robert.foley@linaro.org>
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ubuntu.aarch64 provides a script to create an Ubuntu 18.04 VM.
Another new file is also added aarch64vm.py, which is a module with
common methods used by aarch64 VMs, such as how to create the
flash images.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/Makefile.include |   7 +-
 tests/vm/aarch64vm.py     |  41 +++++++++++
 tests/vm/ubuntu.aarch64   | 144 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 2 deletions(-)
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100755 tests/vm/ubuntu.aarch64

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 9e7c46a473..966b417ba7 100644
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
@@ -35,6 +36,8 @@ vm-help vm-test:
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
+	@echo "    QEMU_CONFIG=/path/conf.yml    - Change path to VM configuration .yml file."
+	@echo "                                    See config_example.yml for file format details."
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
@@ -80,7 +83,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
 
 vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
-		$(SRC_PATH)/tests/vm/$* \
+		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		--image "$<" \
 		--interactive \
diff --git a/tests/vm/aarch64vm.py b/tests/vm/aarch64vm.py
new file mode 100644
index 0000000000..43f841571f
--- /dev/null
+++ b/tests/vm/aarch64vm.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python
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
+
+
+def create_flash_images():
+    """Creates the appropriate pflash files
+       for an aarch64 VM."""
+    subprocess.check_call(["dd", "if=/dev/zero", "of=flash0.img",
+                           "bs=1M", "count=64"])
+    # A reliable way to get the QEMU EFI image is via an installed package.
+    efi_img = "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"
+    if not os.path.exists(efi_img):
+        sys.stderr.write("*** {} is missing\n".format(efi_img))
+        sys.stderr.write("*** please install qemu-efi-aarch64 package\n")
+        exit(3)
+    subprocess.check_call(["dd", "if={}".format(efi_img),
+                           "of=flash0.img", "conv=notrunc"])
+    subprocess.check_call(["dd", "if=/dev/zero",
+                           "of=flash1.img", "bs=1M", "count=64"])
+
+def get_pflash_args():
+    """Returns a string that can be used to
+       boot qemu using the appropriate pflash files
+       for aarch64."""
+    pflash_args = "-drive file=flash0.img,format=raw,if=pflash "\
+                  "-drive file=flash1.img,format=raw,if=pflash"
+    return pflash_args.split(" ")
diff --git a/tests/vm/ubuntu.aarch64 b/tests/vm/ubuntu.aarch64
new file mode 100755
index 0000000000..941f7f5166
--- /dev/null
+++ b/tests/vm/ubuntu.aarch64
@@ -0,0 +1,144 @@
+#!/usr/bin/env python
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
+import time
+import aarch64vm
+
+DEFAULT_CONFIG = {
+    'cpu'          : "max",
+    'machine'      : "virt,gic-version=max",
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
+    login_prompt = "ubuntu-guest login:"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d);
+        sudo chmod a+r /dev/vdb;
+        tar --checkpoint=.10 -xf /dev/vdb;
+        ./configure {configure_opts};
+        make --output-sync {target} -j{jobs} {verbose};
+    """
+    def _gen_cloud_init_iso(self):
+        cidir = self._tmpdir
+        mdata = open(os.path.join(cidir, "meta-data"), "w")
+        mdata.writelines(["instance-id: ubuntu-vm-0\n",
+                          "local-hostname: ubuntu-guest\n"])
+        mdata.close()
+        udata = open(os.path.join(cidir, "user-data"), "w")
+        print("guest user:pw {}:{}".format(self.GUEST_USER, self.GUEST_PASS))
+        udata.writelines(["#cloud-config\n",
+                          "chpasswd:\n",
+                          "  list: |\n",
+                          "    root:%s\n" % self.ROOT_PASS,
+                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_PASS),
+                          "  expire: False\n",
+                          "users:\n",
+                          "  - name: %s\n" % self.GUEST_USER,
+                          "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
+                          "    ssh-authorized-keys:\n",
+                          "    - %s\n" % self.ssh_pub_key,
+                          "  - name: root\n",
+                          "    ssh-authorized-keys:\n",
+                          "    - %s\n" % self.ssh_pub_key,
+                          "locale: en_US.UTF-8\n"])
+        proxy = os.environ.get("http_proxy")
+        if not proxy is None:
+            udata.writelines(["apt:\n",
+                              "  proxy: %s" % proxy])
+        udata.close()
+        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
+                               "-volid", "cidata", "-joliet", "-rock",
+                               "user-data", "meta-data"],
+                               cwd=cidir,
+                               stdin=self._devnull, stdout=self._stdout,
+                               stderr=self._stdout)
+
+        return os.path.join(cidir, "cloud-init.iso")
+
+    def boot(self, img, extra_args=None):
+        aarch64vm.create_flash_images()
+        default_args = aarch64vm.get_pflash_args()
+        if extra_args:
+            extra_args.extend(default_args)
+        else:
+            extra_args = default_args
+        # We always add these performance tweaks
+        # because without them, we boot so slowly that we
+        # can time out finding the boot efi device.
+        if os.geteuid() != 0:
+            extra_args.extend(["-accel", "tcg,thread=multi"])
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
+        ci_img = self._gen_cloud_init_iso()
+
+        self.boot(img_tmp, extra_args = ["-cdrom", ci_img])
+        self.wait_ssh(wait_root=True)
+        # Fix for slow ssh login.
+        self.ssh_root("chmod -x /etc/update-motd.d/*")
+        self.ssh_root("touch /etc/cloud/cloud-init.disabled")
+        # Disable auto upgrades.
+        # We want to keep the VM system state stable.
+        self.ssh_root('sed -ie \'s/"1"/"0"/g\' /etc/apt/apt.conf.d/20auto-upgrades')
+
+        # If the user chooses *not* to do the second phase,
+        # then we will jump right to the graceful shutdown
+        if self._config['install_cmds'] != "":
+            # Don't check the status in case the guest hang up too quickly
+            self.ssh_root("sync && reboot")
+
+            self.wait_ssh(wait_root=True)
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
+    sys.exit(basevm.main(UbuntuAarch64VM, DEFAULT_CONFIG))
-- 
2.17.1


