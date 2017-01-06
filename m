Received: from eggs.gnu.org ([2001:4830:134:3::10]:52418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNp2-0007J0-16
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNoy-00031w-St
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:16:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cPNoy-00031k-JT
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:16:12 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v066FwUZ089534
	for <qemu-devel@nongnu.org>; Fri, 6 Jan 2017 01:16:11 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27sydqdhkx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 01:16:11 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Jan 2017 16:16:09 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  6 Jan 2017 11:44:51 +0530
In-Reply-To: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483683296-32568-10-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 09/14] target-ppc: Add xscvdpqp instruction
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

xscvdpqp: VSX Scalar Convert Double-Precision format to
          Quad-Precision format

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 10 ++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 13 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 05b2926..224876b 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -22,6 +22,15 @@
 #include "exec/exec-all.h"
 #include "internal.h"
 
+static inline float128 float128_snan_to_qnan(float128 x)
+{
+    float128 r;
+
+    r.high = x.high | 0x0000800000000000;
+    r.low = x.low;
+    return r;
+}
+
 #define float64_snan_to_qnan(x) ((x) | 0x0008000000000000ULL)
 #define float32_snan_to_qnan(x) ((x) | 0x00400000)
 #define float16_snan_to_qnan(x) ((x) | 0x0200)
@@ -2701,6 +2710,7 @@ VSX_CVT_FP_TO_FP(xscvdpsp, 1, float64, float32, VsrD(0), VsrW(0), 1)
 VSX_CVT_FP_TO_FP(xscvspdp, 1, float32, float64, VsrW(0), VsrD(0), 1)
 VSX_CVT_FP_TO_FP(xvcvdpsp, 2, float64, float32, VsrD(i), VsrW(2*i), 0)
 VSX_CVT_FP_TO_FP(xvcvspdp, 2, float32, float64, VsrW(2*i), VsrD(i), 0)
+VSX_CVT_FP_TO_FP(xscvdpqp, 1, float64, float128, VsrD(0), f128, 1)
 
 /* VSX_CVT_FP_TO_FP_HP - VSX floating point/floating point conversion
  *                       involving one half precision value
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 889fe55..3b5d0ad 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -430,6 +430,7 @@ DEF_HELPER_2(xscmpuqp, void, env, i32)
 DEF_HELPER_2(xsmaxdp, void, env, i32)
 DEF_HELPER_2(xsmindp, void, env, i32)
 DEF_HELPER_2(xscvdphp, void, env, i32)
+DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
 DEF_HELPER_2(xscvhpdp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 16242f2..358ff4c 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -808,6 +808,7 @@ GEN_VSX_HELPER_2(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 0704d7a..fcf9597 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -112,6 +112,7 @@ GEN_VSX_XFORM_300_EO(xsabsqp, 0x04, 0x19, 0x00, 0x00000001),
 GEN_VSX_XFORM_300_EO(xsnabsqp, 0x04, 0x19, 0x08, 0x00000001),
 GEN_VSX_XFORM_300_EO(xsnegqp, 0x04, 0x19, 0x10, 0x00000001),
 GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
+GEN_VSX_XFORM_300_EO(xscvdpqp, 0x04, 0x1A, 0x16, 0x00000001),
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),
-- 
2.7.4
