Received: from eggs.gnu.org ([209.51.188.92]:51466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC8B-000483-Kr
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC89-000150-Jt
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:58:59 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 14 Jan 2019 23:58:42 +0000
Message-ID: <2425e4ccd5ad76fa9dbedfc7c2b33918a222aabd.1547510220.git.alistair.francis@wdc.com>
References: <cover.1547510220.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1547510220.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 6/8] RISC-V: Add misa to DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

From: Michael Clark <mjc@sifive.com>

gen methods should access state from DisasContext. Add misa
field to the DisasContext struct and remove CPURISCVState
argument from all gen methods.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Emilio G. Cota <cota@braap.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 75 +++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 833adf1d6f..7ebea308b4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -46,6 +46,7 @@ typedef struct DisasContext {
     target_ulong priv_ver;
     uint32_t opcode;
     uint32_t mstatus_fs;
+    uint32_t misa;
     uint32_t mem_idx;
     /* Remember the rounding mode encoded in the previous fp instruction,
        which we have already installed into env->fp_status.  Or -1 for
@@ -75,6 +76,11 @@ static const int tcg_memop_lookup[8] =3D {
 #define CASE_OP_32_64(X) case X
 #endif
=20
+static inline bool has_ext(DisasContext *ctx, uint32_t ext)
+{
+    return ctx->misa & ext;
+}
+
 static void generate_exception(DisasContext *ctx, int excp)
 {
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
@@ -506,14 +512,13 @@ static void gen_arith_imm(DisasContext *ctx, uint32_t=
 opc, int rd,
     tcg_temp_free(source1);
 }
=20
-static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
-                    target_ulong imm)
+static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     target_ulong next_pc;
=20
     /* check misaligned: */
     next_pc =3D ctx->base.pc_next + imm;
-    if (!riscv_has_ext(env, RVC)) {
+    if (!has_ext(ctx, RVC)) {
         if ((next_pc & 0x3) !=3D 0) {
             gen_exception_inst_addr_mis(ctx);
             return;
@@ -527,8 +532,8 @@ static void gen_jal(CPURISCVState *env, DisasContext *c=
tx, int rd,
     ctx->base.is_jmp =3D DISAS_NORETURN;
 }
=20
-static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
-                     int rd, int rs1, target_long imm)
+static void gen_jalr(DisasContext *ctx, uint32_t opc, int rd, int rs1,
+                     target_long imm)
 {
     /* no chaining with JALR */
     TCGLabel *misaligned =3D NULL;
@@ -540,7 +545,7 @@ static void gen_jalr(CPURISCVState *env, DisasContext *=
ctx, uint32_t opc,
         tcg_gen_addi_tl(cpu_pc, cpu_pc, imm);
         tcg_gen_andi_tl(cpu_pc, cpu_pc, (target_ulong)-2);
=20
-        if (!riscv_has_ext(env, RVC)) {
+        if (!has_ext(ctx, RVC)) {
             misaligned =3D gen_new_label();
             tcg_gen_andi_tl(t0, cpu_pc, 0x2);
             tcg_gen_brcondi_tl(TCG_COND_NE, t0, 0x0, misaligned);
@@ -565,8 +570,8 @@ static void gen_jalr(CPURISCVState *env, DisasContext *=
ctx, uint32_t opc,
     tcg_temp_free(t0);
 }
=20
-static void gen_branch(CPURISCVState *env, DisasContext *ctx, uint32_t opc=
,
-                       int rs1, int rs2, target_long bimm)
+static void gen_branch(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
+                       target_long bimm)
 {
     TCGLabel *l =3D gen_new_label();
     TCGv source1, source2;
@@ -603,7 +608,7 @@ static void gen_branch(CPURISCVState *env, DisasContext=
 *ctx, uint32_t opc,
=20
     gen_goto_tb(ctx, 1, ctx->pc_succ_insn);
     gen_set_label(l); /* branch taken */
-    if (!riscv_has_ext(env, RVC) && ((ctx->base.pc_next + bimm) & 0x3)) {
+    if (!has_ext(ctx, RVC) && ((ctx->base.pc_next + bimm) & 0x3)) {
         /* misaligned */
         gen_exception_inst_addr_mis(ctx);
     } else {
@@ -1314,8 +1319,8 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t =
opc, int rd,
     }
 }
=20
-static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc=
,
-                      int rd, int rs1, int csr)
+static void gen_system(DisasContext *ctx, uint32_t opc, int rd, int rs1,
+                       int csr)
 {
     TCGv source1, csr_store, dest, rs1_pass, imm_rs1;
     source1 =3D tcg_temp_new();
@@ -1361,7 +1366,7 @@ static void gen_system(CPURISCVState *env, DisasConte=
xt *ctx, uint32_t opc,
             gen_exception_illegal(ctx);
             break;
         case 0x102: /* SRET */
-            if (riscv_has_ext(env, RVS)) {
+            if (has_ext(ctx, RVS)) {
                 gen_helper_sret(cpu_pc, cpu_env, cpu_pc);
                 tcg_gen_exit_tb(NULL, 0); /* no chaining */
                 ctx->base.is_jmp =3D DISAS_NORETURN;
@@ -1506,7 +1511,7 @@ static void decode_RV32_64C0(DisasContext *ctx)
     }
 }
=20
-static void decode_RV32_64C1(CPURISCVState *env, DisasContext *ctx)
+static void decode_RV32_64C1(DisasContext *ctx)
 {
     uint8_t funct3 =3D extract32(ctx->opcode, 13, 3);
     uint8_t rd_rs1 =3D GET_C_RS1(ctx->opcode);
@@ -1526,7 +1531,7 @@ static void decode_RV32_64C1(CPURISCVState *env, Disa=
sContext *ctx)
                       GET_C_IMM(ctx->opcode));
 #else
         /* C.JAL(RV32) -> jal x1, offset[11:1] */
-        gen_jal(env, ctx, 1, GET_C_J_IMM(ctx->opcode));
+        gen_jal(ctx, 1, GET_C_J_IMM(ctx->opcode));
 #endif
         break;
     case 2:
@@ -1605,22 +1610,22 @@ static void decode_RV32_64C1(CPURISCVState *env, Di=
sasContext *ctx)
         break;
     case 5:
         /* C.J -> jal x0, offset[11:1]*/
-        gen_jal(env, ctx, 0, GET_C_J_IMM(ctx->opcode));
+        gen_jal(ctx, 0, GET_C_J_IMM(ctx->opcode));
         break;
     case 6:
         /* C.BEQZ -> beq rs1', x0, offset[8:1]*/
         rs1s =3D GET_C_RS1S(ctx->opcode);
-        gen_branch(env, ctx, OPC_RISC_BEQ, rs1s, 0, GET_C_B_IMM(ctx->opcod=
e));
+        gen_branch(ctx, OPC_RISC_BEQ, rs1s, 0, GET_C_B_IMM(ctx->opcode));
         break;
     case 7:
         /* C.BNEZ -> bne rs1', x0, offset[8:1]*/
         rs1s =3D GET_C_RS1S(ctx->opcode);
-        gen_branch(env, ctx, OPC_RISC_BNE, rs1s, 0, GET_C_B_IMM(ctx->opcod=
e));
+        gen_branch(ctx, OPC_RISC_BNE, rs1s, 0, GET_C_B_IMM(ctx->opcode));
         break;
     }
 }
=20
-static void decode_RV32_64C2(CPURISCVState *env, DisasContext *ctx)
+static void decode_RV32_64C2(DisasContext *ctx)
 {
     uint8_t rd, rs2;
     uint8_t funct3 =3D extract32(ctx->opcode, 13, 3);
@@ -1654,7 +1659,7 @@ static void decode_RV32_64C2(CPURISCVState *env, Disa=
sContext *ctx)
         if (extract32(ctx->opcode, 12, 1) =3D=3D 0) {
             if (rs2 =3D=3D 0) {
                 /* C.JR -> jalr x0, rs1, 0*/
-                gen_jalr(env, ctx, OPC_RISC_JALR, 0, rd, 0);
+                gen_jalr(ctx, OPC_RISC_JALR, 0, rd, 0);
             } else {
                 /* C.MV -> add rd, x0, rs2 */
                 gen_arith(ctx, OPC_RISC_ADD, rd, 0, rs2);
@@ -1662,11 +1667,11 @@ static void decode_RV32_64C2(CPURISCVState *env, Di=
sasContext *ctx)
         } else {
             if (rd =3D=3D 0) {
                 /* C.EBREAK -> ebreak*/
-                gen_system(env, ctx, OPC_RISC_ECALL, 0, 0, 0x1);
+                gen_system(ctx, OPC_RISC_ECALL, 0, 0, 0x1);
             } else {
                 if (rs2 =3D=3D 0) {
                     /* C.JALR -> jalr x1, rs1, 0*/
-                    gen_jalr(env, ctx, OPC_RISC_JALR, 1, rd, 0);
+                    gen_jalr(ctx, OPC_RISC_JALR, 1, rd, 0);
                 } else {
                     /* C.ADD -> add rd, rd, rs2 */
                     gen_arith(ctx, OPC_RISC_ADD, rd, rd, rs2);
@@ -1698,7 +1703,7 @@ static void decode_RV32_64C2(CPURISCVState *env, Disa=
sContext *ctx)
     }
 }
=20
-static void decode_RV32_64C(CPURISCVState *env, DisasContext *ctx)
+static void decode_RV32_64C(DisasContext *ctx)
 {
     uint8_t op =3D extract32(ctx->opcode, 0, 2);
=20
@@ -1707,15 +1712,15 @@ static void decode_RV32_64C(CPURISCVState *env, Dis=
asContext *ctx)
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
=20
-static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
+static void decode_RV32_64G(DisasContext *ctx)
 {
     int rs1;
     int rs2;
@@ -1750,13 +1755,13 @@ static void decode_RV32_64G(CPURISCVState *env, Dis=
asContext *ctx)
         break;
     case OPC_RISC_JAL:
         imm =3D GET_JAL_IMM(ctx->opcode);
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
@@ -1827,7 +1832,7 @@ static void decode_RV32_64G(CPURISCVState *env, Disas=
Context *ctx)
         }
         break;
     case OPC_RISC_SYSTEM:
-        gen_system(env, ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
+        gen_system(ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
                    (ctx->opcode & 0xFFF00000) >> 20);
         break;
     default:
@@ -1836,19 +1841,19 @@ static void decode_RV32_64G(CPURISCVState *env, Dis=
asContext *ctx)
     }
 }
=20
-static void decode_opc(CPURISCVState *env, DisasContext *ctx)
+static void decode_opc(DisasContext *ctx)
 {
     /* check for compressed insn */
     if (extract32(ctx->opcode, 0, 2) !=3D 3) {
-        if (!riscv_has_ext(env, RVC)) {
+        if (!has_ext(ctx, RVC)) {
             gen_exception_illegal(ctx);
         } else {
             ctx->pc_succ_insn =3D ctx->base.pc_next + 2;
-            decode_RV32_64C(env, ctx);
+            decode_RV32_64C(ctx);
         }
     } else {
         ctx->pc_succ_insn =3D ctx->base.pc_next + 4;
-        decode_RV32_64G(env, ctx);
+        decode_RV32_64G(ctx);
     }
 }
=20
@@ -1861,6 +1866,7 @@ static void riscv_tr_init_disas_context(DisasContextB=
ase *dcbase, CPUState *cpu)
     ctx->mem_idx =3D ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
     ctx->mstatus_fs =3D ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx->priv_ver =3D env->priv_ver;
+    ctx->misa =3D env->misa;
     ctx->frm =3D -1;  /* unknown rounding mode */
 }
=20
@@ -1891,14 +1897,13 @@ static bool riscv_tr_breakpoint_check(DisasContextB=
ase *dcbase, CPUState *cpu,
     return true;
 }
=20
-
 static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cp=
u)
 {
     DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
     CPURISCVState *env =3D cpu->env_ptr;
=20
     ctx->opcode =3D cpu_ldl_code(env, ctx->base.pc_next);
-    decode_opc(env, ctx);
+    decode_opc(ctx);
     ctx->base.pc_next =3D ctx->pc_succ_insn;
=20
     if (ctx->base.is_jmp =3D=3D DISAS_NEXT) {
--=20
2.19.1
