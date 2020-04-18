Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDE8C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2701620776
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eukjP3f3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2701620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqQx-0008V0-7K
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqKH-0000vd-P1
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqKE-0004SE-2z
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:28:16 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:36725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqKC-0004GO-Qn
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:28:14 -0400
Received: by mail-pg1-x52d.google.com with SMTP id o185so2235672pgo.3
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xnS9Hp/zCDSod3J/YyHqIL7v+HoiOIhZGjDHIa10l0g=;
 b=eukjP3f35anKwUtiWJZPVQLyCp30Osunk+sh8H29+BWDIK3V3MSdQXGoiortMmp5cG
 gslm4onFNeDHP43jvo4hwXjsVn+gcIm2aM1jBh/OwuFeXtB4dBrCw+Icj3UvuLUcHJhB
 GwM3cA2VgAzwMDFuHOi/9RL1GRrneJ8pxeBNGV/85vTuGbqyaoT+puNEEMCYclJgUSP8
 3tfrSHv2W3vOsAMJvTRXOn9U6SCCmK8GVbI7Le4tTDykfvYmG4J6r8JJQe5QyE+M/fha
 25S+WmAG/gDxVEVosLlaeMERArDLMt/3MCHoRaMTrbL/2XgXKaIbQnNEWb+tbkPW2QU1
 +WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xnS9Hp/zCDSod3J/YyHqIL7v+HoiOIhZGjDHIa10l0g=;
 b=sSLb6KIMBqvoeS+ORmcL/87GwXNN/C7+MYlXJRrhN1rrLuM19JSt2nCcNFnfILFUy2
 zxcxnYnov0nCILrfmVvYpjkMmCDVEO73iXungtb06XRRqbxN/WOx3giwFB0HposuLla+
 9/hiFyNo77Oi2c0RwEAoBkc33gOl4tySnaRiO7v9ONPAnMlSv8aA6ED6+8TdP6uMDV/c
 QaczRxPODZN8ctyR6PX7gM5jE/zsRIrdTeo4EG5mAyWDpS4XOqTG3V4S9ZJu+xTLWPLf
 oKDpViy6lFlNQk47fhgDLiHmfjfeHITDi1PrFLfxNVIgt+mkSUhb0fYWRNrIlhw23xMQ
 0b7Q==
X-Gm-Message-State: AGi0Pua7f8nz1crJeoWD5wMPV+lxS99zolIP4sQtdbQXOPKBoa4Zzu0r
 MRCJKpp5oc9oHB0XssqOl81uSCcI9Xw=
X-Google-Smtp-Source: APiQypLoUgQXGmOlkFmKWnfTH1SwZqi5hAtP6Ax9edmqoUKazN6gQA5jCa2aCOzRBrm1KnMPGbIbuQ==
X-Received: by 2002:a62:be19:: with SMTP id l25mr8505572pff.304.1587227290202; 
 Sat, 18 Apr 2020 09:28:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y186sm10373017pfy.208.2020.04.18.09.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:28:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Vectorize integer comparison vs zero
Date: Sat, 18 Apr 2020 09:28:08 -0700
Message-Id: <20200418162808.4680-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These instructions are often used in glibc's string routines.
They were the final uses of the 32-bit at a time neon helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  27 ++--
 target/arm/translate.h     |   5 +
 target/arm/neon_helper.c   |  24 ----
 target/arm/translate-a64.c |  64 +++-------
 target/arm/translate.c     | 256 +++++++++++++++++++++++++++++++------
 target/arm/vec_helper.c    |  25 ++++
 6 files changed, 278 insertions(+), 123 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index f37b8670a5..5817626b20 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -275,19 +275,6 @@ DEF_HELPER_2(neon_hsub_u16, i32, i32, i32)
 DEF_HELPER_2(neon_hsub_s32, s32, s32, s32)
 DEF_HELPER_2(neon_hsub_u32, i32, i32, i32)
 
-DEF_HELPER_2(neon_cgt_u8, i32, i32, i32)
-DEF_HELPER_2(neon_cgt_s8, i32, i32, i32)
-DEF_HELPER_2(neon_cgt_u16, i32, i32, i32)
-DEF_HELPER_2(neon_cgt_s16, i32, i32, i32)
-DEF_HELPER_2(neon_cgt_u32, i32, i32, i32)
-DEF_HELPER_2(neon_cgt_s32, i32, i32, i32)
-DEF_HELPER_2(neon_cge_u8, i32, i32, i32)
-DEF_HELPER_2(neon_cge_s8, i32, i32, i32)
-DEF_HELPER_2(neon_cge_u16, i32, i32, i32)
-DEF_HELPER_2(neon_cge_s16, i32, i32, i32)
-DEF_HELPER_2(neon_cge_u32, i32, i32, i32)
-DEF_HELPER_2(neon_cge_s32, i32, i32, i32)
-
 DEF_HELPER_2(neon_pmin_u8, i32, i32, i32)
 DEF_HELPER_2(neon_pmin_s8, i32, i32, i32)
 DEF_HELPER_2(neon_pmin_u16, i32, i32, i32)
@@ -347,9 +334,6 @@ DEF_HELPER_2(neon_mul_u16, i32, i32, i32)
 DEF_HELPER_2(neon_tst_u8, i32, i32, i32)
 DEF_HELPER_2(neon_tst_u16, i32, i32, i32)
 DEF_HELPER_2(neon_tst_u32, i32, i32, i32)
-DEF_HELPER_2(neon_ceq_u8, i32, i32, i32)
-DEF_HELPER_2(neon_ceq_u16, i32, i32, i32)
-DEF_HELPER_2(neon_ceq_u32, i32, i32, i32)
 
 DEF_HELPER_1(neon_clz_u8, i32, i32)
 DEF_HELPER_1(neon_clz_u16, i32, i32)
@@ -686,6 +670,17 @@ DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, ptr)
 
+DEF_HELPER_FLAGS_3(gvec_ceq0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_clt0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_clt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cle0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cgt0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cge0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_sshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/translate.h b/target/arm/translate.h
index d9ea0c99cc..98b319f3f6 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -275,6 +275,11 @@ static inline void gen_swstep_exception(DisasContext *s, int isv, int ex)
 uint64_t vfp_expand_imm(int size, uint8_t imm8);
 
 /* Vector operations shared between ARM and AArch64.  */
+extern const GVecGen2 ceq0_op[4];
+extern const GVecGen2 clt0_op[4];
+extern const GVecGen2 cgt0_op[4];
+extern const GVecGen2 cle0_op[4];
+extern const GVecGen2 cge0_op[4];
 extern const GVecGen3 mla_op[4];
 extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index c7a8438b42..448be93fa1 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -562,24 +562,6 @@ uint32_t HELPER(neon_hsub_u32)(uint32_t src1, uint32_t src2)
     return dest;
 }
 
-#define NEON_FN(dest, src1, src2) dest = (src1 > src2) ? ~0 : 0
-NEON_VOP(cgt_s8, neon_s8, 4)
-NEON_VOP(cgt_u8, neon_u8, 4)
-NEON_VOP(cgt_s16, neon_s16, 2)
-NEON_VOP(cgt_u16, neon_u16, 2)
-NEON_VOP(cgt_s32, neon_s32, 1)
-NEON_VOP(cgt_u32, neon_u32, 1)
-#undef NEON_FN
-
-#define NEON_FN(dest, src1, src2) dest = (src1 >= src2) ? ~0 : 0
-NEON_VOP(cge_s8, neon_s8, 4)
-NEON_VOP(cge_u8, neon_u8, 4)
-NEON_VOP(cge_s16, neon_s16, 2)
-NEON_VOP(cge_u16, neon_u16, 2)
-NEON_VOP(cge_s32, neon_s32, 1)
-NEON_VOP(cge_u32, neon_u32, 1)
-#undef NEON_FN
-
 #define NEON_FN(dest, src1, src2) dest = (src1 < src2) ? src1 : src2
 NEON_POP(pmin_s8, neon_s8, 4)
 NEON_POP(pmin_u8, neon_u8, 4)
@@ -1135,12 +1117,6 @@ NEON_VOP(tst_u16, neon_u16, 2)
 NEON_VOP(tst_u32, neon_u32, 1)
 #undef NEON_FN
 
-#define NEON_FN(dest, src1, src2) dest = (src1 == src2) ? -1 : 0
-NEON_VOP(ceq_u8, neon_u8, 4)
-NEON_VOP(ceq_u16, neon_u16, 2)
-NEON_VOP(ceq_u32, neon_u32, 1)
-#undef NEON_FN
-
 /* Count Leading Sign/Zero Bits.  */
 static inline int do_clz8(uint8_t x)
 {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bf82a2e115..888a0b2cd0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -588,6 +588,14 @@ static void gen_gvec_fn4(DisasContext *s, bool is_q, int rd, int rn, int rm,
             is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
+/* Expand a 2-operand AdvSIMD vector operation using an op descriptor. */
+static void gen_gvec_op2(DisasContext *s, bool is_q, int rd,
+                         int rn, const GVecGen2 *gvec_op)
+{
+    tcg_gen_gvec_2(vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
+                   is_q ? 16 : 8, vec_full_reg_size(s), gvec_op);
+}
+
 /* Expand a 2-operand + immediate AdvSIMD vector operation using
  * an op descriptor.
  */
@@ -12373,6 +12381,15 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             return;
         }
         break;
+    case 0x8: /* CMGT, CMGE */
+        gen_gvec_op2(s, is_q, rd, rn, u ? &cge0_op[size] : &cgt0_op[size]);
+        return;
+    case 0x9: /* CMEQ, CMLE */
+        gen_gvec_op2(s, is_q, rd, rn, u ? &cle0_op[size] : &ceq0_op[size]);
+        return;
+    case 0xa: /* CMLT */
+        gen_gvec_op2(s, is_q, rd, rn, &clt0_op[size]);
+        return;
     case 0xb:
         if (u) { /* ABS, NEG */
             gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_neg, size);
@@ -12410,29 +12427,12 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         for (pass = 0; pass < (is_q ? 4 : 2); pass++) {
             TCGv_i32 tcg_op = tcg_temp_new_i32();
             TCGv_i32 tcg_res = tcg_temp_new_i32();
-            TCGCond cond;
 
             read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
 
             if (size == 2) {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
-                case 0xa: /* CMLT */
-                    /* 32 bit integer comparison against zero, result is
-                     * test ? (2^32 - 1) : 0. We implement via setcond(test)
-                     * and inverting.
-                     */
-                    cond = TCG_COND_LT;
-                do_cmop:
-                    tcg_gen_setcondi_i32(cond, tcg_res, tcg_op, 0);
-                    tcg_gen_neg_i32(tcg_res, tcg_res);
-                    break;
-                case 0x8: /* CMGT, CMGE */
-                    cond = u ? TCG_COND_GE : TCG_COND_GT;
-                    goto do_cmop;
-                case 0x9: /* CMEQ, CMLE */
-                    cond = u ? TCG_COND_LE : TCG_COND_EQ;
-                    goto do_cmop;
                 case 0x4: /* CLS */
                     if (u) {
                         tcg_gen_clzi_i32(tcg_res, tcg_op, 32);
@@ -12529,36 +12529,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     genfn(tcg_res, cpu_env, tcg_op);
                     break;
                 }
-                case 0x8: /* CMGT, CMGE */
-                case 0x9: /* CMEQ, CMLE */
-                case 0xa: /* CMLT */
-                {
-                    static NeonGenTwoOpFn * const fns[3][2] = {
-                        { gen_helper_neon_cgt_s8, gen_helper_neon_cgt_s16 },
-                        { gen_helper_neon_cge_s8, gen_helper_neon_cge_s16 },
-                        { gen_helper_neon_ceq_u8, gen_helper_neon_ceq_u16 },
-                    };
-                    NeonGenTwoOpFn *genfn;
-                    int comp;
-                    bool reverse;
-                    TCGv_i32 tcg_zero = tcg_const_i32(0);
-
-                    /* comp = index into [CMGT, CMGE, CMEQ, CMLE, CMLT] */
-                    comp = (opcode - 0x8) * 2 + u;
-                    /* ...but LE, LT are implemented as reverse GE, GT */
-                    reverse = (comp > 2);
-                    if (reverse) {
-                        comp = 4 - comp;
-                    }
-                    genfn = fns[comp][size];
-                    if (reverse) {
-                        genfn(tcg_res, tcg_zero, tcg_op);
-                    } else {
-                        genfn(tcg_res, tcg_op, tcg_zero);
-                    }
-                    tcg_temp_free_i32(tcg_zero);
-                    break;
-                }
                 case 0x4: /* CLS, CLZ */
                     if (u) {
                         if (size == 0) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index af4d3ff4c9..a96899549b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3917,6 +3917,205 @@ static int do_v81_helper(DisasContext *s, gen_helper_gvec_3_ptr *fn,
     return 1;
 }
 
+static void gen_ceq0_i32(TCGv_i32 d, TCGv_i32 a)
+{
+    tcg_gen_setcondi_i32(TCG_COND_EQ, d, a, 0);
+    tcg_gen_neg_i32(d, d);
+}
+
+static void gen_ceq0_i64(TCGv_i64 d, TCGv_i64 a)
+{
+    tcg_gen_setcondi_i64(TCG_COND_EQ, d, a, 0);
+    tcg_gen_neg_i64(d, d);
+}
+
+static void gen_ceq0_vec(unsigned vece, TCGv_vec d, TCGv_vec a)
+{
+    TCGv_vec zero = tcg_const_zeros_vec_matching(d);
+    tcg_gen_cmp_vec(TCG_COND_EQ, vece, d, a, zero);
+    tcg_temp_free_vec(zero);
+}
+
+static const TCGOpcode vecop_list_cmp[] = {
+    INDEX_op_cmp_vec, 0
+};
+
+const GVecGen2 ceq0_op[4] = {
+    { .fno = gen_helper_gvec_ceq0_b,
+      .fniv = gen_ceq0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_8 },
+    { .fno = gen_helper_gvec_ceq0_h,
+      .fniv = gen_ceq0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_16 },
+    { .fni4 = gen_ceq0_i32,
+      .fniv = gen_ceq0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_32 },
+    { .fni8 = gen_ceq0_i64,
+      .fniv = gen_ceq0_vec,
+      .opt_opc = vecop_list_cmp,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .vece = MO_64 },
+};
+
+static void gen_cle0_i32(TCGv_i32 d, TCGv_i32 a)
+{
+    tcg_gen_setcondi_i32(TCG_COND_LE, d, a, 0);
+    tcg_gen_neg_i32(d, d);
+}
+
+static void gen_cle0_i64(TCGv_i64 d, TCGv_i64 a)
+{
+    tcg_gen_setcondi_i64(TCG_COND_LE, d, a, 0);
+    tcg_gen_neg_i64(d, d);
+}
+
+static void gen_cle0_vec(unsigned vece, TCGv_vec d, TCGv_vec a)
+{
+    TCGv_vec zero = tcg_const_zeros_vec_matching(d);
+    tcg_gen_cmp_vec(TCG_COND_LE, vece, d, a, zero);
+    tcg_temp_free_vec(zero);
+}
+
+const GVecGen2 cle0_op[4] = {
+    { .fno = gen_helper_gvec_cle0_b,
+      .fniv = gen_cle0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_8 },
+    { .fno = gen_helper_gvec_cle0_h,
+      .fniv = gen_cle0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_16 },
+    { .fni4 = gen_cle0_i32,
+      .fniv = gen_cle0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_32 },
+    { .fni8 = gen_cle0_i64,
+      .fniv = gen_cle0_vec,
+      .opt_opc = vecop_list_cmp,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .vece = MO_64 },
+};
+
+static void gen_cge0_i32(TCGv_i32 d, TCGv_i32 a)
+{
+    tcg_gen_setcondi_i32(TCG_COND_GE, d, a, 0);
+    tcg_gen_neg_i32(d, d);
+}
+
+static void gen_cge0_i64(TCGv_i64 d, TCGv_i64 a)
+{
+    tcg_gen_setcondi_i64(TCG_COND_GE, d, a, 0);
+    tcg_gen_neg_i64(d, d);
+}
+
+static void gen_cge0_vec(unsigned vece, TCGv_vec d, TCGv_vec a)
+{
+    TCGv_vec zero = tcg_const_zeros_vec_matching(d);
+    tcg_gen_cmp_vec(TCG_COND_GE, vece, d, a, zero);
+    tcg_temp_free_vec(zero);
+}
+
+const GVecGen2 cge0_op[4] = {
+    { .fno = gen_helper_gvec_cge0_b,
+      .fniv = gen_cge0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_8 },
+    { .fno = gen_helper_gvec_cge0_h,
+      .fniv = gen_cge0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_16 },
+    { .fni4 = gen_cge0_i32,
+      .fniv = gen_cge0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_32 },
+    { .fni8 = gen_cge0_i64,
+      .fniv = gen_cge0_vec,
+      .opt_opc = vecop_list_cmp,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .vece = MO_64 },
+};
+
+static void gen_clt0_i32(TCGv_i32 d, TCGv_i32 a)
+{
+    tcg_gen_setcondi_i32(TCG_COND_LT, d, a, 0);
+    tcg_gen_neg_i32(d, d);
+}
+
+static void gen_clt0_i64(TCGv_i64 d, TCGv_i64 a)
+{
+    tcg_gen_setcondi_i64(TCG_COND_LT, d, a, 0);
+    tcg_gen_neg_i64(d, d);
+}
+
+static void gen_clt0_vec(unsigned vece, TCGv_vec d, TCGv_vec a)
+{
+    TCGv_vec zero = tcg_const_zeros_vec_matching(d);
+    tcg_gen_cmp_vec(TCG_COND_LT, vece, d, a, zero);
+    tcg_temp_free_vec(zero);
+}
+
+const GVecGen2 clt0_op[4] = {
+    { .fno = gen_helper_gvec_clt0_b,
+      .fniv = gen_clt0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_8 },
+    { .fno = gen_helper_gvec_clt0_h,
+      .fniv = gen_clt0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_16 },
+    { .fni4 = gen_clt0_i32,
+      .fniv = gen_clt0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_32 },
+    { .fni8 = gen_clt0_i64,
+      .fniv = gen_clt0_vec,
+      .opt_opc = vecop_list_cmp,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .vece = MO_64 },
+};
+
+static void gen_cgt0_i32(TCGv_i32 d, TCGv_i32 a)
+{
+    tcg_gen_setcondi_i32(TCG_COND_GT, d, a, 0);
+    tcg_gen_neg_i32(d, d);
+}
+
+static void gen_cgt0_i64(TCGv_i64 d, TCGv_i64 a)
+{
+    tcg_gen_setcondi_i64(TCG_COND_GT, d, a, 0);
+    tcg_gen_neg_i64(d, d);
+}
+
+static void gen_cgt0_vec(unsigned vece, TCGv_vec d, TCGv_vec a)
+{
+    TCGv_vec zero = tcg_const_zeros_vec_matching(d);
+    tcg_gen_cmp_vec(TCG_COND_GT, vece, d, a, zero);
+    tcg_temp_free_vec(zero);
+}
+
+const GVecGen2 cgt0_op[4] = {
+    { .fno = gen_helper_gvec_cgt0_b,
+      .fniv = gen_cgt0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_8 },
+    { .fno = gen_helper_gvec_cgt0_h,
+      .fniv = gen_cgt0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_16 },
+    { .fni4 = gen_cgt0_i32,
+      .fniv = gen_cgt0_vec,
+      .opt_opc = vecop_list_cmp,
+      .vece = MO_32 },
+    { .fni8 = gen_cgt0_i64,
+      .fniv = gen_cgt0_vec,
+      .opt_opc = vecop_list_cmp,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .vece = MO_64 },
+};
+
 static void gen_ssra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
     tcg_gen_vec_sar8i_i64(a, a, shift);
@@ -6484,6 +6683,27 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     tcg_gen_gvec_abs(size, rd_ofs, rm_ofs, vec_size, vec_size);
                     break;
 
+                case NEON_2RM_VCEQ0:
+                    tcg_gen_gvec_2(rd_ofs, rm_ofs, vec_size,
+                                   vec_size, &ceq0_op[size]);
+                    break;
+                case NEON_2RM_VCGT0:
+                    tcg_gen_gvec_2(rd_ofs, rm_ofs, vec_size,
+                                   vec_size, &cgt0_op[size]);
+                    break;
+                case NEON_2RM_VCLE0:
+                    tcg_gen_gvec_2(rd_ofs, rm_ofs, vec_size,
+                                   vec_size, &cle0_op[size]);
+                    break;
+                case NEON_2RM_VCGE0:
+                    tcg_gen_gvec_2(rd_ofs, rm_ofs, vec_size,
+                                   vec_size, &cge0_op[size]);
+                    break;
+                case NEON_2RM_VCLT0:
+                    tcg_gen_gvec_2(rd_ofs, rm_ofs, vec_size,
+                                   vec_size, &clt0_op[size]);
+                    break;
+
                 default:
                 elementwise:
                     for (pass = 0; pass < (q ? 4 : 2); pass++) {
@@ -6546,42 +6766,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             default: abort();
                             }
                             break;
-                        case NEON_2RM_VCGT0: case NEON_2RM_VCLE0:
-                            tmp2 = tcg_const_i32(0);
-                            switch(size) {
-                            case 0: gen_helper_neon_cgt_s8(tmp, tmp, tmp2); break;
-                            case 1: gen_helper_neon_cgt_s16(tmp, tmp, tmp2); break;
-                            case 2: gen_helper_neon_cgt_s32(tmp, tmp, tmp2); break;
-                            default: abort();
-                            }
-                            tcg_temp_free_i32(tmp2);
-                            if (op == NEON_2RM_VCLE0) {
-                                tcg_gen_not_i32(tmp, tmp);
-                            }
-                            break;
-                        case NEON_2RM_VCGE0: case NEON_2RM_VCLT0:
-                            tmp2 = tcg_const_i32(0);
-                            switch(size) {
-                            case 0: gen_helper_neon_cge_s8(tmp, tmp, tmp2); break;
-                            case 1: gen_helper_neon_cge_s16(tmp, tmp, tmp2); break;
-                            case 2: gen_helper_neon_cge_s32(tmp, tmp, tmp2); break;
-                            default: abort();
-                            }
-                            tcg_temp_free_i32(tmp2);
-                            if (op == NEON_2RM_VCLT0) {
-                                tcg_gen_not_i32(tmp, tmp);
-                            }
-                            break;
-                        case NEON_2RM_VCEQ0:
-                            tmp2 = tcg_const_i32(0);
-                            switch(size) {
-                            case 0: gen_helper_neon_ceq_u8(tmp, tmp, tmp2); break;
-                            case 1: gen_helper_neon_ceq_u16(tmp, tmp, tmp2); break;
-                            case 2: gen_helper_neon_ceq_u32(tmp, tmp, tmp2); break;
-                            default: abort();
-                            }
-                            tcg_temp_free_i32(tmp2);
-                            break;
                         case NEON_2RM_VCGT0_F:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 8017bd88c4..3d534188a8 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1257,3 +1257,28 @@ void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
     }
 }
 #endif
+
+#define DO_CMP0(NAME, TYPE, OP)                         \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
+{                                                       \
+    intptr_t i, opr_sz = simd_oprsz(desc);              \
+    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {        \
+        TYPE nn = *(TYPE *)(vn + i);                    \
+        *(TYPE *)(vd + i) = -(nn OP 0);                 \
+    }                                                   \
+    clear_tail(vd, opr_sz, simd_maxsz(desc));           \
+}
+
+DO_CMP0(gvec_ceq0_b, int8_t, ==)
+DO_CMP0(gvec_clt0_b, int8_t, <)
+DO_CMP0(gvec_cle0_b, int8_t, <=)
+DO_CMP0(gvec_cgt0_b, int8_t, >)
+DO_CMP0(gvec_cge0_b, int8_t, >=)
+
+DO_CMP0(gvec_ceq0_h, int16_t, ==)
+DO_CMP0(gvec_clt0_h, int16_t, <)
+DO_CMP0(gvec_cle0_h, int16_t, <=)
+DO_CMP0(gvec_cgt0_h, int16_t, >)
+DO_CMP0(gvec_cge0_h, int16_t, >=)
+
+#undef DO_CMP0
-- 
2.20.1


