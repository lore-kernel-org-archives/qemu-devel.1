Received: from eggs.gnu.org ([2001:4830:134:3::10]:52393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kA-0007oA-16
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k3-00049q-UZ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:28 +1100
Message-Id: <20170202051445.5735-91-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 090/107] target-ppc: Add xsmulqp instruction
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

xsmulqp: VSX Scalar Multiply Quad-Precision

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 35 +++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 38 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 545bbbc..e7e1024 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1927,6 +1927,41 @@ VSX_MUL(xsmulsp, 1, float64, VsrD(0), 1, 1)
 VSX_MUL(xvmuldp, 2, float64, VsrD(i), 0, 0)
 VSX_MUL(xvmulsp, 4, float32, VsrW(i), 0, 0)
 
+void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xt, xa, xb;
+
+    getVSR(rA(opcode) + 32, &xa, env);
+    getVSR(rB(opcode) + 32, &xb, env);
+    getVSR(rD(opcode) + 32, &xt, env);
+
+    if (unlikely(Rc(opcode) != 0)) {
+        /* TODO: Support xsmulpo after round-to-odd is implemented */
+        abort();
+    }
+
+    helper_reset_fpstatus(env);
+
+    float_status tstat = env->fp_status;
+    set_float_exception_flags(0, &tstat);
+    xt.f128 = float128_mul(xa.f128, xb.f128, &tstat);
+    env->fp_status.float_exception_flags |= tstat.float_exception_flags;
+
+    if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
+        if ((float128_is_infinity(xa.f128) && float128_is_zero(xb.f128)) ||
+            (float128_is_infinity(xb.f128) && float128_is_zero(xa.f128))) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
+        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
+                   float128_is_signaling_nan(xb.f128, &tstat)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+        }
+    }
+    helper_compute_fprf_float128(env, xt.f128);
+
+    putVSR(rD(opcode) + 32, &xt, env);
+    float_check_status(env);
+}
+
 /* VSX_DIV - VSX floating point divide
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 71bf182..9f8f0ed 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -403,6 +403,7 @@ DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xsaddqp, void, env, i32)
 DEF_HELPER_2(xssubdp, void, env, i32)
 DEF_HELPER_2(xsmuldp, void, env, i32)
+DEF_HELPER_2(xsmulqp, void, env, i32)
 DEF_HELPER_2(xsdivdp, void, env, i32)
 DEF_HELPER_2(xsdivqp, void, env, i32)
 DEF_HELPER_2(xsredp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 38fab01..d75474e 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -780,6 +780,7 @@ GEN_VSX_HELPER_2(xsadddp, 0x00, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsaddqp, 0x04, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xssubdp, 0x00, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xsmulqp, 0x04, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsdivdp, 0x00, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsdivqp, 0x04, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index c1164c3..589b505 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -146,6 +146,7 @@ GEN_XX3FORM(xsadddp, 0x00, 0x04, PPC2_VSX),
 GEN_VSX_XFORM_300(xsaddqp, 0x04, 0x00, 0x0),
 GEN_XX3FORM(xssubdp, 0x00, 0x05, PPC2_VSX),
 GEN_XX3FORM(xsmuldp, 0x00, 0x06, PPC2_VSX),
+GEN_VSX_XFORM_300(xsmulqp, 0x04, 0x01, 0x0),
 GEN_XX3FORM(xsdivdp, 0x00, 0x07, PPC2_VSX),
 GEN_XX2FORM(xsredp,  0x14, 0x05, PPC2_VSX),
 GEN_XX2FORM(xssqrtdp,  0x16, 0x04, PPC2_VSX),
-- 
2.9.3
