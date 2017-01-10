Received: from eggs.gnu.org ([2001:4830:134:3::10]:55660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs9W-0000vi-Gu
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs9T-0000vG-HE
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cQs9T-0000uu-6G
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:31 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0A8n8tE089567
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:30 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vus71fxt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:29 -0500
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 14:21:26 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 14:20:36 +0530
In-Reply-To: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1484038243-30314-5-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 04/11] target-ppc: Add xsiexpqp instruction
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

xsiexpqp: VSX Scalar Insert Exponent Quad Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate/vsx-impl.inc.c | 22 ++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 23 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 2d09225..ed392aa 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1263,6 +1263,28 @@ static void gen_xsiexpdp(DisasContext *ctx)
     tcg_temp_free_i64(t0);
 }
 
+static void gen_xsiexpqp(DisasContext *ctx)
+{
+    TCGv_i64 xth = cpu_vsrh(rD(ctx->opcode) + 32);
+    TCGv_i64 xtl = cpu_vsrl(rD(ctx->opcode) + 32);
+    TCGv_i64 xah = cpu_vsrh(rA(ctx->opcode) + 32);
+    TCGv_i64 xal = cpu_vsrl(rA(ctx->opcode) + 32);
+    TCGv_i64 xbh = cpu_vsrh(rB(ctx->opcode) + 32);
+    TCGv_i64 t0;
+
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    t0 = tcg_temp_new_i64();
+    tcg_gen_andi_i64(xth, xah, 0x8000FFFFFFFFFFFF);
+    tcg_gen_andi_i64(t0, xbh, 0x7FFF);
+    tcg_gen_shli_i64(t0, t0, 48);
+    tcg_gen_or_i64(xth, xth, t0);
+    tcg_gen_mov_i64(xtl, xal);
+    tcg_temp_free_i64(t0);
+}
+
 static void gen_xsxsigdp(DisasContext *ctx)
 {
     TCGv rt = cpu_gpr[rD(ctx->opcode)];
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 5980ac6..09b91c3 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -121,6 +121,7 @@ GEN_VSX_XFORM_300_EO(xsxexpqp, 0x04, 0x19, 0x02, 0x00000001),
 GEN_XX2FORM_EO(xsxsigdp, 0x16, 0x15, 0x01, PPC2_ISA300),
 GEN_VSX_XFORM_300_EO(xsxsigqp, 0x04, 0x19, 0x12, 0x00000001),
 GEN_HANDLER_E(xsiexpdp, 0x3C, 0x16, 0x1C, 0, PPC_NONE, PPC2_ISA300),
+GEN_VSX_XFORM_300(xsiexpqp, 0x4, 0x1B, 0x00000001),
 #endif
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
-- 
2.7.4
