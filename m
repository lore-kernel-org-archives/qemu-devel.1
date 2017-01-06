Received: from eggs.gnu.org ([2001:4830:134:3::10]:52491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNp8-0007P5-Kz
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNp5-00034U-KY
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:16:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35203
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cPNp5-00034F-Ey
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:16:19 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v066Dun3057001
	for <qemu-devel@nongnu.org>; Fri, 6 Jan 2017 01:16:19 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27t5prg6kv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 01:16:18 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Jan 2017 16:16:15 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  6 Jan 2017 11:44:52 +0530
In-Reply-To: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483683296-32568-11-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 10/14] target-ppc: Add xscvqpdp instruction
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

xscvqpdp:  VSX Scalar round & Convert Quad-Precision format to
           Double-Precision format

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 28 ++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 31 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 224876b..dfd3515 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2743,6 +2743,34 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                \
 VSX_CVT_FP_TO_FP_HP(xscvdphp, float64, float16, VsrD(0), VsrH(3))
 VSX_CVT_FP_TO_FP_HP(xscvhpdp, float16, float64, VsrH(3), VsrD(0))
 
+/*
+ * xscvqpdp isn't using VSX_CVT_FP_TO_FP() because xscvqpdpo will be
+ * added to this later.
+ */
+void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xt, xb;
+
+    getVSR(xB(opcode), &xb, env);
+    getVSR(xT(opcode), &xt, env);
+
+    if (unlikely(Rc(opcode) != 0)) {
+        /* TODO: Support xscvqpdpo after round-to-odd is implemented */
+        abort();
+    }
+
+    xt.VsrD(0) = float128_to_float64(xb.f128, &env->fp_status);
+    if (unlikely(float128_is_signaling_nan(xb.f128,
+                                           &env->fp_status))) {
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);
+        xt.VsrD(0) = float64_snan_to_qnan(xt.VsrD(0));
+    }
+    helper_compute_fprf_float64(env, xt.VsrD(0));
+
+    putVSR(xT(opcode), &xt, env);
+    float_check_status(env);
+}
+
 uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
 {
     float_status tstat = env->fp_status;
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3b5d0ad..f28bf62 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -433,6 +433,7 @@ DEF_HELPER_2(xscvdphp, void, env, i32)
 DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
+DEF_HELPER_2(xscvqpdp, void, env, i32)
 DEF_HELPER_2(xscvhpdp, void, env, i32)
 DEF_HELPER_2(xscvspdp, void, env, i32)
 DEF_HELPER_2(xscvspdpn, i64, env, i64)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 358ff4c..d9cdaf1 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -810,6 +810,7 @@ GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
+GEN_VSX_HELPER_2(xscvqpdp, 0x04, 0x1A, 0x14, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xscvspdpn, 0x16, 0x14, 0, PPC2_VSX207)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index fcf9597..cc5b268 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -113,6 +113,7 @@ GEN_VSX_XFORM_300_EO(xsnabsqp, 0x04, 0x19, 0x08, 0x00000001),
 GEN_VSX_XFORM_300_EO(xsnegqp, 0x04, 0x19, 0x10, 0x00000001),
 GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
 GEN_VSX_XFORM_300_EO(xscvdpqp, 0x04, 0x1A, 0x16, 0x00000001),
+GEN_VSX_XFORM_300_EO(xscvqpdp, 0x04, 0x1A, 0x14, 0x0),
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),
-- 
2.7.4
