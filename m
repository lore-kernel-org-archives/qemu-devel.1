Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BDC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7DD207E0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0bQHcdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7DD207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilgl4-0000LF-Ve
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilgV4-0007pi-VN
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilgV3-0004Ga-Po
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:26 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilgV2-0004DF-Oa
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:25 -0500
Received: by mail-wm1-x342.google.com with SMTP id d139so10506069wmd.0
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 13:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o1YkLtT6Ze9oMsNmRtkKZc9LCOt0XB8lCSHqKeVRNdM=;
 b=e0bQHcdVVhsE+Ci4pNQJQY3aNIsAzwUifhLLXAQ0xK8NuDmTW5yIzPBtfCiOBN4FNO
 pijnPL/L6iptyh5K4zhyX3dVJCZHzocZG6jq+k/0ZgJl8qJb6HGqIUnTB+HNK4/jo9Xl
 JuBi7n1iR6cEWOHOwuJyfdSQ4kU+OmX0ZynrbLbsfonSpa8UWer7368TLbLgJ3GLkhIe
 xSwzJ/AnoppOnLhAyA5wCDdOxlZjw+3Z1KXGa9u2vmdVo/hk6gt0zoaAjeYy6QagIn1n
 Vq4MQq0R/PWIQJjyJu18wH+fsYzJRQZtB1lnyihgi2CA0aQN/q6/q9WFXJmOpxKZQZId
 X1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o1YkLtT6Ze9oMsNmRtkKZc9LCOt0XB8lCSHqKeVRNdM=;
 b=WarDjilq4kW2yc67mL8bqi+6mR97XEax6wU16o+9u2CO66FB0Mr0B14Z+MM2PeJGbK
 7NS5t5w2Yt3eZtIfwyGZL6HQ1VzkmTCOg2DqnL5/BJnNnBkEiQHwOnN5PI/DUga1YPMV
 FdypRHkcorgHgZWPU9JyZ+yo2wWBF118QD3w03TaE96exBolDnAvIuK/qrTJOnr+H+Vz
 U8PVgOszEIUB/L4HBDYpi+Mt7SkI2nMD7gLM14hTLCYRWzZykQj3YEFAU+h6u3yRn0hh
 M4eK2pTYnDwRXaI7Kezr2jt9ZL21QtuuuEqRBC4m8WJtsAwdF+Hm0jjsFZzyOuqN0JYD
 1puA==
X-Gm-Message-State: APjAAAVpigPU4m3rlsLMTEj/eZYFbHMHIQdRUd87s71TLW2EsIbY/JTZ
 vEMJsPS7lKRp3V8wok+L5HGVvltN3xUXZQ==
X-Google-Smtp-Source: APXvYqwoXMthPc3PjfW1DbxHYBVgjZ21hJLL7vhWYdH6OhZIrSiYQnBBp50Oxll5eUq37vO8dQvNWw==
X-Received: by 2002:a1c:28d4:: with SMTP id
 o203mr30787010wmo.123.1577656403197; 
 Sun, 29 Dec 2019 13:53:23 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-183-93-3.red.bezeqint.net. [79.183.93.3])
 by smtp.gmail.com with ESMTPSA id 25sm18182850wmi.32.2019.12.29.13.53.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 29 Dec 2019 13:53:22 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v40 19/21] target/avr: Add boot serial test
Date: Sun, 29 Dec 2019 23:51:56 +0200
Message-Id: <20191229215158.5788-20-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191229215158.5788-1-mrolnik@gmail.com>
References: <20191229215158.5788-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
index 05c7f44457..e556f09db8 100644
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
index 31b86674e5..554a5c3084 100644
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


