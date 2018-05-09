Received: from eggs.gnu.org ([2001:4830:134:3::10]:43408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGM6R-0003mA-9v
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGM6P-0007NW-B1
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:43 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:34801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fGM6P-0007Lc-24
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:41 -0400
Received: by mail-pl0-x242.google.com with SMTP id ay10-v6so4018542plb.1
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 03:13:41 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  9 May 2018 22:11:53 +1200
Message-Id: <1525860713-3476-7-git-send-email-mjc@sifive.com>
In-Reply-To: <1525860713-3476-1-git-send-email-mjc@sifive.com>
References: <1525860713-3476-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 6/6] target/riscv: add misa to DisasContext
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

[Rebased against github.com/cota/qemu/tree/trloop-conv-v3]

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Emilio G. Cota <cota@braap.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/translate.c | 77 ++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1788668c6f28..507d74186293 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -45,6 +45,7 @@ typedef struct DisasContext {
     target_ulong pc_succ_insn;
     uint32_t opcode;
     uint32_t flags;
+    uint32_t misa;
     uint32_t mem_idx;
     /* Remember the rounding mode encoded in the previous fp instruction,
        which we have already installed into env->fp_status.  Or -1 for
@@ -74,6 +75,11 @@ static const int tcg_memop_lookup[8] = {
 #define CASE_OP_32_64(X) case X
 #endif
 
+static inline bool has_ext(DisasContext *ctx, uint32_t ext)
+{
+    return ctx->misa & ext;
+}
+
 static void generate_exception(DisasContext *ctx, int excp)
 {
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
@@ -505,14 +511,13 @@ static void gen_arith_imm(DisasContext *ctx, uint32_t opc, int rd,
     tcg_temp_free(source1);
 }
 
-static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
-                    target_ulong imm)
+static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     target_ulong next_pc;
 
     /* check misaligned: */
     next_pc = ctx->base.pc_next + imm;
-    if (!riscv_has_ext(env, RVC)) {
+    if (!has_ext(ctx, RVC)) {
         if ((next_pc & 0x3) != 0) {
             gen_exception_inst_addr_mis(ctx);
             return;
@@ -526,8 +531,8 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
-                     int rd, int rs1, target_long imm)
+static void gen_jalr(DisasContext *ctx, uint32_t opc, int rd, int rs1,
+                     target_long imm)
 {
     /* no chaining with JALR */
     TCGLabel *misaligned = NULL;
@@ -539,7 +544,7 @@ static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         tcg_gen_addi_tl(cpu_pc, cpu_pc, imm);
         tcg_gen_andi_tl(cpu_pc, cpu_pc, (target_ulong)-2);
 
-        if (!riscv_has_ext(env, RVC)) {
+        if (!has_ext(ctx, RVC)) {
             misaligned = gen_new_label();
             tcg_gen_andi_tl(t0, cpu_pc, 0x2);
             tcg_gen_brcondi_tl(TCG_COND_NE, t0, 0x0, misaligned);
@@ -564,8 +569,8 @@ static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t0);
 }
 
-static void gen_branch(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
-                       int rs1, int rs2, target_long bimm)
+static void gen_branch(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
+                       target_long bimm)
 {
     TCGLabel *l = gen_new_label();
     TCGv source1, source2;
@@ -602,7 +607,7 @@ static void gen_branch(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
 
     gen_goto_tb(ctx, 1, ctx->pc_succ_insn);
     gen_set_label(l); /* branch taken */
-    if (!riscv_has_ext(env, RVC) && ((ctx->base.pc_next + bimm) & 0x3)) {
+    if (!has_ext(ctx, RVC) && ((ctx->base.pc_next + bimm) & 0x3)) {
         /* misaligned */
         gen_exception_inst_addr_mis(ctx);
     } else {
@@ -1305,8 +1310,8 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
     }
 }
 
-static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
-                      int rd, int rs1, int csr)
+static void gen_system(DisasContext *ctx, uint32_t opc, int rd, int rs1,
+                       int csr)
 {
     TCGv source1, csr_store, dest, rs1_pass, imm_rs1;
     source1 = tcg_temp_new();
@@ -1348,7 +1353,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             gen_exception_illegal(ctx);
             break;
         case 0x102: /* SRET */
-            if (riscv_has_ext(env, RVS)) {
+            if (has_ext(ctx, RVS)) {
                 gen_helper_sret(cpu_pc, cpu_env, cpu_pc);
                 tcg_gen_exit_tb(0); /* no chaining */
                 ctx->base.is_jmp = DISAS_NORETURN;
@@ -1489,7 +1494,7 @@ static void decode_RV32_64C0(DisasContext *ctx)
     }
 }
 
-static void decode_RV32_64C1(CPURISCVState *env, DisasContext *ctx)
+static void decode_RV32_64C1(DisasContext *ctx)
 {
     uint8_t funct3 = extract32(ctx->opcode, 13, 3);
     uint8_t rd_rs1 = GET_C_RS1(ctx->opcode);
@@ -1509,7 +1514,7 @@ static void decode_RV32_64C1(CPURISCVState *env, DisasContext *ctx)
                       GET_C_IMM(ctx->opcode));
 #else
         /* C.JAL(RV32) -> jal x1, offset[11:1] */
-        gen_jal(env, ctx, 1, GET_C_J_IMM(ctx->opcode));
+        gen_jal(ctx, 1, GET_C_J_IMM(ctx->opcode));
 #endif
         break;
     case 2:
@@ -1588,22 +1593,22 @@ static void decode_RV32_64C1(CPURISCVState *env, DisasContext *ctx)
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
@@ -1637,7 +1642,7 @@ static void decode_RV32_64C2(CPURISCVState *env, DisasContext *ctx)
         if (extract32(ctx->opcode, 12, 1) == 0) {
             if (rs2 == 0) {
                 /* C.JR -> jalr x0, rs1, 0*/
-                gen_jalr(env, ctx, OPC_RISC_JALR, 0, rd, 0);
+                gen_jalr(ctx, OPC_RISC_JALR, 0, rd, 0);
             } else {
                 /* C.MV -> add rd, x0, rs2 */
                 gen_arith(ctx, OPC_RISC_ADD, rd, 0, rs2);
@@ -1645,11 +1650,11 @@ static void decode_RV32_64C2(CPURISCVState *env, DisasContext *ctx)
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
@@ -1681,7 +1686,7 @@ static void decode_RV32_64C2(CPURISCVState *env, DisasContext *ctx)
     }
 }
 
-static void decode_RV32_64C(CPURISCVState *env, DisasContext *ctx)
+static void decode_RV32_64C(DisasContext *ctx)
 {
     uint8_t op = extract32(ctx->opcode, 0, 2);
 
@@ -1690,15 +1695,15 @@ static void decode_RV32_64C(CPURISCVState *env, DisasContext *ctx)
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
@@ -1733,13 +1738,13 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
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
@@ -1812,7 +1817,7 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
 #endif
         break;
     case OPC_RISC_SYSTEM:
-        gen_system(env, ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
+        gen_system(ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
                    (ctx->opcode & 0xFFF00000) >> 20);
         break;
     default:
@@ -1821,28 +1826,30 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
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
             ctx->pc_succ_insn = ctx->base.pc_next + 2;
-            decode_RV32_64C(env, ctx);
+            decode_RV32_64C(ctx);
         }
     } else {
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
-        decode_RV32_64G(env, ctx);
+        decode_RV32_64G(ctx);
     }
 }
 
-static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
+static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPURISCVState *env = cpu->env_ptr;
 
     ctx->pc_succ_insn = ctx->base.pc_first;
     ctx->flags = ctx->base.tb->flags;
+    ctx->misa = env->misa;
     ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
     ctx->frm = -1;  /* unknown rounding mode */
 }
@@ -1881,7 +1888,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     CPURISCVState *env = cpu->env_ptr;
 
     ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
-    decode_opc(env, ctx);
+    decode_opc(ctx);
     ctx->base.pc_next = ctx->pc_succ_insn;
 
     if (ctx->base.is_jmp == DISAS_NEXT) {
-- 
2.7.0
