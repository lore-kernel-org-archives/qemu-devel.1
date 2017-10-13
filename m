Received: from eggs.gnu.org ([2001:4830:134:3::10]:44099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32se-0000e5-4c
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sc-0002LD-D4
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:11 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:45349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32sc-0002KX-4L
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:10 -0400
Received: by mail-wm0-x235.google.com with SMTP id q124so22584859wmb.0
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:32:10 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:29 +0100
Message-Id: <20171013162438.32458-22-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 21/30] target/arm/translate-a64: add FP16
 2-reg misc compare (zero)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

I re-use the existing handle_2misc_fcmp_zero handler and tweak it
slightly to deal with the half-precision case.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper-a64.c    | 39 +++++++++++++++++++++++++++++++++++++++
 target/arm/helper-a64.h    |  6 ++++++
 target/arm/translate-a64.c | 25 ++++++++++++++++++-------
 3 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index dd26675d5c..b62d77aec4 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -577,3 +577,42 @@ float16 HELPER(advsimd_mulxh)(float16 a, float16 b, void *fpstp)
     }
     return float16_mul(a, b, fpst);
 }
+
+
+/*
+ * Floating point comparisons produce an integer result.
+ * Softfloat routines return 0/1, which we convert to the 0/-1 Neon requires.
+ */
+uint32_t HELPER(advsimd_ceq_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    return -float16_eq_quiet(a, b, fpst);
+}
+
+uint32_t HELPER(advsimd_cge_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    return -float16_le(b, a, fpst);
+}
+
+uint32_t HELPER(advsimd_cgt_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    return -float16_lt(b, a, fpst);
+}
+
+uint32_t HELPER(advsimd_acge_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    float16 f0 = float16_abs(a);
+    float16 f1 = float16_abs(b);
+    return -float16_le(f1, f0, fpst);
+}
+
+/* uint32_t HELPER(advsimd_acgt_f16)(float16 a, float16 b, void *fpstp) */
+/* { */
+/*     float_status *fpst = fpstp; */
+/*     float16 f0 = float16_abs(a); */
+/*     float16 f1 = float16_abs(b); */
+/*     return -float16_lt(f1, f0, fpst); */
+/* } */
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 0f97eb607f..952869f43e 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -53,3 +53,9 @@ DEF_HELPER_3(advsimd_minh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_maxnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_minnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_mulxh, f16, f16, f16, ptr)
+
+DEF_HELPER_3(advsimd_ceq_f16, i32, f16, f16, ptr)
+DEF_HELPER_3(advsimd_cge_f16, i32, f16, f16, ptr)
+DEF_HELPER_3(advsimd_cgt_f16, i32, f16, f16, ptr)
+DEF_HELPER_3(advsimd_acge_f16, i32, f16, f16, ptr)
+DEF_HELPER_3(advsimd_acgt_f16, i32, f16, f16, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7792cea9f5..623b0b3fab 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7785,6 +7785,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         TCGv_i32 tcg_res = tcg_temp_new_i32();
         NeonGenTwoSingleOPFn *genfn;
         bool swap = false;
+        bool hp = (size == 1 ? true : false);
         int pass, maxpasses;
 
         switch (opcode) {
@@ -7792,7 +7793,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
             swap = true;
             /* fall through */
         case 0x2c: /* FCMGT (zero) */
-            genfn = gen_helper_neon_cgt_f32;
+            genfn = hp ? gen_helper_advsimd_cgt_f16 : gen_helper_neon_cgt_f32;
             break;
         case 0x2d: /* FCMEQ (zero) */
             genfn = gen_helper_neon_ceq_f32;
@@ -7814,7 +7815,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         }
 
         for (pass = 0; pass < maxpasses; pass++) {
-            read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
+            read_vec_element_i32(s, tcg_op, rn, pass, hp ? MO_16 : MO_32);
             if (swap) {
                 genfn(tcg_res, tcg_zero, tcg_op, fpst);
             } else {
@@ -7823,7 +7824,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
             if (is_scalar) {
                 write_fp_sreg(s, rd, tcg_res);
             } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
+                write_vec_element_i32(s, tcg_res, rd, pass, hp ? MO_16 : MO_32);
             }
         }
         tcg_temp_free_i32(tcg_res);
@@ -9809,6 +9810,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         case 0x2: /* FADD */
             gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
+        case 0x6: /* FMAX */
+            gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         case 0x23: /* FMUL */
             gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
@@ -10580,21 +10584,28 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
 static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
 {
     int fpop, opcode, a;
+    int rn, rd;
 
     if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
         unallocated_encoding(s);
         return;
     }
 
-    if (!fp_access_check(s)) {
-        return;
-    }
-
     opcode = extract32(insn, 12, 4);
     a = extract32(insn, 23, 1);
     fpop = deposit32(opcode, 5, 1, a);
 
+    rn = extract32(insn, 5, 5);
+    rd = extract32(insn, 0, 5);
+
     switch (fpop) {
+    case 0x2c: /* FCMGT (zero) */
+    case 0x2d: /* FCMEQ (zero) */
+    case 0x2e: /* FCMLT (zero) */
+    case 0x6c: /* FCMGE (zero) */
+    case 0x6d: /* FCMLE (zero) */
+        handle_2misc_fcmp_zero(s, fpop, true, 0, false, 1, rn, rd);
+        break;
     default:
         fprintf(stderr,"%s: insn %#04x fpop %#2x\n", __func__, insn, fpop);
         g_assert_not_reached();
-- 
2.14.1
