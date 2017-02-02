Received: from eggs.gnu.org ([2001:4830:134:3::10]:52431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kA-0007pQ-T5
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k5-0004BQ-EX
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:13 +1100
Message-Id: <20170202051445.5735-76-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 075/107] target-ppc: Add xsiexpdp instruction
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

xsiexpdp: VSX Scalar Insert Exponent Double Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 20 ++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 21 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 2d9fe50..2d09225 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1243,6 +1243,26 @@ static void gen_xsxexpqp(DisasContext *ctx)
     tcg_gen_movi_i64(xtl, 0);
 }
 
+static void gen_xsiexpdp(DisasContext *ctx)
+{
+    TCGv_i64 xth = cpu_vsrh(xT(ctx->opcode));
+    TCGv ra = cpu_gpr[rA(ctx->opcode)];
+    TCGv rb = cpu_gpr[rB(ctx->opcode)];
+    TCGv_i64 t0;
+
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    t0 = tcg_temp_new_i64();
+    tcg_gen_andi_i64(xth, ra, 0x800FFFFFFFFFFFFF);
+    tcg_gen_andi_i64(t0, rb, 0x7FF);
+    tcg_gen_shli_i64(t0, t0, 52);
+    tcg_gen_or_i64(xth, xth, t0);
+    /* dword[1] is undefined */
+    tcg_temp_free_i64(t0);
+}
+
 static void gen_xsxsigdp(DisasContext *ctx)
 {
     TCGv rt = cpu_gpr[rD(ctx->opcode)];
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index aeeaff2..5980ac6 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -120,6 +120,7 @@ GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
 GEN_VSX_XFORM_300_EO(xsxexpqp, 0x04, 0x19, 0x02, 0x00000001),
 GEN_XX2FORM_EO(xsxsigdp, 0x16, 0x15, 0x01, PPC2_ISA300),
 GEN_VSX_XFORM_300_EO(xsxsigqp, 0x04, 0x19, 0x12, 0x00000001),
+GEN_HANDLER_E(xsiexpdp, 0x3C, 0x16, 0x1C, 0, PPC_NONE, PPC2_ISA300),
 #endif
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
-- 
2.9.3
