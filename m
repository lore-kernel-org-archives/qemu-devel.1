Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C23C17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D33D2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9QRl+Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D33D2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXZa-0008Qg-9x
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXV5-0003Os-HJ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXV3-00032v-LJ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUXV3-00032K-Dh
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:33 -0500
Received: by mail-wr1-x42b.google.com with SMTP id i10so18835635wrs.7
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 06:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DCQEvHTOo7eYVi9zrwdE9leN9C0uu42dACCPL6An92U=;
 b=d9QRl+BnlGYgCGLYKC30XWUD9/aIzV7s7WAImJSrMUNmBIDlqCo+opwTQtSABcdEzd
 LGHWWUB6dsNWQb5rxDX0hdTzjK9xmTZdJOJHxm13UkDKuIjqFH8+V7FowVifETTQHXd2
 4rKBjfYO1fHKn7lOwGebUecEAIR/gFlxlrbSogPY1gdXmQClYVAln3xDNmPADAqwp8Lk
 9T6X+jE4GoeLXdqP1gMhpwz2HtKO8+KI1K1jiSoepiUNw2sNJRADfagp04Zp39cg5L+0
 cv4+o4vf9s8u+3NAEP/Mkt42s48IxrUXzS7eMQ0lWgO1C9PQP1UQWNrwcWpsa3tjud7M
 mvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DCQEvHTOo7eYVi9zrwdE9leN9C0uu42dACCPL6An92U=;
 b=q1bPIZ+3wpYNC8UhdvWFhxpVLek/S2IPv0l/fsh9imwsVyAcnAeThrK8j4gzD7MKkU
 IuNo06/FrNwkRx4Xh3qMkTaKiOeXGSU2AwDiEd9yKGXsD7HYGVOW2dDNqsiQw9IU6Hrt
 C5DIU5BCgdmv4uTKMKGtAOAgKJlbPoH5jdhj4eVR4HeyXYLIOym1SNuxuRIIOxnzy+d5
 /88sII83DUY46MlbIsr7Ihx67+LNtlDQmr4TQP2zgeW6XvYw4LNCbI4mtI2qWnf5dx41
 97MVi/4UV822ORQWVlFurTZguUW4KTYdHot0gWl62KYizXVxVO4VFJttxkAg60y+Nlg3
 3j/w==
X-Gm-Message-State: APjAAAVxA5kxOwlnE3SnJBcyryxQ0bhSHZ6+JQGpNV20oFbeXJ91FWFT
 PKrtmcuatz+5keFb1i/lWmkypg==
X-Google-Smtp-Source: APXvYqxUJXIuNWaffgL+PxH8FraYetgRrfjzwIqqRgV0GIqC+rGxc2I5addG7Sz/go3jOKIRxXe7SA==
X-Received: by 2002:a5d:5391:: with SMTP id d17mr28113278wrv.382.1573570232116; 
 Tue, 12 Nov 2019 06:50:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x9sm19479286wru.32.2019.11.12.06.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 06:50:29 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 220B11FF8C;
 Tue, 12 Nov 2019 14:50:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 1/8] tests/vm: netbsd autoinstall, using serial console
Date: Tue, 12 Nov 2019 14:50:21 +0000
Message-Id: <20191112145028.26386-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112145028.26386-1-alex.bennee@linaro.org>
References: <20191112145028.26386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kamil Rytarowski <n54@gmx.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Instead of fetching the prebuilt image from patchew download the install
iso and prepare the image locally.  Install to disk, using the serial
console.  Create qemu user, configure ssh login.  Install packages
needed for qemu builds.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Kamil Rytarowski <n54@gmx.com>
Tested-by: Thomas Huth <thuth@redhat.com>
[ehabkost: rebased to latest qemu.git master]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20191031085306.28888-2-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 18aa56ae826..445c34dc495 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -2,10 +2,11 @@
 #
 # NetBSD VM image
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
@@ -13,20 +14,53 @@
 
 import os
 import sys
+import time
 import subprocess
 import basevm
 
 class NetBSDVM(basevm.BaseVM):
     name = "netbsd"
     arch = "x86_64"
+
+    link = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetBSD-8.0-amd64.iso"
+    size = "20G"
+    pkgs = [
+        # tools
+        "git-base",
+        "pkgconf",
+        "xz",
+        "python37",
+
+        # gnu tools
+        "bash",
+        "gmake",
+        "gsed",
+        "flex", "bison",
+
+        # libs: crypto
+        "gnutls",
+
+        # libs: images
+        "jpeg",
+        "png",
+
+	# libs: ui
+        "SDL2",
+        "gtk3+",
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
         tar -xf /dev/rld1a;
-        ./configure --python=python2.7 {configure_opts};
+        cd ../build
+        ../src/configure --python=python3.7 --disable-opengl {configure_opts};
         gmake --output-sync -j{jobs} {target} {verbose};
     """
+    poweroff = "/sbin/poweroff"
 
     # Workaround for NetBSD + IPv6 + slirp issues.
     # NetBSD seems to ignore the ICMPv6 Destination Unreachable
@@ -36,14 +70,147 @@ class NetBSDVM(basevm.BaseVM):
     ipv6 = False
 
     def build_image(self, img):
-        cimg = self._download_with_cache("http://download.patchew.org/netbsd-7.1-amd64.img.xz",
-                                         sha256sum='b633d565b0eac3d02015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
-        img_tmp_xz = img + ".tmp.xz"
+        cimg = self._download_with_cache(self.link)
         img_tmp = img + ".tmp"
-        sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
+        iso = img + ".install.iso"
+
+        self.print_step("Preparing iso and disk image")
+        subprocess.check_call(["ln", "-f", cimg, iso])
+        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
+                               img_tmp, self.size])
+
+        self.print_step("Booting installer")
+        self.boot(img_tmp, extra_args = [
+            "-bios", "pc-bios/bios-256k.bin",
+            "-machine", "graphics=off",
+            "-cdrom", iso
+        ])
+        self.console_init()
+        self.console_wait("Primary Bootstrap")
+
+        # serial console boot menu output doesn't work for some
+        # reason, so we have to fly blind ...
+        for char in list("5consdev com0\n"):
+            time.sleep(0.2)
+            self.console_send(char)
+            self.console_wait("")
+        self.console_wait_send("> ", "boot\n")
+
+        self.console_wait_send("Terminal type",            "xterm\n")
+        self.console_wait_send("a: Installation messages", "a\n")
+        self.console_wait_send("b: US-English",            "b\n")
+        self.console_wait_send("a: Install NetBSD",        "a\n")
+        self.console_wait("Shall we continue?")
+        self.console_wait_send("b: Yes",                   "b\n")
+
+        self.console_wait_send("a: ld0",                   "a\n")
+        self.console_wait_send("a: This is the correct",   "a\n")
+        self.console_wait_send("b: Use the entire disk",   "b\n")
+        self.console_wait("NetBSD bootcode")
+        self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait_send("b: Use existing part",     "b\n")
+        self.console_wait_send("x: Partition sizes ok",    "x\n")
+        self.console_wait_send("for your NetBSD disk",     "\n")
+        self.console_wait("Shall we continue?")
+        self.console_wait_send("b: Yes",                   "b\n")
+
+        self.console_wait_send("b: Use serial port com0",  "b\n")
+        self.console_wait_send("f: Set serial baud rate",  "f\n")
+        self.console_wait_send("a: 9600",                  "a\n")
+        self.console_wait_send("x: Exit",                  "x\n")
+
+        self.console_wait_send("a: Full installation",     "a\n")
+        self.console_wait_send("a: CD-ROM",                "a\n")
+
+        self.print_step("Installation started now, this will take a while")
+        self.console_wait_send("Hit enter to continue",    "\n")
+
+        self.console_wait_send("d: Change root password",  "d\n")
+        self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait("New password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait("New password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait("Retype new password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+
+        self.console_wait_send("o: Add a user",            "o\n")
+        self.console_wait("username")
+        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_wait("to group wheel")
+        self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait_send("a: /bin/sh",               "a\n")
+        self.console_wait("New password:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait("New password:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait("Retype new password:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+
+        self.console_wait_send("a: Configure network",     "a\n")
+        self.console_wait_send("a: vioif0",                "a\n")
+        self.console_wait_send("Network media type",       "\n")
+        self.console_wait("autoconfiguration")
+        self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait_send("DNS domain",               "localnet\n")
+        self.console_wait("Are they OK?")
+        self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait("installed in /etc")
+        self.console_wait_send("a: Yes",                   "a\n")
+
+        self.console_wait_send("e: Enable install",        "e\n")
+        proxy = os.environ.get("http_proxy")
+        if not proxy is None:
+            self.console_wait_send("f: Proxy",             "f\n")
+            self.console_wait("Proxy")
+            self.console_send("%s\n" % proxy)
+        self.console_wait_send("x: Install pkgin",         "x\n")
+        self.console_init(1200)
+        self.console_wait_send("Hit enter to continue", "\n")
+        self.console_init()
+
+        self.console_wait_send("g: Enable sshd",           "g\n")
+        self.console_wait_send("x: Finished conf",         "x\n")
+        self.console_wait_send("Hit enter to continue",    "\n")
+
+        self.print_step("Installation finished, rebooting")
+        self.console_wait_send("d: Reboot the computer",   "d\n")
+
+        # setup qemu user
+        prompt = "localhost$"
+        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_wait_send(prompt, "exit\n")
+
+        # setup root user
+        prompt = "localhost#"
+        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_sshd_config(prompt)
+
+        # setup virtio-blk #1 (tarfile)
+        self.console_wait(prompt)
+        self.console_send("echo 'chmod 666 /dev/rld1a' >> /etc/rc.local\n")
+
+        # turn off mprotect (conflicts with tcg)
+        self.console_wait(prompt)
+        self.console_send("echo security.pax.mprotect.enabled=0 >> /etc/sysctl.conf\n")
+
+        self.print_step("Configuration finished, rebooting")
+        self.console_wait_send(prompt, "reboot\n")
+        self.console_wait("login:")
+        self.wait_ssh()
+
+        self.print_step("Installing packages")
+        self.ssh_root_check("pkgin update\n")
+        self.ssh_root_check("pkgin -y install %s\n" % " ".join(self.pkgs))
+
+        # shutdown
+        self.ssh_root(self.poweroff)
+        self.console_wait("entering state S5")
+        self.wait()
+
         os.rename(img_tmp, img)
+        os.remove(iso)
+        self.print_step("All done")
 
 if __name__ == "__main__":
     sys.exit(basevm.main(NetBSDVM))
-- 
2.20.1


