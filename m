Received: from eggs.gnu.org ([2001:4830:134:3::10]:45917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjr-0002nq-6V
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjq-0006MU-4t
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:39 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:24 +1100
Message-Id: <20170112020327.24882-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/67] target-ppc: Fix xscmpodp and xscmpudp
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

- xscmpodp & xscmpudp are missing flags reset.
- In xscmpodp, VXCC should be set only if VE is 0 for signalling NaN case
  and VXCC should be set by explicitly checking for quiet NaN case.
- Comparison is being done only if the operands are not NaNs. However as
  per ISA, it should be done even when operands are NaNs.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index d3741b4..fdd3216 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2410,29 +2410,39 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                      \
 {                                                                        \
     ppc_vsr_t xa, xb;                                                    \
     uint32_t cc = 0;                                                     \
+    bool vxsnan_flag = false, vxvc_flag = false;                         \
                                                                          \
+    helper_reset_fpstatus(env);                                          \
     getVSR(xA(opcode), &xa, env);                                        \
     getVSR(xB(opcode), &xb, env);                                        \
                                                                          \
-    if (unlikely(float64_is_any_nan(xa.VsrD(0)) ||                       \
-                 float64_is_any_nan(xb.VsrD(0)))) {                      \
-        if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status) ||     \
-            float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {     \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);       \
+    if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status) ||         \
+        float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {         \
+        vxsnan_flag = true;                                              \
+        cc = CRF_SO;                                                     \
+        if (fpscr_ve == 0 && ordered) {                                  \
+            vxvc_flag = true;                                            \
         }                                                                \
+    } else if (float64_is_quiet_nan(xa.VsrD(0), &env->fp_status) ||      \
+               float64_is_quiet_nan(xb.VsrD(0), &env->fp_status)) {      \
+        cc = CRF_SO;                                                     \
         if (ordered) {                                                   \
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXVC, 0);         \
+            vxvc_flag = true;                                            \
         }                                                                \
-        cc = 1;                                                          \
+    }                                                                    \
+    if (vxsnan_flag) {                                                   \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);           \
+    }                                                                    \
+    if (vxvc_flag) {                                                     \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXVC, 0);             \
+    }                                                                    \
+                                                                         \
+    if (float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) {           \
+        cc |= CRF_LT;                                                    \
+    } else if (!float64_le(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) {   \
+        cc |= CRF_GT;                                                    \
     } else {                                                             \
-        if (float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) {       \
-            cc = 8;                                                      \
-        } else if (!float64_le(xa.VsrD(0), xb.VsrD(0),                   \
-                               &env->fp_status)) { \
-            cc = 4;                                                      \
-        } else {                                                         \
-            cc = 2;                                                      \
-        }                                                                \
+        cc |= CRF_EQ;                                                    \
     }                                                                    \
                                                                          \
     env->fpscr &= ~(0x0F << FPSCR_FPRF);                                 \
-- 
2.9.3
