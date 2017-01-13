Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRy5m-0007me-Px
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRy5j-0003Vh-HH
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:24:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40202
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cRy5j-0003VS-AV
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:24:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0D9O5F8011324
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 04:24:10 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27xukj19qb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 04:24:10 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 13 Jan 2017 19:24:07 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 13 Jan 2017 14:53:40 +0530
In-Reply-To: <1484299420-23031-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484299420-23031-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1484299420-23031-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/2] target-ppc: Add xststdc[sp, dp,
 qp] instructions
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

xststdcsp: VSX Scalar Test Data Class Single-Precision
xststdcdp: VSX Scalar Test Data Class Double-Precision
xststdcqp: VSX Scalar Test Data Class Quad-Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 66 ++++++++++++++++++++++++++++++++-----
 target/ppc/helper.h                 |  3 ++
 target/ppc/internal.h               |  1 +
 target/ppc/translate/vsx-impl.inc.c |  3 ++
 target/ppc/translate/vsx-ops.inc.c  |  4 +++
 5 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 45bc93c..9f5cafd 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3196,17 +3196,22 @@ void helper_xvxsigsp(CPUPPCState *env, uint32_t opcode)
  *   fld   - vsr_t field (VsrD(*) or VsrW(*))
  *   tfld   - target vsr_t field (VsrD(*) or VsrW(*))
  *   fld_max - target field max
+ *   scrf - set result in CR and FPCC
  */
-#define VSX_TEST_DC(op, nels, xbn, tp, fld, tfld, fld_max)  \
+#define VSX_TEST_DC(op, nels, xbn, tp, fld, tfld, fld_max, scrf)  \
 void helper_##op(CPUPPCState *env, uint32_t opcode)         \
 {                                                           \
     ppc_vsr_t xt, xb;                                       \
     uint32_t i, sign, dcmx;                                 \
-    uint32_t match = 0;                                     \
+    uint32_t cc, match = 0;                                 \
                                                             \
     getVSR(xbn, &xb, env);                                  \
-    memset(&xt, 0, sizeof(xt));                             \
-    dcmx = DCMX_XV(opcode);                                 \
+    if (!scrf) {                                            \
+        memset(&xt, 0, sizeof(xt));                         \
+        dcmx = DCMX_XV(opcode);                             \
+    } else {                                                \
+        dcmx = DCMX(opcode);                                \
+    }                                                       \
                                                             \
     for (i = 0; i < nels; i++) {                            \
         sign = tp##_is_neg(xb.fld);                         \
@@ -3219,11 +3224,56 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)         \
         } else if (tp##_is_zero_or_denormal(xb.fld)) {      \
             match = extract32(dcmx, 0 + !sign, 1);          \
         }                                                   \
-        xt.tfld = match ? fld_max : 0;                      \
+                                                            \
+        if (scrf) {                                         \
+            cc = sign << CRF_LT_BIT | match << CRF_EQ_BIT;  \
+            env->fpscr &= ~(0x0F << FPSCR_FPRF);            \
+            env->fpscr |= cc << FPSCR_FPRF;                 \
+            env->crf[BF(opcode)] = cc;                      \
+        } else {                                            \
+            xt.tfld = match ? fld_max : 0;                  \
+        }                                                   \
         match = 0;                                          \
     }                                                       \
-    putVSR(xT(opcode), &xt, env);                           \
+    if (!scrf) {                                            \
+        putVSR(xT(opcode), &xt, env);                       \
+    }                                                       \
 }
 
-VSX_TEST_DC(xvtstdcdp, 2, xB(opcode), float64, VsrD(i), VsrD(i), UINT64_MAX)
-VSX_TEST_DC(xvtstdcsp, 4, xB(opcode), float32, VsrW(i), VsrW(i), UINT32_MAX)
+VSX_TEST_DC(xvtstdcdp, 2, xB(opcode), float64, VsrD(i), VsrD(i), UINT64_MAX, 0)
+VSX_TEST_DC(xvtstdcsp, 4, xB(opcode), float32, VsrW(i), VsrW(i), UINT32_MAX, 0)
+VSX_TEST_DC(xststdcdp, 1, xB(opcode), float64, VsrD(0), VsrD(0), 0, 1)
+VSX_TEST_DC(xststdcqp, 1, (rB(opcode) + 32), float128, f128, VsrD(0), 0, 1)
+
+void helper_xststdcsp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xb;
+    uint32_t dcmx, sign, exp;
+    uint32_t cc, match = 0, not_sp = 0;
+
+    getVSR(xB(opcode), &xb, env);
+    dcmx = DCMX(opcode);
+    exp = (xb.VsrD(0) >> 52) & 0x7FF;
+
+    sign = float64_is_neg(xb.VsrD(0));
+    if (float64_is_any_nan(xb.VsrD(0))) {
+        match = extract32(dcmx, 6, 1);
+    } else if (float64_is_infinity(xb.VsrD(0))) {
+        match = extract32(dcmx, 4 + !sign, 1);
+    } else if (float64_is_zero(xb.VsrD(0))) {
+        match = extract32(dcmx, 2 + !sign, 1);
+    } else if (float64_is_zero_or_denormal(xb.VsrD(0)) ||
+               (exp > 0 && exp < 0x381)) {
+        match = extract32(dcmx, 0 + !sign, 1);
+    }
+
+    not_sp = !float64_eq(xb.VsrD(0),
+                         float32_to_float64(
+                             float64_to_float32(xb.VsrD(0), &env->fp_status),
+                             &env->fp_status), &env->fp_status);
+
+    cc = sign << CRF_LT_BIT | match << CRF_EQ_BIT | not_sp << CRF_SO_BIT;
+    env->fpscr &= ~(0x0F << FPSCR_FPRF);
+    env->fpscr |= cc << FPSCR_FPRF;
+    env->crf[BF(opcode)] = cc;
+}
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 165e4a5..85af9df 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -451,6 +451,9 @@ DEF_HELPER_2(xscvuxdsp, void, env, i32)
 DEF_HELPER_2(xscvsxdsp, void, env, i32)
 DEF_HELPER_2(xscvudqp, void, env, i32)
 DEF_HELPER_2(xscvuxddp, void, env, i32)
+DEF_HELPER_2(xststdcsp, void, env, i32)
+DEF_HELPER_2(xststdcdp, void, env, i32)
+DEF_HELPER_2(xststdcqp, void, env, i32)
 DEF_HELPER_2(xsrdpi, void, env, i32)
 DEF_HELPER_2(xsrdpic, void, env, i32)
 DEF_HELPER_2(xsrdpim, void, env, i32)
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 4c3811a..5a2fd68 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -198,6 +198,7 @@ EXTRACT_HELPER(UIM, 16, 2);
 EXTRACT_HELPER(SHW, 8, 2);
 EXTRACT_HELPER(SP, 19, 2);
 EXTRACT_HELPER(IMM8, 11, 8);
+EXTRACT_HELPER(DCMX, 16, 7);
 EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
 
 typedef union _ppc_vsr_t {
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index adb6fc7..a44c003 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -850,6 +850,9 @@ GEN_VSX_HELPER_2(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
+GEN_VSX_HELPER_2(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xststdcdp, 0x14, 0x16, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xststdcqp, 0x04, 0x16, 0, PPC2_ISA300)
 
 GEN_VSX_HELPER_2(xvadddp, 0x00, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvsubdp, 0x00, 0x0D, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 6dd5d72..7dc9f6f 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -126,6 +126,10 @@ GEN_HANDLER_E(xsiexpdp, 0x3C, 0x16, 0x1C, 0, PPC_NONE, PPC2_ISA300),
 GEN_VSX_XFORM_300(xsiexpqp, 0x4, 0x1B, 0x00000001),
 #endif
 
+GEN_XX2FORM(xststdcdp, 0x14, 0x16, PPC2_ISA300),
+GEN_XX2FORM(xststdcsp, 0x14, 0x12, PPC2_ISA300),
+GEN_VSX_XFORM_300(xststdcqp, 0x04, 0x16, 0x00000001),
+
 GEN_XX3FORM(xviexpsp, 0x00, 0x1B, PPC2_ISA300),
 GEN_XX3FORM(xviexpdp, 0x00, 0x1F, PPC2_ISA300),
 GEN_XX2FORM_EO(xvxexpdp, 0x16, 0x1D, 0x00, PPC2_ISA300),
-- 
2.7.4
