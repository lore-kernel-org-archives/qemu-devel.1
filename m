Received: from eggs.gnu.org ([2001:4830:134:3::10]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kJ-00080s-Ex
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kC-0004L3-EA
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:47 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:26 +1100
Message-Id: <20170202051445.5735-89-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 088/107] target-ppc: Add xscvsdqp and xscvudqp
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
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Bharata B Rao <bharata@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

xscvsdqp: VSX Scalar Convert Signed Doubleword format to
          Quad-Precision format
xscvudqp: VSX Scalar Convert Unsigned Doubleword format to
          Quad-Precision format

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 25 +++++++++++++++++++++++++
 target/ppc/helper.h                 |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  |  2 ++
 4 files changed, 31 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index d648234..b9689b7 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2960,6 +2960,31 @@ VSX_CVT_INT_TO_FP(xvcvuxdsp, 2, uint64, float32, VsrD(i), VsrW(2*i), 0, 0)
 VSX_CVT_INT_TO_FP(xvcvsxwsp, 4, int32, float32, VsrW(i), VsrW(i), 0, 0)
 VSX_CVT_INT_TO_FP(xvcvuxwsp, 4, uint32, float32, VsrW(i), VsrW(i), 0, 0)
 
+/* VSX_CVT_INT_TO_FP_VECTOR - VSX integer to floating point conversion
+ *   op    - instruction mnemonic
+ *   stp   - source type (int32, uint32, int64 or uint64)
+ *   ttp   - target type (float32 or float64)
+ *   sfld  - source vsr_t field
+ *   tfld  - target vsr_t field
+ */
+#define VSX_CVT_INT_TO_FP_VECTOR(op, stp, ttp, sfld, tfld)              \
+void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
+{                                                                       \
+    ppc_vsr_t xt, xb;                                                   \
+                                                                        \
+    getVSR(rB(opcode) + 32, &xb, env);                                  \
+    getVSR(rD(opcode) + 32, &xt, env);                                  \
+                                                                        \
+    xt.tfld = stp##_to_##ttp(xb.sfld, &env->fp_status);                 \
+    helper_compute_fprf_##ttp(env, xt.tfld);                            \
+                                                                        \
+    putVSR(xT(opcode) + 32, &xt, env);                                  \
+    float_check_status(env);                                            \
+}
+
+VSX_CVT_INT_TO_FP_VECTOR(xscvsdqp, int64, float128, VsrD(0), f128)
+VSX_CVT_INT_TO_FP_VECTOR(xscvudqp, uint64, float128, VsrD(0), f128)
+
 /* For "use current rounding mode", define a value that will not be one of
  * the existing rounding model enums.
  */
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 51a1a5f..13142e0 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -437,6 +437,7 @@ DEF_HELPER_2(xscvqpdp, void, env, i32)
 DEF_HELPER_2(xscvqpsdz, void, env, i32)
 DEF_HELPER_2(xscvqpswz, void, env, i32)
 DEF_HELPER_2(xscvhpdp, void, env, i32)
+DEF_HELPER_2(xscvsdqp, void, env, i32)
 DEF_HELPER_2(xscvspdp, void, env, i32)
 DEF_HELPER_2(xscvspdpn, i64, env, i64)
 DEF_HELPER_2(xscvdpsxds, void, env, i32)
@@ -446,6 +447,7 @@ DEF_HELPER_2(xscvdpuxws, void, env, i32)
 DEF_HELPER_2(xscvsxddp, void, env, i32)
 DEF_HELPER_2(xscvuxdsp, void, env, i32)
 DEF_HELPER_2(xscvsxdsp, void, env, i32)
+DEF_HELPER_2(xscvudqp, void, env, i32)
 DEF_HELPER_2(xscvuxddp, void, env, i32)
 DEF_HELPER_2(xsrdpi, void, env, i32)
 DEF_HELPER_2(xsrdpic, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 3c924ba..37004a4 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -814,6 +814,7 @@ GEN_VSX_HELPER_2(xscvqpdp, 0x04, 0x1A, 0x14, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpsdz, 0x04, 0x1A, 0x19, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpswz, 0x04, 0x1A, 0x09, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
+GEN_VSX_HELPER_2(xscvsdqp, 0x04, 0x1A, 0x0A, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xscvspdpn, 0x16, 0x14, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvdpsxds, 0x10, 0x15, 0, PPC2_VSX)
@@ -821,6 +822,7 @@ GEN_VSX_HELPER_2(xscvdpsxws, 0x10, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpuxds, 0x10, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpuxws, 0x10, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvsxddp, 0x10, 0x17, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xscvudqp, 0x04, 0x1A, 0x02, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvuxddp, 0x10, 0x16, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsrdpi, 0x12, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsrdpic, 0x16, 0x06, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 297c317..6b6b828 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -176,6 +176,7 @@ GEN_XX2FORM_EO(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300),
 GEN_XX2FORM(xscvdpsp, 0x12, 0x10, PPC2_VSX),
 GEN_XX2FORM(xscvdpspn, 0x16, 0x10, PPC2_VSX207),
 GEN_XX2FORM_EO(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300),
+GEN_VSX_XFORM_300_EO(xscvsdqp, 0x04, 0x1A, 0x0A, 0x00000001),
 GEN_XX2FORM(xscvspdp, 0x12, 0x14, PPC2_VSX),
 GEN_XX2FORM(xscvspdpn, 0x16, 0x14, PPC2_VSX207),
 GEN_XX2FORM(xscvdpsxds, 0x10, 0x15, PPC2_VSX),
@@ -183,6 +184,7 @@ GEN_XX2FORM(xscvdpsxws, 0x10, 0x05, PPC2_VSX),
 GEN_XX2FORM(xscvdpuxds, 0x10, 0x14, PPC2_VSX),
 GEN_XX2FORM(xscvdpuxws, 0x10, 0x04, PPC2_VSX),
 GEN_XX2FORM(xscvsxddp, 0x10, 0x17, PPC2_VSX),
+GEN_VSX_XFORM_300_EO(xscvudqp, 0x04, 0x1A, 0x02, 0x00000001),
 GEN_XX2FORM(xscvuxddp, 0x10, 0x16, PPC2_VSX),
 GEN_XX2FORM(xsrdpi, 0x12, 0x04, PPC2_VSX),
 GEN_XX2FORM(xsrdpic, 0x16, 0x06, PPC2_VSX),
-- 
2.9.3
