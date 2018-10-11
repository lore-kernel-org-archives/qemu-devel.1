Received: from eggs.gnu.org ([2001:4830:134:3::10]:54261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkar-0001oG-C1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkao-0002HV-Cg
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:13 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:40020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAkam-0001zP-7w
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id 1-v6so4970059plv.7
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:42:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 16:41:53 -0700
Message-Id: <20181011234159.11496-2-richard.henderson@linaro.org>
In-Reply-To: <20181011234159.11496-1-richard.henderson@linaro.org>
References: <20181011234159.11496-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/7] target/ppc: Split up float_invalid_op_excp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

The always_inline trick only works if the function is always
called from the outer-most helper.  But it isn't, so pass in
the outer-most return address.  There's no need for a switch
statement whose argument is always a constant.  Unravel the
switch and goto via more helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/fpu_helper.c | 344 +++++++++++++++++++++-------------------
 1 file changed, 181 insertions(+), 163 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index b9bb1b856e..6ec5227dd5 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -170,96 +170,120 @@ COMPUTE_FPRF(float64)
 COMPUTE_FPRF(float128)
 
 /* Floating-point invalid operations exception */
-static inline __attribute__((__always_inline__))
-uint64_t float_invalid_op_excp(CPUPPCState *env, int op, int set_fpcc)
+static void finish_invalid_op_excp(CPUPPCState *env, int op, uintptr_t retaddr)
 {
-    CPUState *cs = CPU(ppc_env_get_cpu(env));
-    uint64_t ret = 0;
-    int ve;
+    /* Update the floating-point invalid operation summary */
+    env->fpscr |= 1 << FPSCR_VX;
+    /* Update the floating-point exception summary */
+    env->fpscr |= FP_FX;
+    if (fpscr_ve != 0) {
+        /* Update the floating-point enabled exception summary */
+        env->fpscr |= 1 << FPSCR_FEX;
+        if (fp_exceptions_enabled(env)) {
+            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
+                                   POWERPC_EXCP_FP | op, retaddr);
+        }
+    }
+}
 
-    ve = fpscr_ve;
-    switch (op) {
-    case POWERPC_EXCP_FP_VXSNAN:
-        env->fpscr |= 1 << FPSCR_VXSNAN;
-        break;
-    case POWERPC_EXCP_FP_VXSOFT:
-        env->fpscr |= 1 << FPSCR_VXSOFT;
-        break;
-    case POWERPC_EXCP_FP_VXISI:
-        /* Magnitude subtraction of infinities */
-        env->fpscr |= 1 << FPSCR_VXISI;
-        goto update_arith;
-    case POWERPC_EXCP_FP_VXIDI:
-        /* Division of infinity by infinity */
-        env->fpscr |= 1 << FPSCR_VXIDI;
-        goto update_arith;
-    case POWERPC_EXCP_FP_VXZDZ:
-        /* Division of zero by zero */
-        env->fpscr |= 1 << FPSCR_VXZDZ;
-        goto update_arith;
-    case POWERPC_EXCP_FP_VXIMZ:
-        /* Multiplication of zero by infinity */
-        env->fpscr |= 1 << FPSCR_VXIMZ;
-        goto update_arith;
-    case POWERPC_EXCP_FP_VXVC:
-        /* Ordered comparison of NaN */
-        env->fpscr |= 1 << FPSCR_VXVC;
+static void finish_invalid_op_arith(CPUPPCState *env, int op,
+                                    bool set_fpcc, uintptr_t retaddr)
+{
+    env->fpscr &= ~((1 << FPSCR_FR) | (1 << FPSCR_FI));
+    if (fpscr_ve == 0) {
         if (set_fpcc) {
             env->fpscr &= ~(0xF << FPSCR_FPCC);
             env->fpscr |= 0x11 << FPSCR_FPCC;
         }
-        /* We must update the target FPR before raising the exception */
-        if (ve != 0) {
-            cs->exception_index = POWERPC_EXCP_PROGRAM;
-            env->error_code = POWERPC_EXCP_FP | POWERPC_EXCP_FP_VXVC;
-            /* Update the floating-point enabled exception summary */
-            env->fpscr |= 1 << FPSCR_FEX;
-            /* Exception is differed */
-            ve = 0;
-        }
-        break;
-    case POWERPC_EXCP_FP_VXSQRT:
-        /* Square root of a negative number */
-        env->fpscr |= 1 << FPSCR_VXSQRT;
-    update_arith:
-        env->fpscr &= ~((1 << FPSCR_FR) | (1 << FPSCR_FI));
-        if (ve == 0) {
-            /* Set the result to quiet NaN */
-            ret = 0x7FF8000000000000ULL;
-            if (set_fpcc) {
-                env->fpscr &= ~(0xF << FPSCR_FPCC);
-                env->fpscr |= 0x11 << FPSCR_FPCC;
-            }
-        }
-        break;
-    case POWERPC_EXCP_FP_VXCVI:
-        /* Invalid conversion */
-        env->fpscr |= 1 << FPSCR_VXCVI;
-        env->fpscr &= ~((1 << FPSCR_FR) | (1 << FPSCR_FI));
-        if (ve == 0) {
-            /* Set the result to quiet NaN */
-            ret = 0x7FF8000000000000ULL;
-            if (set_fpcc) {
-                env->fpscr &= ~(0xF << FPSCR_FPCC);
-                env->fpscr |= 0x11 << FPSCR_FPCC;
-            }
-        }
-        break;
+    }
+    finish_invalid_op_excp(env, op, retaddr);
+}
+
+/* Signalling NaN */
+static void float_invalid_op_vxsnan(CPUPPCState *env, uintptr_t retaddr)
+{
+    env->fpscr |= 1 << FPSCR_VXSNAN;
+    finish_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, retaddr);
+}
+
+/* Magnitude subtraction of infinities */
+static void float_invalid_op_vxisi(CPUPPCState *env, bool set_fpcc,
+                                   uintptr_t retaddr)
+{
+    env->fpscr |= 1 << FPSCR_VXISI;
+    finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXISI, set_fpcc, retaddr);
+}
+
+/* Division of infinity by infinity */
+static void float_invalid_op_vxidi(CPUPPCState *env, bool set_fpcc,
+                                   uintptr_t retaddr)
+{
+    env->fpscr |= 1 << FPSCR_VXIDI;
+    finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXIDI, set_fpcc, retaddr);
+}
+
+/* Division of zero by zero */
+static void float_invalid_op_vxzdz(CPUPPCState *env, bool set_fpcc,
+                                   uintptr_t retaddr)
+{
+    env->fpscr |= 1 << FPSCR_VXZDZ;
+    finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXZDZ, set_fpcc, retaddr);
+}
+
+/* Multiplication of zero by infinity */
+static void float_invalid_op_vximz(CPUPPCState *env, bool set_fpcc,
+                                   uintptr_t retaddr)
+{
+    env->fpscr |= 1 << FPSCR_VXIMZ;
+    finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXIMZ, set_fpcc, retaddr);
+}
+
+/* Square root of a negative number */
+static void float_invalid_op_vxsqrt(CPUPPCState *env, bool set_fpcc,
+                                    uintptr_t retaddr)
+{
+    env->fpscr |= 1 << FPSCR_VXSQRT;
+    finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXSQRT, set_fpcc, retaddr);
+}
+
+/* Ordered comparison of NaN */
+static void float_invalid_op_vxvc(CPUPPCState *env, bool set_fpcc,
+                                  uintptr_t retaddr)
+{
+    env->fpscr |= 1 << FPSCR_VXVC;
+    if (set_fpcc) {
+        env->fpscr &= ~(0xF << FPSCR_FPCC);
+        env->fpscr |= 0x11 << FPSCR_FPCC;
     }
     /* Update the floating-point invalid operation summary */
     env->fpscr |= 1 << FPSCR_VX;
     /* Update the floating-point exception summary */
     env->fpscr |= FP_FX;
-    if (ve != 0) {
+    /* We must update the target FPR before raising the exception */
+    if (fpscr_ve != 0) {
+        CPUState *cs = CPU(ppc_env_get_cpu(env));
+
+        cs->exception_index = POWERPC_EXCP_PROGRAM;
+        env->error_code = POWERPC_EXCP_FP | POWERPC_EXCP_FP_VXVC;
         /* Update the floating-point enabled exception summary */
         env->fpscr |= 1 << FPSCR_FEX;
-        if (fp_exceptions_enabled(env)) {
-            /* GETPC() works here because this is inline */
-            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                                   POWERPC_EXCP_FP | op, GETPC());
+        /* Exception is differed */
+    }
+}
+
+/* Invalid conversion */
+static void float_invalid_op_vxcvi(CPUPPCState *env, bool set_fpcc,
+                                   uintptr_t retaddr)
+{
+    env->fpscr |= 1 << FPSCR_VXCVI;
+    env->fpscr &= ~((1 << FPSCR_FR) | (1 << FPSCR_FI));
+    if (fpscr_ve == 0) {
+        if (set_fpcc) {
+            env->fpscr &= ~(0xF << FPSCR_FPCC);
+            env->fpscr |= 0x11 << FPSCR_FPCC;
         }
     }
-    return ret;
+    finish_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, retaddr);
 }
 
 static inline void float_zero_divide_excp(CPUPPCState *env, uintptr_t raddr)
@@ -632,11 +656,11 @@ float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
     if (unlikely(status & float_flag_invalid)) {
         if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
             /* Magnitude subtraction of infinities */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
+            float_invalid_op_vxisi(env, 1, GETPC());
         } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
                    float64_is_signaling_nan(arg2, &env->fp_status)) {
             /* sNaN addition */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            float_invalid_op_vxsnan(env, GETPC());
         }
     }
 
@@ -652,11 +676,11 @@ float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
     if (unlikely(status & float_flag_invalid)) {
         if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
             /* Magnitude subtraction of infinities */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
+            float_invalid_op_vxisi(env, 1, GETPC());
         } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
                    float64_is_signaling_nan(arg2, &env->fp_status)) {
             /* sNaN addition */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            float_invalid_op_vxsnan(env, GETPC());
         }
     }
 
@@ -673,11 +697,11 @@ float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
         if ((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
             (float64_is_zero(arg1) && float64_is_infinity(arg2))) {
             /* Multiplication of zero by infinity */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
+            float_invalid_op_vximz(env, 1, GETPC());
         } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
                    float64_is_signaling_nan(arg2, &env->fp_status)) {
             /* sNaN multiplication */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            float_invalid_op_vxsnan(env, GETPC());
         }
     }
 
@@ -695,14 +719,14 @@ float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
             /* Determine what kind of invalid operation was seen.  */
             if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
                 /* Division of infinity by infinity */
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIDI, 1);
+                float_invalid_op_vxidi(env, 1, GETPC());
             } else if (float64_is_zero(arg1) && float64_is_zero(arg2)) {
                 /* Division of zero by zero */
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXZDZ, 1);
+                float_invalid_op_vxzdz(env, 1, GETPC());
             } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
                        float64_is_signaling_nan(arg2, &env->fp_status)) {
                 /* sNaN division */
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+                float_invalid_op_vxsnan(env, GETPC());
             }
         }
         if (status & float_flag_divbyzero) {
@@ -724,14 +748,14 @@ uint64_t helper_##op(CPUPPCState *env, uint64_t arg)                   \
                                                                        \
     if (unlikely(env->fp_status.float_exception_flags)) {              \
         if (float64_is_any_nan(arg)) {                                 \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, 1);      \
+            float_invalid_op_vxcvi(env, 1, GETPC());                   \
             if (float64_is_signaling_nan(arg, &env->fp_status)) {      \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1); \
+                float_invalid_op_vxsnan(env, GETPC());                 \
             }                                                          \
             farg.ll = nanval;                                          \
         } else if (env->fp_status.float_exception_flags &              \
                    float_flag_invalid) {                               \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, 1);      \
+            float_invalid_op_vxcvi(env, 1, GETPC());                   \
         }                                                              \
         float_check_status(env);                                       \
     }                                                                  \
@@ -776,7 +800,7 @@ static inline uint64_t do_fri(CPUPPCState *env, uint64_t arg,
 
     if (unlikely(float64_is_signaling_nan(farg.d, &env->fp_status))) {
         /* sNaN round */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+        float_invalid_op_vxsnan(env, GETPC());
         farg.ll = arg | 0x0008000000000000ULL;
     } else {
         int inexact = get_float_exception_flags(&env->fp_status) &
@@ -817,18 +841,18 @@ uint64_t helper_frim(CPUPPCState *env, uint64_t arg)
 
 #define FPU_MADDSUB_UPDATE(NAME, TP)                                    \
 static void NAME(CPUPPCState *env, TP arg1, TP arg2, TP arg3,           \
-                 unsigned int madd_flags)                               \
+                 unsigned int madd_flags, uintptr_t retaddr)            \
 {                                                                       \
     if (TP##_is_signaling_nan(arg1, &env->fp_status) ||                 \
         TP##_is_signaling_nan(arg2, &env->fp_status) ||                 \
         TP##_is_signaling_nan(arg3, &env->fp_status)) {                 \
         /* sNaN operation */                                            \
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);          \
+        float_invalid_op_vxsnan(env, retaddr);                          \
     }                                                                   \
     if ((TP##_is_infinity(arg1) && TP##_is_zero(arg2)) ||               \
         (TP##_is_zero(arg1) && TP##_is_infinity(arg2))) {               \
         /* Multiplication of zero by infinity */                        \
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);           \
+        float_invalid_op_vximz(env, 1, retaddr);                        \
     }                                                                   \
     if ((TP##_is_infinity(arg1) || TP##_is_infinity(arg2)) &&           \
         TP##_is_infinity(arg3)) {                                       \
@@ -841,7 +865,7 @@ static void NAME(CPUPPCState *env, TP arg1, TP arg2, TP arg3,           \
             cSign ^= 1;                                                 \
         }                                                               \
         if (aSign ^ bSign ^ cSign) {                                    \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);       \
+            float_invalid_op_vxisi(env, 1, retaddr);                    \
         }                                                               \
     }                                                                   \
 }
@@ -859,7 +883,7 @@ uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,                   \
     if (flags) {                                                        \
         if (flags & float_flag_invalid) {                               \
             float64_maddsub_update_excp(env, arg1, arg2, arg3,          \
-                                        madd_flags);                    \
+                                        madd_flags, GETPC());           \
         }                                                               \
         float_check_status(env);                                        \
     }                                                                   \
@@ -885,8 +909,7 @@ uint64_t helper_frsp(CPUPPCState *env, uint64_t arg)
     farg.ll = arg;
 
     if (unlikely(float64_is_signaling_nan(farg.d, &env->fp_status))) {
-        /* sNaN square root */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+        float_invalid_op_vxsnan(env, GETPC());
     }
     f32 = float64_to_float32(farg.d, &env->fp_status);
     farg.d = float32_to_float64(f32, &env->fp_status);
@@ -904,11 +927,11 @@ float64 helper_fsqrt(CPUPPCState *env, float64 arg)
         if (unlikely(float64_is_any_nan(arg))) {
             if (unlikely(float64_is_signaling_nan(arg, &env->fp_status))) {
                 /* sNaN square root */
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+                float_invalid_op_vxsnan(env, GETPC());
             }
         } else {
             /* Square root of a negative nonzero number */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, 1);
+            float_invalid_op_vxsqrt(env, 1, GETPC());
         }
     }
 
@@ -926,7 +949,7 @@ float64 helper_fre(CPUPPCState *env, float64 arg)
         if (status & float_flag_invalid) {
             if (float64_is_signaling_nan(arg, &env->fp_status)) {
                 /* sNaN reciprocal */
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+                float_invalid_op_vxsnan(env, GETPC());
             }
         }
         if (status & float_flag_divbyzero) {
@@ -949,7 +972,7 @@ uint64_t helper_fres(CPUPPCState *env, uint64_t arg)
 
     if (unlikely(float64_is_signaling_nan(farg.d, &env->fp_status))) {
         /* sNaN reciprocal */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+        float_invalid_op_vxsnan(env, GETPC());
     }
     farg.d = float64_div(float64_one, farg.d, &env->fp_status);
     f32 = float64_to_float32(farg.d, &env->fp_status);
@@ -970,10 +993,10 @@ float64 helper_frsqrte(CPUPPCState *env, float64 arg)
         if (status & float_flag_invalid) {
             if (float64_is_signaling_nan(arg, &env->fp_status)) {
                 /* sNaN reciprocal */
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+                float_invalid_op_vxsnan(env, GETPC());
             } else {
                 /* Square root of a negative nonzero number */
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, 1);
+                float_invalid_op_vxsqrt(env, 1, GETPC());
             }
         }
         if (status & float_flag_divbyzero) {
@@ -1095,7 +1118,7 @@ void helper_fcmpu(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
                  && (float64_is_signaling_nan(farg1.d, &env->fp_status) ||
                      float64_is_signaling_nan(farg2.d, &env->fp_status)))) {
         /* sNaN comparison */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+        float_invalid_op_vxsnan(env, GETPC());
     }
 }
 
@@ -1123,14 +1146,11 @@ void helper_fcmpo(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
     env->fpscr |= ret << FPSCR_FPRF;
     env->crf[crfD] = ret;
     if (unlikely(ret == 0x01UL)) {
+        float_invalid_op_vxvc(env, 1, GETPC());
         if (float64_is_signaling_nan(farg1.d, &env->fp_status) ||
             float64_is_signaling_nan(farg2.d, &env->fp_status)) {
             /* sNaN comparison */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN |
-                                  POWERPC_EXCP_FP_VXVC, 1);
-        } else {
-            /* qNaN comparison */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXVC, 1);
+            float_invalid_op_vxsnan(env, GETPC());
         }
     }
 }
@@ -1783,10 +1803,10 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                        \
                                                                              \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
             if (tp##_is_infinity(xa.fld) && tp##_is_infinity(xb.fld)) {      \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, sfprf);    \
+                float_invalid_op_vxisi(env, sfprf, GETPC());                 \
             } else if (tp##_is_signaling_nan(xa.fld, &tstat) ||              \
                        tp##_is_signaling_nan(xb.fld, &tstat)) {              \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, sfprf);   \
+                float_invalid_op_vxsnan(env, GETPC());                       \
             }                                                                \
         }                                                                    \
                                                                              \
@@ -1832,10 +1852,10 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f128)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
+            float_invalid_op_vxisi(env, 1, GETPC());
         } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
                    float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            float_invalid_op_vxsnan(env, GETPC());
         }
     }
 
@@ -1872,10 +1892,10 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
             if ((tp##_is_infinity(xa.fld) && tp##_is_zero(xb.fld)) ||        \
                 (tp##_is_infinity(xb.fld) && tp##_is_zero(xa.fld))) {        \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, sfprf);    \
+                float_invalid_op_vximz(env, sfprf, GETPC());                 \
             } else if (tp##_is_signaling_nan(xa.fld, &tstat) ||              \
                        tp##_is_signaling_nan(xb.fld, &tstat)) {              \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, sfprf);   \
+                float_invalid_op_vxsnan(env, GETPC());                       \
             }                                                                \
         }                                                                    \
                                                                              \
@@ -1919,10 +1939,10 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         if ((float128_is_infinity(xa.f128) && float128_is_zero(xb.f128)) ||
             (float128_is_infinity(xb.f128) && float128_is_zero(xa.f128))) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
+            float_invalid_op_vximz(env, 1, GETPC());
         } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
                    float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            float_invalid_op_vxsnan(env, GETPC());
         }
     }
     helper_compute_fprf_float128(env, xt.f128);
@@ -1957,13 +1977,12 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
                                                                               \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {     \
             if (tp##_is_infinity(xa.fld) && tp##_is_infinity(xb.fld)) {       \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIDI, sfprf);     \
-            } else if (tp##_is_zero(xa.fld) &&                                \
-                tp##_is_zero(xb.fld)) {                                       \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXZDZ, sfprf);     \
+                float_invalid_op_vxidi(env, sfprf, GETPC());                  \
+            } else if (tp##_is_zero(xa.fld) && tp##_is_zero(xb.fld)) {        \
+                float_invalid_op_vxzdz(env, sfprf, GETPC());                  \
             } else if (tp##_is_signaling_nan(xa.fld, &tstat) ||               \
-                tp##_is_signaling_nan(xb.fld, &tstat)) {                      \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, sfprf);    \
+                       tp##_is_signaling_nan(xb.fld, &tstat)) {               \
+                float_invalid_op_vxsnan(env, GETPC());                        \
             }                                                                 \
         }                                                                     \
         if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {   \
@@ -2009,13 +2028,12 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f128)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIDI, 1);
-        } else if (float128_is_zero(xa.f128) &&
-            float128_is_zero(xb.f128)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXZDZ, 1);
+            float_invalid_op_vxidi(env, 1, GETPC());
+        } else if (float128_is_zero(xa.f128) && float128_is_zero(xb.f128)) {
+            float_invalid_op_vxzdz(env, 1, GETPC());
         } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
-            float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+                   float128_is_signaling_nan(xb.f128, &tstat)) {
+            float_invalid_op_vxsnan(env, GETPC());
         }
     }
     if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {
@@ -2046,7 +2064,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
         if (unlikely(tp##_is_signaling_nan(xb.fld, &env->fp_status))) {       \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, sfprf);    \
+            float_invalid_op_vxsnan(env, GETPC());                            \
         }                                                                     \
         xt.fld = tp##_div(tp##_one, xb.fld, &env->fp_status);                 \
                                                                               \
@@ -2093,9 +2111,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
                                                                              \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
             if (tp##_is_neg(xb.fld) && !tp##_is_zero(xb.fld)) {              \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, sfprf);   \
+                float_invalid_op_vxsqrt(env, sfprf, GETPC());                \
             } else if (tp##_is_signaling_nan(xb.fld, &tstat)) {              \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, sfprf);   \
+                float_invalid_op_vxsnan(env, GETPC());                       \
             }                                                                \
         }                                                                    \
                                                                              \
@@ -2143,9 +2161,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
                                                                              \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
             if (tp##_is_neg(xb.fld) && !tp##_is_zero(xb.fld)) {              \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, sfprf);   \
+                float_invalid_op_vxsqrt(env, sfprf, GETPC());                \
             } else if (tp##_is_signaling_nan(xb.fld, &tstat)) {              \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, sfprf);   \
+                float_invalid_op_vxsnan(env, GETPC());                       \
             }                                                                \
         }                                                                    \
                                                                              \
@@ -2329,7 +2347,8 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags;  \
                                                                               \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {     \
-            tp##_maddsub_update_excp(env, xa.fld, b->fld, c->fld, maddflgs);  \
+            tp##_maddsub_update_excp(env, xa.fld, b->fld,                     \
+                                     c->fld, maddflgs, GETPC());              \
         }                                                                     \
                                                                               \
         if (r2sp) {                                                           \
@@ -2407,10 +2426,10 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
             float64_is_quiet_nan(xb.VsrD(0), &env->fp_status);                \
     }                                                                         \
     if (vxsnan_flag) {                                                        \
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);                \
+        float_invalid_op_vxsnan(env, GETPC());                                \
     }                                                                         \
     if (vxvc_flag) {                                                          \
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXVC, 0);                  \
+        float_invalid_op_vxvc(env, 0, GETPC());                               \
     }                                                                         \
     vex_flag = fpscr_ve && (vxvc_flag || vxsnan_flag);                        \
                                                                               \
@@ -2522,10 +2541,10 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                      \
         }                                                                \
     }                                                                    \
     if (vxsnan_flag) {                                                   \
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);           \
+        float_invalid_op_vxsnan(env, GETPC());                           \
     }                                                                    \
     if (vxvc_flag) {                                                     \
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXVC, 0);             \
+        float_invalid_op_vxvc(env, 0, GETPC());                          \
     }                                                                    \
                                                                          \
     if (float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) {           \
@@ -2572,10 +2591,10 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
         }                                                               \
     }                                                                   \
     if (vxsnan_flag) {                                                  \
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);          \
+        float_invalid_op_vxsnan(env, GETPC());                          \
     }                                                                   \
     if (vxvc_flag) {                                                    \
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXVC, 0);            \
+        float_invalid_op_vxvc(env, 0, GETPC());                         \
     }                                                                   \
                                                                         \
     if (float128_lt(xa.f128, xb.f128, &env->fp_status)) {               \
@@ -2617,7 +2636,7 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
         xt.fld = tp##_##op(xa.fld, xb.fld, &env->fp_status);                  \
         if (unlikely(tp##_is_signaling_nan(xa.fld, &env->fp_status) ||        \
                      tp##_is_signaling_nan(xb.fld, &env->fp_status))) {       \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);            \
+            float_invalid_op_vxsnan(env, GETPC());                            \
         }                                                                     \
     }                                                                         \
                                                                               \
@@ -2660,7 +2679,7 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
                                                                               \
     vex_flag = fpscr_ve & vxsnan_flag;                                        \
     if (vxsnan_flag) {                                                        \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);            \
+        float_invalid_op_vxsnan(env, GETPC());                                \
     }                                                                         \
     if (!vex_flag) {                                                          \
         putVSR(rD(opcode) + 32, &xt, env);                                    \
@@ -2715,7 +2734,7 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
                                                                               \
     vex_flag = fpscr_ve & vxsnan_flag;                                        \
     if (vxsnan_flag) {                                                        \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);            \
+        float_invalid_op_vxsnan(env, GETPC());                                \
     }                                                                         \
     if (!vex_flag) {                                                          \
         putVSR(rD(opcode) + 32, &xt, env);                                    \
@@ -2751,10 +2770,10 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
                      tp##_is_any_nan(xb.fld))) {                          \
             if (tp##_is_signaling_nan(xa.fld, &env->fp_status) ||         \
                 tp##_is_signaling_nan(xb.fld, &env->fp_status)) {         \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);    \
+                float_invalid_op_vxsnan(env, GETPC());                    \
             }                                                             \
             if (svxvc) {                                                  \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXVC, 0);      \
+                float_invalid_op_vxvc(env, 0, GETPC());                   \
             }                                                             \
             xt.fld = 0;                                                   \
             all_true = 0;                                                 \
@@ -2807,7 +2826,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                \
         xt.tfld = stp##_to_##ttp(xb.sfld, &env->fp_status);        \
         if (unlikely(stp##_is_signaling_nan(xb.sfld,               \
                                             &env->fp_status))) {   \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0); \
+            float_invalid_op_vxsnan(env, GETPC());                 \
             xt.tfld = ttp##_snan_to_qnan(xt.tfld);                 \
         }                                                          \
         if (sfprf) {                                               \
@@ -2846,7 +2865,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
         xt.tfld = stp##_to_##ttp(xb.sfld, &env->fp_status);             \
         if (unlikely(stp##_is_signaling_nan(xb.sfld,                    \
                                             &env->fp_status))) {        \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);      \
+            float_invalid_op_vxsnan(env, GETPC());                      \
             xt.tfld = ttp##_snan_to_qnan(xt.tfld);                      \
         }                                                               \
         if (sfprf) {                                                    \
@@ -2883,7 +2902,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                \
         xt.tfld = stp##_to_##ttp(xb.sfld, 1, &env->fp_status);     \
         if (unlikely(stp##_is_signaling_nan(xb.sfld,               \
                                             &env->fp_status))) {   \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0); \
+            float_invalid_op_vxsnan(env, GETPC());                 \
             xt.tfld = ttp##_snan_to_qnan(xt.tfld);                 \
         }                                                          \
         if (sfprf) {                                               \
@@ -2919,9 +2938,8 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode)
 
     xt.VsrD(0) = float128_to_float64(xb.f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
-    if (unlikely(float128_is_signaling_nan(xb.f128,
-                                           &tstat))) {
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);
+    if (unlikely(float128_is_signaling_nan(xb.f128, &tstat))) {
+        float_invalid_op_vxsnan(env, GETPC());
         xt.VsrD(0) = float64_snan_to_qnan(xt.VsrD(0));
     }
     helper_compute_fprf_float64(env, xt.VsrD(0));
@@ -2967,15 +2985,15 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
     for (i = 0; i < nels; i++) {                                             \
         if (unlikely(stp##_is_any_nan(xb.sfld))) {                           \
             if (stp##_is_signaling_nan(xb.sfld, &env->fp_status)) {          \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);       \
+                float_invalid_op_vxsnan(env, GETPC());                       \
             }                                                                \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, 0);            \
+            float_invalid_op_vxcvi(env, 0, GETPC());                         \
             xt.tfld = rnan;                                                  \
         } else {                                                             \
             xt.tfld = stp##_to_##ttp##_round_to_zero(xb.sfld,                \
                           &env->fp_status);                                  \
             if (env->fp_status.float_exception_flags & float_flag_invalid) { \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, 0);        \
+                float_invalid_op_vxcvi(env, 0, GETPC());                     \
             }                                                                \
         }                                                                    \
     }                                                                        \
@@ -3020,15 +3038,15 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
                                                                              \
     if (unlikely(stp##_is_any_nan(xb.sfld))) {                               \
         if (stp##_is_signaling_nan(xb.sfld, &env->fp_status)) {              \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);           \
+            float_invalid_op_vxsnan(env, GETPC());                           \
         }                                                                    \
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, 0);                \
+        float_invalid_op_vxcvi(env, 0, GETPC());                             \
         xt.tfld = rnan;                                                      \
     } else {                                                                 \
         xt.tfld = stp##_to_##ttp##_round_to_zero(xb.sfld,                    \
                       &env->fp_status);                                      \
         if (env->fp_status.float_exception_flags & float_flag_invalid) {     \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, 0);            \
+            float_invalid_op_vxcvi(env, 0, GETPC());                         \
         }                                                                    \
     }                                                                        \
                                                                              \
@@ -3144,7 +3162,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                    \
     for (i = 0; i < nels; i++) {                                       \
         if (unlikely(tp##_is_signaling_nan(xb.fld,                     \
                                            &env->fp_status))) {        \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);     \
+            float_invalid_op_vxsnan(env, GETPC());                     \
             xt.fld = tp##_snan_to_qnan(xb.fld);                        \
         } else {                                                       \
             xt.fld = tp##_round_to_int(xb.fld, &env->fp_status);       \
@@ -3373,7 +3391,7 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         if (float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);
+            float_invalid_op_vxsnan(env, GETPC());
             xt.f128 = float128_snan_to_qnan(xt.f128);
         }
     }
@@ -3433,7 +3451,7 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode)
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         if (float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);
+            float_invalid_op_vxsnan(env, GETPC());
             xt.f128 = float128_snan_to_qnan(xt.f128);
         }
     }
@@ -3464,12 +3482,12 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         if (float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            float_invalid_op_vxsnan(env, GETPC());
             xt.f128 = float128_snan_to_qnan(xb.f128);
         } else if  (float128_is_quiet_nan(xb.f128, &tstat)) {
             xt.f128 = xb.f128;
         } else if (float128_is_neg(xb.f128) && !float128_is_zero(xb.f128)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, 1);
+            float_invalid_op_vxsqrt(env, 1, GETPC());
             xt.f128 = float128_default_nan(&env->fp_status);
         }
     }
@@ -3500,10 +3518,10 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f128)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
+            float_invalid_op_vxisi(env, 1, GETPC());
         } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
                    float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            float_invalid_op_vxsnan(env, GETPC());
         }
     }
 
-- 
2.17.1
