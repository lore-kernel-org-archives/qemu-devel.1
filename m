Received: from eggs.gnu.org ([2001:4830:134:3::10]:39954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hl-0001rT-5s
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hh-0000JG-T7
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:37 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:38644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1Hf-00005A-P1
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:33 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:36 +0200
Message-Id: <20181012173047.25420-18-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 17/28] target/riscv: Convert quadrant 2 of RVXC
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

This also removes all functions that now became obsolete.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn16.decode              |  34 +++++-
 target/riscv/insn_trans/trans_rvc.inc.c | 107 +++++++++++++++++
 target/riscv/translate.c                | 151 +-----------------------
 3 files changed, 139 insertions(+), 153 deletions(-)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 29dade0fa1..138290c450 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -20,6 +20,7 @@
 %rd        7:5
 %rs1_3     7:3                !function=ex_rvc_register
 %rs2_3     2:3                !function=ex_rvc_register
+%rs2_5     2:5
 
 # Immediates:
 %imm_ci        12:s1 2:5
@@ -30,12 +31,14 @@
 %imm_cj        12:s1 8:1 9:2 6:1 7:1 2:1 11:1 3:3 !function=ex_shift_1
 
 %nzuimm_6bit   12:1 2:5
+%uimm_6bit_ld 2:3 12:1 5:2           !function=ex_shift_3
+%uimm_6bit_lw 2:2 12:1 4:3           !function=ex_shift_2
+%uimm_6bit_sd 7:3 10:3               !function=ex_shift_3
+%uimm_6bit_sw 7:2 9:4                !function=ex_shift_2
 
 %imm_addi16sp  12:s1 3:2 5:1 2:1 6:1 !function=ex_shift_4
 %imm_lui       12:s1 2:5             !function=ex_shift_12
 
-
-
 # Argument sets:
 &cl               rs1 rd
 &cl_dw     uimm   rs1 rd
@@ -47,11 +50,15 @@
 &cr               rd  rs2
 &c_j       imm
 &c_shift   shamt      rd
-
+&c_ld      uimm  rd
+&c_sd      uimm  rs2
 
 &c_addi16sp_lui  imm_lui imm_addi16sp rd
+&c_flwsp_ldsp    uimm_flwsp uimm_ldsp rd
+&c_fswsp_sdsp    uimm_fswsp uimm_sdsp rs2
 
 # Formats 16:
+@cr        ....  ..... .....  .. &cr                      rs2=%rs2_5  %rd
 @ci        ... . ..... .....  .. &ci     imm=%imm_ci                  %rd
 @ciw       ...   ........ ... .. &ciw    nzuimm=%nzuimm_ciw           rd=%rs2_3
 @cl_d      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rd=%rs2_3
@@ -64,9 +71,19 @@
 @cb        ... ... ... .. ... .. &cb     imm=%imm_cb      rs1=%rs1_3
 @cj        ...    ........... .. &c_j    imm=%imm_cj
 
+@c_ld      ... . .....  ..... .. &c_ld     uimm=%uimm_6bit_ld  %rd
+@c_lw      ... . .....  ..... .. &c_ld     uimm=%uimm_6bit_lw  %rd
+@c_sd      ... . .....  ..... .. &c_sd     uimm=%uimm_6bit_sd  rs2=%rs2_5
+@c_sw      ... . .....  ..... .. &c_sd     uimm=%uimm_6bit_sw  rs2=%rs2_5
+
 @c_addi16sp_lui ... .  ..... ..... .. &c_addi16sp_lui %imm_lui %imm_addi16sp %rd
+@c_flwsp_ldsp   ... .  ..... ..... .. &c_flwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
+    uimm_ldsp=%uimm_6bit_ld %rd
+@c_fswsp_sdsp   ... .  ..... ..... .. &c_fswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
+    uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5
 
 @c_shift        ... . .. ... ..... .. &c_shift rd=%rs1_3 shamt=%nzuimm_6bit
+@c_shift2       ... . .. ... ..... .. &c_shift rd=%rd    shamt=%nzuimm_6bit
 
 @c_andi         ... . .. ... ..... .. &ci imm=%imm_ci rd=%rs1_3
 
@@ -96,3 +113,14 @@ c_addw            100 1 11 ... 01 ... 01 @cs_2
 c_j               101     ........... 01 @cj
 c_beqz            110  ... ...  ..... 01 @cb
 c_bnez            111  ... ...  ..... 01 @cb
+
+# *** RV64C Standard Extension (Quadrant 2) ***
+c_slli            000 .  .....  ..... 10 @c_shift2
+c_fldsp           001 .  .....  ..... 10 @c_ld
+c_lwsp            010 .  .....  ..... 10 @c_lw
+c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
+c_jr_mv           100 0  .....  ..... 10 @cr
+c_ebreak_jalr_add 100 1  .....  ..... 10 @cr
+c_fsdsp           101   ......  ..... 10 @c_sd
+c_swsp            110 .  .....  ..... 10 @c_sw
+c_fswsp_sdsp      111 .  .....  ..... 10 @c_fswsp_sdsp #C.SDSP:RV64;C.FSWSP:RV32
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index 74cb4dad0a..b98c18d99e 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -237,3 +237,110 @@ static bool trans_c_bnez(DisasContext *ctx, arg_c_bnez *a, uint16_t insn)
     arg_bne arg = { .rs1 = a->rs1, .rs2 = 0, .imm = a->imm };
     return trans_bne(ctx, &arg, insn);
 }
+
+static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a, uint16_t insn)
+{
+    if (a->shamt == 0) {
+        /* Reserved in ISA */
+        gen_exception_illegal(ctx);
+        return true;
+    }
+
+#ifdef TARGET_RISCV32
+    /* Ensure, that shamt[5] is zero for RV32 */
+    if (a->shamt >= 32) {
+        gen_exception_illegal(ctx);
+        return true;
+    }
+#endif
+
+    arg_slli arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
+    return trans_slli(ctx, &arg, insn);
+}
+
+static bool trans_c_fldsp(DisasContext *ctx, arg_c_fldsp *a, uint16_t insn)
+{
+    arg_fld arg = { .rd = a->rd, .rs1 = 2, .imm = a->uimm };
+    return trans_fld(ctx, &arg, insn);
+}
+
+static bool trans_c_lwsp(DisasContext *ctx, arg_c_lwsp *a, uint16_t insn)
+{
+    arg_lw arg = { .rd = a->rd, .rs1 = 2, .imm = a->uimm };
+    return trans_lw(ctx, &arg, insn);
+}
+
+static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a,
+        uint16_t insn)
+{
+#ifdef TARGET_RISCV32
+    /* C.FLWSP */
+    arg_flw arg_flw = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_flwsp };
+    return trans_flw(ctx, &arg_flw, insn);
+#else
+    /* C.LDSP */
+    arg_ld arg_ld = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_ldsp };
+    return trans_ld(ctx, &arg_ld, insn);
+#endif
+    return false;
+}
+
+static bool trans_c_jr_mv(DisasContext *ctx, arg_c_jr_mv *a, uint16_t insn)
+{
+    if (a->rd != 0 && a->rs2 == 0) {
+        /* C.JR */
+        arg_jalr arg = { .rd = 0, .rs1 = a->rd, .imm = 0 };
+        return trans_jalr(ctx, &arg, insn);
+    } else if (a->rd != 0 && a->rs2 != 0) {
+        /* C.MV */
+        arg_add arg = { .rd = a->rd, .rs1 = 0, .rs2 = a->rs2 };
+        return trans_add(ctx, &arg, insn);
+    }
+    return false;
+}
+
+static bool trans_c_ebreak_jalr_add(DisasContext *ctx, arg_c_ebreak_jalr_add *a,
+        uint16_t insn)
+{
+    if (a->rd == 0 && a->rs2 == 0) {
+        /* C.EBREAK */
+        arg_ebreak arg = { };
+        return trans_ebreak(ctx, &arg, insn);
+    } else if (a->rd != 0) {
+        if (a->rs2 == 0) {
+            /* C.JALR */
+            arg_jalr arg = { .rd = 1, .rs1 = a->rd, .imm = 0 };
+            return trans_jalr(ctx, &arg, insn);
+        } else {
+            /* C.ADD */
+            arg_add arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
+            return trans_add(ctx, &arg, insn);
+        }
+    }
+    return false;
+}
+
+static bool trans_c_fsdsp(DisasContext *ctx, arg_c_fsdsp *a, uint16_t insn)
+{
+    arg_fsd arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
+    return trans_fsd(ctx, &arg, insn);
+}
+
+static bool trans_c_swsp(DisasContext *ctx, arg_c_swsp *a, uint16_t insn)
+{
+    arg_sw arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
+    return trans_sw(ctx, &arg, insn);
+}
+
+static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a,
+        uint16_t insn)
+{
+#ifdef TARGET_RISCV32
+    /* C.FSWSP */
+    arg_fsw a_fsw = { .rs1 = a->rs2, .rs2 = 2, .imm = a->uimm_fswsp };
+    return trans_fsw(ctx, &a_fsw, insn);
+#endif
+    /* C.SDSP */
+    arg_sd a_sd = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm_sdsp };
+    return trans_sd(ctx, &a_sd, insn);
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 3d2146c9b2..6b4a0430fd 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -613,65 +613,6 @@ static void gen_store(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
     tcg_temp_free(dat);
 }
 
-static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
-        int rs1, target_long imm)
-{
-    TCGv t0;
-
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
-        gen_exception_illegal(ctx);
-        return;
-    }
-
-    t0 = tcg_temp_new();
-    gen_get_gpr(t0, rs1);
-    tcg_gen_addi_tl(t0, t0, imm);
-
-    switch (opc) {
-    case OPC_RISC_FLW:
-        tcg_gen_qemu_ld_i64(cpu_fpr[rd], t0, ctx->mem_idx, MO_TEUL);
-        /* RISC-V requires NaN-boxing of narrower width floating point values */
-        tcg_gen_ori_i64(cpu_fpr[rd], cpu_fpr[rd], 0xffffffff00000000ULL);
-        break;
-    case OPC_RISC_FLD:
-        tcg_gen_qemu_ld_i64(cpu_fpr[rd], t0, ctx->mem_idx, MO_TEQ);
-        break;
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-    tcg_temp_free(t0);
-}
-
-static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
-        int rs2, target_long imm)
-{
-    TCGv t0;
-
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
-        gen_exception_illegal(ctx);
-        return;
-    }
-
-    t0 = tcg_temp_new();
-    gen_get_gpr(t0, rs1);
-    tcg_gen_addi_tl(t0, t0, imm);
-
-    switch (opc) {
-    case OPC_RISC_FSW:
-        tcg_gen_qemu_st_i64(cpu_fpr[rs2], t0, ctx->mem_idx, MO_TEUL);
-        break;
-    case OPC_RISC_FSD:
-        tcg_gen_qemu_st_i64(cpu_fpr[rs2], t0, ctx->mem_idx, MO_TEQ);
-        break;
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-
-    tcg_temp_free(t0);
-}
-
 static void gen_set_rm(DisasContext *ctx, int rm)
 {
     TCGv_i32 t0;
@@ -713,95 +654,6 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
     }
 }
 
-static void decode_RV32_64C2(CPURISCVState *env, DisasContext *ctx)
-{
-    uint8_t rd, rs2;
-    uint8_t funct3 = extract32(ctx->opcode, 13, 3);
-
-
-    rd = GET_RD(ctx->opcode);
-
-    switch (funct3) {
-    case 0: /* C.SLLI -> slli rd, rd, shamt[5:0]
-               C.SLLI64 -> */
-        gen_arith_imm(ctx, OPC_RISC_SLLI, rd, rd, GET_C_ZIMM(ctx->opcode));
-        break;
-    case 1: /* C.FLDSP(RV32/64DC) -> fld rd, offset[8:3](x2) */
-        gen_fp_load(ctx, OPC_RISC_FLD, rd, 2, GET_C_LDSP_IMM(ctx->opcode));
-        break;
-    case 2: /* C.LWSP -> lw rd, offset[7:2](x2) */
-        gen_load(ctx, OPC_RISC_LW, rd, 2, GET_C_LWSP_IMM(ctx->opcode));
-        break;
-    case 3:
-#if defined(TARGET_RISCV64)
-        /* C.LDSP(RVC64) -> ld rd, offset[8:3](x2) */
-        gen_load(ctx, OPC_RISC_LD, rd, 2, GET_C_LDSP_IMM(ctx->opcode));
-#else
-        /* C.FLWSP(RV32FC) -> flw rd, offset[7:2](x2) */
-        gen_fp_load(ctx, OPC_RISC_FLW, rd, 2, GET_C_LWSP_IMM(ctx->opcode));
-#endif
-        break;
-    case 4:
-        rs2 = GET_C_RS2(ctx->opcode);
-
-        if (extract32(ctx->opcode, 12, 1) == 0) {
-            if (rs2 == 0) {
-                /* C.JR -> jalr x0, rs1, 0*/
-                gen_jalr(env, ctx, OPC_RISC_JALR, 0, rd, 0);
-            } else {
-                /* C.MV -> add rd, x0, rs2 */
-                gen_arith(ctx, OPC_RISC_ADD, rd, 0, rs2);
-            }
-        } else {
-            if (rd == 0) {
-                /* C.EBREAK -> ebreak*/
-                gen_system(env, ctx, OPC_RISC_ECALL, 0, 0, 0x1);
-            } else {
-                if (rs2 == 0) {
-                    /* C.JALR -> jalr x1, rs1, 0*/
-                    gen_jalr(env, ctx, OPC_RISC_JALR, 1, rd, 0);
-                } else {
-                    /* C.ADD -> add rd, rd, rs2 */
-                    gen_arith(ctx, OPC_RISC_ADD, rd, rd, rs2);
-                }
-            }
-        }
-        break;
-    case 5:
-        /* C.FSDSP -> fsd rs2, offset[8:3](x2)*/
-        gen_fp_store(ctx, OPC_RISC_FSD, 2, GET_C_RS2(ctx->opcode),
-                     GET_C_SDSP_IMM(ctx->opcode));
-        /* C.SQSP */
-        break;
-    case 6: /* C.SWSP -> sw rs2, offset[7:2](x2)*/
-        gen_store(ctx, OPC_RISC_SW, 2, GET_C_RS2(ctx->opcode),
-                  GET_C_SWSP_IMM(ctx->opcode));
-        break;
-    case 7:
-#if defined(TARGET_RISCV64)
-        /* C.SDSP(Rv64/128) -> sd rs2, offset[8:3](x2)*/
-        gen_store(ctx, OPC_RISC_SD, 2, GET_C_RS2(ctx->opcode),
-                  GET_C_SDSP_IMM(ctx->opcode));
-#else
-        /* C.FSWSP(RV32) -> fsw rs2, offset[7:2](x2) */
-        gen_fp_store(ctx, OPC_RISC_FSW, 2, GET_C_RS2(ctx->opcode),
-                     GET_C_SWSP_IMM(ctx->opcode));
-#endif
-        break;
-    }
-}
-
-static void decode_RV32_64C(CPURISCVState *env, DisasContext *ctx)
-{
-    uint8_t op = extract32(ctx->opcode, 0, 2);
-
-    switch (op) {
-    case 2:
-        decode_RV32_64C2(env, ctx);
-        break;
-    }
-}
-
 #define EX_SH(amount) \
     static int64_t ex_shift_##amount(int imm) \
     {                                         \
@@ -868,8 +720,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
         } else {
             ctx->pc_succ_insn = ctx->base.pc_next + 2;
             if (!decode_insn16(ctx, ctx->opcode)) {
-                /* fall back to old decoder */
-                decode_RV32_64C(env, ctx);
+                gen_exception_illegal(ctx);
             }
         }
     } else {
-- 
2.19.1
