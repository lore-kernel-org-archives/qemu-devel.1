Received: from eggs.gnu.org ([2001:4830:134:3::10]:37678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV3-0002yc-U0
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV2-0007yA-5k
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:14 +1100
Message-Id: <20170222063348.32176-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/43] target-ppc: Add xsmaxcdp and xsmincdp
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
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

xsmaxcdp: VSX Scalar Maximum Type-C Double-Precision
xsmincdp: VSX Scalar Minimum Type-C Double-Precision

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 38 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  |  2 ++
 4 files changed, 44 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 48973a9..9d2688e 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2679,6 +2679,44 @@ VSX_MAX_MIN(xsmindp, minnum, 1, float64, VsrD(0))
 VSX_MAX_MIN(xvmindp, minnum, 2, float64, VsrD(i))
 VSX_MAX_MIN(xvminsp, minnum, 4, float32, VsrW(i))
 
+#define VSX_MAX_MINC(name, max)                                               \
+void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
+{                                                                             \
+    ppc_vsr_t xt, xa, xb;                                                     \
+    bool vxsnan_flag = false, vex_flag = false;                               \
+                                                                              \
+    getVSR(rA(opcode) + 32, &xa, env);                                        \
+    getVSR(rB(opcode) + 32, &xb, env);                                        \
+    getVSR(rD(opcode) + 32, &xt, env);                                        \
+                                                                              \
+    if (unlikely(float64_is_any_nan(xa.VsrD(0)) ||                            \
+                 float64_is_any_nan(xb.VsrD(0)))) {                           \
+        if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status) ||          \
+            float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {          \
+            vxsnan_flag = true;                                               \
+        }                                                                     \
+        xt.VsrD(0) = xb.VsrD(0);                                              \
+    } else if ((max &&                                                        \
+               !float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) ||       \
+               (!max &&                                                       \
+               float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status))) {        \
+        xt.VsrD(0) = xa.VsrD(0);                                              \
+    } else {                                                                  \
+        xt.VsrD(0) = xb.VsrD(0);                                              \
+    }                                                                         \
+                                                                              \
+    vex_flag = fpscr_ve & vxsnan_flag;                                        \
+    if (vxsnan_flag) {                                                        \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);            \
+    }                                                                         \
+    if (!vex_flag) {                                                          \
+        putVSR(rD(opcode) + 32, &xt, env);                                    \
+    }                                                                         \
+}                                                                             \
+
+VSX_MAX_MINC(xsmaxcdp, 1);
+VSX_MAX_MINC(xsmincdp, 0);
+
 /* VSX_CMP - VSX floating point compare
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3956fd1..fe3267e 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -431,6 +431,8 @@ DEF_HELPER_2(xscmpoqp, void, env, i32)
 DEF_HELPER_2(xscmpuqp, void, env, i32)
 DEF_HELPER_2(xsmaxdp, void, env, i32)
 DEF_HELPER_2(xsmindp, void, env, i32)
+DEF_HELPER_2(xsmaxcdp, void, env, i32)
+DEF_HELPER_2(xsmincdp, void, env, i32)
 DEF_HELPER_2(xscvdphp, void, env, i32)
 DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index a062203..3251dca 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -808,6 +808,8 @@ GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xsmaxcdp, 0x00, 0x10, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xsmincdp, 0x00, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 2202c0f..16a135f 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -200,6 +200,8 @@ GEN_VSX_XFORM_300(xscmpoqp, 0x04, 0x04, 0x00600001),
 GEN_VSX_XFORM_300(xscmpuqp, 0x04, 0x14, 0x00600001),
 GEN_XX3FORM(xsmaxdp, 0x00, 0x14, PPC2_VSX),
 GEN_XX3FORM(xsmindp, 0x00, 0x15, PPC2_VSX),
+GEN_XX3FORM(xsmaxcdp, 0x00, 0x10, PPC2_ISA300),
+GEN_XX3FORM(xsmincdp, 0x00, 0x11, PPC2_ISA300),
 GEN_XX2FORM_EO(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300),
 GEN_XX2FORM(xscvdpsp, 0x12, 0x10, PPC2_VSX),
 GEN_XX2FORM(xscvdpspn, 0x16, 0x10, PPC2_VSX207),
-- 
2.9.3
