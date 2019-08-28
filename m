Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF883C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C0D208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjA6QUR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C0D208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33W7-0001tT-38
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fs-00038J-1P
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fq-0008JL-0N
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Fp-0008Hc-Cy
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:13 -0400
Received: by mail-pg1-x544.google.com with SMTP id n9so233475pgc.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VO3W9DH8N43psEbK5DhPL38cP8IqwAsRisCTRHkRmo0=;
 b=KjA6QUR6nHRZf6I+bVkPcfociKyMauAjE0flKOHl0ZsKmjwS76Ihi0WhkoTM4CYjYk
 3ahHSdxrIHvLVvuV+l/u17TJNj51OW6px917/Bt4bVz3WL6Ka5A9OQPBe4psgOahx6xW
 6yI3uhnq04Db+XW7ja/dqvpUias5pPPCn5hHK8p8e7qI1pwsLpBI/4h/HN+ECiYkMU7E
 RM7EzIrR4z6C0WHvB+vOy6kocsNgWCzMSNCgW/tYtMGIg7ltlx7/dS4vwef7YogVUdmJ
 SIxnka9OdTGl792W6/KEvKmHv5Z2hXPIDWK4gjLwE2j2tBj3bhsCPkPJg6WMg+rd2jd5
 pVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VO3W9DH8N43psEbK5DhPL38cP8IqwAsRisCTRHkRmo0=;
 b=EyLP/iNEQrmbP8c67DTx9Qvu2flA/iThiDoILGppNf7G/CMHcAr51HGogwCL9oM6Z3
 0BPd5pgbNmkXrdXHJ4hD7Cifz7QUCpAffe1+Khlwkua6qe7rWCKcJfl13AZnOrCBJGQu
 4ddOoZZKcDB5mHX58yV1fB+ybvxUd3/h1eKnM24Fo0tYTMDPqmnfITwYAMZ2QO1pwNHj
 B+sEYhI8a3IWKjYjE5d0vtCpE21ajS/SC0zi5rmQGHGftbMl28db29Zgz9erw2qgXmqO
 H1vzub/LZW46+2ISk82hHL+o5vXpQslQbiu9nyLDQjndtzSwKWowH9KuaxmMiIWQ+SBT
 uenw==
X-Gm-Message-State: APjAAAVkXKdXZHVu8isyFcOg6SBp8iDZVb47fdog4Erhc2OZIzWxQui2
 YCfqQ4wg7U29B9V2DaDOT3SaF54ZfkQ=
X-Google-Smtp-Source: APXvYqxsBuwQqfDhlS389wsiUNKIIE8GeeGluu8x+1zrQ1GircnEVa3qT1CIeVlQOi+HK6ik9UD6og==
X-Received: by 2002:a65:5b09:: with SMTP id y9mr4889095pgq.345.1567019111704; 
 Wed, 28 Aug 2019 12:05:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:03:57 -0700
Message-Id: <20190828190456.30315-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 10/69] target/arm: Simplify op_smlaxxx for
 SMLAL*
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

Since all of the inputs and outputs are i32, dispense with
the intermediate promotion to i64 and use tcg_gen_add2_i32.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 58983ccf88..8813d40a2c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8151,8 +8151,7 @@ DO_QADDSUB(QDSUB, false, true)
 static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
                        int add_long, bool nt, bool mt)
 {
-    TCGv_i32 t0, t1;
-    TCGv_i64 t64;
+    TCGv_i32 t0, t1, tl, th;
 
     if (s->thumb
         ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
@@ -8176,12 +8175,14 @@ static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
         store_reg(s, a->rd, t0);
         break;
     case 2:
-        t64 = tcg_temp_new_i64();
-        tcg_gen_ext_i32_i64(t64, t0);
+        tl = load_reg(s, a->ra);
+        th = load_reg(s, a->rd);
+        t1 = tcg_const_i32(0);
+        tcg_gen_add2_i32(tl, th, tl, th, t0, t1);
         tcg_temp_free_i32(t0);
-        gen_addq(s, t64, a->ra, a->rd);
-        gen_storeq_reg(s, a->ra, a->rd, t64);
-        tcg_temp_free_i64(t64);
+        tcg_temp_free_i32(t1);
+        store_reg(s, a->ra, tl);
+        store_reg(s, a->rd, th);
         break;
     default:
         g_assert_not_reached();
-- 
2.17.1


