Received: from eggs.gnu.org ([2001:4830:134:3::10]:57819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3u-0006Q7-7q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3p-0000RJ-17
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:50 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1faN3o-0000Qg-S6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:44 -0400
Received: by mail-pf0-x242.google.com with SMTP id s21-v6so1178114pfm.6
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:17:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  3 Jul 2018 08:17:31 -0700
Message-Id: <20180703151732.29843-7-richard.henderson@linaro.org>
In-Reply-To: <20180703151732.29843-1-richard.henderson@linaro.org>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/7] target/ppc: Honor fpscr_ze semantics and
 tidy fre, fresqrt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

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
---
 target/ppc/fpu_helper.c | 62 ++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index c8a2dd6408..1e195487d3 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -871,18 +871,27 @@ float64 helper_fsqrt(CPUPPCState *env, float64 arg)
 }
 
 /* fre - fre. */
-uint64_t helper_fre(CPUPPCState *env, uint64_t arg)
+float64 helper_fre(CPUPPCState *env, float64 arg)
 {
-    CPU_DoubleU farg;
+    /* "Estimate" the reciprocal with actual division.  */
+    float64 ret = float64_div(float64_one, arg, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    farg.ll = arg;
-
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
@@ -905,27 +914,30 @@ uint64_t helper_fres(CPUPPCState *env, uint64_t arg)
 }
 
 /* frsqrte  - frsqrte. */
-uint64_t helper_frsqrte(CPUPPCState *env, uint64_t arg)
+float64 helper_frsqrte(CPUPPCState *env, float64 arg)
 {
-    CPU_DoubleU farg;
+    /* "Estimate" the reciprocal with actual division.  */
+    float64 rets = float64_sqrt(arg, &env->fp_status);
+    float64 retd = float64_div(float64_one, rets, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    farg.ll = arg;
-
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
