Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21796C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B6A2082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaLf/XH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B6A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j336V-0004t6-4r
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331J-0004Fs-Tu
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331I-00010f-KF
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:29 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331I-0000zj-Dj
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:28 -0500
Received: by mail-ed1-x544.google.com with SMTP id t7so3804505edr.4
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 11:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=09Xk8WDBMCC08TR8D0T7ekaeveyV8dl1oOjYfkBK3r4=;
 b=YaLf/XH6wsVDqz+uCMcOjR3Qko2ZHIc1kHFfovvZmFp6pz0sJn2+kNLnHrZ30tvTn0
 +Ti9qxSgOxaGwpRng2gpdPnuVvPIjOJAjLTZSmDlYGu5o2PaPoP6Fterq7lJr1CARViu
 iBrjz3cKTcTHL47uGioHEoRfI+jaDOs0Yq6FM1KQ2zcUNo3jAK7b9+Lmy+qgIi/Pi5lP
 IIF3ae6OWQqUUXrVzzxaytBXjZUtDMWrTGSvy9sYgooQO6zZWEugqNKA2mEMBUYAE35c
 hmMVzWbxe3U+pguzz51LC0XqGWc0lJwPzZQDSXJ50EvoIb2Ydv2rcblDSNEQKpcWNvPe
 R3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=09Xk8WDBMCC08TR8D0T7ekaeveyV8dl1oOjYfkBK3r4=;
 b=fUhP8DKooR9XHBqVTOW08LFmGX/y/VmFAuKMGcoPMjUnCW8Ht5bMkVQZ8M5s0ay1Pc
 74ccmF0iXpwFEt957dKuZiN0b4S/sJVFpif5kBEx/r5r+LyN25LITd/R5ymHtGQHGyab
 3FEwOmqZzE236qV7XAfPTDy3+YCi7+Kr8K8qFJhwfKB6a8RxQb1d3+EDOHPyEnsP0W+a
 GwVZpi2XfTlLAziISmylc/MxYKaMqWwLP7PE8T8kCNVGSaLzJvPn/6g3eZzEL++oh2L0
 gSdJ7qB5nYzprvDc6l8hMcokCkH9tTpUF2RC5f2vsv5va383QujC65F4sk/BkkmqVfgJ
 gcrg==
X-Gm-Message-State: APjAAAVzqYkj0IFDXMY1ZYGn+2BTm7SYu4kdNlZUluZapHVAoJer53us
 gQvVUQemKWXWZ1LRJVpDfSv4BvaXjmY=
X-Google-Smtp-Source: APXvYqyAWgMB2HAy5L1qb/u48RWQuuL15FbJpHdM4fejvIECboOvi+3dTf6hM90i90og1JC7/xSC2A==
X-Received: by 2002:a17:906:bb04:: with SMTP id
 jz4mr8574711ejb.183.1581794547245; 
 Sat, 15 Feb 2020 11:22:27 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a24sm657128ejt.40.2020.02.15.11.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:22:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] tests/boot_linux_console: Test booting U-Boot on the
 Raspberry Pi 2
Date: Sat, 15 Feb 2020 20:22:14 +0100
Message-Id: <20200215192216.4899-7-f4bug@amsat.org>
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

This test runs U-Boot on the Raspberry Pi 2.
It is very simple and fast:

  $ avocado --show=app,console run -t raspi2 -t u-boot tests/acceptance/
  JOB LOG    : avocado/job-results/job-2020-01-20T23.40-2424777/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi2_uboot:
  console: MMC:   sdhci@7e300000: 0
  console: Loading Environment from FAT... Card did not respond to voltage select!
  console: In:    serial
  console: Out:   vidconsole
  console: Err:   vidconsole
  console: Net:   No ethernet found.
  console: starting USB...
  console: USB0:   Port not available.
  console: Hit any key to stop autoboot:  0
  console: U-Boot>
  console: U-Boot> bdinfo
  console: arch_number = 0x00000000
  console: boot_params = 0x00000100
  console: DRAM bank   = 0x00000000
  console: -> start    = 0x00000000
  console: -> size     = 0x3c000000
  console: baudrate    = 115200 bps
  console: TLB addr    = 0x3bff0000
  console: relocaddr   = 0x3bf64000
  console: reloc off   = 0x3bf5c000
  console: irq_sp      = 0x3bb5fec0
  console: sp start    = 0x3bb5feb0
  console: Early malloc usage: 2a4 / 400
  console: fdt_blob    = 0x3bfbdfb0
  console: U-Boot> version
  console: U-Boot 2019.01+dfsg-7 (May 14 2019 - 02:07:44 +0000)
  console: gcc (Debian 8.3.0-7) 8.3.0
  console: GNU ld (GNU Binutils for Debian) 2.31.1
  console: U-Boot> reset
  console: resetting ...
  PASS (0.46 s)

U-Boot is built by the Debian project, see:
https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootable_SD_Card_with_u-boot

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 3d442b6cd1..3b1952b2df 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -16,6 +16,7 @@
 from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import exec_command_and_wait_for_pattern
+from avocado_qemu import interrupt_interactive_console_until_pattern
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
@@ -575,6 +576,33 @@ def test_arm_cubieboard_sata(self):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    def test_arm_raspi2_uboot(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi2
+        :avocado: tags=u-boot
+        """
+        deb_url = ('https://snapshot.debian.org/archive/debian/'
+                   '20190514T084354Z/pool/main/u/u-boot/'
+                   'u-boot-rpi_2019.01%2Bdfsg-7_armhf.deb')
+        deb_hash = 'ad858cf3afe623b6c3fa2e20dcdd1768fcb9ae83'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        uboot_path = '/usr/lib/u-boot/rpi_2/uboot.elf'
+        uboot_path = self.extract_from_deb(deb_path, uboot_path)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', uboot_path,
+                         # VideoCore starts CPU with only 1 core enabled
+                         '-global', 'bcm2836.enabled-cpus=1',
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


