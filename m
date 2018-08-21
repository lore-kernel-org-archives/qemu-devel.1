Received: from eggs.gnu.org ([2001:4830:134:3::10]:56422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMp-00047R-7S
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMl-0000Ip-2N
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:06 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:23 +1000
Message-Id: <20180821043343.7514-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/26] target/ppc: Tidy helper_fadd, helper_fsub
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

Tidy the invalid exception checking so that we rely on softfloat for
initial argument validation, and select the kind of invalid operand
exception only when we know we must.  Pass and return float64 values
directly rather than bounce through the CPU_DoubleU union.

Note that because we know float_flag_invalid was set, we do not have
to re-check the signs of the infinities.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 50 +++++++++++++++++------------------------
 target/ppc/helper.h     |  4 ++--
 2 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index b9ee46eb5f..7758372ecd 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -587,51 +587,43 @@ void helper_reset_fpstatus(CPUPPCState *env)
 }
 
 /* fadd - fadd. */
-uint64_t helper_fadd(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
+float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
 {
-    CPU_DoubleU farg1, farg2;
-
-    farg1.ll = arg1;
-    farg2.ll = arg2;
+    float64 ret = float64_add(arg1, arg2, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    if (unlikely(float64_is_infinity(farg1.d) && float64_is_infinity(farg2.d) &&
-                 float64_is_neg(farg1.d) != float64_is_neg(farg2.d))) {
-        /* Magnitude subtraction of infinities */
-        farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status))) {
+    if (unlikely(status & float_flag_invalid)) {
+        if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
+            /* Magnitude subtraction of infinities */
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
+        } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
+                   float64_is_signaling_nan(arg2, &env->fp_status)) {
             /* sNaN addition */
             float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
         }
-        farg1.d = float64_add(farg1.d, farg2.d, &env->fp_status);
     }
 
-    return farg1.ll;
+    return ret;
 }
 
 /* fsub - fsub. */
-uint64_t helper_fsub(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
+float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
 {
-    CPU_DoubleU farg1, farg2;
-
-    farg1.ll = arg1;
-    farg2.ll = arg2;
+    float64 ret = float64_sub(arg1, arg2, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    if (unlikely(float64_is_infinity(farg1.d) && float64_is_infinity(farg2.d) &&
-                 float64_is_neg(farg1.d) == float64_is_neg(farg2.d))) {
-        /* Magnitude subtraction of infinities */
-        farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status))) {
-            /* sNaN subtraction */
+    if (unlikely(status & float_flag_invalid)) {
+        if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
+            /* Magnitude subtraction of infinities */
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
+        } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
+                   float64_is_signaling_nan(arg2, &env->fp_status)) {
+            /* sNaN addition */
             float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
         }
-        farg1.d = float64_sub(farg1.d, farg2.d, &env->fp_status);
     }
 
-    return farg1.ll;
+    return ret;
 }
 
 /* fmul - fmul. */
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index e4f7c55db9..d81806dd2c 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -85,8 +85,8 @@ DEF_HELPER_2(friz, i64, env, i64)
 DEF_HELPER_2(frip, i64, env, i64)
 DEF_HELPER_2(frim, i64, env, i64)
 
-DEF_HELPER_3(fadd, i64, env, i64, i64)
-DEF_HELPER_3(fsub, i64, env, i64, i64)
+DEF_HELPER_3(fadd, f64, env, f64, f64)
+DEF_HELPER_3(fsub, f64, env, f64, f64)
 DEF_HELPER_3(fmul, f64, env, f64, f64)
 DEF_HELPER_3(fdiv, f64, env, f64, f64)
 DEF_HELPER_4(fmadd, i64, env, i64, i64, i64)
-- 
2.17.1
