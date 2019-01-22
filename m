Received: from eggs.gnu.org ([209.51.188.92]:59398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glsVo-0006NI-Fb
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glsNU-0004jN-G7
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:29:54 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue, 22 Jan 2019 10:28:37 +0100
Message-Id: <20190122092909.5341-4-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
References: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 03/35] target/riscv: Convert RVXI branch
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
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode              | 19 ++++++++++
 target/riscv/insn_trans/trans_rvi.inc.c | 49 +++++++++++++++++++++++++
 target/riscv/translate.c                | 12 +-----
 3 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 44d4e922b6..81f56c16b4 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -17,14 +17,33 @@
 # this program.  If not, see <http://www.gnu.org/licenses/>.
 
 # Fields:
+%rs2       20:5
+%rs1       15:5
 %rd        7:5
 
 # immediates:
+%imm_i    20:s12
+%imm_b    31:s1 7:1 25:6 8:4     !function=ex_shift_1
+%imm_j    31:s1 12:8 20:1 21:10  !function=ex_shift_1
 %imm_u    12:s20                 !function=ex_shift_12
 
+# Argument sets:
+&b    imm rs2 rs1
+
 # Formats 32:
+@i       ............    ..... ... ..... .......         imm=%imm_i     %rs1 %rd
+@b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
 @u       ....................      ..... .......         imm=%imm_u          %rd
+@j       ....................      ..... .......         imm=%imm_j          %rd
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
 auipc    ....................       ..... 0010111 @u
+jal      ....................       ..... 1101111 @j
+jalr     ............     ..... 000 ..... 1100111 @i
+beq      ....... .....    ..... 000 ..... 1100011 @b
+bne      ....... .....    ..... 001 ..... 1100011 @b
+blt      ....... .....    ..... 100 ..... 1100011 @b
+bge      ....... .....    ..... 101 ..... 1100011 @b
+bltu     ....... .....    ..... 110 ..... 1100011 @b
+bgeu     ....... .....    ..... 111 ..... 1100011 @b
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 9885a8d275..0347461ee6 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -33,3 +33,52 @@ static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
     }
     return true;
 }
+
+static bool trans_jal(DisasContext *ctx, arg_jal *a)
+{
+    gen_jal(ctx->env, ctx, a->rd, a->imm);
+    return true;
+}
+
+static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
+{
+    gen_jalr(ctx->env, ctx, OPC_RISC_JALR, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_beq(DisasContext *ctx, arg_beq *a)
+{
+    gen_branch(ctx->env, ctx, OPC_RISC_BEQ, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_bne(DisasContext *ctx, arg_bne *a)
+{
+    gen_branch(ctx->env, ctx, OPC_RISC_BNE, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_blt(DisasContext *ctx, arg_blt *a)
+{
+    gen_branch(ctx->env, ctx, OPC_RISC_BLT, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_bge(DisasContext *ctx, arg_bge *a)
+{
+    gen_branch(ctx->env, ctx, OPC_RISC_BGE, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_bltu(DisasContext *ctx, arg_bltu *a)
+{
+    gen_branch(ctx->env, ctx, OPC_RISC_BLTU, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)
+{
+
+    gen_branch(ctx->env, ctx, OPC_RISC_BGEU, a->rs1, a->rs2, a->imm);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 99829a600d..b81297f23e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1682,6 +1682,7 @@ static void decode_RV32_64C(CPURISCVState *env, DisasContext *ctx)
     {                                         \
         return imm << amount;                 \
     }
+EX_SH(1)
 EX_SH(12)
 
 bool decode_insn32(DisasContext *ctx, uint32_t insn);
@@ -1710,17 +1711,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
     imm = GET_IMM(ctx->opcode);
 
     switch (op) {
-    case OPC_RISC_JAL:
-        imm = GET_JAL_IMM(ctx->opcode);
-        gen_jal(env, ctx, rd, imm);
-        break;
-    case OPC_RISC_JALR:
-        gen_jalr(env, ctx, MASK_OP_JALR(ctx->opcode), rd, rs1, imm);
-        break;
-    case OPC_RISC_BRANCH:
-        gen_branch(env, ctx, MASK_OP_BRANCH(ctx->opcode), rs1, rs2,
-                   GET_B_IMM(ctx->opcode));
-        break;
     case OPC_RISC_LOAD:
         gen_load(ctx, MASK_OP_LOAD(ctx->opcode), rd, rs1, imm);
         break;
-- 
2.20.1
