Received: from eggs.gnu.org ([2001:4830:134:3::10]:55332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1caga9-0003Je-A7
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1caga5-0007gC-JG
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1caga5-0007fx-9w
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:33 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v16ASjqO108770
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 05:31:32 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28en0mxhdd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 05:31:32 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 6 Feb 2017 20:31:29 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon,  6 Feb 2017 16:00:00 +0530
In-Reply-To: <1486377000-25701-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486377000-25701-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486377000-25701-5-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/4] target-ppc: Add xsmaxjdp and xsminjdp
 instructions
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

xsmaxjdp: VSX Scalar Maximum Type-J Double-Precision
xsminjdp: VSX Scalar Minimum Type-J Double-Precision

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 55 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  |  2 ++
 4 files changed, 61 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 9d2688e..1b6cd3b 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2717,6 +2717,61 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
 VSX_MAX_MINC(xsmaxcdp, 1);
 VSX_MAX_MINC(xsmincdp, 0);
 
+#define VSX_MAX_MINJ(name, max)                                               \
+void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
+{                                                                             \
+    ppc_vsr_t xt, xa, xb;                                                     \
+    bool vxsnan_flag = false, vex_flag = false;                               \
+                                                                              \
+    getVSR(rA(opcode) + 32, &xa, env);                                        \
+    getVSR(rB(opcode) + 32, &xb, env);                                        \
+    getVSR(rD(opcode) + 32, &xt, env);                                        \
+                                                                              \
+    if (unlikely(float64_is_any_nan(xa.VsrD(0)))) {                           \
+        if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status)) {          \
+            vxsnan_flag = true;                                               \
+        }                                                                     \
+        xt.VsrD(0) = xa.VsrD(0);                                              \
+    } else if (unlikely(float64_is_any_nan(xb.VsrD(0)))) {                    \
+        if (float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {          \
+            vxsnan_flag = true;                                               \
+        }                                                                     \
+        xt.VsrD(0) = xb.VsrD(0);                                              \
+    } else if (float64_is_zero(xa.VsrD(0)) && float64_is_zero(xb.VsrD(0))) {  \
+        if (max) {                                                            \
+            if (!float64_is_neg(xa.VsrD(0)) || !float64_is_neg(xb.VsrD(0))) { \
+                xt.VsrD(0) = 0ULL;                                            \
+            } else {                                                          \
+                xt.VsrD(0) = 0x8000000000000000ULL;                           \
+            }                                                                 \
+        } else {                                                              \
+            if (float64_is_neg(xa.VsrD(0)) || float64_is_neg(xb.VsrD(0))) {   \
+                xt.VsrD(0) = 0x8000000000000000ULL;                           \
+            } else {                                                          \
+                xt.VsrD(0) = 0ULL;                                            \
+            }                                                                 \
+        }                                                                     \
+    } else if ((max &&                                                        \
+               !float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) ||       \
+               (!max &&                                                       \
+               float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status))) {        \
+        xt.VsrD(0) = xa.VsrD(0);                                              \
+    } else {                                                                  \
+        xt.VsrD(0) = xb.VsrD(0);                                              \
+    }                                                                         \
+                                                                              \
+    vex_flag = fpscr_ve & vxsnan_flag;                                        \
+    if (vxsnan_flag) {                                                        \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);            \
+    }                                                                         \
+    if (!vex_flag) {                                                          \
+        putVSR(rD(opcode) + 32, &xt, env);                                    \
+    }                                                                         \
+}                                                                             \
+
+VSX_MAX_MINJ(xsmaxjdp, 1);
+VSX_MAX_MINJ(xsminjdp, 0);
+
 /* VSX_CMP - VSX floating point compare
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index fe3267e..cc81709 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -433,6 +433,8 @@ DEF_HELPER_2(xsmaxdp, void, env, i32)
 DEF_HELPER_2(xsmindp, void, env, i32)
 DEF_HELPER_2(xsmaxcdp, void, env, i32)
 DEF_HELPER_2(xsmincdp, void, env, i32)
+DEF_HELPER_2(xsmaxjdp, void, env, i32)
+DEF_HELPER_2(xsminjdp, void, env, i32)
 DEF_HELPER_2(xscvdphp, void, env, i32)
 DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 3251dca..8de8cd0 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -810,6 +810,8 @@ GEN_VSX_HELPER_2(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmaxcdp, 0x00, 0x10, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsmincdp, 0x00, 0x11, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xsmaxjdp, 0x00, 0x12, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xsminjdp, 0x00, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 16a135f..c1b71ad 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -202,6 +202,8 @@ GEN_XX3FORM(xsmaxdp, 0x00, 0x14, PPC2_VSX),
 GEN_XX3FORM(xsmindp, 0x00, 0x15, PPC2_VSX),
 GEN_XX3FORM(xsmaxcdp, 0x00, 0x10, PPC2_ISA300),
 GEN_XX3FORM(xsmincdp, 0x00, 0x11, PPC2_ISA300),
+GEN_XX3FORM(xsmaxjdp, 0x00, 0x12, PPC2_ISA300),
+GEN_XX3FORM(xsminjdp, 0x00, 0x13, PPC2_ISA300),
 GEN_XX2FORM_EO(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300),
 GEN_XX2FORM(xscvdpsp, 0x12, 0x10, PPC2_VSX),
 GEN_XX2FORM(xscvdpspn, 0x16, 0x10, PPC2_VSX207),
-- 
2.7.4
