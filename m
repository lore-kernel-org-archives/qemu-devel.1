Received: from eggs.gnu.org ([2001:4830:134:3::10]:47107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkH-0003GY-5x
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkE-0006pi-7n
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:19 +1100
Message-Id: <20170112020327.24882-60-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 59/67] target-ppc: Add xsxsigqp instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

xsxsigqp: VSX Scalar Extract Significand Quad Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 29 +++++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 30 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index c6f2208..33e934f 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1268,6 +1268,35 @@ static void gen_xsxsigdp(DisasContext *ctx)
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
index 1fd5285..bfcd09e 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -117,6 +117,7 @@ GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
 GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
 GEN_VSX_XFORM_300_EO(xsxexpqp, 0x04, 0x19, 0x02, 0x00000001),
 GEN_XX2FORM_EO(xsxsigdp, 0x16, 0x15, 0x01, PPC2_ISA300),
+GEN_VSX_XFORM_300_EO(xsxsigqp, 0x04, 0x19, 0x12, 0x00000001),
 #endif
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
-- 
2.9.3
