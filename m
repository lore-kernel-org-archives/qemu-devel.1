Received: from eggs.gnu.org ([2001:4830:134:3::10]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkat-0001po-Fw
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkaq-0002K1-St
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:15 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:33528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAkaq-0002Hj-IP
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id s4-v6so4986189plp.0
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:42:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 16:41:58 -0700
Message-Id: <20181011234159.11496-7-richard.henderson@linaro.org>
In-Reply-To: <20181011234159.11496-1-richard.henderson@linaro.org>
References: <20181011234159.11496-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/7] target/ppc: Split out float_invalid_op_div
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
 target/ppc/fpu_helper.c | 52 +++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index ef251d062f..127c08bcec 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -715,6 +715,21 @@ float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
     return ret;
 }
 
+static void float_invalid_op_div(CPUPPCState *env, bool set_fprc,
+                                 uintptr_t retaddr, int classes)
+{
+    classes &= ~is_neg;
+    if (classes == is_inf) {
+        /* Division of infinity by infinity */
+        float_invalid_op_vxidi(env, set_fprc, retaddr);
+    } else if (classes == is_zero) {
+        /* Division of zero by zero */
+        float_invalid_op_vxzdz(env, set_fprc, retaddr);
+    } else if (classes & is_snan) {
+        float_invalid_op_vxsnan(env, retaddr);
+    }
+}
+
 /* fdiv - fdiv. */
 float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
 {
@@ -723,18 +738,9 @@ float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
 
     if (unlikely(status)) {
         if (status & float_flag_invalid) {
-            /* Determine what kind of invalid operation was seen.  */
-            if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
-                /* Division of infinity by infinity */
-                float_invalid_op_vxidi(env, 1, GETPC());
-            } else if (float64_is_zero(arg1) && float64_is_zero(arg2)) {
-                /* Division of zero by zero */
-                float_invalid_op_vxzdz(env, 1, GETPC());
-            } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
-                       float64_is_signaling_nan(arg2, &env->fp_status)) {
-                /* sNaN division */
-                float_invalid_op_vxsnan(env, GETPC());
-            }
+            float_invalid_op_div(env, 1, GETPC(),
+                                 float64_classify(arg1) |
+                                 float64_classify(arg2));
         }
         if (status & float_flag_divbyzero) {
             float_zero_divide_excp(env, GETPC());
@@ -1969,14 +1975,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags;  \
                                                                               \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {     \
-            if (tp##_is_infinity(xa.fld) && tp##_is_infinity(xb.fld)) {       \
-                float_invalid_op_vxidi(env, sfprf, GETPC());                  \
-            } else if (tp##_is_zero(xa.fld) && tp##_is_zero(xb.fld)) {        \
-                float_invalid_op_vxzdz(env, sfprf, GETPC());                  \
-            } else if (tp##_is_signaling_nan(xa.fld, &tstat) ||               \
-                       tp##_is_signaling_nan(xb.fld, &tstat)) {               \
-                float_invalid_op_vxsnan(env, GETPC());                        \
-            }                                                                 \
+            float_invalid_op_div(env, sfprf, GETPC(),                         \
+                                 tp##_classify(xa.fld) |                      \
+                                 tp##_classify(xb.fld));                      \
         }                                                                     \
         if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {   \
             float_zero_divide_excp(env, GETPC());                             \
@@ -2020,14 +2021,9 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f128)) {
-            float_invalid_op_vxidi(env, 1, GETPC());
-        } else if (float128_is_zero(xa.f128) && float128_is_zero(xb.f128)) {
-            float_invalid_op_vxzdz(env, 1, GETPC());
-        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
-                   float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_div(env, 1, GETPC(),
+                             float128_classify(xa.f128) |
+                             float128_classify(xb.f128));
     }
     if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {
         float_zero_divide_excp(env, GETPC());
-- 
2.17.1
