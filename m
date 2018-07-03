Received: from eggs.gnu.org ([2001:4830:134:3::10]:57650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3k-0006IR-3K
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3i-0000Mh-L5
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:40 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1faN3i-0000MG-FI
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:38 -0400
Received: by mail-pg0-x244.google.com with SMTP id c10-v6so1126279pgu.9
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:17:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  3 Jul 2018 08:17:27 -0700
Message-Id: <20180703151732.29843-3-richard.henderson@linaro.org>
In-Reply-To: <20180703151732.29843-1-richard.henderson@linaro.org>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/7] target/ppc: Honor fpscr_ze semantics and
 tidy fdiv
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
from helper_fdiv.  Move the check from do_float_check_status into
helper_fdiv.

At the same time, tidy the invalid exception checking so that we
rely on softfloat for initial argument validation, and select the
kind of invalid operand exception only when we know we must.

At the same time, pass and return float64 values directly rather
than bounce through the CPU_DoubleU union.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h     |  2 +-
 target/ppc/fpu_helper.c | 44 ++++++++++++++++++++---------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index d751f0e219..151437d8fc 100644
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
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 119826b5a7..0df7e31c10 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -543,9 +543,7 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
     CPUState *cs = CPU(ppc_env_get_cpu(env));
     int status = get_float_exception_flags(&env->fp_status);
 
-    if (status & float_flag_divbyzero) {
-        float_zero_divide_excp(env, raddr);
-    } else if (status & float_flag_overflow) {
+    if (status & float_flag_overflow) {
         float_overflow_excp(env);
     } else if (status & float_flag_underflow) {
         float_underflow_excp(env);
@@ -653,30 +651,32 @@ uint64_t helper_fmul(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
 }
 
 /* fdiv - fdiv. */
-uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
+float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
 {
-    CPU_DoubleU farg1, farg2;
+    float64 ret = float64_div(arg1, arg2, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    farg1.ll = arg1;
-    farg2.ll = arg2;
-
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
 
 
-- 
2.17.1
