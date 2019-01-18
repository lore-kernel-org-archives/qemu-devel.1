Received: from eggs.gnu.org ([209.51.188.92]:41987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gkU04-0004x6-JU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gkU01-0007TU-CC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:15:56 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 18 Jan 2019 14:14:36 +0100
Message-Id: <20190118131456.32451-16-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 15/35] target/riscv: Convert RV64D insns to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com, kbastian@mail.uni-paderborn.de
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, richard.henderson@linaro.org, qemu-devel@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32-64.decode           |   8 +
 target/riscv/insn_trans/trans_rvd.inc.c |  73 ++++
 target/riscv/translate.c                | 487 +-----------------------
 3 files changed, 82 insertions(+), 486 deletions(-)

diff --git a/target/riscv/insn32-64.decode b/target/riscv/insn32-64.decode
index 6319f872ac..380bf791bc 100644
--- a/target/riscv/insn32-64.decode
+++ b/target/riscv/insn32-64.decode
@@ -62,3 +62,11 @@ fcvt_l_s   1100000  00010 ..... ... ..... 1010011 @r2_rm
 fcvt_lu_s  1100000  00011 ..... ... ..... 1010011 @r2_rm
 fcvt_s_l   1101000  00010 ..... ... ..... 1010011 @r2_rm
 fcvt_s_lu  1101000  00011 ..... ... ..... 1010011 @r2_rm
+
+# *** RV64D Standard Extension (in addition to RV32D) ***
+fcvt_l_d   1100001  00010 ..... ... ..... 1010011 @r2_rm
+fcvt_lu_d  1100001  00011 ..... ... ..... 1010011 @r2_rm
+fmv_x_d    1110001  00000 ..... 000 ..... 1010011 @r2
+fcvt_d_l   1101001  00010 ..... ... ..... 1010011 @r2_rm
+fcvt_d_lu  1101001  00011 ..... ... ..... 1010011 @r2_rm
+fmv_d_x    1111001  00000 ..... 000 ..... 1010011 @r2
diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index a7e2335ffa..2e45c8ed7e 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -313,3 +313,76 @@ static bool trans_fcvt_d_wu(DisasContext *ctx, arg_fcvt_d_wu *a)
 
     return true;
 }
+
+#ifdef TARGET_RISCV64
+
+static bool trans_fcvt_l_d(DisasContext *ctx, arg_fcvt_l_d *a)
+{
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_l_d(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fcvt_lu_d(DisasContext *ctx, arg_fcvt_lu_d *a)
+{
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_lu_d(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fmv_x_d(DisasContext *ctx, arg_fmv_x_d *a)
+{
+    REQUIRE_FPU;
+
+    gen_set_gpr(a->rd, cpu_fpr[a->rs1]);
+    return true;
+}
+
+static bool trans_fcvt_d_l(DisasContext *ctx, arg_fcvt_d_l *a)
+{
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_d_l(cpu_fpr[a->rd], cpu_env, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fcvt_d_lu(DisasContext *ctx, arg_fcvt_d_lu *a)
+{
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_d_lu(cpu_fpr[a->rd], cpu_env, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fmv_d_x(DisasContext *ctx, arg_fmv_d_x *a)
+{
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    tcg_gen_mov_tl(cpu_fpr[a->rd], t0);
+    tcg_temp_free(t0);
+    return true;
+}
+#endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 7f3443db20..4dda78d7c1 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -180,44 +180,6 @@ static void gen_mulhsu(TCGv ret, TCGv arg1, TCGv arg2)
     tcg_temp_free(rh);
 }
 
-static void gen_fsgnj(DisasContext *ctx, uint32_t rd, uint32_t rs1,
-    uint32_t rs2, int rm, uint64_t min)
-{
-    switch (rm) {
-    case 0: /* fsgnj */
-        if (rs1 == rs2) { /* FMOV */
-            tcg_gen_mov_i64(cpu_fpr[rd], cpu_fpr[rs1]);
-        } else {
-            tcg_gen_deposit_i64(cpu_fpr[rd], cpu_fpr[rs2], cpu_fpr[rs1],
-                                0, min == INT32_MIN ? 31 : 63);
-        }
-        break;
-    case 1: /* fsgnjn */
-        if (rs1 == rs2) { /* FNEG */
-            tcg_gen_xori_i64(cpu_fpr[rd], cpu_fpr[rs1], min);
-        } else {
-            TCGv_i64 t0 = tcg_temp_new_i64();
-            tcg_gen_not_i64(t0, cpu_fpr[rs2]);
-            tcg_gen_deposit_i64(cpu_fpr[rd], t0, cpu_fpr[rs1],
-                                0, min == INT32_MIN ? 31 : 63);
-            tcg_temp_free_i64(t0);
-        }
-        break;
-    case 2: /* fsgnjx */
-        if (rs1 == rs2) { /* FABS */
-            tcg_gen_andi_i64(cpu_fpr[rd], cpu_fpr[rs1], ~min);
-        } else {
-            TCGv_i64 t0 = tcg_temp_new_i64();
-            tcg_gen_andi_i64(t0, cpu_fpr[rs2], min);
-            tcg_gen_xor_i64(cpu_fpr[rd], cpu_fpr[rs1], t0);
-            tcg_temp_free_i64(t0);
-        }
-        break;
-    default:
-        gen_exception_illegal(ctx);
-    }
-}
-
 static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
         int rs2)
 {
@@ -724,421 +686,6 @@ static void gen_set_rm(DisasContext *ctx, int rm)
     tcg_temp_free_i32(t0);
 }
 
-static void gen_fp_fmadd(DisasContext *ctx, uint32_t opc, int rd,
-                         int rs1, int rs2, int rs3, int rm)
-{
-    switch (opc) {
-    case OPC_RISC_FMADD_S:
-        gen_set_rm(ctx, rm);
-        gen_helper_fmadd_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
-                           cpu_fpr[rs2], cpu_fpr[rs3]);
-        break;
-    case OPC_RISC_FMADD_D:
-        gen_set_rm(ctx, rm);
-        gen_helper_fmadd_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
-                           cpu_fpr[rs2], cpu_fpr[rs3]);
-        break;
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-}
-
-static void gen_fp_fmsub(DisasContext *ctx, uint32_t opc, int rd,
-                         int rs1, int rs2, int rs3, int rm)
-{
-    switch (opc) {
-    case OPC_RISC_FMSUB_S:
-        gen_set_rm(ctx, rm);
-        gen_helper_fmsub_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
-                           cpu_fpr[rs2], cpu_fpr[rs3]);
-        break;
-    case OPC_RISC_FMSUB_D:
-        gen_set_rm(ctx, rm);
-        gen_helper_fmsub_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
-                           cpu_fpr[rs2], cpu_fpr[rs3]);
-        break;
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-}
-
-static void gen_fp_fnmsub(DisasContext *ctx, uint32_t opc, int rd,
-                          int rs1, int rs2, int rs3, int rm)
-{
-    switch (opc) {
-    case OPC_RISC_FNMSUB_S:
-        gen_set_rm(ctx, rm);
-        gen_helper_fnmsub_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
-                            cpu_fpr[rs2], cpu_fpr[rs3]);
-        break;
-    case OPC_RISC_FNMSUB_D:
-        gen_set_rm(ctx, rm);
-        gen_helper_fnmsub_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
-                            cpu_fpr[rs2], cpu_fpr[rs3]);
-        break;
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-}
-
-static void gen_fp_fnmadd(DisasContext *ctx, uint32_t opc, int rd,
-                          int rs1, int rs2, int rs3, int rm)
-{
-    switch (opc) {
-    case OPC_RISC_FNMADD_S:
-        gen_set_rm(ctx, rm);
-        gen_helper_fnmadd_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
-                            cpu_fpr[rs2], cpu_fpr[rs3]);
-        break;
-    case OPC_RISC_FNMADD_D:
-        gen_set_rm(ctx, rm);
-        gen_helper_fnmadd_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1],
-                            cpu_fpr[rs2], cpu_fpr[rs3]);
-        break;
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-}
-
-static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
-                         int rs1, int rs2, int rm)
-{
-    TCGv t0 = NULL;
-
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
-        goto do_illegal;
-    }
-
-    switch (opc) {
-    case OPC_RISC_FADD_S:
-        gen_set_rm(ctx, rm);
-        gen_helper_fadd_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-        break;
-    case OPC_RISC_FSUB_S:
-        gen_set_rm(ctx, rm);
-        gen_helper_fsub_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-        break;
-    case OPC_RISC_FMUL_S:
-        gen_set_rm(ctx, rm);
-        gen_helper_fmul_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-        break;
-    case OPC_RISC_FDIV_S:
-        gen_set_rm(ctx, rm);
-        gen_helper_fdiv_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-        break;
-    case OPC_RISC_FSQRT_S:
-        gen_set_rm(ctx, rm);
-        gen_helper_fsqrt_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1]);
-        break;
-    case OPC_RISC_FSGNJ_S:
-        gen_fsgnj(ctx, rd, rs1, rs2, rm, INT32_MIN);
-        break;
-
-    case OPC_RISC_FMIN_S:
-        /* also handles: OPC_RISC_FMAX_S */
-        switch (rm) {
-        case 0x0:
-            gen_helper_fmin_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-            break;
-        case 0x1:
-            gen_helper_fmax_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-            break;
-        default:
-            goto do_illegal;
-        }
-        break;
-
-    case OPC_RISC_FEQ_S:
-        /* also handles: OPC_RISC_FLT_S, OPC_RISC_FLE_S */
-        t0 = tcg_temp_new();
-        switch (rm) {
-        case 0x0:
-            gen_helper_fle_s(t0, cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-            break;
-        case 0x1:
-            gen_helper_flt_s(t0, cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-            break;
-        case 0x2:
-            gen_helper_feq_s(t0, cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-            break;
-        default:
-            goto do_illegal;
-        }
-        gen_set_gpr(rd, t0);
-        tcg_temp_free(t0);
-        break;
-
-    case OPC_RISC_FCVT_W_S:
-        /* also OPC_RISC_FCVT_WU_S, OPC_RISC_FCVT_L_S, OPC_RISC_FCVT_LU_S */
-        t0 = tcg_temp_new();
-        switch (rs2) {
-        case 0: /* FCVT_W_S */
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_w_s(t0, cpu_env, cpu_fpr[rs1]);
-            break;
-        case 1: /* FCVT_WU_S */
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_wu_s(t0, cpu_env, cpu_fpr[rs1]);
-            break;
-#if defined(TARGET_RISCV64)
-        case 2: /* FCVT_L_S */
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[rs1]);
-            break;
-        case 3: /* FCVT_LU_S */
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_lu_s(t0, cpu_env, cpu_fpr[rs1]);
-            break;
-#endif
-        default:
-            goto do_illegal;
-        }
-        gen_set_gpr(rd, t0);
-        tcg_temp_free(t0);
-        break;
-
-    case OPC_RISC_FCVT_S_W:
-        /* also OPC_RISC_FCVT_S_WU, OPC_RISC_FCVT_S_L, OPC_RISC_FCVT_S_LU */
-        t0 = tcg_temp_new();
-        gen_get_gpr(t0, rs1);
-        switch (rs2) {
-        case 0: /* FCVT_S_W */
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_s_w(cpu_fpr[rd], cpu_env, t0);
-            break;
-        case 1: /* FCVT_S_WU */
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_s_wu(cpu_fpr[rd], cpu_env, t0);
-            break;
-#if defined(TARGET_RISCV64)
-        case 2: /* FCVT_S_L */
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_s_l(cpu_fpr[rd], cpu_env, t0);
-            break;
-        case 3: /* FCVT_S_LU */
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_s_lu(cpu_fpr[rd], cpu_env, t0);
-            break;
-#endif
-        default:
-            goto do_illegal;
-        }
-        tcg_temp_free(t0);
-        break;
-
-    case OPC_RISC_FMV_X_S:
-        /* also OPC_RISC_FCLASS_S */
-        t0 = tcg_temp_new();
-        switch (rm) {
-        case 0: /* FMV */
-#if defined(TARGET_RISCV64)
-            tcg_gen_ext32s_tl(t0, cpu_fpr[rs1]);
-#else
-            tcg_gen_extrl_i64_i32(t0, cpu_fpr[rs1]);
-#endif
-            break;
-        case 1:
-            gen_helper_fclass_s(t0, cpu_fpr[rs1]);
-            break;
-        default:
-            goto do_illegal;
-        }
-        gen_set_gpr(rd, t0);
-        tcg_temp_free(t0);
-        break;
-
-    case OPC_RISC_FMV_S_X:
-        t0 = tcg_temp_new();
-        gen_get_gpr(t0, rs1);
-#if defined(TARGET_RISCV64)
-        tcg_gen_mov_i64(cpu_fpr[rd], t0);
-#else
-        tcg_gen_extu_i32_i64(cpu_fpr[rd], t0);
-#endif
-        tcg_temp_free(t0);
-        break;
-
-    /* double */
-    case OPC_RISC_FADD_D:
-        gen_set_rm(ctx, rm);
-        gen_helper_fadd_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-        break;
-    case OPC_RISC_FSUB_D:
-        gen_set_rm(ctx, rm);
-        gen_helper_fsub_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-        break;
-    case OPC_RISC_FMUL_D:
-        gen_set_rm(ctx, rm);
-        gen_helper_fmul_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-        break;
-    case OPC_RISC_FDIV_D:
-        gen_set_rm(ctx, rm);
-        gen_helper_fdiv_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-        break;
-    case OPC_RISC_FSQRT_D:
-        gen_set_rm(ctx, rm);
-        gen_helper_fsqrt_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1]);
-        break;
-    case OPC_RISC_FSGNJ_D:
-        gen_fsgnj(ctx, rd, rs1, rs2, rm, INT64_MIN);
-        break;
-
-    case OPC_RISC_FMIN_D:
-        /* also OPC_RISC_FMAX_D */
-        switch (rm) {
-        case 0:
-            gen_helper_fmin_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-            break;
-        case 1:
-            gen_helper_fmax_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-            break;
-        default:
-            goto do_illegal;
-        }
-        break;
-
-    case OPC_RISC_FCVT_S_D:
-        switch (rs2) {
-        case 1:
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_s_d(cpu_fpr[rd], cpu_env, cpu_fpr[rs1]);
-            break;
-        default:
-            goto do_illegal;
-        }
-        break;
-
-    case OPC_RISC_FCVT_D_S:
-        switch (rs2) {
-        case 0:
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_d_s(cpu_fpr[rd], cpu_env, cpu_fpr[rs1]);
-            break;
-        default:
-            goto do_illegal;
-        }
-        break;
-
-    case OPC_RISC_FEQ_D:
-        /* also OPC_RISC_FLT_D, OPC_RISC_FLE_D */
-        t0 = tcg_temp_new();
-        switch (rm) {
-        case 0:
-            gen_helper_fle_d(t0, cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-            break;
-        case 1:
-            gen_helper_flt_d(t0, cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-            break;
-        case 2:
-            gen_helper_feq_d(t0, cpu_env, cpu_fpr[rs1], cpu_fpr[rs2]);
-            break;
-        default:
-            goto do_illegal;
-        }
-        gen_set_gpr(rd, t0);
-        tcg_temp_free(t0);
-        break;
-
-    case OPC_RISC_FCVT_W_D:
-        /* also OPC_RISC_FCVT_WU_D, OPC_RISC_FCVT_L_D, OPC_RISC_FCVT_LU_D */
-        t0 = tcg_temp_new();
-        switch (rs2) {
-        case 0:
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_w_d(t0, cpu_env, cpu_fpr[rs1]);
-            break;
-        case 1:
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_wu_d(t0, cpu_env, cpu_fpr[rs1]);
-            break;
-#if defined(TARGET_RISCV64)
-        case 2:
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_l_d(t0, cpu_env, cpu_fpr[rs1]);
-            break;
-        case 3:
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_lu_d(t0, cpu_env, cpu_fpr[rs1]);
-            break;
-#endif
-        default:
-            goto do_illegal;
-        }
-        gen_set_gpr(rd, t0);
-        tcg_temp_free(t0);
-        break;
-
-    case OPC_RISC_FCVT_D_W:
-        /* also OPC_RISC_FCVT_D_WU, OPC_RISC_FCVT_D_L, OPC_RISC_FCVT_D_LU */
-        t0 = tcg_temp_new();
-        gen_get_gpr(t0, rs1);
-        switch (rs2) {
-        case 0:
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_d_w(cpu_fpr[rd], cpu_env, t0);
-            break;
-        case 1:
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_d_wu(cpu_fpr[rd], cpu_env, t0);
-            break;
-#if defined(TARGET_RISCV64)
-        case 2:
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_d_l(cpu_fpr[rd], cpu_env, t0);
-            break;
-        case 3:
-            gen_set_rm(ctx, rm);
-            gen_helper_fcvt_d_lu(cpu_fpr[rd], cpu_env, t0);
-            break;
-#endif
-        default:
-            goto do_illegal;
-        }
-        tcg_temp_free(t0);
-        break;
-
-    case OPC_RISC_FMV_X_D:
-        /* also OPC_RISC_FCLASS_D */
-        switch (rm) {
-#if defined(TARGET_RISCV64)
-        case 0: /* FMV */
-            gen_set_gpr(rd, cpu_fpr[rs1]);
-            break;
-#endif
-        case 1:
-            t0 = tcg_temp_new();
-            gen_helper_fclass_d(t0, cpu_fpr[rs1]);
-            gen_set_gpr(rd, t0);
-            tcg_temp_free(t0);
-            break;
-        default:
-            goto do_illegal;
-        }
-        break;
-
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_FMV_D_X:
-        t0 = tcg_temp_new();
-        gen_get_gpr(t0, rs1);
-        tcg_gen_mov_tl(cpu_fpr[rd], t0);
-        tcg_temp_free(t0);
-        break;
-#endif
-
-    default:
-    do_illegal:
-        if (t0) {
-            tcg_temp_free(t0);
-        }
-        gen_exception_illegal(ctx);
-        break;
-    }
-}
-
 static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
                       int rd, int rs1, int csr)
 {
@@ -1519,11 +1066,8 @@ bool decode_insn32(DisasContext *ctx, uint32_t insn);
 
 static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
 {
-    int rs1;
-    int rs2;
-    int rd;
+    int rs1, rd;
     uint32_t op;
-    target_long imm;
 
     /* We do not do misaligned address check here: the address should never be
      * misaligned at this point. Instructions that set PC must do the check,
@@ -1532,38 +1076,9 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
 
     op = MASK_OP_MAJOR(ctx->opcode);
     rs1 = GET_RS1(ctx->opcode);
-    rs2 = GET_RS2(ctx->opcode);
     rd = GET_RD(ctx->opcode);
-    imm = GET_IMM(ctx->opcode);
 
     switch (op) {
-    case OPC_RISC_FP_LOAD:
-        gen_fp_load(ctx, MASK_OP_FP_LOAD(ctx->opcode), rd, rs1, imm);
-        break;
-    case OPC_RISC_FP_STORE:
-        gen_fp_store(ctx, MASK_OP_FP_STORE(ctx->opcode), rs1, rs2,
-                     GET_STORE_IMM(ctx->opcode));
-        break;
-    case OPC_RISC_FMADD:
-        gen_fp_fmadd(ctx, MASK_OP_FP_FMADD(ctx->opcode), rd, rs1, rs2,
-                     GET_RS3(ctx->opcode), GET_RM(ctx->opcode));
-        break;
-    case OPC_RISC_FMSUB:
-        gen_fp_fmsub(ctx, MASK_OP_FP_FMSUB(ctx->opcode), rd, rs1, rs2,
-                     GET_RS3(ctx->opcode), GET_RM(ctx->opcode));
-        break;
-    case OPC_RISC_FNMSUB:
-        gen_fp_fnmsub(ctx, MASK_OP_FP_FNMSUB(ctx->opcode), rd, rs1, rs2,
-                      GET_RS3(ctx->opcode), GET_RM(ctx->opcode));
-        break;
-    case OPC_RISC_FNMADD:
-        gen_fp_fnmadd(ctx, MASK_OP_FP_FNMADD(ctx->opcode), rd, rs1, rs2,
-                      GET_RS3(ctx->opcode), GET_RM(ctx->opcode));
-        break;
-    case OPC_RISC_FP_ARITH:
-        gen_fp_arith(ctx, MASK_OP_FP_ARITH(ctx->opcode), rd, rs1, rs2,
-                     GET_RM(ctx->opcode));
-        break;
     case OPC_RISC_SYSTEM:
         gen_system(env, ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
                    (ctx->opcode & 0xFFF00000) >> 20);
-- 
2.20.1
