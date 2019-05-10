Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AE2C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C33121479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C33121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41245 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3MP-0000Kh-7q
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:06:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP336-0008NI-Az
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP334-00045u-D1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP334-00044d-4q
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61F75307D914;
	Fri, 10 May 2019 10:46:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8CAA51001E81;
	Fri, 10 May 2019 10:46:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id AA1BD9DAE; Fri, 10 May 2019 12:46:33 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:46:29 +0200
Message-Id: <20190510104633.9428-10-kraxel@redhat.com>
In-Reply-To: <20190510104633.9428-1-kraxel@redhat.com>
References: <20190510104633.9428-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 10 May 2019 10:46:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 09/13] tests/vm: openbsd autoinstall,
 using serial console
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of fetching the prebuilt image from patchew download the install
iso and prepare the image locally.  Install to disk, using the serial
console.  Create qemu user, configure ssh login.  Install packages
needed for qemu builds.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/openbsd | 154 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 141 insertions(+), 13 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 2105c01a267a..2753cfb1139a 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -2,10 +2,11 @@
 #
 # OpenBSD VM image
 #
-# Copyright 2017 Red Hat Inc.
+# Copyright 2017-2019 Red Hat Inc.
 #
 # Authors:
 #  Fam Zheng <famz@redhat.com>
+#  Gerd Hoffmann <kraxel@redhat.com>
 #
 # This code is licensed under the GPL version 2 or later.  See
 # the COPYING file in the top-level directory.
@@ -13,34 +14,161 @@
 
 import os
 import sys
+import socket
 import subprocess
 import basevm
 
 class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
+
+    link = "https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/install65.iso"
+    csum = "38d1f8cadd502f1c27bf05c5abde6cc505dd28f3f34f8a941048ff9a54f9f608"
+    size = "20G"
+    pkgs = [
+        # tools
+        "git",
+        "pkgconf",
+        "bzip2", "xz",
+
+        # gnu tools
+        "bash",
+        "gmake",
+        "gsed",
+        "bison",
+
+        # libs: usb
+        "libusb1",
+
+        # libs: crypto
+        "gnutls",
+
+        # libs: images
+        "jpeg",
+        "png",
+
+	# libs: ui
+        "sdl2",
+        "gtk+3",
+        "libxkbcommon",
+    ]
+
     BUILD_SCRIPT = """
         set -e;
-        rm -rf /var/tmp/qemu-test.*
-        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        rm -rf /home/qemu/qemu-test.*
+        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
+        mkdir src build; cd src;
         tar -xf /dev/rsd1c;
-        ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
-        gmake --output-sync -j{jobs} {verbose};
-        # XXX: "gmake check" seems to always hang or fail
-        #gmake --output-sync -j{jobs} check {verbose};
+        cd ../build
+        ../src/configure --cc=cc --python=python3 {configure_opts};
+        gmake --output-sync -j{jobs} {target} {verbose};
     """
+    poweroff = "halt -p"
 
     def build_image(self, img):
-        cimg = self._download_with_cache("http://download.patchew.org/openbsd-6.1-amd64.img.xz",
-                sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
-        img_tmp_xz = img + ".tmp.xz"
+        self.print_step("Downloading install iso")
+        cimg = self._download_with_cache(self.link, sha256sum=self.csum)
         img_tmp = img + ".tmp"
-        sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        iso = img + ".install.iso"
+
+        self.print_step("Preparing iso and disk image")
+        subprocess.check_call(["cp", "-f", cimg, iso])
+        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
+                               img_tmp, self.size])
+
+        self.print_step("Booting installer")
+        self.boot(img_tmp, extra_args = [
+            "-machine", "graphics=off",
+            "-cdrom", iso
+        ])
+        self.console_init()
+        self.console_wait_send("boot>", "set tty com0\n")
+        self.console_wait_send("boot>", "\n")
+
+        # pre-install configuration
+        self.console_wait_send("(I)nstall",               "i\n")
+        self.console_wait_send("Terminal type",           "xterm\n")
+        self.console_wait_send("System hostname",         "openbsd\n")
+        self.console_wait_send("Which network interface", "vio0\n")
+        self.console_wait_send("IPv4 address",            "dhcp\n")
+        self.console_wait_send("IPv6 address",            "none\n")
+        self.console_wait_send("Which network interface", "done\n")
+        self.console_wait_send("DNS domain name",         "localnet\n")
+        self.console_wait("Password for root account")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait("Password for root account")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait_send("Start sshd(8)",           "yes\n")
+        self.console_wait_send("X Window System",         "\n")
+        self.console_wait_send("xenodm",                  "\n")
+        self.console_wait_send("console to com0",         "\n")
+        self.console_wait_send("Which speed",             "\n")
+
+        self.console_wait("Setup a user")
+        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_wait("Full name")
+        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_wait("Password")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait("Password")
+        self.console_send("%s\n" % self.GUEST_PASS)
+
+        self.console_wait_send("Allow root ssh login",    "yes\n")
+        self.console_wait_send("timezone",                "UTC\n")
+        self.console_wait_send("root disk",               "\n")
+        self.console_wait_send("(W)hole disk",            "\n")
+        self.console_wait_send("(A)uto layout",           "\n")
+        self.console_wait_send("Location of sets",        "cd0\n")
+        self.console_wait_send("Pathname to the sets",    "\n")
+        self.console_wait_send("Set name(s)",             "\n")
+        self.console_wait_send("without verification",    "yes\n")
+
+        self.print_step("Installation started now, this will take a while")
+        self.console_wait_send("Location of sets",        "done\n")
+
+        self.console_wait("successfully completed")
+        self.print_step("Installation finished, rebooting")
+        self.console_wait_send("(R)eboot",                "reboot\n")
+
+        # setup qemu user
+        prompt = "$"
+        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_wait_send(prompt, "exit\n")
+
+        # setup root user
+        prompt = "openbsd#"
+        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_sshd_config(prompt)
+
+        # setup virtio-blk #1 (tarfile)
+        self.console_wait(prompt)
+        self.console_send("echo 'chmod 666 /dev/rsd1c' >> /etc/rc.local\n")
+
+        # enable w+x for /home
+        self.console_wait(prompt)
+        self.console_send("sed -i -e '/home/s/rw,/rw,wxallowed,/' /etc/fstab\n")
+
+        # use http (be proxy cache friendly)
+        self.console_wait(prompt)
+        self.console_send("sed -i -e 's/https/http/' /etc/installurl\n")
+
+        self.print_step("Configuration finished, rebooting")
+        self.console_wait_send(prompt, "reboot\n")
+        self.console_wait("login:")
+        self.wait_ssh()
+
+        self.print_step("Installing packages")
+        self.ssh_root_check("pkg_add %s\n" % " ".join(self.pkgs))
+
+        # shutdown
+        self.ssh_root(self.poweroff)
+        self.wait()
+
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
+        os.remove(iso)
+        self.print_step("All done")
 
 if __name__ == "__main__":
     sys.exit(basevm.main(OpenBSDVM))
-- 
2.18.1


