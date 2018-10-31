Received: from eggs.gnu.org ([2001:4830:134:3::10]:36835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHqQd-0003zI-Ek
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHqQZ-0002BE-1W
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:20:59 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 31 Oct 2018 14:19:58 +0100
Message-Id: <20181031132029.4887-5-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/35] target/riscv: Convert RV32I
 load/store insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de, Alistair.Francis@wdc.com
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
v2 -> v3:
    - split into two patches for RV32 and RV64
    - dropped insn argument of trans_foo functions

 target/riscv/insn32.decode              | 10 ++++
 target/riscv/insn_trans/trans_rvi.inc.c | 64 +++++++++++++++++++++----
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 81f56c16b4..076de873c4 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -23,6 +23,7 @@
 
 # immediates:
 %imm_i    20:s12
+%imm_s    25:s7 7:5
 %imm_b    31:s1 7:1 25:6 8:4     !function=ex_shift_1
 %imm_j    31:s1 12:8 20:1 21:10  !function=ex_shift_1
 %imm_u    12:s20                 !function=ex_shift_12
@@ -33,6 +34,7 @@
 # Formats 32:
 @i       ............    ..... ... ..... .......         imm=%imm_i     %rs1 %rd
 @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
+@s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
 @u       ....................      ..... .......         imm=%imm_u          %rd
 @j       ....................      ..... .......         imm=%imm_j          %rd
 
@@ -47,3 +49,11 @@ blt      ....... .....    ..... 100 ..... 1100011 @b
 bge      ....... .....    ..... 101 ..... 1100011 @b
 bltu     ....... .....    ..... 110 ..... 1100011 @b
 bgeu     ....... .....    ..... 111 ..... 1100011 @b
+lb       ............     ..... 000 ..... 0000011 @i
+lh       ............     ..... 001 ..... 0000011 @i
+lw       ............     ..... 010 ..... 0000011 @i
+lbu      ............     ..... 100 ..... 0000011 @i
+lhu      ............     ..... 101 ..... 0000011 @i
+sb       .......  .....   ..... 000 ..... 0100011 @s
+sh       .......  .....   ..... 001 ..... 0100011 @s
+sw       .......  .....   ..... 010 ..... 0100011 @s
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index eaeab20282..f3b88ebb69 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -34,51 +34,99 @@ static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
     return true;
 }
 
-static bool trans_jal(DisasContext *ctx, arg_jal *a, uint32_t insn)
+static bool trans_jal(DisasContext *ctx, arg_jal *a)
 {
     gen_jal(ctx->env, ctx, a->rd, a->imm);
     return true;
 }
 
-static bool trans_jalr(DisasContext *ctx, arg_jalr *a, uint32_t insn)
+static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
 {
     gen_jalr(ctx->env, ctx, OPC_RISC_JALR, a->rd, a->rs1, a->imm);
     return true;
 }
 
-static bool trans_beq(DisasContext *ctx, arg_beq *a, uint32_t insn)
+static bool trans_beq(DisasContext *ctx, arg_beq *a)
 {
     gen_branch(ctx->env, ctx, OPC_RISC_BEQ, a->rs1, a->rs2, a->imm);
     return true;
 }
 
-static bool trans_bne(DisasContext *ctx, arg_bne *a, uint32_t insn)
+static bool trans_bne(DisasContext *ctx, arg_bne *a)
 {
     gen_branch(ctx->env, ctx, OPC_RISC_BNE, a->rs1, a->rs2, a->imm);
     return true;
 }
 
-static bool trans_blt(DisasContext *ctx, arg_blt *a, uint32_t insn)
+static bool trans_blt(DisasContext *ctx, arg_blt *a)
 {
     gen_branch(ctx->env, ctx, OPC_RISC_BLT, a->rs1, a->rs2, a->imm);
     return true;
 }
 
-static bool trans_bge(DisasContext *ctx, arg_bge *a, uint32_t insn)
+static bool trans_bge(DisasContext *ctx, arg_bge *a)
 {
     gen_branch(ctx->env, ctx, OPC_RISC_BGE, a->rs1, a->rs2, a->imm);
     return true;
 }
 
-static bool trans_bltu(DisasContext *ctx, arg_bltu *a, uint32_t insn)
+static bool trans_bltu(DisasContext *ctx, arg_bltu *a)
 {
     gen_branch(ctx->env, ctx, OPC_RISC_BLTU, a->rs1, a->rs2, a->imm);
     return true;
 }
 
-static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a, uint32_t insn)
+static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)
 {
 
     gen_branch(ctx->env, ctx, OPC_RISC_BGEU, a->rs1, a->rs2, a->imm);
     return true;
 }
+
+static bool trans_lb(DisasContext *ctx, arg_lb *a)
+{
+    gen_load(ctx, OPC_RISC_LB, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lh(DisasContext *ctx, arg_lh *a)
+{
+    gen_load(ctx, OPC_RISC_LH, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lw(DisasContext *ctx, arg_lw *a)
+{
+    gen_load(ctx, OPC_RISC_LW, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
+{
+    gen_load(ctx, OPC_RISC_LBU, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
+{
+    gen_load(ctx, OPC_RISC_LHU, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_sb(DisasContext *ctx, arg_sb *a)
+{
+    gen_store(ctx, OPC_RISC_SB, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_sh(DisasContext *ctx, arg_sh *a)
+{
+    gen_store(ctx, OPC_RISC_SH, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_sw(DisasContext *ctx, arg_sw *a)
+{
+    gen_store(ctx, OPC_RISC_SW, a->rs1, a->rs2, a->imm);
+    return true;
+}
-- 
2.19.1
