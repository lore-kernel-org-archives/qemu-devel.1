Received: from eggs.gnu.org ([2001:4830:134:3::10]:50701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudcY-0002kZ-Bw
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudc5-0000aR-E4
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:00:59 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:46415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudc5-0000YH-93
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:00:53 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 09:00:36 -0400
Message-Id: <20180828130041.26445-4-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-1-jancraig@amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v3 3/8] target/mips: Add MXU instructions
 S32I2M and S32M2I
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

This commit makes the MXU registers and the utility functions for
reading/writing to them. This is required for full MXU instruction
support.

Adds support for emulating the S32I2M and S32M2I MXU instructions.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - initial patch
 v2
    - Fix checkpatch.pl errors
    - remove mips64 ifdef
    - changed bitfield usage to extract32
    - squashed register addition patch into this one
 v3
    - Split register addition and opcode enum definition into seperate patches
    - Split gen_mxu function into command specific gen_mxu_<ins> functions

 target/mips/translate.c | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ae6b16ecd7..f6991aa8ef 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1610,6 +1610,23 @@ static inline void gen_store_gpr (TCGv t, int reg)
         tcg_gen_mov_tl(cpu_gpr[reg], t);
 }
 
+/* MXU General purpose registers moves. */
+static inline void gen_load_mxu_gpr(TCGv t, int reg)
+{
+    if (reg == 0) {
+        tcg_gen_movi_tl(t, 0);
+    } else {
+        tcg_gen_mov_tl(t, mxu_gpr[reg - 1]);
+    }
+}
+
+static inline void gen_store_mxu_gpr(TCGv t, int reg)
+{
+    if (reg != 0) {
+        tcg_gen_mov_tl(mxu_gpr[reg - 1], t);
+    }
+}
+
 /* Moves to/from shadow registers. */
 static inline void gen_load_srsgpr (int from, int to)
 {
@@ -3798,6 +3815,42 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
     }
 }
 
+/* MXU Instructions */
+
+/* S32I2M XRa, rb - Register move from GRF to XRF */
+static void gen_mxu_s32i2m(DisasContext *ctx, uint32_t opc)
+{
+    TCGv t0;
+    uint32_t xra, rb;
+
+    t0 = tcg_temp_new();
+
+    xra = extract32(ctx->opcode, 6, 5);
+    rb = extract32(ctx->opcode, 16, 5);
+
+    gen_load_gpr(t0, rb);
+    gen_store_mxu_gpr(t0, xra);
+
+    tcg_temp_free(t0);
+}
+
+/* S32M2I XRa, rb - Register move from XRF to GRF */
+static void gen_mxu_s32m2i(DisasContext *ctx, uint32_t opc)
+{
+    TCGv t0;
+    uint32_t xra, rb;
+
+    t0 = tcg_temp_new();
+
+    xra = extract32(ctx->opcode, 6, 5);
+    rb = extract32(ctx->opcode, 16, 5);
+
+    gen_load_mxu_gpr(t0, xra);
+    gen_store_gpr(t0, rb);
+
+    tcg_temp_free(t0);
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -17894,6 +17947,15 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         check_insn(ctx, INSN_LOONGSON2F);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
+
+    case OPC_MXU_S32I2M:
+        gen_mxu_s32i2m(ctx, op1);
+        break;
+
+    case OPC_MXU_S32M2I:
+        gen_mxu_s32m2i(ctx, op1);
+        break;
+
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS32);
-- 
2.18.0
