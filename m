Received: from eggs.gnu.org ([208.118.235.92]:59958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSss-00010D-4J
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSiE-0008T6-EM
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:34:42 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:63982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSiE-0008Sm-1q
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:34:38 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Thu, 30 Aug 2018 15:30:14 -0400
Message-Id: <20180830193019.20104-5-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-1-jancraig@amazon.com>
References: <20180830193019.20104-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v4 4/9] target/mips: Add MXU instructions
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
 v4
    - changed MXU register utility functions to take in unsigned argument
    - Created seperate utility functions for MXU_CR
    - Moved ins handling to mxu specific switch statement

 target/mips/translate.c | 83 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 53d896ebf9..41081ee066 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1619,6 +1619,34 @@ static inline void gen_store_gpr (TCGv t, int reg)
         tcg_gen_mov_tl(cpu_gpr[reg], t);
 }
 
+/* MXU General purpose registers moves. */
+static inline void gen_load_mxu_gpr(TCGv t, unsigned int reg)
+{
+    if (reg == 0) {
+        tcg_gen_movi_tl(t, 0);
+    } else if (reg <= 15) {
+        tcg_gen_mov_tl(t, mxu_gpr[reg - 1]);
+    }
+}
+
+static inline void gen_store_mxu_gpr(TCGv t, unsigned int reg)
+{
+    if (reg > 0 && reg <= 15) {
+        tcg_gen_mov_tl(mxu_gpr[reg - 1], t);
+    }
+}
+
+/* MXU control register moves. */
+static inline void gen_load_mxu_cr(TCGv t)
+{
+    tcg_gen_mov_tl(t, mxu_CR);
+}
+
+static inline void gen_store_mxu_cr(TCGv t)
+{
+    tcg_gen_mov_tl(mxu_CR, t);
+}
+
 /* Moves to/from shadow registers. */
 static inline void gen_load_srsgpr (int from, int to)
 {
@@ -3807,6 +3835,51 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
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
+    if (xra <= 15) {
+        gen_store_mxu_gpr(t0, xra);
+    } else if (xra == 16) {
+        gen_store_mxu_cr(t0);
+    }
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
+    if (xra <= 15) {
+        gen_load_mxu_gpr(t0, xra);
+    } else if (xra == 16) {
+        gen_load_mxu_cr(t0);
+    }
+
+    gen_store_gpr(t0, rb);
+
+    tcg_temp_free(t0);
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -17870,6 +17943,15 @@ static void decode_opc_special2_mxu(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MUL:
         gen_arith(ctx, op1, rd, rs, rt);
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
     default:            /* Invalid */
         MIPS_INVAL("special2_mxu");
         generate_exception_end(ctx, EXCP_RI);
@@ -17909,6 +17991,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         check_insn(ctx, INSN_LOONGSON2F);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
+
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS32);
-- 
2.18.0
