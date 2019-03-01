Received: from eggs.gnu.org ([209.51.188.92]:44874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzoPq-00058G-3r
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzoPm-0002Dx-0j
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:51 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:41349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzoPj-0001mu-JK
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:48 -0500
Received: by mail-pf1-x435.google.com with SMTP id d25so11902426pfn.8
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 12:05:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Mar 2019 12:05:01 -0800
Message-Id: <20190301200501.16533-11-richard.henderson@linaro.org>
In-Reply-To: <20190301200501.16533-1-richard.henderson@linaro.org>
References: <20190301200501.16533-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 10/10] target/arm: Implement ARMv8.5-FRINT
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

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  5 ++
 target/arm/helper.h        |  5 ++
 target/arm/cpu64.c         |  1 +
 target/arm/translate-a64.c | 71 ++++++++++++++++++++++++++--
 target/arm/vfp_helper.c    | 96 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a7aaec63d7..5f23c62132 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3476,6 +3476,11 @@ static inline bool isar_feature_aa64_predinv(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SPECRES) != 0;
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
index 583adba9b0..a09566f795 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -683,6 +683,11 @@ DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a32, TCG_CALL_NO_RWG,
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
index 9fe0844a82..228906f267 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -321,6 +321,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 94184ea5af..8907cc950a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5721,6 +5721,20 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
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
@@ -5784,6 +5798,20 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
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
@@ -5920,6 +5948,13 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
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
@@ -5929,14 +5964,12 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
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
@@ -5948,13 +5981,13 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
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
@@ -9482,6 +9515,14 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
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
@@ -12132,8 +12173,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         }
         break;
     case 0xc ... 0xf:
-    case 0x16 ... 0x1d:
-    case 0x1f:
+    case 0x16 ... 0x1f:
     {
         /* Floating point: U, size[1] and opcode indicate operation;
          * size[0] indicates single or double precision.
@@ -12276,6 +12316,19 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -12441,6 +12494,14 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
index cc7f9f5cb1..2468fc1629 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1174,3 +1174,99 @@ uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
 
     return result;
 }
+
+/* Round a float32 to an integer that fits in int32_t or int64_t.  */
+static float32 frint_s(float32 f, float_status *fpst, int intsize)
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
+    return frint_s(f, fpst, 32);
+}
+
+float32 HELPER(frint64_s)(float32 f, void *fpst)
+{
+    return frint_s(f, fpst, 64);
+}
+
+/* Round a float64 to an integer that fits in int32_t or int64_t.  */
+static float64 frint_d(float64 f, float_status *fpst, int intsize)
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
+     * inexact exception float64_round_to_int may have raised.
+     */
+    set_float_exception_flags(old_flags | float_flag_invalid, fpst);
+    return (uint64_t)(0x800 + 1022 + intsize) << 52;
+}
+
+float64 HELPER(frint32_d)(float64 f, void *fpst)
+{
+    return frint_d(f, fpst, 32);
+}
+
+float64 HELPER(frint64_d)(float64 f, void *fpst)
+{
+    return frint_d(f, fpst, 64);
+}
-- 
2.17.2
