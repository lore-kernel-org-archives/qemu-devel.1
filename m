Received: from eggs.gnu.org ([2001:4830:134:3::10]:53384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciz0E-0000R4-Vi
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 02:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciz0B-0004zP-Pm
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 02:48:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ciz0B-0004ic-GJ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 02:48:47 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v217lFVP128696
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 02:47:58 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28wt7a81t4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 02:47:56 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 1 Mar 2017 13:14:31 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  1 Mar 2017 13:14:11 +0530
Message-Id: <1488354251-20802-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] target/ppc: rewrite f[n]m[add,
 sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Use the softfloat api for fused multiply-add. As we are using the fused
multiply-add, the intermediate result for setting VXISI is not
available.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c | 201 +++++++-----------------------------------------
 1 file changed, 29 insertions(+), 172 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 58aee64..1701b80 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -742,179 +742,36 @@ uint64_t helper_frim(CPUPPCState *env, uint64_t arg)
 {
     return do_fri(env, arg, float_round_down);
 }
-
-/* fmadd - fmadd. */
-uint64_t helper_fmadd(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
-                      uint64_t arg3)
-{
-    CPU_DoubleU farg1, farg2, farg3;
-
-    farg1.ll = arg1;
-    farg2.ll = arg2;
-    farg3.ll = arg3;
-
-    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.d)) ||
-                 (float64_is_zero(farg1.d) && float64_is_infinity(farg2.d)))) {
-        /* Multiplication of zero by infinity */
-        farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg3.d, &env->fp_status))) {
-            /* sNaN operation */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-        }
-        /* This is the way the PowerPC specification defines it */
-        float128 ft0_128, ft1_128;
-
-        ft0_128 = float64_to_float128(farg1.d, &env->fp_status);
-        ft1_128 = float64_to_float128(farg2.d, &env->fp_status);
-        ft0_128 = float128_mul(ft0_128, ft1_128, &env->fp_status);
-        if (unlikely(float128_is_infinity(ft0_128) &&
-                     float64_is_infinity(farg3.d) &&
-                     float128_is_neg(ft0_128) != float64_is_neg(farg3.d))) {
-            /* Magnitude subtraction of infinities */
-            farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
-        } else {
-            ft1_128 = float64_to_float128(farg3.d, &env->fp_status);
-            ft0_128 = float128_add(ft0_128, ft1_128, &env->fp_status);
-            farg1.d = float128_to_float64(ft0_128, &env->fp_status);
-        }
-    }
-
-    return farg1.ll;
-}
-
-/* fmsub - fmsub. */
-uint64_t helper_fmsub(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
-                      uint64_t arg3)
-{
-    CPU_DoubleU farg1, farg2, farg3;
-
-    farg1.ll = arg1;
-    farg2.ll = arg2;
-    farg3.ll = arg3;
-
-    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.d)) ||
-                 (float64_is_zero(farg1.d) &&
-                  float64_is_infinity(farg2.d)))) {
-        /* Multiplication of zero by infinity */
-        farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg3.d, &env->fp_status))) {
-            /* sNaN operation */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-        }
-        /* This is the way the PowerPC specification defines it */
-        float128 ft0_128, ft1_128;
-
-        ft0_128 = float64_to_float128(farg1.d, &env->fp_status);
-        ft1_128 = float64_to_float128(farg2.d, &env->fp_status);
-        ft0_128 = float128_mul(ft0_128, ft1_128, &env->fp_status);
-        if (unlikely(float128_is_infinity(ft0_128) &&
-                     float64_is_infinity(farg3.d) &&
-                     float128_is_neg(ft0_128) == float64_is_neg(farg3.d))) {
-            /* Magnitude subtraction of infinities */
-            farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
-        } else {
-            ft1_128 = float64_to_float128(farg3.d, &env->fp_status);
-            ft0_128 = float128_sub(ft0_128, ft1_128, &env->fp_status);
-            farg1.d = float128_to_float64(ft0_128, &env->fp_status);
-        }
-    }
-    return farg1.ll;
-}
-
-/* fnmadd - fnmadd. */
-uint64_t helper_fnmadd(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
-                       uint64_t arg3)
-{
-    CPU_DoubleU farg1, farg2, farg3;
-
-    farg1.ll = arg1;
-    farg2.ll = arg2;
-    farg3.ll = arg3;
-
-    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.d)) ||
-                 (float64_is_zero(farg1.d) && float64_is_infinity(farg2.d)))) {
-        /* Multiplication of zero by infinity */
-        farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg3.d, &env->fp_status))) {
-            /* sNaN operation */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-        }
-        /* This is the way the PowerPC specification defines it */
-        float128 ft0_128, ft1_128;
-
-        ft0_128 = float64_to_float128(farg1.d, &env->fp_status);
-        ft1_128 = float64_to_float128(farg2.d, &env->fp_status);
-        ft0_128 = float128_mul(ft0_128, ft1_128, &env->fp_status);
-        if (unlikely(float128_is_infinity(ft0_128) &&
-                     float64_is_infinity(farg3.d) &&
-                     float128_is_neg(ft0_128) != float64_is_neg(farg3.d))) {
-            /* Magnitude subtraction of infinities */
-            farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
-        } else {
-            ft1_128 = float64_to_float128(farg3.d, &env->fp_status);
-            ft0_128 = float128_add(ft0_128, ft1_128, &env->fp_status);
-            farg1.d = float128_to_float64(ft0_128, &env->fp_status);
-        }
-        if (likely(!float64_is_any_nan(farg1.d))) {
-            farg1.d = float64_chs(farg1.d);
-        }
-    }
-    return farg1.ll;
-}
-
-/* fnmsub - fnmsub. */
-uint64_t helper_fnmsub(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
-                       uint64_t arg3)
-{
-    CPU_DoubleU farg1, farg2, farg3;
-
-    farg1.ll = arg1;
-    farg2.ll = arg2;
-    farg3.ll = arg3;
-
-    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.d)) ||
-                 (float64_is_zero(farg1.d) &&
-                  float64_is_infinity(farg2.d)))) {
-        /* Multiplication of zero by infinity */
-        farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg3.d, &env->fp_status))) {
-            /* sNaN operation */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-        }
-        /* This is the way the PowerPC specification defines it */
-        float128 ft0_128, ft1_128;
-
-        ft0_128 = float64_to_float128(farg1.d, &env->fp_status);
-        ft1_128 = float64_to_float128(farg2.d, &env->fp_status);
-        ft0_128 = float128_mul(ft0_128, ft1_128, &env->fp_status);
-        if (unlikely(float128_is_infinity(ft0_128) &&
-                     float64_is_infinity(farg3.d) &&
-                     float128_is_neg(ft0_128) == float64_is_neg(farg3.d))) {
-            /* Magnitude subtraction of infinities */
-            farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
-        } else {
-            ft1_128 = float64_to_float128(farg3.d, &env->fp_status);
-            ft0_128 = float128_sub(ft0_128, ft1_128, &env->fp_status);
-            farg1.d = float128_to_float64(ft0_128, &env->fp_status);
-        }
-        if (likely(!float64_is_any_nan(farg1.d))) {
-            farg1.d = float64_chs(farg1.d);
-        }
-    }
-    return farg1.ll;
+#define FPU_FMADD(op, sub, negate)                                      \
+uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,                   \
+                     uint64_t arg2,                                     \
+                     uint64_t arg3)                                     \
+{                                                                       \
+    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) || \
+                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) { \
+        /* Multiplication of zero by infinity */                        \
+        arg1 = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);    \
+    } else {                                                            \
+        if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) || \
+                     float64_is_signaling_nan(arg2, &env->fp_status) || \
+                     float64_is_signaling_nan(arg3, &env->fp_status))) { \
+            /* sNaN operation */                                        \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);      \
+        }                                                               \
+        arg1 = float64_muladd(arg1, arg2, arg3, sub, &env->fp_status);  \
+        if (negate) {                                                   \
+            if (likely(!float64_is_any_nan(arg1))) {                    \
+                arg1 = float64_chs(arg1);                               \
+            }                                                           \
+        }                                                               \
+        float_check_status(env);                                        \
+    }                                                                   \
+    return arg1;                                                        \
 }
+FPU_FMADD(fmadd, 0, 0)
+FPU_FMADD(fnmadd, 0, 1)
+FPU_FMADD(fmsub, float_muladd_negate_c, 0)
+FPU_FMADD(fnmsub, float_muladd_negate_c, 1)
 
 /* frsp - frsp. */
 uint64_t helper_frsp(CPUPPCState *env, uint64_t arg)
-- 
2.7.4
