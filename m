Received: from eggs.gnu.org ([2001:4830:134:3::10]:37569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV1-0002x6-Mh
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV0-0007w9-DN
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:11 +1100
Message-Id: <20170222063348.32176-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/43] ppc: implement xssqrtqp instruction
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

xssqrtqp: VSX Scalar Square Root Quad-Precision.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 38 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 41 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index b422442..5c34438 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3392,3 +3392,41 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode)
     putVSR(rD(opcode) + 32, &xt, env);
     float_check_status(env);
 }
+
+void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xb;
+    ppc_vsr_t xt;
+    float_status tstat;
+
+    getVSR(rB(opcode) + 32, &xb, env);
+    memset(&xt, 0, sizeof(xt));
+    helper_reset_fpstatus(env);
+
+    if (unlikely(Rc(opcode) != 0)) {
+        /* TODO: Support xsadddpo after round-to-odd is implemented */
+        abort();
+    }
+
+    tstat = env->fp_status;
+    set_float_exception_flags(0, &tstat);
+    xt.f128 = float128_sqrt(xb.f128, &tstat);
+    env->fp_status.float_exception_flags |= tstat.float_exception_flags;
+
+    if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
+        if (float128_is_signaling_nan(xb.f128, &tstat)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+            xt.f128 = float128_snan_to_qnan(xb.f128);
+        } else if  (float128_is_quiet_nan(xb.f128, &tstat)) {
+            xt.f128 = xb.f128;
+        } else if (float128_is_neg(xb.f128) && !float128_is_zero(xb.f128)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, 1);
+            set_snan_bit_is_one(0, &env->fp_status);
+            xt.f128 = float128_default_nan(&env->fp_status);
+        }
+    }
+
+    helper_compute_fprf_float128(env, xt.f128);
+    putVSR(rD(opcode) + 32, &xt, env);
+    float_check_status(env);
+}
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 9ce2e58..fbf80a7 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -461,6 +461,7 @@ DEF_HELPER_2(xsrdpip, void, env, i32)
 DEF_HELPER_2(xsrdpiz, void, env, i32)
 DEF_HELPER_2(xsrqpi, void, env, i32)
 DEF_HELPER_2(xsrqpxp, void, env, i32)
+DEF_HELPER_2(xssqrtqp, void, env, i32)
 
 DEF_HELPER_2(xsaddsp, void, env, i32)
 DEF_HELPER_2(xssubsp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 91be201..bbd7d1a 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -835,6 +835,7 @@ GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_VSX207)
 
 GEN_VSX_HELPER_2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
 
 GEN_VSX_HELPER_2(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index e58740b..bac3db2 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -115,6 +115,7 @@ GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x18, opc4 | 0x1, inval)
 
 GEN_VSX_Z23FORM_300(xsrqpi, 0x05, 0x0, 0x0, 0x0),
 GEN_VSX_Z23FORM_300(xsrqpxp, 0x05, 0x1, 0x0, 0x0),
+GEN_VSX_XFORM_300_EO(xssqrtqp, 0x04, 0x19, 0x1B, 0x00000001),
 
 GEN_XX2FORM(xsabsdp, 0x12, 0x15, PPC2_VSX),
 GEN_XX2FORM(xsnabsdp, 0x12, 0x16, PPC2_VSX),
-- 
2.9.3
