Received: from eggs.gnu.org ([2001:4830:134:3::10]:54268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkar-0001oP-OB
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkaq-0002In-B9
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:13 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:34585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAkao-0002FV-76
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:10 -0400
Received: by mail-pl1-x62f.google.com with SMTP id f18-v6so4985258plr.1
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:42:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 16:41:56 -0700
Message-Id: <20181011234159.11496-5-richard.henderson@linaro.org>
In-Reply-To: <20181011234159.11496-1-richard.henderson@linaro.org>
References: <20181011234159.11496-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/7] target/ppc: Split out
 float_invalid_op_addsub
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
 target/ppc/fpu_helper.c | 60 ++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 9ae55b1e93..111ce12a37 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -648,6 +648,17 @@ void helper_reset_fpstatus(CPUPPCState *env)
     set_float_exception_flags(0, &env->fp_status);
 }
 
+static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
+                                    uintptr_t retaddr, int classes)
+{
+    if ((classes & ~is_neg) == is_inf) {
+        /* Magnitude subtraction of infinities */
+        float_invalid_op_vxisi(env, set_fpcc, retaddr);
+    } else if (classes & is_snan) {
+        float_invalid_op_vxsnan(env, retaddr);
+    }
+}
+
 /* fadd - fadd. */
 float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
 {
@@ -655,14 +666,9 @@ float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
     int status = get_float_exception_flags(&env->fp_status);
 
     if (unlikely(status & float_flag_invalid)) {
-        if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
-            /* Magnitude subtraction of infinities */
-            float_invalid_op_vxisi(env, 1, GETPC());
-        } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
-                   float64_is_signaling_nan(arg2, &env->fp_status)) {
-            /* sNaN addition */
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_addsub(env, 1, GETPC(),
+                                float64_classify(arg1) |
+                                float64_classify(arg2));
     }
 
     return ret;
@@ -675,14 +681,9 @@ float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
     int status = get_float_exception_flags(&env->fp_status);
 
     if (unlikely(status & float_flag_invalid)) {
-        if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
-            /* Magnitude subtraction of infinities */
-            float_invalid_op_vxisi(env, 1, GETPC());
-        } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
-                   float64_is_signaling_nan(arg2, &env->fp_status)) {
-            /* sNaN addition */
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_addsub(env, 1, GETPC(),
+                                float64_classify(arg1) |
+                                float64_classify(arg2));
     }
 
     return ret;
@@ -1803,12 +1804,9 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                        \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
                                                                              \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
-            if (tp##_is_infinity(xa.fld) && tp##_is_infinity(xb.fld)) {      \
-                float_invalid_op_vxisi(env, sfprf, GETPC());                 \
-            } else if (tp##_is_signaling_nan(xa.fld, &tstat) ||              \
-                       tp##_is_signaling_nan(xb.fld, &tstat)) {              \
-                float_invalid_op_vxsnan(env, GETPC());                       \
-            }                                                                \
+            float_invalid_op_addsub(env, sfprf, GETPC(),                     \
+                                    tp##_classify(xa.fld) |                  \
+                                    tp##_classify(xb.fld));                  \
         }                                                                    \
                                                                              \
         if (r2sp) {                                                          \
@@ -1852,12 +1850,9 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f128)) {
-            float_invalid_op_vxisi(env, 1, GETPC());
-        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
-                   float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_addsub(env, 1, GETPC(),
+                                float128_classify(xa.f128) |
+                                float128_classify(xb.f128));
     }
 
     helper_compute_fprf_float128(env, xt.f128);
@@ -3518,12 +3513,9 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f128)) {
-            float_invalid_op_vxisi(env, 1, GETPC());
-        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
-                   float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_addsub(env, 1, GETPC(),
+                                float128_classify(xa.f128) |
+                                float128_classify(xb.f128));
     }
 
     helper_compute_fprf_float128(env, xt.f128);
-- 
2.17.1
