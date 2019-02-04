Received: from eggs.gnu.org ([209.51.188.92]:43323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqWwb-00017n-MU
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqWn2-0002gf-3o
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:27:29 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqWmy-0002cu-2t
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:27:26 -0500
Received: by mail-wr1-x444.google.com with SMTP id p4so12996237wrt.7
	for <qemu-devel@nongnu.org>; Sun, 03 Feb 2019 21:27:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 05:27:12 +0000
Message-Id: <20190204052712.30833-4-richard.henderson@linaro.org>
In-Reply-To: <20190204052712.30833-1-richard.henderson@linaro.org>
References: <20190204052712.30833-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 10 +++++
 target/arm/helper.h        |  2 +
 target/arm/cpu.c           |  1 +
 target/arm/cpu64.c         |  2 +
 target/arm/op_helper.c     | 91 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 26 +++++++++++
 target/arm/translate.c     | 15 +++++++
 7 files changed, 147 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a68bcc9fed..d2c2e2b0cf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3209,6 +3209,11 @@ static inline bool isar_feature_aa32_vcma(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar5, ID_ISAR5, VCMA) != 0;
 }
 
+static inline bool isar_feature_aa32_jscvt(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, JSCVT) != 0;
+}
+
 static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->id_isar6, ID_ISAR6, DP) != 0;
@@ -3287,6 +3292,11 @@ static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, DP) != 0;
 }
 
+static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
+}
+
 static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 53a38188c6..6998f7e8d5 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -218,6 +218,8 @@ DEF_HELPER_FLAGS_2(rintd_exact, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(rints, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rintd, TCG_CALL_NO_RWG, f64, f64, ptr)
 
+DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
+
 /* neon_helper.c */
 DEF_HELPER_FLAGS_3(neon_qadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(neon_qadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3874dc9875..2eb2ce6c8c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1995,6 +1995,7 @@ static void arm_max_initfn(Object *obj)
             cpu->isar.id_isar5 = t;
 
             t = cpu->isar.id_isar6;
+            t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
             cpu->isar.id_isar6 = t;
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 7107ec8d7e..43d8ff047c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -311,6 +311,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
         t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
@@ -340,6 +341,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_isar5 = u;
 
         u = cpu->isar.id_isar6;
+        u = FIELD_DP32(u, ID_ISAR6, JSCVT, 1);
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
         cpu->isar.id_isar6 = u;
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index c998eadfaa..a7259a7194 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -24,6 +24,7 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "fpu/softfloat.h"
 
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
@@ -1376,3 +1377,93 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
         return ((uint32_t)x >> shift) | (x << (32 - shift));
     }
 }
+
+/*
+ * Implement float64 to int32_t conversion without saturation;
+ * the result is supplied modulo 2^32.
+ */
+uint64_t HELPER(fjcvtzs)(float64 value, void *vstatus)
+{
+    float_status *status = vstatus;
+    uint32_t result, exp, sign;
+    uint64_t frac;
+    uint32_t inexact; /* !Z */
+
+    sign = extract64(value, 63, 1);
+    exp = extract64(value, 52, 11);
+    frac = extract64(value, 0, 52);
+
+    if (exp == 0) {
+        /* While not inexact for IEEE FP, -0.0 is inexact for JavaScript.  */
+        inexact = sign;
+        result = 0;
+        if (frac != 0) {
+            if (status->flush_inputs_to_zero) {
+                float_raise(float_flag_input_denormal, status);
+            } else {
+                float_raise(float_flag_inexact, status);
+                inexact = 1;
+            }
+        }
+    } else if (exp == 0x7ff) {
+        if (frac == 0) {
+            /* Infinity.  */
+            result = 0;
+        } else {
+            /* NaN */
+            result = INT32_MAX;
+        }
+        /* This operation raises Invalid for both NaN and overflow (Inf).  */
+        float_raise(float_flag_invalid, status);
+        inexact = 1;
+    } else {
+        int shift, true_exp;
+
+        true_exp = exp - 1023;
+        shift = 52 - true_exp;
+
+        /* Restore implicit bit.  */
+        frac |= 1ull << 52;
+
+        /* Shift the fraction into place.  */
+        if (shift <= -64) {
+            /*
+             * The number is so large the fraction is shifted out entirely.
+             * The result mod 2^32 is 0 and will match the overflow case.
+             */
+            inexact = 1;
+            frac = 0;
+        } else if (shift <= 0) {
+            /* The number is so large we must shift the fraction left.  */
+            inexact = 1;
+            frac <<= -shift;
+        } else if (shift < 64) {
+            /* Normal case -- shift right and notice if bits shift out.  */
+            inexact = (frac << (64 - shift)) != 0;
+            frac >>= shift;
+        } else {
+            /* The number is so small the fraction is shifted out entirely.  */
+            inexact = 1;
+            frac = 0;
+        }
+
+        /* Notice overflow or inexact exceptions.  */
+        if (true_exp > 31
+            || frac > (sign ? 0x80000000ull : 0x7fffffff)) {
+            /* Overflow, for which this operation raises invalid.  */
+            float_raise(float_flag_invalid, status);
+            inexact = 1;
+        } else if (inexact) {
+            float_raise(float_flag_inexact, status);
+        }
+
+        /* Produce the result mod 2^32.  */
+        if (sign) {
+            frac = -frac;
+        }
+        result = frac;
+    }
+
+    /* Pack the result and the env->ZF representation of Z together.  */
+    return deposit64(result, 32, 32, inexact);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 90298ac562..49289bf1d8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6458,6 +6458,24 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
     }
 }
 
+static void handle_fjcvtzs(DisasContext *s, int rd, int rn)
+{
+    TCGv_i64 t = read_fp_dreg(s, rn);
+    TCGv_ptr fpstatus = get_fpstatus_ptr(false);
+
+    gen_helper_fjcvtzs(t, t, fpstatus);
+
+    tcg_temp_free_ptr(fpstatus);
+
+    tcg_gen_ext32u_i64(cpu_reg(s, rd), t);
+    tcg_gen_extrh_i64_i32(cpu_ZF, t);
+    tcg_gen_movi_i32(cpu_CF, 0);
+    tcg_gen_movi_i32(cpu_NF, 0);
+    tcg_gen_movi_i32(cpu_VF, 0);
+
+    tcg_temp_free_i64(t);
+}
+
 /* Floating point <-> integer conversions
  *   31   30  29 28       24 23  22  21 20   19 18 16 15         10 9  5 4  0
  * +----+---+---+-----------+------+---+-------+-----+-------------+----+----+
@@ -6533,6 +6551,14 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
             handle_fmov(s, rd, rn, type, itof);
             break;
 
+        case 0b00111110: /* FJCVTZS */
+            if (!dc_isar_feature(aa64_jscvt, s)) {
+                goto do_unallocated;
+            } else if (fp_access_check(s)) {
+                handle_fjcvtzs(s, rd, rn);
+            }
+            break;
+
         default:
         do_unallocated:
             unallocated_encoding(s);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index eb25895876..a92d06b05b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4066,6 +4066,21 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     case 17: /* fsito */
                         gen_vfp_sito(dp, 0);
                         break;
+                    case 19: /* vjcvt */
+                        if (!dp || !dc_isar_feature(aa32_jscvt, s)) {
+                            return 1;
+                        } else {
+                            TCGv_ptr fpst = get_fpstatus_ptr(0);
+                            gen_helper_fjcvtzs(cpu_F0d, cpu_F0d, fpst);
+                            tcg_temp_free_ptr(fpst);
+
+                            tcg_gen_extr_i64_i32(cpu_F0s, cpu_ZF, cpu_F0d);
+                            tcg_gen_movi_i32(cpu_NF, 0);
+                            tcg_gen_movi_i32(cpu_CF, 0);
+                            tcg_gen_movi_i32(cpu_VF, 0);
+                            dp = 0; /* always a single precision result */
+                        }
+                        break;
                     case 20: /* fshto */
                         if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
                             return 1;
-- 
2.17.2
