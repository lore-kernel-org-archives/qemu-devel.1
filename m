Received: from eggs.gnu.org ([2001:4830:134:3::10]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZlvV-0006Vk-6c
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZlvT-00074p-PN
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:01:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZlvT-00074Y-HF
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:01:51 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v13Lxtog022600
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 17:01:49 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28cuc6qj38-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 17:01:49 -0500
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Fri, 3 Feb 2017 20:01:47 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Fri,  3 Feb 2017 20:01:15 -0200
In-Reply-To: <1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1486159277-25949-3-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/4] ppc: implement xsrqpxp instruction
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

xsrqpxp: VSX Scalar Round Quad-Precision to Double-Extended Precision.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 56 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 59 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 593befa..e032363 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3337,3 +3337,59 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
     putVSR(rD(opcode) + 32, &xt, env);
 }
 
+void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xb;
+    ppc_vsr_t xt;
+    uint8_t r = Rrm(opcode);
+    uint8_t rmc = RMC(opcode);
+    uint8_t rmode = 0;
+    floatx80 round_res;
+    float_status tstat;
+
+    getVSR(rB(opcode) + 32, &xb, env);
+    memset(&xt, 0, sizeof(xt));
+    helper_reset_fpstatus(env);
+
+    if (r == 0 && rmc == 0) {
+        rmode = float_round_ties_away;
+    } else if (r == 0 && rmc == 0x3) {
+        rmode = fpscr_rn;
+    } else if (r == 1) {
+        switch (rmc) {
+        case 0:
+            rmode = float_round_nearest_even;
+            break;
+        case 1:
+            rmode = float_round_to_zero;
+            break;
+        case 2:
+            rmode = float_round_up;
+            break;
+        case 3:
+            rmode = float_round_down;
+            break;
+        default:
+            abort();
+        }
+    }
+
+    tstat = env->fp_status;
+    set_float_exception_flags(0, &tstat);
+    set_float_rounding_mode(rmode, &tstat);
+    round_res = float128_to_floatx80(xb.f128, &tstat);
+    xt.f128 = floatx80_to_float128(round_res, &tstat);
+    env->fp_status.float_exception_flags |= tstat.float_exception_flags;
+
+    if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
+        if (float128_is_signaling_nan(xb.f128, &tstat)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);
+            xt.f128 = float128_snan_to_qnan(xt.f128);
+        }
+    }
+
+    helper_compute_fprf_float128(env, xt.f128);
+    putVSR(rD(opcode) + 32, &xt, env);
+    float_check_status(env);
+}
+
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6a53ae0..9ce2e58 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -460,6 +460,7 @@ DEF_HELPER_2(xsrdpim, void, env, i32)
 DEF_HELPER_2(xsrdpip, void, env, i32)
 DEF_HELPER_2(xsrdpiz, void, env, i32)
 DEF_HELPER_2(xsrqpi, void, env, i32)
+DEF_HELPER_2(xsrqpxp, void, env, i32)
 
 DEF_HELPER_2(xsaddsp, void, env, i32)
 DEF_HELPER_2(xssubsp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 9868f01..91be201 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -834,6 +834,7 @@ GEN_VSX_HELPER_2(xsrdpiz, 0x12, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_VSX207)
 
 GEN_VSX_HELPER_2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
 
 GEN_VSX_HELPER_2(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index b095508..e58740b 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -114,6 +114,7 @@ GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x10, opc4 | 0x1, inval), \
 GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x18, opc4 | 0x1, inval)
 
 GEN_VSX_Z23FORM_300(xsrqpi, 0x05, 0x0, 0x0, 0x0),
+GEN_VSX_Z23FORM_300(xsrqpxp, 0x05, 0x1, 0x0, 0x0),
 
 GEN_XX2FORM(xsabsdp, 0x12, 0x15, PPC2_VSX),
 GEN_XX2FORM(xsnabsdp, 0x12, 0x16, PPC2_VSX),
-- 
2.7.4
