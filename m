Received: from eggs.gnu.org ([2001:4830:134:3::10]:56420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMp-00047P-7K
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMl-0000It-2v
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:06 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:25 +1000
Message-Id: <20180821043343.7514-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/26] target/ppc: Honor fpscr_ze semantics and
 tidy fre, fresqrt
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
from the respective helpers.

>From helper_fre, divide by zero exception not taken, return the
documented +/- 0.5.

At the same time, tidy the invalid exception checking so that we
rely on softfloat for initial argument validation, and select the
kind of invalid operand exception only when we know we must.

At the same time, pass and return float64 values directly rather
than bounce through the CPU_DoubleU union.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 62 ++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 44f3fed17d..5af5241ab0 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -879,18 +879,27 @@ float64 helper_fsqrt(CPUPPCState *env, float64 arg)
 }
 
 /* fre - fre. */
-uint64_t helper_fre(CPUPPCState *env, uint64_t arg)
+float64 helper_fre(CPUPPCState *env, float64 arg)
 {
-    CPU_DoubleU farg;
-
-    farg.ll = arg;
+    /* "Estimate" the reciprocal with actual division.  */
+    float64 ret = float64_div(float64_one, arg, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    if (unlikely(float64_is_signaling_nan(farg.d, &env->fp_status))) {
-        /* sNaN reciprocal */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+    if (unlikely(status)) {
+        if (status & float_flag_invalid) {
+            if (float64_is_signaling_nan(arg, &env->fp_status)) {
+                /* sNaN reciprocal */
+                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            }
+        }
+        if (status & float_flag_divbyzero) {
+            float_zero_divide_excp(env, GETPC());
+            /* For FPSCR.ZE == 0, the result is 1/2.  */
+            ret = float64_set_sign(float64_half, float64_is_neg(arg));
+        }
     }
-    farg.d = float64_div(float64_one, farg.d, &env->fp_status);
-    return farg.d;
+
+    return ret;
 }
 
 /* fres - fres. */
@@ -913,27 +922,30 @@ uint64_t helper_fres(CPUPPCState *env, uint64_t arg)
 }
 
 /* frsqrte  - frsqrte. */
-uint64_t helper_frsqrte(CPUPPCState *env, uint64_t arg)
+float64 helper_frsqrte(CPUPPCState *env, float64 arg)
 {
-    CPU_DoubleU farg;
-
-    farg.ll = arg;
+    /* "Estimate" the reciprocal with actual division.  */
+    float64 rets = float64_sqrt(arg, &env->fp_status);
+    float64 retd = float64_div(float64_one, rets, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    if (unlikely(float64_is_any_nan(farg.d))) {
-        if (unlikely(float64_is_signaling_nan(farg.d, &env->fp_status))) {
-            /* sNaN reciprocal square root */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-            farg.ll = float64_snan_to_qnan(farg.ll);
+    if (unlikely(status)) {
+        if (status & float_flag_invalid) {
+            if (float64_is_signaling_nan(arg, &env->fp_status)) {
+                /* sNaN reciprocal */
+                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            } else {
+                /* Square root of a negative nonzero number */
+                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, 1);
+            }
+        }
+        if (status & float_flag_divbyzero) {
+            /* Reciprocal of (square root of) zero.  */
+            float_zero_divide_excp(env, GETPC());
         }
-    } else if (unlikely(float64_is_neg(farg.d) && !float64_is_zero(farg.d))) {
-        /* Reciprocal square root of a negative nonzero number */
-        farg.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, 1);
-    } else {
-        farg.d = float64_sqrt(farg.d, &env->fp_status);
-        farg.d = float64_div(float64_one, farg.d, &env->fp_status);
     }
 
-    return farg.ll;
+    return retd;
 }
 
 /* fsel - fsel. */
-- 
2.17.1
