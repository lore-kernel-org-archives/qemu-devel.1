Received: from eggs.gnu.org ([2001:4830:134:3::10]:60188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5ZD-0007JN-Fv
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5ZA-0000NC-9T
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41884
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cc5ZA-0000N6-38
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:24 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1A7JFE5031463
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:23 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28gr4efb8q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:23 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 10 Feb 2017 17:24:20 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 10 Feb 2017 12:53:08 +0530
In-Reply-To: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1486711391-12247-5-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/7] target-ppc: Implement round to odd
 variants of quad FP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

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
2.7.4
