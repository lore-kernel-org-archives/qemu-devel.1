Received: from eggs.gnu.org ([2001:4830:134:3::10]:46953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkE-0003F3-60
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkB-0006mG-35
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:02 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:25 +1100
Message-Id: <20170112020327.24882-66-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 65/67] target-ppc: Add xscvqpdp instruction
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

xscvqpdp:  VSX Scalar round & Convert Quad-Precision format to
           Double-Precision format

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 28 ++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 31 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 16397ef..8c8e3c5 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2778,6 +2778,34 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                \
 VSX_CVT_FP_TO_FP_HP(xscvdphp, float64, float16, VsrD(0), VsrH(3))
 VSX_CVT_FP_TO_FP_HP(xscvhpdp, float16, float64, VsrH(3), VsrD(0))
 
+/*
+ * xscvqpdp isn't using VSX_CVT_FP_TO_FP() because xscvqpdpo will be
+ * added to this later.
+ */
+void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xt, xb;
+
+    getVSR(rB(opcode) + 32, &xb, env);
+    getVSR(rD(opcode) + 32, &xt, env);
+
+    if (unlikely(Rc(opcode) != 0)) {
+        /* TODO: Support xscvqpdpo after round-to-odd is implemented */
+        abort();
+    }
+
+    xt.VsrD(0) = float128_to_float64(xb.f128, &env->fp_status);
+    if (unlikely(float128_is_signaling_nan(xb.f128,
+                                           &env->fp_status))) {
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);
+        xt.VsrD(0) = float64_snan_to_qnan(xt.VsrD(0));
+    }
+    helper_compute_fprf_float64(env, xt.VsrD(0));
+
+    putVSR(rD(opcode) + 32, &xt, env);
+    float_check_status(env);
+}
+
 uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
 {
     float_status tstat = env->fp_status;
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3b5d0ad..f28bf62 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -433,6 +433,7 @@ DEF_HELPER_2(xscvdphp, void, env, i32)
 DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
+DEF_HELPER_2(xscvqpdp, void, env, i32)
 DEF_HELPER_2(xscvhpdp, void, env, i32)
 DEF_HELPER_2(xscvspdp, void, env, i32)
 DEF_HELPER_2(xscvspdpn, i64, env, i64)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 01b5621..2d9fe50 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -810,6 +810,7 @@ GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
+GEN_VSX_HELPER_2(xscvqpdp, 0x04, 0x1A, 0x14, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xscvspdpn, 0x16, 0x14, 0, PPC2_VSX207)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index e75ecd1..aeeaff2 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -113,6 +113,7 @@ GEN_VSX_XFORM_300_EO(xsnabsqp, 0x04, 0x19, 0x08, 0x00000001),
 GEN_VSX_XFORM_300_EO(xsnegqp, 0x04, 0x19, 0x10, 0x00000001),
 GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
 GEN_VSX_XFORM_300_EO(xscvdpqp, 0x04, 0x1A, 0x16, 0x00000001),
+GEN_VSX_XFORM_300_EO(xscvqpdp, 0x04, 0x1A, 0x14, 0x0),
 
 #ifdef TARGET_PPC64
 GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
-- 
2.9.3
