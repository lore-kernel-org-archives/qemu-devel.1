Received: from eggs.gnu.org ([2001:4830:134:3::10]:52427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kA-0007pE-Qt
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k5-0004BX-FC
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:16 +1100
Message-Id: <20170202051445.5735-79-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 078/107] target-ppc: Add xviexpdp instruction
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

xviexpdp: VSX Vector Insert Exponent Dual Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 26 ++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 27 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index c86f1b5..b66272e 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1370,6 +1370,32 @@ static void gen_xviexpsp(DisasContext *ctx)
     tcg_temp_free_i64(t0);
 }
 
+static void gen_xviexpdp(DisasContext *ctx)
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
+    tcg_gen_andi_i64(xth, xah, 0x800FFFFFFFFFFFFF);
+    tcg_gen_andi_i64(t0, xbh, 0x7FF);
+    tcg_gen_shli_i64(t0, t0, 52);
+    tcg_gen_or_i64(xth, xth, t0);
+    tcg_gen_andi_i64(xtl, xal, 0x800FFFFFFFFFFFFF);
+    tcg_gen_andi_i64(t0, xbl, 0x7FF);
+    tcg_gen_shli_i64(t0, t0, 52);
+    tcg_gen_or_i64(xtl, xtl, t0);
+    tcg_temp_free_i64(t0);
+}
+
 #undef GEN_XX2FORM
 #undef GEN_XX3FORM
 #undef GEN_XX2IFORM
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 93752f0..253a5c4 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -125,6 +125,7 @@ GEN_VSX_XFORM_300(xsiexpqp, 0x4, 0x1B, 0x00000001),
 #endif
 
 GEN_XX3FORM(xviexpsp, 0x00, 0x1B, PPC2_ISA300),
+GEN_XX3FORM(xviexpdp, 0x00, 0x1F, PPC2_ISA300),
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),
-- 
2.9.3
