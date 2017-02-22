Received: from eggs.gnu.org ([2001:4830:134:3::10]:37941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV9-00036L-Po
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV6-00085F-He
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:30 +1100
Message-Id: <20170222063348.32176-26-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 25/43] target-ppc: Implement round to odd
 variants of quad FP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

xsaddqpo:  VSX Scalar Add Quad-Precision using round to Odd
xsmulqo:   VSX Scalar Multiply Quad-Precision using round to Odd
xsdivqpo:  VSX Scalar Divide Quad-Precision using round to Odd
xscvqpdpo: VSX Scalar round & Convert Quad-Precision format to
           Double-Precision format using round to Odd
xssqrtqpo: VSX Scalar Square Root Quad-Precision using round to Odd
xssubqpo:  VSX Scalar Subtract Quad-Precision using round to Odd

In addition, fix the invalid bitmask in the instruction encoding
of xssqrtqp[o].

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
CC: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c            | 42 ++++++++++++++++++--------------------
 target/ppc/translate/vsx-ops.inc.c |  2 +-
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 1b6cd3b..96f9801 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1850,12 +1850,11 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
     getVSR(rD(opcode) + 32, &xt, env);
     helper_reset_fpstatus(env);
 
+    tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        /* TODO: Support xsadddpo after round-to-odd is implemented */
-        abort();
+        tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    tstat = env->fp_status;
     set_float_exception_flags(0, &tstat);
     xt.f128 = float128_add(xa.f128, xb.f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
@@ -1930,19 +1929,18 @@ VSX_MUL(xvmulsp, 4, float32, VsrW(i), 0, 0)
 void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
 {
     ppc_vsr_t xt, xa, xb;
+    float_status tstat;
 
     getVSR(rA(opcode) + 32, &xa, env);
     getVSR(rB(opcode) + 32, &xb, env);
     getVSR(rD(opcode) + 32, &xt, env);
 
+    helper_reset_fpstatus(env);
+    tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        /* TODO: Support xsmulpo after round-to-odd is implemented */
-        abort();
+        tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    helper_reset_fpstatus(env);
-
-    float_status tstat = env->fp_status;
     set_float_exception_flags(0, &tstat);
     xt.f128 = float128_mul(xa.f128, xb.f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
@@ -2019,18 +2017,18 @@ VSX_DIV(xvdivsp, 4, float32, VsrW(i), 0, 0)
 void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
 {
     ppc_vsr_t xt, xa, xb;
+    float_status tstat;
 
     getVSR(rA(opcode) + 32, &xa, env);
     getVSR(rB(opcode) + 32, &xb, env);
     getVSR(rD(opcode) + 32, &xt, env);
 
+    helper_reset_fpstatus(env);
+    tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        /* TODO: Support xsdivqpo after round-to-odd is implemented */
-        abort();
+        tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    helper_reset_fpstatus(env);
-    float_status tstat = env->fp_status;
     set_float_exception_flags(0, &tstat);
     xt.f128 = float128_div(xa.f128, xb.f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
@@ -2954,18 +2952,20 @@ VSX_CVT_FP_TO_FP_HP(xvcvhpsp, 4, float16, float32, VsrH(2 * i + 1), VsrW(i), 0)
 void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode)
 {
     ppc_vsr_t xt, xb;
+    float_status tstat;
 
     getVSR(rB(opcode) + 32, &xb, env);
     memset(&xt, 0, sizeof(xt));
 
+    tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        /* TODO: Support xscvqpdpo after round-to-odd is implemented */
-        abort();
+        tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    xt.VsrD(0) = float128_to_float64(xb.f128, &env->fp_status);
+    xt.VsrD(0) = float128_to_float64(xb.f128, &tstat);
+    env->fp_status.float_exception_flags |= tstat.float_exception_flags;
     if (unlikely(float128_is_signaling_nan(xb.f128,
-                                           &env->fp_status))) {
+                                           &tstat))) {
         float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);
         xt.VsrD(0) = float64_snan_to_qnan(xt.VsrD(0));
     }
@@ -3496,12 +3496,11 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
     memset(&xt, 0, sizeof(xt));
     helper_reset_fpstatus(env);
 
+    tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        /* TODO: Support xsadddpo after round-to-odd is implemented */
-        abort();
+        tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    tstat = env->fp_status;
     set_float_exception_flags(0, &tstat);
     xt.f128 = float128_sqrt(xb.f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
@@ -3534,12 +3533,11 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
     getVSR(rD(opcode) + 32, &xt, env);
     helper_reset_fpstatus(env);
 
+    tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        /* TODO: Support xssubqp after round-to-odd is implemented */
-        abort();
+        tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    tstat = env->fp_status;
     set_float_exception_flags(0, &tstat);
     xt.f128 = float128_sub(xa.f128, xb.f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index c1b71ad..e20ca32 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -115,7 +115,7 @@ GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x18, opc4 | 0x1, inval)
 
 GEN_VSX_Z23FORM_300(xsrqpi, 0x05, 0x0, 0x0, 0x0),
 GEN_VSX_Z23FORM_300(xsrqpxp, 0x05, 0x1, 0x0, 0x0),
-GEN_VSX_XFORM_300_EO(xssqrtqp, 0x04, 0x19, 0x1B, 0x00000001),
+GEN_VSX_XFORM_300_EO(xssqrtqp, 0x04, 0x19, 0x1B, 0x0),
 GEN_VSX_XFORM_300(xssubqp, 0x04, 0x10, 0x0),
 
 GEN_XX2FORM(xsabsdp, 0x12, 0x15, PPC2_VSX),
-- 
2.9.3
