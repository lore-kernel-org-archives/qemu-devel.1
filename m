Received: from eggs.gnu.org ([2001:4830:134:3::10]:46423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cdtDb-0000PR-7b
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cdtDY-0006Xn-3H
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:37:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cdtDX-0006X9-PL
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:37:32 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1F6XpoL082257
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 01:37:28 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28m9wxpumr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 01:37:27 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 15 Feb 2017 12:07:24 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 12:07:16 +0530
Message-Id: <1487140636-19955-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] target-ppc: Add quad precision muladd
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

xsmaddqp:   VSX Scalar Multiply-Add Quad-Precision
xsmaddqpo:  VSX Scalar Multiply-Add Quad-Precision using round to Odd
xsnmaddqp:  VSX Scalar Negative Multiply-Add Quad-Precision
xsnmaddqpo: VSX Scalar Negative Multiply-Add Quad-Precision using round to Odd

xsmsubqp:   VSX Scalar Multiply-Subtract Quad-Precision
xsmsubqpo:  VSX Scalar Multiply-Subtract Quad-Precision using round to Odd
xsnmsubqp:  VSX Scalar Negative Multiply-Subtract Quad-Precision
xsnmsubqpo: VSX Scalar Negative Multiply-Subtract Quad-Precision
            using round to Odd

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 69 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  4 +++
 target/ppc/translate/vsx-impl.inc.c |  4 +++
 target/ppc/translate/vsx-ops.inc.c  |  4 +++
 4 files changed, 81 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 58aee64..201cafd 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2425,6 +2425,75 @@ VSX_MADD(xvnmaddmsp, 4, float32, VsrW(i), NMADD_FLGS, 0, 0, 0)
 VSX_MADD(xvnmsubasp, 4, float32, VsrW(i), NMSUB_FLGS, 1, 0, 0)
 VSX_MADD(xvnmsubmsp, 4, float32, VsrW(i), NMSUB_FLGS, 0, 0, 0)
 
+/*
+ * Quadruple-precision version of multiply and add/subtract.
+ *
+ * This implementation is not 100% accurate as we truncate the
+ * intermediate result of multiplication and then add/subtract
+ * separately.
+ *
+ * TODO: When float128_muladd() becomes available, switch this
+ * implementation to use that instead of separate float128_mul()
+ * followed by float128_add().
+ */
+#define VSX_MADD_QP(op, maddflgs)                                             \
+void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
+{                                                                             \
+    ppc_vsr_t xt_in, xa, xb, xt_out;                                          \
+                                                                              \
+    getVSR(rA(opcode) + 32, &xa, env);                                        \
+    getVSR(rB(opcode) + 32, &xb, env);                                        \
+    getVSR(rD(opcode) + 32, &xt_in, env);                                     \
+                                                                              \
+    xt_out = xt_in;                                                           \
+    helper_reset_fpstatus(env);                                               \
+    float_status tstat = env->fp_status;                                      \
+    if (unlikely(Rc(opcode) != 0)) {                                          \
+        tstat.float_rounding_mode = float_round_to_odd;                       \
+    }                                                                         \
+    set_float_exception_flags(0, &tstat);                                     \
+    xt_out.f128 = float128_mul(xa.f128, xt_in.f128, &tstat);                  \
+                                                                              \
+    if (maddflgs & float_muladd_negate_c) {                                   \
+        xb.VsrD(0) ^= 0x8000000000000000;                                     \
+    }                                                                         \
+    xt_out.f128 = float128_add(xt_out.f128, xb.f128, &tstat);                 \
+    env->fp_status.float_exception_flags |= tstat.float_exception_flags;      \
+                                                                              \
+    if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {         \
+        if (float128_is_signaling_nan(xa.f128, &tstat) ||                     \
+            float128_is_signaling_nan(xt_in.f128, &tstat) ||                  \
+            float128_is_signaling_nan(xb.f128, &tstat)) {                     \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);            \
+            tstat.float_exception_flags &= ~float_flag_invalid;               \
+        }                                                                     \
+        if ((float128_is_infinity(xa.f128) && float128_is_zero(xt_in.f128)) ||\
+            (float128_is_zero(xa.f128) && float128_is_infinity(xt_in.f128))) {\
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);             \
+            tstat.float_exception_flags &= ~float_flag_invalid;               \
+        }                                                                     \
+        if ((tstat.float_exception_flags & float_flag_invalid) &&             \
+            ((float128_is_infinity(xa.f128) ||                                \
+            float128_is_infinity(xt_in.f128)) &&                              \
+            float128_is_infinity(xb.f128))) {                                 \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);             \
+        }                                                                     \
+    }                                                                         \
+                                                                              \
+    helper_compute_fprf_float128(env, xt_out.f128);                           \
+    if ((maddflgs & float_muladd_negate_result) &&                            \
+        !float128_is_any_nan(xt_out.f128)) {                                  \
+        xt_out.VsrD(0) ^= 0x8000000000000000;                                 \
+    }                                                                         \
+    putVSR(rD(opcode) + 32, &xt_out, env);                                    \
+    float_check_status(env);                                                  \
+}
+
+VSX_MADD_QP(xsmaddqp, MADD_FLGS)
+VSX_MADD_QP(xsmsubqp, MSUB_FLGS)
+VSX_MADD_QP(xsnmaddqp, NMADD_FLGS)
+VSX_MADD_QP(xsnmsubqp, NMSUB_FLGS)
+
 /* VSX_SCALAR_CMP_DP - VSX scalar floating point compare double precision
  *   op    - instruction mnemonic
  *   cmp   - comparison operation
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6d77661..eade946 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -480,12 +480,16 @@ DEF_HELPER_2(xssqrtsp, void, env, i32)
 DEF_HELPER_2(xsrsqrtesp, void, env, i32)
 DEF_HELPER_2(xsmaddasp, void, env, i32)
 DEF_HELPER_2(xsmaddmsp, void, env, i32)
+DEF_HELPER_2(xsmaddqp, void, env, i32)
 DEF_HELPER_2(xsmsubasp, void, env, i32)
 DEF_HELPER_2(xsmsubmsp, void, env, i32)
+DEF_HELPER_2(xsmsubqp, void, env, i32)
 DEF_HELPER_2(xsnmaddasp, void, env, i32)
 DEF_HELPER_2(xsnmaddmsp, void, env, i32)
+DEF_HELPER_2(xsnmaddqp, void, env, i32)
 DEF_HELPER_2(xsnmsubasp, void, env, i32)
 DEF_HELPER_2(xsnmsubmsp, void, env, i32)
+DEF_HELPER_2(xsnmsubqp, void, env, i32)
 
 DEF_HELPER_2(xvadddp, void, env, i32)
 DEF_HELPER_2(xvsubdp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 7f12908..0a96e6b 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -853,12 +853,16 @@ GEN_VSX_HELPER_2(xssqrtsp, 0x16, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsrsqrtesp, 0x14, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsmaddasp, 0x04, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsmaddmsp, 0x04, 0x01, 0, PPC2_VSX207)
+GEN_VSX_HELPER_2(xsmaddqp, 0x04, 0x0C, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsmsubasp, 0x04, 0x02, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsmsubmsp, 0x04, 0x03, 0, PPC2_VSX207)
+GEN_VSX_HELPER_2(xsmsubqp, 0x04, 0x0D, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsnmaddasp, 0x04, 0x10, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsnmaddmsp, 0x04, 0x11, 0, PPC2_VSX207)
+GEN_VSX_HELPER_2(xsnmaddqp, 0x04, 0x0E, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
+GEN_VSX_HELPER_2(xsnmsubqp, 0x04, 0x0F, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 5030c4a..e770fab 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -237,12 +237,16 @@ GEN_XX2FORM(xssqrtsp,  0x16, 0x00, PPC2_VSX207),
 GEN_XX2FORM(xsrsqrtesp,  0x14, 0x00, PPC2_VSX207),
 GEN_XX3FORM(xsmaddasp, 0x04, 0x00, PPC2_VSX207),
 GEN_XX3FORM(xsmaddmsp, 0x04, 0x01, PPC2_VSX207),
+GEN_VSX_XFORM_300(xsmaddqp, 0x04, 0x0C, 0x0),
 GEN_XX3FORM(xsmsubasp, 0x04, 0x02, PPC2_VSX207),
 GEN_XX3FORM(xsmsubmsp, 0x04, 0x03, PPC2_VSX207),
+GEN_VSX_XFORM_300(xsmsubqp, 0x04, 0x0D, 0x0),
 GEN_XX3FORM(xsnmaddasp, 0x04, 0x10, PPC2_VSX207),
 GEN_XX3FORM(xsnmaddmsp, 0x04, 0x11, PPC2_VSX207),
+GEN_VSX_XFORM_300(xsnmaddqp, 0x04, 0x0E, 0x0),
 GEN_XX3FORM(xsnmsubasp, 0x04, 0x12, PPC2_VSX207),
 GEN_XX3FORM(xsnmsubmsp, 0x04, 0x13, PPC2_VSX207),
+GEN_VSX_XFORM_300(xsnmsubqp, 0x04, 0x0F, 0x0),
 GEN_XX2FORM(xscvsxdsp, 0x10, 0x13, PPC2_VSX207),
 GEN_XX2FORM(xscvuxdsp, 0x10, 0x12, PPC2_VSX207),
 
-- 
2.7.4
