Received: from eggs.gnu.org ([209.51.188.92]:59186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwsL-0000yi-9j
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwsJ-0001GB-0s
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:04 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:39794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwsF-0000sp-Gk
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:00 -0500
Received: by mail-pf1-x429.google.com with SMTP id f132so1323486pfa.6
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:54:42 -0800 (PST)
Date: Wed, 13 Feb 2019 07:53:42 -0800
Message-Id: <20190213155414.22285-4-palmer@sifive.com>
In-Reply-To: <20190213155414.22285-1-palmer@sifive.com>
References: <20190213155414.22285-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH v7 03/35] target/riscv: Convert RVXI branch
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Acked-by: Alistair Francis <alistair.francis@wdc.com>
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
index 44d4e922b6fa..81f56c16b45f 100644
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
index 9885a8d27551..bcf20def50eb 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -33,3 +33,52 @@ static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
     }
     return true;
 }
+
+static bool trans_jal(DisasContext *ctx, arg_jal *a)
+{
+    gen_jal(ctx, a->rd, a->imm);
+    return true;
+}
+
+static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
+{
+    gen_jalr(ctx, OPC_RISC_JALR, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_beq(DisasContext *ctx, arg_beq *a)
+{
+    gen_branch(ctx, OPC_RISC_BEQ, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_bne(DisasContext *ctx, arg_bne *a)
+{
+    gen_branch(ctx, OPC_RISC_BNE, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_blt(DisasContext *ctx, arg_blt *a)
+{
+    gen_branch(ctx, OPC_RISC_BLT, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_bge(DisasContext *ctx, arg_bge *a)
+{
+    gen_branch(ctx, OPC_RISC_BGE, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_bltu(DisasContext *ctx, arg_bltu *a)
+{
+    gen_branch(ctx, OPC_RISC_BLTU, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)
+{
+
+    gen_branch(ctx, OPC_RISC_BGEU, a->rs1, a->rs2, a->imm);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 4076f28b3c8b..c5bcfd6b9756 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1880,6 +1880,7 @@ static void decode_RV32_64C(DisasContext *ctx)
     {                                         \
         return imm << amount;                 \
     }
+EX_SH(1)
 EX_SH(12)
 
 bool decode_insn32(DisasContext *ctx, uint32_t insn);
@@ -1908,17 +1909,6 @@ static void decode_RV32_64G(DisasContext *ctx)
     imm = GET_IMM(ctx->opcode);
 
     switch (op) {
-    case OPC_RISC_JAL:
-        imm = GET_JAL_IMM(ctx->opcode);
-        gen_jal(ctx, rd, imm);
-        break;
-    case OPC_RISC_JALR:
-        gen_jalr(ctx, MASK_OP_JALR(ctx->opcode), rd, rs1, imm);
-        break;
-    case OPC_RISC_BRANCH:
-        gen_branch(ctx, MASK_OP_BRANCH(ctx->opcode), rs1, rs2,
-                   GET_B_IMM(ctx->opcode));
-        break;
     case OPC_RISC_LOAD:
         gen_load(ctx, MASK_OP_LOAD(ctx->opcode), rd, rs1, imm);
         break;
-- 
2.18.1
