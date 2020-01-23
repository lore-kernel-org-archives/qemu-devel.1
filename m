Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06253C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC39F20665
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8rp30lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC39F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49101 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQLA-00038M-Ng
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzk-0002J5-PB
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzc-0002Lr-64
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPzc-0002Li-09
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id c9so533315plo.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SlxqTjIPt9dUcMT1pJil25PNJ90pZv9wieksrOmXI1I=;
 b=h8rp30lbJdpfgYnjsyMAMp5x6JqBU8zicnAT4wmSxAAxQzK6WwgkOLlNEdyWPDHoNf
 zFzXSUXDYDrqkIxnLbYEK2hCOB1q1JVjPaEP9Qm3NjdGf/irsu5pO8adARCpj3sHzA8+
 WdGdsUi+Z3kTq6Cj25rwtsWdx2eSR0FUvsm7dIFZBvNfyDqqIY4OArz8ZGNoyf8Voha2
 PtmGiohcfAD70MvVvyzF5kBUfmgMKH0YVzVlXJkpymuyqLjpygOeY4kZ7/qW1Eb6jjXl
 cJc1TNakVRuX+QQsMftePY4wItQ28oI0z+DPSmw7Jqxosch9lMAGFwkTcsRLm7sbmaVE
 DBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SlxqTjIPt9dUcMT1pJil25PNJ90pZv9wieksrOmXI1I=;
 b=tWyOGU7H4eC5MR/vyqiBoUTa025PJwmYvLmMz+NK81ji/2TX256mbfXiwwz95Fut/b
 QhQKzmGedhqrSUs56e+NqGEtsHxPD3b7yPnry9XVLA3kx+8gPFwhybiQEg7bWcz7VJzF
 dkQyb7wLUIb8zw8dTX6w8MbalMaATgNbggCR3icAIf2d7ucGK9PDl204aBFSrlAbyWDj
 U86QKjjT8Q/QhzbEVGlIULSH1JfeaPgP71I36dnowQldmeNa71dkRGiwU3jfU6g/EbHs
 WyaYwPCsP/etH/MTiZFYhU/WhA2nKiPgVkZm4mDHnsGXUMPwd4vzEJV9Nf6z46un/h74
 idQw==
X-Gm-Message-State: APjAAAXmwaoSC9OU+K4gzTkVb/iMfPZZM9GfhxweWelRaifhTc6OmLpl
 wRpSJMCq5zJS3Hmn/vOAT+apC1uKoVU=
X-Google-Smtp-Source: APXvYqys8wejwqNMR56wA7oJjcWq+MHiCyeb2wU9J5Tw8rG8grQuOOo7pJtBa8/wCRKisHmvC3pTow==
X-Received: by 2002:a17:902:9a8e:: with SMTP id
 w14mr13332545plp.315.1579737842846; 
 Wed, 22 Jan 2020 16:04:02 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:04:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 22/24] tests/boot-serial-test: Test some Arduino boards
 (AVR based)
Date: Wed, 22 Jan 2020 14:03:05 -1000
Message-Id: <20200123000307.11541-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Print out 'T' through serial port

The Arduino Duemilanove is based on a AVR5 CPU, while the
Arduino MEGA2560 on a AVR6 CPU.

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash Arduino adjustments from f4bug]
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qtest/boot-serial-test.c | 11 +++++++++++
 tests/qtest/Makefile.include   |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 05c7f44457..07067b76a2 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -16,6 +16,15 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 
+static const uint8_t bios_avr[] = {
+    0x88, 0xe0,             /* ldi r24, 0x08   */
+    0x80, 0x93, 0xc1, 0x00, /* sts 0x00C1, r24 ; Enable tx */
+    0x86, 0xe0,             /* ldi r24, 0x06   */
+    0x80, 0x93, 0xc2, 0x00, /* sts 0x00C2, r24 ; Set the data bits to 8 */
+    0x84, 0xe5,             /* ldi r24, 0x54   */
+    0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
+};
+
 static const uint8_t kernel_mcf5208[] = {
     0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
     0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
@@ -103,6 +112,8 @@ typedef struct testdef {
 
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
+    { "avr", "arduino-duemilanove", "", "T", sizeof(bios_avr), NULL, bios_avr },
+    { "avr", "arduino-mega-2560-v3", "", "T", sizeof(bios_avr), NULL, bios_avr},
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index e6bb4ab28c..4817b6320f 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -65,6 +65,8 @@ check-qtest-i386-y += numa-test
 
 check-qtest-x86_64-y += $(check-qtest-i386-y)
 
+check-qtest-avr-y += boot-serial-test
+
 check-qtest-alpha-y += boot-serial-test
 check-qtest-alpha-$(CONFIG_VGA) += display-vga-test
 
-- 
2.20.1


