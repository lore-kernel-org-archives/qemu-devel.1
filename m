Received: from eggs.gnu.org ([2001:4830:134:3::10]:52621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEgup-0005FR-Sc
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguk-0001y7-Tg
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:26:03 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:49206
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cEguk-0001xj-Kg
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:58 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7INjIw013664
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 13:25:57 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276mpmjd5a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 13:25:57 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 23:55:54 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  7 Dec 2016 23:55:02 +0530
In-Reply-To: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1481135102-20011-10-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 9/9] target-ppc: Add xxperm and xxpermr
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

xxperm:  VSX Vector Permute
xxpermr: VSX Vector Permute Right-indexed

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target-ppc/fpu_helper.c             | 23 +++++++++++++++++++++++
 target-ppc/helper.h                 |  2 ++
 target-ppc/translate/vsx-impl.inc.c |  2 ++
 target-ppc/translate/vsx-ops.inc.c  |  2 ++
 4 files changed, 29 insertions(+)

diff --git a/target-ppc/fpu_helper.c b/target-ppc/fpu_helper.c
index 3b867cf..1ccd5e6 100644
--- a/target-ppc/fpu_helper.c
+++ b/target-ppc/fpu_helper.c
@@ -2869,3 +2869,26 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
     float_check_status(env);
     return xt;
 }
+
+#define VSX_XXPERM(op, indexed)                                       \
+void helper_##op(CPUPPCState *env, uint32_t opcode)                   \
+{                                                                     \
+    ppc_vsr_t xt, xa, pcv, xto;                                       \
+    int i, idx;                                                       \
+                                                                      \
+    getVSR(xA(opcode), &xa, env);                                     \
+    getVSR(xT(opcode), &xt, env);                                     \
+    getVSR(xB(opcode), &pcv, env);                                    \
+                                                                      \
+    for (i = 0; i < 16; i++) {                                        \
+        idx = pcv.VsrB(i) & 0x1F;                                     \
+        if (indexed) {                                                \
+            idx = 31 - idx;                                           \
+        }                                                             \
+        xto.VsrB(i) = (idx <= 15) ? xa.VsrB(idx) : xt.VsrB(idx - 16); \
+    }                                                                 \
+    putVSR(xT(opcode), &xto, env);                                    \
+}
+
+VSX_XXPERM(xxperm, 0)
+VSX_XXPERM(xxpermr, 1)
diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index 9f812c8..399cf99 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -538,6 +538,8 @@ DEF_HELPER_2(xvrspip, void, env, i32)
 DEF_HELPER_2(xvrspiz, void, env, i32)
 DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
 DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
+DEF_HELPER_2(xxperm, void, env, i32)
+DEF_HELPER_2(xxpermr, void, env, i32)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
 DEF_HELPER_2(efscfui, i32, env, i32)
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
index 8321134..1d88cee 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -913,6 +913,8 @@ GEN_VSX_HELPER_2(xvrspic, 0x16, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspim, 0x12, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspip, 0x12, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspiz, 0x12, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
+GEN_VSX_HELPER_2(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
 
 static void gen_xxbrd(DisasContext *ctx)
 {
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vsx-ops.inc.c
index 42e83d2..93fb9b8 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -275,6 +275,8 @@ VSX_LOGICAL(xxlnand, 0x8, 0x16, PPC2_VSX207),
 VSX_LOGICAL(xxlorc, 0x8, 0x15, PPC2_VSX207),
 GEN_XX3FORM(xxmrghw, 0x08, 0x02, PPC2_VSX),
 GEN_XX3FORM(xxmrglw, 0x08, 0x06, PPC2_VSX),
+GEN_XX3FORM(xxperm, 0x08, 0x03, PPC2_ISA300),
+GEN_XX3FORM(xxpermr, 0x08, 0x07, PPC2_ISA300),
 GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
 GEN_XX1FORM(xxspltib, 0x08, 0x0B, PPC2_ISA300),
 GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
-- 
2.7.4
