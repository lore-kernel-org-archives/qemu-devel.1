Received: from eggs.gnu.org ([209.51.188.92]:60192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwtl-0002NN-Ij
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwtO-00031v-4D
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:25 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwtN-00026h-MG
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:09 -0500
Received: by mail-pg1-x542.google.com with SMTP id s198so1322550pgs.2
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:55:30 -0800 (PST)
Date: Wed, 13 Feb 2019 07:54:12 -0800
Message-Id: <20190213155414.22285-34-palmer@sifive.com>
In-Reply-To: <20190213155414.22285-1-palmer@sifive.com>
References: <20190213155414.22285-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH v7 33/35] target/riscv: Splice fsw_sd and
 flw_ld for riscv32 vs riscv64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

this finally removes the old decoder functions that we carried along
with it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/riscv/Makefile.objs              |   1 +
 target/riscv/insn16-32.decode           |  24 ++++
 target/riscv/insn16-64.decode           |   4 +
 target/riscv/insn16.decode              |   7 +-
 target/riscv/insn_trans/trans_rvc.inc.c |  22 ---
 target/riscv/translate.c                | 181 +-----------------------
 6 files changed, 31 insertions(+), 208 deletions(-)
 create mode 100644 target/riscv/insn16-32.decode

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index 990bd8901623..a31a9ea061dd 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -6,6 +6,7 @@ decode32-y = $(SRC_PATH)/target/riscv/insn32.decode
 decode32-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn32-64.decode
 
 decode16-y = $(SRC_PATH)/target/riscv/insn16.decode
+decode16-$(TARGET_RISCV32) += $(SRC_PATH)/target/riscv/insn16-32.decode
 decode16-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn16-64.decode
 
 target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
diff --git a/target/riscv/insn16-32.decode b/target/riscv/insn16-32.decode
new file mode 100644
index 000000000000..e21a701056f1
--- /dev/null
+++ b/target/riscv/insn16-32.decode
@@ -0,0 +1,24 @@
+#
+# RISC-V translation routines for the RVC Instruction Set.
+#
+# Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
+#                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms and conditions of the GNU General Public License,
+# version 2 or later, as published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program.  If not, see <http://www.gnu.org/licenses/>.
+
+# This is concatenated with insn16.decode for risc32 targets.
+# All of the fields and formats are there.
+
+# *** RV32C Standard Extension (Quadrant 0) ***
+flw     011 ... ... .. ... 00   @cl_w
+fsw     111 ... ... .. ... 00   @cs_w
diff --git a/target/riscv/insn16-64.decode b/target/riscv/insn16-64.decode
index 5af2e2b0728d..de97a45acf4b 100644
--- a/target/riscv/insn16-64.decode
+++ b/target/riscv/insn16-64.decode
@@ -19,6 +19,10 @@
 # This is concatenated with insn16.decode for risc64 targets.
 # All of the fields and formats are there.
 
+# *** RV64C Standard Extension (Quadrant 0) ***
+ld      011  ... ... .. ... 00 @cl_d
+sd      111  ... ... .. ... 00 @cs_d
+
 # *** RV64C Standard Extension (Quadrant 1) ***
 subw              100 1 11 ... 00 ... 01 @cs_2
 addw              100 1 11 ... 01 ... 01 @cs_2
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index c215867ff947..b0753360626b 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -47,10 +47,9 @@
 &s         imm rs1 rs2  !extern
 
 # Argument sets:
-&cl               rs1 rd
 &ci        imm        rd
 &ciw       nzuimm     rd
-&cs               rs1 rs2
+&cs_dw     uimm   rs1 rs2
 &cb        imm    rs1
 &cr               rd  rs2
 &c_j       imm
@@ -69,8 +68,6 @@
 @ciw       ...   ........ ... .. &ciw    nzuimm=%nzuimm_ciw           rd=%rs2_3
 @cl_d      ... ... ... .. ... .. &i  imm=%uimm_cl_d  rs1=%rs1_3  rd=%rs2_3
 @cl_w      ... ... ... .. ... .. &i  imm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3
-@cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
-@cs        ... ... ... .. ... .. &cs                      rs1=%rs1_3  rs2=%rs2_3
 @cs_2      ... ... ... .. ... .. &r      rd=%rs1_3 rs1=%rs1_3 rs2=%rs2_3
 @cs_d      ... ... ... .. ... .. &s  imm=%uimm_cl_d  rs1=%rs1_3  rs2=%rs2_3
 @cs_w      ... ... ... .. ... .. &s  imm=%uimm_cl_w  rs1=%rs1_3  rs2=%rs2_3
@@ -97,10 +94,8 @@
 c_addi4spn        000    ........ ... 00 @ciw
 fld               001  ... ... .. ... 00 @cl_d
 lw                010  ... ... .. ... 00 @cl_w
-c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually
 fsd               101  ... ... .. ... 00 @cs_d
 sw                110  ... ... .. ... 00 @cs_w
-c_fsw_sd          111  --- ... -- ... 00 @cs    #Note: Must parse uimm manually
 
 # *** RV64C Standard Extension (Quadrant 1) ***
 c_addi            000 .  .....  ..... 01 @ci
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index d932bfd3e0cc..f521daf32e55 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -28,28 +28,6 @@ static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a)
     return trans_addi(ctx, &arg);
 }
 
-static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
-{
-#ifdef TARGET_RISCV32
-    /* C.FLW ( RV32FC-only ) */
-    return false;
-#else
-    /* C.LD ( RV64C/RV128C-only ) */
-    return false;
-#endif
-}
-
-static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
-{
-#ifdef TARGET_RISCV32
-    /* C.FSW ( RV32FC-only ) */
-    return false;
-#else
-    /* C.SD ( RV64C/RV128C-only ) */
-    return false;
-#endif
-}
-
 static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a)
 {
     if (a->imm == 0) {
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 597653fb12bc..5448b56e4fdd 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -57,22 +57,6 @@ typedef struct DisasContext {
     CPURISCVState *env;
 } DisasContext;
 
-#ifdef TARGET_RISCV64
-/* convert riscv funct3 to qemu memop for load/store */
-static const int tcg_memop_lookup[8] = {
-    [0 ... 7] = -1,
-    [0] = MO_SB,
-    [1] = MO_TESW,
-    [2] = MO_TESL,
-    [4] = MO_UB,
-    [5] = MO_TEUW,
-#ifdef TARGET_RISCV64
-    [3] = MO_TEQ,
-    [6] = MO_TEUL,
-#endif
-};
-#endif
-
 #ifdef TARGET_RISCV64
 #define CASE_OP_32_64(X) case X: case glue(X, W)
 #else
@@ -317,49 +301,6 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-#ifdef TARGET_RISCV64
-static void gen_load_c(DisasContext *ctx, uint32_t opc, int rd, int rs1,
-        target_long imm)
-{
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    gen_get_gpr(t0, rs1);
-    tcg_gen_addi_tl(t0, t0, imm);
-    int memop = tcg_memop_lookup[(opc >> 12) & 0x7];
-
-    if (memop < 0) {
-        gen_exception_illegal(ctx);
-        return;
-    }
-
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, memop);
-    gen_set_gpr(rd, t1);
-    tcg_temp_free(t0);
-    tcg_temp_free(t1);
-}
-
-static void gen_store_c(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
-        target_long imm)
-{
-    TCGv t0 = tcg_temp_new();
-    TCGv dat = tcg_temp_new();
-    gen_get_gpr(t0, rs1);
-    tcg_gen_addi_tl(t0, t0, imm);
-    gen_get_gpr(dat, rs2);
-    int memop = tcg_memop_lookup[(opc >> 12) & 0x7];
-
-    if (memop < 0) {
-        gen_exception_illegal(ctx);
-        return;
-    }
-
-    tcg_gen_qemu_st_tl(dat, t0, ctx->mem_idx, memop);
-    tcg_temp_free(t0);
-    tcg_temp_free(dat);
-}
-#endif
-
-#if !defined(TARGET_RISCV64)
 #ifndef CONFIG_USER_ONLY
 /* The states of mstatus_fs are:
  * 0 = disabled, 1 = initial, 2 = clean, 3 = dirty
@@ -385,82 +326,6 @@ static void mark_fs_dirty(DisasContext *ctx)
 static inline void mark_fs_dirty(DisasContext *ctx) { }
 #endif
 
-static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
-        int rs1, target_long imm)
-{
-    TCGv t0;
-
-    if (ctx->mstatus_fs == 0) {
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
-        if (!has_ext(ctx, RVF)) {
-            goto do_illegal;
-        }
-        tcg_gen_qemu_ld_i64(cpu_fpr[rd], t0, ctx->mem_idx, MO_TEUL);
-        /* RISC-V requires NaN-boxing of narrower width floating point values */
-        tcg_gen_ori_i64(cpu_fpr[rd], cpu_fpr[rd], 0xffffffff00000000ULL);
-        break;
-    case OPC_RISC_FLD:
-        if (!has_ext(ctx, RVD)) {
-            goto do_illegal;
-        }
-        tcg_gen_qemu_ld_i64(cpu_fpr[rd], t0, ctx->mem_idx, MO_TEQ);
-        break;
-    do_illegal:
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-    tcg_temp_free(t0);
-
-    mark_fs_dirty(ctx);
-}
-
-static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
-        int rs2, target_long imm)
-{
-    TCGv t0;
-
-    if (ctx->mstatus_fs == 0) {
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
-        if (!has_ext(ctx, RVF)) {
-            goto do_illegal;
-        }
-        tcg_gen_qemu_st_i64(cpu_fpr[rs2], t0, ctx->mem_idx, MO_TEUL);
-        break;
-    case OPC_RISC_FSD:
-        if (!has_ext(ctx, RVD)) {
-            goto do_illegal;
-        }
-        tcg_gen_qemu_st_i64(cpu_fpr[rs2], t0, ctx->mem_idx, MO_TEQ);
-        break;
-    do_illegal:
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-
-    tcg_temp_free(t0);
-}
-#endif
-
 static void gen_set_rm(DisasContext *ctx, int rm)
 {
     TCGv_i32 t0;
@@ -474,49 +339,6 @@ static void gen_set_rm(DisasContext *ctx, int rm)
     tcg_temp_free_i32(t0);
 }
 
-static void decode_RV32_64C0(DisasContext *ctx)
-{
-    uint8_t funct3 = extract32(ctx->opcode, 13, 3);
-    uint8_t rd_rs2 = GET_C_RS2S(ctx->opcode);
-    uint8_t rs1s = GET_C_RS1S(ctx->opcode);
-
-    switch (funct3) {
-    case 3:
-#if defined(TARGET_RISCV64)
-        /* C.LD(RV64/128) -> ld rd', offset[7:3](rs1')*/
-        gen_load_c(ctx, OPC_RISC_LD, rd_rs2, rs1s,
-                 GET_C_LD_IMM(ctx->opcode));
-#else
-        /* C.FLW (RV32) -> flw rd', offset[6:2](rs1')*/
-        gen_fp_load(ctx, OPC_RISC_FLW, rd_rs2, rs1s,
-                    GET_C_LW_IMM(ctx->opcode));
-#endif
-        break;
-    case 7:
-#if defined(TARGET_RISCV64)
-        /* C.SD (RV64/128) -> sd rs2', offset[7:3](rs1')*/
-        gen_store_c(ctx, OPC_RISC_SD, rs1s, rd_rs2,
-                  GET_C_LD_IMM(ctx->opcode));
-#else
-        /* C.FSW (RV32) -> fsw rs2', offset[6:2](rs1')*/
-        gen_fp_store(ctx, OPC_RISC_FSW, rs1s, rd_rs2,
-                     GET_C_LW_IMM(ctx->opcode));
-#endif
-        break;
-    }
-}
-
-static void decode_RV32_64C(DisasContext *ctx)
-{
-    uint8_t op = extract32(ctx->opcode, 0, 2);
-
-    switch (op) {
-    case 0:
-        decode_RV32_64C0(ctx);
-        break;
-    }
-}
-
 #define EX_SH(amount) \
     static int ex_shift_##amount(int imm) \
     {                                         \
@@ -667,8 +489,7 @@ static void decode_opc(DisasContext *ctx)
         } else {
             ctx->pc_succ_insn = ctx->base.pc_next + 2;
             if (!decode_insn16(ctx, ctx->opcode)) {
-                /* fall back to old decoder */
-                decode_RV32_64C(ctx);
+                gen_exception_illegal(ctx);
             }
         }
     } else {
-- 
2.18.1
