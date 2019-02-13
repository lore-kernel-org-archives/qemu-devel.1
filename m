Received: from eggs.gnu.org ([209.51.188.92]:59879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwtS-00022f-FS
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwtM-0002y7-ME
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:14 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwtM-0001NU-33
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:08 -0500
Received: by mail-pg1-x544.google.com with SMTP id g189so1312933pgc.5
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:55:08 -0800 (PST)
Date: Wed, 13 Feb 2019 07:53:58 -0800
Message-Id: <20190213155414.22285-20-palmer@sifive.com>
In-Reply-To: <20190213155414.22285-1-palmer@sifive.com>
References: <20190213155414.22285-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH v7 19/35] target/riscv: Convert quadrant 2 of
 RVXC insns to decodetree
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn16.decode              |  31 ++++++++
 target/riscv/insn_trans/trans_rvc.inc.c | 101 ++++++++++++++++++++++++
 target/riscv/translate.c                |  83 +------------------
 3 files changed, 134 insertions(+), 81 deletions(-)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 29dade0fa1ae..0829e3bc592d 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -20,6 +20,7 @@
 %rd        7:5
 %rs1_3     7:3                !function=ex_rvc_register
 %rs2_3     2:3                !function=ex_rvc_register
+%rs2_5     2:5
 
 # Immediates:
 %imm_ci        12:s1 2:5
@@ -30,6 +31,10 @@
 %imm_cj        12:s1 8:1 9:2 6:1 7:1 2:1 11:1 3:3 !function=ex_shift_1
 
 %nzuimm_6bit   12:1 2:5
+%uimm_6bit_ld 2:3 12:1 5:2           !function=ex_shift_3
+%uimm_6bit_lw 2:2 12:1 4:3           !function=ex_shift_2
+%uimm_6bit_sd 7:3 10:3               !function=ex_shift_3
+%uimm_6bit_sw 7:2 9:4                !function=ex_shift_2
 
 %imm_addi16sp  12:s1 3:2 5:1 2:1 6:1 !function=ex_shift_4
 %imm_lui       12:s1 2:5             !function=ex_shift_12
@@ -48,10 +53,15 @@
 &c_j       imm
 &c_shift   shamt      rd
 
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
@@ -64,9 +74,19 @@
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
 
@@ -96,3 +116,14 @@ c_addw            100 1 11 ... 01 ... 01 @cs_2
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
index b06c435c9800..bcdf64d3b705 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -224,3 +224,104 @@ static bool trans_c_bnez(DisasContext *ctx, arg_c_bnez *a)
     arg_bne arg = { .rs1 = a->rs1, .rs2 = 0, .imm = a->imm };
     return trans_bne(ctx, &arg);
 }
+
+static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a)
+{
+    int shamt = a->shamt;
+    if (shamt == 0) {
+        /* For RV128 a shamt of 0 means a shift by 64 */
+        shamt = 64;
+    }
+    /* Ensure, that shamt[5] is zero for RV32 */
+    if (shamt >= TARGET_LONG_BITS) {
+        return false;
+    }
+
+    arg_slli arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
+    return trans_slli(ctx, &arg);
+}
+
+static bool trans_c_fldsp(DisasContext *ctx, arg_c_fldsp *a)
+{
+    arg_fld arg = { .rd = a->rd, .rs1 = 2, .imm = a->uimm };
+    return trans_fld(ctx, &arg);
+}
+
+static bool trans_c_lwsp(DisasContext *ctx, arg_c_lwsp *a)
+{
+    arg_lw arg = { .rd = a->rd, .rs1 = 2, .imm = a->uimm };
+    return trans_lw(ctx, &arg);
+}
+
+static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
+{
+#ifdef TARGET_RISCV32
+    /* C.FLWSP */
+    arg_flw arg_flw = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_flwsp };
+    return trans_flw(ctx, &arg_flw);
+#else
+    /* C.LDSP */
+    arg_ld arg_ld = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_ldsp };
+    return trans_ld(ctx, &arg_ld);
+#endif
+    return false;
+}
+
+static bool trans_c_jr_mv(DisasContext *ctx, arg_c_jr_mv *a)
+{
+    if (a->rd != 0 && a->rs2 == 0) {
+        /* C.JR */
+        arg_jalr arg = { .rd = 0, .rs1 = a->rd, .imm = 0 };
+        return trans_jalr(ctx, &arg);
+    } else if (a->rd != 0 && a->rs2 != 0) {
+        /* C.MV */
+        arg_add arg = { .rd = a->rd, .rs1 = 0, .rs2 = a->rs2 };
+        return trans_add(ctx, &arg);
+    }
+    return false;
+}
+
+static bool trans_c_ebreak_jalr_add(DisasContext *ctx, arg_c_ebreak_jalr_add *a)
+{
+    if (a->rd == 0 && a->rs2 == 0) {
+        /* C.EBREAK */
+        arg_ebreak arg = { };
+        return trans_ebreak(ctx, &arg);
+    } else if (a->rd != 0) {
+        if (a->rs2 == 0) {
+            /* C.JALR */
+            arg_jalr arg = { .rd = 1, .rs1 = a->rd, .imm = 0 };
+            return trans_jalr(ctx, &arg);
+        } else {
+            /* C.ADD */
+            arg_add arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
+            return trans_add(ctx, &arg);
+        }
+    }
+    return false;
+}
+
+static bool trans_c_fsdsp(DisasContext *ctx, arg_c_fsdsp *a)
+{
+    arg_fsd arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
+    return trans_fsd(ctx, &arg);
+}
+
+static bool trans_c_swsp(DisasContext *ctx, arg_c_swsp *a)
+{
+    arg_sw arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
+    return trans_sw(ctx, &arg);
+}
+
+static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a)
+{
+#ifdef TARGET_RISCV32
+    /* C.FSWSP */
+    arg_fsw a_fsw = { .rs1 = a->rs2, .rs2 = 2, .imm = a->uimm_fswsp };
+    return trans_fsw(ctx, &a_fsw);
+#else
+    /* C.SDSP */
+    arg_sd a_sd = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm_sdsp };
+    return trans_sd(ctx, &a_sd);
+#endif
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 52fcc5bb7b77..c9a8fdda8a85 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -657,6 +657,7 @@ static void gen_store(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
     tcg_temp_free(dat);
 }
 
+#if !defined(TARGET_RISCV64)
 #ifndef CONFIG_USER_ONLY
 /* The states of mstatus_fs are:
  * 0 = disabled, 1 = initial, 2 = clean, 3 = dirty
@@ -756,6 +757,7 @@ static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
 
     tcg_temp_free(t0);
 }
+#endif
 
 static void gen_set_rm(DisasContext *ctx, int rm)
 {
@@ -829,84 +831,6 @@ static void decode_RV32_64C0(DisasContext *ctx)
     }
 }
 
-static void decode_RV32_64C2(DisasContext *ctx)
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
-                gen_jalr(ctx, OPC_RISC_JALR, 0, rd, 0);
-            } else {
-                /* C.MV -> add rd, x0, rs2 */
-                gen_arith(ctx, OPC_RISC_ADD, rd, 0, rs2);
-            }
-        } else {
-            if (rd == 0) {
-                /* C.EBREAK -> ebreak*/
-                gen_system(ctx, OPC_RISC_ECALL, 0, 0, 0x1);
-            } else {
-                if (rs2 == 0) {
-                    /* C.JALR -> jalr x1, rs1, 0*/
-                    gen_jalr(ctx, OPC_RISC_JALR, 1, rd, 0);
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
 static void decode_RV32_64C(DisasContext *ctx)
 {
     uint8_t op = extract32(ctx->opcode, 0, 2);
@@ -915,9 +839,6 @@ static void decode_RV32_64C(DisasContext *ctx)
     case 0:
         decode_RV32_64C0(ctx);
         break;
-    case 2:
-        decode_RV32_64C2(ctx);
-        break;
     }
 }
 
-- 
2.18.1
