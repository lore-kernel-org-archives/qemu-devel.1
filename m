Received: from eggs.gnu.org ([2001:4830:134:3::10]:47029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkF-0003F8-Ni
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkB-0006n4-JN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:24 +1100
Message-Id: <20170112020327.24882-65-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 64/67] target-ppc: Add xscvdpqp instruction
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

xscvdpqp: VSX Scalar Convert Double-Precision format to
          Quad-Precision format

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 45 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 48 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 6e7279c..16397ef 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -22,6 +22,15 @@
 #include "exec/exec-all.h"
 #include "internal.h"
 
+static inline float128 float128_snan_to_qnan(float128 x)
+{
+    float128 r;
+
+    r.high = x.high | 0x0000800000000000;
+    r.low = x.low;
+    return r;
+}
+
 #define float64_snan_to_qnan(x) ((x) | 0x0008000000000000ULL)
 #define float32_snan_to_qnan(x) ((x) | 0x00400000)
 #define float16_snan_to_qnan(x) ((x) | 0x0200)
@@ -2702,6 +2711,42 @@ VSX_CVT_FP_TO_FP(xscvspdp, 1, float32, float64, VsrW(0), VsrD(0), 1)
 VSX_CVT_FP_TO_FP(xvcvdpsp, 2, float64, float32, VsrD(i), VsrW(2*i), 0)
 VSX_CVT_FP_TO_FP(xvcvspdp, 2, float32, float64, VsrW(2*i), VsrD(i), 0)
 
+/* VSX_CVT_FP_TO_FP_VECTOR - VSX floating point/floating point conversion
+ *   op    - instruction mnemonic
+ *   nels  - number of elements (1, 2 or 4)
+ *   stp   - source type (float32 or float64)
+ *   ttp   - target type (float32 or float64)
+ *   sfld  - source vsr_t field
+ *   tfld  - target vsr_t field (f32 or f64)
+ *   sfprf - set FPRF
+ */
+#define VSX_CVT_FP_TO_FP_VECTOR(op, nels, stp, ttp, sfld, tfld, sfprf)    \
+void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
+{                                                                       \
+    ppc_vsr_t xt, xb;                                                   \
+    int i;                                                              \
+                                                                        \
+    getVSR(rB(opcode) + 32, &xb, env);                                  \
+    getVSR(rD(opcode) + 32, &xt, env);                                  \
+                                                                        \
+    for (i = 0; i < nels; i++) {                                        \
+        xt.tfld = stp##_to_##ttp(xb.sfld, &env->fp_status);             \
+        if (unlikely(stp##_is_signaling_nan(xb.sfld,                    \
+                                            &env->fp_status))) {        \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);      \
+            xt.tfld = ttp##_snan_to_qnan(xt.tfld);                      \
+        }                                                               \
+        if (sfprf) {                                                    \
+            helper_compute_fprf_##ttp(env, xt.tfld);                    \
+        }                                                               \
+    }                                                                   \
+                                                                        \
+    putVSR(rD(opcode) + 32, &xt, env);                                  \
+    float_check_status(env);                                            \
+}
+
+VSX_CVT_FP_TO_FP_VECTOR(xscvdpqp, 1, float64, float128, VsrD(0), f128, 1)
+
 /* VSX_CVT_FP_TO_FP_HP - VSX floating point/floating point conversion
  *                       involving one half precision value
  *   op    - instruction mnemonic
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 889fe55..3b5d0ad 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -430,6 +430,7 @@ DEF_HELPER_2(xscmpuqp, void, env, i32)
 DEF_HELPER_2(xsmaxdp, void, env, i32)
 DEF_HELPER_2(xsmindp, void, env, i32)
 DEF_HELPER_2(xscvdphp, void, env, i32)
+DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
 DEF_HELPER_2(xscvhpdp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 113ccf3..01b5621 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -808,6 +808,7 @@ GEN_VSX_HELPER_2(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 882e11b..e75ecd1 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -112,6 +112,7 @@ GEN_VSX_XFORM_300_EO(xsabsqp, 0x04, 0x19, 0x00, 0x00000001),
 GEN_VSX_XFORM_300_EO(xsnabsqp, 0x04, 0x19, 0x08, 0x00000001),
 GEN_VSX_XFORM_300_EO(xsnegqp, 0x04, 0x19, 0x10, 0x00000001),
 GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
+GEN_VSX_XFORM_300_EO(xscvdpqp, 0x04, 0x1A, 0x16, 0x00000001),
 
 #ifdef TARGET_PPC64
 GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
-- 
2.9.3
