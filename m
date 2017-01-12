Received: from eggs.gnu.org ([2001:4830:134:3::10]:46014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUju-0002pv-M1
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjs-0006O9-TQ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:42 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:26 +1100
Message-Id: <20170112020327.24882-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/67] target-ppc: Add xscmpoqp and xscmpuqp
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

xscmpoqp - VSX Scalar Compare Ordered Quad-Precision
xscmpuqp - VSX Scalar Compare Unordered Quad-Precision

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 54 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  |  2 ++
 4 files changed, 60 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 8bffafb..696f537 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2519,6 +2519,60 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                      \
 VSX_SCALAR_CMP(xscmpodp, 1)
 VSX_SCALAR_CMP(xscmpudp, 0)
 
+#define VSX_SCALAR_CMPQ(op, ordered)                                    \
+void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
+{                                                                       \
+    ppc_vsr_t xa, xb;                                                   \
+    uint32_t cc = 0;                                                    \
+    bool vxsnan_flag = false, vxvc_flag = false;                        \
+    float128 a, b;                                                      \
+                                                                        \
+    helper_reset_fpstatus(env);                                         \
+    getVSR(rA(opcode) + 32, &xa, env);                                  \
+    getVSR(rB(opcode) + 32, &xb, env);                                  \
+                                                                        \
+    a = make_float128(xa.VsrD(0), xa.VsrD(1));                          \
+    b = make_float128(xb.VsrD(0), xb.VsrD(1));                          \
+                                                                        \
+    if (float128_is_signaling_nan(a, &env->fp_status) ||                \
+        float128_is_signaling_nan(b, &env->fp_status)) {                \
+        vxsnan_flag = true;                                             \
+        cc = CRF_SO;                                                    \
+        if (fpscr_ve == 0 && ordered) {                                 \
+            vxvc_flag = true;                                           \
+        }                                                               \
+    } else if (float128_is_quiet_nan(a, &env->fp_status) ||             \
+               float128_is_quiet_nan(b, &env->fp_status)) {             \
+        cc = CRF_SO;                                                    \
+        if (ordered) {                                                  \
+            vxvc_flag = true;                                           \
+        }                                                               \
+    }                                                                   \
+    if (vxsnan_flag) {                                                  \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);          \
+    }                                                                   \
+    if (vxvc_flag) {                                                    \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXVC, 0);            \
+    }                                                                   \
+                                                                        \
+    if (float128_lt(a, b, &env->fp_status)) {                           \
+        cc |= CRF_LT;                                                   \
+    } else if (!float128_le(a, b, &env->fp_status)) {                   \
+        cc |= CRF_GT;                                                   \
+    } else {                                                            \
+        cc |= CRF_EQ;                                                   \
+    }                                                                   \
+                                                                        \
+    env->fpscr &= ~(0x0F << FPSCR_FPRF);                                \
+    env->fpscr |= cc << FPSCR_FPRF;                                     \
+    env->crf[BF(opcode)] = cc;                                          \
+                                                                        \
+    float_check_status(env);                                            \
+}
+
+VSX_SCALAR_CMPQ(xscmpoqp, 1)
+VSX_SCALAR_CMPQ(xscmpuqp, 0)
+
 /* VSX_MAX_MIN - VSX floating point maximum/minimum
  *   name  - instruction mnemonic
  *   op    - operation (max or min)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index ba42015..3b26678 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -408,6 +408,8 @@ DEF_HELPER_2(xscmpexpdp, void, env, i32)
 DEF_HELPER_2(xscmpexpqp, void, env, i32)
 DEF_HELPER_2(xscmpodp, void, env, i32)
 DEF_HELPER_2(xscmpudp, void, env, i32)
+DEF_HELPER_2(xscmpoqp, void, env, i32)
+DEF_HELPER_2(xscmpuqp, void, env, i32)
 DEF_HELPER_2(xsmaxdp, void, env, i32)
 DEF_HELPER_2(xsmindp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 5206258..ed9588e 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -628,6 +628,8 @@ GEN_VSX_HELPER_2(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 2468ee9..7f09527 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -126,6 +126,8 @@ GEN_XX3FORM(xscmpexpdp, 0x0C, 0x07, PPC2_ISA300),
 GEN_VSX_XFORM_300(xscmpexpqp, 0x04, 0x05, 0x00600001),
 GEN_XX2IFORM(xscmpodp,  0x0C, 0x05, PPC2_VSX),
 GEN_XX2IFORM(xscmpudp,  0x0C, 0x04, PPC2_VSX),
+GEN_VSX_XFORM_300(xscmpoqp, 0x04, 0x04, 0x00600001),
+GEN_VSX_XFORM_300(xscmpuqp, 0x04, 0x14, 0x00600001),
 GEN_XX3FORM(xsmaxdp, 0x00, 0x14, PPC2_VSX),
 GEN_XX3FORM(xsmindp, 0x00, 0x15, PPC2_VSX),
 GEN_XX2FORM(xscvdpsp, 0x12, 0x10, PPC2_VSX),
-- 
2.9.3
