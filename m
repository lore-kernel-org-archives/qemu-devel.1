Received: from eggs.gnu.org ([2001:4830:134:3::10]:52589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNpT-00083H-Ll
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNpQ-00037K-H5
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:16:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36837
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cPNpQ-00037G-BE
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:16:40 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v066DvbW016047
	for <qemu-devel@nongnu.org>; Fri, 6 Jan 2017 01:16:40 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27skxwmdjf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 01:16:39 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Jan 2017 16:16:36 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  6 Jan 2017 11:44:56 +0530
In-Reply-To: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483683296-32568-15-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 14/14] target-ppc: Add xsxsigqp instructions
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

xsxsigqp: VSX Scalar Extract Significand Quad Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate/vsx-impl.inc.c | 29 +++++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 30 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 1fea8dc..2d9fe50 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1271,6 +1271,35 @@ static void gen_xsxsigdp(DisasContext *ctx)
     tcg_temp_free_i64(nan);
 }
 
+static void gen_xsxsigqp(DisasContext *ctx)
+{
+    TCGv_i64 t0, zr, nan, exp;
+    TCGv_i64 xth = cpu_vsrh(rD(ctx->opcode) + 32);
+    TCGv_i64 xtl = cpu_vsrl(rD(ctx->opcode) + 32);
+
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    exp = tcg_temp_new_i64();
+    t0 = tcg_temp_new_i64();
+    zr = tcg_const_i64(0);
+    nan = tcg_const_i64(32767);
+
+    tcg_gen_shri_i64(exp, cpu_vsrh(rB(ctx->opcode) + 32), 48);
+    tcg_gen_andi_i64(exp, exp, 0x7FFF);
+    tcg_gen_movi_i64(t0, 0x0001000000000000);
+    tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
+    tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
+    tcg_gen_andi_i64(xth, cpu_vsrh(rB(ctx->opcode) + 32), 0x0000FFFFFFFFFFFF);
+    tcg_gen_or_i64(xth, xth, t0);
+    tcg_gen_mov_i64(xtl, cpu_vsrl(rB(ctx->opcode) + 32));
+
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(exp);
+    tcg_temp_free_i64(zr);
+    tcg_temp_free_i64(nan);
+}
 #endif
 
 #undef GEN_XX2FORM
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index c7791f8..aeeaff2 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -119,6 +119,7 @@ GEN_VSX_XFORM_300_EO(xscvqpdp, 0x04, 0x1A, 0x14, 0x0),
 GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
 GEN_VSX_XFORM_300_EO(xsxexpqp, 0x04, 0x19, 0x02, 0x00000001),
 GEN_XX2FORM_EO(xsxsigdp, 0x16, 0x15, 0x01, PPC2_ISA300),
+GEN_VSX_XFORM_300_EO(xsxsigqp, 0x04, 0x19, 0x12, 0x00000001),
 #endif
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
-- 
2.7.4
