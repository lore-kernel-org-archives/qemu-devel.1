Received: from eggs.gnu.org ([2001:4830:134:3::10]:55875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs9m-0001Ud-Ek
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs9j-00013l-Fy
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44621
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cQs9j-00013P-AY
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:47 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0A8nH4I034213
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:46 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27vcdnk2bh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:46 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 14:21:42 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 14:20:43 +0530
In-Reply-To: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1484038243-30314-12-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 11/11] target-ppc: Add xscvqps[d,
 w]z instructions
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

xscvqpsdz: VSX Scalar truncate & Convert Quad-Precision format to
           Signed Doubleword format
xscvqpswz: VSX Scalar truncate & Convert Quad-Precision format to
           Signed Word format

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 40 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  |  2 ++
 4 files changed, 46 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 4da83d9..ae57272 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2878,6 +2878,46 @@ VSX_CVT_FP_TO_INT(xvcvspsxws, 4, float32, int32, VsrW(i), VsrW(i), 0x80000000U)
 VSX_CVT_FP_TO_INT(xvcvspuxds, 2, float32, uint64, VsrW(2*i), VsrD(i), 0ULL)
 VSX_CVT_FP_TO_INT(xvcvspuxws, 4, float32, uint32, VsrW(i), VsrW(i), 0U)
 
+/* VSX_CVT_FP_TO_INT_VECTOR - VSX floating point to integer conversion
+ *   op    - instruction mnemonic
+ *   stp   - source type (float32 or float64)
+ *   ttp   - target type (int32, uint32, int64 or uint64)
+ *   sfld  - source vsr_t field
+ *   tfld  - target vsr_t field
+ *   rnan  - resulting NaN
+ */
+#define VSX_CVT_FP_TO_INT_VECTOR(op, stp, ttp, sfld, tfld, rnan)             \
+void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
+{                                                                            \
+    ppc_vsr_t xt, xb;                                                        \
+                                                                             \
+    getVSR(rB(opcode) + 32, &xb, env);                                       \
+    memset(&xt, 0, sizeof(xt));                                              \
+                                                                             \
+    if (unlikely(stp##_is_any_nan(xb.sfld))) {                               \
+        if (stp##_is_signaling_nan(xb.sfld, &env->fp_status)) {              \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);           \
+        }                                                                    \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, 0);                \
+        xt.tfld = rnan;                                                      \
+    } else {                                                                 \
+        xt.tfld = stp##_to_##ttp##_round_to_zero(xb.sfld,                    \
+                      &env->fp_status);                                      \
+        if (env->fp_status.float_exception_flags & float_flag_invalid) {     \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, 0);            \
+        }                                                                    \
+    }                                                                        \
+                                                                             \
+    putVSR(rD(opcode) + 32, &xt, env);                                       \
+    float_check_status(env);                                                 \
+}
+
+VSX_CVT_FP_TO_INT_VECTOR(xscvqpsdz, float128, int64, f128, VsrD(0),          \
+                  0x8000000000000000ULL)
+
+VSX_CVT_FP_TO_INT_VECTOR(xscvqpswz, float128, int32, f128, VsrD(0),          \
+                  0xffffffff80000000ULL)
+
 /* VSX_CVT_INT_TO_FP - VSX integer to floating point conversion
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 27607bf..54853b8 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -434,6 +434,8 @@ DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
 DEF_HELPER_2(xscvqpdp, void, env, i32)
+DEF_HELPER_2(xscvqpsdz, void, env, i32)
+DEF_HELPER_2(xscvqpswz, void, env, i32)
 DEF_HELPER_2(xscvhpdp, void, env, i32)
 DEF_HELPER_2(xscvspdp, void, env, i32)
 DEF_HELPER_2(xscvspdpn, i64, env, i64)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 7e068a4..3c924ba 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -811,6 +811,8 @@ GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvqpdp, 0x04, 0x1A, 0x14, PPC2_ISA300)
+GEN_VSX_HELPER_2(xscvqpsdz, 0x04, 0x1A, 0x19, PPC2_ISA300)
+GEN_VSX_HELPER_2(xscvqpswz, 0x04, 0x1A, 0x09, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xscvspdpn, 0x16, 0x14, 0, PPC2_VSX207)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 367fd38..297c317 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -114,6 +114,8 @@ GEN_VSX_XFORM_300_EO(xsnegqp, 0x04, 0x19, 0x10, 0x00000001),
 GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
 GEN_VSX_XFORM_300_EO(xscvdpqp, 0x04, 0x1A, 0x16, 0x00000001),
 GEN_VSX_XFORM_300_EO(xscvqpdp, 0x04, 0x1A, 0x14, 0x0),
+GEN_VSX_XFORM_300_EO(xscvqpsdz, 0x04, 0x1A, 0x19, 0x00000001),
+GEN_VSX_XFORM_300_EO(xscvqpswz, 0x04, 0x1A, 0x09, 0x00000001),
 
 #ifdef TARGET_PPC64
 GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
-- 
2.7.4
