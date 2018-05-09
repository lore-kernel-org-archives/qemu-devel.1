Received: from eggs.gnu.org ([2001:4830:134:3::10]:36110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGLaw-0007rN-7H
	for qemu-devel@nongnu.org; Wed, 09 May 2018 05:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGLas-0003iP-EK
	for qemu-devel@nongnu.org; Wed, 09 May 2018 05:41:10 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:44655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fGLas-0003fo-6H
	for qemu-devel@nongnu.org; Wed, 09 May 2018 05:41:06 -0400
Received: by mail-pg0-x243.google.com with SMTP id x145-v6so2162391pgx.11
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 02:41:05 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  9 May 2018 21:39:28 +1200
Message-Id: <1525858768-325-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1] RISC-V: Add misa to DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, "Emilio G . Cota" <cota@braap.org>

gen methods should access state from DisasContext. Add misa
field to the DisasContext struct and remove CPURISCVState
argument from all gen methods.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Emilio G. Cota <cota@braap.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/translate.c | 74 ++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index c0e6a044d383..5b9e5fe343d2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -44,6 +44,7 @@ typedef struct DisasContext {
     target_ulong next_pc;
     uint32_t opcode;
     uint32_t flags;
+    uint32_t misa;
     uint32_t mem_idx;
     int singlestep_enabled;
     int bstate;
@@ -82,6 +83,11 @@ static const int tcg_memop_lookup[8] = {
 #define CASE_OP_32_64(X) case X
 #endif
 
+static inline bool has_ext(DisasContext *ctx, uint32_t ext)
+{
+    return ctx->misa & ext;
+}
+
 static void generate_exception(DisasContext *ctx, int excp)
 {
     tcg_gen_movi_tl(cpu_pc, ctx->pc);
@@ -513,14 +519,13 @@ static void gen_arith_imm(DisasContext *ctx, uint32_t opc, int rd,
     tcg_temp_free(source1);
 }
 
-static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
-                    target_ulong imm)
+static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     target_ulong next_pc;
 
     /* check misaligned: */
     next_pc = ctx->pc + imm;
-    if (!riscv_has_ext(env, RVC)) {
+    if (!has_ext(ctx, RVC)) {
         if ((next_pc & 0x3) != 0) {
             gen_exception_inst_addr_mis(ctx);
             return;
@@ -534,8 +539,8 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
     ctx->bstate = BS_BRANCH;
 }
 
-static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
-                     int rd, int rs1, target_long imm)
+static void gen_jalr(DisasContext *ctx, uint32_t opc, int rd, int rs1,
+                     target_long imm)
 {
     /* no chaining with JALR */
     TCGLabel *misaligned = NULL;
@@ -547,7 +552,7 @@ static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         tcg_gen_addi_tl(cpu_pc, cpu_pc, imm);
         tcg_gen_andi_tl(cpu_pc, cpu_pc, (target_ulong)-2);
 
-        if (!riscv_has_ext(env, RVC)) {
+        if (!has_ext(ctx, RVC)) {
             misaligned = gen_new_label();
             tcg_gen_andi_tl(t0, cpu_pc, 0x2);
             tcg_gen_brcondi_tl(TCG_COND_NE, t0, 0x0, misaligned);
@@ -572,8 +577,8 @@ static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t0);
 }
 
-static void gen_branch(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
-                       int rs1, int rs2, target_long bimm)
+static void gen_branch(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
+                       target_long bimm)
 {
     TCGLabel *l = gen_new_label();
     TCGv source1, source2;
@@ -610,7 +615,7 @@ static void gen_branch(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
 
     gen_goto_tb(ctx, 1, ctx->next_pc);
     gen_set_label(l); /* branch taken */
-    if (!riscv_has_ext(env, RVC) && ((ctx->pc + bimm) & 0x3)) {
+    if (!has_ext(ctx, RVC) && ((ctx->pc + bimm) & 0x3)) {
         /* misaligned */
         gen_exception_inst_addr_mis(ctx);
     } else {
@@ -1313,8 +1318,8 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
     }
 }
 
-static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
-                      int rd, int rs1, int csr)
+static void gen_system(DisasContext *ctx, uint32_t opc, int rd, int rs1,
+                       int csr)
 {
     TCGv source1, csr_store, dest, rs1_pass, imm_rs1;
     source1 = tcg_temp_new();
@@ -1356,7 +1361,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             gen_exception_illegal(ctx);
             break;
         case 0x102: /* SRET */
-            if (riscv_has_ext(env, RVS)) {
+            if (has_ext(ctx, RVS)) {
                 gen_helper_sret(cpu_pc, cpu_env, cpu_pc);
                 tcg_gen_exit_tb(0); /* no chaining */
                 ctx->bstate = BS_BRANCH;
@@ -1497,7 +1502,7 @@ static void decode_RV32_64C0(DisasContext *ctx)
     }
 }
 
-static void decode_RV32_64C1(CPURISCVState *env, DisasContext *ctx)
+static void decode_RV32_64C1(DisasContext *ctx)
 {
     uint8_t funct3 = extract32(ctx->opcode, 13, 3);
     uint8_t rd_rs1 = GET_C_RS1(ctx->opcode);
@@ -1517,7 +1522,7 @@ static void decode_RV32_64C1(CPURISCVState *env, DisasContext *ctx)
                       GET_C_IMM(ctx->opcode));
 #else
         /* C.JAL(RV32) -> jal x1, offset[11:1] */
-        gen_jal(env, ctx, 1, GET_C_J_IMM(ctx->opcode));
+        gen_jal(ctx, 1, GET_C_J_IMM(ctx->opcode));
 #endif
         break;
     case 2:
@@ -1596,22 +1601,22 @@ static void decode_RV32_64C1(CPURISCVState *env, DisasContext *ctx)
         break;
     case 5:
         /* C.J -> jal x0, offset[11:1]*/
-        gen_jal(env, ctx, 0, GET_C_J_IMM(ctx->opcode));
+        gen_jal(ctx, 0, GET_C_J_IMM(ctx->opcode));
         break;
     case 6:
         /* C.BEQZ -> beq rs1', x0, offset[8:1]*/
         rs1s = GET_C_RS1S(ctx->opcode);
-        gen_branch(env, ctx, OPC_RISC_BEQ, rs1s, 0, GET_C_B_IMM(ctx->opcode));
+        gen_branch(ctx, OPC_RISC_BEQ, rs1s, 0, GET_C_B_IMM(ctx->opcode));
         break;
     case 7:
         /* C.BNEZ -> bne rs1', x0, offset[8:1]*/
         rs1s = GET_C_RS1S(ctx->opcode);
-        gen_branch(env, ctx, OPC_RISC_BNE, rs1s, 0, GET_C_B_IMM(ctx->opcode));
+        gen_branch(ctx, OPC_RISC_BNE, rs1s, 0, GET_C_B_IMM(ctx->opcode));
         break;
     }
 }
 
-static void decode_RV32_64C2(CPURISCVState *env, DisasContext *ctx)
+static void decode_RV32_64C2(DisasContext *ctx)
 {
     uint8_t rd, rs2;
     uint8_t funct3 = extract32(ctx->opcode, 13, 3);
@@ -1645,7 +1650,7 @@ static void decode_RV32_64C2(CPURISCVState *env, DisasContext *ctx)
         if (extract32(ctx->opcode, 12, 1) == 0) {
             if (rs2 == 0) {
                 /* C.JR -> jalr x0, rs1, 0*/
-                gen_jalr(env, ctx, OPC_RISC_JALR, 0, rd, 0);
+                gen_jalr(ctx, OPC_RISC_JALR, 0, rd, 0);
             } else {
                 /* C.MV -> add rd, x0, rs2 */
                 gen_arith(ctx, OPC_RISC_ADD, rd, 0, rs2);
@@ -1653,11 +1658,11 @@ static void decode_RV32_64C2(CPURISCVState *env, DisasContext *ctx)
         } else {
             if (rd == 0) {
                 /* C.EBREAK -> ebreak*/
-                gen_system(env, ctx, OPC_RISC_ECALL, 0, 0, 0x1);
+                gen_system(ctx, OPC_RISC_ECALL, 0, 0, 0x1);
             } else {
                 if (rs2 == 0) {
                     /* C.JALR -> jalr x1, rs1, 0*/
-                    gen_jalr(env, ctx, OPC_RISC_JALR, 1, rd, 0);
+                    gen_jalr(ctx, OPC_RISC_JALR, 1, rd, 0);
                 } else {
                     /* C.ADD -> add rd, rd, rs2 */
                     gen_arith(ctx, OPC_RISC_ADD, rd, rd, rs2);
@@ -1689,7 +1694,7 @@ static void decode_RV32_64C2(CPURISCVState *env, DisasContext *ctx)
     }
 }
 
-static void decode_RV32_64C(CPURISCVState *env, DisasContext *ctx)
+static void decode_RV32_64C(DisasContext *ctx)
 {
     uint8_t op = extract32(ctx->opcode, 0, 2);
 
@@ -1698,15 +1703,15 @@ static void decode_RV32_64C(CPURISCVState *env, DisasContext *ctx)
         decode_RV32_64C0(ctx);
         break;
     case 1:
-        decode_RV32_64C1(env, ctx);
+        decode_RV32_64C1(ctx);
         break;
     case 2:
-        decode_RV32_64C2(env, ctx);
+        decode_RV32_64C2(ctx);
         break;
     }
 }
 
-static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
+static void decode_RV32_64G(DisasContext *ctx)
 {
     int rs1;
     int rs2;
@@ -1741,13 +1746,13 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
         break;
     case OPC_RISC_JAL:
         imm = GET_JAL_IMM(ctx->opcode);
-        gen_jal(env, ctx, rd, imm);
+        gen_jal(ctx, rd, imm);
         break;
     case OPC_RISC_JALR:
-        gen_jalr(env, ctx, MASK_OP_JALR(ctx->opcode), rd, rs1, imm);
+        gen_jalr(ctx, MASK_OP_JALR(ctx->opcode), rd, rs1, imm);
         break;
     case OPC_RISC_BRANCH:
-        gen_branch(env, ctx, MASK_OP_BRANCH(ctx->opcode), rs1, rs2,
+        gen_branch(ctx, MASK_OP_BRANCH(ctx->opcode), rs1, rs2,
                    GET_B_IMM(ctx->opcode));
         break;
     case OPC_RISC_LOAD:
@@ -1820,7 +1825,7 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
 #endif
         break;
     case OPC_RISC_SYSTEM:
-        gen_system(env, ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
+        gen_system(ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
                    (ctx->opcode & 0xFFF00000) >> 20);
         break;
     default:
@@ -1829,19 +1834,19 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
     }
 }
 
-static void decode_opc(CPURISCVState *env, DisasContext *ctx)
+static void decode_opc(DisasContext *ctx)
 {
     /* check for compressed insn */
     if (extract32(ctx->opcode, 0, 2) != 3) {
-        if (!riscv_has_ext(env, RVC)) {
+        if (!has_ext(ctx, RVC)) {
             gen_exception_illegal(ctx);
         } else {
             ctx->next_pc = ctx->pc + 2;
-            decode_RV32_64C(env, ctx);
+            decode_RV32_64C(ctx);
         }
     } else {
         ctx->next_pc = ctx->pc + 4;
-        decode_RV32_64G(env, ctx);
+        decode_RV32_64G(ctx);
     }
 }
 
@@ -1865,6 +1870,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     ctx.bstate = BS_NONE;
     ctx.flags = tb->flags;
     ctx.mem_idx = tb->flags & TB_FLAGS_MMU_MASK;
+    ctx.misa = env->misa;
     ctx.frm = -1;  /* unknown rounding mode */
 
     num_insns = 0;
@@ -1898,7 +1904,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         }
 
         ctx.opcode = cpu_ldl_code(env, ctx.pc);
-        decode_opc(env, &ctx);
+        decode_opc(&ctx);
         ctx.pc = ctx.next_pc;
 
         if (cs->singlestep_enabled) {
-- 
2.7.0
