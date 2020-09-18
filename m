Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91889C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011CF21D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zM1ruSuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011CF21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLkP-00061o-4c
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHM-0000SD-Uy
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:40 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHK-00079p-Qe
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:40 -0400
Received: by mail-pl1-x641.google.com with SMTP id k13so3442835plk.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=16ObUsciA5sTLGBaYdN2/secK6wqo2MfYlYAt1+Qus8=;
 b=zM1ruSuIdrogJrevkujSv8/ZDVdBc3R1QH8euSWlZkwYgP+BpRujHrW7Tsy9x7hCrq
 9yqbTEex2JVNY/wjPDsN42NvVwJybXTXGu5BDJPPFrrboOKzXHsrd4SbseNnbmfpbOj5
 OWiz2vClFoBZzq3k+8WF5QZDZOtpmfmJVAASjeZQFLNvzlHZ5gommAhicCNrkhCTVPcG
 OZaz6iEW3xz3587KsBP0iDNcsrpVsBQVVjGcgH4qJD+O2Fpi11klN9jLN56WAuosgT/a
 m1MsMtkRRJg6xD4Av+foKYxR/84QyPvAXxlkglNvJPxSqpFRoG/1bndk+y/zz4sTCrQ0
 2ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=16ObUsciA5sTLGBaYdN2/secK6wqo2MfYlYAt1+Qus8=;
 b=WHixUKKPVWVoWyDt+trIPpZcfBN49Ulx+xzQ0gECoME5jEd0/xWw7h1T3L5jE3o7j+
 NENTb4CWbfa0osSVYR0b65GpzMwKlrd0mefn8D+zlvtkxkO4xoGg866oVvuFw3kiIPnB
 CDlTEF52IJWUL+C8+nFl8Jguz4UuOLzeUnw2vmHOVXEZ0Vo67EmqqKn02YWFN31z2rCY
 mXsVcdvsobdeLZjCNrT/N7eSV1H53Q36QMZrXuFywUEcgV21ck0BF4baY2W1s9WIhTDw
 TNtMNhAnMdb7SS7qYF1vmVlIYgUrpV2qJFvpevmiBV2GcGgWMCjnBDI4jJAWtmpVbAvD
 7AiA==
X-Gm-Message-State: AOAM53094E4Tn9HW+MKDs+5Gs/FLarf3X80VsRM3RYNDddpsGWvkB4GS
 LLjmcZYMqzXPhnyg7dfZx9j0/DJpcLld+g==
X-Google-Smtp-Source: ABdhPJwO2aE/m51QbsDYVg9CnfcN479jucGK15XXN2Ef1ONeAu0s5oCQFiy1bULzfM890rVK/7QLgg==
X-Received: by 2002:a17:902:8549:b029:d1:e603:af73 with SMTP id
 d9-20020a1709028549b02900d1e603af73mr15856813plo.60.1600454316848; 
 Fri, 18 Sep 2020 11:38:36 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 33/81] target/arm: Implement SVE2 WHILEGT, WHILEGE, WHILEHI,
 WHILEHS
Date: Fri, 18 Sep 2020 11:37:03 -0700
Message-Id: <20200918183751.2787647-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the existing sve_while (less-than) helper to sve_whilel
to make room for a new sve_whileg helper for greater-than.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use a new helper function to implement this.
---
 target/arm/helper-sve.h    |  3 +-
 target/arm/sve.decode      |  2 +-
 target/arm/sve_helper.c    | 38 +++++++++++++++++++++++++-
 target/arm/translate-sve.c | 56 ++++++++++++++++++++++++++++----------
 4 files changed, 82 insertions(+), 17 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 04b3ae3219..6b4ae8f98b 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -913,7 +913,8 @@ DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_3(sve_while, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
+DEF_HELPER_FLAGS_3(sve_whilel, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
+DEF_HELPER_FLAGS_3(sve_whileg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 
 DEF_HELPER_FLAGS_4(sve_subri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_subri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 5f76a95139..b7038f9f57 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -700,7 +700,7 @@ SINCDECP_z      00100101 .. 1010 d:1 u:1 10000 00 .... .....    @incdec2_pred
 CTERM           00100101 1 sf:1 1 rm:5 001000 rn:5 ne:1 0000
 
 # SVE integer compare scalar count and limit
-WHILE           00100101 esz:2 1 rm:5 000 sf:1 u:1 1 rn:5 eq:1 rd:4
+WHILE           00100101 esz:2 1 rm:5 000 sf:1 u:1 lt:1 rn:5 eq:1 rd:4
 
 ### SVE Integer Wide Immediate - Unpredicated Group
 
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 2a3dc76d87..0bb9d73cbf 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3746,7 +3746,7 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
     return sum;
 }
 
-uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
+uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
 {
     uintptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
     intptr_t esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
@@ -3772,6 +3772,42 @@ uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
     return predtest_ones(d, oprsz, esz_mask);
 }
 
+uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uintptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    intptr_t esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
+    uint64_t esz_mask = pred_esz_masks[esz];
+    ARMPredicateReg *d = vd;
+    intptr_t i, invcount, oprbits;
+    uint64_t bits;
+
+    if (count == 0) {
+        return do_zero(d, oprsz);
+    }
+
+    oprbits = oprsz * 8;
+    tcg_debug_assert(count <= oprbits);
+
+    bits = esz_mask;
+    if (oprbits & 63) {
+        bits &= MAKE_64BIT_MASK(0, oprbits & 63);
+    }
+
+    invcount = oprbits - count;
+    for (i = (oprsz - 1) / 8; i > invcount / 64; --i) {
+        d->p[i] = bits;
+        bits = esz_mask;
+    }
+
+    d->p[i] = bits & MAKE_64BIT_MASK(invcount & 63, 64);
+
+    while (--i >= 0) {
+        d->p[i] = 0;
+    }
+
+    return predtest_ones(d, oprsz, esz_mask);
+}
+
 /* Recursive reduction on a function;
  * C.f. the ARM ARM function ReducePredicated.
  *
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5091c0bc67..f1bc4c63e6 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3121,7 +3121,14 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     TCGv_ptr ptr;
     unsigned desc, vsz = vec_full_reg_size(s);
     TCGCond cond;
+    uint64_t maxval;
+    /* Note that GE/HS has a->eq == 0 and GT/HI has a->eq == 1. */
+    bool eq = a->eq == a->lt;
 
+    /* The greater-than conditions are all SVE2. */
+    if (!a->lt && !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
     if (!sve_access_check(s)) {
         return true;
     }
@@ -3144,22 +3151,42 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
      */
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
-    tcg_gen_sub_i64(t0, op1, op0);
+
+    if (a->lt) {
+        tcg_gen_sub_i64(t0, op1, op0);
+        if (a->u) {
+            maxval = a->sf ? UINT64_MAX : UINT32_MAX;
+            cond = eq ? TCG_COND_LEU : TCG_COND_LTU;
+        } else {
+            maxval = a->sf ? INT64_MAX : INT32_MAX;
+            cond = eq ? TCG_COND_LE : TCG_COND_LT;
+        }
+    } else {
+        tcg_gen_sub_i64(t0, op0, op1);
+        if (a->u) {
+            maxval = 0;
+            cond = eq ? TCG_COND_GEU : TCG_COND_GTU;
+        } else {
+            maxval = a->sf ? INT64_MIN : INT32_MIN;
+            cond = eq ? TCG_COND_GE : TCG_COND_GT;
+        }
+    }
 
     tmax = tcg_const_i64(vsz >> a->esz);
-    if (a->eq) {
+    if (eq) {
         /* Equality means one more iteration.  */
         tcg_gen_addi_i64(t0, t0, 1);
 
-        /* If op1 is max (un)signed integer (and the only time the addition
-         * above could overflow), then we produce an all-true predicate by
-         * setting the count to the vector length.  This is because the
-         * pseudocode is described as an increment + compare loop, and the
-         * max integer would always compare true.
+        /*
+         * For the less-than while, if op1 is maxval (and the only time
+         * the addition above could overflow), then we produce an all-true
+         * predicate by setting the count to the vector length.  This is
+         * because the pseudocode is described as an increment + compare
+         * loop, and the maximum integer would always compare true.
+         * Similarly, the greater-than while has the same issue with the
+         * minimum integer due to the decrement + compare loop.
          */
-        tcg_gen_movi_i64(t1, (a->sf
-                              ? (a->u ? UINT64_MAX : INT64_MAX)
-                              : (a->u ? UINT32_MAX : INT32_MAX)));
+        tcg_gen_movi_i64(t1, maxval);
         tcg_gen_movcond_i64(TCG_COND_EQ, t0, op1, t1, tmax, t0);
     }
 
@@ -3168,9 +3195,6 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     tcg_temp_free_i64(tmax);
 
     /* Set the count to zero if the condition is false.  */
-    cond = (a->u
-            ? (a->eq ? TCG_COND_LEU : TCG_COND_LTU)
-            : (a->eq ? TCG_COND_LE : TCG_COND_LT));
     tcg_gen_movi_i64(t1, 0);
     tcg_gen_movcond_i64(cond, t0, op0, op1, t0, t1);
     tcg_temp_free_i64(t1);
@@ -3190,7 +3214,11 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     ptr = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(ptr, cpu_env, pred_full_reg_offset(s, a->rd));
 
-    gen_helper_sve_while(t2, ptr, t2, t3);
+    if (a->lt) {
+        gen_helper_sve_whilel(t2, ptr, t2, t3);
+    } else {
+        gen_helper_sve_whileg(t2, ptr, t2, t3);
+    }
     do_pred_flags(t2);
 
     tcg_temp_free_ptr(ptr);
-- 
2.25.1


