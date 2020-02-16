Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CC2C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 17:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EDF20857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 17:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYTLEyVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EDF20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Nlg-0005HN-RH
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 12:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3Nl1-0004aC-ST
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 12:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3Nl0-0001QE-Fu
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 12:31:03 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3Nky-0001Ob-Bn; Sun, 16 Feb 2020 12:31:01 -0500
Received: by mail-wr1-x444.google.com with SMTP id w12so16866682wrt.2;
 Sun, 16 Feb 2020 09:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ILByhanNSF4EWIF7kqIRdqxbnlc2sM+dFB4V1nqdc6M=;
 b=UYTLEyVGniAzpBLTnUMIlzGKTh2jG8JtmaIfySDMY24Cvt+e4H2Ea7opHdhb1VhR95
 E5d5b7L3jERpa5ZX+/F5yJssJMHZ1QHgCD0IE8wtfb0Gu9SIkhk4bcf2ccV1JV5saILb
 0cPKQVYUe7Fq329pmEyGBCv9Ckkek6PMUGg9ogS4Y467u8glzlQVWyhKp/Dv7SgHguXi
 DC7SKsSZD6KqUguTAexer9LGWjVPcvfW+GCi5Z4hpo5MwVVsAISQ+lqfqTAZHkcJBp2Q
 Yh2e5JAjuQTEVb299sl4VWk5A1rsomGPKUCEkWWF7YkQThWqY+Q1jA3SWSSkkgjttAjg
 wTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ILByhanNSF4EWIF7kqIRdqxbnlc2sM+dFB4V1nqdc6M=;
 b=m/pGOHuvNVhAv7SUhnOD5xmtYQHdUqY2QIdfR9XW3RmRalvboaI62z40ImUqbEEzEi
 eq2za087we1Pjf9rak3okq0WFRAZO2y9YkFz2Yrgt+uqiX1LF4cJBuHZubyXKziVFiCQ
 bOBQbsDdBgXYfeywntjRJa3n9omNMZuZwj/Ja4AHFNxEC1pw/xRd0RWq3b1+H6+YGCQO
 eNhxZyrCDDK8aWyNM5RbWWiZ+57K9vgeehckRbnJmfgiuFROBAY46slQafNF4W73iTcf
 84Lr6RPiMVqUFd4EOl7Ab3N8zXDBXcLxk8CZEh5kA9vpo/5/BqDjo+5G83Kr1E7quWNw
 V4cg==
X-Gm-Message-State: APjAAAV9pAoiiN/oCTa11oD2RJOKBIZBzW+uiq2IR2J7ZAW6sxkKgBzW
 CLGzlPjBfFw8cuxrA0ofa7xtG9F9YHw=
X-Google-Smtp-Source: APXvYqyGs87kwhUCxWSJWZwpCkT5DrUyOuqZa8fkfZ+OSM85HhApWM08bWVI5Hoa0RQX1U7EJ7GsCQ==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr17687924wrn.292.1581874258126; 
 Sun, 16 Feb 2020 09:30:58 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id 59sm18086135wre.29.2020.02.16.09.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 09:30:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/boot_linux_console: Boot Trusted Firmware-A on the
 Raspberry Pi 3
Date: Sun, 16 Feb 2020 18:30:55 +0100
Message-Id: <20200216173055.30338-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-arm@nongnu.org, pete@akeo.ie,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test runs Trusted Firmware-A on the Raspberry Pi 3.
We deliberately stop the boot process when the EDK2 UEFI version
is displayed.

The binary is build on AppVeyor CI using Pete Batard repository [1].
ATF v2.1 binary are used (see [2]).

It is very simple and fast:

  $ avocado --show=app,console run -t atf tests/acceptance
  JOB ID     : 1e748d7c9e9011cf0af3250ddc8ebf2389d6204e
  JOB LOG    : avocado/job-results/job-2020-02-16T18.08-1e748d7/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_raspi3_atf:
  console: NOTICE:  Booting Trusted Firmware
  console: NOTICE:  BL1: v2.1(release):v2.1
  console: NOTICE:  BL1: Built : 15:26:06, May 13 2019
  console: NOTICE:  rpi3: Detected: Raspberry Pi 3 Model B (1GB, Sony, UK) [0x00a02082]
  console: NOTICE:  BL1: Booting BL2
  console: ERROR:   rpi3_sdhost: timeout status 0x40
  console: NOTICE:  BL2: v2.1(release):v2.1
  console: NOTICE:  BL2: Built : 15:26:01, May 13 2019
  console: NOTICE:  BL1: Booting BL31
  console: NOTICE:  BL31: v2.1(release):v2.1
  console: NOTICE:  BL31: Built : 15:26:04, May 13 2019
  console: =UEFI firmware (version UEFI Firmware v1.15 built at 11:58:44 on Feb 14 2020)
  PASS (1.54 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 1.88 s

[1] https://github.com/pbatard/RPi3#summary
[2] https://github.com/ARM-software/arm-trusted-firmware/blob/v2.1/docs/plat/rpi3.rst

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 34d37eba3b..51f24c462a 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -507,6 +507,28 @@ def test_arm_cubieboard_sata(self):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    def test_aarch64_raspi3_atf(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi3
+        :avocado: tags=cpu:cortex-a53
+        :avocado: tags=device:pl011
+        :avocado: tags=atf
+        """
+        zip_url = ('https://github.com/pbatard/RPi3/releases/download/'
+                   'v1.15/RPi3_UEFI_Firmware_v1.15.zip')
+        zip_hash = '74b3bd0de92683cadb14e008a7575e1d0c3cafb9'
+        zip_path = self.fetch_asset(zip_url, asset_hash=zip_hash)
+
+        archive.extract(zip_path, self.workdir)
+        efi_fd = os.path.join(self.workdir, 'RPI_EFI.fd')
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-nodefaults',
+                         '-device', 'loader,file=%s,force-raw=true' % efi_fd)
+        self.vm.launch()
+        self.wait_for_console_pattern('version UEFI Firmware v1.15')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.21.1


