Received: from eggs.gnu.org ([2001:4830:134:3::10]:44447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjRRL-0005kz-7c
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjRRI-0007oS-0z
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:10:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35691
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cjRRH-0007mx-Q0
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:10:39 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v22E4VMZ051300
	for <qemu-devel@nongnu.org>; Thu, 2 Mar 2017 09:10:38 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28xdv1m8x9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 09:10:38 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 2 Mar 2017 19:40:34 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  2 Mar 2017 19:40:29 +0530
Message-Id: <1488463829-26839-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] target/ppc: rewrite f[n]m[add,
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

Use the softfloat api for fused multiply-add.
Introduce routine to set the FPSCR flags VXNAN, VXIMZ nad VMISI.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

---

v1:
* Removed float64_madd_set_vxisi()
* Introduced float64_maddsub_update_excp() will updated required flags
* Changed layout of error handling

v0:
* Use MADD/MSUB_FLAGS as used by VSX instructions
* Introduce helper float64_madd_set_vxisi()
---
 target/ppc/fpu_helper.c | 213 +++++++++++-------------------------------------
 1 file changed, 46 insertions(+), 167 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 58aee64..0535ad0 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -743,178 +743,62 @@ uint64_t helper_frim(CPUPPCState *env, uint64_t arg)
     return do_fri(env, arg, float_round_down);
 }
 
-/* fmadd - fmadd. */
-uint64_t helper_fmadd(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
-                      uint64_t arg3)
+static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
+                                        float64 arg2, float64 arg3,
+                                        unsigned int madd_flags)
 {
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
+    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
+                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
         /* Multiplication of zero by infinity */
-        farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status) ||
-                     float64_is_signaling_nan(farg3.d, &env->fp_status))) {
-            /* sNaN operation */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+        arg1 = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
+    } else if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
+                        float64_is_signaling_nan(arg2, &env->fp_status) ||
+                        float64_is_signaling_nan(arg3, &env->fp_status))) {
+        /* sNaN operation */
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+    } else if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
+               float64_is_infinity(arg3)) {
+        uint8_t aSign, bSign, cSign;
+
+        aSign = float64_is_neg(arg1);
+        bSign = float64_is_neg(arg2);
+        cSign = float64_is_neg(arg3);
+        if (madd_flags & float_muladd_negate_c) {
+            cSign ^= 1;
         }
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
+        if (aSign ^ bSign ^ cSign) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
         }
     }
-    return farg1.ll;
 }
 
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
+#define FPU_FMADD(op, madd_flags)                                       \
+uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,                   \
+                     uint64_t arg2, uint64_t arg3)                      \
+{                                                                       \
+    uint32_t flags;                                                     \
+    float64 ret = float64_muladd(arg1, arg2, arg3, madd_flags,          \
+                                 &env->fp_status);                      \
+    flags = get_float_exception_flags(&env->fp_status);                 \
+    if (flags) {                                                        \
+        if (flags & float_flag_invalid) {                               \
+            float64_maddsub_update_excp(env, arg1, arg2, arg3,          \
+                                        madd_flags);                    \
+        }                                                               \
+        float_check_status(env);                                        \
+    }                                                                   \
+    return ret;                                                         \
 }
 
-/* fnmsub - fnmsub. */
-uint64_t helper_fnmsub(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
-                       uint64_t arg3)
-{
-    CPU_DoubleU farg1, farg2, farg3;
-
-    farg1.ll = arg1;
-    farg2.ll = arg2;
-    farg3.ll = arg3;
+#define MADD_FLGS 0
+#define MSUB_FLGS float_muladd_negate_c
+#define NMADD_FLGS float_muladd_negate_result
+#define NMSUB_FLGS (float_muladd_negate_c | float_muladd_negate_result)
 
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
-}
+FPU_FMADD(fmadd, MADD_FLGS)
+FPU_FMADD(fnmadd, NMADD_FLGS)
+FPU_FMADD(fmsub, MSUB_FLGS)
+FPU_FMADD(fnmsub, NMSUB_FLGS)
 
 /* frsp - frsp. */
 uint64_t helper_frsp(CPUPPCState *env, uint64_t arg)
@@ -2384,11 +2268,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
     float_check_status(env);                                                  \
 }
 
-#define MADD_FLGS 0
-#define MSUB_FLGS float_muladd_negate_c
-#define NMADD_FLGS float_muladd_negate_result
-#define NMSUB_FLGS (float_muladd_negate_c | float_muladd_negate_result)
-
 VSX_MADD(xsmaddadp, 1, float64, VsrD(0), MADD_FLGS, 1, 1, 0)
 VSX_MADD(xsmaddmdp, 1, float64, VsrD(0), MADD_FLGS, 0, 1, 0)
 VSX_MADD(xsmsubadp, 1, float64, VsrD(0), MSUB_FLGS, 1, 1, 0)
-- 
2.7.4
