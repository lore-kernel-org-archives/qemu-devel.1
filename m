Received: from eggs.gnu.org ([2001:4830:134:3::10]:42627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTj-0000Gt-NP
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTh-0001Dn-Iw
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:07 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:44824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHTh-0001DH-Af
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:05 -0400
Received: by mail-pf0-x22b.google.com with SMTP id q22-v6so9549866pff.11
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:18:05 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:08 +1200
Message-Id: <1527034517-7851-22-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 21/30] RISC-V: Add misa.MAFD checks to
 translate
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

Add misa checks for M, A, F and D extensions and if they are
not present generate illegal instructions. This improves
emulation accurary for harts with a limited set of extensions.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Emilio G. Cota <cota@braap.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/translate.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index fd21b133a5a4..e488101ff56d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -290,24 +290,42 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
         tcg_gen_and_tl(source1, source1, source2);
         break;
     CASE_OP_32_64(OPC_RISC_MUL):
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         tcg_gen_mul_tl(source1, source1, source2);
         break;
     case OPC_RISC_MULH:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         tcg_gen_muls2_tl(source2, source1, source1, source2);
         break;
     case OPC_RISC_MULHSU:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         gen_mulhsu(source1, source1, source2);
         break;
     case OPC_RISC_MULHU:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         tcg_gen_mulu2_tl(source2, source1, source1, source2);
         break;
 #if defined(TARGET_RISCV64)
     case OPC_RISC_DIVW:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         tcg_gen_ext32s_tl(source1, source1);
         tcg_gen_ext32s_tl(source2, source2);
         /* fall through to DIV */
 #endif
     case OPC_RISC_DIV:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         /* Handle by altering args to tcg_gen_div to produce req'd results:
          * For overflow: want source1 in source1 and 1 in source2
          * For div by zero: want -1 in source1 and 1 in source2 -> -1 result */
@@ -339,11 +357,17 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
         break;
 #if defined(TARGET_RISCV64)
     case OPC_RISC_DIVUW:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         tcg_gen_ext32u_tl(source1, source1);
         tcg_gen_ext32u_tl(source2, source2);
         /* fall through to DIVU */
 #endif
     case OPC_RISC_DIVU:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         cond1 = tcg_temp_new();
         zeroreg = tcg_const_tl(0);
         resultopt1 = tcg_temp_new();
@@ -363,11 +387,17 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
         break;
 #if defined(TARGET_RISCV64)
     case OPC_RISC_REMW:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         tcg_gen_ext32s_tl(source1, source1);
         tcg_gen_ext32s_tl(source2, source2);
         /* fall through to REM */
 #endif
     case OPC_RISC_REM:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         cond1 = tcg_temp_new();
         cond2 = tcg_temp_new();
         zeroreg = tcg_const_tl(0);
@@ -395,11 +425,17 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
         break;
 #if defined(TARGET_RISCV64)
     case OPC_RISC_REMUW:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         tcg_gen_ext32u_tl(source1, source1);
         tcg_gen_ext32u_tl(source2, source2);
         /* fall through to REMU */
 #endif
     case OPC_RISC_REMU:
+        if (!has_ext(ctx, RVM)) {
+            goto do_illegal;
+        }
         cond1 = tcg_temp_new();
         zeroreg = tcg_const_tl(0);
         resultopt1 = tcg_temp_new();
@@ -417,6 +453,7 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
         tcg_temp_free(zeroreg);
         tcg_temp_free(resultopt1);
         break;
+    do_illegal:
     default:
         gen_exception_illegal(ctx);
         return;
@@ -697,13 +734,20 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
 
     switch (opc) {
     case OPC_RISC_FLW:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         tcg_gen_qemu_ld_i64(cpu_fpr[rd], t0, ctx->mem_idx, MO_TEUL);
         /* RISC-V requires NaN-boxing of narrower width floating point values */
         tcg_gen_ori_i64(cpu_fpr[rd], cpu_fpr[rd], 0xffffffff00000000ULL);
         break;
     case OPC_RISC_FLD:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         tcg_gen_qemu_ld_i64(cpu_fpr[rd], t0, ctx->mem_idx, MO_TEQ);
         break;
+    do_illegal:
     default:
         gen_exception_illegal(ctx);
         break;
@@ -729,11 +773,18 @@ static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
 
     switch (opc) {
     case OPC_RISC_FSW:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         tcg_gen_qemu_st_i64(cpu_fpr[rs2], t0, ctx->mem_idx, MO_TEUL);
         break;
     case OPC_RISC_FSD:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         tcg_gen_qemu_st_i64(cpu_fpr[rs2], t0, ctx->mem_idx, MO_TEQ);
         break;
+    do_illegal:
     default:
         gen_exception_illegal(ctx);
         break;
@@ -897,15 +948,22 @@ static void gen_fp_fmadd(DisasContext *ctx, uint32_t opc, int rd,
 {
     switch (opc) {
     case OPC_RISC_FMADD_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fmadd_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
                            cpu_fpr[rs2], cpu_fpr[rs3]);
         break;
     case OPC_RISC_FMADD_D:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fmadd_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
                            cpu_fpr[rs2], cpu_fpr[rs3]);
         break;
+    do_illegal:
     default:
         gen_exception_illegal(ctx);
         break;
@@ -917,15 +975,22 @@ static void gen_fp_fmsub(DisasContext *ctx, uint32_t opc, int rd,
 {
     switch (opc) {
     case OPC_RISC_FMSUB_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fmsub_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
                            cpu_fpr[rs2], cpu_fpr[rs3]);
         break;
     case OPC_RISC_FMSUB_D:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fmsub_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
                            cpu_fpr[rs2], cpu_fpr[rs3]);
         break;
+    do_illegal:
     default:
         gen_exception_illegal(ctx);
         break;
@@ -937,15 +1002,22 @@ static void gen_fp_fnmsub(DisasContext *ctx, uint32_t opc, int rd,
 {
     switch (opc) {
     case OPC_RISC_FNMSUB_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fnmsub_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
                             cpu_fpr[rs2], cpu_fpr[rs3]);
         break;
     case OPC_RISC_FNMSUB_D:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fnmsub_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
                             cpu_fpr[rs2], cpu_fpr[rs3]);
         break;
+    do_illegal:
     default:
         gen_exception_illegal(ctx);
         break;
@@ -957,15 +1029,22 @@ static void gen_fp_fnmadd(DisasContext *ctx, uint32_t opc, int rd,
 {
     switch (opc) {
     case OPC_RISC_FNMADD_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fnmadd_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
                             cpu_fpr[rs2], cpu_fpr[rs3]);
         break;
     case OPC_RISC_FNMADD_D:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fnmadd_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
                             cpu_fpr[rs2], cpu_fpr[rs3]);
         break;
+    do_illegal:
     default:
         gen_exception_illegal(ctx);
         break;
@@ -984,30 +1063,51 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 
     switch (opc) {
     case OPC_RISC_FADD_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fadd_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
         break;
     case OPC_RISC_FSUB_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fsub_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
         break;
     case OPC_RISC_FMUL_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fmul_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
         break;
     case OPC_RISC_FDIV_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fdiv_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
         break;
     case OPC_RISC_FSQRT_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fsqrt_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1]);
         break;
     case OPC_RISC_FSGNJ_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         gen_fsgnj(ctx, rd, rs1, rs2, rm, INT32_MIN);
         break;
 
     case OPC_RISC_FMIN_S:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         /* also handles: OPC_RISC_FMAX_S */
         switch (rm) {
         case 0x0:
@@ -1023,6 +1123,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 
     case OPC_RISC_FEQ_S:
         /* also handles: OPC_RISC_FLT_S, OPC_RISC_FLE_S */
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         t0 = tcg_temp_new();
         switch (rm) {
         case 0x0:
@@ -1044,6 +1147,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 
     case OPC_RISC_FCVT_W_S:
         /* also OPC_RISC_FCVT_WU_S, OPC_RISC_FCVT_L_S, OPC_RISC_FCVT_LU_S */
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         t0 = tcg_temp_new();
         switch (rs2) {
         case 0: /* FCVT_W_S */
@@ -1074,6 +1180,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 
     case OPC_RISC_FCVT_S_W:
         /* also OPC_RISC_FCVT_S_WU, OPC_RISC_FCVT_S_L, OPC_RISC_FCVT_S_LU */
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         t0 = tcg_temp_new();
         gen_get_gpr(t0, rs1);
         switch (rs2) {
@@ -1103,6 +1212,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 
     case OPC_RISC_FMV_X_S:
         /* also OPC_RISC_FCLASS_S */
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         t0 = tcg_temp_new();
         switch (rm) {
         case 0: /* FMV */
@@ -1124,6 +1236,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         break;
 
     case OPC_RISC_FMV_S_X:
+        if (!has_ext(ctx, RVF)) {
+            goto do_illegal;
+        }
         t0 = tcg_temp_new();
         gen_get_gpr(t0, rs1);
 #if defined(TARGET_RISCV64)
@@ -1136,22 +1251,37 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 
     /* double */
     case OPC_RISC_FADD_D:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fadd_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
         break;
     case OPC_RISC_FSUB_D:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fsub_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
         break;
     case OPC_RISC_FMUL_D:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fmul_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
         break;
     case OPC_RISC_FDIV_D:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fdiv_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
         break;
     case OPC_RISC_FSQRT_D:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         gen_set_rm(ctx, rm);
         gen_helper_fsqrt_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1]);
         break;
@@ -1161,6 +1291,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 
     case OPC_RISC_FMIN_D:
         /* also OPC_RISC_FMAX_D */
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         switch (rm) {
         case 0:
             gen_helper_fmin_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
@@ -1174,6 +1307,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         break;
 
     case OPC_RISC_FCVT_S_D:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         switch (rs2) {
         case 1:
             gen_set_rm(ctx, rm);
@@ -1185,6 +1321,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         break;
 
     case OPC_RISC_FCVT_D_S:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         switch (rs2) {
         case 0:
             gen_set_rm(ctx, rm);
@@ -1197,6 +1336,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 
     case OPC_RISC_FEQ_D:
         /* also OPC_RISC_FLT_D, OPC_RISC_FLE_D */
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         t0 = tcg_temp_new();
         switch (rm) {
         case 0:
@@ -1218,6 +1360,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 
     case OPC_RISC_FCVT_W_D:
         /* also OPC_RISC_FCVT_WU_D, OPC_RISC_FCVT_L_D, OPC_RISC_FCVT_LU_D */
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         t0 = tcg_temp_new();
         switch (rs2) {
         case 0:
@@ -1248,6 +1393,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 
     case OPC_RISC_FCVT_D_W:
         /* also OPC_RISC_FCVT_D_WU, OPC_RISC_FCVT_D_L, OPC_RISC_FCVT_D_LU */
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         t0 = tcg_temp_new();
         gen_get_gpr(t0, rs1);
         switch (rs2) {
@@ -1278,6 +1426,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 #if defined(TARGET_RISCV64)
     case OPC_RISC_FMV_X_D:
         /* also OPC_RISC_FCLASS_D */
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         switch (rm) {
         case 0: /* FMV */
             gen_set_gpr(rd, cpu_fpr[rs1]);
@@ -1295,6 +1446,9 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         break;
 
     case OPC_RISC_FMV_D_X:
+        if (!has_ext(ctx, RVD)) {
+            goto do_illegal;
+        }
         t0 = tcg_temp_new();
         gen_get_gpr(t0, rs1);
         tcg_gen_mov_tl(cpu_fpr[rd], t0);
@@ -1786,6 +1940,9 @@ static void decode_RV32_64G(DisasContext *ctx)
                      GET_STORE_IMM(ctx->opcode));
         break;
     case OPC_RISC_ATOMIC:
+        if (!has_ext(ctx, RVA)) {
+            goto do_illegal;
+        }
         gen_atomic(ctx, MASK_OP_ATOMIC(ctx->opcode), rd, rs1, rs2);
         break;
     case OPC_RISC_FMADD:
@@ -1826,6 +1983,7 @@ static void decode_RV32_64G(DisasContext *ctx)
         gen_system(ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
                    (ctx->opcode & 0xFFF00000) >> 20);
         break;
+    do_illegal:
     default:
         gen_exception_illegal(ctx);
         break;
-- 
2.7.0
