Received: from eggs.gnu.org ([209.51.188.92]:57079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxM18-0008J2-DT
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 20:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxM16-0000Xl-Uf
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 20:22:14 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxM16-0000UU-L6
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 20:22:12 -0500
Received: by mail-pl1-x641.google.com with SMTP id y5so1841082plk.8
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 17:22:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 22 Feb 2019 17:22:06 -0800
Message-Id: <20190223012206.30498-3-richard.henderson@linaro.org>
In-Reply-To: <20190223012206.30498-1-richard.henderson@linaro.org>
References: <20190223012206.30498-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Implement ARMv8.5-FRINT
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
 target/arm/cpu.h           |  5 ++
 target/arm/helper.h        |  5 ++
 target/arm/cpu64.c         |  1 +
 target/arm/translate-a64.c | 71 ++++++++++++++++++++++++++--
 target/arm/vfp_helper.c    | 96 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9cf439fb8d..f60a2361fe 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3391,6 +3391,11 @@ static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
              FIELD_DP64(0, ID_AA64ISAR1, GPI, 0xf))) != 0;
 }
 
+static inline bool isar_feature_aa64_frint(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) != 0;
+}
+
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index d363904278..c978a1d812 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -686,6 +686,11 @@ DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a32, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a64, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_2(frint32_s, TCG_CALL_NO_RWG, f32, f32, ptr)
+DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, ptr)
+DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, ptr)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1b0c427277..645cc20eb6 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -318,6 +318,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fcbf6b16cf..139e500df8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5540,6 +5540,20 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     case 0xf: /* FRINTI */
         gen_fpst = gen_helper_rints;
         break;
+    case 0x10: /* FRINT32Z */
+        rmode = float_round_to_zero;
+        gen_fpst = gen_helper_frint32_s;
+        break;
+    case 0x11: /* FRINT32X */
+        gen_fpst = gen_helper_frint32_s;
+        break;
+    case 0x12: /* FRINT64Z */
+        rmode = float_round_to_zero;
+        gen_fpst = gen_helper_frint64_s;
+        break;
+    case 0x13: /* FRINT64X */
+        gen_fpst = gen_helper_frint64_s;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -5603,6 +5617,20 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     case 0xf: /* FRINTI */
         gen_fpst = gen_helper_rintd;
         break;
+    case 0x10: /* FRINT32Z */
+        rmode = float_round_to_zero;
+        gen_fpst = gen_helper_frint32_d;
+        break;
+    case 0x11: /* FRINT32X */
+        gen_fpst = gen_helper_frint32_d;
+        break;
+    case 0x12: /* FRINT64Z */
+        rmode = float_round_to_zero;
+        gen_fpst = gen_helper_frint64_d;
+        break;
+    case 0x13: /* FRINT64X */
+        gen_fpst = gen_helper_frint64_d;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -5739,6 +5767,13 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
         handle_fp_fcvt(s, opcode, rd, rn, dtype, type);
         break;
     }
+
+    case 0x10 ... 0x13: /* FRINT{32,64}{X,Z} */
+        if (type > 1 || !dc_isar_feature(aa64_frint, s)) {
+            unallocated_encoding(s);
+            return;
+        }
+        /* fall through */
     case 0x0 ... 0x3:
     case 0x8 ... 0xc:
     case 0xe ... 0xf:
@@ -5748,14 +5783,12 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
             if (!fp_access_check(s)) {
                 return;
             }
-
             handle_fp_1src_single(s, opcode, rd, rn);
             break;
         case 1:
             if (!fp_access_check(s)) {
                 return;
             }
-
             handle_fp_1src_double(s, opcode, rd, rn);
             break;
         case 3:
@@ -5767,13 +5800,13 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
             if (!fp_access_check(s)) {
                 return;
             }
-
             handle_fp_1src_half(s, opcode, rd, rn);
             break;
         default:
             unallocated_encoding(s);
         }
         break;
+
     default:
         unallocated_encoding(s);
         break;
@@ -9301,6 +9334,14 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x59: /* FRINTX */
         gen_helper_rintd_exact(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
+    case 0x1e: /* FRINT32Z */
+    case 0x5e: /* FRINT32X */
+        gen_helper_frint32_d(tcg_rd, tcg_rn, tcg_fpstatus);
+        break;
+    case 0x1f: /* FRINT64Z */
+    case 0x5f: /* FRINT64X */
+        gen_helper_frint64_d(tcg_rd, tcg_rn, tcg_fpstatus);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -11951,8 +11992,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         }
         break;
     case 0xc ... 0xf:
-    case 0x16 ... 0x1d:
-    case 0x1f:
+    case 0x16 ... 0x1f:
     {
         /* Floating point: U, size[1] and opcode indicate operation;
          * size[0] indicates single or double precision.
@@ -12095,6 +12135,19 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             need_fpstatus = true;
             break;
+        case 0x1e: /* FRINT32Z */
+        case 0x1f: /* FRINT64Z */
+            need_rmode = true;
+            rmode = FPROUNDING_ZERO;
+            /* fall through */
+        case 0x5e: /* FRINT32X */
+        case 0x5f: /* FRINT64X */
+            need_fpstatus = true;
+            if ((size == 3 && !is_q) || !dc_isar_feature(aa64_frint, s)) {
+                unallocated_encoding(s);
+                return;
+            }
+            break;
         default:
             unallocated_encoding(s);
             return;
@@ -12260,6 +12313,14 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 case 0x7c: /* URSQRTE */
                     gen_helper_rsqrte_u32(tcg_res, tcg_op, tcg_fpstatus);
                     break;
+                case 0x1e: /* FRINT32Z */
+                case 0x5e: /* FRINT32X */
+                    gen_helper_frint32_s(tcg_res, tcg_op, tcg_fpstatus);
+                    break;
+                case 0x1f: /* FRINT64Z */
+                case 0x5f: /* FRINT64X */
+                    gen_helper_frint64_s(tcg_res, tcg_op, tcg_fpstatus);
+                    break;
                 default:
                     g_assert_not_reached();
                 }
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index f19c0606c2..c77000606e 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1174,3 +1174,99 @@ uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
 
     return result;
 }
+
+/* Round a float32 to an integer that fits in int32_t or int64_t.  */
+static float32 frint_f32(float32 f, float_status *fpst, int intsize)
+{
+    int old_flags = get_float_exception_flags(fpst);
+    uint32_t exp = extract32(f, 23, 8);
+
+    if (unlikely(exp == 0xff)) {
+        /* NaN or Inf.  */
+        goto overflow;
+    }
+
+    /* Round and re-extract the exponent.  */
+    f = float32_round_to_int(f, fpst);
+    exp = extract32(f, 23, 8);
+
+    /* Validate the range of the result.  */
+    if (exp < 126 + intsize) {
+        /* abs(F) <= INT{N}_MAX */
+        return f;
+    }
+    if (exp == 126 + intsize) {
+        uint32_t sign = extract32(f, 31, 1);
+        uint32_t frac = extract32(f, 0, 23);
+        if (sign && frac == 0) {
+            /* F == INT{N}_MIN */
+            return f;
+        }
+    }
+
+ overflow:
+    /*
+     * Raise Invalid and return INT{N}_MIN as a float.  Revert any
+     * inexact exception float32_round_to_int may have raised.
+     */
+    set_float_exception_flags(old_flags | float_flag_invalid, fpst);
+    return (0x100u + 126u + intsize) << 23;
+}
+
+float32 HELPER(frint32_s)(float32 f, void *fpst)
+{
+    return frint_f32(f, fpst, 32);
+}
+
+float32 HELPER(frint64_s)(float32 f, void *fpst)
+{
+    return frint_f32(f, fpst, 64);
+}
+
+/* Round a float64 to an integer that fits in int32_t or int64_t.  */
+static float64 frint_f64(float64 f, float_status *fpst, int intsize)
+{
+    int old_flags = get_float_exception_flags(fpst);
+    uint32_t exp = extract64(f, 52, 11);
+
+    if (unlikely(exp == 0x7ff)) {
+        /* NaN or Inf.  */
+        goto overflow;
+    }
+
+    /* Round and re-extract the exponent.  */
+    f = float64_round_to_int(f, fpst);
+    exp = extract64(f, 52, 11);
+
+    /* Validate the range of the result.  */
+    if (exp < 1022 + intsize) {
+        /* abs(F) <= INT{N}_MAX */
+        return f;
+    }
+    if (exp == 1022 + intsize) {
+        uint64_t sign = extract64(f, 63, 1);
+        uint64_t frac = extract64(f, 0, 52);
+        if (sign && frac == 0) {
+            /* F == INT{N}_MIN */
+            return f;
+        }
+    }
+
+ overflow:
+    /*
+     * Raise Invalid and return INT{N}_MIN as a float.  Revert any
+     * inexact exception float32_round_to_int may have raised.
+     */
+    set_float_exception_flags(old_flags | float_flag_invalid, fpst);
+    return (uint64_t)(0x800 + 1022 + intsize) << 52;
+}
+
+float64 HELPER(frint32_d)(float64 f, void *fpst)
+{
+    return frint_f64(f, fpst, 32);
+}
+
+float64 HELPER(frint64_d)(float64 f, void *fpst)
+{
+    return frint_f64(f, fpst, 64);
+}
-- 
2.17.1
