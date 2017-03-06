Received: from eggs.gnu.org ([2001:4830:134:3::10]:47451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckjwl-00058R-Ni
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckjwk-0003tJ-Rs
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:08:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  6 Mar 2017 15:08:21 +1100
Message-Id: <20170306040823.28482-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170306040823.28482-1-david@gibson.dropbear.id.au>
References: <20170306040823.28482-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 3/5] target/ppc: fmadd check for excp
 independently
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

Current order of checking does not confirm with the spec
(ISA 3.0: MultiplyAddDP page-469). Change the order and make them
independent of each other.

For example: a = infinity, b = zero, c = SNaN, this should set both
VXIMZ and VXNAN

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 0535ad0..a547f58 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -747,17 +747,21 @@ static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
                                         float64 arg2, float64 arg3,
                                         unsigned int madd_flags)
 {
+    if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
+                 float64_is_signaling_nan(arg2, &env->fp_status) ||
+                 float64_is_signaling_nan(arg3, &env->fp_status))) {
+        /* sNaN operation */
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+    }
+
     if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
                  (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
         /* Multiplication of zero by infinity */
-        arg1 = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
-    } else if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
-                        float64_is_signaling_nan(arg2, &env->fp_status) ||
-                        float64_is_signaling_nan(arg3, &env->fp_status))) {
-        /* sNaN operation */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-    } else if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
-               float64_is_infinity(arg3)) {
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
+    }
+
+    if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
+        float64_is_infinity(arg3)) {
         uint8_t aSign, bSign, cSign;
 
         aSign = float64_is_neg(arg1);
-- 
2.9.3
