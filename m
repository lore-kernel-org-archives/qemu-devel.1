Received: from eggs.gnu.org ([2001:4830:134:3::10]:54254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEvR8-00064C-Ml
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEvQs-0007cy-BH
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:24 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEvQr-0007YA-1e
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id d10-v6so1414164wrs.5
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 05:05:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 13:04:50 +0100
Message-Id: <20181023120454.28553-4-richard.henderson@linaro.org>
In-Reply-To: <20181023120454.28553-1-richard.henderson@linaro.org>
References: <20181023120454.28553-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/7] target/riscv: Update for decodetree insn
 argument change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, sagark@eecs.berkeley.edu, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

??? Should be merged back into previous patches.
??? Additional changes required for compact mode.
---
 .../riscv/insn_trans/trans_privileged.inc.c   |  19 ++-
 target/riscv/insn_trans/trans_rva.inc.c       |  44 +++---
 target/riscv/insn_trans/trans_rvc.inc.c       | 148 +++++++++---------
 target/riscv/insn_trans/trans_rvd.inc.c       |  64 ++++----
 target/riscv/insn_trans/trans_rvf.inc.c       |  60 +++----
 target/riscv/insn_trans/trans_rvi.inc.c       | 114 +++++++-------
 target/riscv/insn_trans/trans_rvm.inc.c       |  26 +--
 7 files changed, 234 insertions(+), 241 deletions(-)

diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index 9534adb025..999e7f0f9e 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -18,7 +18,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-static bool trans_ecall(DisasContext *ctx, arg_ecall *a, uint32_t insn)
+static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 {
     /* always generates U-level ECALL, fixed in do_interrupt handler */
     generate_exception(ctx, RISCV_EXCP_U_ECALL);
@@ -27,7 +27,7 @@ static bool trans_ecall(DisasContext *ctx, arg_ecall *a, uint32_t insn)
     return true;
 }
 
-static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a, uint32_t insn)
+static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
 {
     generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
     tcg_gen_exit_tb(NULL, 0); /* no chaining */
@@ -35,13 +35,13 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a, uint32_t insn)
     return true;
 }
 
-static bool trans_uret(DisasContext *ctx, arg_uret *a, uint32_t insn)
+static bool trans_uret(DisasContext *ctx, arg_uret *a)
 {
     gen_exception_illegal(ctx);
     return true;
 }
 
-static bool trans_sret(DisasContext *ctx, arg_sret *a, uint32_t insn)
+static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
 #ifndef CONFIG_USER_ONLY
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
@@ -59,13 +59,13 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a, uint32_t insn)
 #endif
 }
 
-static bool trans_hret(DisasContext *ctx, arg_hret *a, uint32_t insn)
+static bool trans_hret(DisasContext *ctx, arg_hret *a)
 {
     gen_exception_illegal(ctx);
     return true;
 }
 
-static bool trans_mret(DisasContext *ctx, arg_mret *a, uint32_t insn)
+static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
@@ -78,7 +78,7 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a, uint32_t insn)
 #endif
 }
 
-static bool trans_wfi(DisasContext *ctx, arg_wfi *a, uint32_t insn)
+static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 {
 #ifndef CONFIG_USER_ONLY
     tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
@@ -89,8 +89,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a, uint32_t insn)
 #endif
 }
 
-static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a,
-                             uint32_t insn)
+static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 {
 #ifndef CONFIG_USER_ONLY
     gen_helper_tlb_flush(cpu_env);
@@ -100,7 +99,7 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a,
 #endif
 }
 
-static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a, uint32_t insn)
+static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
 {
 #ifndef CONFIG_USER_ONLY
     gen_helper_tlb_flush(cpu_env);
diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
index 7e368dc321..e658bf32c4 100644
--- a/target/riscv/insn_trans/trans_rva.inc.c
+++ b/target/riscv/insn_trans/trans_rva.inc.c
@@ -89,62 +89,62 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     return true;
 }
 
-static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a, uint32_t insn)
+static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
 {
     return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a, uint32_t insn)
+static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 {
     return gen_sc(ctx, a, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a, uint32_t insn)
+static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a, uint32_t insn)
+static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a, uint32_t insn)
+static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
 {
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a, uint32_t insn)
+static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
 {
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a, uint32_t insn)
+static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
 {
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a, uint32_t insn)
+static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
 {
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a, uint32_t insn)
+static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
 {
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a, uint32_t insn)
+static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
 {
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a, uint32_t insn)
+static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 {
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESL));
 }
 
-static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a, uint32_t insn)
+static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_lr(ctx, a, MO_ALIGN | MO_TEQ);
@@ -153,7 +153,7 @@ static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a, uint32_t insn)
 #endif
 }
 
-static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a, uint32_t insn)
+static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_sc(ctx, a, (MO_ALIGN | MO_TEQ));
@@ -162,7 +162,7 @@ static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a, uint32_t insn)
 #endif
 }
 
-static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a, uint32_t insn)
+static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEQ));
@@ -171,7 +171,7 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a, uint32_t insn)
 #endif
 }
 
-static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a, uint32_t insn)
+static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEQ));
@@ -180,7 +180,7 @@ static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a, uint32_t insn)
 #endif
 }
 
-static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a, uint32_t insn)
+static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEQ));
@@ -189,7 +189,7 @@ static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a, uint32_t insn)
 #endif
 }
 
-static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a, uint32_t insn)
+static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEQ));
@@ -198,7 +198,7 @@ static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a, uint32_t insn)
 #endif
 }
 
-static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a, uint32_t insn)
+static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEQ));
@@ -207,7 +207,7 @@ static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a, uint32_t insn)
 #endif
 }
 
-static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a, uint32_t insn)
+static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEQ));
@@ -216,7 +216,7 @@ static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a, uint32_t insn)
 #endif
 }
 
-static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a, uint32_t insn)
+static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEQ));
@@ -225,7 +225,7 @@ static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a, uint32_t insn)
 #endif
 }
 
-static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a, uint32_t insn)
+static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEQ));
@@ -234,7 +234,7 @@ static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a, uint32_t insn)
 #endif
 }
 
-static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a, uint32_t insn)
+static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
 {
 #ifdef TARGET_RISCV64
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEQ));
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index 593dfb82a3..7e2668c03d 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -18,30 +18,29 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a,
-        uint16_t insn)
+static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a)
 {
     if (a->nzuimm == 0) {
         /* Reserved in ISA */
         return false;
     }
     arg_addi arg = { .rd = a->rd, .rs1 = 2, .imm = a->nzuimm };
-    return trans_addi(ctx, &arg, insn);
+    return trans_addi(ctx, &arg);
 }
 
-static bool trans_c_fld(DisasContext *ctx, arg_c_fld *a, uint16_t insn)
+static bool trans_c_fld(DisasContext *ctx, arg_c_fld *a)
 {
     arg_fld arg = { .rd = a->rd, .rs1 = a->rs1, .imm = a->uimm };
-    return trans_fld(ctx, &arg, insn);
+    return trans_fld(ctx, &arg);
 }
 
-static bool trans_c_lw(DisasContext *ctx, arg_c_lw *a, uint16_t insn)
+static bool trans_c_lw(DisasContext *ctx, arg_c_lw *a)
 {
     arg_lw arg = { .rd = a->rd, .rs1 = a->rs1, .imm = a->uimm };
-    return trans_lw(ctx, &arg, insn);
+    return trans_lw(ctx, &arg);
 }
 
-static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a, uint16_t insn)
+static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
 {
 #ifdef TARGET_RISCV32
     /* C.FLW ( RV32FC-only ) */
@@ -52,25 +51,25 @@ static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a, uint16_t insn)
 #else
     /* C.LD ( RV64C/RV128C-only ) */
     arg_c_fld tmp;
-    extract_cl_d(&tmp, insn);
+    extract_cl_d(&tmp, 0); // FIXME
     arg_ld arg = { .rd = tmp.rd, .rs1 = tmp.rs1, .imm = tmp.uimm };
-    return trans_ld(ctx, &arg, insn);
+    return trans_ld(ctx, &arg);
 #endif
 }
 
-static bool trans_c_fsd(DisasContext *ctx, arg_c_fsd *a, uint16_t insn)
+static bool trans_c_fsd(DisasContext *ctx, arg_c_fsd *a)
 {
     arg_fsd arg = { .rs1 = a->rs1, .rs2 = a->rs2, .imm = a->uimm };
-    return trans_fsd(ctx, &arg, insn);
+    return trans_fsd(ctx, &arg);
 }
 
-static bool trans_c_sw(DisasContext *ctx, arg_c_sw *a, uint16_t insn)
+static bool trans_c_sw(DisasContext *ctx, arg_c_sw *a)
 {
     arg_sw arg = { .rs1 = a->rs1, .rs2 = a->rs2, .imm = a->uimm };
-    return trans_sw(ctx, &arg, insn);
+    return trans_sw(ctx, &arg);
 }
 
-static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a, uint16_t insn)
+static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
 {
 #ifdef TARGET_RISCV32
     /* C.FSW ( RV32FC-only ) */
@@ -81,24 +80,23 @@ static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a, uint16_t insn)
 #else
     /* C.SD ( RV64C/RV128C-only ) */
     arg_c_fsd tmp;
-    extract_cs_d(&tmp, insn);
+    extract_cs_d(&tmp, 0); // FIXME
     arg_sd arg = { .rs1 = tmp.rs1, .rs2 = tmp.rs2, .imm = tmp.uimm };
-    return trans_sd(ctx, &arg, insn);
+    return trans_sd(ctx, &arg);
 #endif
 }
 
-static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a, uint16_t insn)
+static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a)
 {
     if (a->imm == 0) {
         /* Hint: insn is valid but does not affect state */
         return true;
     }
     arg_addi arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
-    return trans_addi(ctx, &arg, insn);
+    return trans_addi(ctx, &arg);
 }
 
-static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a,
-        uint16_t insn)
+static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
 {
 #ifdef TARGET_RISCV32
     /* C.JAL */
@@ -107,27 +105,26 @@ static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a,
 #else
     /* C.ADDIW */
     arg_addiw arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
-    return trans_addiw(ctx, &arg, insn);
+    return trans_addiw(ctx, &arg);
 #endif
 }
 
-static bool trans_c_li(DisasContext *ctx, arg_c_li *a, uint16_t insn)
+static bool trans_c_li(DisasContext *ctx, arg_c_li *a)
 {
     if (a->rd == 0) {
         /* Hint: insn is valid but does not affect state */
         return true;
     }
     arg_addi arg = { .rd = a->rd, .rs1 = 0, .imm = a->imm };
-    return trans_addi(ctx, &arg, insn);
+    return trans_addi(ctx, &arg);
 }
 
-static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a,
-        uint16_t insn)
+static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a)
 {
     if (a->rd == 2) {
         /* C.ADDI16SP */
         arg_addi arg = { .rd = 2, .rs1 = 2, .imm = a->imm_addi16sp };
-        return trans_addi(ctx, &arg, insn);
+        return trans_addi(ctx, &arg);
     } else if (a->imm_lui != 0) {
         /* C.LUI */
         if (a->rd == 0) {
@@ -135,12 +132,12 @@ static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a,
             return true;
         }
         arg_lui arg = { .rd = a->rd, .imm = a->imm_lui };
-        return trans_lui(ctx, &arg, insn);
+        return trans_lui(ctx, &arg);
     }
     return false;
 }
 
-static bool trans_c_srli(DisasContext *ctx, arg_c_srli *a, uint16_t insn)
+static bool trans_c_srli(DisasContext *ctx, arg_c_srli *a)
 {
     int shamt = a->shamt;
     if (shamt == 0) {
@@ -153,10 +150,10 @@ static bool trans_c_srli(DisasContext *ctx, arg_c_srli *a, uint16_t insn)
     }
 
     arg_srli arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
-    return trans_srli(ctx, &arg, insn);
+    return trans_srli(ctx, &arg);
 }
 
-static bool trans_c_srai(DisasContext *ctx, arg_c_srai *a, uint16_t insn)
+static bool trans_c_srai(DisasContext *ctx, arg_c_srai *a)
 {
     if (a->shamt == 0) {
         /* Reserved in ISA */
@@ -170,70 +167,70 @@ static bool trans_c_srai(DisasContext *ctx, arg_c_srai *a, uint16_t insn)
 #endif
 
     arg_srai arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
-    return trans_srai(ctx, &arg, insn);
+    return trans_srai(ctx, &arg);
 }
 
-static bool trans_c_andi(DisasContext *ctx, arg_c_andi *a, uint16_t insn)
+static bool trans_c_andi(DisasContext *ctx, arg_c_andi *a)
 {
     arg_andi arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
-    return trans_andi(ctx, &arg, insn);
+    return trans_andi(ctx, &arg);
 }
 
-static bool trans_c_sub(DisasContext *ctx, arg_c_sub *a, uint16_t insn)
+static bool trans_c_sub(DisasContext *ctx, arg_c_sub *a)
 {
     arg_sub arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_sub(ctx, &arg, insn);
+    return trans_sub(ctx, &arg);
 }
 
-static bool trans_c_xor(DisasContext *ctx, arg_c_xor *a, uint16_t insn)
+static bool trans_c_xor(DisasContext *ctx, arg_c_xor *a)
 {
     arg_xor arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_xor(ctx, &arg, insn);
+    return trans_xor(ctx, &arg);
 }
 
-static bool trans_c_or(DisasContext *ctx, arg_c_or *a, uint16_t insn)
+static bool trans_c_or(DisasContext *ctx, arg_c_or *a)
 {
     arg_or arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_or(ctx, &arg, insn);
+    return trans_or(ctx, &arg);
 }
 
-static bool trans_c_and(DisasContext *ctx, arg_c_and *a, uint16_t insn)
+static bool trans_c_and(DisasContext *ctx, arg_c_and *a)
 {
     arg_and arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_and(ctx, &arg, insn);
+    return trans_and(ctx, &arg);
 }
 
-static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a, uint16_t insn)
+static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
 {
     arg_subw arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_subw(ctx, &arg, insn);
+    return trans_subw(ctx, &arg);
 }
 
-static bool trans_c_addw(DisasContext *ctx, arg_c_addw *a, uint16_t insn)
+static bool trans_c_addw(DisasContext *ctx, arg_c_addw *a)
 {
     arg_addw arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_addw(ctx, &arg, insn);
+    return trans_addw(ctx, &arg);
 }
 
-static bool trans_c_j(DisasContext *ctx, arg_c_j *a, uint16_t insn)
+static bool trans_c_j(DisasContext *ctx, arg_c_j *a)
 {
     arg_jal arg = { .rd = 0, .imm = a->imm };
-    return trans_jal(ctx, &arg, insn);
+    return trans_jal(ctx, &arg);
 }
 
-static bool trans_c_beqz(DisasContext *ctx, arg_c_beqz *a, uint16_t insn)
+static bool trans_c_beqz(DisasContext *ctx, arg_c_beqz *a)
 {
     arg_beq arg = { .rs1 = a->rs1, .rs2 = 0, .imm = a->imm };
-    return trans_beq(ctx, &arg, insn);
+    return trans_beq(ctx, &arg);
 }
 
-static bool trans_c_bnez(DisasContext *ctx, arg_c_bnez *a, uint16_t insn)
+static bool trans_c_bnez(DisasContext *ctx, arg_c_bnez *a)
 {
     arg_bne arg = { .rs1 = a->rs1, .rs2 = 0, .imm = a->imm };
-    return trans_bne(ctx, &arg, insn);
+    return trans_bne(ctx, &arg);
 }
 
-static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a, uint16_t insn)
+static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a)
 {
     int shamt = a->shamt;
     if (shamt == 0) {
@@ -246,85 +243,82 @@ static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a, uint16_t insn)
     }
 
     arg_slli arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
-    return trans_slli(ctx, &arg, insn);
+    return trans_slli(ctx, &arg);
 }
 
-static bool trans_c_fldsp(DisasContext *ctx, arg_c_fldsp *a, uint16_t insn)
+static bool trans_c_fldsp(DisasContext *ctx, arg_c_fldsp *a)
 {
     arg_fld arg = { .rd = a->rd, .rs1 = 2, .imm = a->uimm };
-    return trans_fld(ctx, &arg, insn);
+    return trans_fld(ctx, &arg);
 }
 
-static bool trans_c_lwsp(DisasContext *ctx, arg_c_lwsp *a, uint16_t insn)
+static bool trans_c_lwsp(DisasContext *ctx, arg_c_lwsp *a)
 {
     arg_lw arg = { .rd = a->rd, .rs1 = 2, .imm = a->uimm };
-    return trans_lw(ctx, &arg, insn);
+    return trans_lw(ctx, &arg);
 }
 
-static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a,
-        uint16_t insn)
+static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
 {
 #ifdef TARGET_RISCV32
     /* C.FLWSP */
     arg_flw arg_flw = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_flwsp };
-    return trans_flw(ctx, &arg_flw, insn);
+    return trans_flw(ctx, &arg_flw);
 #else
     /* C.LDSP */
     arg_ld arg_ld = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_ldsp };
-    return trans_ld(ctx, &arg_ld, insn);
+    return trans_ld(ctx, &arg_ld);
 #endif
     return false;
 }
 
-static bool trans_c_jr_mv(DisasContext *ctx, arg_c_jr_mv *a, uint16_t insn)
+static bool trans_c_jr_mv(DisasContext *ctx, arg_c_jr_mv *a)
 {
     if (a->rd != 0 && a->rs2 == 0) {
         /* C.JR */
         arg_jalr arg = { .rd = 0, .rs1 = a->rd, .imm = 0 };
-        return trans_jalr(ctx, &arg, insn);
+        return trans_jalr(ctx, &arg);
     } else if (a->rd != 0 && a->rs2 != 0) {
         /* C.MV */
         arg_add arg = { .rd = a->rd, .rs1 = 0, .rs2 = a->rs2 };
-        return trans_add(ctx, &arg, insn);
+        return trans_add(ctx, &arg);
     }
     return false;
 }
 
-static bool trans_c_ebreak_jalr_add(DisasContext *ctx, arg_c_ebreak_jalr_add *a,
-        uint16_t insn)
+static bool trans_c_ebreak_jalr_add(DisasContext *ctx, arg_c_ebreak_jalr_add *a)
 {
     if (a->rd == 0 && a->rs2 == 0) {
         /* C.EBREAK */
         arg_ebreak arg = { };
-        return trans_ebreak(ctx, &arg, insn);
+        return trans_ebreak(ctx, &arg);
     } else if (a->rd != 0) {
         if (a->rs2 == 0) {
             /* C.JALR */
             arg_jalr arg = { .rd = 1, .rs1 = a->rd, .imm = 0 };
-            return trans_jalr(ctx, &arg, insn);
+            return trans_jalr(ctx, &arg);
         } else {
             /* C.ADD */
             arg_add arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-            return trans_add(ctx, &arg, insn);
+            return trans_add(ctx, &arg);
         }
     }
     return false;
 }
 
-static bool trans_c_fsdsp(DisasContext *ctx, arg_c_fsdsp *a, uint16_t insn)
+static bool trans_c_fsdsp(DisasContext *ctx, arg_c_fsdsp *a)
 {
     arg_fsd arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
-    return trans_fsd(ctx, &arg, insn);
+    return trans_fsd(ctx, &arg);
 }
 
-static bool trans_c_swsp(DisasContext *ctx, arg_c_swsp *a, uint16_t insn)
+static bool trans_c_swsp(DisasContext *ctx, arg_c_swsp *a)
 {
     arg_sw arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
-    return trans_sw(ctx, &arg, insn);
+    return trans_sw(ctx, &arg);
 }
 
-static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a,
-        uint16_t insn)
+static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a)
 {
 #ifdef TARGET_RISCV32
     /* C.FSWSP */
@@ -333,5 +327,5 @@ static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a,
 #endif
     /* C.SDSP */
     arg_sd a_sd = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm_sdsp };
-    return trans_sd(ctx, &a_sd, insn);
+    return trans_sd(ctx, &a_sd);
 }
diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index 665cf54e25..4b2face7c5 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -18,7 +18,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-static bool trans_fld(DisasContext *ctx, arg_fld *a, uint32_t insn)
+static bool trans_fld(DisasContext *ctx, arg_fld *a)
 {
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
@@ -31,7 +31,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsd(DisasContext *ctx, arg_fsd *a, uint32_t insn)
+static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 {
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
@@ -44,7 +44,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmadd_d(DisasContext *ctx, arg_fmadd_d *a, uint32_t insn)
+static bool trans_fmadd_d(DisasContext *ctx, arg_fmadd_d *a)
 {
     REQUIRE_FPU;
     gen_set_rm(ctx, a->rm);
@@ -53,7 +53,7 @@ static bool trans_fmadd_d(DisasContext *ctx, arg_fmadd_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmsub_d(DisasContext *ctx, arg_fmsub_d *a, uint32_t insn)
+static bool trans_fmsub_d(DisasContext *ctx, arg_fmsub_d *a)
 {
     REQUIRE_FPU;
     gen_set_rm(ctx, a->rm);
@@ -62,7 +62,7 @@ static bool trans_fmsub_d(DisasContext *ctx, arg_fmsub_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fnmsub_d(DisasContext *ctx, arg_fnmsub_d *a, uint32_t insn)
+static bool trans_fnmsub_d(DisasContext *ctx, arg_fnmsub_d *a)
 {
     REQUIRE_FPU;
     gen_set_rm(ctx, a->rm);
@@ -71,7 +71,7 @@ static bool trans_fnmsub_d(DisasContext *ctx, arg_fnmsub_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fnmadd_d(DisasContext *ctx, arg_fnmadd_d *a, uint32_t insn)
+static bool trans_fnmadd_d(DisasContext *ctx, arg_fnmadd_d *a)
 {
     REQUIRE_FPU;
     gen_set_rm(ctx, a->rm);
@@ -80,7 +80,7 @@ static bool trans_fnmadd_d(DisasContext *ctx, arg_fnmadd_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fadd_d(DisasContext *ctx, arg_fadd_d *a, uint32_t insn)
+static bool trans_fadd_d(DisasContext *ctx, arg_fadd_d *a)
 {
     REQUIRE_FPU;
 
@@ -91,7 +91,7 @@ static bool trans_fadd_d(DisasContext *ctx, arg_fadd_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsub_d(DisasContext *ctx, arg_fsub_d *a, uint32_t insn)
+static bool trans_fsub_d(DisasContext *ctx, arg_fsub_d *a)
 {
     REQUIRE_FPU;
 
@@ -102,7 +102,7 @@ static bool trans_fsub_d(DisasContext *ctx, arg_fsub_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmul_d(DisasContext *ctx, arg_fmul_d *a, uint32_t insn)
+static bool trans_fmul_d(DisasContext *ctx, arg_fmul_d *a)
 {
     REQUIRE_FPU;
 
@@ -113,7 +113,7 @@ static bool trans_fmul_d(DisasContext *ctx, arg_fmul_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fdiv_d(DisasContext *ctx, arg_fdiv_d *a, uint32_t insn)
+static bool trans_fdiv_d(DisasContext *ctx, arg_fdiv_d *a)
 {
     REQUIRE_FPU;
 
@@ -124,7 +124,7 @@ static bool trans_fdiv_d(DisasContext *ctx, arg_fdiv_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsqrt_d(DisasContext *ctx, arg_fsqrt_d *a, uint32_t insn)
+static bool trans_fsqrt_d(DisasContext *ctx, arg_fsqrt_d *a)
 {
     REQUIRE_FPU;
 
@@ -134,7 +134,7 @@ static bool trans_fsqrt_d(DisasContext *ctx, arg_fsqrt_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsgnj_d(DisasContext *ctx, arg_fsgnj_d *a, uint32_t insn)
+static bool trans_fsgnj_d(DisasContext *ctx, arg_fsgnj_d *a)
 {
     if (a->rs1 == a->rs2) { /* FMOV */
         tcg_gen_mov_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
@@ -145,7 +145,7 @@ static bool trans_fsgnj_d(DisasContext *ctx, arg_fsgnj_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsgnjn_d(DisasContext *ctx, arg_fsgnjn_d *a, uint32_t insn)
+static bool trans_fsgnjn_d(DisasContext *ctx, arg_fsgnjn_d *a)
 {
     REQUIRE_FPU;
     if (a->rs1 == a->rs2) { /* FNEG */
@@ -159,7 +159,7 @@ static bool trans_fsgnjn_d(DisasContext *ctx, arg_fsgnjn_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsgnjx_d(DisasContext *ctx, arg_fsgnjx_d *a, uint32_t insn)
+static bool trans_fsgnjx_d(DisasContext *ctx, arg_fsgnjx_d *a)
 {
     REQUIRE_FPU;
     if (a->rs1 == a->rs2) { /* FABS */
@@ -173,7 +173,7 @@ static bool trans_fsgnjx_d(DisasContext *ctx, arg_fsgnjx_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmin_d(DisasContext *ctx, arg_fmin_d *a, uint32_t insn)
+static bool trans_fmin_d(DisasContext *ctx, arg_fmin_d *a)
 {
     REQUIRE_FPU;
 
@@ -183,7 +183,7 @@ static bool trans_fmin_d(DisasContext *ctx, arg_fmin_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmax_d(DisasContext *ctx, arg_fmax_d *a, uint32_t insn)
+static bool trans_fmax_d(DisasContext *ctx, arg_fmax_d *a)
 {
     REQUIRE_FPU;
 
@@ -193,7 +193,7 @@ static bool trans_fmax_d(DisasContext *ctx, arg_fmax_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_s_d(DisasContext *ctx, arg_fcvt_s_d *a, uint32_t insn)
+static bool trans_fcvt_s_d(DisasContext *ctx, arg_fcvt_s_d *a)
 {
     REQUIRE_FPU;
 
@@ -203,7 +203,7 @@ static bool trans_fcvt_s_d(DisasContext *ctx, arg_fcvt_s_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_d_s(DisasContext *ctx, arg_fcvt_d_s *a, uint32_t insn)
+static bool trans_fcvt_d_s(DisasContext *ctx, arg_fcvt_d_s *a)
 {
     REQUIRE_FPU;
 
@@ -213,7 +213,7 @@ static bool trans_fcvt_d_s(DisasContext *ctx, arg_fcvt_d_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_feq_d(DisasContext *ctx, arg_feq_d *a, uint32_t insn)
+static bool trans_feq_d(DisasContext *ctx, arg_feq_d *a)
 {
     REQUIRE_FPU;
 
@@ -225,7 +225,7 @@ static bool trans_feq_d(DisasContext *ctx, arg_feq_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_flt_d(DisasContext *ctx, arg_flt_d *a, uint32_t insn)
+static bool trans_flt_d(DisasContext *ctx, arg_flt_d *a)
 {
     REQUIRE_FPU;
 
@@ -237,7 +237,7 @@ static bool trans_flt_d(DisasContext *ctx, arg_flt_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fle_d(DisasContext *ctx, arg_fle_d *a, uint32_t insn)
+static bool trans_fle_d(DisasContext *ctx, arg_fle_d *a)
 {
     REQUIRE_FPU;
 
@@ -249,7 +249,7 @@ static bool trans_fle_d(DisasContext *ctx, arg_fle_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fclass_d(DisasContext *ctx, arg_fclass_d *a, uint32_t insn)
+static bool trans_fclass_d(DisasContext *ctx, arg_fclass_d *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
@@ -264,7 +264,7 @@ static bool trans_fclass_d(DisasContext *ctx, arg_fclass_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_w_d(DisasContext *ctx, arg_fcvt_w_d *a, uint32_t insn)
+static bool trans_fcvt_w_d(DisasContext *ctx, arg_fcvt_w_d *a)
 {
     REQUIRE_FPU;
 
@@ -277,7 +277,7 @@ static bool trans_fcvt_w_d(DisasContext *ctx, arg_fcvt_w_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_wu_d(DisasContext *ctx, arg_fcvt_wu_d *a, uint32_t insn)
+static bool trans_fcvt_wu_d(DisasContext *ctx, arg_fcvt_wu_d *a)
 {
     REQUIRE_FPU;
 
@@ -290,7 +290,7 @@ static bool trans_fcvt_wu_d(DisasContext *ctx, arg_fcvt_wu_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_d_w(DisasContext *ctx, arg_fcvt_d_w *a, uint32_t insn)
+static bool trans_fcvt_d_w(DisasContext *ctx, arg_fcvt_d_w *a)
 {
     REQUIRE_FPU;
 
@@ -304,7 +304,7 @@ static bool trans_fcvt_d_w(DisasContext *ctx, arg_fcvt_d_w *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_d_wu(DisasContext *ctx, arg_fcvt_d_wu *a, uint32_t insn)
+static bool trans_fcvt_d_wu(DisasContext *ctx, arg_fcvt_d_wu *a)
 {
     REQUIRE_FPU;
 
@@ -318,7 +318,7 @@ static bool trans_fcvt_d_wu(DisasContext *ctx, arg_fcvt_d_wu *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_l_d(DisasContext *ctx, arg_fcvt_l_d *a, uint32_t insn)
+static bool trans_fcvt_l_d(DisasContext *ctx, arg_fcvt_l_d *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
@@ -334,7 +334,7 @@ static bool trans_fcvt_l_d(DisasContext *ctx, arg_fcvt_l_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_lu_d(DisasContext *ctx, arg_fcvt_lu_d *a, uint32_t insn)
+static bool trans_fcvt_lu_d(DisasContext *ctx, arg_fcvt_lu_d *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
@@ -350,7 +350,7 @@ static bool trans_fcvt_lu_d(DisasContext *ctx, arg_fcvt_lu_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmv_x_d(DisasContext *ctx, arg_fmv_x_d *a, uint32_t insn)
+static bool trans_fmv_x_d(DisasContext *ctx, arg_fmv_x_d *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
@@ -362,7 +362,7 @@ static bool trans_fmv_x_d(DisasContext *ctx, arg_fmv_x_d *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_d_l(DisasContext *ctx, arg_fcvt_d_l *a, uint32_t insn)
+static bool trans_fcvt_d_l(DisasContext *ctx, arg_fcvt_d_l *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
@@ -379,7 +379,7 @@ static bool trans_fcvt_d_l(DisasContext *ctx, arg_fcvt_d_l *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_d_lu(DisasContext *ctx, arg_fcvt_d_lu *a, uint32_t insn)
+static bool trans_fcvt_d_lu(DisasContext *ctx, arg_fcvt_d_lu *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
@@ -396,7 +396,7 @@ static bool trans_fcvt_d_lu(DisasContext *ctx, arg_fcvt_d_lu *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmv_d_x(DisasContext *ctx, arg_fmv_d_x *a, uint32_t insn)
+static bool trans_fmv_d_x(DisasContext *ctx, arg_fmv_d_x *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index bd79ef96f8..6f055e77bf 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -23,7 +23,7 @@
         return false;                       \
 } while (0)
 
-static bool trans_flw(DisasContext *ctx, arg_flw *a, uint32_t insn)
+static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
@@ -38,7 +38,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsw(DisasContext *ctx, arg_fsw *a, uint32_t insn)
+static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
 {
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
@@ -52,7 +52,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmadd_s(DisasContext *ctx, arg_fmadd_s *a, uint32_t insn)
+static bool trans_fmadd_s(DisasContext *ctx, arg_fmadd_s *a)
 {
     REQUIRE_FPU;
     gen_set_rm(ctx, a->rm);
@@ -61,7 +61,7 @@ static bool trans_fmadd_s(DisasContext *ctx, arg_fmadd_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmsub_s(DisasContext *ctx, arg_fmsub_s *a, uint32_t insn)
+static bool trans_fmsub_s(DisasContext *ctx, arg_fmsub_s *a)
 {
     REQUIRE_FPU;
     gen_set_rm(ctx, a->rm);
@@ -70,7 +70,7 @@ static bool trans_fmsub_s(DisasContext *ctx, arg_fmsub_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fnmsub_s(DisasContext *ctx, arg_fnmsub_s *a, uint32_t insn)
+static bool trans_fnmsub_s(DisasContext *ctx, arg_fnmsub_s *a)
 {
     REQUIRE_FPU;
     gen_set_rm(ctx, a->rm);
@@ -79,7 +79,7 @@ static bool trans_fnmsub_s(DisasContext *ctx, arg_fnmsub_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fnmadd_s(DisasContext *ctx, arg_fnmadd_s *a, uint32_t insn)
+static bool trans_fnmadd_s(DisasContext *ctx, arg_fnmadd_s *a)
 {
     REQUIRE_FPU;
     gen_set_rm(ctx, a->rm);
@@ -88,7 +88,7 @@ static bool trans_fnmadd_s(DisasContext *ctx, arg_fnmadd_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fadd_s(DisasContext *ctx, arg_fadd_s *a, uint32_t insn)
+static bool trans_fadd_s(DisasContext *ctx, arg_fadd_s *a)
 {
     REQUIRE_FPU;
 
@@ -98,7 +98,7 @@ static bool trans_fadd_s(DisasContext *ctx, arg_fadd_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsub_s(DisasContext *ctx, arg_fsub_s *a, uint32_t insn)
+static bool trans_fsub_s(DisasContext *ctx, arg_fsub_s *a)
 {
     REQUIRE_FPU;
 
@@ -108,7 +108,7 @@ static bool trans_fsub_s(DisasContext *ctx, arg_fsub_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmul_s(DisasContext *ctx, arg_fmul_s *a, uint32_t insn)
+static bool trans_fmul_s(DisasContext *ctx, arg_fmul_s *a)
 {
     REQUIRE_FPU;
 
@@ -118,7 +118,7 @@ static bool trans_fmul_s(DisasContext *ctx, arg_fmul_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fdiv_s(DisasContext *ctx, arg_fdiv_s *a, uint32_t insn)
+static bool trans_fdiv_s(DisasContext *ctx, arg_fdiv_s *a)
 {
     REQUIRE_FPU;
 
@@ -128,7 +128,7 @@ static bool trans_fdiv_s(DisasContext *ctx, arg_fdiv_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsqrt_s(DisasContext *ctx, arg_fsqrt_s *a, uint32_t insn)
+static bool trans_fsqrt_s(DisasContext *ctx, arg_fsqrt_s *a)
 {
     REQUIRE_FPU;
 
@@ -137,7 +137,7 @@ static bool trans_fsqrt_s(DisasContext *ctx, arg_fsqrt_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a, uint32_t insn)
+static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a)
 {
     REQUIRE_FPU;
     if (a->rs1 == a->rs2) { /* FMOV */
@@ -149,7 +149,7 @@ static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a, uint32_t insn)
+static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
 {
     REQUIRE_FPU;
     if (a->rs1 == a->rs2) { /* FNEG */
@@ -163,7 +163,7 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a, uint32_t insn)
+static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
 {
     REQUIRE_FPU;
     if (a->rs1 == a->rs2) { /* FABS */
@@ -177,7 +177,7 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmin_s(DisasContext *ctx, arg_fmin_s *a, uint32_t insn)
+static bool trans_fmin_s(DisasContext *ctx, arg_fmin_s *a)
 {
     REQUIRE_FPU;
 
@@ -186,7 +186,7 @@ static bool trans_fmin_s(DisasContext *ctx, arg_fmin_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmax_s(DisasContext *ctx, arg_fmax_s *a, uint32_t insn)
+static bool trans_fmax_s(DisasContext *ctx, arg_fmax_s *a)
 {
     REQUIRE_FPU;
 
@@ -195,7 +195,7 @@ static bool trans_fmax_s(DisasContext *ctx, arg_fmax_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_w_s(DisasContext *ctx, arg_fcvt_w_s *a, uint32_t insn)
+static bool trans_fcvt_w_s(DisasContext *ctx, arg_fcvt_w_s *a)
 {
     REQUIRE_FPU;
 
@@ -208,7 +208,7 @@ static bool trans_fcvt_w_s(DisasContext *ctx, arg_fcvt_w_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_wu_s(DisasContext *ctx, arg_fcvt_wu_s *a, uint32_t insn)
+static bool trans_fcvt_wu_s(DisasContext *ctx, arg_fcvt_wu_s *a)
 {
     REQUIRE_FPU;
 
@@ -221,7 +221,7 @@ static bool trans_fcvt_wu_s(DisasContext *ctx, arg_fcvt_wu_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmv_x_w(DisasContext *ctx, arg_fmv_x_w *a, uint32_t insn)
+static bool trans_fmv_x_w(DisasContext *ctx, arg_fmv_x_w *a)
 {
     /* NOTE: This was FMV.X.S in an earlier version of the ISA spec! */
     REQUIRE_FPU;
@@ -240,7 +240,7 @@ static bool trans_fmv_x_w(DisasContext *ctx, arg_fmv_x_w *a, uint32_t insn)
     return true;
 }
 
-static bool trans_feq_s(DisasContext *ctx, arg_feq_s *a, uint32_t insn)
+static bool trans_feq_s(DisasContext *ctx, arg_feq_s *a)
 {
     REQUIRE_FPU;
     TCGv t0 = tcg_temp_new();
@@ -250,7 +250,7 @@ static bool trans_feq_s(DisasContext *ctx, arg_feq_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_flt_s(DisasContext *ctx, arg_flt_s *a, uint32_t insn)
+static bool trans_flt_s(DisasContext *ctx, arg_flt_s *a)
 {
     REQUIRE_FPU;
     TCGv t0 = tcg_temp_new();
@@ -260,7 +260,7 @@ static bool trans_flt_s(DisasContext *ctx, arg_flt_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fle_s(DisasContext *ctx, arg_fle_s *a, uint32_t insn)
+static bool trans_fle_s(DisasContext *ctx, arg_fle_s *a)
 {
     REQUIRE_FPU;
     TCGv t0 = tcg_temp_new();
@@ -270,7 +270,7 @@ static bool trans_fle_s(DisasContext *ctx, arg_fle_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fclass_s(DisasContext *ctx, arg_fclass_s *a, uint32_t insn)
+static bool trans_fclass_s(DisasContext *ctx, arg_fclass_s *a)
 {
     REQUIRE_FPU;
 
@@ -284,7 +284,7 @@ static bool trans_fclass_s(DisasContext *ctx, arg_fclass_s *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_s_w(DisasContext *ctx, arg_fcvt_s_w *a, uint32_t insn)
+static bool trans_fcvt_s_w(DisasContext *ctx, arg_fcvt_s_w *a)
 {
     REQUIRE_FPU;
 
@@ -299,7 +299,7 @@ static bool trans_fcvt_s_w(DisasContext *ctx, arg_fcvt_s_w *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_s_wu(DisasContext *ctx, arg_fcvt_s_wu *a, uint32_t insn)
+static bool trans_fcvt_s_wu(DisasContext *ctx, arg_fcvt_s_wu *a)
 {
     REQUIRE_FPU;
 
@@ -314,7 +314,7 @@ static bool trans_fcvt_s_wu(DisasContext *ctx, arg_fcvt_s_wu *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a, uint32_t insn)
+static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
 {
     /* NOTE: This was FMV.S.X in an earlier version of the ISA spec! */
     REQUIRE_FPU;
@@ -333,7 +333,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a, uint32_t insn)
+static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
@@ -349,7 +349,7 @@ static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a, uint32_t insn)
 #endif
 }
 
-static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a, uint32_t insn)
+static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
@@ -365,7 +365,7 @@ static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a, uint32_t insn)
 #endif
 }
 
-static bool trans_fcvt_s_l(DisasContext *ctx, arg_fcvt_s_l *a, uint32_t insn)
+static bool trans_fcvt_s_l(DisasContext *ctx, arg_fcvt_s_l *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
@@ -383,7 +383,7 @@ static bool trans_fcvt_s_l(DisasContext *ctx, arg_fcvt_s_l *a, uint32_t insn)
 #endif
 }
 
-static bool trans_fcvt_s_lu(DisasContext *ctx, arg_fcvt_s_lu *a, uint32_t insn)
+static bool trans_fcvt_s_lu(DisasContext *ctx, arg_fcvt_s_lu *a)
 {
 #if defined(TARGET_RISCV64)
     REQUIRE_FPU;
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 0455f0bf91..2ef355019d 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -18,7 +18,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-static bool trans_lui(DisasContext *ctx, arg_lui *a, uint32_t insn)
+static bool trans_lui(DisasContext *ctx, arg_lui *a)
 {
     if (a->rd != 0) {
         tcg_gen_movi_tl(cpu_gpr[a->rd], a->imm);
@@ -26,7 +26,7 @@ static bool trans_lui(DisasContext *ctx, arg_lui *a, uint32_t insn)
     return true;
 }
 
-static bool trans_auipc(DisasContext *ctx, arg_auipc *a, uint32_t insn)
+static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
 {
     if (a->rd != 0) {
         tcg_gen_movi_tl(cpu_gpr[a->rd], a->imm + ctx->base.pc_next);
@@ -34,13 +34,13 @@ static bool trans_auipc(DisasContext *ctx, arg_auipc *a, uint32_t insn)
     return true;
 }
 
-static bool trans_jal(DisasContext *ctx, arg_jal *a, uint32_t insn)
+static bool trans_jal(DisasContext *ctx, arg_jal *a)
 {
     gen_jal(ctx->env, ctx, a->rd, a->imm);
     return true;
 }
 
-static bool trans_jalr(DisasContext *ctx, arg_jalr *a, uint32_t insn)
+static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
 {
     /* no chaining with JALR */
     TCGLabel *misaligned = NULL;
@@ -99,32 +99,32 @@ static bool gen_branch(DisasContext *ctx, arg_branch *a, TCGCond cond)
     return true;
 }
 
-static bool trans_beq(DisasContext *ctx, arg_beq *a, uint32_t insn)
+static bool trans_beq(DisasContext *ctx, arg_beq *a)
 {
     return gen_branch(ctx, a, TCG_COND_EQ);
 }
 
-static bool trans_bne(DisasContext *ctx, arg_bne *a, uint32_t insn)
+static bool trans_bne(DisasContext *ctx, arg_bne *a)
 {
     return gen_branch(ctx, a, TCG_COND_NE);
 }
 
-static bool trans_blt(DisasContext *ctx, arg_blt *a, uint32_t insn)
+static bool trans_blt(DisasContext *ctx, arg_blt *a)
 {
     return gen_branch(ctx, a, TCG_COND_LT);
 }
 
-static bool trans_bge(DisasContext *ctx, arg_bge *a, uint32_t insn)
+static bool trans_bge(DisasContext *ctx, arg_bge *a)
 {
     return gen_branch(ctx, a, TCG_COND_GE);
 }
 
-static bool trans_bltu(DisasContext *ctx, arg_bltu *a, uint32_t insn)
+static bool trans_bltu(DisasContext *ctx, arg_bltu *a)
 {
     return gen_branch(ctx, a, TCG_COND_LTU);
 }
 
-static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a, uint32_t insn)
+static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)
 {
     return gen_branch(ctx, a, TCG_COND_GEU);
 }
@@ -143,32 +143,32 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, int memop)
      return true;
 }
 
-static bool trans_lb(DisasContext *ctx, arg_lb *a, uint32_t insn)
+static bool trans_lb(DisasContext *ctx, arg_lb *a)
 {
     return gen_load(ctx, a, MO_SB);
 }
 
-static bool trans_lh(DisasContext *ctx, arg_lh *a, uint32_t insn)
+static bool trans_lh(DisasContext *ctx, arg_lh *a)
 {
     return gen_load(ctx, a, MO_TESW);
 }
 
-static bool trans_lw(DisasContext *ctx, arg_lw *a, uint32_t insn)
+static bool trans_lw(DisasContext *ctx, arg_lw *a)
 {
     return gen_load(ctx, a, MO_TESL);
 }
 
-static bool trans_lbu(DisasContext *ctx, arg_lbu *a, uint32_t insn)
+static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
 {
     return gen_load(ctx, a, MO_UB);
 }
 
-static bool trans_lhu(DisasContext *ctx, arg_lhu *a, uint32_t insn)
+static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
 {
     return gen_load(ctx, a, MO_TEUW);
 }
 
-static bool trans_lwu(DisasContext *ctx, arg_lwu *a, uint32_t insn)
+static bool trans_lwu(DisasContext *ctx, arg_lwu *a)
 {
 #ifdef TARGET_RISCV64
     return gen_load(ctx, a, MO_TEUL);
@@ -177,7 +177,7 @@ static bool trans_lwu(DisasContext *ctx, arg_lwu *a, uint32_t insn)
 #endif
 }
 
-static bool trans_ld(DisasContext *ctx, arg_ld *a, uint32_t insn)
+static bool trans_ld(DisasContext *ctx, arg_ld *a)
 {
 #ifdef TARGET_RISCV64
     return gen_load(ctx, a, MO_TEQ);
@@ -201,22 +201,22 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, int memop)
 }
 
 
-static bool trans_sb(DisasContext *ctx, arg_sb *a, uint32_t insn)
+static bool trans_sb(DisasContext *ctx, arg_sb *a)
 {
     return gen_store(ctx, a, MO_SB);
 }
 
-static bool trans_sh(DisasContext *ctx, arg_sh *a, uint32_t insn)
+static bool trans_sh(DisasContext *ctx, arg_sh *a)
 {
     return gen_store(ctx, a, MO_TESW);
 }
 
-static bool trans_sw(DisasContext *ctx, arg_sw *a, uint32_t insn)
+static bool trans_sw(DisasContext *ctx, arg_sw *a)
 {
     return gen_store(ctx, a, MO_TESL);
 }
 
-static bool trans_sd(DisasContext *ctx, arg_sd *a, uint32_t insn)
+static bool trans_sd(DisasContext *ctx, arg_sd *a)
 {
 #ifdef TARGET_RISCV64
     return gen_store(ctx, a, MO_TEQ);
@@ -225,12 +225,12 @@ static bool trans_sd(DisasContext *ctx, arg_sd *a, uint32_t insn)
 #endif
 }
 
-static bool trans_addi(DisasContext *ctx, arg_addi *a, uint32_t insn)
+static bool trans_addi(DisasContext *ctx, arg_addi *a)
 {
     return gen_arith_imm(ctx, a, &tcg_gen_add_tl);
 }
 
-static bool trans_slti(DisasContext *ctx, arg_slti *a, uint32_t insn)
+static bool trans_slti(DisasContext *ctx, arg_slti *a)
 {
     TCGv source1;
     source1 = tcg_temp_new();
@@ -243,7 +243,7 @@ static bool trans_slti(DisasContext *ctx, arg_slti *a, uint32_t insn)
     return true;
 }
 
-static bool trans_sltiu(DisasContext *ctx, arg_sltiu *a, uint32_t insn)
+static bool trans_sltiu(DisasContext *ctx, arg_sltiu *a)
 {
     TCGv source1;
     source1 = tcg_temp_new();
@@ -256,22 +256,22 @@ static bool trans_sltiu(DisasContext *ctx, arg_sltiu *a, uint32_t insn)
     return true;
 }
 
-static bool trans_xori(DisasContext *ctx, arg_xori *a, uint32_t insn)
+static bool trans_xori(DisasContext *ctx, arg_xori *a)
 {
     return gen_arith_imm(ctx, a, &tcg_gen_xor_tl);
 }
 
-static bool trans_ori(DisasContext *ctx, arg_ori *a, uint32_t insn)
+static bool trans_ori(DisasContext *ctx, arg_ori *a)
 {
     return gen_arith_imm(ctx, a, &tcg_gen_or_tl);
 }
 
-static bool trans_andi(DisasContext *ctx, arg_andi *a, uint32_t insn)
+static bool trans_andi(DisasContext *ctx, arg_andi *a)
 {
     return gen_arith_imm(ctx, a, &tcg_gen_and_tl);
 }
 
-static bool trans_slli(DisasContext *ctx, arg_slli *a, uint32_t insn)
+static bool trans_slli(DisasContext *ctx, arg_slli *a)
 {
     if (a->rd != 0) {
         TCGv t = tcg_temp_new();
@@ -289,7 +289,7 @@ static bool trans_slli(DisasContext *ctx, arg_slli *a, uint32_t insn)
     return true;
 }
 
-static bool trans_srli(DisasContext *ctx, arg_srli *a, uint32_t insn)
+static bool trans_srli(DisasContext *ctx, arg_srli *a)
 {
     if (a->rd != 0) {
         TCGv t = tcg_temp_new();
@@ -301,7 +301,7 @@ static bool trans_srli(DisasContext *ctx, arg_srli *a, uint32_t insn)
     return true;
 }
 
-static bool trans_srai(DisasContext *ctx, arg_srai *a, uint32_t insn)
+static bool trans_srai(DisasContext *ctx, arg_srai *a)
 {
     if (a->rd != 0) {
         TCGv t = tcg_temp_new();
@@ -313,23 +313,23 @@ static bool trans_srai(DisasContext *ctx, arg_srai *a, uint32_t insn)
     return true;
 }
 
-static bool trans_add(DisasContext *ctx, arg_add *a, uint32_t insn)
+static bool trans_add(DisasContext *ctx, arg_add *a)
 {
     return gen_arith(ctx, a, &tcg_gen_add_tl);
 }
 
-static bool trans_sub(DisasContext *ctx, arg_sub *a, uint32_t insn)
+static bool trans_sub(DisasContext *ctx, arg_sub *a)
 {
     return gen_arith(ctx, a, &tcg_gen_sub_tl);
 }
 
-static bool trans_sll(DisasContext *ctx, arg_sll *a, uint32_t insn)
+static bool trans_sll(DisasContext *ctx, arg_sll *a)
 {
 
     return gen_shift(ctx, a, &tcg_gen_shl_tl);
 }
 
-static bool trans_slt(DisasContext *ctx, arg_slt *a, uint32_t insn)
+static bool trans_slt(DisasContext *ctx, arg_slt *a)
 {
     TCGv source1 = tcg_temp_new();
     TCGv source2 = tcg_temp_new();
@@ -345,7 +345,7 @@ static bool trans_slt(DisasContext *ctx, arg_slt *a, uint32_t insn)
     return true;
 }
 
-static bool trans_sltu(DisasContext *ctx, arg_sltu *a, uint32_t insn)
+static bool trans_sltu(DisasContext *ctx, arg_sltu *a)
 {
     TCGv source1 = tcg_temp_new();
     TCGv source2 = tcg_temp_new();
@@ -361,33 +361,33 @@ static bool trans_sltu(DisasContext *ctx, arg_sltu *a, uint32_t insn)
     return true;
 }
 
-static bool trans_xor(DisasContext *ctx, arg_xor *a, uint32_t insn)
+static bool trans_xor(DisasContext *ctx, arg_xor *a)
 {
     return gen_arith(ctx, a, &tcg_gen_xor_tl);
 }
 
 
-static bool trans_srl(DisasContext *ctx, arg_srl *a, uint32_t insn)
+static bool trans_srl(DisasContext *ctx, arg_srl *a)
 {
     return gen_shift(ctx, a, &tcg_gen_shr_tl);
 }
 
-static bool trans_sra(DisasContext *ctx, arg_sra *a, uint32_t insn)
+static bool trans_sra(DisasContext *ctx, arg_sra *a)
 {
     return gen_shift(ctx, a, &tcg_gen_sar_tl);
 }
 
-static bool trans_or(DisasContext *ctx, arg_or *a, uint32_t insn)
+static bool trans_or(DisasContext *ctx, arg_or *a)
 {
     return gen_arith(ctx, a, &tcg_gen_or_tl);
 }
 
-static bool trans_and(DisasContext *ctx, arg_and *a, uint32_t insn)
+static bool trans_and(DisasContext *ctx, arg_and *a)
 {
     return gen_arith(ctx, a, &tcg_gen_and_tl);
 }
 
-static bool trans_addiw(DisasContext *ctx, arg_addiw *a, uint32_t insn)
+static bool trans_addiw(DisasContext *ctx, arg_addiw *a)
 {
 #ifdef TARGET_RISCV64
     bool res = gen_arith_imm(ctx, a, &tcg_gen_add_tl);
@@ -398,7 +398,7 @@ static bool trans_addiw(DisasContext *ctx, arg_addiw *a, uint32_t insn)
 #endif
 }
 
-static bool trans_slliw(DisasContext *ctx, arg_slliw *a, uint32_t insn)
+static bool trans_slliw(DisasContext *ctx, arg_slliw *a)
 {
 #ifdef TARGET_RISCV64
     TCGv source1;
@@ -416,7 +416,7 @@ static bool trans_slliw(DisasContext *ctx, arg_slliw *a, uint32_t insn)
 #endif
 }
 
-static bool trans_srliw(DisasContext *ctx, arg_srliw *a, uint32_t insn)
+static bool trans_srliw(DisasContext *ctx, arg_srliw *a)
 {
 #ifdef TARGET_RISCV64
     TCGv t = tcg_temp_new();
@@ -432,7 +432,7 @@ static bool trans_srliw(DisasContext *ctx, arg_srliw *a, uint32_t insn)
 #endif
 }
 
-static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a, uint32_t insn)
+static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
 {
 #ifdef TARGET_RISCV64
     TCGv t = tcg_temp_new();
@@ -448,7 +448,7 @@ static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a, uint32_t insn)
 #endif
 }
 
-static bool trans_addw(DisasContext *ctx, arg_addw *a, uint32_t insn)
+static bool trans_addw(DisasContext *ctx, arg_addw *a)
 {
 #if !defined(TARGET_RISCV64)
     return false;
@@ -456,7 +456,7 @@ static bool trans_addw(DisasContext *ctx, arg_addw *a, uint32_t insn)
     return gen_arith(ctx, a, &tcg_gen_add_tl);
 }
 
-static bool trans_subw(DisasContext *ctx, arg_subw *a, uint32_t insn)
+static bool trans_subw(DisasContext *ctx, arg_subw *a)
 {
 #if !defined(TARGET_RISCV64)
     return false;
@@ -464,7 +464,7 @@ static bool trans_subw(DisasContext *ctx, arg_subw *a, uint32_t insn)
     return gen_arith(ctx, a, &tcg_gen_sub_tl);
 }
 
-static bool trans_sllw(DisasContext *ctx, arg_sllw *a, uint32_t insn)
+static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
 {
 #if !defined(TARGET_RISCV64)
     return false;
@@ -484,7 +484,7 @@ static bool trans_sllw(DisasContext *ctx, arg_sllw *a, uint32_t insn)
     return true;
 }
 
-static bool trans_srlw(DisasContext *ctx, arg_srlw *a, uint32_t insn)
+static bool trans_srlw(DisasContext *ctx, arg_srlw *a)
 {
 #if !defined(TARGET_RISCV64)
     return false;
@@ -506,7 +506,7 @@ static bool trans_srlw(DisasContext *ctx, arg_srlw *a, uint32_t insn)
     return true;
 }
 
-static bool trans_sraw(DisasContext *ctx, arg_sraw *a, uint32_t insn)
+static bool trans_sraw(DisasContext *ctx, arg_sraw *a)
 {
 #if !defined(TARGET_RISCV64)
     return false;
@@ -529,7 +529,7 @@ static bool trans_sraw(DisasContext *ctx, arg_sraw *a, uint32_t insn)
     return true;
 }
 
-static bool trans_fence(DisasContext *ctx, arg_fence *a, uint32_t insn)
+static bool trans_fence(DisasContext *ctx, arg_fence *a)
 {
 #ifndef CONFIG_USER_ONLY
     /* FENCE is a full memory barrier. */
@@ -537,7 +537,7 @@ static bool trans_fence(DisasContext *ctx, arg_fence *a, uint32_t insn)
 #endif
     return true;
 }
-static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a, uint32_t insn)
+static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
 {
 #ifndef CONFIG_USER_ONLY
     /* FENCE_I is a no-op in QEMU,
@@ -574,7 +574,7 @@ static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a, uint32_t insn)
 } while (0)
 
 
-static bool trans_csrrw(DisasContext *ctx, arg_csrrw *a, uint32_t insn)
+static bool trans_csrrw(DisasContext *ctx, arg_csrrw *a)
 {
     TCGv source1, csr_store, dest, rs1_pass;
     RISCV_OP_CSR_PRE;
@@ -583,7 +583,7 @@ static bool trans_csrrw(DisasContext *ctx, arg_csrrw *a, uint32_t insn)
     return true;
 }
 
-static bool trans_csrrs(DisasContext *ctx, arg_csrrs *a, uint32_t insn)
+static bool trans_csrrs(DisasContext *ctx, arg_csrrs *a)
 {
     TCGv source1, csr_store, dest, rs1_pass;
     RISCV_OP_CSR_PRE;
@@ -592,7 +592,7 @@ static bool trans_csrrs(DisasContext *ctx, arg_csrrs *a, uint32_t insn)
     return true;
 }
 
-static bool trans_csrrc(DisasContext *ctx, arg_csrrc *a, uint32_t insn)
+static bool trans_csrrc(DisasContext *ctx, arg_csrrc *a)
 {
     TCGv source1, csr_store, dest, rs1_pass;
     RISCV_OP_CSR_PRE;
@@ -601,7 +601,7 @@ static bool trans_csrrc(DisasContext *ctx, arg_csrrc *a, uint32_t insn)
     return true;
 }
 
-static bool trans_csrrwi(DisasContext *ctx, arg_csrrwi *a, uint32_t insn)
+static bool trans_csrrwi(DisasContext *ctx, arg_csrrwi *a)
 {
     TCGv source1, csr_store, dest, rs1_pass;
     RISCV_OP_CSR_PRE;
@@ -610,7 +610,7 @@ static bool trans_csrrwi(DisasContext *ctx, arg_csrrwi *a, uint32_t insn)
     return true;
 }
 
-static bool trans_csrrsi(DisasContext *ctx, arg_csrrsi *a, uint32_t insn)
+static bool trans_csrrsi(DisasContext *ctx, arg_csrrsi *a)
 {
     TCGv source1, csr_store, dest, rs1_pass;
     RISCV_OP_CSR_PRE;
@@ -619,7 +619,7 @@ static bool trans_csrrsi(DisasContext *ctx, arg_csrrsi *a, uint32_t insn)
     return true;
 }
 
-static bool trans_csrrci(DisasContext *ctx, arg_csrrci *a, uint32_t insn)
+static bool trans_csrrci(DisasContext *ctx, arg_csrrci *a)
 {
     TCGv source1, csr_store, dest, rs1_pass;
     RISCV_OP_CSR_PRE;
diff --git a/target/riscv/insn_trans/trans_rvm.inc.c b/target/riscv/insn_trans/trans_rvm.inc.c
index 0bc9b4347a..7809bcb187 100644
--- a/target/riscv/insn_trans/trans_rvm.inc.c
+++ b/target/riscv/insn_trans/trans_rvm.inc.c
@@ -19,12 +19,12 @@
  */
 
 
-static bool trans_mul(DisasContext *ctx, arg_mul *a, uint32_t insn)
+static bool trans_mul(DisasContext *ctx, arg_mul *a)
 {
     return gen_arith(ctx, a, &tcg_gen_mul_tl);
 }
 
-static bool trans_mulh(DisasContext *ctx, arg_mulh *a, uint32_t insn)
+static bool trans_mulh(DisasContext *ctx, arg_mulh *a)
 {
     TCGv source1 = tcg_temp_new();
     TCGv source2 = tcg_temp_new();
@@ -39,12 +39,12 @@ static bool trans_mulh(DisasContext *ctx, arg_mulh *a, uint32_t insn)
     return true;
 }
 
-static bool trans_mulhsu(DisasContext *ctx, arg_mulhsu *a, uint32_t insn)
+static bool trans_mulhsu(DisasContext *ctx, arg_mulhsu *a)
 {
     return gen_arith(ctx, a, &gen_mulhsu);
 }
 
-static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a, uint32_t insn)
+static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a)
 {
     TCGv source1 = tcg_temp_new();
     TCGv source2 = tcg_temp_new();
@@ -59,27 +59,27 @@ static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a, uint32_t insn)
     return true;
 }
 
-static bool trans_div(DisasContext *ctx, arg_div *a, uint32_t insn)
+static bool trans_div(DisasContext *ctx, arg_div *a)
 {
     return gen_arith(ctx, a, &gen_div);
 }
 
-static bool trans_divu(DisasContext *ctx, arg_divu *a, uint32_t insn)
+static bool trans_divu(DisasContext *ctx, arg_divu *a)
 {
     return gen_arith(ctx, a, &gen_divu);
 }
 
-static bool trans_rem(DisasContext *ctx, arg_rem *a, uint32_t insn)
+static bool trans_rem(DisasContext *ctx, arg_rem *a)
 {
     return gen_arith(ctx, a, &gen_rem);
 }
 
-static bool trans_remu(DisasContext *ctx, arg_remu *a, uint32_t insn)
+static bool trans_remu(DisasContext *ctx, arg_remu *a)
 {
     return gen_arith(ctx, a, &gen_remu);
 }
 
-static bool trans_mulw(DisasContext *ctx, arg_mulw *a, uint32_t insn)
+static bool trans_mulw(DisasContext *ctx, arg_mulw *a)
 {
 #ifdef TARGET_RISCV64
     return gen_arith(ctx, a, &tcg_gen_mul_tl);
@@ -88,7 +88,7 @@ static bool trans_mulw(DisasContext *ctx, arg_mulw *a, uint32_t insn)
 #endif
 }
 
-static bool trans_divw(DisasContext *ctx, arg_divw *a, uint32_t insn)
+static bool trans_divw(DisasContext *ctx, arg_divw *a)
 {
 #ifdef TARGET_RISCV64
     return gen_arith_w(ctx, a, &gen_div);
@@ -97,7 +97,7 @@ static bool trans_divw(DisasContext *ctx, arg_divw *a, uint32_t insn)
 #endif
 }
 
-static bool trans_divuw(DisasContext *ctx, arg_divuw *a, uint32_t insn)
+static bool trans_divuw(DisasContext *ctx, arg_divuw *a)
 {
 #ifdef TARGET_RISCV64
     return gen_arith_w(ctx, a, &gen_divu);
@@ -106,7 +106,7 @@ static bool trans_divuw(DisasContext *ctx, arg_divuw *a, uint32_t insn)
 #endif
 }
 
-static bool trans_remw(DisasContext *ctx, arg_remw *a, uint32_t insn)
+static bool trans_remw(DisasContext *ctx, arg_remw *a)
 {
 #ifdef TARGET_RISCV64
     return gen_arith_w(ctx, a, &gen_rem);
@@ -115,7 +115,7 @@ static bool trans_remw(DisasContext *ctx, arg_remw *a, uint32_t insn)
 #endif
 }
 
-static bool trans_remuw(DisasContext *ctx, arg_remuw *a, uint32_t insn)
+static bool trans_remuw(DisasContext *ctx, arg_remuw *a)
 {
 #ifdef TARGET_RISCV64
     return gen_arith_w(ctx, a, &gen_remu);
-- 
2.17.2
