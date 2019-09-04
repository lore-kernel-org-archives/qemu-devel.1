Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2746EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14FF206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTUNQP7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14FF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5b6Q-0002PM-Lx
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azq-0004Cy-4H
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azn-00029Y-QE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:13 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5azn-00028h-Gu
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:11 -0400
Received: by mail-pf1-x441.google.com with SMTP id x127so1219540pfb.7
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mUfMuu94nY9iTVUmT2HpXRX8/pvEI2tD109hkQpzr/w=;
 b=eTUNQP7nuw/1zXzNDy5hZ1YIGSvXVg8rujyUAG00PzwjJ3vzlL7jDdJeI9pE4q8dbh
 wCNZOn50+lnBnX1aXdMHrXtVdoIvy3v8rOoJMcLiOBBQoYT3WU+o3uwmMiw5h/NVi4/b
 IPtTBerwL7MkgFVN+BXAfrgO1Jmz8M8R04s9DcJOyhG8ReWUxe2pJu0nDa87qMlwHm5n
 weIQ9aat7rahADviAxFqNP9GC7LQ/7Fp7tCdbF7E/jQjvwkMyxUVp62VdQivWetcc3zq
 KCGMz6pYXRlJOtiFh9LxatENMrljJVVu03FfFAbR8uDP37+fzTlJeooBq1UwEtcjWvLB
 318A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mUfMuu94nY9iTVUmT2HpXRX8/pvEI2tD109hkQpzr/w=;
 b=a58ElbmzxoEtb9O84NiRtz86fpcVKym9kotkCORgz4ZylfPPI78nDByHLDCHj0liaV
 dOQwiCuAny0MyMcZZQ+ILoJe5ZP8u2wQqJ7JIdr0p6B1anCjcJkx/FnV8ft+mLoOmBEs
 x1PJcPf4HEkuG0/P4yTP7W9P9U4hma16xisKvT3Wyux6pq1mbZSuZcU7zccQcM6NhUpl
 /vTbRP9zqmK1Q+LX4RrSzi9JiuPuQeYSqdnHHCWwzhVyDYDz66pEmqq/j69z1mtLZ6cp
 nmpnIyxtIOwVD21XqfsUkg9Yp8GzWbnyn7AMnSw7o+WXncJyUm63TGkOpRetkEbq4auf
 J1RQ==
X-Gm-Message-State: APjAAAVYHRi64Txrs3fcPnHhr/RviW5ez1ttKsQJe4mCQTyaS2cs5FlT
 Mtjm1k4U7/EnrT0rPaf4kGxGJHwwq0o=
X-Google-Smtp-Source: APXvYqySPakiBWbCu98zVf96FdYT6ybGHkVYoAjArSLBAeZk+1xF+mN/Z72wXUk4SxwtN7Uh3XIXEA==
X-Received: by 2002:a17:90a:db0e:: with SMTP id
 g14mr4882317pjv.54.1567625469925; 
 Wed, 04 Sep 2019 12:31:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:29:57 -0700
Message-Id: <20190904193059.26202-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v4 07/69] target/arm: Simplify UMAAL
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
the intermediate promotion to i64 and use tcg_gen_mulu2_i32
and tcg_gen_add2_i32.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9bcf1e0964..8d70f15a4f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7346,21 +7346,6 @@ static void gen_storeq_reg(DisasContext *s, int rlow, int rhigh, TCGv_i64 val)
     store_reg(s, rhigh, tmp);
 }
 
-/* load a 32-bit value from a register and perform a 64-bit accumulate.  */
-static void gen_addq_lo(DisasContext *s, TCGv_i64 val, int rlow)
-{
-    TCGv_i64 tmp;
-    TCGv_i32 tmp2;
-
-    /* Load value and extend to 64 bits.  */
-    tmp = tcg_temp_new_i64();
-    tmp2 = load_reg(s, rlow);
-    tcg_gen_extu_i32_i64(tmp, tmp2);
-    tcg_temp_free_i32(tmp2);
-    tcg_gen_add_i64(val, val, tmp);
-    tcg_temp_free_i64(tmp);
-}
-
 /* load and add a 64-bit value from a register pair.  */
 static void gen_addq(DisasContext *s, TCGv_i64 val, int rlow, int rhigh)
 {
@@ -8119,8 +8104,7 @@ static bool trans_SMLAL(DisasContext *s, arg_SMLAL *a)
 
 static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
 {
-    TCGv_i32 t0, t1;
-    TCGv_i64 t64;
+    TCGv_i32 t0, t1, t2, zero;
 
     if (s->thumb
         ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
@@ -8130,11 +8114,17 @@ static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
 
     t0 = load_reg(s, a->rm);
     t1 = load_reg(s, a->rn);
-    t64 = gen_mulu_i64_i32(t0, t1);
-    gen_addq_lo(s, t64, a->ra);
-    gen_addq_lo(s, t64, a->rd);
-    gen_storeq_reg(s, a->ra, a->rd, t64);
-    tcg_temp_free_i64(t64);
+    tcg_gen_mulu2_i32(t0, t1, t0, t1);
+    zero = tcg_const_i32(0);
+    t2 = load_reg(s, a->ra);
+    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
+    tcg_temp_free_i32(t2);
+    t2 = load_reg(s, a->rd);
+    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(zero);
+    store_reg(s, a->ra, t0);
+    store_reg(s, a->rd, t1);
     return true;
 }
 
-- 
2.17.1


