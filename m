Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC14C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9CC2082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0ZOiTqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9CC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j332L-0005gW-Ob
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331D-00042u-Aj
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331C-0000uK-4Q
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:23 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:44757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331B-0000ta-Ue
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:22 -0500
Received: by mail-ed1-x543.google.com with SMTP id g19so15417529eds.11
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 11:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T9g/uHvPBoXhUQDq2QsJ245v2/hf9EivqbEoJ3SIqVI=;
 b=O0ZOiTqAgEDNvTqaFZl96dP515q36pnwm/o6kOFowuLoG7ZYJVZHO6qIw1NKR/PclW
 SG+J4OwxoSJK/eMQQkfxdpJROP5QqmNWPfPG+so+KCuwGC3DDknIz0RoCeWZ791iTyk1
 +hBjtnlgjhcfx2j2BGhSeJveVN5688BX8TkmSpoV58b+zuVhsjJrEL/RjPEBRX84xgeD
 mB3oJvwICMmzZPj9CODdSL9qG8kX2Oxzqd1G/mKW1bBJ/DVL4/UcKt4IaajIoYzdqnpC
 QoOSZy91sCFw2sx7q+wYHMjFW7qZSqkowTsDBX7vjjWHIxumnZ7lIhHepBRzX3bvac43
 vUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T9g/uHvPBoXhUQDq2QsJ245v2/hf9EivqbEoJ3SIqVI=;
 b=hNU7vG/SsIiNSMDouv8bCNd8cqN5O9j3Z0WveZQ0JLwcC9WnzZp1UkdfpHvkfFCysS
 DyyhiSVHMG1470I9tqHSPUybcE60G0ggdWK8SIqBP3s//1leUSiSQzU4UWDtjCGdyWnn
 UgxDGyXcQoQgJ1WA+/lSOXQrLHmhRsMckXqfXRiLoZixXyeblwUNVHs8tmJCNMLyzv2V
 NW/axz02Td1ig7nAp/bMf4XMNaKBkQu/JdkV8yWLFDF9lA2kWCAeWiL7TB7CfJEc0bEW
 MUFaxLXb6qzxK5Lvmt134sC2zOqjI+jwgvOv1SgId1r6rqj5fCja3XUfSqbjxqFSYGUp
 meXw==
X-Gm-Message-State: APjAAAXox/ODo88Hjsjz8S64VU3DadAB6AWERNx0FxjCQe92YMjhoPBS
 EHvSaxscECG0nXJPkF6OyZ9NqBikfxs=
X-Google-Smtp-Source: APXvYqw9ciBVVR2btddrB8upvlmzxtHD2XfgWqRdl25JaGCJhdAcF8Km7PYbdDsh4E19K/0ucSjf8w==
X-Received: by 2002:a17:906:5210:: with SMTP id
 g16mr8349779ejm.305.1581794540603; 
 Sat, 15 Feb 2020 11:22:20 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a24sm657128ejt.40.2020.02.15.11.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:22:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] tests/acceptance/boot_linux_console: Use raspi console
 model as key
Date: Sat, 15 Feb 2020 20:22:09 +0100
Message-Id: <20200215192216.4899-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215192216.4899-1-f4bug@amsat.org>
References: <20200215192216.4899-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
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

Python dictionary are not that expensive. Use a key makes the
code easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 34d37eba3b..8cfc758d42 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -347,14 +347,14 @@ def test_arm_emcraft_sf2(self):
         self.vm.launch()
         self.wait_for_console_pattern('init started: BusyBox')
 
-    def do_test_arm_raspi2(self, uart_id):
+    def do_test_arm_raspi2(self, uart_model):
         """
         The kernel can be rebuilt using the kernel source referenced
         and following the instructions on the on:
         https://www.raspberrypi.org/documentation/linux/kernel/building.md
         """
         serial_kernel_cmdline = {
-            0: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
+            'pl011': 'earlycon=pl011,0x3f201000 console=ttyAMA0',
         }
         deb_url = ('http://archive.raspberrypi.org/debian/'
                    'pool/main/r/raspberrypi-firmware/'
@@ -366,7 +366,7 @@ def do_test_arm_raspi2(self, uart_id):
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               serial_kernel_cmdline[uart_id])
+                               serial_kernel_cmdline[uart_model])
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
                          '-append', kernel_command_line)
@@ -380,7 +380,7 @@ def test_arm_raspi2_uart0(self):
         :avocado: tags=machine:raspi2
         :avocado: tags=device:pl011
         """
-        self.do_test_arm_raspi2(0)
+        self.do_test_arm_raspi2('pl011')
 
     def test_arm_exynos4210_initrd(self):
         """
-- 
2.21.1


