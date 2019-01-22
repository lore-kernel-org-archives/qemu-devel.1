Received: from eggs.gnu.org ([209.51.188.92]:59571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glsVc-0006XP-Iq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glsO4-0005UX-CJ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:30:31 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue, 22 Jan 2019 10:28:46 +0100
Message-Id: <20190122092909.5341-13-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
References: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 12/35] target/riscv: Convert RV32F insns to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode              |  35 +++
 target/riscv/insn_trans/trans_rvf.inc.c | 334 ++++++++++++++++++++++++
 target/riscv/translate.c                |   1 +
 3 files changed, 370 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvf.inc.c

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 00b9e2d9a5..e40836bf03 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -17,12 +17,14 @@
 # this program.  If not, see <http://www.gnu.org/licenses/>.
 
 # Fields:
+%rs3       27:5
 %rs2       20:5
 %rs1       15:5
 %rd        7:5
 
 %sh10    20:10
 %csr    20:12
+%rm     12:3
 
 # immediates:
 %imm_i    20:s12
@@ -50,6 +52,11 @@
 @atom_ld ..... aq:1 rl:1 ..... ........ ..... ....... &atomic rs2=0     %rs1 %rd
 @atom_st ..... aq:1 rl:1 ..... ........ ..... ....... &atomic %rs2      %rs1 %rd
 
+@r4_rm   ..... ..  ..... ..... ... ..... ....... %rs3 %rs2 %rs1 %rm %rd
+@r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
+@r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
+@r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
 auipc    ....................       ..... 0010111 @u
@@ -119,3 +126,31 @@ amomin_w   10000 . . ..... ..... 010 ..... 0101111 @atom_st
 amomax_w   10100 . . ..... ..... 010 ..... 0101111 @atom_st
 amominu_w  11000 . . ..... ..... 010 ..... 0101111 @atom_st
 amomaxu_w  11100 . . ..... ..... 010 ..... 0101111 @atom_st
+
+# *** RV32F Standard Extension ***
+flw        ............   ..... 010 ..... 0000111 @i
+fsw        .......  ..... ..... 010 ..... 0100111 @s
+fmadd_s    ..... 00 ..... ..... ... ..... 1000011 @r4_rm
+fmsub_s    ..... 00 ..... ..... ... ..... 1000111 @r4_rm
+fnmsub_s   ..... 00 ..... ..... ... ..... 1001011 @r4_rm
+fnmadd_s   ..... 00 ..... ..... ... ..... 1001111 @r4_rm
+fadd_s     0000000  ..... ..... ... ..... 1010011 @r_rm
+fsub_s     0000100  ..... ..... ... ..... 1010011 @r_rm
+fmul_s     0001000  ..... ..... ... ..... 1010011 @r_rm
+fdiv_s     0001100  ..... ..... ... ..... 1010011 @r_rm
+fsqrt_s    0101100  00000 ..... ... ..... 1010011 @r2_rm
+fsgnj_s    0010000  ..... ..... 000 ..... 1010011 @r
+fsgnjn_s   0010000  ..... ..... 001 ..... 1010011 @r
+fsgnjx_s   0010000  ..... ..... 010 ..... 1010011 @r
+fmin_s     0010100  ..... ..... 000 ..... 1010011 @r
+fmax_s     0010100  ..... ..... 001 ..... 1010011 @r
+fcvt_w_s   1100000  00000 ..... ... ..... 1010011 @r2_rm
+fcvt_wu_s  1100000  00001 ..... ... ..... 1010011 @r2_rm
+fmv_x_w    1110000  00000 ..... 000 ..... 1010011 @r2
+feq_s      1010000  ..... ..... 010 ..... 1010011 @r
+flt_s      1010000  ..... ..... 001 ..... 1010011 @r
+fle_s      1010000  ..... ..... 000 ..... 1010011 @r
+fclass_s   1110000  00000 ..... 001 ..... 1010011 @r2
+fcvt_s_w   1101000  00000 ..... ... ..... 1010011 @r2_rm
+fcvt_s_wu  1101000  00001 ..... ... ..... 1010011 @r2_rm
+fmv_w_x    1111000  00000 ..... 000 ..... 1010011 @r2
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
new file mode 100644
index 0000000000..b101593ac4
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -0,0 +1,334 @@
+/*
+ * RISC-V translation routines for the RV64F Standard Extension.
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
+ *                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_FPU do {\
+    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) \
+        return false;                       \
+} while (0)
+
+static bool trans_flw(DisasContext *ctx, arg_flw *a)
+{
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+    REQUIRE_FPU;
+    tcg_gen_addi_tl(t0, t0, a->imm);
+
+    tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
+    /* RISC-V requires NaN-boxing of narrower width floating point values */
+    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
+
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
+{
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    REQUIRE_FPU;
+    tcg_gen_addi_tl(t0, t0, a->imm);
+
+    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUL);
+
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fmadd_s(DisasContext *ctx, arg_fmadd_s *a)
+{
+    REQUIRE_FPU;
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    return true;
+}
+
+static bool trans_fmsub_s(DisasContext *ctx, arg_fmsub_s *a)
+{
+    REQUIRE_FPU;
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fmsub_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    return true;
+}
+
+static bool trans_fnmsub_s(DisasContext *ctx, arg_fnmsub_s *a)
+{
+    REQUIRE_FPU;
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fnmsub_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    return true;
+}
+
+static bool trans_fnmadd_s(DisasContext *ctx, arg_fnmadd_s *a)
+{
+    REQUIRE_FPU;
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fnmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    return true;
+}
+
+static bool trans_fadd_s(DisasContext *ctx, arg_fadd_s *a)
+{
+    REQUIRE_FPU;
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fadd_s(cpu_fpr[a->rd], cpu_env,
+                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    return true;
+}
+
+static bool trans_fsub_s(DisasContext *ctx, arg_fsub_s *a)
+{
+    REQUIRE_FPU;
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fsub_s(cpu_fpr[a->rd], cpu_env,
+                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    return true;
+}
+
+static bool trans_fmul_s(DisasContext *ctx, arg_fmul_s *a)
+{
+    REQUIRE_FPU;
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fmul_s(cpu_fpr[a->rd], cpu_env,
+                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    return true;
+}
+
+static bool trans_fdiv_s(DisasContext *ctx, arg_fdiv_s *a)
+{
+    REQUIRE_FPU;
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fdiv_s(cpu_fpr[a->rd], cpu_env,
+                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    return true;
+}
+
+static bool trans_fsqrt_s(DisasContext *ctx, arg_fsqrt_s *a)
+{
+    REQUIRE_FPU;
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fsqrt_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
+    return true;
+}
+
+static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a)
+{
+    REQUIRE_FPU;
+    if (a->rs1 == a->rs2) { /* FMOV */
+        tcg_gen_mov_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
+    } else { /* FSGNJ */
+        tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2], cpu_fpr[a->rs1],
+                            0, 31);
+    }
+    return true;
+}
+
+static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
+{
+    REQUIRE_FPU;
+    if (a->rs1 == a->rs2) { /* FNEG */
+        tcg_gen_xori_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], INT32_MIN);
+    } else {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        tcg_gen_not_i64(t0, cpu_fpr[a->rs2]);
+        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
+        tcg_temp_free_i64(t0);
+    }
+    return true;
+}
+
+static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
+{
+    REQUIRE_FPU;
+    if (a->rs1 == a->rs2) { /* FABS */
+        tcg_gen_andi_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], ~INT32_MIN);
+    } else {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        tcg_gen_andi_i64(t0, cpu_fpr[a->rs2], INT32_MIN);
+        tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
+        tcg_temp_free_i64(t0);
+    }
+    return true;
+}
+
+static bool trans_fmin_s(DisasContext *ctx, arg_fmin_s *a)
+{
+    REQUIRE_FPU;
+
+    gen_helper_fmin_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                      cpu_fpr[a->rs2]);
+    return true;
+}
+
+static bool trans_fmax_s(DisasContext *ctx, arg_fmax_s *a)
+{
+    REQUIRE_FPU;
+
+    gen_helper_fmax_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                      cpu_fpr[a->rs2]);
+    return true;
+}
+
+static bool trans_fcvt_w_s(DisasContext *ctx, arg_fcvt_w_s *a)
+{
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_w_s(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fcvt_wu_s(DisasContext *ctx, arg_fcvt_wu_s *a)
+{
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_wu_s(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fmv_x_w(DisasContext *ctx, arg_fmv_x_w *a)
+{
+    /* NOTE: This was FMV.X.S in an earlier version of the ISA spec! */
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+
+#if defined(TARGET_RISCV64)
+    tcg_gen_ext32s_tl(t0, cpu_fpr[a->rs1]);
+#else
+    tcg_gen_extrl_i64_i32(t0, cpu_fpr[a->rs1]);
+#endif
+
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_feq_s(DisasContext *ctx, arg_feq_s *a)
+{
+    REQUIRE_FPU;
+    TCGv t0 = tcg_temp_new();
+    gen_helper_feq_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_flt_s(DisasContext *ctx, arg_flt_s *a)
+{
+    REQUIRE_FPU;
+    TCGv t0 = tcg_temp_new();
+    gen_helper_flt_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fle_s(DisasContext *ctx, arg_fle_s *a)
+{
+    REQUIRE_FPU;
+    TCGv t0 = tcg_temp_new();
+    gen_helper_fle_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fclass_s(DisasContext *ctx, arg_fclass_s *a)
+{
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+
+    gen_helper_fclass_s(t0, cpu_fpr[a->rs1]);
+
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fcvt_s_w(DisasContext *ctx, arg_fcvt_s_w *a)
+{
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_s_w(cpu_fpr[a->rd], cpu_env, t0);
+
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fcvt_s_wu(DisasContext *ctx, arg_fcvt_s_wu *a)
+{
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_s_wu(cpu_fpr[a->rd], cpu_env, t0);
+
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
+{
+    /* NOTE: This was FMV.S.X in an earlier version of the ISA spec! */
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+#if defined(TARGET_RISCV64)
+    tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
+#else
+    tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
+#endif
+
+    tcg_temp_free(t0);
+
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 944836dd7c..933ca9fb69 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1514,6 +1514,7 @@ bool decode_insn32(DisasContext *ctx, uint32_t insn);
 #include "insn_trans/trans_rvi.inc.c"
 #include "insn_trans/trans_rvm.inc.c"
 #include "insn_trans/trans_rva.inc.c"
+#include "insn_trans/trans_rvf.inc.c"
 
 static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
 {
-- 
2.20.1
