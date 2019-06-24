Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC60AC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD56212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIZeQAqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD56212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51543 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPhb-0001rA-QN
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41641)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGO-0006jj-9n
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0007gm-Ul
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:44:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGG-0007Vf-HK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id n9so14039576wru.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UpVvHEnh/SP5d5n5fhpbeMvaoSDIsow/FrkdXyrTnwk=;
 b=EIZeQAqt7tBcSB5dclnivOuFWbO0Zile5mqNF5EaaDKiHXWNhg9xxNHv8UA9RwKFvH
 RGeEirFYgLk3LwIAk+Q4VJ3OSHzZtR/ONhVT22t+vuhc+SeL0RlukYpgUD0tjfwpjMpf
 L3iVKFniS6OqhLlBcuGY3NYJgnJecsh1IsERneg3gXNVEM/kzFDMOPy30tC75eOjw9wa
 fcpzIfjadFJWeGwVifuIZtFjE28sP+QAEHMhudy8pwCpcXggDnVVMQ2xr9wZVbGMZalP
 DYuXPIekWWh6+u4GLxnIys+bAlJV3iAYp8hKEmxRo57xWxB3enViwNe1YU1cJtlop+Lk
 wizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UpVvHEnh/SP5d5n5fhpbeMvaoSDIsow/FrkdXyrTnwk=;
 b=haviPSnh8yG+38O2DdjTobrD96GCi+QO+1Dg1iznANGtK1n46Ht5Cw1P5azB4/b9OS
 TvKk4QkeMrRHo8MWdBSkcikQk5qRHHVI4acNsz7FfGHjGkkCCm0ix5VziiGqscYfwZNZ
 kJXSvG0W6zvIh/Px+CAryklanpX4ViNA2vVPJG9E6GqxBmBc2BruoNskfWlS1w+tzzp6
 lJkHNCaBblPKguKSEojoGO/J+duNNxZBql+lgi1f0J/deZUP2DBh+2He/tv2fEdO7d0Z
 f3XbK78eOIxmqMohoMp8h8qKxVX22r9BK6KXUEZODlrj12sdUmpQnTpF3/iSE5TzAM2S
 taJw==
X-Gm-Message-State: APjAAAV7P6/f+yL4o67VsoOloe5i8nsvEzvq9ylRt1QDEYKXnqfyZvl+
 afaQiVPgHhvwd8p3IF9B57y5yg==
X-Google-Smtp-Source: APXvYqymsCt9JE3Z27IUF5o+2JmrFfT1flFJVYxJUlAFvALc1Iw6q///AmATWEZroJ6AJ+YrbSaD2Q==
X-Received: by 2002:adf:9bd3:: with SMTP id e19mr32204476wrc.38.1561383828671; 
 Mon, 24 Jun 2019 06:43:48 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d1sm10270324wru.41.2019.06.24.06.43.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:44 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B1E221FF9D;
 Mon, 24 Jun 2019 14:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:32 +0100
Message-Id: <20190624134337.10532-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 14/19] tests/vm: fedora autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Download the install iso and prepare the image locally.  Install to
disk, using the serial console.  Create qemu user, configure ssh login.
Install packages needed for qemu builds.

Yes, we have docker images for fedora.  But for trouble-shooting it
might be helpful to have a vm too.  When vm builds fail you can use
it to figure whenever the vm setup or the guest os is the problem.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190617043858.8290-11-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index a61c236b8e..809b80e2e5 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -2,7 +2,7 @@
 
 .PHONY: vm-build-all vm-clean-all
 
-IMAGES := ubuntu.i386 freebsd netbsd openbsd centos
+IMAGES := ubuntu.i386 freebsd netbsd openbsd centos fedora
 IMAGES_DIR := $(HOME)/.cache/qemu-vm/images
 IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 
@@ -16,6 +16,7 @@ vm-test:
 	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
 	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
 	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
+	@echo "  vm-build-fedora                 - Build QEMU in Fedora VM"
 	@echo ""
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 592a344773..3d717da498 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -206,7 +206,7 @@ class BaseVM(object):
             # log console line
             sys.stderr.write("con recv: %s\n" % line)
 
-    def console_wait(self, expect):
+    def console_wait(self, expect, expectalt = None):
         vm = self._guest
         output = ""
         while True:
@@ -215,6 +215,8 @@ class BaseVM(object):
             except socket.timeout:
                 sys.stderr.write("console: *** read timeout ***\n")
                 sys.stderr.write("console: waiting for: '%s'\n" % expect)
+                if not expectalt is None:
+                    sys.stderr.write("console: waiting for: '%s' (alt)\n" % expectalt)
                 sys.stderr.write("console: line buffer:\n")
                 sys.stderr.write("\n")
                 self.console_log(output.rstrip())
@@ -223,6 +225,8 @@ class BaseVM(object):
             output += chars.decode("latin1")
             if expect in output:
                 break
+            if not expectalt is None and expectalt in output:
+                break
             if "\r" in output or "\n" in output:
                 lines = re.split("[\r\n]", output)
                 output = lines.pop()
@@ -230,6 +234,9 @@ class BaseVM(object):
                     self.console_log("\n".join(lines))
         if self.debug:
             self.console_log(output)
+        if not expectalt is None and expectalt in output:
+            return False
+        return True
 
     def console_send(self, command):
         vm = self._guest
diff --git a/tests/vm/fedora b/tests/vm/fedora
new file mode 100755
index 0000000000..e8fa5bf0d2
--- /dev/null
+++ b/tests/vm/fedora
@@ -0,0 +1,189 @@
+#!/usr/bin/env python
+#
+# Fedora VM image
+#
+# Copyright 2019 Red Hat Inc.
+#
+# Authors:
+#  Gerd Hoffmann <kraxel@redhat.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import re
+import sys
+import time
+import socket
+import subprocess
+import basevm
+
+class FedoraVM(basevm.BaseVM):
+    name = "fedora"
+    arch = "x86_64"
+
+    base = "http://dl.fedoraproject.org/pub/fedora/linux/releases/30/"
+    link = base + "Server/x86_64/iso/Fedora-Server-netinst-x86_64-30-1.2.iso"
+    repo = base + "Server/x86_64/os/"
+    full = base + "Everything/x86_64/os/"
+    csum = "5e4eac4566d8c572bfb3bcf54b7d6c82006ec3c6c882a2c9235c6d3494d7b100"
+    size = "20G"
+    pkgs = [
+        # tools
+        'git-core',
+        'flex', 'bison',
+        'gcc', 'binutils', 'make',
+
+        # perl
+        'perl-Test-Harness',
+
+        # libs: usb
+        '"pkgconfig(libusb-1.0)"',
+        '"pkgconfig(libusbredirparser-0.5)"',
+
+        # libs: crypto
+        '"pkgconfig(gnutls)"',
+
+        # libs: ui
+        '"pkgconfig(sdl2)"',
+        '"pkgconfig(gtk+-3.0)"',
+        '"pkgconfig(ncursesw)"',
+
+        # libs: audio
+        '"pkgconfig(libpulse)"',
+        '"pkgconfig(alsa)"',
+    ]
+
+    BUILD_SCRIPT = """
+        set -e;
+        rm -rf /home/qemu/qemu-test.*
+        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
+        mkdir src build; cd src;
+        tar -xf /dev/vdb;
+        cd ../build
+        ../src/configure --python=python3 {configure_opts};
+        gmake --output-sync -j{jobs} {target} {verbose};
+    """
+
+    def build_image(self, img):
+        self.print_step("Downloading install iso")
+        cimg = self._download_with_cache(self.link, sha256sum=self.csum)
+        img_tmp = img + ".tmp"
+        iso = img + ".install.iso"
+
+        self.print_step("Preparing iso and disk image")
+        subprocess.check_call(["cp", "-f", cimg, iso])
+        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
+                               img_tmp, self.size])
+
+        self.print_step("Booting installer")
+        self.boot(img_tmp, extra_args = [
+            "-bios", "pc-bios/bios-256k.bin",
+            "-machine", "graphics=off",
+            "-cdrom", iso
+        ])
+        self.console_init(300)
+        self.console_wait("installation process.")
+        time.sleep(0.3)
+        self.console_send("\t")
+        time.sleep(0.3)
+        self.console_send(" console=ttyS0")
+        proxy = os.environ.get("http_proxy")
+        if not proxy is None:
+            self.console_send(" proxy=%s" % proxy)
+            self.console_send(" inst.proxy=%s" % proxy)
+        self.console_send(" inst.repo=%s" % self.repo)
+        self.console_send("\n")
+
+        self.console_wait_send("2) Use text mode",         "2\n")
+
+        self.console_wait_send("5) [!] Installation Dest", "5\n")
+        self.console_wait_send("1) [x]",                   "c\n")
+        self.console_wait_send("2) [ ] Use All Space",     "2\n")
+        self.console_wait_send("2) [x] Use All Space",     "c\n")
+        self.console_wait_send("1) [ ] Standard Part",     "1\n")
+        self.console_wait_send("1) [x] Standard Part",     "c\n")
+
+        self.console_wait_send("7) [!] Root password",     "7\n")
+        self.console_wait("Password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait("Password (confirm):")
+        self.console_send("%s\n" % self.ROOT_PASS)
+
+        self.console_wait_send("8) [ ] User creation",     "8\n")
+        self.console_wait_send("1) [ ] Create user",       "1\n")
+        self.console_wait_send("3) User name",             "3\n")
+        self.console_wait_send("ENTER:", "%s\n" % self.GUEST_USER)
+        self.console_wait_send("4) [ ] Use password",      "4\n")
+        self.console_wait_send("5) Password",              "5\n")
+        self.console_wait("Password:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait("Password (confirm):")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait_send("7) Groups",                "c\n")
+
+        while True:
+            good = self.console_wait("3) [x] Installation",
+                                     "3) [!] Installation")
+            self.console_send("r\n")
+            if good:
+                break
+            time.sleep(10)
+
+        while True:
+            good = self.console_wait("4) [x] Software",
+                                     "4) [!] Software")
+            self.console_send("r\n")
+            if good:
+                break
+            time.sleep(10)
+            self.console_send("r\n" % self.GUEST_PASS)
+
+        self.console_wait_send("'b' to begin install",     "b\n")
+
+        self.print_step("Installation started now, this will take a while")
+
+        self.console_wait_send("Installation complete",    "\n")
+        self.print_step("Installation finished, rebooting")
+
+        # setup qemu user
+        prompt = " ~]$"
+        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_wait_send(prompt, "exit\n")
+
+        # setup root user
+        prompt = " ~]#"
+        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_sshd_config(prompt)
+
+        # setup virtio-blk #1 (tarfile)
+        self.console_wait(prompt)
+        self.console_send("echo 'KERNEL==\"vdb\" MODE=\"666\"' >> %s\n" %
+                          "/etc/udev/rules.d/99-qemu.rules")
+
+        self.print_step("Configuration finished, rebooting")
+        self.console_wait_send(prompt, "reboot\n")
+        self.console_wait("login:")
+        self.wait_ssh()
+
+        self.print_step("Installing packages")
+        self.ssh_root_check("rm -vf /etc/yum.repos.d/fedora*.repo\n")
+        self.ssh_root_check("echo '[fedora]' >> /etc/yum.repos.d/qemu.repo\n")
+        self.ssh_root_check("echo 'baseurl=%s' >> /etc/yum.repos.d/qemu.repo\n" % self.full)
+        self.ssh_root_check("echo 'gpgcheck=0' >> /etc/yum.repos.d/qemu.repo\n")
+        self.ssh_root_check("dnf install -y %s\n" % " ".join(self.pkgs))
+
+        # shutdown
+        self.ssh_root(self.poweroff)
+        self.console_wait("sleep state S5")
+        self.wait()
+
+        if os.path.exists(img):
+            os.remove(img)
+        os.rename(img_tmp, img)
+        os.remove(iso)
+        self.print_step("All done")
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(FedoraVM))
-- 
2.20.1


