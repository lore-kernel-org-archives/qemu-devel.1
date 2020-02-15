Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9BAC7114D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACE62082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2VFKwqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACE62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j335d-0003RI-RZ
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331I-0004D5-Qt
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331H-0000zA-EX
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:28 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:46537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331H-0000y8-7Q
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:27 -0500
Received: by mail-ed1-x544.google.com with SMTP id p14so7289543edy.13
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 11:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tzrui7Hni4HFas47JhhX91fv9JSO990o0375X1EFRvA=;
 b=Y2VFKwqKuyOKh2fZHOUSqMmH7qFh3qXZhhJrDA9lvf0Ak3QDxxoCnggcMkwgc/u/Ss
 J24qPzJu1u9Vr03FoOj8UZ9QIbmIkDUB1LRjHkvIJfaeF3hfO/9/AV2+C53xoizEtGVi
 re8HUXO9Hs0Cf8zqVTihfMw5mB4uF++JYeVGO0FBefpI+Gj4Io+kyaG3v40MDzKIQoBq
 yt8SW/KS4PKVXNd/hHWxfa78lozMhDJFZS8iUo9KHYzXrou8IQ5ELWgcKYoQv5QA1jNW
 RqoDLR8W4T9+HnLFGNjIXykh6zkOzwwelAB3XrJ45Nd3SkfcYH3nUdnCiNlQJItjcpdG
 BzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tzrui7Hni4HFas47JhhX91fv9JSO990o0375X1EFRvA=;
 b=ufudAQfIi/2DDjba5FS2yyw7gIt97rfNUmImCbCkDOYOcg7mlYn+wkQkhC6JSzBzNp
 9xA+qUX1Of3U1eAwLUlD3IvDckV1aphrKCA+tKZw97+TMJNIM3+7h/YB2r4O/5bu5aDI
 oBhaDejhvgCSiGe7x0hQVCewKCFZzvZQGZ7JmagsW0vSSfv3olWQm1FV5448BlsdsZ+Y
 kiRQHYiveVJirKQh1JAmBQyYJBnoF2SCAwCPv+6vHXjpPQVuX+f5NaUHsvu/cOjPdXqK
 e2CQQOP4lPx+IXJkXC/nTgqM+/j3IFHP9ink6w3k4+e0Ku0rN1PnJ/iWOkJ7dc9RKr0Y
 bTqw==
X-Gm-Message-State: APjAAAVWESrtoLbPcPntO6kAtXtDlxlho/1HysVoUmNlO/S4YraOi/ej
 6ubzVgaf7iz/8h6CeAIgausCM5xWlFQ=
X-Google-Smtp-Source: APXvYqzARskAAw3XImlSx0Y7jKGg1loNMYvhMzaxSl1hWagJJgDAu6PUr7acneCnzd5B+v+kFiVdsQ==
X-Received: by 2002:a17:906:4a5a:: with SMTP id
 a26mr8428680ejv.49.1581794545977; 
 Sat, 15 Feb 2020 11:22:25 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a24sm657128ejt.40.2020.02.15.11.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:22:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] tests/acceptance/boot_linux_console: Test the raspi1 AUX
 console
Date: Sat, 15 Feb 2020 20:22:13 +0100
Message-Id: <20200215192216.4899-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215192216.4899-1-f4bug@amsat.org>
References: <20200215192216.4899-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
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

  $ avocado --show=app,console run -t device:bcm2835_aux tests/acceptance/
  JOB ID     : a8846d69d52da701681b1d17f80ef299009fd078
  JOB LOG    : avocado/job-results/job-2020-02-05T23.44-a8846d6/job.log
   (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi0_uart1:
  console: [    0.000000] Booting Linux on physical CPU 0x0
  console: [    0.000000] Linux version 4.14.98+ (dom@dom-XPS-13-9370) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 Tue Feb 12 20:11:02 GMT 2019
  console: [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  console: [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  console: [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero W
  console: [    0.000000] earlycon: uart8250 at MMIO32 0x20215040 (options '')
  console: [    0.000000] bootconsole [uart8250] enabled
  console: [    0.000000] Memory policy: Data cache writeback
  console: [    0.000000] cma: Reserved 8 MiB at 0x1b800000
  console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 113680
  console: [    0.000000] Kernel command line: printk.time=0 earlycon=uart8250,mmio32,0x20215040 console=ttyS1,115200
  PASS (13.31 s)
   (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi1_uart1:
  console: [    0.000000] Booting Linux on physical CPU 0x0
  console: [    0.000000] Linux version 4.14.98+ (dom@dom-XPS-13-9370) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 Tue Feb 12 20:11:02 GMT 2019
  console: [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  console: [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  console: [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B
  console: [    0.000000] earlycon: uart8250 at MMIO32 0x20215040 (options '')
  console: [    0.000000] bootconsole [uart8250] enabled
  console: [    0.000000] Memory policy: Data cache writeback
  console: [    0.000000] cma: Reserved 8 MiB at 0x1b800000
  console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 113680
  console: [    0.000000] Kernel command line: printk.time=0 earlycon=uart8250,mmio32,0x20215040 console=ttyS1,115200
  PASS (13.39 s)
   (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi2_uart1:
  console: [    0.000000] Booting Linux on physical CPU 0xf00
  console: [    0.000000] Linux version 4.14.98-v7+ (dom@dom-XPS-13-9370) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 SMP Tue Feb 12 20:27:48 GMT 2019
  console: [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
  console: [    0.000000] CPU: div instructions available: patching division code
  console: [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
  console: [    0.000000] OF: fdt: Machine model: Raspberry Pi 2 Model B
  console: [    0.000000] earlycon: uart8250 at MMIO32 0x3f215040 (options '')
  console: [    0.000000] bootconsole [uart8250] enabled
  console: [    0.000000] Memory policy: Data cache writealloc
  console: [    0.000000] cma: Reserved 8 MiB at 0x3b800000
  console: [    0.000000] percpu: Embedded 17 pages/cpu @baf2e000 s38720 r8192 d22720 u69632
  console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 243600
  console: [    0.000000] Kernel command line: printk.time=0 earlycon=uart8250,mmio32,0x3f215040 console=ttyS1,115200
  PASS (12.46 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 39.60 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 37 +++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index bd3f0fc852..3d442b6cd1 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -359,6 +359,14 @@ def do_test_arm_raspi(self, version, uart_model):
                 1: 'earlycon=pl011,0x20201000 console=ttyAMA0',
                 2: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
             },
+            'bcm2835_aux': {
+                0: 'earlycon=uart8250,mmio32,0x20215040 console=ttyS1,115200',
+                1: 'earlycon=uart8250,mmio32,0x20215040 console=ttyS1,115200',
+                2: 'earlycon=uart8250,mmio32,0x3f215040 console=ttyS1,115200',
+            },
+        }
+        uart_id = {
+            'pl011': 0, 'bcm2835_aux': 1,
         }
         kernel = {
             0: '/boot/kernel.img',
@@ -378,7 +386,7 @@ def do_test_arm_raspi(self, version, uart_model):
         kernel_path = self.extract_from_deb(deb_path, kernel[version])
         dtb_path = self.extract_from_deb(deb_path, dtb[version])
 
-        self.vm.set_console()
+        self.vm.set_console(console_index=uart_id[uart_model])
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                serial_kernel_cmdline[uart_model][version])
         self.vm.add_args('-kernel', kernel_path,
@@ -397,6 +405,15 @@ def test_arm_raspi0_uart0(self):
         """
         self.do_test_arm_raspi(0, 'pl011')
 
+    def test_arm_raspi0_uart1(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi0
+        :avocado: tags=cpu:arm1176
+        :avocado: tags=device:bcm2835_aux
+        """
+        self.do_test_arm_raspi(0, 'bcm2835_aux')
+
     def test_arm_raspi1_uart0(self):
         """
         :avocado: tags=arch:arm
@@ -406,6 +423,15 @@ def test_arm_raspi1_uart0(self):
         """
         self.do_test_arm_raspi(1, 'pl011')
 
+    def test_arm_raspi1_uart1(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi1
+        :avocado: tags=cpu:arm1176
+        :avocado: tags=device:bcm2835_aux
+        """
+        self.do_test_arm_raspi(1, 'bcm2835_aux')
+
     def test_arm_raspi2_uart0(self):
         """
         :avocado: tags=arch:arm
@@ -415,6 +441,15 @@ def test_arm_raspi2_uart0(self):
         """
         self.do_test_arm_raspi(2, 'pl011')
 
+    def test_arm_raspi2_uart1(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi2
+        :avocado: tags=cpu:cortex-a7
+        :avocado: tags=device:bcm2835_aux
+        """
+        self.do_test_arm_raspi(2, 'bcm2835_aux')
+
     def test_arm_exynos4210_initrd(self):
         """
         :avocado: tags=arch:arm
-- 
2.21.1


