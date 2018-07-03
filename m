Received: from eggs.gnu.org ([2001:4830:134:3::10]:57750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3o-0006JX-P8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3n-0000Q2-L2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:44 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:34385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1faN3n-0000PS-FT
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:43 -0400
Received: by mail-pg0-x229.google.com with SMTP id y5-v6so1134244pgv.1
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:17:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  3 Jul 2018 08:17:30 -0700
Message-Id: <20180703151732.29843-6-richard.henderson@linaro.org>
In-Reply-To: <20180703151732.29843-1-richard.henderson@linaro.org>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/7] target/ppc: Tidy helper_fsqrt
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

Tidy the invalid exception checking so that we rely on softfloat for
initial argument validation, and select the kind of invalid operand
exception only when we know we must.  Pass and return float64 values
directly rather than bounce through the CPU_DoubleU union.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h     |  2 +-
 target/ppc/fpu_helper.c | 29 ++++++++++++++---------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3262e2feaf..cc3d031407 100644
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
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 2d56c93498..c8a2dd6408 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -850,25 +850,24 @@ uint64_t helper_frsp(CPUPPCState *env, uint64_t arg)
 }
 
 /* fsqrt - fsqrt. */
-uint64_t helper_fsqrt(CPUPPCState *env, uint64_t arg)
+float64 helper_fsqrt(CPUPPCState *env, float64 arg)
 {
-    CPU_DoubleU farg;
+    float64 ret = float64_sqrt(arg, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    farg.ll = arg;
-
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
-- 
2.17.1
