Received: from eggs.gnu.org ([2001:4830:134:3::10]:42603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cP6C9-0000hK-1v
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cP6C5-0006VB-3r
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57752
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cP6C4-0006Ue-Tm
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:53 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v05BO1XX052672
	for <qemu-devel@nongnu.org>; Thu, 5 Jan 2017 06:26:52 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27skxvbwa6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 06:26:52 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 5 Jan 2017 16:56:48 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  5 Jan 2017 16:56:18 +0530
In-Reply-To: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483615579-17618-14-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 13/14] target-ppc: Add xsxsigdp instruction
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

xsxsigdp: VSX Scalar Extract Significand Dual Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target-ppc/translate/vsx-impl.inc.c | 29 +++++++++++++++++++++++++++++
 target-ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 30 insertions(+)

diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
index 514a273..1fea8dc 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -1242,6 +1242,35 @@ static void gen_xsxexpqp(DisasContext *ctx)
     tcg_gen_andi_i64(xth, xth, 0x7FFF);
     tcg_gen_movi_i64(xtl, 0);
 }
+
+static void gen_xsxsigdp(DisasContext *ctx)
+{
+    TCGv rt = cpu_gpr[rD(ctx->opcode)];
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
+    tcg_gen_shri_i64(exp, cpu_vsrh(xB(ctx->opcode)), 52);
+    tcg_gen_andi_i64(exp, exp, 0x7FF);
+    tcg_gen_movi_i64(t0, 0x0010000000000000);
+    tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
+    tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
+    tcg_gen_andi_i64(rt, cpu_vsrh(xB(ctx->opcode)), 0x000FFFFFFFFFFFFF);
+    tcg_gen_or_i64(rt, rt, t0);
+
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(exp);
+    tcg_temp_free_i64(zr);
+    tcg_temp_free_i64(nan);
+}
+
 #endif
 
 #undef GEN_XX2FORM
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vsx-ops.inc.c
index 2ea8ce4..c7791f8 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -118,6 +118,7 @@ GEN_VSX_XFORM_300_EO(xscvqpdp, 0x04, 0x1A, 0x14, 0x0),
 #ifdef TARGET_PPC64
 GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
 GEN_VSX_XFORM_300_EO(xsxexpqp, 0x04, 0x19, 0x02, 0x00000001),
+GEN_XX2FORM_EO(xsxsigdp, 0x16, 0x15, 0x01, PPC2_ISA300),
 #endif
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
-- 
2.7.4
