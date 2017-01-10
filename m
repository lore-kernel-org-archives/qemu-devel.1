Received: from eggs.gnu.org ([2001:4830:134:3::10]:55778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs9d-00019d-H3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs9b-0000yr-Cy
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cQs9b-0000y3-33
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0A8n8P5015738
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:38 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vvbxr8gm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:35 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 14:21:31 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 14:20:37 +0530
In-Reply-To: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1484038243-30314-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 05/11] target-ppc: Add xviexpsp instruction
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

xviexpsp: VSX Vector Insert Exponent Single Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate/vsx-impl.inc.c | 26 ++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index ed392aa..c86f1b5 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1344,6 +1344,32 @@ static void gen_xsxsigqp(DisasContext *ctx)
 }
 #endif
 
+static void gen_xviexpsp(DisasContext *ctx)
+{
+    TCGv_i64 xth = cpu_vsrh(xT(ctx->opcode));
+    TCGv_i64 xtl = cpu_vsrl(xT(ctx->opcode));
+    TCGv_i64 xah = cpu_vsrh(xA(ctx->opcode));
+    TCGv_i64 xal = cpu_vsrl(xA(ctx->opcode));
+    TCGv_i64 xbh = cpu_vsrh(xB(ctx->opcode));
+    TCGv_i64 xbl = cpu_vsrl(xB(ctx->opcode));
+    TCGv_i64 t0;
+
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    t0 = tcg_temp_new_i64();
+    tcg_gen_andi_i64(xth, xah, 0x807FFFFF807FFFFF);
+    tcg_gen_andi_i64(t0, xbh, 0xFF000000FF);
+    tcg_gen_shli_i64(t0, t0, 23);
+    tcg_gen_or_i64(xth, xth, t0);
+    tcg_gen_andi_i64(xtl, xal, 0x807FFFFF807FFFFF);
+    tcg_gen_andi_i64(t0, xbl, 0xFF000000FF);
+    tcg_gen_shli_i64(t0, t0, 23);
+    tcg_gen_or_i64(xtl, xtl, t0);
+    tcg_temp_free_i64(t0);
+}
+
 #undef GEN_XX2FORM
 #undef GEN_XX3FORM
 #undef GEN_XX2IFORM
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 09b91c3..93752f0 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -124,6 +124,8 @@ GEN_HANDLER_E(xsiexpdp, 0x3C, 0x16, 0x1C, 0, PPC_NONE, PPC2_ISA300),
 GEN_VSX_XFORM_300(xsiexpqp, 0x4, 0x1B, 0x00000001),
 #endif
 
+GEN_XX3FORM(xviexpsp, 0x00, 0x1B, PPC2_ISA300),
+
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),
 GEN_XX2FORM(xvnegdp, 0x12, 0x1F, PPC2_VSX),
-- 
2.7.4
