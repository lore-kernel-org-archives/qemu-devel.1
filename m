Received: from eggs.gnu.org ([2001:4830:134:3::10]:43973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI57-0001Kx-7t
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI52-0007mk-VA
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:49:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:29927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI52-0007mI-MT
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:49:12 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Fri, 24 Aug 2018 15:44:03 -0400
Message-Id: <f1e92127959ffb3df713a06452328a71170bda93.1535133089.git.jancraig@amazon.com>
In-Reply-To: <cover.1535133088.git.jancraig@amazon.com>
References: <cover.1535133088.git.jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH 2/7] target/mips: Add MXU instructions S32I2M
 and S32M2I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

Adds support for emulating the S32I2M and S32M2I MXU instructions.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 target/mips/translate.c | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 50f0cb558f..381dfad36e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -364,6 +364,9 @@ enum {
     OPC_CLO      = 0x21 | OPC_SPECIAL2,
     OPC_DCLZ     = 0x24 | OPC_SPECIAL2,
     OPC_DCLO     = 0x25 | OPC_SPECIAL2,
+    /* MXU */
+    OPC_MXU_S32I2M = 0x2F | OPC_SPECIAL2,
+    OPC_MXU_S32M2I = 0x2E | OPC_SPECIAL2,
     /* Special */
     OPC_SDBBP    = 0x3F | OPC_SPECIAL2,
 };
@@ -3763,6 +3766,52 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
     }
 }
 
+typedef union {
+    struct {
+        uint32_t op:6;
+        uint32_t xra:5;
+        uint32_t:5;
+        uint32_t rb:5;
+        uint32_t:5;
+        uint32_t special2:6;
+    } S32I2M;
+
+    struct {
+        uint32_t op:6;
+        uint32_t xra:5;
+        uint32_t:5;
+        uint32_t rb:5;
+        uint32_t:5;
+        uint32_t special2:6;
+    } S32M2I;
+} MXU_OPCODE;
+
+/* MXU Instructions */
+static void gen_mxu(DisasContext *ctx, uint32_t opc)
+{
+#ifndef TARGET_MIPS64 /* Only works in 32 bit mode */
+    TCGv t0;
+    t0 = tcg_temp_new();
+    MXU_OPCODE *opcode = (MXU_OPCODE *)&ctx->opcode;
+
+    switch (opc) {
+    case OPC_MXU_S32I2M:
+        gen_load_gpr(t0, opcode->S32I2M.rb);
+        gen_store_mxu_gpr(t0, opcode->S32I2M.xra);
+        break;
+
+    case OPC_MXU_S32M2I:
+        gen_load_mxu_gpr(t0, opcode->S32M2I.xra);
+        gen_store_gpr(t0, opcode->S32M2I.rb);
+        break;
+    }
+
+    tcg_temp_free(t0);
+#else
+    generate_exception_end(ctx, EXCP_RI);
+#endif
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -17843,6 +17892,12 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         check_insn(ctx, INSN_LOONGSON2F);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
+
+    case OPC_MXU_S32I2M:
+    case OPC_MXU_S32M2I:
+        gen_mxu(ctx, op1);
+        break;
+
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS32);
-- 
2.18.0
