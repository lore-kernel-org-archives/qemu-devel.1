Received: from eggs.gnu.org ([2001:4830:134:3::10]:60220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5ZH-0007NJ-Mw
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5ZG-0000Ow-Oz
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59282
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cc5ZG-0000Oj-JS
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:30 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1A7In1f053302
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:30 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28h507fvve-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:29 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 10 Feb 2017 17:24:21 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 10 Feb 2017 12:53:09 +0530
In-Reply-To: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1486711391-12247-6-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 5/7] target-ppc: Add xscvqpudz and xscvqpuwz
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

xscvqpudz: VSX Scalar truncate & Convert Quad-Precision format to
           Unsigned Doubleword format
xscvqpuwz: VSX Scalar truncate & Convert Quad-Precision format to
           Unsigned Word format

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 2 ++
 target/ppc/helper.h                 | 2 ++
 target/ppc/translate/vsx-impl.inc.c | 2 ++
 target/ppc/translate/vsx-ops.inc.c  | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 96f9801..58aee64 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3086,6 +3086,8 @@ VSX_CVT_FP_TO_INT_VECTOR(xscvqpsdz, float128, int64, f128, VsrD(0),          \
 
 VSX_CVT_FP_TO_INT_VECTOR(xscvqpswz, float128, int32, f128, VsrD(0),          \
                   0xffffffff80000000ULL)
+VSX_CVT_FP_TO_INT_VECTOR(xscvqpudz, float128, uint64, f128, VsrD(0), 0x0ULL)
+VSX_CVT_FP_TO_INT_VECTOR(xscvqpuwz, float128, uint32, f128, VsrD(0), 0x0ULL)
 
 /* VSX_CVT_INT_TO_FP - VSX integer to floating point conversion
  *   op    - instruction mnemonic
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 007a837..6d77661 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -442,6 +442,8 @@ DEF_HELPER_2(xscvdpspn, i64, env, i64)
 DEF_HELPER_2(xscvqpdp, void, env, i32)
 DEF_HELPER_2(xscvqpsdz, void, env, i32)
 DEF_HELPER_2(xscvqpswz, void, env, i32)
+DEF_HELPER_2(xscvqpudz, void, env, i32)
+DEF_HELPER_2(xscvqpuwz, void, env, i32)
 DEF_HELPER_2(xscvhpdp, void, env, i32)
 DEF_HELPER_2(xscvsdqp, void, env, i32)
 DEF_HELPER_2(xscvspdp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 8de8cd0..7f12908 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -819,6 +819,8 @@ GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvqpdp, 0x04, 0x1A, 0x14, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpsdz, 0x04, 0x1A, 0x19, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvqpswz, 0x04, 0x1A, 0x09, PPC2_ISA300)
+GEN_VSX_HELPER_2(xscvqpudz, 0x04, 0x1A, 0x11, PPC2_ISA300)
+GEN_VSX_HELPER_2(xscvqpuwz, 0x04, 0x1A, 0x01, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvsdqp, 0x04, 0x1A, 0x0A, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index e20ca32..5030c4a 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -131,6 +131,8 @@ GEN_VSX_XFORM_300_EO(xscvdpqp, 0x04, 0x1A, 0x16, 0x00000001),
 GEN_VSX_XFORM_300_EO(xscvqpdp, 0x04, 0x1A, 0x14, 0x0),
 GEN_VSX_XFORM_300_EO(xscvqpsdz, 0x04, 0x1A, 0x19, 0x00000001),
 GEN_VSX_XFORM_300_EO(xscvqpswz, 0x04, 0x1A, 0x09, 0x00000001),
+GEN_VSX_XFORM_300_EO(xscvqpudz, 0x04, 0x1A, 0x11, 0x00000001),
+GEN_VSX_XFORM_300_EO(xscvqpuwz, 0x04, 0x1A, 0x01, 0x00000001),
 
 #ifdef TARGET_PPC64
 GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
-- 
2.7.4
