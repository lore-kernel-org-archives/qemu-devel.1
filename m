Received: from eggs.gnu.org ([2001:4830:134:3::10]:44450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqa-00089z-TM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqX-0001OP-2r
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:25:07 +1100
Message-Id: <20170303032507.16142-18-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/17] target/ppc: rewrite f[n]m[add,
 sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Use the softfloat api for fused multiply-add.
Introduce routine to set the FPSCR flags VXNAN, VXIMZ nad VMISI.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.9.3
