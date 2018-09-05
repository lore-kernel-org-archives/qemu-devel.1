Received: from eggs.gnu.org ([2001:4830:134:3::10]:57914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsB-00064I-E0
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMs5-0006wg-EV
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:43 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a]:40291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMs3-0006th-GH
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:40 -0400
Received: by mail-lf1-x12a.google.com with SMTP id x26-v6so4576157lfi.7
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:39 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:45 -0700
Message-Id: <20180905014352.970-9-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 08/15] target/xtensa: extract test for
 cpdisabled exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

- add XtensaOpcodeOps::coprocessor with bitmask of coprocessors used by
  the instruction;
- replace coprocessor id parameter of gen_check_cpenable with the
  bitmask of used coprocessors;
- collect coprocessor IDs used by an instruction in the disassembly
  loop;
- put test for coprocessor disabled exception after the alloca test;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |   1 +
 target/xtensa/translate.c | 230 ++++++++++++++++++++++++----------------------
 2 files changed, 123 insertions(+), 108 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index be234958a228..34e5ccd9f1d6 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -381,6 +381,7 @@ typedef struct XtensaOpcodeOps {
     const uint32_t *par;
     uint32_t op_flags;
     uint32_t windowed_register_op;
+    uint32_t coprocessor;
 } XtensaOpcodeOps;
 
 typedef struct XtensaOpcodeTranslators {
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 9b59f35a1de7..eb123f68b364 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -351,11 +351,12 @@ static bool gen_check_privilege(DisasContext *dc)
     return false;
 }
 
-static bool gen_check_cpenable(DisasContext *dc, unsigned cp)
+static bool gen_check_cpenable(DisasContext *dc, uint32_t cp_mask)
 {
-    if (option_enabled(dc, XTENSA_OPTION_COPROCESSOR) &&
-            !(dc->cpenable & (1 << cp))) {
-        gen_exception_cause(dc, COPROCESSOR0_DISABLED + cp);
+    cp_mask &= ~dc->cpenable;
+
+    if (option_enabled(dc, XTENSA_OPTION_COPROCESSOR) && cp_mask) {
+        gen_exception_cause(dc, COPROCESSOR0_DISABLED + ctz32(cp_mask));
         dc->base.is_jmp = DISAS_NORETURN;
         return false;
     }
@@ -953,6 +954,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     } slot_prop[MAX_INSN_SLOTS];
     uint32_t debug_cause = 0;
     uint32_t windowed_register = 0;
+    uint32_t coprocessor = 0;
 
     if (len == XTENSA_UNDEFINED) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -1050,6 +1052,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                 reg_opnd ^= 1 << i;
             }
         }
+        coprocessor |= ops->coprocessor;
     }
 
     if ((op_flags & XTENSA_OP_PRIVILEGED) &&
@@ -1085,6 +1088,10 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         tcg_temp_free(tmp);
     }
 
+    if (coprocessor && !gen_check_cpenable(dc, coprocessor)) {
+        return;
+    }
+
     for (slot = 0; slot < slots; ++slot) {
         XtensaOpcodeOps *ops = slot_prop[slot].ops;
 
@@ -4084,11 +4091,13 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rur,
         .par = (const uint32_t[]){FCR},
         .windowed_register_op = 0x1,
+        .coprocessor = 0x1,
     }, {
         .name = "rur.fsr",
         .translate = translate_rur,
         .par = (const uint32_t[]){FSR},
         .windowed_register_op = 0x1,
+        .coprocessor = 0x1,
     }, {
         .name = "rur.threadptr",
         .translate = translate_rur,
@@ -4805,11 +4814,13 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wur,
         .par = (const uint32_t[]){FCR},
         .windowed_register_op = 0x1,
+        .coprocessor = 0x1,
     }, {
         .name = "wur.fsr",
         .translate = translate_wur,
         .par = (const uint32_t[]){FSR},
         .windowed_register_op = 0x1,
+        .coprocessor = 0x1,
     }, {
         .name = "wur.threadptr",
         .translate = translate_wur,
@@ -5354,18 +5365,14 @@ const XtensaOpcodeTranslators xtensa_core_opcodes = {
 static void translate_abs_s(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        gen_helper_abs_s(cpu_FR[arg[0]], cpu_FR[arg[1]]);
-    }
+    gen_helper_abs_s(cpu_FR[arg[0]], cpu_FR[arg[1]]);
 }
 
 static void translate_add_s(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        gen_helper_add_s(cpu_FR[arg[0]], cpu_env,
-                         cpu_FR[arg[1]], cpu_FR[arg[2]]);
-    }
+    gen_helper_add_s(cpu_FR[arg[0]], cpu_env,
+                     cpu_FR[arg[1]], cpu_FR[arg[2]]);
 }
 
 enum {
@@ -5391,350 +5398,357 @@ static void translate_compare_s(DisasContext *dc, const uint32_t arg[],
         [COMPARE_OLE] = gen_helper_ole_s,
         [COMPARE_ULE] = gen_helper_ule_s,
     };
+    TCGv_i32 bit = tcg_const_i32(1 << arg[0]);
 
-    if (gen_check_cpenable(dc, 0)) {
-        TCGv_i32 bit = tcg_const_i32(1 << arg[0]);
-
-        helper[par[0]](cpu_env, bit, cpu_FR[arg[1]], cpu_FR[arg[2]]);
-        tcg_temp_free(bit);
-    }
+    helper[par[0]](cpu_env, bit, cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    tcg_temp_free(bit);
 }
 
 static void translate_float_s(DisasContext *dc, const uint32_t arg[],
                               const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        TCGv_i32 scale = tcg_const_i32(-arg[2]);
+    TCGv_i32 scale = tcg_const_i32(-arg[2]);
 
-        if (par[0]) {
-            gen_helper_uitof(cpu_FR[arg[0]], cpu_env, cpu_R[arg[1]], scale);
-        } else {
-            gen_helper_itof(cpu_FR[arg[0]], cpu_env, cpu_R[arg[1]], scale);
-        }
-        tcg_temp_free(scale);
+    if (par[0]) {
+        gen_helper_uitof(cpu_FR[arg[0]], cpu_env, cpu_R[arg[1]], scale);
+    } else {
+        gen_helper_itof(cpu_FR[arg[0]], cpu_env, cpu_R[arg[1]], scale);
     }
+    tcg_temp_free(scale);
 }
 
 static void translate_ftoi_s(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        TCGv_i32 rounding_mode = tcg_const_i32(par[0]);
-        TCGv_i32 scale = tcg_const_i32(arg[2]);
+    TCGv_i32 rounding_mode = tcg_const_i32(par[0]);
+    TCGv_i32 scale = tcg_const_i32(arg[2]);
 
-        if (par[1]) {
-            gen_helper_ftoui(cpu_R[arg[0]], cpu_FR[arg[1]],
-                             rounding_mode, scale);
-        } else {
-            gen_helper_ftoi(cpu_R[arg[0]], cpu_FR[arg[1]],
-                            rounding_mode, scale);
-        }
-        tcg_temp_free(rounding_mode);
-        tcg_temp_free(scale);
+    if (par[1]) {
+        gen_helper_ftoui(cpu_R[arg[0]], cpu_FR[arg[1]],
+                         rounding_mode, scale);
+    } else {
+        gen_helper_ftoi(cpu_R[arg[0]], cpu_FR[arg[1]],
+                        rounding_mode, scale);
     }
+    tcg_temp_free(rounding_mode);
+    tcg_temp_free(scale);
 }
 
 static void translate_ldsti(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        TCGv_i32 addr = tcg_temp_new_i32();
+    TCGv_i32 addr = tcg_temp_new_i32();
 
-        tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
-        gen_load_store_alignment(dc, 2, addr, false);
-        if (par[0]) {
-            tcg_gen_qemu_st32(cpu_FR[arg[0]], addr, dc->cring);
-        } else {
-            tcg_gen_qemu_ld32u(cpu_FR[arg[0]], addr, dc->cring);
-        }
-        if (par[1]) {
-            tcg_gen_mov_i32(cpu_R[arg[1]], addr);
-        }
-        tcg_temp_free(addr);
+    tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+    gen_load_store_alignment(dc, 2, addr, false);
+    if (par[0]) {
+        tcg_gen_qemu_st32(cpu_FR[arg[0]], addr, dc->cring);
+    } else {
+        tcg_gen_qemu_ld32u(cpu_FR[arg[0]], addr, dc->cring);
     }
+    if (par[1]) {
+        tcg_gen_mov_i32(cpu_R[arg[1]], addr);
+    }
+    tcg_temp_free(addr);
 }
 
 static void translate_ldstx(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        TCGv_i32 addr = tcg_temp_new_i32();
+    TCGv_i32 addr = tcg_temp_new_i32();
 
-        tcg_gen_add_i32(addr, cpu_R[arg[1]], cpu_R[arg[2]]);
-        gen_load_store_alignment(dc, 2, addr, false);
-        if (par[0]) {
-            tcg_gen_qemu_st32(cpu_FR[arg[0]], addr, dc->cring);
-        } else {
-            tcg_gen_qemu_ld32u(cpu_FR[arg[0]], addr, dc->cring);
-        }
-        if (par[1]) {
-            tcg_gen_mov_i32(cpu_R[arg[1]], addr);
-        }
-        tcg_temp_free(addr);
+    tcg_gen_add_i32(addr, cpu_R[arg[1]], cpu_R[arg[2]]);
+    gen_load_store_alignment(dc, 2, addr, false);
+    if (par[0]) {
+        tcg_gen_qemu_st32(cpu_FR[arg[0]], addr, dc->cring);
+    } else {
+        tcg_gen_qemu_ld32u(cpu_FR[arg[0]], addr, dc->cring);
+    }
+    if (par[1]) {
+        tcg_gen_mov_i32(cpu_R[arg[1]], addr);
     }
+    tcg_temp_free(addr);
 }
 
 static void translate_madd_s(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        gen_helper_madd_s(cpu_FR[arg[0]], cpu_env,
-                          cpu_FR[arg[0]], cpu_FR[arg[1]], cpu_FR[arg[2]]);
-    }
+    gen_helper_madd_s(cpu_FR[arg[0]], cpu_env,
+                      cpu_FR[arg[0]], cpu_FR[arg[1]], cpu_FR[arg[2]]);
 }
 
 static void translate_mov_s(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        tcg_gen_mov_i32(cpu_FR[arg[0]], cpu_FR[arg[1]]);
-    }
+    tcg_gen_mov_i32(cpu_FR[arg[0]], cpu_FR[arg[1]]);
 }
 
 static void translate_movcond_s(DisasContext *dc, const uint32_t arg[],
                                 const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 zero = tcg_const_i32(0);
 
-        tcg_gen_movcond_i32(par[0], cpu_FR[arg[0]],
-                            cpu_R[arg[2]], zero,
-                            cpu_FR[arg[1]], cpu_FR[arg[0]]);
-        tcg_temp_free(zero);
-    }
+    tcg_gen_movcond_i32(par[0], cpu_FR[arg[0]],
+                        cpu_R[arg[2]], zero,
+                        cpu_FR[arg[1]], cpu_FR[arg[0]]);
+    tcg_temp_free(zero);
 }
 
 static void translate_movp_s(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        TCGv_i32 zero = tcg_const_i32(0);
-        TCGv_i32 tmp = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-        tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2]);
-        tcg_gen_movcond_i32(par[0],
-                            cpu_FR[arg[0]], tmp, zero,
-                            cpu_FR[arg[1]], cpu_FR[arg[0]]);
-        tcg_temp_free(tmp);
-        tcg_temp_free(zero);
-    }
+    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2]);
+    tcg_gen_movcond_i32(par[0],
+                        cpu_FR[arg[0]], tmp, zero,
+                        cpu_FR[arg[1]], cpu_FR[arg[0]]);
+    tcg_temp_free(tmp);
+    tcg_temp_free(zero);
 }
 
 static void translate_mul_s(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        gen_helper_mul_s(cpu_FR[arg[0]], cpu_env,
-                         cpu_FR[arg[1]], cpu_FR[arg[2]]);
-    }
+    gen_helper_mul_s(cpu_FR[arg[0]], cpu_env,
+                     cpu_FR[arg[1]], cpu_FR[arg[2]]);
 }
 
 static void translate_msub_s(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        gen_helper_msub_s(cpu_FR[arg[0]], cpu_env,
-                          cpu_FR[arg[0]], cpu_FR[arg[1]], cpu_FR[arg[2]]);
-    }
+    gen_helper_msub_s(cpu_FR[arg[0]], cpu_env,
+                      cpu_FR[arg[0]], cpu_FR[arg[1]], cpu_FR[arg[2]]);
 }
 
 static void translate_neg_s(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        gen_helper_neg_s(cpu_FR[arg[0]], cpu_FR[arg[1]]);
-    }
+    gen_helper_neg_s(cpu_FR[arg[0]], cpu_FR[arg[1]]);
 }
 
 static void translate_rfr_s(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        tcg_gen_mov_i32(cpu_R[arg[0]], cpu_FR[arg[1]]);
-    }
+    tcg_gen_mov_i32(cpu_R[arg[0]], cpu_FR[arg[1]]);
 }
 
 static void translate_sub_s(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        gen_helper_sub_s(cpu_FR[arg[0]], cpu_env,
-                         cpu_FR[arg[1]], cpu_FR[arg[2]]);
-    }
+    gen_helper_sub_s(cpu_FR[arg[0]], cpu_env,
+                     cpu_FR[arg[1]], cpu_FR[arg[2]]);
 }
 
 static void translate_wfr_s(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_cpenable(dc, 0)) {
-        tcg_gen_mov_i32(cpu_FR[arg[0]], cpu_R[arg[1]]);
-    }
+    tcg_gen_mov_i32(cpu_FR[arg[0]], cpu_R[arg[1]]);
 }
 
 static const XtensaOpcodeOps fpu2000_ops[] = {
     {
         .name = "abs.s",
         .translate = translate_abs_s,
+        .coprocessor = 0x1,
     }, {
         .name = "add.s",
         .translate = translate_add_s,
+        .coprocessor = 0x1,
     }, {
         .name = "ceil.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_up, false},
         .windowed_register_op = 0x1,
+        .coprocessor = 0x1,
     }, {
         .name = "float.s",
         .translate = translate_float_s,
         .par = (const uint32_t[]){false},
         .windowed_register_op = 0x2,
+        .coprocessor = 0x1,
     }, {
         .name = "floor.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_down, false},
         .windowed_register_op = 0x1,
+        .coprocessor = 0x1,
     }, {
         .name = "lsi",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){false, false},
         .windowed_register_op = 0x2,
+        .coprocessor = 0x1,
     }, {
         .name = "lsiu",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){false, true},
         .windowed_register_op = 0x2,
+        .coprocessor = 0x1,
     }, {
         .name = "lsx",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){false, false},
         .windowed_register_op = 0x6,
+        .coprocessor = 0x1,
     }, {
         .name = "lsxu",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){false, true},
         .windowed_register_op = 0x6,
+        .coprocessor = 0x1,
     }, {
         .name = "madd.s",
         .translate = translate_madd_s,
+        .coprocessor = 0x1,
     }, {
         .name = "mov.s",
         .translate = translate_mov_s,
+        .coprocessor = 0x1,
     }, {
         .name = "moveqz.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_EQ},
         .windowed_register_op = 0x4,
+        .coprocessor = 0x1,
     }, {
         .name = "movf.s",
         .translate = translate_movp_s,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .coprocessor = 0x1,
     }, {
         .name = "movgez.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_GE},
         .windowed_register_op = 0x4,
+        .coprocessor = 0x1,
     }, {
         .name = "movltz.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_LT},
         .windowed_register_op = 0x4,
+        .coprocessor = 0x1,
     }, {
         .name = "movnez.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_NE},
         .windowed_register_op = 0x4,
+        .coprocessor = 0x1,
     }, {
         .name = "movt.s",
         .translate = translate_movp_s,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .coprocessor = 0x1,
     }, {
         .name = "msub.s",
         .translate = translate_msub_s,
+        .coprocessor = 0x1,
     }, {
         .name = "mul.s",
         .translate = translate_mul_s,
+        .coprocessor = 0x1,
     }, {
         .name = "neg.s",
         .translate = translate_neg_s,
+        .coprocessor = 0x1,
     }, {
         .name = "oeq.s",
         .translate = translate_compare_s,
         .par = (const uint32_t[]){COMPARE_OEQ},
+        .coprocessor = 0x1,
     }, {
         .name = "ole.s",
         .translate = translate_compare_s,
         .par = (const uint32_t[]){COMPARE_OLE},
+        .coprocessor = 0x1,
     }, {
         .name = "olt.s",
         .translate = translate_compare_s,
         .par = (const uint32_t[]){COMPARE_OLT},
+        .coprocessor = 0x1,
     }, {
         .name = "rfr",
         .translate = translate_rfr_s,
         .windowed_register_op = 0x1,
+        .coprocessor = 0x1,
     }, {
         .name = "round.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_nearest_even, false},
         .windowed_register_op = 0x1,
+        .coprocessor = 0x1,
     }, {
         .name = "ssi",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){true, false},
         .windowed_register_op = 0x2,
+        .coprocessor = 0x1,
     }, {
         .name = "ssiu",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){true, true},
         .windowed_register_op = 0x2,
+        .coprocessor = 0x1,
     }, {
         .name = "ssx",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){true, false},
         .windowed_register_op = 0x6,
+        .coprocessor = 0x1,
     }, {
         .name = "ssxu",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){true, true},
         .windowed_register_op = 0x6,
+        .coprocessor = 0x1,
     }, {
         .name = "sub.s",
         .translate = translate_sub_s,
+        .coprocessor = 0x1,
     }, {
         .name = "trunc.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_to_zero, false},
         .windowed_register_op = 0x1,
+        .coprocessor = 0x1,
     }, {
         .name = "ueq.s",
         .translate = translate_compare_s,
         .par = (const uint32_t[]){COMPARE_UEQ},
+        .coprocessor = 0x1,
     }, {
         .name = "ufloat.s",
         .translate = translate_float_s,
         .par = (const uint32_t[]){true},
         .windowed_register_op = 0x2,
+        .coprocessor = 0x1,
     }, {
         .name = "ule.s",
         .translate = translate_compare_s,
         .par = (const uint32_t[]){COMPARE_ULE},
+        .coprocessor = 0x1,
     }, {
         .name = "ult.s",
         .translate = translate_compare_s,
         .par = (const uint32_t[]){COMPARE_ULT},
+        .coprocessor = 0x1,
     }, {
         .name = "un.s",
         .translate = translate_compare_s,
         .par = (const uint32_t[]){COMPARE_UN},
+        .coprocessor = 0x1,
     }, {
         .name = "utrunc.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_to_zero, true},
         .windowed_register_op = 0x1,
+        .coprocessor = 0x1,
     }, {
         .name = "wfr",
         .translate = translate_wfr_s,
         .windowed_register_op = 0x2,
+        .coprocessor = 0x1,
     },
 };
 
-- 
2.11.0
