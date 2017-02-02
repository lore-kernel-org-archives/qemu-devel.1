Received: from eggs.gnu.org ([2001:4830:134:3::10]:52699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kG-0007wq-JC
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k9-0004GU-4k
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:44 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:20 +1100
Message-Id: <20170202051445.5735-83-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 082/107] target-ppc: Add xvxsigdp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

xvxsigdp: VSX Vector Extract Significand Dual Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.9.3
