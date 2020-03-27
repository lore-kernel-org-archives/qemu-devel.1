Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77CDC2D0EE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EF52072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9I6ODyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EF52072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtV0-0003V5-NX
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtTz-0001kg-MS
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtTy-0000gk-Gw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtTy-0000fp-AU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id m11so6663353wrx.10
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BVjll0Btf0ZgFKbd+CxXv9O+AQAJq5w3JoNQuRDkfgk=;
 b=Z9I6ODyFcuBBChjXasaT5mQtLEPar3QkRaY4PedHhvyIVj6ezyCUsX3oxY8Z2dpeGj
 3QLWECtZE4CTNhUSJUBqtsxM8R/G12+RSwRL9u8EewsucON4rwDkL4PRLD1wUOQSFJwd
 0b43TpXF6dFMfs7D+gaR2LsfD8r6EV3IYLJCuxFVh97sX1AGTj33np3hAuusRKhgFPfP
 Wy8vpWf3HfxLvzjgVchD/tXf78NHRDlklhKUYwV1WoMCvZ2CUf9BQN4ozQm2Ui8engNS
 dfkiBU8Mh1UT0gUUQibi+qRylLNbhLdEbmU1PPgULRX7NRD2Fo27GtU5nGkw002K8UAh
 0ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BVjll0Btf0ZgFKbd+CxXv9O+AQAJq5w3JoNQuRDkfgk=;
 b=Md6jZnD/QA3IGVcRRVovzRdlKcY8d8HxrFE2ArErpCh7Owzl8AJuPvj/BfQkGh9gqT
 mldnYSCAa3tnR/2rPdKwkanOCfFKKLAFxQOPhfJvD+UOaJc8GsrK0facKic7DsQHLLeF
 frbEsoFwVZSkEm9MPVakk1I9Oxx41/yt6teWzFEUUMT/IZvqLv2RaBQWNB7FKnFSSRWB
 O3VVNtjJPuwhDdKZJ51nLdNYchQWLmPbyDkROQgoQW8iaZjt7JPPniyA5TYiducWsAT+
 NO7EHy81E9/IWfBjDMHUg9pvWOdaIWNHX0vy9EwHxInd6rJdv7xtPMEJ9A35NEgnDU4T
 648Q==
X-Gm-Message-State: ANhLgQ3NMjeLnoaInf5StfnO3PkjKZTvH8H4ERTT4Yn0Kfhr2XV2gytD
 GOHrVaLkxDipe6vI/piYLF9G+Q==
X-Google-Smtp-Source: ADFU+vupHbLD/BOz056AJgq3ARrJWWNCY4FwvhkacMSFbt+fGPpJyNVpclMlX/z5xJ/r+izUGxhrjQ==
X-Received: by 2002:adf:8182:: with SMTP id 2mr646042wra.37.1585332805271;
 Fri, 27 Mar 2020 11:13:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n124sm8489975wma.11.2020.03.27.11.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8DA981FF8F;
 Fri, 27 Mar 2020 18:13:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 03/12] tests/vm: move vga setup
Date: Fri, 27 Mar 2020 18:13:11 +0000
Message-Id: <20200327181320.23329-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Move '-device VGA' from basevm.py to the guests, so they have
the chance to opt out and run without display device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200310083218.26355-3-kraxel@redhat.com>
Message-Id: <20200323161514.23952-3-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index c53fd354d95..cffe7c4600e 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -179,7 +179,6 @@ class BaseVM(object):
 
     def boot(self, img, extra_args=[]):
         args = self._args + [
-            "-device", "VGA",
             "-drive", "file=%s,if=none,id=drive0,cache=writeback" % img,
             "-device", "virtio-blk,drive=drive0,bootindex=0"]
         args += self._data_args + extra_args
diff --git a/tests/vm/fedora b/tests/vm/fedora
index 4843b4175e0..bd9c6cf295c 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -82,6 +82,7 @@ class FedoraVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init(300)
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 86770878b67..58166766d91 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -92,6 +92,7 @@ class FreeBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 55590f46015..f3257bc245a 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -86,6 +86,7 @@ class NetBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index ab6abbedab5..0b705f49452 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -82,6 +82,7 @@ class OpenBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 3266038fbde..15707753353 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -36,7 +36,10 @@ class UbuntuX86VM(basevm.BaseVM):
         img_tmp = img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
         self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args = ["-cdrom", self.gen_cloud_init_iso()])
+        self.boot(img_tmp, extra_args = [
+            "-device", "VGA",
+            "-cdrom", self.gen_cloud_init_iso()
+        ])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
         self.ssh_root_check("apt-get update")
-- 
2.20.1


