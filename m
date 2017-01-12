Received: from eggs.gnu.org ([2001:4830:134:3::10]:46059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjv-0002ql-Kt
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjt-0006PI-GU
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:25 +1100
Message-Id: <20170112020327.24882-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/67] target-ppc: Add xscmpexp[dp,
 qp] instructions
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

xscmpexpdp: VSX Scalar Compare Exponents Double-Precision
xscmpexpqp: VSX Scalar Compare Exponents Quad-Precision

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 64 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  |  6 ++++
 4 files changed, 74 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index fdd3216..8bffafb 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2405,6 +2405,70 @@ VSX_SCALAR_CMP_DP(xscmpgedp, le, 1, 1)
 VSX_SCALAR_CMP_DP(xscmpgtdp, lt, 1, 1)
 VSX_SCALAR_CMP_DP(xscmpnedp, eq, 0, 0)
 
+void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xa, xb;
+    int64_t exp_a, exp_b;
+    uint32_t cc;
+
+    getVSR(xA(opcode), &xa, env);
+    getVSR(xB(opcode), &xb, env);
+
+    exp_a = extract64(xa.VsrD(0), 52, 11);
+    exp_b = extract64(xb.VsrD(0), 52, 11);
+
+    if (unlikely(float64_is_any_nan(xa.VsrD(0)) ||
+                 float64_is_any_nan(xb.VsrD(0)))) {
+        cc = CRF_SO;
+    } else {
+        if (exp_a < exp_b) {
+            cc = CRF_LT;
+        } else if (exp_a > exp_b) {
+            cc = CRF_GT;
+        } else {
+            cc = CRF_EQ;
+        }
+    }
+
+    env->fpscr &= ~(0x0F << FPSCR_FPRF);
+    env->fpscr |= cc << FPSCR_FPRF;
+    env->crf[BF(opcode)] = cc;
+
+    helper_float_check_status(env);
+}
+
+void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xa, xb;
+    int64_t exp_a, exp_b;
+    uint32_t cc;
+
+    getVSR(rA(opcode) + 32, &xa, env);
+    getVSR(rB(opcode) + 32, &xb, env);
+
+    exp_a = extract64(xa.VsrD(0), 48, 15);
+    exp_b = extract64(xb.VsrD(0), 48, 15);
+
+    if (unlikely(float128_is_any_nan(make_float128(xa.VsrD(0), xa.VsrD(1))) ||
+                 float128_is_any_nan(make_float128(xb.VsrD(0), xb.VsrD(1))))) {
+        cc = CRF_SO;
+    } else {
+        if (exp_a < exp_b) {
+            cc = CRF_LT;
+        } else if (exp_a > exp_b) {
+            cc = CRF_GT;
+        } else {
+            cc = CRF_EQ;
+        }
+    }
+
+    env->fpscr &= ~(0x0F << FPSCR_FPRF);
+    env->fpscr |= cc << FPSCR_FPRF;
+    env->crf[BF(opcode)] = cc;
+
+    helper_float_check_status(env);
+}
+
 #define VSX_SCALAR_CMP(op, ordered)                                      \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                      \
 {                                                                        \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index da00f0a..ba42015 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -404,6 +404,8 @@ DEF_HELPER_2(xscmpeqdp, void, env, i32)
 DEF_HELPER_2(xscmpgtdp, void, env, i32)
 DEF_HELPER_2(xscmpgedp, void, env, i32)
 DEF_HELPER_2(xscmpnedp, void, env, i32)
+DEF_HELPER_2(xscmpexpdp, void, env, i32)
+DEF_HELPER_2(xscmpexpqp, void, env, i32)
 DEF_HELPER_2(xscmpodp, void, env, i32)
 DEF_HELPER_2(xscmpudp, void, env, i32)
 DEF_HELPER_2(xsmaxdp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 5a27be4..5206258 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -624,6 +624,8 @@ GEN_VSX_HELPER_2(xscmpeqdp, 0x0C, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpnedp, 0x0C, 0x03, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 3d91041..2468ee9 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -83,6 +83,10 @@ GEN_HANDLER2_E(name, #name, 0x3C, opc2|0x01, opc3|0x0C, 0, PPC_NONE, PPC2_VSX),\
 GEN_HANDLER2_E(name, #name, 0x3C, opc2|0x02, opc3|0x0C, 0, PPC_NONE, PPC2_VSX),\
 GEN_HANDLER2_E(name, #name, 0x3C, opc2|0x03, opc3|0x0C, 0, PPC_NONE, PPC2_VSX)
 
+#define GEN_VSX_XFORM_300(name, opc2, opc3, inval) \
+GEN_HANDLER_E(name, 0x3F, opc2, opc3, inval, PPC_NONE, PPC2_ISA300)
+
+
 GEN_XX2FORM(xsabsdp, 0x12, 0x15, PPC2_VSX),
 GEN_XX2FORM(xsnabsdp, 0x12, 0x16, PPC2_VSX),
 GEN_XX2FORM(xsnegdp, 0x12, 0x17, PPC2_VSX),
@@ -118,6 +122,8 @@ GEN_XX3FORM(xscmpeqdp, 0x0C, 0x00, PPC2_ISA300),
 GEN_XX3FORM(xscmpgtdp, 0x0C, 0x01, PPC2_ISA300),
 GEN_XX3FORM(xscmpgedp, 0x0C, 0x02, PPC2_ISA300),
 GEN_XX3FORM(xscmpnedp, 0x0C, 0x03, PPC2_ISA300),
+GEN_XX3FORM(xscmpexpdp, 0x0C, 0x07, PPC2_ISA300),
+GEN_VSX_XFORM_300(xscmpexpqp, 0x04, 0x05, 0x00600001),
 GEN_XX2IFORM(xscmpodp,  0x0C, 0x05, PPC2_VSX),
 GEN_XX2IFORM(xscmpudp,  0x0C, 0x04, PPC2_VSX),
 GEN_XX3FORM(xsmaxdp, 0x00, 0x14, PPC2_VSX),
-- 
2.9.3
