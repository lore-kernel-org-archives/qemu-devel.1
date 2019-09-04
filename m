Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3A9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9201F2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fIYOgT14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9201F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bg1-0000gm-5S
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0w-0005XO-2x
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0s-00039q-4l
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:21 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0r-00037J-MU
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:17 -0400
Received: by mail-pf1-x442.google.com with SMTP id h195so7362906pfe.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NK+hQjn74sTmmQoYkWqtZ1EbyzqY+R+jJ+p0UyW4OS0=;
 b=fIYOgT14ZAqAaSw448/XmZtYxW6nZHFwCUzpJYoRotX4XVCDuardpm99QiJcH9i6Ot
 FMH6y36BvG8K5t21zMeAjo1Dx4YcWMX1Aoc9s7hsy0aPTTWdcH+YPP+6T2D5sTlzbiKG
 +qF2AM73RHRWNnwqaLJAs7fyPmC0kvY0yPfKQfIN/rpjaCeN7Fl39P983ClaeyNec6lw
 ySAtuZTB5y+uggk4pzeoKvKEMYdu0iMoHM0rkYF65HZTQlepPJKFogkXAE2sksMt7tz/
 r7X8/Le47AsoJxMbDI4SuQpa81FRJp+ch3MptNea7Qvi5AWWgmLKig2loxdo2dEK6vVK
 th4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NK+hQjn74sTmmQoYkWqtZ1EbyzqY+R+jJ+p0UyW4OS0=;
 b=gEoTWJUGUAgpVDFPMT7QauGToBDRlTU/oXzNQ7+GggRQXeY3pwJbaRfB9IeGfcytYL
 OHINFi7GTp2HvNXyk1VoqLPNjAtE5rKulajpnEEUCApjcXaus95DPl/XNWSajZTLZvfQ
 Z9f9N3FlUuL9vreMKwcEptjmMNIc4rwNnK/p/AXcFQR/wdu/DxDXx9oSc4KH/6/KULmy
 zzKeaGTvOayVr2GupikD83jEff+YUTT0U6fiEVrsU9SJA4ZCwNlf7JW3XEYm/YwzQXD4
 GOsZEt5y4wB/zhoR6NbyaphYQcPq5CGiGt4bdg7OhQ689Z+5TLQms+SzIgtyUPZYA7Ws
 +wlw==
X-Gm-Message-State: APjAAAVkeNIpRQTNPshvLcUwEe3pfPO3CTHsqytUSLajCHd0J0ye8Hn2
 ZhP4/9sI+8ZX4k15qSl3idYqpbzFZOk=
X-Google-Smtp-Source: APXvYqztzCBe+ITN5zDplXdZLYN73se3dYg7jiAIgcy7qT5FF9Ip0D57UcTTdSEwDCeX2Gf1xG7cZg==
X-Received: by 2002:aa7:8498:: with SMTP id u24mr48839331pfn.61.1567625536067; 
 Wed, 04 Sep 2019 12:32:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:49 -0700
Message-Id: <20190904193059.26202-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 59/69] target/arm: Convert T16, nop hints
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c |  3 +--
 target/arm/t16.decode  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b70491d39e..69092c12c3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10891,8 +10891,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
         case 15: /* IT, nop-hint.  */
             if ((insn & 0xf) == 0) {
-                gen_nop_hint(s, (insn >> 4) & 0xf);
-                break;
+                goto illegal_op; /* nop hint, in decodetree */
             }
             /*
              * IT (If-Then)
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 19a442b894..5829b9a58c 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -19,6 +19,7 @@
 # This file is processed by scripts/decodetree.py
 #
 
+&empty           !extern
 &s_rrr_shi       !extern s rd rn rm shim shty
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
@@ -204,3 +205,19 @@ SETEND          1011 0110 010 1 E:1 000         &setend
 REV             1011 1010 00 ... ...            @rdm
 REV16           1011 1010 01 ... ...            @rdm
 REVSH           1011 1010 11 ... ...            @rdm
+
+# Hints
+
+{
+  YIELD         1011 1111 0001 0000
+  WFE           1011 1111 0010 0000
+  WFI           1011 1111 0011 0000
+
+  # TODO: Implement SEV, SEVL; may help SMP performance.
+  # SEV         1011 1111 0100 0000
+  # SEVL        1011 1111 0101 0000
+
+  # The canonical nop has the second nibble as 0000, but the whole of the
+  # rest of the space is a reserved hint, behaves as nop.
+  NOP           1011 1111 ---- 0000
+}
-- 
2.17.1


