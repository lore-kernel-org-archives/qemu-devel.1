Received: from eggs.gnu.org ([2001:4830:134:3::10]:45140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRiBI-0005eR-W1
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRiBE-0007mq-Es
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cRiBE-0007kn-6I
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:48 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0CGJWWM139649
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:24:47 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27x9h8jaw4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:24:46 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 21:54:42 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 21:54:07 +0530
In-Reply-To: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1484238251-8096-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/7] target-ppc: Add xsdivqp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

xsdivqp: VSX Scalar Divide Quad-Precision

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 36 ++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 39 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index b9689b7..545bbbc 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1981,6 +1981,42 @@ VSX_DIV(xsdivsp, 1, float64, VsrD(0), 1, 1)
 VSX_DIV(xvdivdp, 2, float64, VsrD(i), 0, 0)
 VSX_DIV(xvdivsp, 4, float32, VsrW(i), 0, 0)
 
+void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xt, xa, xb;
+
+    getVSR(rA(opcode) + 32, &xa, env);
+    getVSR(rB(opcode) + 32, &xb, env);
+    getVSR(rD(opcode) + 32, &xt, env);
+
+    if (unlikely(Rc(opcode) != 0)) {
+        /* TODO: Support xsdivqpo after round-to-odd is implemented */
+        abort();
+    }
+
+    helper_reset_fpstatus(env);
+    float_status tstat = env->fp_status;
+    set_float_exception_flags(0, &tstat);
+    xt.f128 = float128_div(xa.f128, xb.f128, &tstat);
+    env->fp_status.float_exception_flags |= tstat.float_exception_flags;
+
+    if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
+        if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f128)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIDI, 1);
+        } else if (float128_is_zero(xa.f128) &&
+            float128_is_zero(xb.f128)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXZDZ, 1);
+        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
+            float128_is_signaling_nan(xb.f128, &tstat)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+        }
+    }
+
+    helper_compute_fprf_float128(env, xt.f128);
+    putVSR(rD(opcode) + 32, &xt, env);
+    float_check_status(env);
+}
+
 /* VSX_RE  - VSX floating point reciprocal estimate
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 73c60d7..636462f 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -404,6 +404,7 @@ DEF_HELPER_2(xsaddqp, void, env, i32)
 DEF_HELPER_2(xssubdp, void, env, i32)
 DEF_HELPER_2(xsmuldp, void, env, i32)
 DEF_HELPER_2(xsdivdp, void, env, i32)
+DEF_HELPER_2(xsdivqp, void, env, i32)
 DEF_HELPER_2(xsredp, void, env, i32)
 DEF_HELPER_2(xssqrtdp, void, env, i32)
 DEF_HELPER_2(xsrsqrtedp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 37004a4..38fab01 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -781,6 +781,7 @@ GEN_VSX_HELPER_2(xsaddqp, 0x04, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xssubdp, 0x00, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsdivdp, 0x00, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xsdivqp, 0x04, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 6b6b828..c1164c3 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -196,6 +196,7 @@ GEN_XX3FORM(xsaddsp, 0x00, 0x00, PPC2_VSX207),
 GEN_XX3FORM(xssubsp, 0x00, 0x01, PPC2_VSX207),
 GEN_XX3FORM(xsmulsp, 0x00, 0x02, PPC2_VSX207),
 GEN_XX3FORM(xsdivsp, 0x00, 0x03, PPC2_VSX207),
+GEN_VSX_XFORM_300(xsdivqp, 0x04, 0x11, 0x0),
 GEN_XX2FORM(xsresp,  0x14, 0x01, PPC2_VSX207),
 GEN_XX2FORM(xsrsp, 0x12, 0x11, PPC2_VSX207),
 GEN_XX2FORM(xssqrtsp,  0x16, 0x00, PPC2_VSX207),
-- 
2.7.4
