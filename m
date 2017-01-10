Received: from eggs.gnu.org ([2001:4830:134:3::10]:55840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs9j-0001L6-Jr
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs9g-00012Y-Vp
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cQs9g-00011y-Mg
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0A8nBiU088841
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:43 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vv7agk7h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:43 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 14:21:39 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 14:20:42 +0530
In-Reply-To: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1484038243-30314-11-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 10/11] target-ppc: Add xvxsigdp instruction
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

xvxsigdp: VSX Vector Extract Significand Dual Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate/vsx-impl.inc.c | 40 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 41 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 4e57af7..7e068a4 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1432,6 +1432,46 @@ static void gen_xvxexpdp(DisasContext *ctx)
 
 GEN_VSX_HELPER_2(xvxsigsp, 0x00, 0x04, 0, PPC2_ISA300)
 
+static void gen_xvxsigdp(DisasContext *ctx)
+{
+    TCGv_i64 xth = cpu_vsrh(xT(ctx->opcode));
+    TCGv_i64 xtl = cpu_vsrl(xT(ctx->opcode));
+    TCGv_i64 xbh = cpu_vsrh(xB(ctx->opcode));
+    TCGv_i64 xbl = cpu_vsrl(xB(ctx->opcode));
+
+    TCGv_i64 t0, zr, nan, exp;
+
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    exp = tcg_temp_new_i64();
+    t0 = tcg_temp_new_i64();
+    zr = tcg_const_i64(0);
+    nan = tcg_const_i64(2047);
+
+    tcg_gen_shri_i64(exp, xbh, 52);
+    tcg_gen_andi_i64(exp, exp, 0x7FF);
+    tcg_gen_movi_i64(t0, 0x0010000000000000);
+    tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
+    tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
+    tcg_gen_andi_i64(xth, xbh, 0x000FFFFFFFFFFFFF);
+    tcg_gen_or_i64(xth, xth, t0);
+
+    tcg_gen_shri_i64(exp, xbl, 52);
+    tcg_gen_andi_i64(exp, exp, 0x7FF);
+    tcg_gen_movi_i64(t0, 0x0010000000000000);
+    tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
+    tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
+    tcg_gen_andi_i64(xtl, xbl, 0x000FFFFFFFFFFFFF);
+    tcg_gen_or_i64(xtl, xtl, t0);
+
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(exp);
+    tcg_temp_free_i64(zr);
+    tcg_temp_free_i64(nan);
+}
+
 #undef GEN_XX2FORM
 #undef GEN_XX3FORM
 #undef GEN_XX2IFORM
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 2c4f641..367fd38 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -127,6 +127,7 @@ GEN_VSX_XFORM_300(xsiexpqp, 0x4, 0x1B, 0x00000001),
 GEN_XX3FORM(xviexpsp, 0x00, 0x1B, PPC2_ISA300),
 GEN_XX3FORM(xviexpdp, 0x00, 0x1F, PPC2_ISA300),
 GEN_XX2FORM_EO(xvxexpdp, 0x16, 0x1D, 0x00, PPC2_ISA300),
+GEN_XX2FORM_EO(xvxsigdp, 0x16, 0x1D, 0x01, PPC2_ISA300),
 GEN_XX2FORM_EO(xvxexpsp, 0x16, 0x1D, 0x08, PPC2_ISA300),
 GEN_XX2FORM_EO(xvxsigsp, 0x16, 0x1D, 0x09, PPC2_ISA300),
 
-- 
2.7.4
