Received: from eggs.gnu.org ([2001:4830:134:3::10]:40817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTY-00021h-Ni
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTU-0004FF-4W
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:08 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:40660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDlTT-0004EI-SL
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:04 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Sat, 20 Oct 2018 09:14:28 +0200
Message-Id: <20181020071451.27808-7-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/29] target/riscv: Convert RVXI fence
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, richard.henderson@linaro.org, qemu-devel@nongnu.org

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
v1 -> v2:
    - simplified fence/fence_i as suggested by Richard

 target/riscv/insn32.decode              |  6 ++++++
 target/riscv/insn_trans/trans_rvi.inc.c | 20 ++++++++++++++++++++
 target/riscv/translate.c                | 14 --------------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cb7622e223..00e30dbc71 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -24,6 +24,9 @@
 %sh6    20:6
 %sh5    20:5
 
+%pred   24:4
+%succ   20:4
+
 # immediates:
 %imm_i    20:s12
 %imm_s    25:s7 7:5
@@ -36,6 +39,7 @@
 &shift     shamt rs1 rd
 
 # Formats 32:
+
 @r       .......   ..... ..... ... ..... .......                   %rs2 %rs1 %rd
 @i       ............    ..... ... ..... .......         imm=%imm_i     %rs1 %rd
 @b       .......   ..... ..... ... ..... ....... &branch imm=%imm_b %rs2 %rs1
@@ -84,6 +88,8 @@ srl      0000000 .....    ..... 101 ..... 0110011 @r
 sra      0100000 .....    ..... 101 ..... 0110011 @r
 or       0000000 .....    ..... 110 ..... 0110011 @r
 and      0000000 .....    ..... 111 ..... 0110011 @r
+fence    ---- pred:4 succ:4 ----- 000 ----- 0001111
+fence_i  ---- ----   ----   ----- 001 ----- 0001111
 
 # *** RV64I Base Instruction Set (in addition to RV32I) ***
 lwu      ............   ..... 110 ..... 0000011 @i
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index e5a67e64cb..14164a952d 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -341,3 +341,23 @@ static bool trans_sraw(DisasContext *ctx, arg_sraw *a, uint32_t insn)
     gen_arith(ctx, OPC_RISC_SRAW, a->rd, a->rs1, a->rs2);
     return true;
 }
+
+static bool trans_fence(DisasContext *ctx, arg_fence *a, uint32_t insn)
+{
+#ifndef CONFIG_USER_ONLY
+    /* FENCE is a full memory barrier. */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+#endif
+    return true;
+}
+static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a, uint32_t insn)
+{
+#ifndef CONFIG_USER_ONLY
+    /* FENCE_I is a no-op in QEMU,
+     * however we need to end the translation block */
+    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
+    tcg_gen_exit_tb(NULL, 0);
+    ctx->base.is_jmp = DISAS_NORETURN;
+#endif
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 3e296a2627..f2567117b9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1740,20 +1740,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
         gen_fp_arith(ctx, MASK_OP_FP_ARITH(ctx->opcode), rd, rs1, rs2,
                      GET_RM(ctx->opcode));
         break;
-    case OPC_RISC_FENCE:
-#ifndef CONFIG_USER_ONLY
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
-#endif
-        break;
     case OPC_RISC_SYSTEM:
         gen_system(env, ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
                    (ctx->opcode & 0xFFF00000) >> 20);
-- 
2.19.1
