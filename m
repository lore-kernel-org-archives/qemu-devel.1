Received: from eggs.gnu.org ([2001:4830:134:3::10]:47028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkF-0003F7-NZ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkC-0006o0-5m
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:17 +1100
Message-Id: <20170112020327.24882-58-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 57/67] target-ppc: Add xsxexpqp instruction
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

xsxexpqp: VSX Scalar Extract Exponent Quad Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 15 +++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 16 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 33ca177..228e2a5 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1224,6 +1224,21 @@ static void gen_xsxexpdp(DisasContext *ctx)
     tcg_gen_shri_i64(rt, cpu_vsrh(xB(ctx->opcode)), 52);
     tcg_gen_andi_i64(rt, rt, 0x7FF);
 }
+
+static void gen_xsxexpqp(DisasContext *ctx)
+{
+    TCGv_i64 xth = cpu_vsrh(rD(ctx->opcode) + 32);
+    TCGv_i64 xtl = cpu_vsrl(rD(ctx->opcode) + 32);
+    TCGv_i64 xbh = cpu_vsrh(rB(ctx->opcode) + 32);
+
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    tcg_gen_shri_i64(xth, xbh, 48);
+    tcg_gen_andi_i64(xth, xth, 0x7FFF);
+    tcg_gen_movi_i64(xtl, 0);
+}
 #endif
 
 #undef GEN_XX2FORM
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 85d3b7d..87f1852 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -115,6 +115,7 @@ GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
 
 #ifdef TARGET_PPC64
 GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
+GEN_VSX_XFORM_300_EO(xsxexpqp, 0x04, 0x19, 0x02, 0x00000001),
 #endif
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
-- 
2.9.3
