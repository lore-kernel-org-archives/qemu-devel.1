Received: from eggs.gnu.org ([2001:4830:134:3::10]:56305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMh-00041f-Jd
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMg-0000E0-6Z
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:33:59 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:24 +1000
Message-Id: <20180821043343.7514-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/26] target/ppc: Tidy helper_fsqrt
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 29 ++++++++++++++---------------
 target/ppc/helper.h     |  2 +-
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 7758372ecd..44f3fed17d 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -858,25 +858,24 @@ uint64_t helper_frsp(CPUPPCState *env, uint64_t arg)
 }
 
 /* fsqrt - fsqrt. */
-uint64_t helper_fsqrt(CPUPPCState *env, uint64_t arg)
+float64 helper_fsqrt(CPUPPCState *env, float64 arg)
 {
-    CPU_DoubleU farg;
-
-    farg.ll = arg;
+    float64 ret = float64_sqrt(arg, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    if (unlikely(float64_is_any_nan(farg.d))) {
-        if (unlikely(float64_is_signaling_nan(farg.d, &env->fp_status))) {
-            /* sNaN reciprocal square root */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-            farg.ll = float64_snan_to_qnan(farg.ll);
+    if (unlikely(status & float_flag_invalid)) {
+        if (unlikely(float64_is_any_nan(arg))) {
+            if (unlikely(float64_is_signaling_nan(arg, &env->fp_status))) {
+                /* sNaN square root */
+                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            }
+        } else {
+            /* Square root of a negative nonzero number */
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, 1);
         }
-    } else if (unlikely(float64_is_neg(farg.d) && !float64_is_zero(farg.d))) {
-        /* Square root of a negative nonzero number */
-        farg.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, 1);
-    } else {
-        farg.d = float64_sqrt(farg.d, &env->fp_status);
     }
-    return farg.ll;
+
+    return ret;
 }
 
 /* fre - fre. */
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index d81806dd2c..7ed72c2337 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -93,7 +93,7 @@ DEF_HELPER_4(fmadd, i64, env, i64, i64, i64)
 DEF_HELPER_4(fmsub, i64, env, i64, i64, i64)
 DEF_HELPER_4(fnmadd, i64, env, i64, i64, i64)
 DEF_HELPER_4(fnmsub, i64, env, i64, i64, i64)
-DEF_HELPER_2(fsqrt, i64, env, i64)
+DEF_HELPER_2(fsqrt, f64, env, f64)
 DEF_HELPER_2(fre, i64, env, i64)
 DEF_HELPER_2(fres, i64, env, i64)
 DEF_HELPER_2(frsqrte, i64, env, i64)
-- 
2.17.1
