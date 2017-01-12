Received: from eggs.gnu.org ([2001:4830:134:3::10]:45203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRiBU-0005ol-ME
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRiBQ-00081i-GI
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:25:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cRiBQ-00080L-6V
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:25:00 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0CGJUQU139531
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:24:59 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27x9h8jb4e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:24:59 -0500
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 21:54:54 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 21:54:09 +0530
In-Reply-To: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1484238251-8096-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 5/7] target-ppc: Add xvcv[hpsp,
 sphp] instructions
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

xvcvhpsp: VSX Vector Convert Half Precision to Single Precision
xvcvsphp: VSX Vector Convert Single Precision to Half Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 27 ++++++++++++++++++---------
 target/ppc/helper.h                 |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  |  2 ++
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index e7e1024..ffcf9ca 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2817,33 +2817,42 @@ VSX_CVT_FP_TO_FP_VECTOR(xscvdpqp, 1, float64, float128, VsrD(0), f128, 1)
 /* VSX_CVT_FP_TO_FP_HP - VSX floating point/floating point conversion
  *                       involving one half precision value
  *   op    - instruction mnemonic
+ *   nels  - number of elements (1, 2 or 4)
  *   stp   - source type
  *   ttp   - target type
  *   sfld  - source vsr_t field
  *   tfld  - target vsr_t field
+ *   sfprf - set FPRF
  */
-#define VSX_CVT_FP_TO_FP_HP(op, stp, ttp, sfld, tfld)              \
+#define VSX_CVT_FP_TO_FP_HP(op, nels, stp, ttp, sfld, tfld, sfprf) \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                \
 {                                                                  \
     ppc_vsr_t xt, xb;                                              \
+    int i;                                                         \
                                                                    \
     getVSR(xB(opcode), &xb, env);                                  \
     memset(&xt, 0, sizeof(xt));                                    \
                                                                    \
-    xt.tfld = stp##_to_##ttp(xb.sfld, 1, &env->fp_status);         \
-    if (unlikely(stp##_is_signaling_nan(xb.sfld,                   \
-                                        &env->fp_status))) {       \
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);     \
-        xt.tfld = ttp##_snan_to_qnan(xt.tfld);                     \
+    for (i = 0; i < nels; i++) {                                   \
+        xt.tfld = stp##_to_##ttp(xb.sfld, 1, &env->fp_status);     \
+        if (unlikely(stp##_is_signaling_nan(xb.sfld,               \
+                                            &env->fp_status))) {   \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0); \
+            xt.tfld = ttp##_snan_to_qnan(xt.tfld);                 \
+        }                                                          \
+        if (sfprf) {                                               \
+            helper_compute_fprf_##ttp(env, xt.tfld);               \
+        }                                                          \
     }                                                              \
-    helper_compute_fprf_##ttp(env, xt.tfld);                       \
                                                                    \
     putVSR(xT(opcode), &xt, env);                                  \
     float_check_status(env);                                       \
 }
 
-VSX_CVT_FP_TO_FP_HP(xscvdphp, float64, float16, VsrD(0), VsrH(3))
-VSX_CVT_FP_TO_FP_HP(xscvhpdp, float16, float64, VsrH(3), VsrD(0))
+VSX_CVT_FP_TO_FP_HP(xscvdphp, 1, float64, float16, VsrD(0), VsrH(3), 1)
+VSX_CVT_FP_TO_FP_HP(xscvhpdp, 1, float16, float64, VsrH(3), VsrD(0), 1)
+VSX_CVT_FP_TO_FP_HP(xvcvsphp, 4, float32, float16, VsrW(i), VsrH(2 * i  + 1), 0)
+VSX_CVT_FP_TO_FP_HP(xvcvhpsp, 4, float16, float32, VsrH(2 * i + 1), VsrW(i), 0)
 
 /*
  * xscvqpdp isn't using VSX_CVT_FP_TO_FP() because xscvqpdpo will be
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 9cd6534..14a12e0 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -536,6 +536,8 @@ DEF_HELPER_2(xvcmpgesp, void, env, i32)
 DEF_HELPER_2(xvcmpgtsp, void, env, i32)
 DEF_HELPER_2(xvcmpnesp, void, env, i32)
 DEF_HELPER_2(xvcvspdp, void, env, i32)
+DEF_HELPER_2(xvcvsphp, void, env, i32)
+DEF_HELPER_2(xvcvhpsp, void, env, i32)
 DEF_HELPER_2(xvcvspsxds, void, env, i32)
 DEF_HELPER_2(xvcvspsxws, void, env, i32)
 DEF_HELPER_2(xvcvspuxds, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index d75474e..9bcc5af 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -913,6 +913,8 @@ GEN_VSX_HELPER_2(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvspdp, 0x12, 0x1C, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300)
+GEN_VSX_HELPER_2(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300)
 GEN_VSX_HELPER_2(xvcvspsxds, 0x10, 0x19, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvspsxws, 0x10, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvspuxds, 0x10, 0x18, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 589b505..ee74312 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -291,6 +291,8 @@ GEN_XX2FORM(xvrspiz, 0x12, 0x09, PPC2_VSX),
 GEN_XX2FORM_EO(xxbrh, 0x16, 0x1D, 0x07, PPC2_ISA300),
 GEN_XX2FORM_EO(xxbrw, 0x16, 0x1D, 0x0F, PPC2_ISA300),
 GEN_XX2FORM_EO(xxbrd, 0x16, 0x1D, 0x17, PPC2_ISA300),
+GEN_XX2FORM_EO(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300),
+GEN_XX2FORM_EO(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300),
 GEN_XX2FORM_EO(xxbrq, 0x16, 0x1D, 0x1F, PPC2_ISA300),
 
 #define VSX_LOGICAL(name, opc2, opc3, fl2) \
-- 
2.7.4
