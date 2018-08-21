Received: from eggs.gnu.org ([2001:4830:134:3::10]:56353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMk-00044q-Tj
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMi-0000GS-Ik
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:02 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:21 +1000
Message-Id: <20180821043343.7514-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/26] target/ppc: Honor fpscr_ze semantics and
 tidy fdiv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

Divide by zero, exception taken, leaves the destination register
unmodified.  Therefore we must raise the exception before returning
from helper_fdiv.  Move the check from do_float_check_status into
helper_fdiv.

At the same time, tidy the invalid exception checking so that we
rely on softfloat for initial argument validation, and select the
kind of invalid operand exception only when we know we must.

At the same time, pass and return float64 values directly rather
than bounce through the CPU_DoubleU union.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 50 +++++++++++++++++++++++------------------
 target/ppc/helper.h     |  2 +-
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 9b39c4b3e5..c20b9ae672 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -545,9 +545,7 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
     int status = get_float_exception_flags(&env->fp_status);
     bool inexact_happened = false;
 
-    if (status & float_flag_divbyzero) {
-        float_zero_divide_excp(env, raddr);
-    } else if (status & float_flag_overflow) {
+    if (status & float_flag_overflow) {
         float_overflow_excp(env);
     } else if (status & float_flag_underflow) {
         float_underflow_excp(env);
@@ -661,30 +659,32 @@ uint64_t helper_fmul(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
 }
 
 /* fdiv - fdiv. */
-uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
+float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
 {
-    CPU_DoubleU farg1, farg2;
-
-    farg1.ll = arg1;
-    farg2.ll = arg2;
+    float64 ret = float64_div(arg1, arg2, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    if (unlikely(float64_is_infinity(farg1.d) &&
-                 float64_is_infinity(farg2.d))) {
-        /* Division of infinity by infinity */
-        farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIDI, 1);
-    } else if (unlikely(float64_is_zero(farg1.d) && float64_is_zero(farg2.d))) {
-        /* Division of zero by zero */
-        farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXZDZ, 1);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status))) {
-            /* sNaN division */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+    if (unlikely(status)) {
+        if (status & float_flag_invalid) {
+            /* Determine what kind of invalid operation was seen.  */
+            if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
+                /* Division of infinity by infinity */
+                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIDI, 1);
+            } else if (float64_is_zero(arg1) && float64_is_zero(arg2)) {
+                /* Division of zero by zero */
+                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXZDZ, 1);
+            } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
+                       float64_is_signaling_nan(arg2, &env->fp_status)) {
+                /* sNaN division */
+                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            }
+        }
+        if (status & float_flag_divbyzero) {
+            float_zero_divide_excp(env, GETPC());
         }
-        farg1.d = float64_div(farg1.d, farg2.d, &env->fp_status);
     }
 
-    return farg1.ll;
+    return ret;
 }
 
 
@@ -1928,6 +1928,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
                 tp##_is_signaling_nan(xb.fld, &tstat)) {                      \
                 float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, sfprf);    \
             }                                                                 \
+        }                                                                     \
+        if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {   \
+            float_zero_divide_excp(env, GETPC());                             \
         }                                                                     \
                                                                               \
         if (r2sp) {                                                           \
@@ -1978,6 +1981,9 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
             float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
         }
     }
+    if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {
+        float_zero_divide_excp(env, GETPC());
+    }
 
     helper_compute_fprf_float128(env, xt.f128);
     putVSR(rD(opcode) + 32, &xt, env);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5706c2497f..1c453fa0f7 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -88,7 +88,7 @@ DEF_HELPER_2(frim, i64, env, i64)
 DEF_HELPER_3(fadd, i64, env, i64, i64)
 DEF_HELPER_3(fsub, i64, env, i64, i64)
 DEF_HELPER_3(fmul, i64, env, i64, i64)
-DEF_HELPER_3(fdiv, i64, env, i64, i64)
+DEF_HELPER_3(fdiv, f64, env, f64, f64)
 DEF_HELPER_4(fmadd, i64, env, i64, i64, i64)
 DEF_HELPER_4(fmsub, i64, env, i64, i64, i64)
 DEF_HELPER_4(fnmadd, i64, env, i64, i64, i64)
-- 
2.17.1
