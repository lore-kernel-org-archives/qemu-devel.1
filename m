Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D30EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132F22072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNTfMrQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132F22072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihge8-00063T-1i
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ihgV1-0002RJ-9p
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ihgUz-0001JI-1N
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:50 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ihgUx-0001IX-G1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so3782788wrw.8
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p+r84vU2MHCDeOWkxehyW8ncP9LqWpMrZCi9EfOXalc=;
 b=PNTfMrQNm7O5dFc+Oc1AJhmTunaTMBhqsvBR8k1Hl2E44I8usoVA4voz+5NrXPWn41
 FLP65Zy02GKcXFpQzRFzfDXnluF2ryWU64Oo28im+Ygy7bJd9rp4d09rhR1PQnRX/lGe
 JKmNIj8WQTwn8MxTrOClMX1T1ntZoKTMYdfyvh+Tmtub1yAfHP9zepcZnSz+Nm8l1FMn
 Qpt1l0aUzjc+iASV3wF9mcvghNB7wbKL2QKGITKJRr0UsMteFLzGAEMv6w2E/3igv0fV
 AWRuq4OpIkS3qGyRllvYOIiFZbtH+fD1pRpRdqqOBAX9rP6kAykHpQHAlhNOp3NTI+iC
 I65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p+r84vU2MHCDeOWkxehyW8ncP9LqWpMrZCi9EfOXalc=;
 b=ewP3b+xQCCrIJ6gH8Uq1seZPbVDR73FS6gVApKqjXfVtlRpYmTV819v+3MabzcCjHV
 eHCBcW2Y6gZURpV7rro9c1AlNoIPlfnAuhP4rXZGNLU3PjTR5bL2hmVnRTxh7oSLoAn/
 no8BOHOhKxwm/uWrPQcP3tndQw+O9UUFvqRtfonAhUNToTz7ZywMK1PoBLo9mNUfmfHg
 Vm2jueb0XL/mUG9XyP2/ZNDMMTVjixA2TFAYh9Kd81poovHuelOzmkfWAARwKxLOM4M4
 aEwqyMvHEqFsmBOjzPflVfRxWcEq6JK+YXiMrCvEpDIFW7o6/HJng/8EA2+JPBzu16rL
 Dklw==
X-Gm-Message-State: APjAAAUXUkMzZQQTF2JePJfrhHLhkEPbjN/9A0QGOcY07y9wmvCpeKwV
 inh2x7TBZZOYBORGLT502fMY5DorqvxotQ==
X-Google-Smtp-Source: APXvYqzBVXd7q3vrbW+GqqrKgt1X+awVKITCVIASZjuHpGaQNNIbStaVhggZNmeWexXoxlvoa/1NKg==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr5127833wru.220.1576703086087; 
 Wed, 18 Dec 2019 13:04:46 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-2-109.red.bezeqint.net. [109.65.2.109])
 by smtp.gmail.com with ESMTPSA id a133sm3808933wme.29.2019.12.18.13.04.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 18 Dec 2019 13:04:45 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v39 20/22] target/avr: Add boot serial test
Date: Wed, 18 Dec 2019 23:03:27 +0200
Message-Id: <20191218210329.1960-21-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191218210329.1960-1-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Print out 'T' through serial port

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-serial-test.c | 10 ++++++++++
 tests/Makefile.include   |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index d3a54a0ba5..1121ed0db2 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
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
@@ -103,6 +112,7 @@ typedef struct testdef {
 
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
+    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
diff --git a/tests/Makefile.include b/tests/Makefile.include
index b381387048..86ace719dc 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -206,6 +206,8 @@ check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
 
+check-qtest-avr-y += tests/boot-serial-test$(EXESUF)
+
 check-qtest-alpha-y += tests/boot-serial-test$(EXESUF)
 check-qtest-alpha-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 
-- 
2.17.2 (Apple Git-113)


