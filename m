Received: from eggs.gnu.org ([2001:4830:134:3::10]:42545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cP6C4-0000cq-Hx
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cP6C0-0006T5-JQ
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52636
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cP6C0-0006Sr-Cq
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:48 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v05BOE8U097840
	for <qemu-devel@nongnu.org>; Thu, 5 Jan 2017 06:26:48 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27sg8kpd65-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 06:26:47 -0500
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 5 Jan 2017 16:56:44 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  5 Jan 2017 16:56:17 +0530
In-Reply-To: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483615579-17618-13-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 12/14] target-ppc: Add xsxexpqp instruction
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

xsxexpqp: VSX Scalar Extract Exponent Quad Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target-ppc/translate/vsx-impl.inc.c | 15 +++++++++++++++
 target-ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 16 insertions(+)

diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
index b8ff31e..514a273 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -1227,6 +1227,21 @@ static void gen_xsxexpdp(DisasContext *ctx)
     tcg_gen_shri_i64(rt, cpu_vsrh(xB(ctx->opcode)), 52);
     tcg_gen_andi_i64(rt, rt, 0x7FF);
 }
+
+static void gen_xsxexpqp(DisasContext *ctx)
+{
+    TCGv_i64 xth = cpu_vsrh(rD(ctx->opcode) + 32);
+    TCGv_i64 xtl = cpu_vsrl(rD(ctx->opcode) + 32);
+    TCGv_i64 xbh = cpu_vsrh(rB(ctx->opcode) + 32);
+
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    tcg_gen_shri_i64(xth, xbh, 48);
+    tcg_gen_andi_i64(xth, xth, 0x7FFF);
+    tcg_gen_movi_i64(xtl, 0);
+}
 #endif
 
 #undef GEN_XX2FORM
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vsx-ops.inc.c
index 2243a1f..2ea8ce4 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -117,6 +117,7 @@ GEN_VSX_XFORM_300_EO(xscvqpdp, 0x04, 0x1A, 0x14, 0x0),
 
 #ifdef TARGET_PPC64
 GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
+GEN_VSX_XFORM_300_EO(xsxexpqp, 0x04, 0x19, 0x02, 0x00000001),
 #endif
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
-- 
2.7.4
