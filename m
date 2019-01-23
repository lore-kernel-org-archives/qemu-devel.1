Received: from eggs.gnu.org ([209.51.188.92]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gmEno-0008Uo-QW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gmEnm-0007Kg-Us
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:26:32 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 23 Jan 2019 10:25:10 +0100
Message-Id: <20190123092538.8004-8-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
References: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 07/35] target/riscv: Convert RVXI fence
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, richard.henderson@linaro.org, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode              |  2 ++
 target/riscv/insn_trans/trans_rvi.inc.c | 19 +++++++++++++++++++
 target/riscv/translate.c                | 12 ------------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1f5bf1f6f9..804b721ca5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -82,3 +82,5 @@ srl      0000000 .....    ..... 101 ..... 0110011 @r
 sra      0100000 .....    ..... 101 ..... 0110011 @r
 or       0000000 .....    ..... 110 ..... 0110011 @r
 and      0000000 .....    ..... 111 ..... 0110011 @r
+fence    ---- pred:4 succ:4 ----- 000 ----- 0001111
+fence_i  ---- ----   ----   ----- 001 ----- 0001111
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 01f751650a..b468a0ac0e 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -318,3 +318,22 @@ static bool trans_sraw(DisasContext *ctx, arg_sraw *a)
     return true;
 }
 #endif
+
+static bool trans_fence(DisasContext *ctx, arg_fence *a)
+{
+    /* FENCE is a full memory barrier. */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+    return true;
+}
+
+static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
+{
+    /*
+     * FENCE_I is a no-op in QEMU,
+     * however we need to end the translation block
+     */
+    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
+    tcg_gen_exit_tb(NULL, 0);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index c16eba8ec8..9899f10be4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1750,18 +1750,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
         gen_fp_arith(ctx, MASK_OP_FP_ARITH(ctx->opcode), rd, rs1, rs2,
                      GET_RM(ctx->opcode));
         break;
-    case OPC_RISC_FENCE:
-        if (ctx->opcode & 0x1000) {
-            /* FENCE_I is a no-op in QEMU,
-             * however we need to end the translation block */
-            tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
-            tcg_gen_exit_tb(NULL, 0);
-            ctx->base.is_jmp = DISAS_NORETURN;
-        } else {
-            /* FENCE is a full memory barrier. */
-            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-        }
-        break;
     case OPC_RISC_SYSTEM:
         gen_system(env, ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
                    (ctx->opcode & 0xFFF00000) >> 20);
-- 
2.20.1
