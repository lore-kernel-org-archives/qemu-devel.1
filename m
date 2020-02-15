Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFEAC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5342082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s35Jv7yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5342082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j336x-0005T7-MC
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331L-0004Il-4L
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331J-00013c-Qk
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:31 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331J-00011M-Jz
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:29 -0500
Received: by mail-ed1-x544.google.com with SMTP id p3so15456747edx.7
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 11:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PzfywHJFm+G1+KKl/Onq2rp5QkVpIkH04ol8WwJE1Zw=;
 b=s35Jv7yjc5XdY4TW3ZpEk5RqR8skKfXKFTlvT3ZTPM6OH1hQK1QycSUqrjPqww2tre
 t2LVmPC4CfhXtecQEf3GMoUXOD9Wa5V6KQrEFCf2WOAUHEhLLzEag8KY4s5NpHqIR6yG
 zcwasypyrkm6RcUiBg/k2sG7DDg4+rDlXejoxuk5n2NDd+OB+6fghWAnRAuBaFPxZa/x
 IC5I5o/L5PCtmXsGE4/E4L26JRlfI5/0QduZUn9UJ2uJHH7nOCLWUNJdjPixJV3yBT3C
 JGd7ctfkb24nygQEKkN4GOOrmqSa22oV/1SUJrPNo5iLm2Xb09lgiEGOpaTiQ4Abovdc
 YCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PzfywHJFm+G1+KKl/Onq2rp5QkVpIkH04ol8WwJE1Zw=;
 b=oCAjXIcoLhhlRMdwmp3XLM79cRDnYo2J5YB+0ZIxXaiM+IFcD93z573n+ZcUwC0BAM
 90z89AjJOhc98cagUlNsOtivo4nNW9u6fWE/7JtYUlbXJ8cJpJ0sHFLvAFYTT1X3BICb
 jBdr97rq44lyUPnK9GNlXTsVOEHWIZPdINr+RP+nsXhU3up8sgKf74PHxb+lvDOupdQj
 OrKtNh+oVvfi4WP/lXwMx2j7DVqvXYb3o/s2XXQpVKfMDbQKoM6Vu3wcOdcyrX88cnTc
 x3Kyq0mWUEDnllqSYjKD7brh9Dx6ltKdTwfPGSIklhU/sqwHRUcYROIpLgkmU+6VXsUE
 yp+g==
X-Gm-Message-State: APjAAAWmxEWzwZ3PZIl2tl7QEvIp+fgpHQyGbzYqiwt4P+KhmCqOJVt/
 cXOh6B6Pnl8styFwUy52v7WqxKoqJ/E=
X-Google-Smtp-Source: APXvYqz4rplq1Fmsn1BZGJORE+dpd0XuDhdxkSMWf6etl1FiQu/fXllxRJSnjSBq6GUT7peNeiml1g==
X-Received: by 2002:a05:6402:3047:: with SMTP id
 bu7mr7899500edb.44.1581794548526; 
 Sat, 15 Feb 2020 11:22:28 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a24sm657128ejt.40.2020.02.15.11.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:22:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] tests/boot_linux_console: Test booting U-Boot on the
 Raspberry Pi 3
Date: Sat, 15 Feb 2020 20:22:15 +0100
Message-Id: <20200215192216.4899-8-f4bug@amsat.org>
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

This test runs U-Boot on the Raspberry Pi 3.
It is very simple and fast:

  $ avocado --show=app,console run -t raspi3 -t u-boot tests/acceptance/
  JOB LOG    : avocado/job-results/job-2020-01-20T23.40-2424777/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_raspi3_uboot:
  console: MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
  console: Loading Environment from FAT... WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_command()!
  console: WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_command()!
  console: Card did not respond to voltage select!
  console: In:    serial
  console: Out:   vidconsole
  console: Err:   vidconsole
  console: Net:   No ethernet found.
  console: starting USB...
  console: Bus usb@7e980000: Port not available.
  console: Hit any key to stop autoboot:  0
  console: U-Boot>
  console: U-Boot>
  console: U-Boot> bdinfo
  console: arch_number = 0x0000000000000000
  console: boot_params = 0x0000000000000100
  console: DRAM bank   = 0x0000000000000000
  console: -> start    = 0x0000000000000000
  console: -> size     = 0x000000003c000000
  console: baudrate    = 115200 bps
  console: TLB addr    = 0x000000003bff0000
  console: relocaddr   = 0x000000003bf57000
  console: reloc off   = 0x000000003bed7000
  console: irq_sp      = 0x000000003bb52dd0
  console: sp start    = 0x000000003bb52dd0
  console: FB base     = 0x0000000000000000
  console: Early malloc usage: 7b0 / 2000
  console: fdt_blob    = 0x000000003bfbf200
  console: U-Boot> version
  console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
  console: gcc (Debian 9.2.1-22) 9.2.1 20200104
  console: GNU ld (GNU Binutils for Debian) 2.33.1
  console: U-Boot> reset
  console: resetting ...
  PASS (1.79 s)

U-Boot is built by the Debian project, see:
https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootable_SD_Card_with_u-boot

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 3b1952b2df..989db7d461 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -603,6 +603,31 @@ def test_arm_raspi2_uboot(self):
         exec_command_and_wait_for_pattern(self, 'version', 'U-Boot')
         exec_command_and_wait_for_pattern(self, 'reset', 'resetting ...')
 
+    def test_aarch64_raspi3_uboot(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi3
+        :avocado: tags=u-boot
+        """
+        deb_url = ('https://snapshot.debian.org/archive/debian/'
+                   '20200108T145233Z/pool/main/u/u-boot/'
+                   'u-boot-rpi_2020.01%2Bdfsg-1_arm64.deb')
+        deb_hash = 'f394386e02469d52f2eb3c07a2325b1c95aeb00b'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        uboot_path = '/usr/lib/u-boot/rpi_3/u-boot.bin'
+        uboot_path = self.extract_from_deb(deb_path, uboot_path)
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-kernel', uboot_path,
+                         '-no-reboot')
+        self.vm.launch()
+        interrupt_interactive_console_until_pattern(self,
+                                       'Hit any key to stop autoboot:',
+                                       'Config file not found')
+        exec_command_and_wait_for_pattern(self, 'bdinfo', 'U-Boot')
+        exec_command_and_wait_for_pattern(self, 'version', 'U-Boot')
+        exec_command_and_wait_for_pattern(self, 'reset', 'resetting ...')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.21.1


