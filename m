Received: from eggs.gnu.org ([2001:4830:134:3::10]:39905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZlvd-0006do-Vj
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZlvZ-00077o-Vo
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:02:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZlvZ-00077B-Nd
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:01:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v13Lxq8P072154
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 17:01:56 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28crxt618p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 17:01:56 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Fri, 3 Feb 2017 20:01:53 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Fri,  3 Feb 2017 20:01:17 -0200
In-Reply-To: <1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1486159277-25949-5-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/4] ppc: implement xssubqp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com

xssubqp: VSX Scalar Subtract Quad-Precision.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 34 ++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 37 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 46ec0ec..35a7bf2 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3431,3 +3431,37 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
     float_check_status(env);
 }
 
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
+
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
2.7.4
