Received: from eggs.gnu.org ([2001:4830:134:3::10]:54302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkat-0001pQ-4J
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkaq-0002KD-VO
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:15 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:34587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAkaq-0002IZ-LA
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id f18-v6so4985337plr.1
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:42:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 16:41:59 -0700
Message-Id: <20181011234159.11496-8-richard.henderson@linaro.org>
In-Reply-To: <20181011234159.11496-1-richard.henderson@linaro.org>
References: <20181011234159.11496-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 7/7] target/ppc: Split out float_invalid_cvt
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
 target/ppc/fpu_helper.c | 67 +++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 127c08bcec..2ed4f42275 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -750,30 +750,30 @@ float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
     return ret;
 }
 
+static void float_invalid_cvt(CPUPPCState *env, bool set_fprc,
+                              uintptr_t retaddr, int class1)
+{
+    float_invalid_op_vxcvi(env, set_fprc, retaddr);
+    if (class1 & is_snan) {
+        float_invalid_op_vxsnan(env, retaddr);
+    }
+}
 
 #define FPU_FCTI(op, cvt, nanval)                                      \
-uint64_t helper_##op(CPUPPCState *env, uint64_t arg)                   \
+uint64_t helper_##op(CPUPPCState *env, float64 arg)                    \
 {                                                                      \
-    CPU_DoubleU farg;                                                  \
+    uint64_t ret = float64_to_##cvt(arg, &env->fp_status);             \
+    int status = get_float_exception_flags(&env->fp_status);           \
                                                                        \
-    farg.ll = arg;                                                     \
-    farg.ll = float64_to_##cvt(farg.d, &env->fp_status);               \
-                                                                       \
-    if (unlikely(env->fp_status.float_exception_flags)) {              \
-        if (float64_is_any_nan(arg)) {                                 \
-            float_invalid_op_vxcvi(env, 1, GETPC());                   \
-            if (float64_is_signaling_nan(arg, &env->fp_status)) {      \
-                float_invalid_op_vxsnan(env, GETPC());                 \
-            }                                                          \
-            farg.ll = nanval;                                          \
-        } else if (env->fp_status.float_exception_flags &              \
-                   float_flag_invalid) {                               \
-            float_invalid_op_vxcvi(env, 1, GETPC());                   \
+    if (unlikely(status)) {                                            \
+        if (status & float_flag_invalid) {                             \
+            float_invalid_cvt(env, 1, GETPC(), float64_classify(arg)); \
+            ret = nanval;                                              \
         }                                                              \
         do_float_check_status(env, GETPC());                           \
     }                                                                  \
-    return farg.ll;                                                    \
- }
+    return ret;                                                        \
+}
 
 FPU_FCTI(fctiw, int32, 0x80000000U)
 FPU_FCTI(fctiwz, int32_round_to_zero, 0x80000000U)
@@ -2965,6 +2965,7 @@ uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_t xb)
 #define VSX_CVT_FP_TO_INT(op, nels, stp, ttp, sfld, tfld, rnan)              \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
 {                                                                            \
+    int all_flags = env->fp_status.float_exception_flags, flags;             \
     ppc_vsr_t xt, xb;                                                        \
     int i;                                                                   \
                                                                              \
@@ -2972,22 +2973,18 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
     getVSR(xT(opcode), &xt, env);                                            \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
-        if (unlikely(stp##_is_any_nan(xb.sfld))) {                           \
-            if (stp##_is_signaling_nan(xb.sfld, &env->fp_status)) {          \
-                float_invalid_op_vxsnan(env, GETPC());                       \
-            }                                                                \
-            float_invalid_op_vxcvi(env, 0, GETPC());                         \
+        env->fp_status.float_exception_flags = 0;                            \
+        xt.tfld = stp##_to_##ttp##_round_to_zero(xb.sfld, &env->fp_status);  \
+        flags = env->fp_status.float_exception_flags;                        \
+        if (unlikely(flags & float_flag_invalid)) {                          \
+            float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb.sfld));     \
             xt.tfld = rnan;                                                  \
-        } else {                                                             \
-            xt.tfld = stp##_to_##ttp##_round_to_zero(xb.sfld,                \
-                          &env->fp_status);                                  \
-            if (env->fp_status.float_exception_flags & float_flag_invalid) { \
-                float_invalid_op_vxcvi(env, 0, GETPC());                     \
-            }                                                                \
         }                                                                    \
+        all_flags |= flags;                                                  \
     }                                                                        \
                                                                              \
     putVSR(xT(opcode), &xt, env);                                            \
+    env->fp_status.float_exception_flags = all_flags;                        \
     do_float_check_status(env, GETPC());                                     \
 }
 
@@ -3025,18 +3022,10 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
     getVSR(rB(opcode) + 32, &xb, env);                                       \
     memset(&xt, 0, sizeof(xt));                                              \
                                                                              \
-    if (unlikely(stp##_is_any_nan(xb.sfld))) {                               \
-        if (stp##_is_signaling_nan(xb.sfld, &env->fp_status)) {              \
-            float_invalid_op_vxsnan(env, GETPC());                           \
-        }                                                                    \
-        float_invalid_op_vxcvi(env, 0, GETPC());                             \
+    xt.tfld = stp##_to_##ttp##_round_to_zero(xb.sfld, &env->fp_status);      \
+    if (env->fp_status.float_exception_flags & float_flag_invalid) {         \
+        float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb.sfld));         \
         xt.tfld = rnan;                                                      \
-    } else {                                                                 \
-        xt.tfld = stp##_to_##ttp##_round_to_zero(xb.sfld,                    \
-                      &env->fp_status);                                      \
-        if (env->fp_status.float_exception_flags & float_flag_invalid) {     \
-            float_invalid_op_vxcvi(env, 0, GETPC());                         \
-        }                                                                    \
     }                                                                        \
                                                                              \
     putVSR(rD(opcode) + 32, &xt, env);                                       \
-- 
2.17.1
