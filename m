Received: from eggs.gnu.org ([2001:4830:134:3::10]:49398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAcy-0000ni-Lg
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAcq-0001kx-Kp
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:44 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eRAcp-0001jN-UW
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:36 -0500
Received: by mail-wr0-x243.google.com with SMTP id y21so17008760wrc.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 21:39:35 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Dec 2017 21:38:39 -0800
Message-Id: <1513661932-6849-4-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
References: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 03/16] target/xtensa: extract core opcode
 translators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

Move implementations of core opcodes into separate translation
functions. Introduce data structures for mapping opcode name to
translator function. Make an array of core opcode/translator structures.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |   24 +
 target/xtensa/translate.c | 3121 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 3145 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index b17d7d96e985..d8f40346269d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -37,6 +37,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat.h"
+#include "xtensa-isa.h"
 
 #define NB_MMU_MODES 4
 
@@ -205,6 +206,8 @@ enum {
 #define MEMCTL_DSNP 0x2
 #define MEMCTL_IL0EN 0x1
 
+#define MAX_INSN_LENGTH 64
+#define MAX_OPCODE_ARGS 16
 #define MAX_NAREG 64
 #define MAX_NINTERRUPT 32
 #define MAX_NLEVEL 6
@@ -330,6 +333,23 @@ typedef struct XtensaMemory {
     } location[MAX_NMEMORY];
 } XtensaMemory;
 
+typedef struct DisasContext DisasContext;
+typedef void (*XtensaOpcodeOp)(DisasContext *dc, const uint32_t arg[],
+                               const uint32_t par[]);
+
+typedef struct XtensaOpcodeOps {
+    const char *name;
+    XtensaOpcodeOp translate;
+    const uint32_t *par;
+} XtensaOpcodeOps;
+
+typedef struct XtensaOpcodeTranslators {
+    unsigned num_opcodes;
+    const XtensaOpcodeOps *opcode;
+} XtensaOpcodeTranslators;
+
+extern const XtensaOpcodeTranslators xtensa_core_opcodes;
+
 struct XtensaConfig {
     const char *name;
     uint64_t options;
@@ -370,6 +390,8 @@ struct XtensaConfig {
 
     uint32_t configid[2];
 
+    void *isa_internal;
+
     uint32_t clock_freq_khz;
 
     xtensa_tlb itlb;
@@ -522,6 +544,8 @@ static inline void xtensa_select_static_vectors(CPUXtensaState *env,
     env->static_vectors = n;
 }
 void xtensa_runstall(CPUXtensaState *env, bool runstall);
+XtensaOpcodeOps *xtensa_find_opcode_ops(const XtensaOpcodeTranslators *t,
+                                        const char *opcode);
 
 #define XTENSA_OPTION_BIT(opt) (((uint64_t)1) << (opt))
 #define XTENSA_OPTION_ALL (~(uint64_t)0)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 225e4a5fe870..1c227380a64d 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -75,6 +75,8 @@ typedef struct DisasContext {
     TCGv_i32 next_icount;
 
     unsigned cpenable;
+
+    uint32_t *raw_arg;
 } DisasContext;
 
 static TCGv_i32 cpu_pc;
@@ -3312,3 +3314,3122 @@ void restore_state_to_opc(CPUXtensaState *env, TranslationBlock *tb,
 {
     env->pc = data[0];
 }
+
+static int compare_opcode_ops(const void *a, const void *b)
+{
+    return strcmp((const char *)a,
+                  ((const XtensaOpcodeOps *)b)->name);
+}
+
+XtensaOpcodeOps *
+xtensa_find_opcode_ops(const XtensaOpcodeTranslators *t,
+                       const char *name)
+{
+    XtensaOpcodeOps *ops;
+
+    ops = bsearch(name, t->opcode, t->num_opcodes,
+                  sizeof(XtensaOpcodeOps), compare_opcode_ops);
+    return ops;
+}
+
+static void translate_abs(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 zero = tcg_const_i32(0);
+        TCGv_i32 neg = tcg_temp_new_i32();
+
+        tcg_gen_neg_i32(neg, cpu_R[arg[1]]);
+        tcg_gen_movcond_i32(TCG_COND_GE, cpu_R[arg[0]],
+                            cpu_R[arg[1]], zero, cpu_R[arg[1]], neg);
+        tcg_temp_free(neg);
+        tcg_temp_free(zero);
+    }
+}
+
+static void translate_add(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_add_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
+static void translate_addi(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        tcg_gen_addi_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
+    }
+}
+
+static void translate_addx(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_shli_i32(tmp, cpu_R[arg[1]], par[0]);
+        tcg_gen_add_i32(cpu_R[arg[0]], tmp, cpu_R[arg[2]]);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_all(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    uint32_t shift = par[1];
+    TCGv_i32 mask = tcg_const_i32(((1 << shift) - 1) << arg[1]);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_and_i32(tmp, cpu_SR[BR], mask);
+    if (par[0]) {
+        tcg_gen_addi_i32(tmp, tmp, 1 << arg[1]);
+    } else {
+        tcg_gen_add_i32(tmp, tmp, mask);
+    }
+    tcg_gen_shri_i32(tmp, tmp, arg[1] + shift);
+    tcg_gen_deposit_i32(cpu_SR[BR], cpu_SR[BR],
+                        tmp, arg[0], 1);
+    tcg_temp_free(mask);
+    tcg_temp_free(tmp);
+}
+
+static void translate_and(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_and_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
+static void translate_ball(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_and_i32(tmp, cpu_R[arg[0]], cpu_R[arg[1]]);
+        gen_brcond(dc, par[0], tmp, cpu_R[arg[1]], arg[2]);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_bany(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_and_i32(tmp, cpu_R[arg[0]], cpu_R[arg[1]]);
+        gen_brcondi(dc, par[0], tmp, 0, arg[2]);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_b(DisasContext *dc, const uint32_t arg[],
+                        const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        gen_brcond(dc, par[0], cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
+    }
+}
+
+static void translate_bb(DisasContext *dc, const uint32_t arg[],
+                         const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+#ifdef TARGET_WORDS_BIGENDIAN
+        TCGv_i32 bit = tcg_const_i32(0x80000000u);
+#else
+        TCGv_i32 bit = tcg_const_i32(0x00000001u);
+#endif
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_andi_i32(tmp, cpu_R[arg[1]], 0x1f);
+#ifdef TARGET_WORDS_BIGENDIAN
+        tcg_gen_shr_i32(bit, bit, tmp);
+#else
+        tcg_gen_shl_i32(bit, bit, tmp);
+#endif
+        tcg_gen_and_i32(tmp, cpu_R[arg[0]], bit);
+        gen_brcondi(dc, par[0], tmp, 0, arg[2]);
+        tcg_temp_free(tmp);
+        tcg_temp_free(bit);
+    }
+}
+
+static void translate_bbi(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+#ifdef TARGET_WORDS_BIGENDIAN
+        tcg_gen_andi_i32(tmp, cpu_R[arg[0]], 0x80000000u >> arg[1]);
+#else
+        tcg_gen_andi_i32(tmp, cpu_R[arg[0]], 0x00000001u << arg[1]);
+#endif
+        gen_brcondi(dc, par[0], tmp, 0, arg[2]);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_bi(DisasContext *dc, const uint32_t arg[],
+                         const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        gen_brcondi(dc, par[0], cpu_R[arg[0]], arg[1], arg[2]);
+    }
+}
+
+static void translate_bz(DisasContext *dc, const uint32_t arg[],
+                         const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        gen_brcondi(dc, par[0], cpu_R[arg[0]], 0, arg[1]);
+    }
+}
+
+enum {
+    BOOLEAN_AND,
+    BOOLEAN_ANDC,
+    BOOLEAN_OR,
+    BOOLEAN_ORC,
+    BOOLEAN_XOR,
+};
+
+static void translate_boolean(DisasContext *dc, const uint32_t arg[],
+                              const uint32_t par[])
+{
+    static void (* const op[])(TCGv_i32, TCGv_i32, TCGv_i32) = {
+        [BOOLEAN_AND] = tcg_gen_and_i32,
+        [BOOLEAN_ANDC] = tcg_gen_andc_i32,
+        [BOOLEAN_OR] = tcg_gen_or_i32,
+        [BOOLEAN_ORC] = tcg_gen_orc_i32,
+        [BOOLEAN_XOR] = tcg_gen_xor_i32,
+    };
+
+    TCGv_i32 tmp1 = tcg_temp_new_i32();
+    TCGv_i32 tmp2 = tcg_temp_new_i32();
+
+    tcg_gen_shri_i32(tmp1, cpu_SR[BR], arg[1]);
+    tcg_gen_shri_i32(tmp2, cpu_SR[BR], arg[2]);
+    op[par[0]](tmp1, tmp1, tmp2);
+    tcg_gen_deposit_i32(cpu_SR[BR], cpu_SR[BR], tmp1, arg[0], 1);
+    tcg_temp_free(tmp1);
+    tcg_temp_free(tmp2);
+}
+
+static void translate_bp(DisasContext *dc, const uint32_t arg[],
+                         const uint32_t par[])
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[0]);
+    gen_brcondi(dc, par[0], tmp, 0, arg[1]);
+    tcg_temp_free(tmp);
+}
+
+static void translate_break(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (dc->debug) {
+        gen_debug_exception(dc, par[0]);
+    }
+}
+
+static void translate_call0(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    tcg_gen_movi_i32(cpu_R[0], dc->next_pc);
+    gen_jumpi(dc, arg[0], 0);
+}
+
+static void translate_callw(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_window_check1(dc, par[0] << 2)) {
+        gen_callwi(dc, par[0], arg[0], 0);
+    }
+}
+
+static void translate_callx0(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
+        tcg_gen_movi_i32(cpu_R[0], dc->next_pc);
+        gen_jump(dc, tmp);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_callxw(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], par[0] << 2)) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+
+        tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
+        gen_callw(dc, par[0], tmp);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_clamps(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 tmp1 = tcg_const_i32(-1u << arg[2]);
+        TCGv_i32 tmp2 = tcg_const_i32((1 << arg[2]) - 1);
+
+        tcg_gen_movcond_i32(TCG_COND_GT, tmp1,
+                            cpu_R[arg[1]], tmp1, cpu_R[arg[1]], tmp1);
+        tcg_gen_movcond_i32(TCG_COND_LT, cpu_R[arg[0]],
+                            tmp1, tmp2, tmp1, tmp2);
+        tcg_temp_free(tmp1);
+        tcg_temp_free(tmp2);
+    }
+}
+
+/* par[0]: privileged, par[1]: check memory access */
+static void translate_dcache(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if ((!par[0] || gen_check_privilege(dc)) &&
+        gen_window_check1(dc, arg[0]) && par[1]) {
+        TCGv_i32 addr = tcg_temp_new_i32();
+        TCGv_i32 res = tcg_temp_new_i32();
+
+        tcg_gen_addi_i32(addr, cpu_R[arg[0]], arg[1]);
+        tcg_gen_qemu_ld8u(res, addr, dc->cring);
+        tcg_temp_free(addr);
+        tcg_temp_free(res);
+    }
+}
+
+static void translate_depbits(DisasContext *dc, const uint32_t arg[],
+                              const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        tcg_gen_deposit_i32(cpu_R[arg[1]], cpu_R[arg[1]], cpu_R[arg[0]],
+                            arg[2], arg[3]);
+    }
+}
+
+static void translate_entry(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    TCGv_i32 pc = tcg_const_i32(dc->pc);
+    TCGv_i32 s = tcg_const_i32(arg[0]);
+    TCGv_i32 imm = tcg_const_i32(arg[1]);
+    gen_helper_entry(cpu_env, pc, s, imm);
+    tcg_temp_free(imm);
+    tcg_temp_free(s);
+    tcg_temp_free(pc);
+    /* This can change tb->flags, so exit tb */
+    gen_jumpi_check_loop_end(dc, -1);
+}
+
+static void translate_extui(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        int maskimm = (1 << arg[3]) - 1;
+
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_shri_i32(tmp, cpu_R[arg[1]], arg[2]);
+        tcg_gen_andi_i32(cpu_R[arg[0]], tmp, maskimm);
+        tcg_temp_free(tmp);
+    }
+}
+
+/* par[0]: privileged, par[1]: check memory access */
+static void translate_icache(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if ((!par[0] || gen_check_privilege(dc)) &&
+        gen_window_check1(dc, arg[0]) && par[1]) {
+        TCGv_i32 addr = tcg_temp_new_i32();
+
+        tcg_gen_movi_i32(cpu_pc, dc->pc);
+        tcg_gen_addi_i32(addr, cpu_R[arg[0]], arg[1]);
+        gen_helper_itlb_hit_test(cpu_env, addr);
+        tcg_temp_free(addr);
+    }
+}
+
+static void translate_itlb(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_check_privilege(dc) &&
+        gen_window_check1(dc, arg[0])) {
+        TCGv_i32 dtlb = tcg_const_i32(par[0]);
+
+        gen_helper_itlb(cpu_env, cpu_R[arg[0]], dtlb);
+        /* This could change memory mapping, so exit tb */
+        gen_jumpi_check_loop_end(dc, -1);
+        tcg_temp_free(dtlb);
+    }
+}
+
+static void translate_ill(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
+}
+
+static void translate_j(DisasContext *dc, const uint32_t arg[],
+                        const uint32_t par[])
+{
+    gen_jumpi(dc, arg[0], 0);
+}
+
+static void translate_jx(DisasContext *dc, const uint32_t arg[],
+                         const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        gen_jump(dc, cpu_R[arg[0]]);
+    }
+}
+
+static void translate_l32e(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_check_privilege(dc) &&
+        gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 addr = tcg_temp_new_i32();
+
+        tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+        gen_load_store_alignment(dc, 2, addr, false);
+        tcg_gen_qemu_ld_tl(cpu_R[arg[0]], addr, dc->ring, MO_TEUL);
+        tcg_temp_free(addr);
+    }
+}
+
+static void translate_ldst(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 addr = tcg_temp_new_i32();
+
+        tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+        if (par[0] & MO_SIZE) {
+            gen_load_store_alignment(dc, par[0] & MO_SIZE, addr, par[1]);
+        }
+        if (par[2]) {
+            tcg_gen_qemu_st_tl(cpu_R[arg[0]], addr, dc->cring, par[0]);
+        } else {
+            tcg_gen_qemu_ld_tl(cpu_R[arg[0]], addr, dc->cring, par[0]);
+        }
+        tcg_temp_free(addr);
+    }
+}
+
+static void translate_l32r(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        TCGv_i32 tmp = (dc->tb->flags & XTENSA_TBFLAG_LITBASE) ?
+                       tcg_const_i32(dc->raw_arg[1] - 1) :
+                       tcg_const_i32(arg[1]);
+
+        if (dc->tb->flags & XTENSA_TBFLAG_LITBASE) {
+            tcg_gen_add_i32(tmp, tmp, dc->litbase);
+        }
+        tcg_gen_qemu_ld32u(cpu_R[arg[0]], tmp, dc->cring);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_loop(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        uint32_t lend = arg[1];
+        TCGv_i32 tmp = tcg_const_i32(lend);
+
+        tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_R[arg[0]], 1);
+        tcg_gen_movi_i32(cpu_SR[LBEG], dc->next_pc);
+        gen_helper_wsr_lend(cpu_env, tmp);
+        tcg_temp_free(tmp);
+
+        if (par[0] != TCG_COND_NEVER) {
+            TCGLabel *label = gen_new_label();
+            tcg_gen_brcondi_i32(par[0], cpu_R[arg[0]], 0, label);
+            gen_jumpi(dc, lend, 1);
+            gen_set_label(label);
+        }
+
+        gen_jumpi(dc, dc->next_pc, 0);
+    }
+}
+
+enum {
+    MAC16_UMUL,
+    MAC16_MUL,
+    MAC16_MULA,
+    MAC16_MULS,
+    MAC16_NONE,
+};
+
+enum {
+    MAC16_LL,
+    MAC16_HL,
+    MAC16_LH,
+    MAC16_HH,
+
+    MAC16_HX = 0x1,
+    MAC16_XH = 0x2,
+};
+
+enum {
+    MAC16_AA,
+    MAC16_AD,
+    MAC16_DA,
+    MAC16_DD,
+
+    MAC16_XD = 0x1,
+    MAC16_DX = 0x2,
+};
+
+static void translate_mac16(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    int op = par[0];
+    bool is_m1_sr = par[1] & MAC16_DX;
+    bool is_m2_sr = par[1] & MAC16_XD;
+    unsigned half = par[2];
+    uint32_t ld_offset = par[3];
+    unsigned off = ld_offset ? 2 : 0;
+    uint32_t ar[3] = {0};
+    unsigned n_ar = 0;
+
+    if (op != MAC16_NONE) {
+        if (!is_m1_sr) {
+            ar[n_ar++] = arg[off];
+        }
+        if (!is_m2_sr) {
+            ar[n_ar++] = arg[off + 1];
+        }
+    }
+
+    if (ld_offset) {
+        ar[n_ar++] = arg[1];
+    }
+
+    if (gen_window_check3(dc, ar[0], ar[1], ar[2])) {
+        TCGv_i32 vaddr = tcg_temp_new_i32();
+        TCGv_i32 mem32 = tcg_temp_new_i32();
+
+        if (ld_offset) {
+            tcg_gen_addi_i32(vaddr, cpu_R[arg[1]], ld_offset);
+            gen_load_store_alignment(dc, 2, vaddr, false);
+            tcg_gen_qemu_ld32u(mem32, vaddr, dc->cring);
+        }
+        if (op != MAC16_NONE) {
+            TCGv_i32 m1 = gen_mac16_m(is_m1_sr ?
+                                      cpu_SR[MR + arg[off]] :
+                                      cpu_R[arg[off]],
+                                      half & MAC16_HX, op == MAC16_UMUL);
+            TCGv_i32 m2 = gen_mac16_m(is_m2_sr ?
+                                      cpu_SR[MR + arg[off + 1]] :
+                                      cpu_R[arg[off + 1]],
+                                      half & MAC16_XH, op == MAC16_UMUL);
+
+            if (op == MAC16_MUL || op == MAC16_UMUL) {
+                tcg_gen_mul_i32(cpu_SR[ACCLO], m1, m2);
+                if (op == MAC16_UMUL) {
+                    tcg_gen_movi_i32(cpu_SR[ACCHI], 0);
+                } else {
+                    tcg_gen_sari_i32(cpu_SR[ACCHI], cpu_SR[ACCLO], 31);
+                }
+            } else {
+                TCGv_i32 lo = tcg_temp_new_i32();
+                TCGv_i32 hi = tcg_temp_new_i32();
+
+                tcg_gen_mul_i32(lo, m1, m2);
+                tcg_gen_sari_i32(hi, lo, 31);
+                if (op == MAC16_MULA) {
+                    tcg_gen_add2_i32(cpu_SR[ACCLO], cpu_SR[ACCHI],
+                                     cpu_SR[ACCLO], cpu_SR[ACCHI],
+                                     lo, hi);
+                } else {
+                    tcg_gen_sub2_i32(cpu_SR[ACCLO], cpu_SR[ACCHI],
+                                     cpu_SR[ACCLO], cpu_SR[ACCHI],
+                                     lo, hi);
+                }
+                tcg_gen_ext8s_i32(cpu_SR[ACCHI], cpu_SR[ACCHI]);
+
+                tcg_temp_free_i32(lo);
+                tcg_temp_free_i32(hi);
+            }
+            tcg_temp_free(m1);
+            tcg_temp_free(m2);
+        }
+        if (ld_offset) {
+            tcg_gen_mov_i32(cpu_R[arg[1]], vaddr);
+            tcg_gen_mov_i32(cpu_SR[MR + arg[0]], mem32);
+        }
+        tcg_temp_free(vaddr);
+        tcg_temp_free(mem32);
+    }
+}
+
+static void translate_minmax(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_movcond_i32(par[0], cpu_R[arg[0]],
+                            cpu_R[arg[1]], cpu_R[arg[2]],
+                            cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
+static void translate_mov(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        tcg_gen_mov_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+    }
+}
+
+static void translate_movcond(DisasContext *dc, const uint32_t arg[],
+                              const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        TCGv_i32 zero = tcg_const_i32(0);
+
+        tcg_gen_movcond_i32(par[0], cpu_R[arg[0]],
+                            cpu_R[arg[2]], zero, cpu_R[arg[1]], cpu_R[arg[0]]);
+        tcg_temp_free(zero);
+    }
+}
+
+static void translate_movi(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        tcg_gen_movi_i32(cpu_R[arg[0]], arg[1]);
+    }
+}
+
+static void translate_movp(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 zero = tcg_const_i32(0);
+        TCGv_i32 tmp = tcg_temp_new_i32();
+
+        tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2]);
+        tcg_gen_movcond_i32(par[0],
+                            cpu_R[arg[0]], tmp, zero,
+                            cpu_R[arg[1]], cpu_R[arg[0]]);
+        tcg_temp_free(tmp);
+        tcg_temp_free(zero);
+    }
+}
+
+static void translate_movsp(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 pc = tcg_const_i32(dc->pc);
+        gen_helper_movsp(cpu_env, pc);
+        tcg_gen_mov_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+        tcg_temp_free(pc);
+    }
+}
+
+static void translate_mul16(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        TCGv_i32 v1 = tcg_temp_new_i32();
+        TCGv_i32 v2 = tcg_temp_new_i32();
+
+        if (par[0]) {
+            tcg_gen_ext16s_i32(v1, cpu_R[arg[1]]);
+            tcg_gen_ext16s_i32(v2, cpu_R[arg[2]]);
+        } else {
+            tcg_gen_ext16u_i32(v1, cpu_R[arg[1]]);
+            tcg_gen_ext16u_i32(v2, cpu_R[arg[2]]);
+        }
+        tcg_gen_mul_i32(cpu_R[arg[0]], v1, v2);
+        tcg_temp_free(v2);
+        tcg_temp_free(v1);
+    }
+}
+
+static void translate_mull(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_mul_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
+static void translate_mulh(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        TCGv_i32 lo = tcg_temp_new();
+
+        if (par[0]) {
+            tcg_gen_muls2_i32(lo, cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+        } else {
+            tcg_gen_mulu2_i32(lo, cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+        }
+        tcg_temp_free(lo);
+    }
+}
+
+static void translate_neg(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        tcg_gen_neg_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+    }
+}
+
+static void translate_nop(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+}
+
+static void translate_nsa(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        tcg_gen_clrsb_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+    }
+}
+
+static void translate_nsau(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        tcg_gen_clzi_i32(cpu_R[arg[0]], cpu_R[arg[1]], 32);
+    }
+}
+
+static void translate_or(DisasContext *dc, const uint32_t arg[],
+                         const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_or_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
+static void translate_ptlb(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_check_privilege(dc) &&
+        gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 dtlb = tcg_const_i32(par[0]);
+
+        tcg_gen_movi_i32(cpu_pc, dc->pc);
+        gen_helper_ptlb(cpu_R[arg[0]], cpu_env, cpu_R[arg[1]], dtlb);
+        tcg_temp_free(dtlb);
+    }
+}
+
+static void gen_zero_check(DisasContext *dc, const uint32_t arg[])
+{
+    TCGLabel *label = gen_new_label();
+
+    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[2]], 0, label);
+    gen_exception_cause(dc, INTEGER_DIVIDE_BY_ZERO_CAUSE);
+    gen_set_label(label);
+}
+
+static void translate_quos(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        TCGLabel *label1 = gen_new_label();
+        TCGLabel *label2 = gen_new_label();
+
+        gen_zero_check(dc, arg);
+
+        tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[1]], 0x80000000,
+                            label1);
+        tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[2]], 0xffffffff,
+                            label1);
+        tcg_gen_movi_i32(cpu_R[arg[0]],
+                         par[0] ? 0x80000000 : 0);
+        tcg_gen_br(label2);
+        gen_set_label(label1);
+        if (par[0]) {
+            tcg_gen_div_i32(cpu_R[arg[0]],
+                            cpu_R[arg[1]], cpu_R[arg[2]]);
+        } else {
+            tcg_gen_rem_i32(cpu_R[arg[0]],
+                            cpu_R[arg[1]], cpu_R[arg[2]]);
+        }
+        gen_set_label(label2);
+    }
+}
+
+static void translate_quou(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        gen_zero_check(dc, arg);
+        if (par[0]) {
+            tcg_gen_divu_i32(cpu_R[arg[0]],
+                             cpu_R[arg[1]], cpu_R[arg[2]]);
+        } else {
+            tcg_gen_remu_i32(cpu_R[arg[0]],
+                             cpu_R[arg[1]], cpu_R[arg[2]]);
+        }
+    }
+}
+
+static void translate_rer(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_check_privilege(dc) &&
+        gen_window_check2(dc, arg[0], arg[1])) {
+        gen_helper_rer(cpu_R[arg[0]], cpu_env, cpu_R[arg[1]]);
+    }
+}
+
+static void translate_ret(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    gen_jump(dc, cpu_R[0]);
+}
+
+static void translate_retw(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    TCGv_i32 tmp = tcg_const_i32(dc->pc);
+    gen_helper_retw(tmp, cpu_env, tmp);
+    gen_jump(dc, tmp);
+    tcg_temp_free(tmp);
+}
+
+static void translate_rfde(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_check_privilege(dc)) {
+        gen_jump(dc, cpu_SR[dc->config->ndepc ? DEPC : EPC1]);
+    }
+}
+
+static void translate_rfe(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_check_privilege(dc)) {
+        tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
+        gen_check_interrupts(dc);
+        gen_jump(dc, cpu_SR[EPC1]);
+    }
+}
+
+static void translate_rfi(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_check_privilege(dc)) {
+        tcg_gen_mov_i32(cpu_SR[PS], cpu_SR[EPS2 + arg[0] - 2]);
+        gen_check_interrupts(dc);
+        gen_jump(dc, cpu_SR[EPC1 + arg[0] - 1]);
+    }
+}
+
+static void translate_rfw(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_check_privilege(dc)) {
+        TCGv_i32 tmp = tcg_const_i32(1);
+
+        tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
+        tcg_gen_shl_i32(tmp, tmp, cpu_SR[WINDOW_BASE]);
+
+        if (par[0]) {
+            tcg_gen_andc_i32(cpu_SR[WINDOW_START],
+                             cpu_SR[WINDOW_START], tmp);
+        } else {
+            tcg_gen_or_i32(cpu_SR[WINDOW_START],
+                           cpu_SR[WINDOW_START], tmp);
+        }
+
+        gen_helper_restore_owb(cpu_env);
+        gen_check_interrupts(dc);
+        gen_jump(dc, cpu_SR[EPC1]);
+
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_rotw(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_check_privilege(dc)) {
+        TCGv_i32 tmp = tcg_const_i32(arg[0]);
+        gen_helper_rotw(cpu_env, tmp);
+        tcg_temp_free(tmp);
+        /* This can change tb->flags, so exit tb */
+        gen_jumpi_check_loop_end(dc, -1);
+    }
+}
+
+static void translate_rsil(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_check_privilege(dc) &&
+        gen_window_check1(dc, arg[0])) {
+        tcg_gen_mov_i32(cpu_R[arg[0]], cpu_SR[PS]);
+        tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_INTLEVEL);
+        tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], arg[1]);
+        gen_check_interrupts(dc);
+        gen_jumpi_check_loop_end(dc, 0);
+    }
+}
+
+static void translate_rsr(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_check_sr(dc, par[0], SR_R) &&
+        (par[0] < 64 || gen_check_privilege(dc)) &&
+        gen_window_check1(dc, arg[0])) {
+        if (gen_rsr(dc, cpu_R[arg[0]], par[0])) {
+            gen_jumpi_check_loop_end(dc, 0);
+        }
+    }
+}
+
+static void translate_rtlb(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    static void (* const helper[])(TCGv_i32 r, TCGv_env env, TCGv_i32 a1,
+                                   TCGv_i32 a2) = {
+        gen_helper_rtlb0,
+        gen_helper_rtlb1,
+    };
+
+    if (gen_check_privilege(dc) &&
+        gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 dtlb = tcg_const_i32(par[0]);
+
+        helper[par[1]](cpu_R[arg[0]], cpu_env, cpu_R[arg[1]], dtlb);
+        tcg_temp_free(dtlb);
+    }
+}
+
+static void translate_rur(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        if (uregnames[par[0]].name) {
+            tcg_gen_mov_i32(cpu_R[arg[0]], cpu_UR[par[0]]);
+        } else {
+            qemu_log_mask(LOG_UNIMP, "RUR %d not implemented, ", par[0]);
+        }
+    }
+}
+
+static void translate_s32c1i(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        TCGLabel *label = gen_new_label();
+        TCGv_i32 tmp = tcg_temp_local_new_i32();
+        TCGv_i32 addr = tcg_temp_local_new_i32();
+        TCGv_i32 tpc;
+
+        tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
+        tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+        gen_load_store_alignment(dc, 2, addr, true);
+
+        tpc = tcg_const_i32(dc->pc);
+        gen_helper_check_atomctl(cpu_env, tpc, addr);
+        tcg_gen_qemu_ld32u(cpu_R[arg[0]], addr, dc->cring);
+        tcg_gen_brcond_i32(TCG_COND_NE, cpu_R[arg[0]],
+                           cpu_SR[SCOMPARE1], label);
+
+        tcg_gen_qemu_st32(tmp, addr, dc->cring);
+
+        gen_set_label(label);
+        tcg_temp_free(tpc);
+        tcg_temp_free(addr);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_s32e(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_check_privilege(dc) &&
+        gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 addr = tcg_temp_new_i32();
+
+        tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+        gen_load_store_alignment(dc, 2, addr, false);
+        tcg_gen_qemu_st_tl(cpu_R[arg[0]], addr, dc->ring, MO_TEUL);
+        tcg_temp_free(addr);
+    }
+}
+
+static void translate_sext(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        int shift = 31 - arg[2];
+
+        if (shift == 24) {
+            tcg_gen_ext8s_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+        } else if (shift == 16) {
+            tcg_gen_ext16s_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+        } else {
+            TCGv_i32 tmp = tcg_temp_new_i32();
+            tcg_gen_shli_i32(tmp, cpu_R[arg[1]], shift);
+            tcg_gen_sari_i32(cpu_R[arg[0]], tmp, shift);
+            tcg_temp_free(tmp);
+        }
+    }
+}
+
+static void translate_simcall(DisasContext *dc, const uint32_t arg[],
+                              const uint32_t par[])
+{
+    if (semihosting_enabled()) {
+        if (gen_check_privilege(dc)) {
+            gen_helper_simcall(cpu_env);
+        }
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
+        gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
+    }
+}
+
+/*
+ * Note: 64 bit ops are used here solely because SAR values
+ * have range 0..63
+ */
+#define gen_shift_reg(cmd, reg) do { \
+                    TCGv_i64 tmp = tcg_temp_new_i64(); \
+                    tcg_gen_extu_i32_i64(tmp, reg); \
+                    tcg_gen_##cmd##_i64(v, v, tmp); \
+                    tcg_gen_extrl_i64_i32(cpu_R[arg[0]], v); \
+                    tcg_temp_free_i64(v); \
+                    tcg_temp_free_i64(tmp); \
+                } while (0)
+
+#define gen_shift(cmd) gen_shift_reg(cmd, cpu_SR[SAR])
+
+static void translate_sll(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        if (dc->sar_m32_5bit) {
+            tcg_gen_shl_i32(cpu_R[arg[0]], cpu_R[arg[1]], dc->sar_m32);
+        } else {
+            TCGv_i64 v = tcg_temp_new_i64();
+            TCGv_i32 s = tcg_const_i32(32);
+            tcg_gen_sub_i32(s, s, cpu_SR[SAR]);
+            tcg_gen_andi_i32(s, s, 0x3f);
+            tcg_gen_extu_i32_i64(v, cpu_R[arg[1]]);
+            gen_shift_reg(shl, s);
+            tcg_temp_free(s);
+        }
+    }
+}
+
+static void translate_slli(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        if (arg[2] == 32) {
+            qemu_log_mask(LOG_GUEST_ERROR, "slli a%d, a%d, 32 is undefined",
+                          arg[0], arg[1]);
+        }
+        tcg_gen_shli_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2] & 0x1f);
+    }
+}
+
+static void translate_sra(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        if (dc->sar_m32_5bit) {
+            tcg_gen_sar_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_SR[SAR]);
+        } else {
+            TCGv_i64 v = tcg_temp_new_i64();
+            tcg_gen_ext_i32_i64(v, cpu_R[arg[1]]);
+            gen_shift(sar);
+        }
+    }
+}
+
+static void translate_srai(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        tcg_gen_sari_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
+    }
+}
+
+static void translate_src(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        TCGv_i64 v = tcg_temp_new_i64();
+        tcg_gen_concat_i32_i64(v, cpu_R[arg[2]], cpu_R[arg[1]]);
+        gen_shift(shr);
+    }
+}
+
+static void translate_srl(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        if (dc->sar_m32_5bit) {
+            tcg_gen_shr_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_SR[SAR]);
+        } else {
+            TCGv_i64 v = tcg_temp_new_i64();
+            tcg_gen_extu_i32_i64(v, cpu_R[arg[1]]);
+            gen_shift(shr);
+        }
+    }
+}
+
+#undef gen_shift
+#undef gen_shift_reg
+
+static void translate_srli(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        tcg_gen_shri_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
+    }
+}
+
+static void translate_ssa8b(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_shli_i32(tmp, cpu_R[arg[0]], 3);
+        gen_left_shift_sar(dc, tmp);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_ssa8l(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_shli_i32(tmp, cpu_R[arg[0]], 3);
+        gen_right_shift_sar(dc, tmp);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_ssai(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    TCGv_i32 tmp = tcg_const_i32(arg[0]);
+    gen_right_shift_sar(dc, tmp);
+    tcg_temp_free(tmp);
+}
+
+static void translate_ssl(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        gen_left_shift_sar(dc, cpu_R[arg[0]]);
+    }
+}
+
+static void translate_ssr(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        gen_right_shift_sar(dc, cpu_R[arg[0]]);
+    }
+}
+
+static void translate_sub(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_sub_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
+static void translate_subx(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_shli_i32(tmp, cpu_R[arg[1]], par[0]);
+        tcg_gen_sub_i32(cpu_R[arg[0]], tmp, cpu_R[arg[2]]);
+        tcg_temp_free(tmp);
+    }
+}
+
+static void translate_syscall(DisasContext *dc, const uint32_t arg[],
+                              const uint32_t par[])
+{
+    gen_exception_cause(dc, SYSCALL_CAUSE);
+}
+
+static void translate_waiti(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_check_privilege(dc)) {
+        gen_waiti(dc, arg[0]);
+    }
+}
+
+static void translate_wtlb(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_check_privilege(dc) &&
+        gen_window_check2(dc, arg[0], arg[1])) {
+        TCGv_i32 dtlb = tcg_const_i32(par[0]);
+
+        gen_helper_wtlb(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]], dtlb);
+        /* This could change memory mapping, so exit tb */
+        gen_jumpi_check_loop_end(dc, -1);
+        tcg_temp_free(dtlb);
+    }
+}
+
+static void translate_wer(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_check_privilege(dc) &&
+        gen_window_check2(dc, arg[0], arg[1])) {
+        gen_helper_wer(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]]);
+    }
+}
+
+static void translate_wsr(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_check_sr(dc, par[0], SR_W) &&
+        (par[0] < 64 || gen_check_privilege(dc)) &&
+        gen_window_check1(dc, arg[0])) {
+        gen_wsr(dc, par[0], cpu_R[arg[0]]);
+    }
+}
+
+static void translate_wur(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        if (uregnames[par[0]].name) {
+            gen_wur(par[0], cpu_R[arg[0]]);
+        } else {
+            qemu_log_mask(LOG_UNIMP, "WUR %d not implemented, ", par[0]);
+        }
+    }
+}
+
+static void translate_xor(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_xor_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
+static void translate_xsr(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (gen_check_sr(dc, par[0], SR_X) &&
+        (par[0] < 64 || gen_check_privilege(dc)) &&
+        gen_window_check1(dc, arg[0])) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        bool rsr_end, wsr_end;
+
+        tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
+        rsr_end = gen_rsr(dc, cpu_R[arg[0]], par[0]);
+        wsr_end = gen_wsr(dc, par[0], tmp);
+        tcg_temp_free(tmp);
+        if (rsr_end && !wsr_end) {
+            gen_jumpi_check_loop_end(dc, 0);
+        }
+    }
+}
+
+static const XtensaOpcodeOps core_ops[] = {
+    {
+        .name = "abs",
+        .translate = translate_abs,
+    }, {
+        .name = "add",
+        .translate = translate_add,
+    }, {
+        .name = "add.n",
+        .translate = translate_add,
+    }, {
+        .name = "addi",
+        .translate = translate_addi,
+    }, {
+        .name = "addi.n",
+        .translate = translate_addi,
+    }, {
+        .name = "addmi",
+        .translate = translate_addi,
+    }, {
+        .name = "addx2",
+        .translate = translate_addx,
+        .par = (const uint32_t[]){1},
+    }, {
+        .name = "addx4",
+        .translate = translate_addx,
+        .par = (const uint32_t[]){2},
+    }, {
+        .name = "addx8",
+        .translate = translate_addx,
+        .par = (const uint32_t[]){3},
+    }, {
+        .name = "all4",
+        .translate = translate_all,
+        .par = (const uint32_t[]){true, 4},
+    }, {
+        .name = "all8",
+        .translate = translate_all,
+        .par = (const uint32_t[]){true, 8},
+    }, {
+        .name = "and",
+        .translate = translate_and,
+    }, {
+        .name = "andb",
+        .translate = translate_boolean,
+        .par = (const uint32_t[]){BOOLEAN_AND},
+    }, {
+        .name = "andbc",
+        .translate = translate_boolean,
+        .par = (const uint32_t[]){BOOLEAN_ANDC},
+    }, {
+        .name = "any4",
+        .translate = translate_all,
+        .par = (const uint32_t[]){false, 4},
+    }, {
+        .name = "any8",
+        .translate = translate_all,
+        .par = (const uint32_t[]){false, 8},
+    }, {
+        .name = "ball",
+        .translate = translate_ball,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "bany",
+        .translate = translate_bany,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "bbc",
+        .translate = translate_bb,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "bbci",
+        .translate = translate_bbi,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "bbs",
+        .translate = translate_bb,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "bbsi",
+        .translate = translate_bbi,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "beq",
+        .translate = translate_b,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "beqi",
+        .translate = translate_bi,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "beqz",
+        .translate = translate_bz,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "beqz.n",
+        .translate = translate_bz,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "bf",
+        .translate = translate_bp,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "bge",
+        .translate = translate_b,
+        .par = (const uint32_t[]){TCG_COND_GE},
+    }, {
+        .name = "bgei",
+        .translate = translate_bi,
+        .par = (const uint32_t[]){TCG_COND_GE},
+    }, {
+        .name = "bgeu",
+        .translate = translate_b,
+        .par = (const uint32_t[]){TCG_COND_GEU},
+    }, {
+        .name = "bgeui",
+        .translate = translate_bi,
+        .par = (const uint32_t[]){TCG_COND_GEU},
+    }, {
+        .name = "bgez",
+        .translate = translate_bz,
+        .par = (const uint32_t[]){TCG_COND_GE},
+    }, {
+        .name = "blt",
+        .translate = translate_b,
+        .par = (const uint32_t[]){TCG_COND_LT},
+    }, {
+        .name = "blti",
+        .translate = translate_bi,
+        .par = (const uint32_t[]){TCG_COND_LT},
+    }, {
+        .name = "bltu",
+        .translate = translate_b,
+        .par = (const uint32_t[]){TCG_COND_LTU},
+    }, {
+        .name = "bltui",
+        .translate = translate_bi,
+        .par = (const uint32_t[]){TCG_COND_LTU},
+    }, {
+        .name = "bltz",
+        .translate = translate_bz,
+        .par = (const uint32_t[]){TCG_COND_LT},
+    }, {
+        .name = "bnall",
+        .translate = translate_ball,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "bne",
+        .translate = translate_b,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "bnei",
+        .translate = translate_bi,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "bnez",
+        .translate = translate_bz,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "bnez.n",
+        .translate = translate_bz,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "bnone",
+        .translate = translate_bany,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "break",
+        .translate = translate_break,
+        .par = (const uint32_t[]){DEBUGCAUSE_BI},
+    }, {
+        .name = "break.n",
+        .translate = translate_break,
+        .par = (const uint32_t[]){DEBUGCAUSE_BN},
+    }, {
+        .name = "bt",
+        .translate = translate_bp,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "call0",
+        .translate = translate_call0,
+    }, {
+        .name = "call12",
+        .translate = translate_callw,
+        .par = (const uint32_t[]){3},
+    }, {
+        .name = "call4",
+        .translate = translate_callw,
+        .par = (const uint32_t[]){1},
+    }, {
+        .name = "call8",
+        .translate = translate_callw,
+        .par = (const uint32_t[]){2},
+    }, {
+        .name = "callx0",
+        .translate = translate_callx0,
+    }, {
+        .name = "callx12",
+        .translate = translate_callxw,
+        .par = (const uint32_t[]){3},
+    }, {
+        .name = "callx4",
+        .translate = translate_callxw,
+        .par = (const uint32_t[]){1},
+    }, {
+        .name = "callx8",
+        .translate = translate_callxw,
+        .par = (const uint32_t[]){2},
+    }, {
+        .name = "clamps",
+        .translate = translate_clamps,
+    }, {
+        .name = "depbits",
+        .translate = translate_depbits,
+    }, {
+        .name = "dhi",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){true, true},
+    }, {
+        .name = "dhu",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){true, true},
+    }, {
+        .name = "dhwb",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){false, true},
+    }, {
+        .name = "dhwbi",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){false, true},
+    }, {
+        .name = "dii",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){true, false},
+    }, {
+        .name = "diu",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){true, false},
+    }, {
+        .name = "diwb",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){true, false},
+    }, {
+        .name = "diwbi",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){true, false},
+    }, {
+        .name = "dpfl",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){true, true},
+    }, {
+        .name = "dpfr",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){false, false},
+    }, {
+        .name = "dpfro",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){false, false},
+    }, {
+        .name = "dpfw",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){false, false},
+    }, {
+        .name = "dpfwo",
+        .translate = translate_dcache,
+        .par = (const uint32_t[]){false, false},
+    }, {
+        .name = "dsync",
+        .translate = translate_nop,
+    }, {
+        .name = "entry",
+        .translate = translate_entry,
+    }, {
+        .name = "esync",
+        .translate = translate_nop,
+    }, {
+        .name = "excw",
+        .translate = translate_nop,
+    }, {
+        .name = "extui",
+        .translate = translate_extui,
+    }, {
+        .name = "extw",
+        .translate = translate_nop,
+    }, {
+        .name = "idtlb",
+        .translate = translate_itlb,
+        .par = (const uint32_t[]){true},
+    }, {
+        .name = "ihi",
+        .translate = translate_icache,
+        .par = (const uint32_t[]){false, true},
+    }, {
+        .name = "ihu",
+        .translate = translate_icache,
+        .par = (const uint32_t[]){true, true},
+    }, {
+        .name = "iii",
+        .translate = translate_icache,
+        .par = (const uint32_t[]){true, false},
+    }, {
+        .name = "iitlb",
+        .translate = translate_itlb,
+        .par = (const uint32_t[]){false},
+    }, {
+        .name = "iiu",
+        .translate = translate_icache,
+        .par = (const uint32_t[]){true, false},
+    }, {
+        .name = "ill",
+        .translate = translate_ill,
+    }, {
+        .name = "ill.n",
+        .translate = translate_ill,
+    }, {
+        .name = "ipf",
+        .translate = translate_icache,
+        .par = (const uint32_t[]){false, false},
+    }, {
+        .name = "ipfl",
+        .translate = translate_icache,
+        .par = (const uint32_t[]){true, true},
+    }, {
+        .name = "isync",
+        .translate = translate_nop,
+    }, {
+        .name = "j",
+        .translate = translate_j,
+    }, {
+        .name = "jx",
+        .translate = translate_jx,
+    }, {
+        .name = "l16si",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_TESW, false, false},
+    }, {
+        .name = "l16ui",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_TEUW, false, false},
+    }, {
+        .name = "l32ai",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_TEUL, true, false},
+    }, {
+        .name = "l32e",
+        .translate = translate_l32e,
+    }, {
+        .name = "l32i",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_TEUL, false, false},
+    }, {
+        .name = "l32i.n",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_TEUL, false, false},
+    }, {
+        .name = "l32r",
+        .translate = translate_l32r,
+    }, {
+        .name = "l8ui",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_UB, false, false},
+    }, {
+        .name = "lddec",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_NONE, 0, 0, -4},
+    }, {
+        .name = "ldinc",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_NONE, 0, 0, 4},
+    }, {
+        .name = "loop",
+        .translate = translate_loop,
+        .par = (const uint32_t[]){TCG_COND_NEVER},
+    }, {
+        .name = "loopgtz",
+        .translate = translate_loop,
+        .par = (const uint32_t[]){TCG_COND_GT},
+    }, {
+        .name = "loopnez",
+        .translate = translate_loop,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "max",
+        .translate = translate_minmax,
+        .par = (const uint32_t[]){TCG_COND_GE},
+    }, {
+        .name = "maxu",
+        .translate = translate_minmax,
+        .par = (const uint32_t[]){TCG_COND_GEU},
+    }, {
+        .name = "memw",
+        .translate = translate_nop,
+    }, {
+        .name = "min",
+        .translate = translate_minmax,
+        .par = (const uint32_t[]){TCG_COND_LT},
+    }, {
+        .name = "minu",
+        .translate = translate_minmax,
+        .par = (const uint32_t[]){TCG_COND_LTU},
+    }, {
+        .name = "mov",
+        .translate = translate_mov,
+    }, {
+        .name = "mov.n",
+        .translate = translate_mov,
+    }, {
+        .name = "moveqz",
+        .translate = translate_movcond,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "movf",
+        .translate = translate_movp,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "movgez",
+        .translate = translate_movcond,
+        .par = (const uint32_t[]){TCG_COND_GE},
+    }, {
+        .name = "movi",
+        .translate = translate_movi,
+    }, {
+        .name = "movi.n",
+        .translate = translate_movi,
+    }, {
+        .name = "movltz",
+        .translate = translate_movcond,
+        .par = (const uint32_t[]){TCG_COND_LT},
+    }, {
+        .name = "movnez",
+        .translate = translate_movcond,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "movsp",
+        .translate = translate_movsp,
+    }, {
+        .name = "movt",
+        .translate = translate_movp,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "mul.aa.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_HH, 0},
+    }, {
+        .name = "mul.aa.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_HL, 0},
+    }, {
+        .name = "mul.aa.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_LH, 0},
+    }, {
+        .name = "mul.aa.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_LL, 0},
+    }, {
+        .name = "mul.ad.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_HH, 0},
+    }, {
+        .name = "mul.ad.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_HL, 0},
+    }, {
+        .name = "mul.ad.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_LH, 0},
+    }, {
+        .name = "mul.ad.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_LL, 0},
+    }, {
+        .name = "mul.da.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_HH, 0},
+    }, {
+        .name = "mul.da.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_HL, 0},
+    }, {
+        .name = "mul.da.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_LH, 0},
+    }, {
+        .name = "mul.da.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_LL, 0},
+    }, {
+        .name = "mul.dd.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_DD, MAC16_HH, 0},
+    }, {
+        .name = "mul.dd.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_DD, MAC16_HL, 0},
+    }, {
+        .name = "mul.dd.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_DD, MAC16_LH, 0},
+    }, {
+        .name = "mul.dd.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_DD, MAC16_LL, 0},
+    }, {
+        .name = "mul16s",
+        .translate = translate_mul16,
+        .par = (const uint32_t[]){true},
+    }, {
+        .name = "mul16u",
+        .translate = translate_mul16,
+        .par = (const uint32_t[]){false},
+    }, {
+        .name = "mula.aa.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_HH, 0},
+    }, {
+        .name = "mula.aa.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_HL, 0},
+    }, {
+        .name = "mula.aa.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_LH, 0},
+    }, {
+        .name = "mula.aa.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_LL, 0},
+    }, {
+        .name = "mula.ad.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_HH, 0},
+    }, {
+        .name = "mula.ad.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_HL, 0},
+    }, {
+        .name = "mula.ad.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_LH, 0},
+    }, {
+        .name = "mula.ad.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_LL, 0},
+    }, {
+        .name = "mula.da.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, 0},
+    }, {
+        .name = "mula.da.hh.lddec",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, -4},
+    }, {
+        .name = "mula.da.hh.ldinc",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, 4},
+    }, {
+        .name = "mula.da.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, 0},
+    }, {
+        .name = "mula.da.hl.lddec",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, -4},
+    }, {
+        .name = "mula.da.hl.ldinc",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, 4},
+    }, {
+        .name = "mula.da.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, 0},
+    }, {
+        .name = "mula.da.lh.lddec",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, -4},
+    }, {
+        .name = "mula.da.lh.ldinc",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, 4},
+    }, {
+        .name = "mula.da.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, 0},
+    }, {
+        .name = "mula.da.ll.lddec",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, -4},
+    }, {
+        .name = "mula.da.ll.ldinc",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, 4},
+    }, {
+        .name = "mula.dd.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HH, 0},
+    }, {
+        .name = "mula.dd.hh.lddec",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HH, -4},
+    }, {
+        .name = "mula.dd.hh.ldinc",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HH, 4},
+    }, {
+        .name = "mula.dd.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HL, 0},
+    }, {
+        .name = "mula.dd.hl.lddec",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HL, -4},
+    }, {
+        .name = "mula.dd.hl.ldinc",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HL, 4},
+    }, {
+        .name = "mula.dd.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LH, 0},
+    }, {
+        .name = "mula.dd.lh.lddec",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LH, -4},
+    }, {
+        .name = "mula.dd.lh.ldinc",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LH, 4},
+    }, {
+        .name = "mula.dd.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LL, 0},
+    }, {
+        .name = "mula.dd.ll.lddec",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LL, -4},
+    }, {
+        .name = "mula.dd.ll.ldinc",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LL, 4},
+    }, {
+        .name = "mull",
+        .translate = translate_mull,
+    }, {
+        .name = "muls.aa.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_HH, 0},
+    }, {
+        .name = "muls.aa.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_HL, 0},
+    }, {
+        .name = "muls.aa.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_LH, 0},
+    }, {
+        .name = "muls.aa.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_LL, 0},
+    }, {
+        .name = "muls.ad.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_HH, 0},
+    }, {
+        .name = "muls.ad.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_HL, 0},
+    }, {
+        .name = "muls.ad.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_LH, 0},
+    }, {
+        .name = "muls.ad.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_LL, 0},
+    }, {
+        .name = "muls.da.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_HH, 0},
+    }, {
+        .name = "muls.da.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_HL, 0},
+    }, {
+        .name = "muls.da.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_LH, 0},
+    }, {
+        .name = "muls.da.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_LL, 0},
+    }, {
+        .name = "muls.dd.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_DD, MAC16_HH, 0},
+    }, {
+        .name = "muls.dd.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_DD, MAC16_HL, 0},
+    }, {
+        .name = "muls.dd.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_DD, MAC16_LH, 0},
+    }, {
+        .name = "muls.dd.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_DD, MAC16_LL, 0},
+    }, {
+        .name = "mulsh",
+        .translate = translate_mulh,
+        .par = (const uint32_t[]){true},
+    }, {
+        .name = "muluh",
+        .translate = translate_mulh,
+        .par = (const uint32_t[]){false},
+    }, {
+        .name = "neg",
+        .translate = translate_neg,
+    }, {
+        .name = "nop",
+        .translate = translate_nop,
+    }, {
+        .name = "nop.n",
+        .translate = translate_nop,
+    }, {
+        .name = "nsa",
+        .translate = translate_nsa,
+    }, {
+        .name = "nsau",
+        .translate = translate_nsau,
+    }, {
+        .name = "or",
+        .translate = translate_or,
+    }, {
+        .name = "orb",
+        .translate = translate_boolean,
+        .par = (const uint32_t[]){BOOLEAN_OR},
+    }, {
+        .name = "orbc",
+        .translate = translate_boolean,
+        .par = (const uint32_t[]){BOOLEAN_ORC},
+    }, {
+        .name = "pdtlb",
+        .translate = translate_ptlb,
+        .par = (const uint32_t[]){true},
+    }, {
+        .name = "pitlb",
+        .translate = translate_ptlb,
+        .par = (const uint32_t[]){false},
+    }, {
+        .name = "quos",
+        .translate = translate_quos,
+        .par = (const uint32_t[]){true},
+    }, {
+        .name = "quou",
+        .translate = translate_quou,
+        .par = (const uint32_t[]){true},
+    }, {
+        .name = "rdtlb0",
+        .translate = translate_rtlb,
+        .par = (const uint32_t[]){true, 0},
+    }, {
+        .name = "rdtlb1",
+        .translate = translate_rtlb,
+        .par = (const uint32_t[]){true, 1},
+    }, {
+        .name = "rems",
+        .translate = translate_quos,
+        .par = (const uint32_t[]){false},
+    }, {
+        .name = "remu",
+        .translate = translate_quou,
+        .par = (const uint32_t[]){false},
+    }, {
+        .name = "rer",
+        .translate = translate_rer,
+    }, {
+        .name = "ret",
+        .translate = translate_ret,
+    }, {
+        .name = "ret.n",
+        .translate = translate_ret,
+    }, {
+        .name = "retw",
+        .translate = translate_retw,
+    }, {
+        .name = "retw.n",
+        .translate = translate_retw,
+    }, {
+        .name = "rfde",
+        .translate = translate_rfde,
+    }, {
+        .name = "rfe",
+        .translate = translate_rfe,
+    }, {
+        .name = "rfi",
+        .translate = translate_rfi,
+    }, {
+        .name = "rfwo",
+        .translate = translate_rfw,
+        .par = (const uint32_t[]){true},
+    }, {
+        .name = "rfwu",
+        .translate = translate_rfw,
+        .par = (const uint32_t[]){false},
+    }, {
+        .name = "ritlb0",
+        .translate = translate_rtlb,
+        .par = (const uint32_t[]){false, 0},
+    }, {
+        .name = "ritlb1",
+        .translate = translate_rtlb,
+        .par = (const uint32_t[]){false, 1},
+    }, {
+        .name = "rotw",
+        .translate = translate_rotw,
+    }, {
+        .name = "rsil",
+        .translate = translate_rsil,
+    }, {
+        .name = "rsr.176",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){176},
+    }, {
+        .name = "rsr.208",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){208},
+    }, {
+        .name = "rsr.acchi",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){ACCHI},
+    }, {
+        .name = "rsr.acclo",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){ACCLO},
+    }, {
+        .name = "rsr.atomctl",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){ATOMCTL},
+    }, {
+        .name = "rsr.br",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){BR},
+    }, {
+        .name = "rsr.cacheattr",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){CACHEATTR},
+    }, {
+        .name = "rsr.ccompare0",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){CCOMPARE},
+    }, {
+        .name = "rsr.ccompare1",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){CCOMPARE + 1},
+    }, {
+        .name = "rsr.ccompare2",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){CCOMPARE + 2},
+    }, {
+        .name = "rsr.ccount",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){CCOUNT},
+    }, {
+        .name = "rsr.configid0",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){CONFIGID0},
+    }, {
+        .name = "rsr.configid1",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){CONFIGID1},
+    }, {
+        .name = "rsr.cpenable",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){CPENABLE},
+    }, {
+        .name = "rsr.dbreaka0",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){DBREAKA},
+    }, {
+        .name = "rsr.dbreaka1",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){DBREAKA + 1},
+    }, {
+        .name = "rsr.dbreakc0",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){DBREAKC},
+    }, {
+        .name = "rsr.dbreakc1",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){DBREAKC + 1},
+    }, {
+        .name = "rsr.debugcause",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){DEBUGCAUSE},
+    }, {
+        .name = "rsr.depc",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){DEPC},
+    }, {
+        .name = "rsr.dtlbcfg",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){DTLBCFG},
+    }, {
+        .name = "rsr.epc1",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPC1},
+    }, {
+        .name = "rsr.epc2",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPC1 + 1},
+    }, {
+        .name = "rsr.epc3",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPC1 + 2},
+    }, {
+        .name = "rsr.epc4",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPC1 + 3},
+    }, {
+        .name = "rsr.epc5",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPC1 + 4},
+    }, {
+        .name = "rsr.epc6",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPC1 + 5},
+    }, {
+        .name = "rsr.epc7",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPC1 + 6},
+    }, {
+        .name = "rsr.eps2",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPS2},
+    }, {
+        .name = "rsr.eps3",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPS2 + 1},
+    }, {
+        .name = "rsr.eps4",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPS2 + 2},
+    }, {
+        .name = "rsr.eps5",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPS2 + 3},
+    }, {
+        .name = "rsr.eps6",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPS2 + 4},
+    }, {
+        .name = "rsr.eps7",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EPS2 + 5},
+    }, {
+        .name = "rsr.exccause",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EXCCAUSE},
+    }, {
+        .name = "rsr.excsave1",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EXCSAVE1},
+    }, {
+        .name = "rsr.excsave2",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 1},
+    }, {
+        .name = "rsr.excsave3",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 2},
+    }, {
+        .name = "rsr.excsave4",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 3},
+    }, {
+        .name = "rsr.excsave5",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 4},
+    }, {
+        .name = "rsr.excsave6",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 5},
+    }, {
+        .name = "rsr.excsave7",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 6},
+    }, {
+        .name = "rsr.excvaddr",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){EXCVADDR},
+    }, {
+        .name = "rsr.ibreaka0",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){IBREAKA},
+    }, {
+        .name = "rsr.ibreaka1",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){IBREAKA + 1},
+    }, {
+        .name = "rsr.ibreakenable",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){IBREAKENABLE},
+    }, {
+        .name = "rsr.icount",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){ICOUNT},
+    }, {
+        .name = "rsr.icountlevel",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){ICOUNTLEVEL},
+    }, {
+        .name = "rsr.intclear",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){INTCLEAR},
+    }, {
+        .name = "rsr.intenable",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){INTENABLE},
+    }, {
+        .name = "rsr.interrupt",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){INTSET},
+    }, {
+        .name = "rsr.intset",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){INTSET},
+    }, {
+        .name = "rsr.itlbcfg",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){ITLBCFG},
+    }, {
+        .name = "rsr.lbeg",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){LBEG},
+    }, {
+        .name = "rsr.lcount",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){LCOUNT},
+    }, {
+        .name = "rsr.lend",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){LEND},
+    }, {
+        .name = "rsr.litbase",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){LITBASE},
+    }, {
+        .name = "rsr.m0",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){MR},
+    }, {
+        .name = "rsr.m1",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){MR + 1},
+    }, {
+        .name = "rsr.m2",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){MR + 2},
+    }, {
+        .name = "rsr.m3",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){MR + 3},
+    }, {
+        .name = "rsr.memctl",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){MEMCTL},
+    }, {
+        .name = "rsr.misc0",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){MISC},
+    }, {
+        .name = "rsr.misc1",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){MISC + 1},
+    }, {
+        .name = "rsr.misc2",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){MISC + 2},
+    }, {
+        .name = "rsr.misc3",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){MISC + 3},
+    }, {
+        .name = "rsr.prid",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){PRID},
+    }, {
+        .name = "rsr.ps",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){PS},
+    }, {
+        .name = "rsr.ptevaddr",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){PTEVADDR},
+    }, {
+        .name = "rsr.rasid",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){RASID},
+    }, {
+        .name = "rsr.sar",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){SAR},
+    }, {
+        .name = "rsr.scompare1",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){SCOMPARE1},
+    }, {
+        .name = "rsr.vecbase",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){VECBASE},
+    }, {
+        .name = "rsr.windowbase",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){WINDOW_BASE},
+    }, {
+        .name = "rsr.windowstart",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){WINDOW_START},
+    }, {
+        .name = "rsync",
+        .translate = translate_nop,
+    }, {
+        .name = "rur.fcr",
+        .translate = translate_rur,
+        .par = (const uint32_t[]){FCR},
+    }, {
+        .name = "rur.fsr",
+        .translate = translate_rur,
+        .par = (const uint32_t[]){FSR},
+    }, {
+        .name = "rur.threadptr",
+        .translate = translate_rur,
+        .par = (const uint32_t[]){THREADPTR},
+    }, {
+        .name = "s16i",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_TEUW, false, true},
+    }, {
+        .name = "s32c1i",
+        .translate = translate_s32c1i,
+    }, {
+        .name = "s32e",
+        .translate = translate_s32e,
+    }, {
+        .name = "s32i",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_TEUL, false, true},
+    }, {
+        .name = "s32i.n",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_TEUL, false, true},
+    }, {
+        .name = "s32nb",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_TEUL, false, true},
+    }, {
+        .name = "s32ri",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_TEUL, true, true},
+    }, {
+        .name = "s8i",
+        .translate = translate_ldst,
+        .par = (const uint32_t[]){MO_UB, false, true},
+    }, {
+        .name = "sext",
+        .translate = translate_sext,
+    }, {
+        .name = "simcall",
+        .translate = translate_simcall,
+    }, {
+        .name = "sll",
+        .translate = translate_sll,
+    }, {
+        .name = "slli",
+        .translate = translate_slli,
+    }, {
+        .name = "sra",
+        .translate = translate_sra,
+    }, {
+        .name = "srai",
+        .translate = translate_srai,
+    }, {
+        .name = "src",
+        .translate = translate_src,
+    }, {
+        .name = "srl",
+        .translate = translate_srl,
+    }, {
+        .name = "srli",
+        .translate = translate_srli,
+    }, {
+        .name = "ssa8b",
+        .translate = translate_ssa8b,
+    }, {
+        .name = "ssa8l",
+        .translate = translate_ssa8l,
+    }, {
+        .name = "ssai",
+        .translate = translate_ssai,
+    }, {
+        .name = "ssl",
+        .translate = translate_ssl,
+    }, {
+        .name = "ssr",
+        .translate = translate_ssr,
+    }, {
+        .name = "sub",
+        .translate = translate_sub,
+    }, {
+        .name = "subx2",
+        .translate = translate_subx,
+        .par = (const uint32_t[]){1},
+    }, {
+        .name = "subx4",
+        .translate = translate_subx,
+        .par = (const uint32_t[]){2},
+    }, {
+        .name = "subx8",
+        .translate = translate_subx,
+        .par = (const uint32_t[]){3},
+    }, {
+        .name = "syscall",
+        .translate = translate_syscall,
+    }, {
+        .name = "umul.aa.hh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_HH, 0},
+    }, {
+        .name = "umul.aa.hl",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_HL, 0},
+    }, {
+        .name = "umul.aa.lh",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_LH, 0},
+    }, {
+        .name = "umul.aa.ll",
+        .translate = translate_mac16,
+        .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_LL, 0},
+    }, {
+        .name = "waiti",
+        .translate = translate_waiti,
+    }, {
+        .name = "wdtlb",
+        .translate = translate_wtlb,
+        .par = (const uint32_t[]){true},
+    }, {
+        .name = "wer",
+        .translate = translate_wer,
+    }, {
+        .name = "witlb",
+        .translate = translate_wtlb,
+        .par = (const uint32_t[]){false},
+    }, {
+        .name = "wsr.176",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){176},
+    }, {
+        .name = "wsr.208",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){208},
+    }, {
+        .name = "wsr.acchi",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){ACCHI},
+    }, {
+        .name = "wsr.acclo",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){ACCLO},
+    }, {
+        .name = "wsr.atomctl",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){ATOMCTL},
+    }, {
+        .name = "wsr.br",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){BR},
+    }, {
+        .name = "wsr.cacheattr",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){CACHEATTR},
+    }, {
+        .name = "wsr.ccompare0",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){CCOMPARE},
+    }, {
+        .name = "wsr.ccompare1",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){CCOMPARE + 1},
+    }, {
+        .name = "wsr.ccompare2",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){CCOMPARE + 2},
+    }, {
+        .name = "wsr.ccount",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){CCOUNT},
+    }, {
+        .name = "wsr.configid0",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){CONFIGID0},
+    }, {
+        .name = "wsr.configid1",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){CONFIGID1},
+    }, {
+        .name = "wsr.cpenable",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){CPENABLE},
+    }, {
+        .name = "wsr.dbreaka0",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){DBREAKA},
+    }, {
+        .name = "wsr.dbreaka1",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){DBREAKA + 1},
+    }, {
+        .name = "wsr.dbreakc0",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){DBREAKC},
+    }, {
+        .name = "wsr.dbreakc1",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){DBREAKC + 1},
+    }, {
+        .name = "wsr.debugcause",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){DEBUGCAUSE},
+    }, {
+        .name = "wsr.depc",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){DEPC},
+    }, {
+        .name = "wsr.dtlbcfg",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){DTLBCFG},
+    }, {
+        .name = "wsr.epc1",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPC1},
+    }, {
+        .name = "wsr.epc2",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPC1 + 1},
+    }, {
+        .name = "wsr.epc3",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPC1 + 2},
+    }, {
+        .name = "wsr.epc4",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPC1 + 3},
+    }, {
+        .name = "wsr.epc5",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPC1 + 4},
+    }, {
+        .name = "wsr.epc6",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPC1 + 5},
+    }, {
+        .name = "wsr.epc7",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPC1 + 6},
+    }, {
+        .name = "wsr.eps2",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPS2},
+    }, {
+        .name = "wsr.eps3",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPS2 + 1},
+    }, {
+        .name = "wsr.eps4",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPS2 + 2},
+    }, {
+        .name = "wsr.eps5",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPS2 + 3},
+    }, {
+        .name = "wsr.eps6",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPS2 + 4},
+    }, {
+        .name = "wsr.eps7",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EPS2 + 5},
+    }, {
+        .name = "wsr.exccause",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EXCCAUSE},
+    }, {
+        .name = "wsr.excsave1",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EXCSAVE1},
+    }, {
+        .name = "wsr.excsave2",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 1},
+    }, {
+        .name = "wsr.excsave3",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 2},
+    }, {
+        .name = "wsr.excsave4",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 3},
+    }, {
+        .name = "wsr.excsave5",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 4},
+    }, {
+        .name = "wsr.excsave6",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 5},
+    }, {
+        .name = "wsr.excsave7",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 6},
+    }, {
+        .name = "wsr.excvaddr",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){EXCVADDR},
+    }, {
+        .name = "wsr.ibreaka0",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){IBREAKA},
+    }, {
+        .name = "wsr.ibreaka1",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){IBREAKA + 1},
+    }, {
+        .name = "wsr.ibreakenable",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){IBREAKENABLE},
+    }, {
+        .name = "wsr.icount",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){ICOUNT},
+    }, {
+        .name = "wsr.icountlevel",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){ICOUNTLEVEL},
+    }, {
+        .name = "wsr.intclear",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){INTCLEAR},
+    }, {
+        .name = "wsr.intenable",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){INTENABLE},
+    }, {
+        .name = "wsr.interrupt",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){INTSET},
+    }, {
+        .name = "wsr.intset",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){INTSET},
+    }, {
+        .name = "wsr.itlbcfg",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){ITLBCFG},
+    }, {
+        .name = "wsr.lbeg",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){LBEG},
+    }, {
+        .name = "wsr.lcount",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){LCOUNT},
+    }, {
+        .name = "wsr.lend",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){LEND},
+    }, {
+        .name = "wsr.litbase",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){LITBASE},
+    }, {
+        .name = "wsr.m0",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){MR},
+    }, {
+        .name = "wsr.m1",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){MR + 1},
+    }, {
+        .name = "wsr.m2",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){MR + 2},
+    }, {
+        .name = "wsr.m3",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){MR + 3},
+    }, {
+        .name = "wsr.memctl",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){MEMCTL},
+    }, {
+        .name = "wsr.misc0",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){MISC},
+    }, {
+        .name = "wsr.misc1",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){MISC + 1},
+    }, {
+        .name = "wsr.misc2",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){MISC + 2},
+    }, {
+        .name = "wsr.misc3",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){MISC + 3},
+    }, {
+        .name = "wsr.prid",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){PRID},
+    }, {
+        .name = "wsr.ps",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){PS},
+    }, {
+        .name = "wsr.ptevaddr",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){PTEVADDR},
+    }, {
+        .name = "wsr.rasid",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){RASID},
+    }, {
+        .name = "wsr.sar",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){SAR},
+    }, {
+        .name = "wsr.scompare1",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){SCOMPARE1},
+    }, {
+        .name = "wsr.vecbase",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){VECBASE},
+    }, {
+        .name = "wsr.windowbase",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){WINDOW_BASE},
+    }, {
+        .name = "wsr.windowstart",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){WINDOW_START},
+    }, {
+        .name = "wur.fcr",
+        .translate = translate_wur,
+        .par = (const uint32_t[]){FCR},
+    }, {
+        .name = "wur.fsr",
+        .translate = translate_wur,
+        .par = (const uint32_t[]){FSR},
+    }, {
+        .name = "wur.threadptr",
+        .translate = translate_wur,
+        .par = (const uint32_t[]){THREADPTR},
+    }, {
+        .name = "xor",
+        .translate = translate_xor,
+    }, {
+        .name = "xorb",
+        .translate = translate_boolean,
+        .par = (const uint32_t[]){BOOLEAN_XOR},
+    }, {
+        .name = "xsr.176",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){176},
+    }, {
+        .name = "xsr.208",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){208},
+    }, {
+        .name = "xsr.acchi",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){ACCHI},
+    }, {
+        .name = "xsr.acclo",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){ACCLO},
+    }, {
+        .name = "xsr.atomctl",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){ATOMCTL},
+    }, {
+        .name = "xsr.br",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){BR},
+    }, {
+        .name = "xsr.cacheattr",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){CACHEATTR},
+    }, {
+        .name = "xsr.ccompare0",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){CCOMPARE},
+    }, {
+        .name = "xsr.ccompare1",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){CCOMPARE + 1},
+    }, {
+        .name = "xsr.ccompare2",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){CCOMPARE + 2},
+    }, {
+        .name = "xsr.ccount",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){CCOUNT},
+    }, {
+        .name = "xsr.configid0",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){CONFIGID0},
+    }, {
+        .name = "xsr.configid1",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){CONFIGID1},
+    }, {
+        .name = "xsr.cpenable",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){CPENABLE},
+    }, {
+        .name = "xsr.dbreaka0",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){DBREAKA},
+    }, {
+        .name = "xsr.dbreaka1",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){DBREAKA + 1},
+    }, {
+        .name = "xsr.dbreakc0",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){DBREAKC},
+    }, {
+        .name = "xsr.dbreakc1",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){DBREAKC + 1},
+    }, {
+        .name = "xsr.debugcause",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){DEBUGCAUSE},
+    }, {
+        .name = "xsr.depc",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){DEPC},
+    }, {
+        .name = "xsr.dtlbcfg",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){DTLBCFG},
+    }, {
+        .name = "xsr.epc1",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPC1},
+    }, {
+        .name = "xsr.epc2",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPC1 + 1},
+    }, {
+        .name = "xsr.epc3",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPC1 + 2},
+    }, {
+        .name = "xsr.epc4",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPC1 + 3},
+    }, {
+        .name = "xsr.epc5",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPC1 + 4},
+    }, {
+        .name = "xsr.epc6",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPC1 + 5},
+    }, {
+        .name = "xsr.epc7",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPC1 + 6},
+    }, {
+        .name = "xsr.eps2",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPS2},
+    }, {
+        .name = "xsr.eps3",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPS2 + 1},
+    }, {
+        .name = "xsr.eps4",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPS2 + 2},
+    }, {
+        .name = "xsr.eps5",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPS2 + 3},
+    }, {
+        .name = "xsr.eps6",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPS2 + 4},
+    }, {
+        .name = "xsr.eps7",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EPS2 + 5},
+    }, {
+        .name = "xsr.exccause",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EXCCAUSE},
+    }, {
+        .name = "xsr.excsave1",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EXCSAVE1},
+    }, {
+        .name = "xsr.excsave2",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 1},
+    }, {
+        .name = "xsr.excsave3",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 2},
+    }, {
+        .name = "xsr.excsave4",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 3},
+    }, {
+        .name = "xsr.excsave5",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 4},
+    }, {
+        .name = "xsr.excsave6",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 5},
+    }, {
+        .name = "xsr.excsave7",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EXCSAVE1 + 6},
+    }, {
+        .name = "xsr.excvaddr",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){EXCVADDR},
+    }, {
+        .name = "xsr.ibreaka0",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){IBREAKA},
+    }, {
+        .name = "xsr.ibreaka1",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){IBREAKA + 1},
+    }, {
+        .name = "xsr.ibreakenable",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){IBREAKENABLE},
+    }, {
+        .name = "xsr.icount",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){ICOUNT},
+    }, {
+        .name = "xsr.icountlevel",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){ICOUNTLEVEL},
+    }, {
+        .name = "xsr.intclear",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){INTCLEAR},
+    }, {
+        .name = "xsr.intenable",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){INTENABLE},
+    }, {
+        .name = "xsr.interrupt",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){INTSET},
+    }, {
+        .name = "xsr.intset",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){INTSET},
+    }, {
+        .name = "xsr.itlbcfg",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){ITLBCFG},
+    }, {
+        .name = "xsr.lbeg",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){LBEG},
+    }, {
+        .name = "xsr.lcount",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){LCOUNT},
+    }, {
+        .name = "xsr.lend",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){LEND},
+    }, {
+        .name = "xsr.litbase",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){LITBASE},
+    }, {
+        .name = "xsr.m0",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){MR},
+    }, {
+        .name = "xsr.m1",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){MR + 1},
+    }, {
+        .name = "xsr.m2",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){MR + 2},
+    }, {
+        .name = "xsr.m3",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){MR + 3},
+    }, {
+        .name = "xsr.memctl",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){MEMCTL},
+    }, {
+        .name = "xsr.misc0",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){MISC},
+    }, {
+        .name = "xsr.misc1",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){MISC + 1},
+    }, {
+        .name = "xsr.misc2",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){MISC + 2},
+    }, {
+        .name = "xsr.misc3",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){MISC + 3},
+    }, {
+        .name = "xsr.prid",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){PRID},
+    }, {
+        .name = "xsr.ps",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){PS},
+    }, {
+        .name = "xsr.ptevaddr",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){PTEVADDR},
+    }, {
+        .name = "xsr.rasid",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){RASID},
+    }, {
+        .name = "xsr.sar",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){SAR},
+    }, {
+        .name = "xsr.scompare1",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){SCOMPARE1},
+    }, {
+        .name = "xsr.vecbase",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){VECBASE},
+    }, {
+        .name = "xsr.windowbase",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){WINDOW_BASE},
+    }, {
+        .name = "xsr.windowstart",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){WINDOW_START},
+    },
+};
+
+const XtensaOpcodeTranslators xtensa_core_opcodes = {
+    .num_opcodes = ARRAY_SIZE(core_ops),
+    .opcode = core_ops,
+};
-- 
2.1.4
