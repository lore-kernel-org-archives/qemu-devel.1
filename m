Received: from eggs.gnu.org ([209.51.188.92]:49516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8n-00035F-A7
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ08-00058a-2s
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:09 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:42116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ07-00056v-FG
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:03 -0500
Received: by mail-lj1-x241.google.com with SMTP id l7-v6so6723855ljg.9
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:01:03 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:56 -0800
Message-Id: <20190214230000.24894-10-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 09/13] target/xtensa: reorganize register
 handling in translators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

To support circular register dependencies in FLIX bundles opcode inputs
and outputs must be separate and adjustable. Circular dependencies can
be broken by making temporary copies of opcode inputs and substituting
them into the arguments array instead of the original registers.

E.g. the circular register dependency in the following bundle:

  { mov a2, a3 ; mov a3, a2 }

can be resolved by making copy a2' = a2 and substituting it as input
argument of the second opcode:

  { mov a2, a3 ; mov a3, a2' }

Change opcode translator prototype to accept OpcodeArg array as
argument. For each register argument initialize OpcodeArg::{in,out} with
TCGv_* of the respective register. Don't explicitly use cpu_R in the
opcode translators, use OpcodeArg::{in,out} instead.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  15 +-
 target/xtensa/helper.c    |  15 +
 target/xtensa/translate.c | 700 ++++++++++++++++++++++++----------------------
 3 files changed, 386 insertions(+), 344 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index dca4e4b1114b..bf021f7695e6 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -345,14 +345,21 @@ typedef struct XtensaMemory {
     } location[MAX_NMEMORY];
 } XtensaMemory;
 
+typedef struct opcode_arg {
+    uint32_t imm;
+    uint32_t raw_imm;
+    void *in;
+    void *out;
+} OpcodeArg;
+
 typedef struct DisasContext DisasContext;
-typedef void (*XtensaOpcodeOp)(DisasContext *dc, const uint32_t arg[],
+typedef void (*XtensaOpcodeOp)(DisasContext *dc, const OpcodeArg arg[],
                                const uint32_t par[]);
 typedef bool (*XtensaOpcodeBoolTest)(DisasContext *dc,
-                                     const uint32_t arg[],
+                                     const OpcodeArg arg[],
                                      const uint32_t par[]);
 typedef uint32_t (*XtensaOpcodeUintTest)(DisasContext *dc,
-                                         const uint32_t arg[],
+                                         const OpcodeArg arg[],
                                          const uint32_t par[]);
 
 enum {
@@ -450,6 +457,7 @@ struct XtensaConfig {
     XtensaOpcodeOps **opcode_ops;
     const XtensaOpcodeTranslators **opcode_translators;
     xtensa_regfile a_regfile;
+    void ***regfile;
 
     uint32_t clock_freq_khz;
 
@@ -578,6 +586,7 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
     XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_NOMMU_MODEL)
 
 void xtensa_translate_init(void);
+void **xtensa_get_regfile_by_name(const char *name);
 void xtensa_breakpoint_handler(CPUState *cs);
 void xtensa_register_core(XtensaConfigList *node);
 void xtensa_sim_open_console(Chardev *chr);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 7008c6390d20..f4867a9b5631 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -91,11 +91,13 @@ static void init_libisa(XtensaConfig *config)
     unsigned i, j;
     unsigned opcodes;
     unsigned formats;
+    unsigned regfiles;
 
     config->isa = xtensa_isa_init(config->isa_internal, NULL, NULL);
     assert(xtensa_isa_maxlength(config->isa) <= MAX_INSN_LENGTH);
     opcodes = xtensa_isa_num_opcodes(config->isa);
     formats = xtensa_isa_num_formats(config->isa);
+    regfiles = xtensa_isa_num_regfiles(config->isa);
     config->opcode_ops = g_new(XtensaOpcodeOps *, opcodes);
 
     for (i = 0; i < formats; ++i) {
@@ -125,6 +127,19 @@ static void init_libisa(XtensaConfig *config)
         config->opcode_ops[i] = ops;
     }
     config->a_regfile = xtensa_regfile_lookup(config->isa, "AR");
+
+    config->regfile = g_new(void **, regfiles);
+    for (i = 0; i < regfiles; ++i) {
+        const char *name = xtensa_regfile_name(config->isa, i);
+
+        config->regfile[i] = xtensa_get_regfile_by_name(name);
+#ifdef DEBUG
+        if (config->regfile[i] == NULL) {
+            fprintf(stderr, "regfile '%s' not found for %s\n",
+                    name, config->name);
+        }
+#endif
+    }
 }
 
 static void xtensa_finalize_config(XtensaConfig *config)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index f991cc360889..253777468c29 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -72,7 +72,6 @@ struct DisasContext {
     unsigned cpenable;
 
     uint32_t op_flags;
-    uint32_t *raw_arg;
     xtensa_insnbuf insnbuf;
     xtensa_insnbuf slotbuf;
 };
@@ -84,6 +83,8 @@ static TCGv_i32 cpu_SR[256];
 static TCGv_i32 cpu_UR[256];
 static TCGv_i32 cpu_windowbase_next;
 
+static GHashTable *xtensa_regfile_table;
+
 #include "exec/gen-icount.h"
 
 typedef struct XtensaReg {
@@ -261,6 +262,18 @@ void xtensa_translate_init(void)
                                "windowbase_next");
 }
 
+void **xtensa_get_regfile_by_name(const char *name)
+{
+    if (xtensa_regfile_table == NULL) {
+        xtensa_regfile_table = g_hash_table_new(g_str_hash, g_str_equal);
+        g_hash_table_insert(xtensa_regfile_table,
+                            (void *)"AR", (void *)cpu_R);
+        g_hash_table_insert(xtensa_regfile_table,
+                            (void *)"FR", (void *)cpu_FR);
+    }
+    return (void **)g_hash_table_lookup(xtensa_regfile_table, (void *)name);
+}
+
 static inline bool option_enabled(DisasContext *dc, int opt)
 {
     return xtensa_option_enabled(dc->config, opt);
@@ -844,11 +857,11 @@ static TCGv_i32 gen_mac16_m(TCGv_i32 v, bool hi, bool is_unsigned)
     return m;
 }
 
-static void gen_zero_check(DisasContext *dc, const uint32_t arg[])
+static void gen_zero_check(DisasContext *dc, const OpcodeArg arg[])
 {
     TCGLabel *label = gen_new_label();
 
-    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[2]], 0, label);
+    tcg_gen_brcondi_i32(TCG_COND_NE, arg[2].in, 0, label);
     gen_exception_cause(dc, INTEGER_DIVIDE_BY_ZERO_CAUSE);
     gen_set_label(label);
 }
@@ -881,8 +894,7 @@ struct opcode_arg_info {
 
 struct slot_prop {
     XtensaOpcodeOps *ops;
-    uint32_t arg[MAX_OPCODE_ARGS];
-    uint32_t raw_arg[MAX_OPCODE_ARGS];
+    OpcodeArg arg[MAX_OPCODE_ARGS];
     struct opcode_arg_info in[MAX_OPCODE_ARGS];
     struct opcode_arg_info out[MAX_OPCODE_ARGS];
     unsigned n_in;
@@ -1064,12 +1076,9 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     for (slot = 0; slot < slots; ++slot) {
         xtensa_opcode opc;
         int opnd, vopnd, opnds;
-        uint32_t *raw_arg = slot_prop[slot].raw_arg;
-        uint32_t *arg = slot_prop[slot].arg;
+        OpcodeArg *arg = slot_prop[slot].arg;
         XtensaOpcodeOps *ops;
 
-        dc->raw_arg = raw_arg;
-
         xtensa_format_get_slot(isa, fmt, slot, dc->insnbuf, dc->slotbuf);
         opc = xtensa_opcode_decode(isa, fmt, slot, dc->slotbuf);
         if (opc == XTENSA_UNDEFINED) {
@@ -1082,15 +1091,21 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         opnds = xtensa_opcode_num_operands(isa, opc);
 
         for (opnd = vopnd = 0; opnd < opnds; ++opnd) {
-            if (xtensa_operand_is_register(isa, opc, opnd) &&
-                xtensa_operand_regfile(isa, opc, opnd) ==
-                dc->config->a_regfile) {
-                uint32_t v;
+            void **register_file = NULL;
 
-                xtensa_operand_get_field(isa, opc, opnd, fmt, slot,
-                                         dc->slotbuf, &v);
-                xtensa_operand_decode(isa, opc, opnd, &v);
-                windowed_register |= 1u << v;
+            if (xtensa_operand_is_register(isa, opc, opnd)) {
+                xtensa_regfile rf = xtensa_operand_regfile(isa, opc, opnd);
+
+                register_file = dc->config->regfile[rf];
+
+                if (rf == dc->config->a_regfile) {
+                    uint32_t v;
+
+                    xtensa_operand_get_field(isa, opc, opnd, fmt, slot,
+                                             dc->slotbuf, &v);
+                    xtensa_operand_decode(isa, opc, opnd, &v);
+                    windowed_register |= 1u << v;
+                }
             }
             if (xtensa_operand_is_visible(isa, opc, opnd)) {
                 uint32_t v;
@@ -1098,11 +1113,15 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                 xtensa_operand_get_field(isa, opc, opnd, fmt, slot,
                                          dc->slotbuf, &v);
                 xtensa_operand_decode(isa, opc, opnd, &v);
-                raw_arg[vopnd] = v;
+                arg[vopnd].raw_imm = v;
                 if (xtensa_operand_is_PCrelative(isa, opc, opnd)) {
                     xtensa_operand_undo_reloc(isa, opc, opnd, &v, dc->pc);
                 }
-                arg[vopnd] = v;
+                arg[vopnd].imm = v;
+                if (register_file) {
+                    arg[vopnd].in = register_file[v];
+                    arg[vopnd].out = register_file[v];
+                }
                 ++vopnd;
             }
         }
@@ -1244,7 +1263,6 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         struct slot_prop *pslot = ordered[slot];
         XtensaOpcodeOps *ops = pslot->ops;
 
-        dc->raw_arg = pslot->raw_arg;
         ops->translate(dc, pslot->arg, ops->par);
     }
 
@@ -1510,91 +1528,91 @@ void restore_state_to_opc(CPUXtensaState *env, TranslationBlock *tb,
     env->pc = data[0];
 }
 
-static void translate_abs(DisasContext *dc, const uint32_t arg[],
+static void translate_abs(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     TCGv_i32 zero = tcg_const_i32(0);
     TCGv_i32 neg = tcg_temp_new_i32();
 
-    tcg_gen_neg_i32(neg, cpu_R[arg[1]]);
-    tcg_gen_movcond_i32(TCG_COND_GE, cpu_R[arg[0]],
-                        cpu_R[arg[1]], zero, cpu_R[arg[1]], neg);
+    tcg_gen_neg_i32(neg, arg[1].in);
+    tcg_gen_movcond_i32(TCG_COND_GE, arg[0].out,
+                        arg[1].in, zero, arg[1].in, neg);
     tcg_temp_free(neg);
     tcg_temp_free(zero);
 }
 
-static void translate_add(DisasContext *dc, const uint32_t arg[],
+static void translate_add(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    tcg_gen_add_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_add_i32(arg[0].out, arg[1].in, arg[2].in);
 }
 
-static void translate_addi(DisasContext *dc, const uint32_t arg[],
+static void translate_addi(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_addi_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
+    tcg_gen_addi_i32(arg[0].out, arg[1].in, arg[2].imm);
 }
 
-static void translate_addx(DisasContext *dc, const uint32_t arg[],
+static void translate_addx(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_shli_i32(tmp, cpu_R[arg[1]], par[0]);
-    tcg_gen_add_i32(cpu_R[arg[0]], tmp, cpu_R[arg[2]]);
+    tcg_gen_shli_i32(tmp, arg[1].in, par[0]);
+    tcg_gen_add_i32(arg[0].out, tmp, arg[2].in);
     tcg_temp_free(tmp);
 }
 
-static void translate_all(DisasContext *dc, const uint32_t arg[],
+static void translate_all(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     uint32_t shift = par[1];
-    TCGv_i32 mask = tcg_const_i32(((1 << shift) - 1) << arg[1]);
+    TCGv_i32 mask = tcg_const_i32(((1 << shift) - 1) << arg[1].imm);
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     tcg_gen_and_i32(tmp, cpu_SR[BR], mask);
     if (par[0]) {
-        tcg_gen_addi_i32(tmp, tmp, 1 << arg[1]);
+        tcg_gen_addi_i32(tmp, tmp, 1 << arg[1].imm);
     } else {
         tcg_gen_add_i32(tmp, tmp, mask);
     }
-    tcg_gen_shri_i32(tmp, tmp, arg[1] + shift);
+    tcg_gen_shri_i32(tmp, tmp, arg[1].imm + shift);
     tcg_gen_deposit_i32(cpu_SR[BR], cpu_SR[BR],
-                        tmp, arg[0], 1);
+                        tmp, arg[0].imm, 1);
     tcg_temp_free(mask);
     tcg_temp_free(tmp);
 }
 
-static void translate_and(DisasContext *dc, const uint32_t arg[],
+static void translate_and(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    tcg_gen_and_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_and_i32(arg[0].out, arg[1].in, arg[2].in);
 }
 
-static void translate_ball(DisasContext *dc, const uint32_t arg[],
+static void translate_ball(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_and_i32(tmp, cpu_R[arg[0]], cpu_R[arg[1]]);
-    gen_brcond(dc, par[0], tmp, cpu_R[arg[1]], arg[2]);
+    tcg_gen_and_i32(tmp, arg[0].in, arg[1].in);
+    gen_brcond(dc, par[0], tmp, arg[1].in, arg[2].imm);
     tcg_temp_free(tmp);
 }
 
-static void translate_bany(DisasContext *dc, const uint32_t arg[],
+static void translate_bany(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_and_i32(tmp, cpu_R[arg[0]], cpu_R[arg[1]]);
-    gen_brcondi(dc, par[0], tmp, 0, arg[2]);
+    tcg_gen_and_i32(tmp, arg[0].in, arg[1].in);
+    gen_brcondi(dc, par[0], tmp, 0, arg[2].imm);
     tcg_temp_free(tmp);
 }
 
-static void translate_b(DisasContext *dc, const uint32_t arg[],
+static void translate_b(DisasContext *dc, const OpcodeArg arg[],
                         const uint32_t par[])
 {
-    gen_brcond(dc, par[0], cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
+    gen_brcond(dc, par[0], arg[0].in, arg[1].in, arg[2].imm);
 }
 
-static void translate_bb(DisasContext *dc, const uint32_t arg[],
+static void translate_bb(DisasContext *dc, const OpcodeArg arg[],
                          const uint32_t par[])
 {
 #ifdef TARGET_WORDS_BIGENDIAN
@@ -1603,41 +1621,41 @@ static void translate_bb(DisasContext *dc, const uint32_t arg[],
     TCGv_i32 bit = tcg_const_i32(0x00000001u);
 #endif
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_andi_i32(tmp, cpu_R[arg[1]], 0x1f);
+    tcg_gen_andi_i32(tmp, arg[1].in, 0x1f);
 #ifdef TARGET_WORDS_BIGENDIAN
     tcg_gen_shr_i32(bit, bit, tmp);
 #else
     tcg_gen_shl_i32(bit, bit, tmp);
 #endif
-    tcg_gen_and_i32(tmp, cpu_R[arg[0]], bit);
-    gen_brcondi(dc, par[0], tmp, 0, arg[2]);
+    tcg_gen_and_i32(tmp, arg[0].in, bit);
+    gen_brcondi(dc, par[0], tmp, 0, arg[2].imm);
     tcg_temp_free(tmp);
     tcg_temp_free(bit);
 }
 
-static void translate_bbi(DisasContext *dc, const uint32_t arg[],
+static void translate_bbi(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
 #ifdef TARGET_WORDS_BIGENDIAN
-    tcg_gen_andi_i32(tmp, cpu_R[arg[0]], 0x80000000u >> arg[1]);
+    tcg_gen_andi_i32(tmp, arg[0].in, 0x80000000u >> arg[1].imm);
 #else
-    tcg_gen_andi_i32(tmp, cpu_R[arg[0]], 0x00000001u << arg[1]);
+    tcg_gen_andi_i32(tmp, arg[0].in, 0x00000001u << arg[1].imm);
 #endif
-    gen_brcondi(dc, par[0], tmp, 0, arg[2]);
+    gen_brcondi(dc, par[0], tmp, 0, arg[2].imm);
     tcg_temp_free(tmp);
 }
 
-static void translate_bi(DisasContext *dc, const uint32_t arg[],
+static void translate_bi(DisasContext *dc, const OpcodeArg arg[],
                          const uint32_t par[])
 {
-    gen_brcondi(dc, par[0], cpu_R[arg[0]], arg[1], arg[2]);
+    gen_brcondi(dc, par[0], arg[0].in, arg[1].imm, arg[2].imm);
 }
 
-static void translate_bz(DisasContext *dc, const uint32_t arg[],
+static void translate_bz(DisasContext *dc, const OpcodeArg arg[],
                          const uint32_t par[])
 {
-    gen_brcondi(dc, par[0], cpu_R[arg[0]], 0, arg[1]);
+    gen_brcondi(dc, par[0], arg[0].in, 0, arg[1].imm);
 }
 
 enum {
@@ -1648,7 +1666,7 @@ enum {
     BOOLEAN_XOR,
 };
 
-static void translate_boolean(DisasContext *dc, const uint32_t arg[],
+static void translate_boolean(DisasContext *dc, const OpcodeArg arg[],
                               const uint32_t par[])
 {
     static void (* const op[])(TCGv_i32, TCGv_i32, TCGv_i32) = {
@@ -1662,110 +1680,110 @@ static void translate_boolean(DisasContext *dc, const uint32_t arg[],
     TCGv_i32 tmp1 = tcg_temp_new_i32();
     TCGv_i32 tmp2 = tcg_temp_new_i32();
 
-    tcg_gen_shri_i32(tmp1, cpu_SR[BR], arg[1]);
-    tcg_gen_shri_i32(tmp2, cpu_SR[BR], arg[2]);
+    tcg_gen_shri_i32(tmp1, cpu_SR[BR], arg[1].imm);
+    tcg_gen_shri_i32(tmp2, cpu_SR[BR], arg[2].imm);
     op[par[0]](tmp1, tmp1, tmp2);
-    tcg_gen_deposit_i32(cpu_SR[BR], cpu_SR[BR], tmp1, arg[0], 1);
+    tcg_gen_deposit_i32(cpu_SR[BR], cpu_SR[BR], tmp1, arg[0].imm, 1);
     tcg_temp_free(tmp1);
     tcg_temp_free(tmp2);
 }
 
-static void translate_bp(DisasContext *dc, const uint32_t arg[],
+static void translate_bp(DisasContext *dc, const OpcodeArg arg[],
                          const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[0]);
-    gen_brcondi(dc, par[0], tmp, 0, arg[1]);
+    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[0].imm);
+    gen_brcondi(dc, par[0], tmp, 0, arg[1].imm);
     tcg_temp_free(tmp);
 }
 
-static void translate_call0(DisasContext *dc, const uint32_t arg[],
+static void translate_call0(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
     tcg_gen_movi_i32(cpu_R[0], dc->base.pc_next);
-    gen_jumpi(dc, arg[0], 0);
+    gen_jumpi(dc, arg[0].imm, 0);
 }
 
-static void translate_callw(DisasContext *dc, const uint32_t arg[],
+static void translate_callw(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    TCGv_i32 tmp = tcg_const_i32(arg[0]);
-    gen_callw_slot(dc, par[0], tmp, adjust_jump_slot(dc, arg[0], 0));
+    TCGv_i32 tmp = tcg_const_i32(arg[0].imm);
+    gen_callw_slot(dc, par[0], tmp, adjust_jump_slot(dc, arg[0].imm, 0));
     tcg_temp_free(tmp);
 }
 
-static void translate_callx0(DisasContext *dc, const uint32_t arg[],
+static void translate_callx0(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
+    tcg_gen_mov_i32(tmp, arg[0].in);
     tcg_gen_movi_i32(cpu_R[0], dc->base.pc_next);
     gen_jump(dc, tmp);
     tcg_temp_free(tmp);
 }
 
-static void translate_callxw(DisasContext *dc, const uint32_t arg[],
+static void translate_callxw(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
+    tcg_gen_mov_i32(tmp, arg[0].in);
     gen_callw_slot(dc, par[0], tmp, -1);
     tcg_temp_free(tmp);
 }
 
-static void translate_clamps(DisasContext *dc, const uint32_t arg[],
+static void translate_clamps(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-    TCGv_i32 tmp1 = tcg_const_i32(-1u << arg[2]);
-    TCGv_i32 tmp2 = tcg_const_i32((1 << arg[2]) - 1);
+    TCGv_i32 tmp1 = tcg_const_i32(-1u << arg[2].imm);
+    TCGv_i32 tmp2 = tcg_const_i32((1 << arg[2].imm) - 1);
 
-    tcg_gen_smax_i32(tmp1, tmp1, cpu_R[arg[1]]);
-    tcg_gen_smin_i32(cpu_R[arg[0]], tmp1, tmp2);
+    tcg_gen_smax_i32(tmp1, tmp1, arg[1].in);
+    tcg_gen_smin_i32(arg[0].out, tmp1, tmp2);
     tcg_temp_free(tmp1);
     tcg_temp_free(tmp2);
 }
 
-static void translate_clrb_expstate(DisasContext *dc, const uint32_t arg[],
+static void translate_clrb_expstate(DisasContext *dc, const OpcodeArg arg[],
                                     const uint32_t par[])
 {
     /* TODO: GPIO32 may be a part of coprocessor */
-    tcg_gen_andi_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], ~(1u << arg[0]));
+    tcg_gen_andi_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], ~(1u << arg[0].imm));
 }
 
-static void translate_const16(DisasContext *dc, const uint32_t arg[],
+static void translate_const16(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-    TCGv_i32 c = tcg_const_i32(arg[1]);
+    TCGv_i32 c = tcg_const_i32(arg[1].imm);
 
-    tcg_gen_deposit_i32(cpu_R[arg[0]], c, cpu_R[arg[0]], 16, 16);
+    tcg_gen_deposit_i32(arg[0].out, c, arg[0].in, 16, 16);
     tcg_temp_free(c);
 }
 
-static void translate_dcache(DisasContext *dc, const uint32_t arg[],
+static void translate_dcache(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
     TCGv_i32 addr = tcg_temp_new_i32();
     TCGv_i32 res = tcg_temp_new_i32();
 
-    tcg_gen_addi_i32(addr, cpu_R[arg[0]], arg[1]);
+    tcg_gen_addi_i32(addr, arg[0].in, arg[1].imm);
     tcg_gen_qemu_ld8u(res, addr, dc->cring);
     tcg_temp_free(addr);
     tcg_temp_free(res);
 }
 
-static void translate_depbits(DisasContext *dc, const uint32_t arg[],
+static void translate_depbits(DisasContext *dc, const OpcodeArg arg[],
                               const uint32_t par[])
 {
-    tcg_gen_deposit_i32(cpu_R[arg[1]], cpu_R[arg[1]], cpu_R[arg[0]],
-                        arg[2], arg[3]);
+    tcg_gen_deposit_i32(arg[1].out, arg[1].in, arg[0].in,
+                        arg[2].imm, arg[3].imm);
 }
 
-static bool test_ill_entry(DisasContext *dc, const uint32_t arg[],
+static bool test_ill_entry(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    if (arg[0] > 3 || !dc->cwoe) {
+    if (arg[0].imm > 3 || !dc->cwoe) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Illegal entry instruction(pc = %08x)\n", dc->pc);
         return true;
@@ -1774,88 +1792,88 @@ static bool test_ill_entry(DisasContext *dc, const uint32_t arg[],
     }
 }
 
-static uint32_t test_overflow_entry(DisasContext *dc, const uint32_t arg[],
+static uint32_t test_overflow_entry(DisasContext *dc, const OpcodeArg arg[],
                                     const uint32_t par[])
 {
     return 1 << (dc->callinc * 4);
 }
 
-static void translate_entry(DisasContext *dc, const uint32_t arg[],
+static void translate_entry(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
     TCGv_i32 pc = tcg_const_i32(dc->pc);
-    TCGv_i32 s = tcg_const_i32(arg[0]);
-    TCGv_i32 imm = tcg_const_i32(arg[1]);
+    TCGv_i32 s = tcg_const_i32(arg[0].imm);
+    TCGv_i32 imm = tcg_const_i32(arg[1].imm);
     gen_helper_entry(cpu_env, pc, s, imm);
     tcg_temp_free(imm);
     tcg_temp_free(s);
     tcg_temp_free(pc);
 }
 
-static void translate_extui(DisasContext *dc, const uint32_t arg[],
+static void translate_extui(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    int maskimm = (1 << arg[3]) - 1;
+    int maskimm = (1 << arg[3].imm) - 1;
 
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_shri_i32(tmp, cpu_R[arg[1]], arg[2]);
-    tcg_gen_andi_i32(cpu_R[arg[0]], tmp, maskimm);
+    tcg_gen_shri_i32(tmp, arg[1].in, arg[2].imm);
+    tcg_gen_andi_i32(arg[0].out, tmp, maskimm);
     tcg_temp_free(tmp);
 }
 
-static void translate_icache(DisasContext *dc, const uint32_t arg[],
+static void translate_icache(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
     TCGv_i32 addr = tcg_temp_new_i32();
 
     tcg_gen_movi_i32(cpu_pc, dc->pc);
-    tcg_gen_addi_i32(addr, cpu_R[arg[0]], arg[1]);
+    tcg_gen_addi_i32(addr, arg[0].in, arg[1].imm);
     gen_helper_itlb_hit_test(cpu_env, addr);
     tcg_temp_free(addr);
 #endif
 }
 
-static void translate_itlb(DisasContext *dc, const uint32_t arg[],
+static void translate_itlb(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
     TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
-    gen_helper_itlb(cpu_env, cpu_R[arg[0]], dtlb);
+    gen_helper_itlb(cpu_env, arg[0].in, dtlb);
     tcg_temp_free(dtlb);
 #endif
 }
 
-static void translate_j(DisasContext *dc, const uint32_t arg[],
+static void translate_j(DisasContext *dc, const OpcodeArg arg[],
                         const uint32_t par[])
 {
-    gen_jumpi(dc, arg[0], 0);
+    gen_jumpi(dc, arg[0].imm, 0);
 }
 
-static void translate_jx(DisasContext *dc, const uint32_t arg[],
+static void translate_jx(DisasContext *dc, const OpcodeArg arg[],
                          const uint32_t par[])
 {
-    gen_jump(dc, cpu_R[arg[0]]);
+    gen_jump(dc, arg[0].in);
 }
 
-static void translate_l32e(DisasContext *dc, const uint32_t arg[],
+static void translate_l32e(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 addr = tcg_temp_new_i32();
 
-    tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+    tcg_gen_addi_i32(addr, arg[1].in, arg[2].imm);
     gen_load_store_alignment(dc, 2, addr, false);
-    tcg_gen_qemu_ld_tl(cpu_R[arg[0]], addr, dc->ring, MO_TEUL);
+    tcg_gen_qemu_ld_tl(arg[0].out, addr, dc->ring, MO_TEUL);
     tcg_temp_free(addr);
 }
 
-static void translate_ldst(DisasContext *dc, const uint32_t arg[],
+static void translate_ldst(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 addr = tcg_temp_new_i32();
 
-    tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+    tcg_gen_addi_i32(addr, arg[1].in, arg[2].imm);
     if (par[0] & MO_SIZE) {
         gen_load_store_alignment(dc, par[0] & MO_SIZE, addr, par[1]);
     }
@@ -1863,9 +1881,9 @@ static void translate_ldst(DisasContext *dc, const uint32_t arg[],
         if (par[1]) {
             tcg_gen_mb(TCG_BAR_STRL | TCG_MO_ALL);
         }
-        tcg_gen_qemu_st_tl(cpu_R[arg[0]], addr, dc->cring, par[0]);
+        tcg_gen_qemu_st_tl(arg[0].in, addr, dc->cring, par[0]);
     } else {
-        tcg_gen_qemu_ld_tl(cpu_R[arg[0]], addr, dc->cring, par[0]);
+        tcg_gen_qemu_ld_tl(arg[0].out, addr, dc->cring, par[0]);
         if (par[1]) {
             tcg_gen_mb(TCG_BAR_LDAQ | TCG_MO_ALL);
         }
@@ -1873,33 +1891,33 @@ static void translate_ldst(DisasContext *dc, const uint32_t arg[],
     tcg_temp_free(addr);
 }
 
-static void translate_l32r(DisasContext *dc, const uint32_t arg[],
+static void translate_l32r(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 tmp;
 
     if (dc->base.tb->flags & XTENSA_TBFLAG_LITBASE) {
-        tmp = tcg_const_i32(dc->raw_arg[1] - 1);
+        tmp = tcg_const_i32(arg[1].raw_imm - 1);
         tcg_gen_add_i32(tmp, cpu_SR[LITBASE], tmp);
     } else {
-        tmp = tcg_const_i32(arg[1]);
+        tmp = tcg_const_i32(arg[1].imm);
     }
-    tcg_gen_qemu_ld32u(cpu_R[arg[0]], tmp, dc->cring);
+    tcg_gen_qemu_ld32u(arg[0].out, tmp, dc->cring);
     tcg_temp_free(tmp);
 }
 
-static void translate_loop(DisasContext *dc, const uint32_t arg[],
+static void translate_loop(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    uint32_t lend = arg[1];
+    uint32_t lend = arg[1].imm;
 
-    tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_R[arg[0]], 1);
+    tcg_gen_subi_i32(cpu_SR[LCOUNT], arg[0].in, 1);
     tcg_gen_movi_i32(cpu_SR[LBEG], dc->base.pc_next);
     tcg_gen_movi_i32(cpu_SR[LEND], lend);
 
     if (par[0] != TCG_COND_NEVER) {
         TCGLabel *label = gen_new_label();
-        tcg_gen_brcondi_i32(par[0], cpu_R[arg[0]], 0, label);
+        tcg_gen_brcondi_i32(par[0], arg[0].in, 0, label);
         gen_jumpi(dc, lend, 1);
         gen_set_label(label);
     }
@@ -1935,7 +1953,7 @@ enum {
     MAC16_DX = 0x2,
 };
 
-static void translate_mac16(DisasContext *dc, const uint32_t arg[],
+static void translate_mac16(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
     int op = par[0];
@@ -1948,18 +1966,18 @@ static void translate_mac16(DisasContext *dc, const uint32_t arg[],
     TCGv_i32 mem32 = tcg_temp_new_i32();
 
     if (ld_offset) {
-        tcg_gen_addi_i32(vaddr, cpu_R[arg[1]], ld_offset);
+        tcg_gen_addi_i32(vaddr, arg[1].in, ld_offset);
         gen_load_store_alignment(dc, 2, vaddr, false);
         tcg_gen_qemu_ld32u(mem32, vaddr, dc->cring);
     }
     if (op != MAC16_NONE) {
         TCGv_i32 m1 = gen_mac16_m(is_m1_sr ?
-                                  cpu_SR[MR + arg[off]] :
-                                  cpu_R[arg[off]],
+                                  cpu_SR[MR + arg[off].imm] :
+                                  arg[off].in,
                                   half & MAC16_HX, op == MAC16_UMUL);
         TCGv_i32 m2 = gen_mac16_m(is_m2_sr ?
-                                  cpu_SR[MR + arg[off + 1]] :
-                                  cpu_R[arg[off + 1]],
+                                  cpu_SR[MR + arg[off + 1].imm] :
+                                  arg[off + 1].in,
                                   half & MAC16_XH, op == MAC16_UMUL);
 
         if (op == MAC16_MUL || op == MAC16_UMUL) {
@@ -1993,221 +2011,221 @@ static void translate_mac16(DisasContext *dc, const uint32_t arg[],
         tcg_temp_free(m2);
     }
     if (ld_offset) {
-        tcg_gen_mov_i32(cpu_R[arg[1]], vaddr);
-        tcg_gen_mov_i32(cpu_SR[MR + arg[0]], mem32);
+        tcg_gen_mov_i32(arg[1].out, vaddr);
+        tcg_gen_mov_i32(cpu_SR[MR + arg[0].imm], mem32);
     }
     tcg_temp_free(vaddr);
     tcg_temp_free(mem32);
 }
 
-static void translate_memw(DisasContext *dc, const uint32_t arg[],
+static void translate_memw(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
 }
 
-static void translate_smin(DisasContext *dc, const uint32_t arg[],
+static void translate_smin(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_smin_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_smin_i32(arg[0].out, arg[1].in, arg[2].in);
 }
 
-static void translate_umin(DisasContext *dc, const uint32_t arg[],
+static void translate_umin(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_umin_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_umin_i32(arg[0].out, arg[1].in, arg[2].in);
 }
 
-static void translate_smax(DisasContext *dc, const uint32_t arg[],
+static void translate_smax(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_smax_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_smax_i32(arg[0].out, arg[1].in, arg[2].in);
 }
 
-static void translate_umax(DisasContext *dc, const uint32_t arg[],
+static void translate_umax(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_umax_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_umax_i32(arg[0].out, arg[1].in, arg[2].in);
 }
 
-static void translate_mov(DisasContext *dc, const uint32_t arg[],
+static void translate_mov(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    tcg_gen_mov_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+    tcg_gen_mov_i32(arg[0].out, arg[1].in);
 }
 
-static void translate_movcond(DisasContext *dc, const uint32_t arg[],
+static void translate_movcond(DisasContext *dc, const OpcodeArg arg[],
                               const uint32_t par[])
 {
     TCGv_i32 zero = tcg_const_i32(0);
 
-    tcg_gen_movcond_i32(par[0], cpu_R[arg[0]],
-                        cpu_R[arg[2]], zero, cpu_R[arg[1]], cpu_R[arg[0]]);
+    tcg_gen_movcond_i32(par[0], arg[0].out,
+                        arg[2].in, zero, arg[1].in, arg[0].in);
     tcg_temp_free(zero);
 }
 
-static void translate_movi(DisasContext *dc, const uint32_t arg[],
+static void translate_movi(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_movi_i32(cpu_R[arg[0]], arg[1]);
+    tcg_gen_movi_i32(arg[0].out, arg[1].imm);
 }
 
-static void translate_movp(DisasContext *dc, const uint32_t arg[],
+static void translate_movp(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 zero = tcg_const_i32(0);
     TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2]);
+    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2].imm);
     tcg_gen_movcond_i32(par[0],
-                        cpu_R[arg[0]], tmp, zero,
-                        cpu_R[arg[1]], cpu_R[arg[0]]);
+                        arg[0].out, tmp, zero,
+                        arg[1].in, arg[0].in);
     tcg_temp_free(tmp);
     tcg_temp_free(zero);
 }
 
-static void translate_movsp(DisasContext *dc, const uint32_t arg[],
+static void translate_movsp(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    tcg_gen_mov_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+    tcg_gen_mov_i32(arg[0].out, arg[1].in);
 }
 
-static void translate_mul16(DisasContext *dc, const uint32_t arg[],
+static void translate_mul16(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
     TCGv_i32 v1 = tcg_temp_new_i32();
     TCGv_i32 v2 = tcg_temp_new_i32();
 
     if (par[0]) {
-        tcg_gen_ext16s_i32(v1, cpu_R[arg[1]]);
-        tcg_gen_ext16s_i32(v2, cpu_R[arg[2]]);
+        tcg_gen_ext16s_i32(v1, arg[1].in);
+        tcg_gen_ext16s_i32(v2, arg[2].in);
     } else {
-        tcg_gen_ext16u_i32(v1, cpu_R[arg[1]]);
-        tcg_gen_ext16u_i32(v2, cpu_R[arg[2]]);
+        tcg_gen_ext16u_i32(v1, arg[1].in);
+        tcg_gen_ext16u_i32(v2, arg[2].in);
     }
-    tcg_gen_mul_i32(cpu_R[arg[0]], v1, v2);
+    tcg_gen_mul_i32(arg[0].out, v1, v2);
     tcg_temp_free(v2);
     tcg_temp_free(v1);
 }
 
-static void translate_mull(DisasContext *dc, const uint32_t arg[],
+static void translate_mull(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_mul_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_mul_i32(arg[0].out, arg[1].in, arg[2].in);
 }
 
-static void translate_mulh(DisasContext *dc, const uint32_t arg[],
+static void translate_mulh(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 lo = tcg_temp_new();
 
     if (par[0]) {
-        tcg_gen_muls2_i32(lo, cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+        tcg_gen_muls2_i32(lo, arg[0].out, arg[1].in, arg[2].in);
     } else {
-        tcg_gen_mulu2_i32(lo, cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+        tcg_gen_mulu2_i32(lo, arg[0].out, arg[1].in, arg[2].in);
     }
     tcg_temp_free(lo);
 }
 
-static void translate_neg(DisasContext *dc, const uint32_t arg[],
+static void translate_neg(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    tcg_gen_neg_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+    tcg_gen_neg_i32(arg[0].out, arg[1].in);
 }
 
-static void translate_nop(DisasContext *dc, const uint32_t arg[],
+static void translate_nop(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
 }
 
-static void translate_nsa(DisasContext *dc, const uint32_t arg[],
+static void translate_nsa(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    tcg_gen_clrsb_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+    tcg_gen_clrsb_i32(arg[0].out, arg[1].in);
 }
 
-static void translate_nsau(DisasContext *dc, const uint32_t arg[],
+static void translate_nsau(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_clzi_i32(cpu_R[arg[0]], cpu_R[arg[1]], 32);
+    tcg_gen_clzi_i32(arg[0].out, arg[1].in, 32);
 }
 
-static void translate_or(DisasContext *dc, const uint32_t arg[],
+static void translate_or(DisasContext *dc, const OpcodeArg arg[],
                          const uint32_t par[])
 {
-    tcg_gen_or_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_or_i32(arg[0].out, arg[1].in, arg[2].in);
 }
 
-static void translate_ptlb(DisasContext *dc, const uint32_t arg[],
+static void translate_ptlb(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
     TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
     tcg_gen_movi_i32(cpu_pc, dc->pc);
-    gen_helper_ptlb(cpu_R[arg[0]], cpu_env, cpu_R[arg[1]], dtlb);
+    gen_helper_ptlb(arg[0].out, cpu_env, arg[1].in, dtlb);
     tcg_temp_free(dtlb);
 #endif
 }
 
-static void translate_quos(DisasContext *dc, const uint32_t arg[],
+static void translate_quos(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGLabel *label1 = gen_new_label();
     TCGLabel *label2 = gen_new_label();
 
-    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[1]], 0x80000000,
+    tcg_gen_brcondi_i32(TCG_COND_NE, arg[1].in, 0x80000000,
                         label1);
-    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[2]], 0xffffffff,
+    tcg_gen_brcondi_i32(TCG_COND_NE, arg[2].in, 0xffffffff,
                         label1);
-    tcg_gen_movi_i32(cpu_R[arg[0]],
+    tcg_gen_movi_i32(arg[0].out,
                      par[0] ? 0x80000000 : 0);
     tcg_gen_br(label2);
     gen_set_label(label1);
     if (par[0]) {
-        tcg_gen_div_i32(cpu_R[arg[0]],
-                        cpu_R[arg[1]], cpu_R[arg[2]]);
+        tcg_gen_div_i32(arg[0].out,
+                        arg[1].in, arg[2].in);
     } else {
-        tcg_gen_rem_i32(cpu_R[arg[0]],
-                        cpu_R[arg[1]], cpu_R[arg[2]]);
+        tcg_gen_rem_i32(arg[0].out,
+                        arg[1].in, arg[2].in);
     }
     gen_set_label(label2);
 }
 
-static void translate_quou(DisasContext *dc, const uint32_t arg[],
+static void translate_quou(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_divu_i32(cpu_R[arg[0]],
-                     cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_divu_i32(arg[0].out,
+                     arg[1].in, arg[2].in);
 }
 
-static void translate_read_impwire(DisasContext *dc, const uint32_t arg[],
+static void translate_read_impwire(DisasContext *dc, const OpcodeArg arg[],
                                    const uint32_t par[])
 {
     /* TODO: GPIO32 may be a part of coprocessor */
-    tcg_gen_movi_i32(cpu_R[arg[0]], 0);
+    tcg_gen_movi_i32(arg[0].out, 0);
 }
 
-static void translate_remu(DisasContext *dc, const uint32_t arg[],
+static void translate_remu(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_remu_i32(cpu_R[arg[0]],
-                     cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_remu_i32(arg[0].out,
+                     arg[1].in, arg[2].in);
 }
 
-static void translate_rer(DisasContext *dc, const uint32_t arg[],
+static void translate_rer(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    gen_helper_rer(cpu_R[arg[0]], cpu_env, cpu_R[arg[1]]);
+    gen_helper_rer(arg[0].out, cpu_env, arg[1].in);
 }
 
-static void translate_ret(DisasContext *dc, const uint32_t arg[],
+static void translate_ret(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     gen_jump(dc, cpu_R[0]);
 }
 
-static bool test_ill_retw(DisasContext *dc, const uint32_t arg[],
+static bool test_ill_retw(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     if (!dc->cwoe) {
@@ -2223,7 +2241,7 @@ static bool test_ill_retw(DisasContext *dc, const uint32_t arg[],
     }
 }
 
-static void translate_retw(DisasContext *dc, const uint32_t arg[],
+static void translate_retw(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_const_i32(1);
@@ -2237,27 +2255,27 @@ static void translate_retw(DisasContext *dc, const uint32_t arg[],
     tcg_temp_free(tmp);
 }
 
-static void translate_rfde(DisasContext *dc, const uint32_t arg[],
+static void translate_rfde(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     gen_jump(dc, cpu_SR[dc->config->ndepc ? DEPC : EPC1]);
 }
 
-static void translate_rfe(DisasContext *dc, const uint32_t arg[],
+static void translate_rfe(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
     gen_jump(dc, cpu_SR[EPC1]);
 }
 
-static void translate_rfi(DisasContext *dc, const uint32_t arg[],
+static void translate_rfi(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    tcg_gen_mov_i32(cpu_SR[PS], cpu_SR[EPS2 + arg[0] - 2]);
-    gen_jump(dc, cpu_SR[EPC1 + arg[0] - 1]);
+    tcg_gen_mov_i32(cpu_SR[PS], cpu_SR[EPS2 + arg[0].imm - 2]);
+    gen_jump(dc, cpu_SR[EPC1 + arg[0].imm - 1]);
 }
 
-static void translate_rfw(DisasContext *dc, const uint32_t arg[],
+static void translate_rfw(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_const_i32(1);
@@ -2278,33 +2296,33 @@ static void translate_rfw(DisasContext *dc, const uint32_t arg[],
     gen_jump(dc, cpu_SR[EPC1]);
 }
 
-static void translate_rotw(DisasContext *dc, const uint32_t arg[],
+static void translate_rotw(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_addi_i32(cpu_windowbase_next, cpu_SR[WINDOW_BASE], arg[0]);
+    tcg_gen_addi_i32(cpu_windowbase_next, cpu_SR[WINDOW_BASE], arg[0].imm);
 }
 
-static void translate_rsil(DisasContext *dc, const uint32_t arg[],
+static void translate_rsil(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_mov_i32(cpu_R[arg[0]], cpu_SR[PS]);
+    tcg_gen_mov_i32(arg[0].out, cpu_SR[PS]);
     tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_INTLEVEL);
-    tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], arg[1]);
+    tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], arg[1].imm);
 }
 
-static bool test_ill_rsr(DisasContext *dc, const uint32_t arg[],
+static bool test_ill_rsr(DisasContext *dc, const OpcodeArg arg[],
                          const uint32_t par[])
 {
     return !check_sr(dc, par[0], SR_R);
 }
 
-static void translate_rsr(DisasContext *dc, const uint32_t arg[],
+static void translate_rsr(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    gen_rsr(dc, cpu_R[arg[0]], par[0]);
+    gen_rsr(dc, arg[0].out, par[0]);
 }
 
-static void translate_rtlb(DisasContext *dc, const uint32_t arg[],
+static void translate_rtlb(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
@@ -2315,26 +2333,26 @@ static void translate_rtlb(DisasContext *dc, const uint32_t arg[],
     };
     TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
-    helper[par[1]](cpu_R[arg[0]], cpu_env, cpu_R[arg[1]], dtlb);
+    helper[par[1]](arg[0].out, cpu_env, arg[1].in, dtlb);
     tcg_temp_free(dtlb);
 #endif
 }
 
-static void translate_rur(DisasContext *dc, const uint32_t arg[],
+static void translate_rur(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     if (uregnames[par[0]].name) {
-        tcg_gen_mov_i32(cpu_R[arg[0]], cpu_UR[par[0]]);
+        tcg_gen_mov_i32(arg[0].out, cpu_UR[par[0]]);
     } else {
         qemu_log_mask(LOG_UNIMP, "RUR %d not implemented\n", par[0]);
     }
 }
 
-static void translate_setb_expstate(DisasContext *dc, const uint32_t arg[],
+static void translate_setb_expstate(DisasContext *dc, const OpcodeArg arg[],
                                     const uint32_t par[])
 {
     /* TODO: GPIO32 may be a part of coprocessor */
-    tcg_gen_ori_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], 1u << arg[0]);
+    tcg_gen_ori_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], 1u << arg[0].imm);
 }
 
 #ifdef CONFIG_USER_ONLY
@@ -2351,59 +2369,59 @@ static void gen_check_atomctl(DisasContext *dc, TCGv_i32 addr)
 }
 #endif
 
-static void translate_s32c1i(DisasContext *dc, const uint32_t arg[],
+static void translate_s32c1i(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_local_new_i32();
     TCGv_i32 addr = tcg_temp_local_new_i32();
 
-    tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
-    tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+    tcg_gen_mov_i32(tmp, arg[0].in);
+    tcg_gen_addi_i32(addr, arg[1].in, arg[2].imm);
     gen_load_store_alignment(dc, 2, addr, true);
     gen_check_atomctl(dc, addr);
-    tcg_gen_atomic_cmpxchg_i32(cpu_R[arg[0]], addr, cpu_SR[SCOMPARE1],
+    tcg_gen_atomic_cmpxchg_i32(arg[0].out, addr, cpu_SR[SCOMPARE1],
                                tmp, dc->cring, MO_TEUL);
     tcg_temp_free(addr);
     tcg_temp_free(tmp);
 }
 
-static void translate_s32e(DisasContext *dc, const uint32_t arg[],
+static void translate_s32e(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 addr = tcg_temp_new_i32();
 
-    tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+    tcg_gen_addi_i32(addr, arg[1].in, arg[2].imm);
     gen_load_store_alignment(dc, 2, addr, false);
-    tcg_gen_qemu_st_tl(cpu_R[arg[0]], addr, dc->ring, MO_TEUL);
+    tcg_gen_qemu_st_tl(arg[0].in, addr, dc->ring, MO_TEUL);
     tcg_temp_free(addr);
 }
 
-static void translate_salt(DisasContext *dc, const uint32_t arg[],
+static void translate_salt(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     tcg_gen_setcond_i32(par[0],
-                        cpu_R[arg[0]],
-                        cpu_R[arg[1]], cpu_R[arg[2]]);
+                        arg[0].out,
+                        arg[1].in, arg[2].in);
 }
 
-static void translate_sext(DisasContext *dc, const uint32_t arg[],
+static void translate_sext(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    int shift = 31 - arg[2];
+    int shift = 31 - arg[2].imm;
 
     if (shift == 24) {
-        tcg_gen_ext8s_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+        tcg_gen_ext8s_i32(arg[0].out, arg[1].in);
     } else if (shift == 16) {
-        tcg_gen_ext16s_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+        tcg_gen_ext16s_i32(arg[0].out, arg[1].in);
     } else {
         TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_shli_i32(tmp, cpu_R[arg[1]], shift);
-        tcg_gen_sari_i32(cpu_R[arg[0]], tmp, shift);
+        tcg_gen_shli_i32(tmp, arg[1].in, shift);
+        tcg_gen_sari_i32(arg[0].out, tmp, shift);
         tcg_temp_free(tmp);
     }
 }
 
-static bool test_ill_simcall(DisasContext *dc, const uint32_t arg[],
+static bool test_ill_simcall(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
 #ifdef CONFIG_USER_ONLY
@@ -2417,7 +2435,7 @@ static bool test_ill_simcall(DisasContext *dc, const uint32_t arg[],
     return ill;
 }
 
-static void translate_simcall(DisasContext *dc, const uint32_t arg[],
+static void translate_simcall(DisasContext *dc, const OpcodeArg arg[],
                               const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
@@ -2433,73 +2451,73 @@ static void translate_simcall(DisasContext *dc, const uint32_t arg[],
                     TCGv_i64 tmp = tcg_temp_new_i64(); \
                     tcg_gen_extu_i32_i64(tmp, reg); \
                     tcg_gen_##cmd##_i64(v, v, tmp); \
-                    tcg_gen_extrl_i64_i32(cpu_R[arg[0]], v); \
+                    tcg_gen_extrl_i64_i32(arg[0].out, v); \
                     tcg_temp_free_i64(v); \
                     tcg_temp_free_i64(tmp); \
                 } while (0)
 
 #define gen_shift(cmd) gen_shift_reg(cmd, cpu_SR[SAR])
 
-static void translate_sll(DisasContext *dc, const uint32_t arg[],
+static void translate_sll(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     if (dc->sar_m32_5bit) {
-        tcg_gen_shl_i32(cpu_R[arg[0]], cpu_R[arg[1]], dc->sar_m32);
+        tcg_gen_shl_i32(arg[0].out, arg[1].in, dc->sar_m32);
     } else {
         TCGv_i64 v = tcg_temp_new_i64();
         TCGv_i32 s = tcg_const_i32(32);
         tcg_gen_sub_i32(s, s, cpu_SR[SAR]);
         tcg_gen_andi_i32(s, s, 0x3f);
-        tcg_gen_extu_i32_i64(v, cpu_R[arg[1]]);
+        tcg_gen_extu_i32_i64(v, arg[1].in);
         gen_shift_reg(shl, s);
         tcg_temp_free(s);
     }
 }
 
-static void translate_slli(DisasContext *dc, const uint32_t arg[],
+static void translate_slli(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    if (arg[2] == 32) {
+    if (arg[2].imm == 32) {
         qemu_log_mask(LOG_GUEST_ERROR, "slli a%d, a%d, 32 is undefined\n",
-                      arg[0], arg[1]);
+                      arg[0].imm, arg[1].imm);
     }
-    tcg_gen_shli_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2] & 0x1f);
+    tcg_gen_shli_i32(arg[0].out, arg[1].in, arg[2].imm & 0x1f);
 }
 
-static void translate_sra(DisasContext *dc, const uint32_t arg[],
+static void translate_sra(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     if (dc->sar_m32_5bit) {
-        tcg_gen_sar_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_SR[SAR]);
+        tcg_gen_sar_i32(arg[0].out, arg[1].in, cpu_SR[SAR]);
     } else {
         TCGv_i64 v = tcg_temp_new_i64();
-        tcg_gen_ext_i32_i64(v, cpu_R[arg[1]]);
+        tcg_gen_ext_i32_i64(v, arg[1].in);
         gen_shift(sar);
     }
 }
 
-static void translate_srai(DisasContext *dc, const uint32_t arg[],
+static void translate_srai(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_sari_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
+    tcg_gen_sari_i32(arg[0].out, arg[1].in, arg[2].imm);
 }
 
-static void translate_src(DisasContext *dc, const uint32_t arg[],
+static void translate_src(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     TCGv_i64 v = tcg_temp_new_i64();
-    tcg_gen_concat_i32_i64(v, cpu_R[arg[2]], cpu_R[arg[1]]);
+    tcg_gen_concat_i32_i64(v, arg[2].in, arg[1].in);
     gen_shift(shr);
 }
 
-static void translate_srl(DisasContext *dc, const uint32_t arg[],
+static void translate_srl(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     if (dc->sar_m32_5bit) {
-        tcg_gen_shr_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_SR[SAR]);
+        tcg_gen_shr_i32(arg[0].out, arg[1].in, cpu_SR[SAR]);
     } else {
         TCGv_i64 v = tcg_temp_new_i64();
-        tcg_gen_extu_i32_i64(v, cpu_R[arg[1]]);
+        tcg_gen_extu_i32_i64(v, arg[1].in);
         gen_shift(shr);
     }
 }
@@ -2507,138 +2525,138 @@ static void translate_srl(DisasContext *dc, const uint32_t arg[],
 #undef gen_shift
 #undef gen_shift_reg
 
-static void translate_srli(DisasContext *dc, const uint32_t arg[],
+static void translate_srli(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    tcg_gen_shri_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
+    tcg_gen_shri_i32(arg[0].out, arg[1].in, arg[2].imm);
 }
 
-static void translate_ssa8b(DisasContext *dc, const uint32_t arg[],
+static void translate_ssa8b(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_shli_i32(tmp, cpu_R[arg[0]], 3);
+    tcg_gen_shli_i32(tmp, arg[0].in, 3);
     gen_left_shift_sar(dc, tmp);
     tcg_temp_free(tmp);
 }
 
-static void translate_ssa8l(DisasContext *dc, const uint32_t arg[],
+static void translate_ssa8l(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_shli_i32(tmp, cpu_R[arg[0]], 3);
+    tcg_gen_shli_i32(tmp, arg[0].in, 3);
     gen_right_shift_sar(dc, tmp);
     tcg_temp_free(tmp);
 }
 
-static void translate_ssai(DisasContext *dc, const uint32_t arg[],
+static void translate_ssai(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    TCGv_i32 tmp = tcg_const_i32(arg[0]);
+    TCGv_i32 tmp = tcg_const_i32(arg[0].imm);
     gen_right_shift_sar(dc, tmp);
     tcg_temp_free(tmp);
 }
 
-static void translate_ssl(DisasContext *dc, const uint32_t arg[],
+static void translate_ssl(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    gen_left_shift_sar(dc, cpu_R[arg[0]]);
+    gen_left_shift_sar(dc, arg[0].in);
 }
 
-static void translate_ssr(DisasContext *dc, const uint32_t arg[],
+static void translate_ssr(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    gen_right_shift_sar(dc, cpu_R[arg[0]]);
+    gen_right_shift_sar(dc, arg[0].in);
 }
 
-static void translate_sub(DisasContext *dc, const uint32_t arg[],
+static void translate_sub(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    tcg_gen_sub_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_sub_i32(arg[0].out, arg[1].in, arg[2].in);
 }
 
-static void translate_subx(DisasContext *dc, const uint32_t arg[],
+static void translate_subx(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_shli_i32(tmp, cpu_R[arg[1]], par[0]);
-    tcg_gen_sub_i32(cpu_R[arg[0]], tmp, cpu_R[arg[2]]);
+    tcg_gen_shli_i32(tmp, arg[1].in, par[0]);
+    tcg_gen_sub_i32(arg[0].out, tmp, arg[2].in);
     tcg_temp_free(tmp);
 }
 
-static void translate_waiti(DisasContext *dc, const uint32_t arg[],
+static void translate_waiti(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
-    gen_waiti(dc, arg[0]);
+    gen_waiti(dc, arg[0].imm);
 #endif
 }
 
-static void translate_wtlb(DisasContext *dc, const uint32_t arg[],
+static void translate_wtlb(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
     TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
-    gen_helper_wtlb(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]], dtlb);
+    gen_helper_wtlb(cpu_env, arg[0].in, arg[1].in, dtlb);
     tcg_temp_free(dtlb);
 #endif
 }
 
-static void translate_wer(DisasContext *dc, const uint32_t arg[],
+static void translate_wer(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    gen_helper_wer(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]]);
+    gen_helper_wer(cpu_env, arg[0].in, arg[1].in);
 }
 
-static void translate_wrmsk_expstate(DisasContext *dc, const uint32_t arg[],
+static void translate_wrmsk_expstate(DisasContext *dc, const OpcodeArg arg[],
                                      const uint32_t par[])
 {
     /* TODO: GPIO32 may be a part of coprocessor */
-    tcg_gen_and_i32(cpu_UR[EXPSTATE], cpu_R[arg[0]], cpu_R[arg[1]]);
+    tcg_gen_and_i32(cpu_UR[EXPSTATE], arg[0].in, arg[1].in);
 }
 
-static bool test_ill_wsr(DisasContext *dc, const uint32_t arg[],
+static bool test_ill_wsr(DisasContext *dc, const OpcodeArg arg[],
                          const uint32_t par[])
 {
     return !check_sr(dc, par[0], SR_W);
 }
 
-static void translate_wsr(DisasContext *dc, const uint32_t arg[],
+static void translate_wsr(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    gen_wsr(dc, par[0], cpu_R[arg[0]]);
+    gen_wsr(dc, par[0], arg[0].in);
 }
 
-static void translate_wur(DisasContext *dc, const uint32_t arg[],
+static void translate_wur(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     if (uregnames[par[0]].name) {
-        gen_wur(par[0], cpu_R[arg[0]]);
+        gen_wur(par[0], arg[0].in);
     } else {
         qemu_log_mask(LOG_UNIMP, "WUR %d not implemented\n", par[0]);
     }
 }
 
-static void translate_xor(DisasContext *dc, const uint32_t arg[],
+static void translate_xor(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    tcg_gen_xor_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_xor_i32(arg[0].out, arg[1].in, arg[2].in);
 }
 
-static bool test_ill_xsr(DisasContext *dc, const uint32_t arg[],
+static bool test_ill_xsr(DisasContext *dc, const OpcodeArg arg[],
                          const uint32_t par[])
 {
     return !check_sr(dc, par[0], SR_X);
 }
 
-static void translate_xsr(DisasContext *dc, const uint32_t arg[],
+static void translate_xsr(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
-    gen_rsr(dc, cpu_R[arg[0]], par[0]);
+    tcg_gen_mov_i32(tmp, arg[0].in);
+    gen_rsr(dc, arg[0].out, par[0]);
     gen_wsr(dc, par[0], tmp);
     tcg_temp_free(tmp);
 }
@@ -5142,17 +5160,17 @@ const XtensaOpcodeTranslators xtensa_core_opcodes = {
 };
 
 
-static void translate_abs_s(DisasContext *dc, const uint32_t arg[],
+static void translate_abs_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    gen_helper_abs_s(cpu_FR[arg[0]], cpu_FR[arg[1]]);
+    gen_helper_abs_s(arg[0].out, arg[1].in);
 }
 
-static void translate_add_s(DisasContext *dc, const uint32_t arg[],
+static void translate_add_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    gen_helper_add_s(cpu_FR[arg[0]], cpu_env,
-                     cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    gen_helper_add_s(arg[0].out, cpu_env,
+                     arg[1].in, arg[2].in);
 }
 
 enum {
@@ -5165,7 +5183,7 @@ enum {
     COMPARE_ULE,
 };
 
-static void translate_compare_s(DisasContext *dc, const uint32_t arg[],
+static void translate_compare_s(DisasContext *dc, const OpcodeArg arg[],
                                 const uint32_t par[])
 {
     static void (* const helper[])(TCGv_env env, TCGv_i32 bit,
@@ -5178,153 +5196,153 @@ static void translate_compare_s(DisasContext *dc, const uint32_t arg[],
         [COMPARE_OLE] = gen_helper_ole_s,
         [COMPARE_ULE] = gen_helper_ule_s,
     };
-    TCGv_i32 bit = tcg_const_i32(1 << arg[0]);
+    TCGv_i32 bit = tcg_const_i32(1 << arg[0].imm);
 
-    helper[par[0]](cpu_env, bit, cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    helper[par[0]](cpu_env, bit, arg[1].in, arg[2].in);
     tcg_temp_free(bit);
 }
 
-static void translate_float_s(DisasContext *dc, const uint32_t arg[],
+static void translate_float_s(DisasContext *dc, const OpcodeArg arg[],
                               const uint32_t par[])
 {
-    TCGv_i32 scale = tcg_const_i32(-arg[2]);
+    TCGv_i32 scale = tcg_const_i32(-arg[2].imm);
 
     if (par[0]) {
-        gen_helper_uitof(cpu_FR[arg[0]], cpu_env, cpu_R[arg[1]], scale);
+        gen_helper_uitof(arg[0].out, cpu_env, arg[1].in, scale);
     } else {
-        gen_helper_itof(cpu_FR[arg[0]], cpu_env, cpu_R[arg[1]], scale);
+        gen_helper_itof(arg[0].out, cpu_env, arg[1].in, scale);
     }
     tcg_temp_free(scale);
 }
 
-static void translate_ftoi_s(DisasContext *dc, const uint32_t arg[],
+static void translate_ftoi_s(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
     TCGv_i32 rounding_mode = tcg_const_i32(par[0]);
-    TCGv_i32 scale = tcg_const_i32(arg[2]);
+    TCGv_i32 scale = tcg_const_i32(arg[2].imm);
 
     if (par[1]) {
-        gen_helper_ftoui(cpu_R[arg[0]], cpu_FR[arg[1]],
+        gen_helper_ftoui(arg[0].out, arg[1].in,
                          rounding_mode, scale);
     } else {
-        gen_helper_ftoi(cpu_R[arg[0]], cpu_FR[arg[1]],
+        gen_helper_ftoi(arg[0].out, arg[1].in,
                         rounding_mode, scale);
     }
     tcg_temp_free(rounding_mode);
     tcg_temp_free(scale);
 }
 
-static void translate_ldsti(DisasContext *dc, const uint32_t arg[],
+static void translate_ldsti(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
     TCGv_i32 addr = tcg_temp_new_i32();
 
-    tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+    tcg_gen_addi_i32(addr, arg[1].in, arg[2].imm);
     gen_load_store_alignment(dc, 2, addr, false);
     if (par[0]) {
-        tcg_gen_qemu_st32(cpu_FR[arg[0]], addr, dc->cring);
+        tcg_gen_qemu_st32(arg[0].in, addr, dc->cring);
     } else {
-        tcg_gen_qemu_ld32u(cpu_FR[arg[0]], addr, dc->cring);
+        tcg_gen_qemu_ld32u(arg[0].out, addr, dc->cring);
     }
     if (par[1]) {
-        tcg_gen_mov_i32(cpu_R[arg[1]], addr);
+        tcg_gen_mov_i32(arg[1].out, addr);
     }
     tcg_temp_free(addr);
 }
 
-static void translate_ldstx(DisasContext *dc, const uint32_t arg[],
+static void translate_ldstx(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
     TCGv_i32 addr = tcg_temp_new_i32();
 
-    tcg_gen_add_i32(addr, cpu_R[arg[1]], cpu_R[arg[2]]);
+    tcg_gen_add_i32(addr, arg[1].in, arg[2].in);
     gen_load_store_alignment(dc, 2, addr, false);
     if (par[0]) {
-        tcg_gen_qemu_st32(cpu_FR[arg[0]], addr, dc->cring);
+        tcg_gen_qemu_st32(arg[0].in, addr, dc->cring);
     } else {
-        tcg_gen_qemu_ld32u(cpu_FR[arg[0]], addr, dc->cring);
+        tcg_gen_qemu_ld32u(arg[0].out, addr, dc->cring);
     }
     if (par[1]) {
-        tcg_gen_mov_i32(cpu_R[arg[1]], addr);
+        tcg_gen_mov_i32(arg[1].out, addr);
     }
     tcg_temp_free(addr);
 }
 
-static void translate_madd_s(DisasContext *dc, const uint32_t arg[],
+static void translate_madd_s(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-    gen_helper_madd_s(cpu_FR[arg[0]], cpu_env,
-                      cpu_FR[arg[0]], cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    gen_helper_madd_s(arg[0].out, cpu_env,
+                      arg[0].in, arg[1].in, arg[2].in);
 }
 
-static void translate_mov_s(DisasContext *dc, const uint32_t arg[],
+static void translate_mov_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    tcg_gen_mov_i32(cpu_FR[arg[0]], cpu_FR[arg[1]]);
+    tcg_gen_mov_i32(arg[0].out, arg[1].in);
 }
 
-static void translate_movcond_s(DisasContext *dc, const uint32_t arg[],
+static void translate_movcond_s(DisasContext *dc, const OpcodeArg arg[],
                                 const uint32_t par[])
 {
     TCGv_i32 zero = tcg_const_i32(0);
 
-    tcg_gen_movcond_i32(par[0], cpu_FR[arg[0]],
-                        cpu_R[arg[2]], zero,
-                        cpu_FR[arg[1]], cpu_FR[arg[0]]);
+    tcg_gen_movcond_i32(par[0], arg[0].out,
+                        arg[2].in, zero,
+                        arg[1].in, arg[0].in);
     tcg_temp_free(zero);
 }
 
-static void translate_movp_s(DisasContext *dc, const uint32_t arg[],
+static void translate_movp_s(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
     TCGv_i32 zero = tcg_const_i32(0);
     TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2]);
+    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2].imm);
     tcg_gen_movcond_i32(par[0],
-                        cpu_FR[arg[0]], tmp, zero,
-                        cpu_FR[arg[1]], cpu_FR[arg[0]]);
+                        arg[0].out, tmp, zero,
+                        arg[1].in, arg[0].in);
     tcg_temp_free(tmp);
     tcg_temp_free(zero);
 }
 
-static void translate_mul_s(DisasContext *dc, const uint32_t arg[],
+static void translate_mul_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    gen_helper_mul_s(cpu_FR[arg[0]], cpu_env,
-                     cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    gen_helper_mul_s(arg[0].out, cpu_env,
+                     arg[1].in, arg[2].in);
 }
 
-static void translate_msub_s(DisasContext *dc, const uint32_t arg[],
+static void translate_msub_s(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-    gen_helper_msub_s(cpu_FR[arg[0]], cpu_env,
-                      cpu_FR[arg[0]], cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    gen_helper_msub_s(arg[0].out, cpu_env,
+                      arg[0].in, arg[1].in, arg[2].in);
 }
 
-static void translate_neg_s(DisasContext *dc, const uint32_t arg[],
+static void translate_neg_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    gen_helper_neg_s(cpu_FR[arg[0]], cpu_FR[arg[1]]);
+    gen_helper_neg_s(arg[0].out, arg[1].in);
 }
 
-static void translate_rfr_s(DisasContext *dc, const uint32_t arg[],
+static void translate_rfr_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    tcg_gen_mov_i32(cpu_R[arg[0]], cpu_FR[arg[1]]);
+    tcg_gen_mov_i32(arg[0].out, arg[1].in);
 }
 
-static void translate_sub_s(DisasContext *dc, const uint32_t arg[],
+static void translate_sub_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    gen_helper_sub_s(cpu_FR[arg[0]], cpu_env,
-                     cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    gen_helper_sub_s(arg[0].out, cpu_env,
+                     arg[1].in, arg[2].in);
 }
 
-static void translate_wfr_s(DisasContext *dc, const uint32_t arg[],
+static void translate_wfr_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    tcg_gen_mov_i32(cpu_FR[arg[0]], cpu_R[arg[1]]);
+    tcg_gen_mov_i32(arg[0].out, arg[1].in);
 }
 
 static const XtensaOpcodeOps fpu2000_ops[] = {
-- 
2.11.0
