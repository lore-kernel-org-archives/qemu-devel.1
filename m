Received: from eggs.gnu.org ([2001:4830:134:3::10]:52532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kD-0007ss-B0
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k6-0004Df-MB
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:41 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:17 +1100
Message-Id: <20170202051445.5735-80-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 079/107] target-ppc: Add xvxexpsp instruction
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

xvxexpsp: VSX Vector Extract Exponent Single Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 17 +++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 18 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index b66272e..160a80c 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1396,6 +1396,23 @@ static void gen_xviexpdp(DisasContext *ctx)
     tcg_temp_free_i64(t0);
 }
 
+static void gen_xvxexpsp(DisasContext *ctx)
+{
+    TCGv_i64 xth = cpu_vsrh(xT(ctx->opcode));
+    TCGv_i64 xtl = cpu_vsrl(xT(ctx->opcode));
+    TCGv_i64 xbh = cpu_vsrh(xB(ctx->opcode));
+    TCGv_i64 xbl = cpu_vsrl(xB(ctx->opcode));
+
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    tcg_gen_shri_i64(xth, xbh, 23);
+    tcg_gen_andi_i64(xth, xth, 0xFF000000FF);
+    tcg_gen_shri_i64(xtl, xbl, 23);
+    tcg_gen_andi_i64(xtl, xtl, 0xFF000000FF);
+}
+
 #undef GEN_XX2FORM
 #undef GEN_XX3FORM
 #undef GEN_XX2IFORM
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 253a5c4..eb7334a 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -126,6 +126,7 @@ GEN_VSX_XFORM_300(xsiexpqp, 0x4, 0x1B, 0x00000001),
 
 GEN_XX3FORM(xviexpsp, 0x00, 0x1B, PPC2_ISA300),
 GEN_XX3FORM(xviexpdp, 0x00, 0x1F, PPC2_ISA300),
+GEN_XX2FORM_EO(xvxexpsp, 0x16, 0x1D, 0x08, PPC2_ISA300),
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),
-- 
2.9.3
