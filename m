Received: from eggs.gnu.org ([2001:4830:134:3::10]:54269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkar-0001oQ-Oz
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkaq-0002JV-HV
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:13 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:41803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAkao-0002Ga-BJ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:12 -0400
Received: by mail-pg1-x52b.google.com with SMTP id 23-v6so4903914pgc.8
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:42:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 16:41:57 -0700
Message-Id: <20181011234159.11496-6-richard.henderson@linaro.org>
In-Reply-To: <20181011234159.11496-1-richard.henderson@linaro.org>
References: <20181011234159.11496-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/7] target/ppc: Split out float_invalid_op_mul
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/fpu_helper.c | 43 +++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 111ce12a37..ef251d062f 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -689,6 +689,17 @@ float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
     return ret;
 }
 
+static void float_invalid_op_mul(CPUPPCState *env, bool set_fprc,
+                                 uintptr_t retaddr, int classes)
+{
+    if ((classes & (is_zero | is_inf)) == (is_zero | is_inf)) {
+        /* Multiplication of zero by infinity */
+        float_invalid_op_vximz(env, set_fprc, retaddr);
+    } else if (classes & is_snan) {
+        float_invalid_op_vxsnan(env, retaddr);
+    }
+}
+
 /* fmul - fmul. */
 float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
 {
@@ -696,15 +707,9 @@ float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
     int status = get_float_exception_flags(&env->fp_status);
 
     if (unlikely(status & float_flag_invalid)) {
-        if ((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
-            (float64_is_zero(arg1) && float64_is_infinity(arg2))) {
-            /* Multiplication of zero by infinity */
-            float_invalid_op_vximz(env, 1, GETPC());
-        } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
-                   float64_is_signaling_nan(arg2, &env->fp_status)) {
-            /* sNaN multiplication */
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_mul(env, 1, GETPC(),
+                             float64_classify(arg1) |
+                             float64_classify(arg2));
     }
 
     return ret;
@@ -1886,13 +1891,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
                                                                              \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
-            if ((tp##_is_infinity(xa.fld) && tp##_is_zero(xb.fld)) ||        \
-                (tp##_is_infinity(xb.fld) && tp##_is_zero(xa.fld))) {        \
-                float_invalid_op_vximz(env, sfprf, GETPC());                 \
-            } else if (tp##_is_signaling_nan(xa.fld, &tstat) ||              \
-                       tp##_is_signaling_nan(xb.fld, &tstat)) {              \
-                float_invalid_op_vxsnan(env, GETPC());                       \
-            }                                                                \
+            float_invalid_op_mul(env, sfprf, GETPC(),                        \
+                                 tp##_classify(xa.fld) |                     \
+                                 tp##_classify(xb.fld));                     \
         }                                                                    \
                                                                              \
         if (r2sp) {                                                          \
@@ -1933,13 +1934,9 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if ((float128_is_infinity(xa.f128) && float128_is_zero(xb.f128)) ||
-            (float128_is_infinity(xb.f128) && float128_is_zero(xa.f128))) {
-            float_invalid_op_vximz(env, 1, GETPC());
-        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
-                   float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_mul(env, 1, GETPC(),
+                             float128_classify(xa.f128) |
+                             float128_classify(xb.f128));
     }
     helper_compute_fprf_float128(env, xt.f128);
 
-- 
2.17.1
