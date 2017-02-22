Received: from eggs.gnu.org ([2001:4830:134:3::10]:37559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV1-0002x0-59
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQUz-0007uK-LX
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:12 +1100
Message-Id: <20170222063348.32176-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/43] ppc: implement xssubqp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

xssubqp: VSX Scalar Subtract Quad-Precision.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 34 ++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 37 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 5c34438..48973a9 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3430,3 +3430,37 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
     putVSR(rD(opcode) + 32, &xt, env);
     float_check_status(env);
 }
+
+void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xt, xa, xb;
+    float_status tstat;
+
+    getVSR(rA(opcode) + 32, &xa, env);
+    getVSR(rB(opcode) + 32, &xb, env);
+    getVSR(rD(opcode) + 32, &xt, env);
+    helper_reset_fpstatus(env);
+
+    if (unlikely(Rc(opcode) != 0)) {
+        /* TODO: Support xssubqp after round-to-odd is implemented */
+        abort();
+    }
+
+    tstat = env->fp_status;
+    set_float_exception_flags(0, &tstat);
+    xt.f128 = float128_sub(xa.f128, xb.f128, &tstat);
+    env->fp_status.float_exception_flags |= tstat.float_exception_flags;
+
+    if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
+        if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f128)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
+        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
+                   float128_is_signaling_nan(xb.f128, &tstat)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+        }
+    }
+
+    helper_compute_fprf_float128(env, xt.f128);
+    putVSR(rD(opcode) + 32, &xt, env);
+    float_check_status(env);
+}
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index fbf80a7..3956fd1 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -462,6 +462,7 @@ DEF_HELPER_2(xsrdpiz, void, env, i32)
 DEF_HELPER_2(xsrqpi, void, env, i32)
 DEF_HELPER_2(xsrqpxp, void, env, i32)
 DEF_HELPER_2(xssqrtqp, void, env, i32)
+DEF_HELPER_2(xssubqp, void, env, i32)
 
 DEF_HELPER_2(xsaddsp, void, env, i32)
 DEF_HELPER_2(xssubsp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index bbd7d1a..a062203 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -836,6 +836,7 @@ GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
+GEN_VSX_HELPER_2(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
 
 GEN_VSX_HELPER_2(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index bac3db2..2202c0f 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -116,6 +116,7 @@ GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x18, opc4 | 0x1, inval)
 GEN_VSX_Z23FORM_300(xsrqpi, 0x05, 0x0, 0x0, 0x0),
 GEN_VSX_Z23FORM_300(xsrqpxp, 0x05, 0x1, 0x0, 0x0),
 GEN_VSX_XFORM_300_EO(xssqrtqp, 0x04, 0x19, 0x1B, 0x00000001),
+GEN_VSX_XFORM_300(xssubqp, 0x04, 0x10, 0x0),
 
 GEN_XX2FORM(xsabsdp, 0x12, 0x15, PPC2_VSX),
 GEN_XX2FORM(xsnabsdp, 0x12, 0x16, PPC2_VSX),
-- 
2.9.3
