Received: from eggs.gnu.org ([2001:4830:134:3::10]:42493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cP6C1-0000VR-Dd
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cP6Bx-0006Qq-EI
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54236
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cP6Bx-0006QN-9Q
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:45 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v05BO0Aw091586
	for <qemu-devel@nongnu.org>; Thu, 5 Jan 2017 06:26:44 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27skwvux54-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 06:26:44 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 5 Jan 2017 16:56:40 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  5 Jan 2017 16:56:12 +0530
In-Reply-To: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483615579-17618-8-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 07/14] target-ppc: Add xscvdphp, xscvhpdp
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

xscvdphp: VSX Scalar round & Convert Double-Precision format to
          Half-Precision format
xscvhpdp: VSX Scalar Convert Half-Precision format to
          Double-Precision format

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 include/fpu/softfloat.h             | 20 ++++++++++++++++++++
 target-ppc/fpu_helper.c             | 33 +++++++++++++++++++++++++++++++++
 target-ppc/helper.h                 |  2 ++
 target-ppc/internal.h               |  3 +++
 target-ppc/translate/vsx-impl.inc.c |  2 ++
 target-ppc/translate/vsx-ops.inc.c  |  2 ++
 6 files changed, 62 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 14f8383..842ec6b 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -356,6 +356,26 @@ static inline int float16_is_any_nan(float16 a)
     return ((float16_val(a) & ~0x8000) > 0x7c00);
 }
 
+static inline int float16_is_neg(float16 a)
+{
+    return float16_val(a) >> 15;
+}
+
+static inline int float16_is_infinity(float16 a)
+{
+    return (float16_val(a) & 0x7fff) == 0x7c00;
+}
+
+static inline int float16_is_zero(float16 a)
+{
+    return (float16_val(a) & 0x7fff) == 0;
+}
+
+static inline int float16_is_zero_or_denormal(float16 a)
+{
+    return (float16_val(a) & 0x7c00) == 0;
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
diff --git a/target-ppc/fpu_helper.c b/target-ppc/fpu_helper.c
index d48cf51..aacfd12 100644
--- a/target-ppc/fpu_helper.c
+++ b/target-ppc/fpu_helper.c
@@ -24,6 +24,7 @@
 
 #define float64_snan_to_qnan(x) ((x) | 0x0008000000000000ULL)
 #define float32_snan_to_qnan(x) ((x) | 0x00400000)
+#define float16_snan_to_qnan(x) ((x) | 0x0200)
 
 /*****************************************************************************/
 /* Floating point operations helpers */
@@ -107,6 +108,7 @@ void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
     env->fpscr |= fprf << FPSCR_FPRF;                          \
 }
 
+COMPUTE_FPRF(float16)
 COMPUTE_FPRF(float64)
 COMPUTE_FPRF(float128)
 
@@ -2700,6 +2702,37 @@ VSX_CVT_FP_TO_FP(xscvspdp, 1, float32, float64, VsrW(0), VsrD(0), 1)
 VSX_CVT_FP_TO_FP(xvcvdpsp, 2, float64, float32, VsrD(i), VsrW(2*i), 0)
 VSX_CVT_FP_TO_FP(xvcvspdp, 2, float32, float64, VsrW(2*i), VsrD(i), 0)
 
+/* VSX_CVT_FP_TO_FP_HP - VSX floating point/floating point conversion
+ *                       involving one half precision value
+ *   op    - instruction mnemonic
+ *   stp   - source type
+ *   ttp   - target type
+ *   sfld  - source vsr_t field
+ *   tfld  - target vsr_t field
+ */
+#define VSX_CVT_FP_TO_FP_HP(op, stp, ttp, sfld, tfld)              \
+void helper_##op(CPUPPCState *env, uint32_t opcode)                \
+{                                                                  \
+    ppc_vsr_t xt, xb;                                              \
+                                                                   \
+    getVSR(xB(opcode), &xb, env);                                  \
+    memset(&xt, 0, sizeof(xt));                                    \
+                                                                   \
+    xt.tfld = stp##_to_##ttp(xb.sfld, 1, &env->fp_status);         \
+    if (unlikely(stp##_is_signaling_nan(xb.sfld,                   \
+                                        &env->fp_status))) {       \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);     \
+        xt.tfld = ttp##_snan_to_qnan(xt.tfld);                     \
+    }                                                              \
+    helper_compute_fprf_##ttp(env, xt.tfld);                       \
+                                                                   \
+    putVSR(xT(opcode), &xt, env);                                  \
+    float_check_status(env);                                       \
+}
+
+VSX_CVT_FP_TO_FP_HP(xscvdphp, float64, float16, VsrD(0), VsrH(3))
+VSX_CVT_FP_TO_FP_HP(xscvhpdp, float16, float64, VsrH(3), VsrD(0))
+
 uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
 {
     float_status tstat = env->fp_status;
diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index cd7b608..889fe55 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -429,8 +429,10 @@ DEF_HELPER_2(xscmpoqp, void, env, i32)
 DEF_HELPER_2(xscmpuqp, void, env, i32)
 DEF_HELPER_2(xsmaxdp, void, env, i32)
 DEF_HELPER_2(xsmindp, void, env, i32)
+DEF_HELPER_2(xscvdphp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
+DEF_HELPER_2(xscvhpdp, void, env, i32)
 DEF_HELPER_2(xscvspdp, void, env, i32)
 DEF_HELPER_2(xscvspdpn, i64, env, i64)
 DEF_HELPER_2(xscvdpsxds, void, env, i32)
diff --git a/target-ppc/internal.h b/target-ppc/internal.h
index f4f02e5..16fc117 100644
--- a/target-ppc/internal.h
+++ b/target-ppc/internal.h
@@ -212,10 +212,12 @@ typedef union _ppc_vsr_t {
 
 #if defined(HOST_WORDS_BIGENDIAN)
 #define VsrB(i) u8[i]
+#define VsrH(i) u16[i]
 #define VsrW(i) u32[i]
 #define VsrD(i) u64[i]
 #else
 #define VsrB(i) u8[15 - (i)]
+#define VsrH(i) u16[7 - (i)]
 #define VsrW(i) u32[3 - (i)]
 #define VsrD(i) u64[1 - (i)]
 #endif
@@ -243,4 +245,5 @@ static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
 }
 
 void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
+void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
 #endif /* PPC_INTERNAL_H */
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
index 51ac183..16242f2 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -806,8 +806,10 @@ GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
+GEN_VSX_HELPER_2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xscvspdpn, 0x16, 0x14, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvdpsxds, 0x10, 0x15, 0, PPC2_VSX)
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vsx-ops.inc.c
index 1155765..0704d7a 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -152,8 +152,10 @@ GEN_VSX_XFORM_300(xscmpoqp, 0x04, 0x04, 0x00600001),
 GEN_VSX_XFORM_300(xscmpuqp, 0x04, 0x14, 0x00600001),
 GEN_XX3FORM(xsmaxdp, 0x00, 0x14, PPC2_VSX),
 GEN_XX3FORM(xsmindp, 0x00, 0x15, PPC2_VSX),
+GEN_XX2FORM_EO(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300),
 GEN_XX2FORM(xscvdpsp, 0x12, 0x10, PPC2_VSX),
 GEN_XX2FORM(xscvdpspn, 0x16, 0x10, PPC2_VSX207),
+GEN_XX2FORM_EO(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300),
 GEN_XX2FORM(xscvspdp, 0x12, 0x14, PPC2_VSX),
 GEN_XX2FORM(xscvspdpn, 0x16, 0x14, PPC2_VSX207),
 GEN_XX2FORM(xscvdpsxds, 0x10, 0x15, PPC2_VSX),
-- 
2.7.4
