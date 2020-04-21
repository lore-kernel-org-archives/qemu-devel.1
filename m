Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705BFC38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9E02084D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vM2nY2C/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9E02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQi99-0001bj-E7
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 21:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQi20-0007b3-JL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQi20-0006bk-4c
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:49:00 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jQi1z-0006Zj-OC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:48:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id r4so6027734pgg.4
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 18:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FS2O63iko+vF5p7kOKGCLXMwPEY/QkzawKDVLWYlL7A=;
 b=vM2nY2C/D2Y1Qz+yl4LnAuVf+rKjFibG6t7SrQjEOYTPA9fr6jJiD+EsuaZJRtF9U8
 LQanFe70zfNI/OZQH3sjL19sL9LYukViOFzBafNUNXOOjL0cshFesoylS9S6/C9DQkap
 4mCkYPV94txJyDnu2UCyxxCPXXnHr/0eljm+KK3fqVPnfQZaGdQpO4VseIBOSiQ7fjdH
 rC8bnSIAOiK4GAT7OtKS/qIWfP+f5NhgV3v5YW2uNIhm1yd92v4tRx2wykuVPAmu8n97
 Q0ZIX2Spu0B5Io8TeNrLPXRIM6Hp8VP0yUx/+McS3x7tc8d+/9Ua+uf6hv58f0Xl/Oio
 Z/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FS2O63iko+vF5p7kOKGCLXMwPEY/QkzawKDVLWYlL7A=;
 b=JRZ2moKaz8Nat1iHVnJKtzIshx12rc1SK9ki6XCDlQlcrjgVsEtXLGyz5BrI7dK6kD
 DTswynIW8sylMvc2DngKQuiMwy8//+8YFRJkZmyb55E734taARN1SW67gnVrXPGHicYb
 818MjB5ElJJeGYSMXqYmXAOPQ199wbxy9w2APh/J+4ryk+VLz/PTd2MyYJU5TjyMn6ia
 yS3Au2BV8cqCspvePlzYOdhF3sfaBUCXx6eXubGXMaTnuTIFkldL1+nNUmJsiinuZ6e0
 SgF3MKjMlzrI+WIIidhLJeVwiO70qusx4aCnavduq3CUgkFs8sJmB0XUqG+KPR0iI2Bm
 2pGg==
X-Gm-Message-State: AGi0PubRBLX1TushMQrED/ch8q0fELjyvDqwhDjqD1JWMzQ/WGREcu0v
 N92nEEEOlwghtgeG+PyjavU=
X-Google-Smtp-Source: APiQypKuTxfpliE2WWh23lgqwyzBebJfAVVdU/dqFodDNW8JqGXCKbLT8exC5MQCScbYQpLGJMZmUg==
X-Received: by 2002:a62:18cc:: with SMTP id 195mr20254739pfy.135.1587433738632; 
 Mon, 20 Apr 2020 18:48:58 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id q11sm654868pgs.25.2020.04.20.18.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 18:48:58 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 7/7] raspi2 acceptance test: add test for dwc-hsotg (dwc2)
 USB host
Date: Mon, 20 Apr 2020 18:45:51 -0700
Message-Id: <20200421014551.10426-8-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421014551.10426-1-pauldzim@gmail.com>
References: <20200421014551.10426-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=pauldzim@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a check for functional dwc-hsotg (dwc2) USB host emulation to
the Raspi 2 acceptance test

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 tests/acceptance/boot_linux_console.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index f825cd9ef5..efa4803642 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -373,13 +373,18 @@ class BootLinuxConsole(Test):
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               serial_kernel_cmdline[uart_id])
+                               serial_kernel_cmdline[uart_id] +
+                               ' root=/dev/mmcblk0p2 rootwait ' +
+                               'dwc_otg.fiq_fsm_enable=0')
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
-                         '-append', kernel_command_line)
+                         '-append', kernel_command_line,
+                         '-device', 'usb-kbd')
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
+        console_pattern = 'Product: QEMU USB Keyboard'
+        self.wait_for_console_pattern(console_pattern)
 
     def test_arm_raspi2_uart0(self):
         """
-- 
2.17.1


