Received: from eggs.gnu.org ([2001:4830:134:3::10]:47473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckjwn-00058q-L7
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckjwk-0003sz-EV
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:08:33 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  6 Mar 2017 15:08:22 +1100
Message-Id: <20170306040823.28482-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170306040823.28482-1-david@gibson.dropbear.id.au>
References: <20170306040823.28482-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 4/5] target/ppc: fmadd: add macro for updating
 flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Adds FPU_MADDSUB_UPDATE macro, this will be used for other routines
having float32/16

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 61 ++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index a547f58..13bd6ce 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -743,38 +743,37 @@ uint64_t helper_frim(CPUPPCState *env, uint64_t arg)
     return do_fri(env, arg, float_round_down);
 }
 
-static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
-                                        float64 arg2, float64 arg3,
-                                        unsigned int madd_flags)
-{
-    if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
-                 float64_is_signaling_nan(arg2, &env->fp_status) ||
-                 float64_is_signaling_nan(arg3, &env->fp_status))) {
-        /* sNaN operation */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-    }
-
-    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
-                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
-        /* Multiplication of zero by infinity */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
-    }
-
-    if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
-        float64_is_infinity(arg3)) {
-        uint8_t aSign, bSign, cSign;
-
-        aSign = float64_is_neg(arg1);
-        bSign = float64_is_neg(arg2);
-        cSign = float64_is_neg(arg3);
-        if (madd_flags & float_muladd_negate_c) {
-            cSign ^= 1;
-        }
-        if (aSign ^ bSign ^ cSign) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
-        }
-    }
+#define FPU_MADDSUB_UPDATE(NAME, TP)                                    \
+static void NAME(CPUPPCState *env, TP arg1, TP arg2, TP arg3,           \
+                 unsigned int madd_flags)                               \
+{                                                                       \
+    if (TP##_is_signaling_nan(arg1, &env->fp_status) ||                 \
+        TP##_is_signaling_nan(arg2, &env->fp_status) ||                 \
+        TP##_is_signaling_nan(arg3, &env->fp_status)) {                 \
+        /* sNaN operation */                                            \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);          \
+    }                                                                   \
+    if ((TP##_is_infinity(arg1) && TP##_is_zero(arg2)) ||               \
+        (TP##_is_zero(arg1) && TP##_is_infinity(arg2))) {               \
+        /* Multiplication of zero by infinity */                        \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);           \
+    }                                                                   \
+    if ((TP##_is_infinity(arg1) || TP##_is_infinity(arg2)) &&           \
+        TP##_is_infinity(arg3)) {                                       \
+        uint8_t aSign, bSign, cSign;                                    \
+                                                                        \
+        aSign = TP##_is_neg(arg1);                                      \
+        bSign = TP##_is_neg(arg2);                                      \
+        cSign = TP##_is_neg(arg3);                                      \
+        if (madd_flags & float_muladd_negate_c) {                       \
+            cSign ^= 1;                                                 \
+        }                                                               \
+        if (aSign ^ bSign ^ cSign) {                                    \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);       \
+        }                                                               \
+    }                                                                   \
 }
+FPU_MADDSUB_UPDATE(float64_maddsub_update_excp, float64)
 
 #define FPU_FMADD(op, madd_flags)                                       \
 uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,                   \
-- 
2.9.3
