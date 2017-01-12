Received: from eggs.gnu.org ([2001:4830:134:3::10]:45220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRiBV-0005pe-KB
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRiBQ-000820-J2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:25:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42589
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cRiBQ-00081D-D3
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:25:00 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0CGJjkA076379
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:24:59 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27xag5frmy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:24:59 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 21:54:55 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 21:54:10 +0530
In-Reply-To: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1484238251-8096-7-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 6/7] target-ppc: Add xvtstdc[sp,
 dp] instructions
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

xvtstdcsp: VSX Vector Test Data Class Single-Precision
xvtstdcdp: VSX Vector Test Data Class Double-Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 50 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  2 ++
 target/ppc/internal.h               |  5 ++--
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  |  8 ++++++
 5 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index ffcf9ca..15af7e2 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3187,3 +3187,53 @@ void helper_xvxsigsp(CPUPPCState *env, uint32_t opcode)
     }
     putVSR(xT(opcode), &xt, env);
 }
+
+/* VSX_TEST_DC - VSX floating point test data class
+ *   op    - instruction mnemonic
+ *   nels  - number of elements (1, 2 or 4)
+ *   xbn   - VSR register number
+ *   tp    - type (float32 or float64)
+ *   fld   - vsr_t field (VsrD(*) or VsrW(*))
+ *   tfld   - target vsr_t field (VsrD(*) or VsrW(*))
+ *   fld_max - target field max
+ */
+#define VSX_TEST_DC(op, nels, xbn, tp, fld, tfld, fld_max)  \
+void helper_##op(CPUPPCState *env, uint32_t opcode)         \
+{                                                           \
+    ppc_vsr_t xt, xb;                                       \
+    uint32_t i, nan, infinity, dcmx, zero, denormal, sign;  \
+    uint32_t match = 0;                                     \
+                                                            \
+    getVSR(xbn, &xb, env);                                  \
+    memset(&xt, 0, sizeof(xt));                             \
+    dcmx = DCMX_XV(opcode);                                 \
+                                                            \
+    for (i = 0; i < nels; i++) {                            \
+        nan = tp##_is_any_nan(xb.fld);                      \
+        infinity = tp##_is_infinity(xb.fld);                \
+        sign = tp##_is_neg(xb.fld);                         \
+        zero = denormal = 0;                                \
+        if (tp##_is_zero_or_denormal(xb.fld)) {             \
+            if (tp##_is_zero(xb.fld)) {                     \
+                zero = 1;                                   \
+            } else {                                        \
+                denormal = 1;                               \
+            }                                               \
+        }                                                   \
+                                                            \
+        if ((extract32(dcmx, 6, 1) && nan) ||               \
+            (extract32(dcmx, 5, 1) && infinity && !sign) || \
+            (extract32(dcmx, 4, 1) && infinity &&  sign) || \
+            (extract32(dcmx, 3, 1) && zero     && !sign) || \
+            (extract32(dcmx, 3, 1) && zero     &&  sign) || \
+            (extract32(dcmx, 1, 1) && denormal && !sign) || \
+            (extract32(dcmx, 0, 1) && denormal &&  sign)) { \
+            match = 1;                                      \
+        }                                                   \
+        xt.tfld = match ? fld_max : 0;                      \
+    }                                                       \
+    putVSR(xT(opcode), &xt, env);                           \
+}
+
+VSX_TEST_DC(xvtstdcdp, 2, xB(opcode), float64, VsrD(i), VsrD(i), UINT64_MAX)
+VSX_TEST_DC(xvtstdcsp, 4, xB(opcode), float32, VsrW(i), VsrW(i), UINT32_MAX)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 14a12e0..2057560 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -546,6 +546,8 @@ DEF_HELPER_2(xvcvsxdsp, void, env, i32)
 DEF_HELPER_2(xvcvuxdsp, void, env, i32)
 DEF_HELPER_2(xvcvsxwsp, void, env, i32)
 DEF_HELPER_2(xvcvuxwsp, void, env, i32)
+DEF_HELPER_2(xvtstdcsp, void, env, i32)
+DEF_HELPER_2(xvtstdcdp, void, env, i32)
 DEF_HELPER_2(xvrspi, void, env, i32)
 DEF_HELPER_2(xvrspic, void, env, i32)
 DEF_HELPER_2(xvrspim, void, env, i32)
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index c22d74e..4c3811a 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -68,7 +68,7 @@ static inline uint32_t name(uint32_t opcode)                                  \
             ((opcode >> (shift2)) & ((1 << (nb2)) - 1));                      \
 }
 
-#define EXTRACT_HELPER_DXFORM(name,                                           \
+#define EXTRACT_HELPER_SPLIT_3(name,                                          \
                               d0_bits, shift_op_d0, shift_d0,                 \
                               d1_bits, shift_op_d1, shift_d1,                 \
                               d2_bits, shift_op_d2, shift_d2)                 \
@@ -156,7 +156,7 @@ EXTRACT_HELPER(FPFLM, 17, 8);
 EXTRACT_HELPER(FPW, 16, 1);
 
 /* addpcis */
-EXTRACT_HELPER_DXFORM(DX, 10, 6, 6, 5, 16, 1, 1, 0, 0)
+EXTRACT_HELPER_SPLIT_3(DX, 10, 6, 6, 5, 16, 1, 1, 0, 0)
 #if defined(TARGET_PPC64)
 /* darn */
 EXTRACT_HELPER(L, 16, 2);
@@ -198,6 +198,7 @@ EXTRACT_HELPER(UIM, 16, 2);
 EXTRACT_HELPER(SHW, 8, 2);
 EXTRACT_HELPER(SP, 19, 2);
 EXTRACT_HELPER(IMM8, 11, 8);
+EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
 
 typedef union _ppc_vsr_t {
     uint8_t u8[16];
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 9bcc5af..adb6fc7 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -928,6 +928,8 @@ GEN_VSX_HELPER_2(xvrspic, 0x16, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspim, 0x12, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspip, 0x12, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspiz, 0x12, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xvtstdcsp, 0x14, 0x1A, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xvtstdcdp, 0x14, 0x1E, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
 
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index ee74312..6dd5d72 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -133,6 +133,14 @@ GEN_XX2FORM_EO(xvxsigdp, 0x16, 0x1D, 0x01, PPC2_ISA300),
 GEN_XX2FORM_EO(xvxexpsp, 0x16, 0x1D, 0x08, PPC2_ISA300),
 GEN_XX2FORM_EO(xvxsigsp, 0x16, 0x1D, 0x09, PPC2_ISA300),
 
+/* DCMX  =  bit[25] << 6 | bit[29] << 5 | bit[11:15] */
+#define GEN_XX2FORM_DCMX(name, opc2, opc3, fl2) \
+GEN_XX3FORM(name, opc2, opc3 | 0, fl2),         \
+GEN_XX3FORM(name, opc2, opc3 | 1, fl2)
+
+GEN_XX2FORM_DCMX(xvtstdcdp, 0x14, 0x1E, PPC2_ISA300),
+GEN_XX2FORM_DCMX(xvtstdcsp, 0x14, 0x1A, PPC2_ISA300),
+
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),
 GEN_XX2FORM(xvnegdp, 0x12, 0x1F, PPC2_VSX),
-- 
2.7.4
