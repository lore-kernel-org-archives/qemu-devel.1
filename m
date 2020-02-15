Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8922CC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D762082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9tCOiwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D762082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j333C-0007sW-Ig
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331F-000451-Am
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331D-0000v9-6B
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:25 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331C-0000uZ-Vz
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:23 -0500
Received: by mail-ed1-x541.google.com with SMTP id t7so3804339edr.4
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 11:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4cYBXqS3UQh4dHtUacPsPiQgmHWGNLbdxXAjBX0BgL8=;
 b=N9tCOiwMK3N4rK+gvIo0fNKGmHKIFkEfcMHRBGHiDwW5oSMGzPFWI8X12VHuSekKHz
 n1vTWJXCLCyDdcmkM3ybB68NH5+avqQIsDfnyCNE1CK1yVUxn/X0cduOp6/zZSErHSgs
 b7q4dp71l//uBu6/hpN/J+pubYfRXHEhOnMwjD0gTYCU3Mo10cnVDLG9GOTAQ2tkdiyl
 fu16I0kQljO5E46dFts4YnjWO/b5llg73risr1R0D1nQzK1QHasos+U8UM2qFQlE7Aha
 x3c7zSh6c4EtKYFzav8VmmzJs5TzkMMg2Y1lgytTGsCeqmJB8zKCPLdK6AjKbV3gRm7A
 Zn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4cYBXqS3UQh4dHtUacPsPiQgmHWGNLbdxXAjBX0BgL8=;
 b=U4fL0qR87hGyBVXbdmqGn+FerVJpk94r5AifTD6W2JdLLtwdRGd+vvUm4Fe60LgOCB
 WuK/F4iTknNM1Vn3E7L1Max2+SS20ljypQZpWP7QQ3sfdK/cRFiSXZxXmzmXX7YOZ49c
 X6vfZ8JV9yujFzXUOwKH7dUWhkrdXEuey2I1RiYvKKWBkl2aHHuevKbQLtiMNIuU+eDs
 mZOaDXKTr5vAU0YnivvZ+veAaNAVAO9gL48B42FsBjfykcsDLEAYlpB3Y61PBRdUOkRJ
 1CprPKd9keqV3/A0iSrrPdDhZmQsLa6KyP5cE77QOS2hVkCp2Ah3BQUO0DFW5NNyYoTD
 DLkw==
X-Gm-Message-State: APjAAAVeHKh0i+Y6TEYMCb3xCnZAB502Bg2OvlHBInOCY/LsD5itRQem
 YI7oUwsYPVgmIPvanZZCpfNqzB0qdWA=
X-Google-Smtp-Source: APXvYqyyrmqKPNWgX4yoMSzCPAtyp2XDW7Cjpqo40FghUIwatzVz3qArAKNXvLylfA/dd+3QF0RkhA==
X-Received: by 2002:a50:a864:: with SMTP id j91mr8176296edc.318.1581794541891; 
 Sat, 15 Feb 2020 11:22:21 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a24sm657128ejt.40.2020.02.15.11.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:22:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] tests/acceptance/boot_linux_console: Add raspi version=2
 parameter
Date: Sat, 15 Feb 2020 20:22:10 +0100
Message-Id: <20200215192216.4899-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215192216.4899-1-f4bug@amsat.org>
References: <20200215192216.4899-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to tests different Raspberry Pi machines. Refactor to
take the board version as argument.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 8cfc758d42..a1b6e70d3f 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -347,26 +347,34 @@ def test_arm_emcraft_sf2(self):
         self.vm.launch()
         self.wait_for_console_pattern('init started: BusyBox')
 
-    def do_test_arm_raspi2(self, uart_model):
+    def do_test_arm_raspi(self, version, uart_model):
         """
         The kernel can be rebuilt using the kernel source referenced
         and following the instructions on the on:
         https://www.raspberrypi.org/documentation/linux/kernel/building.md
         """
         serial_kernel_cmdline = {
-            'pl011': 'earlycon=pl011,0x3f201000 console=ttyAMA0',
+            'pl011': {
+                2: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
+            },
+        }
+        kernel = {
+            2: '/boot/kernel7.img',
+        }
+        dtb = {
+            2: '/boot/bcm2709-rpi-2-b.dtb',
         }
         deb_url = ('http://archive.raspberrypi.org/debian/'
                    'pool/main/r/raspberrypi-firmware/'
                    'raspberrypi-kernel_1.20190215-1_armhf.deb')
         deb_hash = 'cd284220b32128c5084037553db3c482426f3972'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
+        kernel_path = self.extract_from_deb(deb_path, kernel[version])
+        dtb_path = self.extract_from_deb(deb_path, dtb[version])
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               serial_kernel_cmdline[uart_model])
+                               serial_kernel_cmdline[uart_model][version])
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
                          '-append', kernel_command_line)
@@ -378,9 +386,10 @@ def test_arm_raspi2_uart0(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:raspi2
+        :avocado: tags=cpu:cortex-a7
         :avocado: tags=device:pl011
         """
-        self.do_test_arm_raspi2('pl011')
+        self.do_test_arm_raspi(2, 'pl011')
 
     def test_arm_exynos4210_initrd(self):
         """
-- 
2.21.1


