Received: from eggs.gnu.org ([2001:4830:134:3::10]:39679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1HO-0001cy-WA
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1HL-0008QJ-89
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:14 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:55268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1HK-0008P7-QW
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:11 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:23 +0200
Message-Id: <20181012173047.25420-5-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/28] target/riscv: Convert RVXI arithmetic
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Cc: qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com

we cannot remove the call to gen_arith() in decode_RV32_64G() since it
is used to translate multiply instructions.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode              |  36 ++++
 target/riscv/insn_trans/trans_rvi.inc.c | 221 ++++++++++++++++++++++++
 target/riscv/translate.c                |   9 -
 3 files changed, 257 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index badd1d9216..cb7622e223 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -21,6 +21,9 @@
 %rs1       15:5
 %rd        7:5
 
+%sh6    20:6
+%sh5    20:5
+
 # immediates:
 %imm_i    20:s12
 %imm_s    25:s7 7:5
@@ -30,14 +33,19 @@
 
 # Argument sets:
 &branch    imm rs2 rs1
+&shift     shamt rs1 rd
 
 # Formats 32:
+@r       .......   ..... ..... ... ..... .......                   %rs2 %rs1 %rd
 @i       ............    ..... ... ..... .......         imm=%imm_i     %rs1 %rd
 @b       .......   ..... ..... ... ..... ....... &branch imm=%imm_b %rs2 %rs1
 @s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
 @u       ....................      ..... .......         imm=%imm_u          %rd
 @j       ....................      ..... .......         imm=%imm_j          %rd
 
+@sh6     ......  ...... .....  ... ..... ....... &shift  shamt=%sh6      %rs1 %rd
+@sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
+
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
 auipc    ....................       ..... 0010111 @u
@@ -57,8 +65,36 @@ lhu      ............     ..... 101 ..... 0000011 @i
 sb       .......  .....   ..... 000 ..... 0100011 @s
 sh       .......  .....   ..... 001 ..... 0100011 @s
 sw       .......  .....   ..... 010 ..... 0100011 @s
+addi     ............     ..... 000 ..... 0010011 @i
+slti     ............     ..... 010 ..... 0010011 @i
+sltiu    ............     ..... 011 ..... 0010011 @i
+xori     ............     ..... 100 ..... 0010011 @i
+ori      ............     ..... 110 ..... 0010011 @i
+andi     ............     ..... 111 ..... 0010011 @i
+slli     000000 ......    ..... 001 ..... 0010011 @sh6
+srli     000000 ......    ..... 101 ..... 0010011 @sh6
+srai     010000 ......    ..... 101 ..... 0010011 @sh6
+add      0000000 .....    ..... 000 ..... 0110011 @r
+sub      0100000 .....    ..... 000 ..... 0110011 @r
+sll      0000000 .....    ..... 001 ..... 0110011 @r
+slt      0000000 .....    ..... 010 ..... 0110011 @r
+sltu     0000000 .....    ..... 011 ..... 0110011 @r
+xor      0000000 .....    ..... 100 ..... 0110011 @r
+srl      0000000 .....    ..... 101 ..... 0110011 @r
+sra      0100000 .....    ..... 101 ..... 0110011 @r
+or       0000000 .....    ..... 110 ..... 0110011 @r
+and      0000000 .....    ..... 111 ..... 0110011 @r
 
 # *** RV64I Base Instruction Set (in addition to RV32I) ***
 lwu      ............   ..... 110 ..... 0000011 @i
 ld       ............   ..... 011 ..... 0000011 @i
 sd       ....... .....  ..... 011 ..... 0100011 @s
+addiw    ............   ..... 000 ..... 0011011 @i
+slliw    0000000 .....  ..... 001 ..... 0011011 @sh5
+srliw    0000000 .....  ..... 101 ..... 0011011 @sh5
+sraiw    0100000 .....  ..... 101 ..... 0011011 @sh5
+addw     0000000 .....  ..... 000 ..... 0111011 @r
+subw     0100000 .....  ..... 000 ..... 0111011 @r
+sllw     0000000 .....  ..... 001 ..... 0111011 @r
+srlw     0000000 .....  ..... 101 ..... 0111011 @r
+sraw     0100000 .....  ..... 101 ..... 0111011 @r
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 5803518fdc..2b017cf4a4 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -156,3 +156,224 @@ static bool trans_sd(DisasContext *ctx, arg_sd *a, uint32_t insn)
     return false;
 #endif
 }
+
+static bool trans_addi(DisasContext *ctx, arg_addi *a, uint32_t insn)
+{
+    gen_arith_imm(ctx, OPC_RISC_ADDI, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_slti(DisasContext *ctx, arg_slti *a, uint32_t insn)
+{
+    gen_arith_imm(ctx, OPC_RISC_SLTI, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_sltiu(DisasContext *ctx, arg_sltiu *a, uint32_t insn)
+{
+    gen_arith_imm(ctx, OPC_RISC_SLTIU, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_xori(DisasContext *ctx, arg_xori *a, uint32_t insn)
+{
+    gen_arith_imm(ctx, OPC_RISC_XORI, a->rd, a->rs1, a->imm);
+    return true;
+}
+static bool trans_ori(DisasContext *ctx, arg_ori *a, uint32_t insn)
+{
+    gen_arith_imm(ctx, OPC_RISC_ORI, a->rd, a->rs1, a->imm);
+    return true;
+}
+static bool trans_andi(DisasContext *ctx, arg_andi *a, uint32_t insn)
+{
+    gen_arith_imm(ctx, OPC_RISC_ANDI, a->rd, a->rs1, a->imm);
+    return true;
+}
+static bool trans_slli(DisasContext *ctx, arg_slli *a, uint32_t insn)
+{
+    if (a->rd != 0) {
+        TCGv t = tcg_temp_new();
+        gen_get_gpr(t, a->rs1);
+
+        if (a->shamt >= TARGET_LONG_BITS) {
+            gen_exception_illegal(ctx);
+            return true;
+        }
+        tcg_gen_shli_tl(t, t, a->shamt);
+
+        gen_set_gpr(a->rd, t);
+        tcg_temp_free(t);
+    } /* NOP otherwise */
+    return true;
+}
+
+static bool trans_srli(DisasContext *ctx, arg_srli *a, uint32_t insn)
+{
+    if (a->rd != 0) {
+        TCGv t = tcg_temp_new();
+        gen_get_gpr(t, a->rs1);
+        tcg_gen_extract_tl(t, t, a->shamt, 64 - a->shamt);
+        gen_set_gpr(a->rd, t);
+        tcg_temp_free(t);
+    } /* NOP otherwise */
+    return true;
+}
+
+static bool trans_srai(DisasContext *ctx, arg_srai *a, uint32_t insn)
+{
+    if (a->rd != 0) {
+        TCGv t = tcg_temp_new();
+        gen_get_gpr(t, a->rs1);
+        tcg_gen_sextract_tl(t, t, a->shamt, 64 - a->shamt);
+        gen_set_gpr(a->rd, t);
+        tcg_temp_free(t);
+    } /* NOP otherwise */
+    return true;
+}
+
+static bool trans_add(DisasContext *ctx, arg_add *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_ADD, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_sub(DisasContext *ctx, arg_sub *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_SUB, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_sll(DisasContext *ctx, arg_sll *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_SLL, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_slt(DisasContext *ctx, arg_slt *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_SLT, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_sltu(DisasContext *ctx, arg_sltu *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_SLTU, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_xor(DisasContext *ctx, arg_xor *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_XOR, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_srl(DisasContext *ctx, arg_srl *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_SRL, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_sra(DisasContext *ctx, arg_sra *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_SRA, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_or(DisasContext *ctx, arg_or *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_OR, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_and(DisasContext *ctx, arg_and *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_AND, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_addiw(DisasContext *ctx, arg_addiw *a, uint32_t insn)
+{
+    gen_arith_imm(ctx, OPC_RISC_ADDIW, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_slliw(DisasContext *ctx, arg_slliw *a, uint32_t insn)
+{
+    gen_arith_imm(ctx, OPC_RISC_SLLIW, a->rd, a->rs1, a->shamt);
+    return true;
+}
+
+static bool trans_srliw(DisasContext *ctx, arg_srliw *a, uint32_t insn)
+{
+    TCGv t = tcg_temp_new();
+    gen_get_gpr(t, a->rs1);
+    tcg_gen_extract_tl(t, t, a->shamt, 32 - a->shamt);
+    /* sign-extend for W instructions */
+    tcg_gen_ext32s_tl(t, t);
+    gen_set_gpr(a->rd, t);
+    tcg_temp_free(t);
+    return true;
+}
+
+static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a, uint32_t insn)
+{
+    TCGv t = tcg_temp_new();
+    gen_get_gpr(t, a->rs1);
+    tcg_gen_sextract_tl(t, t, a->shamt, 32 - a->shamt);
+    /* sign-extend for W instructions */
+    tcg_gen_ext32s_tl(t, t);
+    gen_set_gpr(a->rd, t);
+    tcg_temp_free(t);
+    return true;
+}
+
+static bool trans_addw(DisasContext *ctx, arg_addw *a, uint32_t insn)
+{
+#if !defined(TARGET_RISCV64)
+    gen_exception_illegal(ctx);
+    return true;
+#endif
+    gen_arith(ctx, OPC_RISC_ADDW, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_subw(DisasContext *ctx, arg_subw *a, uint32_t insn)
+{
+#if !defined(TARGET_RISCV64)
+    gen_exception_illegal(ctx);
+    return true;
+#endif
+    gen_arith(ctx, OPC_RISC_SUBW, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_sllw(DisasContext *ctx, arg_sllw *a, uint32_t insn)
+{
+#if !defined(TARGET_RISCV64)
+    gen_exception_illegal(ctx);
+    return true;
+#endif
+    gen_arith(ctx, OPC_RISC_SLLW, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_srlw(DisasContext *ctx, arg_srlw *a, uint32_t insn)
+{
+#if !defined(TARGET_RISCV64)
+    gen_exception_illegal(ctx);
+    return true;
+#endif
+    gen_arith(ctx, OPC_RISC_SRLW, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_sraw(DisasContext *ctx, arg_sraw *a, uint32_t insn)
+{
+#if !defined(TARGET_RISCV64)
+    gen_exception_illegal(ctx);
+    return true;
+#endif
+    gen_arith(ctx, OPC_RISC_SRAW, a->rd, a->rs1, a->rs2);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 517a2cda17..96169c4935 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1700,15 +1700,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
     imm = GET_IMM(ctx->opcode);
 
     switch (op) {
-    case OPC_RISC_ARITH_IMM:
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_ARITH_IMM_W:
-#endif
-        if (rd == 0) {
-            break; /* NOP */
-        }
-        gen_arith_imm(ctx, MASK_OP_ARITH_IMM(ctx->opcode), rd, rs1, imm);
-        break;
     case OPC_RISC_ARITH:
 #if defined(TARGET_RISCV64)
     case OPC_RISC_ARITH_W:
-- 
2.19.1
