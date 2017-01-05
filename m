Received: from eggs.gnu.org ([2001:4830:134:3::10]:42560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cP6C5-0000dR-19
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cP6C1-0006TY-3Q
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cP6C0-0006Sn-Pa
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:49 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v05BO3hZ016741
	for <qemu-devel@nongnu.org>; Thu, 5 Jan 2017 06:26:47 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27sk0kem3w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 06:26:47 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 5 Jan 2017 16:56:44 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  5 Jan 2017 16:56:16 +0530
In-Reply-To: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483615579-17618-12-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 11/14] target-ppc: Add xsxexpdp instruction
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

xsxexpdp: VSX Scalar Extract Exponent Dual Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target-ppc/translate/vsx-impl.inc.c | 13 +++++++++++++
 target-ppc/translate/vsx-ops.inc.c  |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
index d9cdaf1..b8ff31e 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -1216,6 +1216,19 @@ static void gen_##name(DisasContext *ctx)                       \
 VSX_EXTRACT_INSERT(xxextractuw)
 VSX_EXTRACT_INSERT(xxinsertw)
 
+#ifdef TARGET_PPC64
+static void gen_xsxexpdp(DisasContext *ctx)
+{
+    TCGv rt = cpu_gpr[rD(ctx->opcode)];
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    tcg_gen_shri_i64(rt, cpu_vsrh(xB(ctx->opcode)), 52);
+    tcg_gen_andi_i64(rt, rt, 0x7FF);
+}
+#endif
+
 #undef GEN_XX2FORM
 #undef GEN_XX3FORM
 #undef GEN_XX2IFORM
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vsx-ops.inc.c
index cc5b268..2243a1f 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -115,6 +115,10 @@ GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
 GEN_VSX_XFORM_300_EO(xscvdpqp, 0x04, 0x1A, 0x16, 0x00000001),
 GEN_VSX_XFORM_300_EO(xscvqpdp, 0x04, 0x1A, 0x14, 0x0),
 
+#ifdef TARGET_PPC64
+GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
+#endif
+
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),
 GEN_XX2FORM(xvnegdp, 0x12, 0x1F, PPC2_VSX),
-- 
2.7.4
