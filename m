Received: from eggs.gnu.org ([209.51.188.92]:40510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXX-00011S-92
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXU-0000kz-Go
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:59 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXT-0000GB-FL
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:56 -0400
Received: by mail-pg1-x544.google.com with SMTP id j26so3592677pgl.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:36 -1000
Message-Id: <20190420073442.7488-33-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 32/38] target/arm: Vectorize USHL and SSHL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

These instructions shift left or right depending on the sign
of the input, and 7 bits are significant to the shift.  This
requires several masks and selects in addition to the actual
shifts to form the complete answer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  15 +-
 target/arm/translate.h     |   6 +
 target/arm/neon_helper.c   |  33 -----
 target/arm/translate-a64.c |  18 +--
 target/arm/translate.c     | 288 +++++++++++++++++++++++++++++++++++--
 target/arm/vec_helper.c    | 176 +++++++++++++++++++++++
 6 files changed, 470 insertions(+), 66 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3d90b5be66..1c0de661fb 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -292,14 +292,8 @@ DEF_HELPER_2(neon_abd_s16, i32, i32, i32)
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
@@ -686,6 +680,15 @@ DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, ptr)
 
+DEF_HELPER_FLAGS_4(gvec_sshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ushl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ushl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 912cc2a4a5..633668fa1b 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -244,6 +244,8 @@ extern const GVecGen3 bif_op;
 extern const GVecGen3 mla_op[4];
 extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
+extern const GVecGen3 sshl_op[4];
+extern const GVecGen3 ushl_op[4];
 extern const GVecGen2i ssra_op[4];
 extern const GVecGen2i usra_op[4];
 extern const GVecGen2i sri_op[4];
@@ -253,6 +255,10 @@ extern const GVecGen4 sqadd_op[4];
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
index 4259056723..c581ffb7d3 100644
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
index fd8921565e..c30f99c7cd 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -8845,9 +8845,9 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
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
@@ -11242,6 +11242,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
@@ -11357,16 +11361,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
index 911ad0bdab..1fd31228f7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5285,13 +5285,13 @@ static inline void gen_neon_shift_narrow(int size, TCGv_i32 var, TCGv_i32 shift,
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
@@ -6170,6 +6170,270 @@ const GVecGen3 cmtst_op[4] = {
       .vece = MO_64 },
 };
 
+void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 lval = tcg_temp_new_i32();
+    TCGv_i32 rval = tcg_temp_new_i32();
+    TCGv_i32 lsh = tcg_temp_new_i32();
+    TCGv_i32 rsh = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 max = tcg_const_i32(32);
+
+    /*
+     * Perform possibly out of range shifts, trusting that the operation
+     * does not trap.  Discard unused results after the fact.
+     */
+    tcg_gen_ext8s_i32(lsh, b);
+    tcg_gen_neg_i32(rsh, lsh);
+    tcg_gen_shl_i32(lval, a, lsh);
+    tcg_gen_shr_i32(rval, a, rsh);
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, lsh, max, lval, zero);
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, rsh, max, rval, d);
+
+    tcg_temp_free_i32(lval);
+    tcg_temp_free_i32(rval);
+    tcg_temp_free_i32(lsh);
+    tcg_temp_free_i32(rsh);
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(max);
+}
+
+void gen_ushl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 lval = tcg_temp_new_i64();
+    TCGv_i64 rval = tcg_temp_new_i64();
+    TCGv_i64 lsh = tcg_temp_new_i64();
+    TCGv_i64 rsh = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_const_i64(0);
+    TCGv_i64 max = tcg_const_i64(64);
+
+    /*
+     * Perform possibly out of range shifts, trusting that the operation
+     * does not trap.  Discard unused results after the fact.
+     */
+    tcg_gen_ext8s_i64(lsh, b);
+    tcg_gen_neg_i64(rsh, lsh);
+    tcg_gen_shl_i64(lval, a, lsh);
+    tcg_gen_shr_i64(rval, a, rsh);
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, lsh, max, lval, zero);
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, rsh, max, rval, d);
+
+    tcg_temp_free_i64(lval);
+    tcg_temp_free_i64(rval);
+    tcg_temp_free_i64(lsh);
+    tcg_temp_free_i64(rsh);
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(max);
+}
+
+static void gen_ushl_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec lval = tcg_temp_new_vec_matching(d);
+    TCGv_vec rval = tcg_temp_new_vec_matching(d);
+    TCGv_vec lsh = tcg_temp_new_vec_matching(d);
+    TCGv_vec rsh = tcg_temp_new_vec_matching(d);
+    TCGv_vec msk, max;
+
+    /*
+     * Since we don't have a sign-extend vector primitive, negate and mask.
+     * With the out-of-range check below, we'll select the correct answer.
+     */
+    tcg_gen_neg_vec(vece, rsh, b);
+    if (vece == MO_8) {
+        tcg_gen_mov_vec(lsh, b);
+    } else {
+        msk = tcg_temp_new_vec_matching(d);
+        tcg_gen_dupi_vec(vece, msk, 0xff);
+        tcg_gen_and_vec(vece, lsh, b, msk);
+        tcg_gen_and_vec(vece, rsh, rsh, msk);
+        tcg_temp_free_vec(msk);
+    }
+
+    /*
+     * Perform possibly out of range shifts, trusting that the operation
+     * does not trap.  Discard unused results after the fact.
+     */
+    tcg_gen_shlv_vec(vece, lval, a, lsh);
+    tcg_gen_shrv_vec(vece, rval, a, rsh);
+
+    max = tcg_temp_new_vec_matching(d);
+    tcg_gen_dupi_vec(vece, max, 8 << vece);
+    tcg_gen_cmp_vec(TCG_COND_LTU, vece, lsh, lsh, max);
+    tcg_gen_cmp_vec(TCG_COND_LTU, vece, rsh, rsh, max);
+    tcg_temp_free_vec(max);
+
+    tcg_gen_and_vec(vece, lval, lval, lsh);
+    tcg_gen_and_vec(vece, rval, rval, rsh);
+    tcg_gen_or_vec(vece, d, lval, rval);
+
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
+      .fno = gen_helper_gvec_ushl_s,
+      .opt_opc = ushl_list,
+      .vece = MO_32 },
+    { .fni8 = gen_ushl_i64,
+      .fniv = gen_ushl_vec,
+      .fno = gen_helper_gvec_ushl_d,
+      .opt_opc = ushl_list,
+      .vece = MO_64 },
+};
+
+void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 lval = tcg_temp_new_i32();
+    TCGv_i32 rval = tcg_temp_new_i32();
+    TCGv_i32 lsh = tcg_temp_new_i32();
+    TCGv_i32 rsh = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 max = tcg_const_i32(31);
+
+    /*
+     * Perform possibly out of range shifts, trusting that the operation
+     * does not trap.  Discard unused results after the fact.
+     */
+    tcg_gen_ext8s_i32(lsh, b);
+    tcg_gen_neg_i32(rsh, lsh);
+    tcg_gen_shl_i32(lval, a, lsh);
+    tcg_gen_umin_i32(rsh, rsh, max);
+    tcg_gen_sar_i32(rval, a, rsh);
+    tcg_gen_movcond_i32(TCG_COND_LEU, lval, lsh, max, lval, zero);
+    tcg_gen_movcond_i32(TCG_COND_LT, d, lsh, zero, rval, lval);
+
+    tcg_temp_free_i32(lval);
+    tcg_temp_free_i32(rval);
+    tcg_temp_free_i32(lsh);
+    tcg_temp_free_i32(rsh);
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(max);
+}
+
+void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 lval = tcg_temp_new_i64();
+    TCGv_i64 rval = tcg_temp_new_i64();
+    TCGv_i64 lsh = tcg_temp_new_i64();
+    TCGv_i64 rsh = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_const_i64(0);
+    TCGv_i64 max = tcg_const_i64(63);
+
+    /*
+     * Perform possibly out of range shifts, trusting that the operation
+     * does not trap.  Discard unused results after the fact.
+     */
+    tcg_gen_ext8s_i64(lsh, b);
+    tcg_gen_neg_i64(rsh, lsh);
+    tcg_gen_shl_i64(lval, a, lsh);
+    tcg_gen_umin_i64(rsh, rsh, max);
+    tcg_gen_sar_i64(rval, a, rsh);
+    tcg_gen_movcond_i64(TCG_COND_LEU, lval, lsh, max, lval, zero);
+    tcg_gen_movcond_i64(TCG_COND_LT, d, lsh, zero, rval, lval);
+
+    tcg_temp_free_i64(lval);
+    tcg_temp_free_i64(rval);
+    tcg_temp_free_i64(lsh);
+    tcg_temp_free_i64(rsh);
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(max);
+}
+
+static void gen_sshl_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec lval = tcg_temp_new_vec_matching(d);
+    TCGv_vec rval = tcg_temp_new_vec_matching(d);
+    TCGv_vec lsh = tcg_temp_new_vec_matching(d);
+    TCGv_vec rsh = tcg_temp_new_vec_matching(d);
+    TCGv_vec msk = tcg_temp_new_vec_matching(d);
+    TCGv_vec max = tcg_temp_new_vec_matching(d);
+
+    /*
+     * Since we don't have a sign-extend vector primitive, negate and mask.
+     * With the out-of-range check below, we'll select the correct answer.
+     */
+    tcg_gen_neg_vec(vece, rsh, b);
+    if (vece == MO_8) {
+        tcg_gen_mov_vec(lsh, b);
+    } else {
+        tcg_gen_dupi_vec(vece, msk, 0xff);
+        tcg_gen_and_vec(vece, lsh, b, msk);
+        tcg_gen_and_vec(vece, rsh, rsh, msk);
+    }
+
+    /* Bound rsh so out of bound right shift gets -1.  */
+    tcg_gen_dupi_vec(vece, max, (8 << vece) - 1);
+    tcg_gen_umin_vec(vece, rsh, rsh, max);
+
+    /* Select between left and right shift.  */
+    tcg_gen_dupi_vec(vece, msk, vece == MO_8 ? 0 : 0x80);
+    tcg_gen_cmp_vec(TCG_COND_LT, vece, msk, lsh, msk);
+
+    tcg_gen_shlv_vec(vece, lval, a, lsh);
+    tcg_gen_sarv_vec(vece, rval, a, rsh);
+
+    /* Select in-bound left shift.  */
+    tcg_gen_cmp_vec(TCG_COND_GT, vece, lsh, lsh, max);
+
+    /* Merge the selections above.  */
+    tcg_gen_andc_vec(vece, lval, lval, lsh);
+    if (vece == MO_8) {
+        tcg_gen_cmpsel_vec(vece, d, msk, rval, lval);
+    } else {
+        tcg_gen_cmpsel_vec(vece, d, msk, lval, rval);
+    }
+
+    tcg_temp_free_vec(lval);
+    tcg_temp_free_vec(rval);
+    tcg_temp_free_vec(lsh);
+    tcg_temp_free_vec(rsh);
+    tcg_temp_free_vec(msk);
+    tcg_temp_free_vec(max);
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
+      .fno = gen_helper_gvec_sshl_s,
+      .opt_opc = sshl_list,
+      .vece = MO_32 },
+    { .fni8 = gen_sshl_i64,
+      .fniv = gen_sshl_vec,
+      .fno = gen_helper_gvec_sshl_d,
+      .opt_opc = sshl_list,
+      .vece = MO_64 },
+};
+
 static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
                           TCGv_vec a, TCGv_vec b)
 {
@@ -6573,6 +6837,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                   vec_size, vec_size);
             }
             return 0;
+
+        case NEON_3R_VSHL:
+            tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
+                           u ? &ushl_op[size] : &sshl_op[size]);
+            return 0;
         }
 
         if (size == 3) {
@@ -6581,13 +6850,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
@@ -6622,7 +6884,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
         pairwise = 0;
         switch (op) {
-        case NEON_3R_VSHL:
         case NEON_3R_VQSHL:
         case NEON_3R_VRSHL:
         case NEON_3R_VQRSHL:
@@ -6702,9 +6963,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VHSUB:
             GEN_NEON_INTEGER_OP(hsub);
             break;
-        case NEON_3R_VSHL:
-            GEN_NEON_INTEGER_OP(shl);
-            break;
         case NEON_3R_VQSHL:
             GEN_NEON_INTEGER_OP_ENV(qshl);
             break;
@@ -7113,9 +7371,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
index dedef62403..9f8eee5611 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1046,3 +1046,179 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
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
+void HELPER(gvec_sshl_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        int8_t mm = m[i];   /* only 8 bits of shift are significant */
+        int32_t nn = n[i];
+        int32_t res = 0;
+        if (mm >= 0) {
+            if (mm < 32) {
+                res = nn << mm;
+            }
+        } else {
+            res = nn >> (mm > -32 ? -mm : 31);
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sshl_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        int8_t mm = m[i];   /* only 8 bits of shift are significant */
+        int64_t nn = n[i];
+        int64_t res = 0;
+        if (mm >= 0) {
+            if (mm < 64) {
+                res = nn << mm;
+            }
+        } else {
+            res = nn >> (mm > -64 ? -mm : 63);
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
+
+void HELPER(gvec_ushl_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        int8_t mm = m[i];   /* only 8 bits of shift are significant */
+        uint32_t nn = n[i];
+        uint32_t res = 0;
+        if (mm >= 0) {
+            if (mm < 32) {
+                res = nn << mm;
+            }
+        } else {
+            if (mm > -32) {
+                res = nn >> -mm;
+            }
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_ushl_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        int8_t mm = m[i];   /* only 8 bits of shift are significant */
+        uint64_t nn = n[i];
+        uint64_t res = 0;
+        if (mm >= 0) {
+            if (mm < 64) {
+                res = nn << mm;
+            }
+        } else {
+            if (mm > -64) {
+                res = nn >> -mm;
+            }
+        }
+        d[i] = res;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.17.1
