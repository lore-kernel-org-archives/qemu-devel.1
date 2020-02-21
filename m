Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD31C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9056206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7Erx8rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9056206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Fr-0004Us-VC
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582k-00087x-Rf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582g-0003To-Nv
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582g-0003Px-DU
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:30 -0500
Received: by mail-wr1-x42d.google.com with SMTP id u6so2021199wrt.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hN4UH3X9JNvxb1NnYu91jhQ7eMwZKKpYApAth0WQOEE=;
 b=l7Erx8rjnwzNmAmsvJit67E3GsN2UQR8MnRsFLmUPuVNe7x5C17IBMUmS9WMVEhOpq
 QsnN0XtmUFxBIFfrcZohxYZ2EO7tymqlTYFpqhboohJ6NdOEnMlUETgvnvA83YJQfU5W
 itoKw9eHDtevDwk7S6X5qXXiFGybZ+JSpj5xE3oVFw/wu9SG51rFTZ335IYpjjUkWygg
 lGlTHJwX8aCaeQ7XFnFlFhBDXtFVdoMiuC8u2/SdAn/kWtuPCVjhWJpmgj/6PQGRgF+A
 dFHoMSumZgeaWRZ9IMqnQBKPeolbUXUudhh3cV6NviVadrG4Gs2tK5MrYLqIim925Ixa
 +5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hN4UH3X9JNvxb1NnYu91jhQ7eMwZKKpYApAth0WQOEE=;
 b=QCxEld/xkcWVsapBt9pHFNQo+spIcmnuX3OpApdJWr5Lo4XFuSD49VIirqhtsnBfVY
 /Cp7iiPJl4RG8F8H3c6OBc/ERDGlF8w7sgjuYDLEN1UOcZ73dzz/9X0T3rhFR796mc9i
 hgjGl3KaharRHfrrH/J3YZ89IckE+8s1ZroDIBmj7i8JacmTafou2ln80w0pI2mZJIDN
 UOmhe5UQgfGixSHR+P1Vt/bjh1declLWCLHCu3KKjN8hFcQYlRIk9mzLwLRS89RFWvi3
 Euvuhag+GiUNvIISqR3zBoMAneE9MWkFcpB8uSfjRd7liZ9j0/VS2Xj1crIbhu0M53f3
 uuGw==
X-Gm-Message-State: APjAAAVtEMYC3KANlTiTVN8d/1sx0fHxjZwjnDLKFP4gxpMVALTTVJxb
 KEevYsecnC33COQPLY9JmbOzk1btUwqWzw==
X-Google-Smtp-Source: APXvYqycChn84kWGbUrnCi6dTrd8t7AUdOmtGB4GqJ6em5tWID+gMiSlv2MgwHtYFWlZip2T7gqByA==
X-Received: by 2002:a5d:560d:: with SMTP id l13mr22512898wrv.222.1582290508530; 
 Fri, 21 Feb 2020 05:08:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/52] target/arm: Vectorize USHL and SSHL
Date: Fri, 21 Feb 2020 13:07:26 +0000
Message-Id: <20200221130740.7583-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

These instructions shift left or right depending on the sign
of the input, and 7 bits are significant to the shift.  This
requires several masks and selects in addition to the actual
shifts to form the complete answer.

That said, the operation is still a small improvement even for
two 64-bit elements -- 13 vector operations instead of 2 * 7
integer operations.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200216214232.4230-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  11 +-
 target/arm/translate.h     |   6 +
 target/arm/neon_helper.c   |  33 ----
 target/arm/translate-a64.c |  18 +--
 target/arm/translate.c     | 299 +++++++++++++++++++++++++++++++++++--
 target/arm/vec_helper.c    |  88 +++++++++++
 6 files changed, 389 insertions(+), 66 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index aa3d8cd08fa..459a278b5c4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -303,14 +303,8 @@ DEF_HELPER_2(neon_abd_s16, i32, i32, i32)
 DEF_HELPER_2(neon_abd_u32, i32, i32, i32)
 DEF_HELPER_2(neon_abd_s32, i32, i32, i32)
 
-DEF_HELPER_2(neon_shl_u8, i32, i32, i32)
-DEF_HELPER_2(neon_shl_s8, i32, i32, i32)
 DEF_HELPER_2(neon_shl_u16, i32, i32, i32)
 DEF_HELPER_2(neon_shl_s16, i32, i32, i32)
-DEF_HELPER_2(neon_shl_u32, i32, i32, i32)
-DEF_HELPER_2(neon_shl_s32, i32, i32, i32)
-DEF_HELPER_2(neon_shl_u64, i64, i64, i64)
-DEF_HELPER_2(neon_shl_s64, i64, i64, i64)
 DEF_HELPER_2(neon_rshl_u8, i32, i32, i32)
 DEF_HELPER_2(neon_rshl_s8, i32, i32, i32)
 DEF_HELPER_2(neon_rshl_u16, i32, i32, i32)
@@ -697,6 +691,11 @@ DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, ptr)
 
+DEF_HELPER_FLAGS_4(gvec_sshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 5b167c416a2..d9ea0c99cc8 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -278,6 +278,8 @@ uint64_t vfp_expand_imm(int size, uint8_t imm8);
 extern const GVecGen3 mla_op[4];
 extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
+extern const GVecGen3 sshl_op[4];
+extern const GVecGen3 ushl_op[4];
 extern const GVecGen2i ssra_op[4];
 extern const GVecGen2i usra_op[4];
 extern const GVecGen2i sri_op[4];
@@ -287,6 +289,10 @@ extern const GVecGen4 sqadd_op[4];
 extern const GVecGen4 uqsub_op[4];
 extern const GVecGen4 sqsub_op[4];
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
+void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
+void gen_ushl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index 42590567236..c581ffb7d3c 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -615,24 +615,9 @@ NEON_VOP(abd_u32, neon_u32, 1)
     } else { \
         dest = src1 << tmp; \
     }} while (0)
-NEON_VOP(shl_u8, neon_u8, 4)
 NEON_VOP(shl_u16, neon_u16, 2)
-NEON_VOP(shl_u32, neon_u32, 1)
 #undef NEON_FN
 
-uint64_t HELPER(neon_shl_u64)(uint64_t val, uint64_t shiftop)
-{
-    int8_t shift = (int8_t)shiftop;
-    if (shift >= 64 || shift <= -64) {
-        val = 0;
-    } else if (shift < 0) {
-        val >>= -shift;
-    } else {
-        val <<= shift;
-    }
-    return val;
-}
-
 #define NEON_FN(dest, src1, src2) do { \
     int8_t tmp; \
     tmp = (int8_t)src2; \
@@ -645,27 +630,9 @@ uint64_t HELPER(neon_shl_u64)(uint64_t val, uint64_t shiftop)
     } else { \
         dest = src1 << tmp; \
     }} while (0)
-NEON_VOP(shl_s8, neon_s8, 4)
 NEON_VOP(shl_s16, neon_s16, 2)
-NEON_VOP(shl_s32, neon_s32, 1)
 #undef NEON_FN
 
-uint64_t HELPER(neon_shl_s64)(uint64_t valop, uint64_t shiftop)
-{
-    int8_t shift = (int8_t)shiftop;
-    int64_t val = valop;
-    if (shift >= 64) {
-        val = 0;
-    } else if (shift <= -64) {
-        val >>= 63;
-    } else if (shift < 0) {
-        val >>= -shift;
-    } else {
-        val <<= shift;
-    }
-    return val;
-}
-
 #define NEON_FN(dest, src1, src2) do { \
     int8_t tmp; \
     tmp = (int8_t)src2; \
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bd68588a710..9fbcf7d2f95 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -8744,9 +8744,9 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         break;
     case 0x8: /* SSHL, USHL */
         if (u) {
-            gen_helper_neon_shl_u64(tcg_rd, tcg_rn, tcg_rm);
+            gen_ushl_i64(tcg_rd, tcg_rn, tcg_rm);
         } else {
-            gen_helper_neon_shl_s64(tcg_rd, tcg_rn, tcg_rm);
+            gen_sshl_i64(tcg_rd, tcg_rn, tcg_rm);
         }
         break;
     case 0x9: /* SQSHL, UQSHL */
@@ -11141,6 +11141,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                        is_q ? 16 : 8, vec_full_reg_size(s),
                        (u ? uqsub_op : sqsub_op) + size);
         return;
+    case 0x08: /* SSHL, USHL */
+        gen_gvec_op3(s, is_q, rd, rn, rm,
+                     u ? &ushl_op[size] : &sshl_op[size]);
+        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11256,16 +11260,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x8: /* SSHL, USHL */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_shl_s8, gen_helper_neon_shl_u8 },
-                    { gen_helper_neon_shl_s16, gen_helper_neon_shl_u16 },
-                    { gen_helper_neon_shl_s32, gen_helper_neon_shl_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             case 0x9: /* SQSHL, UQSHL */
             {
                 static NeonGenTwoOpEnvFn * const fns[3][2] = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 93f028f256b..a96104d6b42 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3575,13 +3575,13 @@ static inline void gen_neon_shift_narrow(int size, TCGv_i32 var, TCGv_i32 shift,
         if (u) {
             switch (size) {
             case 1: gen_helper_neon_shl_u16(var, var, shift); break;
-            case 2: gen_helper_neon_shl_u32(var, var, shift); break;
+            case 2: gen_ushl_i32(var, var, shift); break;
             default: abort();
             }
         } else {
             switch (size) {
             case 1: gen_helper_neon_shl_s16(var, var, shift); break;
-            case 2: gen_helper_neon_shl_s32(var, var, shift); break;
+            case 2: gen_sshl_i32(var, var, shift); break;
             default: abort();
             }
         }
@@ -4384,6 +4384,280 @@ const GVecGen3 cmtst_op[4] = {
       .vece = MO_64 },
 };
 
+void gen_ushl_i32(TCGv_i32 dst, TCGv_i32 src, TCGv_i32 shift)
+{
+    TCGv_i32 lval = tcg_temp_new_i32();
+    TCGv_i32 rval = tcg_temp_new_i32();
+    TCGv_i32 lsh = tcg_temp_new_i32();
+    TCGv_i32 rsh = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 max = tcg_const_i32(32);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i32(lsh, shift);
+    tcg_gen_neg_i32(rsh, lsh);
+    tcg_gen_shl_i32(lval, src, lsh);
+    tcg_gen_shr_i32(rval, src, rsh);
+    tcg_gen_movcond_i32(TCG_COND_LTU, dst, lsh, max, lval, zero);
+    tcg_gen_movcond_i32(TCG_COND_LTU, dst, rsh, max, rval, dst);
+
+    tcg_temp_free_i32(lval);
+    tcg_temp_free_i32(rval);
+    tcg_temp_free_i32(lsh);
+    tcg_temp_free_i32(rsh);
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(max);
+}
+
+void gen_ushl_i64(TCGv_i64 dst, TCGv_i64 src, TCGv_i64 shift)
+{
+    TCGv_i64 lval = tcg_temp_new_i64();
+    TCGv_i64 rval = tcg_temp_new_i64();
+    TCGv_i64 lsh = tcg_temp_new_i64();
+    TCGv_i64 rsh = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_const_i64(0);
+    TCGv_i64 max = tcg_const_i64(64);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i64(lsh, shift);
+    tcg_gen_neg_i64(rsh, lsh);
+    tcg_gen_shl_i64(lval, src, lsh);
+    tcg_gen_shr_i64(rval, src, rsh);
+    tcg_gen_movcond_i64(TCG_COND_LTU, dst, lsh, max, lval, zero);
+    tcg_gen_movcond_i64(TCG_COND_LTU, dst, rsh, max, rval, dst);
+
+    tcg_temp_free_i64(lval);
+    tcg_temp_free_i64(rval);
+    tcg_temp_free_i64(lsh);
+    tcg_temp_free_i64(rsh);
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(max);
+}
+
+static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
+                         TCGv_vec src, TCGv_vec shift)
+{
+    TCGv_vec lval = tcg_temp_new_vec_matching(dst);
+    TCGv_vec rval = tcg_temp_new_vec_matching(dst);
+    TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
+    TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
+    TCGv_vec msk, max;
+
+    tcg_gen_neg_vec(vece, rsh, shift);
+    if (vece == MO_8) {
+        tcg_gen_mov_vec(lsh, shift);
+    } else {
+        msk = tcg_temp_new_vec_matching(dst);
+        tcg_gen_dupi_vec(vece, msk, 0xff);
+        tcg_gen_and_vec(vece, lsh, shift, msk);
+        tcg_gen_and_vec(vece, rsh, rsh, msk);
+        tcg_temp_free_vec(msk);
+    }
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_shlv_vec(vece, lval, src, lsh);
+    tcg_gen_shrv_vec(vece, rval, src, rsh);
+
+    max = tcg_temp_new_vec_matching(dst);
+    tcg_gen_dupi_vec(vece, max, 8 << vece);
+
+    /*
+     * The choice of LT (signed) and GEU (unsigned) are biased toward
+     * the instructions of the x86_64 host.  For MO_8, the whole byte
+     * is significant so we must use an unsigned compare; otherwise we
+     * have already masked to a byte and so a signed compare works.
+     * Other tcg hosts have a full set of comparisons and do not care.
+     */
+    if (vece == MO_8) {
+        tcg_gen_cmp_vec(TCG_COND_GEU, vece, lsh, lsh, max);
+        tcg_gen_cmp_vec(TCG_COND_GEU, vece, rsh, rsh, max);
+        tcg_gen_andc_vec(vece, lval, lval, lsh);
+        tcg_gen_andc_vec(vece, rval, rval, rsh);
+    } else {
+        tcg_gen_cmp_vec(TCG_COND_LT, vece, lsh, lsh, max);
+        tcg_gen_cmp_vec(TCG_COND_LT, vece, rsh, rsh, max);
+        tcg_gen_and_vec(vece, lval, lval, lsh);
+        tcg_gen_and_vec(vece, rval, rval, rsh);
+    }
+    tcg_gen_or_vec(vece, dst, lval, rval);
+
+    tcg_temp_free_vec(max);
+    tcg_temp_free_vec(lval);
+    tcg_temp_free_vec(rval);
+    tcg_temp_free_vec(lsh);
+    tcg_temp_free_vec(rsh);
+}
+
+static const TCGOpcode ushl_list[] = {
+    INDEX_op_neg_vec, INDEX_op_shlv_vec,
+    INDEX_op_shrv_vec, INDEX_op_cmp_vec, 0
+};
+
+const GVecGen3 ushl_op[4] = {
+    { .fniv = gen_ushl_vec,
+      .fno = gen_helper_gvec_ushl_b,
+      .opt_opc = ushl_list,
+      .vece = MO_8 },
+    { .fniv = gen_ushl_vec,
+      .fno = gen_helper_gvec_ushl_h,
+      .opt_opc = ushl_list,
+      .vece = MO_16 },
+    { .fni4 = gen_ushl_i32,
+      .fniv = gen_ushl_vec,
+      .opt_opc = ushl_list,
+      .vece = MO_32 },
+    { .fni8 = gen_ushl_i64,
+      .fniv = gen_ushl_vec,
+      .opt_opc = ushl_list,
+      .vece = MO_64 },
+};
+
+void gen_sshl_i32(TCGv_i32 dst, TCGv_i32 src, TCGv_i32 shift)
+{
+    TCGv_i32 lval = tcg_temp_new_i32();
+    TCGv_i32 rval = tcg_temp_new_i32();
+    TCGv_i32 lsh = tcg_temp_new_i32();
+    TCGv_i32 rsh = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 max = tcg_const_i32(31);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i32(lsh, shift);
+    tcg_gen_neg_i32(rsh, lsh);
+    tcg_gen_shl_i32(lval, src, lsh);
+    tcg_gen_umin_i32(rsh, rsh, max);
+    tcg_gen_sar_i32(rval, src, rsh);
+    tcg_gen_movcond_i32(TCG_COND_LEU, lval, lsh, max, lval, zero);
+    tcg_gen_movcond_i32(TCG_COND_LT, dst, lsh, zero, rval, lval);
+
+    tcg_temp_free_i32(lval);
+    tcg_temp_free_i32(rval);
+    tcg_temp_free_i32(lsh);
+    tcg_temp_free_i32(rsh);
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(max);
+}
+
+void gen_sshl_i64(TCGv_i64 dst, TCGv_i64 src, TCGv_i64 shift)
+{
+    TCGv_i64 lval = tcg_temp_new_i64();
+    TCGv_i64 rval = tcg_temp_new_i64();
+    TCGv_i64 lsh = tcg_temp_new_i64();
+    TCGv_i64 rsh = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_const_i64(0);
+    TCGv_i64 max = tcg_const_i64(63);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i64(lsh, shift);
+    tcg_gen_neg_i64(rsh, lsh);
+    tcg_gen_shl_i64(lval, src, lsh);
+    tcg_gen_umin_i64(rsh, rsh, max);
+    tcg_gen_sar_i64(rval, src, rsh);
+    tcg_gen_movcond_i64(TCG_COND_LEU, lval, lsh, max, lval, zero);
+    tcg_gen_movcond_i64(TCG_COND_LT, dst, lsh, zero, rval, lval);
+
+    tcg_temp_free_i64(lval);
+    tcg_temp_free_i64(rval);
+    tcg_temp_free_i64(lsh);
+    tcg_temp_free_i64(rsh);
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(max);
+}
+
+static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
+                         TCGv_vec src, TCGv_vec shift)
+{
+    TCGv_vec lval = tcg_temp_new_vec_matching(dst);
+    TCGv_vec rval = tcg_temp_new_vec_matching(dst);
+    TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
+    TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
+    TCGv_vec tmp = tcg_temp_new_vec_matching(dst);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_neg_vec(vece, rsh, shift);
+    if (vece == MO_8) {
+        tcg_gen_mov_vec(lsh, shift);
+    } else {
+        tcg_gen_dupi_vec(vece, tmp, 0xff);
+        tcg_gen_and_vec(vece, lsh, shift, tmp);
+        tcg_gen_and_vec(vece, rsh, rsh, tmp);
+    }
+
+    /* Bound rsh so out of bound right shift gets -1.  */
+    tcg_gen_dupi_vec(vece, tmp, (8 << vece) - 1);
+    tcg_gen_umin_vec(vece, rsh, rsh, tmp);
+    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, tmp);
+
+    tcg_gen_shlv_vec(vece, lval, src, lsh);
+    tcg_gen_sarv_vec(vece, rval, src, rsh);
+
+    /* Select in-bound left shift.  */
+    tcg_gen_andc_vec(vece, lval, lval, tmp);
+
+    /* Select between left and right shift.  */
+    if (vece == MO_8) {
+        tcg_gen_dupi_vec(vece, tmp, 0);
+        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, tmp, rval, lval);
+    } else {
+        tcg_gen_dupi_vec(vece, tmp, 0x80);
+        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, tmp, lval, rval);
+    }
+
+    tcg_temp_free_vec(lval);
+    tcg_temp_free_vec(rval);
+    tcg_temp_free_vec(lsh);
+    tcg_temp_free_vec(rsh);
+    tcg_temp_free_vec(tmp);
+}
+
+static const TCGOpcode sshl_list[] = {
+    INDEX_op_neg_vec, INDEX_op_umin_vec, INDEX_op_shlv_vec,
+    INDEX_op_sarv_vec, INDEX_op_cmp_vec, INDEX_op_cmpsel_vec, 0
+};
+
+const GVecGen3 sshl_op[4] = {
+    { .fniv = gen_sshl_vec,
+      .fno = gen_helper_gvec_sshl_b,
+      .opt_opc = sshl_list,
+      .vece = MO_8 },
+    { .fniv = gen_sshl_vec,
+      .fno = gen_helper_gvec_sshl_h,
+      .opt_opc = sshl_list,
+      .vece = MO_16 },
+    { .fni4 = gen_sshl_i32,
+      .fniv = gen_sshl_vec,
+      .opt_opc = sshl_list,
+      .vece = MO_32 },
+    { .fni8 = gen_sshl_i64,
+      .fniv = gen_sshl_vec,
+      .opt_opc = sshl_list,
+      .vece = MO_64 },
+};
+
 static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
                           TCGv_vec a, TCGv_vec b)
 {
@@ -4787,6 +5061,12 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                   vec_size, vec_size);
             }
             return 0;
+
+        case NEON_3R_VSHL:
+            /* Note the operation is vshl vd,vm,vn */
+            tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
+                           u ? &ushl_op[size] : &sshl_op[size]);
+            return 0;
         }
 
         if (size == 3) {
@@ -4795,13 +5075,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 neon_load_reg64(cpu_V0, rn + pass);
                 neon_load_reg64(cpu_V1, rm + pass);
                 switch (op) {
-                case NEON_3R_VSHL:
-                    if (u) {
-                        gen_helper_neon_shl_u64(cpu_V0, cpu_V1, cpu_V0);
-                    } else {
-                        gen_helper_neon_shl_s64(cpu_V0, cpu_V1, cpu_V0);
-                    }
-                    break;
                 case NEON_3R_VQSHL:
                     if (u) {
                         gen_helper_neon_qshl_u64(cpu_V0, cpu_env,
@@ -4836,7 +5109,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
         pairwise = 0;
         switch (op) {
-        case NEON_3R_VSHL:
         case NEON_3R_VQSHL:
         case NEON_3R_VRSHL:
         case NEON_3R_VQRSHL:
@@ -4916,9 +5188,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VHSUB:
             GEN_NEON_INTEGER_OP(hsub);
             break;
-        case NEON_3R_VSHL:
-            GEN_NEON_INTEGER_OP(shl);
-            break;
         case NEON_3R_VQSHL:
             GEN_NEON_INTEGER_OP_ENV(qshl);
             break;
@@ -5327,9 +5596,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             }
                         } else {
                             if (input_unsigned) {
-                                gen_helper_neon_shl_u64(cpu_V0, in, tmp64);
+                                gen_ushl_i64(cpu_V0, in, tmp64);
                             } else {
-                                gen_helper_neon_shl_s64(cpu_V0, in, tmp64);
+                                gen_sshl_i64(cpu_V0, in, tmp64);
                             }
                         }
                         tmp = tcg_temp_new_i32();
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index dedef62403a..fcb36639036 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1046,3 +1046,91 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
+
+void HELPER(gvec_sshl_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        int8_t mm = m[i];
+        int8_t nn = n[i];
+        int8_t res = 0;
+        if (mm >= 0) {
+            if (mm < 8) {
+                res = nn << mm;
+            }
+        } else {
+            res = nn >> (mm > -8 ? -mm : 7);
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sshl_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        int8_t mm = m[i];   /* only 8 bits of shift are significant */
+        int16_t nn = n[i];
+        int16_t res = 0;
+        if (mm >= 0) {
+            if (mm < 16) {
+                res = nn << mm;
+            }
+        } else {
+            res = nn >> (mm > -16 ? -mm : 15);
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_ushl_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        int8_t mm = m[i];
+        uint8_t nn = n[i];
+        uint8_t res = 0;
+        if (mm >= 0) {
+            if (mm < 8) {
+                res = nn << mm;
+            }
+        } else {
+            if (mm > -8) {
+                res = nn >> -mm;
+            }
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_ushl_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        int8_t mm = m[i];   /* only 8 bits of shift are significant */
+        uint16_t nn = n[i];
+        uint16_t res = 0;
+        if (mm >= 0) {
+            if (mm < 16) {
+                res = nn << mm;
+            }
+        } else {
+            if (mm > -16) {
+                res = nn >> -mm;
+            }
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.20.1


