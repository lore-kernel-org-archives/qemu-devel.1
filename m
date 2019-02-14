Received: from eggs.gnu.org ([209.51.188.92]:57213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guOVD-000350-JD
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guOSO-0002i1-7x
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:22:11 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1guOSN-0002Ja-J6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:22:08 -0500
Received: by mail-pf1-x442.google.com with SMTP id b7so3721078pfi.8
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 13:21:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Feb 2019 13:21:44 -0800
Message-Id: <20190214212144.12784-4-richard.henderson@linaro.org>
In-Reply-To: <20190214212144.12784-1-richard.henderson@linaro.org>
References: <20190214212144.12784-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 3/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Return 0 for NaN
v3: Return aa32 flags in FPSCR.NZCV.
---
 target/arm/cpu.h           | 10 +++++
 target/arm/helper.h        |  3 ++
 target/arm/cpu.c           |  1 +
 target/arm/cpu64.c         |  2 +
 target/arm/translate-a64.c | 26 +++++++++++
 target/arm/translate.c     | 10 +++++
 target/arm/vfp_helper.c    | 88 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 140 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b96463e8f1..dbed7a74b4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3230,6 +3230,11 @@ static inline bool isar_feature_aa32_vcma(const ARMISARegisters *id)
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
@@ -3308,6 +3313,11 @@ static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
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
index 923e8e1525..747cb64d29 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -218,6 +218,9 @@ DEF_HELPER_FLAGS_2(rintd_exact, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(rints, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rintd, TCG_CALL_NO_RWG, f64, f64, ptr)
 
+DEF_HELPER_FLAGS_2(vjcvt, TCG_CALL_NO_RWG, i32, f64, env)
+DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
+
 /* neon_helper.c */
 DEF_HELPER_FLAGS_3(neon_qadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(neon_qadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index edf6e0e1f1..8ea6569088 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2001,6 +2001,7 @@ static void arm_max_initfn(Object *obj)
             cpu->isar.id_isar5 = t;
 
             t = cpu->isar.id_isar6;
+            t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
             cpu->isar.id_isar6 = t;
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index eff0f164dd..69e4134f79 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -311,6 +311,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
         t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
@@ -344,6 +345,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_isar5 = u;
 
         u = cpu->isar.id_isar6;
+        u = FIELD_DP32(u, ID_ISAR6, JSCVT, 1);
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
         cpu->isar.id_isar6 = u;
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index dbce24fe32..c56e878787 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6526,6 +6526,24 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
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
@@ -6601,6 +6619,14 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
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
index 64c5fe0df3..c1175798ac 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3718,6 +3718,13 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     rm_is_dp = false;
                     break;
 
+                case 0x13: /* vjcvt */
+                    if (!dp || !dc_isar_feature(aa32_jscvt, s)) {
+                        return 1;
+                    }
+                    rd_is_dp = false;
+                    break;
+
                 default:
                     return 1;
                 }
@@ -4088,6 +4095,9 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     case 17: /* fsito */
                         gen_vfp_sito(dp, 0);
                         break;
+                    case 19: /* vjcvt */
+                        gen_helper_vjcvt(cpu_F0s, cpu_F0d, cpu_env);
+                        break;
                     case 20: /* fshto */
                         gen_vfp_shto(dp, 16 - rm, 0);
                         break;
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 74d3030c47..f19c0606c2 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1086,3 +1086,91 @@ int arm_rmode_to_sf(int rmode)
     }
     return rmode;
 }
+
+/*
+ * Implement float64 to int32_t conversion without saturation;
+ * the result is supplied modulo 2^32.
+ */
+uint64_t HELPER(fjcvtzs)(float64 value, void *vstatus)
+{
+    float_status *status = vstatus;
+    uint32_t exp, sign;
+    uint64_t frac;
+    uint32_t inexact = 1; /* !Z */
+
+    sign = extract64(value, 63, 1);
+    exp = extract64(value, 52, 11);
+    frac = extract64(value, 0, 52);
+
+    if (exp == 0) {
+        /* While not inexact for IEEE FP, -0.0 is inexact for JavaScript.  */
+        inexact = sign;
+        if (frac != 0) {
+            if (status->flush_inputs_to_zero) {
+                float_raise(float_flag_input_denormal, status);
+            } else {
+                float_raise(float_flag_inexact, status);
+                inexact = 1;
+            }
+        }
+        frac = 0;
+    } else if (exp == 0x7ff) {
+        /* This operation raises Invalid for both NaN and overflow (Inf).  */
+        float_raise(float_flag_invalid, status);
+        frac = 0;
+    } else {
+        int true_exp = exp - 1023;
+        int shift = true_exp - 52;
+
+        /* Restore implicit bit.  */
+        frac |= 1ull << 52;
+
+        /* Shift the fraction into place.  */
+        if (shift >= 0) {
+            /* The number is so large we must shift the fraction left.  */
+            if (shift >= 64) {
+                /* The the fraction is shifted out entirely.  */
+                frac = 0;
+            } else {
+                frac <<= shift;
+            }
+        } else if (shift > -64) {
+            /* Normal case -- shift right and notice if bits shift out.  */
+            inexact = (frac << (64 + shift)) != 0;
+            frac >>= -shift;
+        } else {
+            /* The fraction is shifted out entirely.  */
+            frac = 0;
+        }
+
+        /* Notice overflow or inexact exceptions.  */
+        if (true_exp > 31 || frac > (sign ? 0x80000000ull : 0x7fffffff)) {
+            /* Overflow, for which this operation raises invalid.  */
+            float_raise(float_flag_invalid, status);
+            inexact = 1;
+        } else if (inexact) {
+            float_raise(float_flag_inexact, status);
+        }
+
+        /* Honor the sign.  */
+        if (sign) {
+            frac = -frac;
+        }
+    }
+
+    /* Pack the result and the env->ZF representation of Z together.  */
+    return deposit64(frac, 32, 32, inexact);
+}
+
+uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
+{
+    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status);
+    uint32_t result = pair;
+    uint32_t z = (pair >> 32) == 0;
+
+    /* Store Z, clear NCV, in FPSCR.NZCF.  */
+    env->vfp.xregs[ARM_VFP_FPSCR]
+        = (env->vfp.xregs[ARM_VFP_FPSCR] & ~CPSR_NZCV) | (z * CPSR_Z);
+
+    return result;
+}
-- 
2.17.2
