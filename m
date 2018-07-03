Received: from eggs.gnu.org ([2001:4830:134:3::10]:57696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3n-0006Ia-HR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3k-0000Nk-99
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:41 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:44464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1faN3k-0000NB-3I
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:40 -0400
Received: by mail-pf0-x242.google.com with SMTP id j3-v6so1169497pfh.11
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:17:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  3 Jul 2018 08:17:28 -0700
Message-Id: <20180703151732.29843-4-richard.henderson@linaro.org>
In-Reply-To: <20180703151732.29843-1-richard.henderson@linaro.org>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/7] target/ppc: Tidy helper_fmul
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
 target/ppc/fpu_helper.c | 25 +++++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 151437d8fc..7ddbc0fc19 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -87,7 +87,7 @@ DEF_HELPER_2(frim, i64, env, i64)
 
 DEF_HELPER_3(fadd, i64, env, i64, i64)
 DEF_HELPER_3(fsub, i64, env, i64, i64)
-DEF_HELPER_3(fmul, i64, env, i64, i64)
+DEF_HELPER_3(fmul, f64, env, f64, f64)
 DEF_HELPER_3(fdiv, f64, env, f64, f64)
 DEF_HELPER_4(fmadd, i64, env, i64, i64, i64)
 DEF_HELPER_4(fmsub, i64, env, i64, i64, i64)
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 0df7e31c10..5642734b5b 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -627,27 +627,24 @@ uint64_t helper_fsub(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
 }
 
 /* fmul - fmul. */
-uint64_t helper_fmul(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
+float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
 {
-    CPU_DoubleU farg1, farg2;
+    float64 ret = float64_mul(arg1, arg2, &env->fp_status);
+    int status = get_float_exception_flags(&env->fp_status);
 
-    farg1.ll = arg1;
-    farg2.ll = arg2;
-
-    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.d)) ||
-                 (float64_is_zero(farg1.d) && float64_is_infinity(farg2.d)))) {
-        /* Multiplication of zero by infinity */
-        farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status))) {
+    if (unlikely(status & float_flag_invalid)) {
+        if ((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
+            (float64_is_zero(arg1) && float64_is_infinity(arg2))) {
+            /* Multiplication of zero by infinity */
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
+        } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
+                   float64_is_signaling_nan(arg2, &env->fp_status)) {
             /* sNaN multiplication */
             float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
         }
-        farg1.d = float64_mul(farg1.d, farg2.d, &env->fp_status);
     }
 
-    return farg1.ll;
+    return ret;
 }
 
 /* fdiv - fdiv. */
-- 
2.17.1
