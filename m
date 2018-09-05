Received: from eggs.gnu.org ([2001:4830:134:3::10]:57952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsE-00067A-Jm
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMry-0006mn-RY
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:47 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMrx-0006lH-UI
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:34 -0400
Received: by mail-lf1-x144.google.com with SMTP id e23-v6so4552537lfc.13
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:33 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:42 -0700
Message-Id: <20180905014352.970-6-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 05/15] target/xtensa: extract test for window
 overflow exception
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

- add ps.callinc to the TB flags, that allows testing all instructions
  for window overflow statically;
- drop gen_window_check* functions; replace them with get_window_check
  that accepts bitmask of used registers;
- add XtensaOpcodeOps::test_overflow that returns bitmask of implicitly
  used registers; use it for entry and call{,x}{4,8,12};
- drop window overflow test from the entry helper;
- drop parameter 0 from translate_[di]cache and use translate_nop for
  d/i cache opcodes that don't need memory accessibility check;
- add bitmask XtensaOpcodeOps::windowed_register_op that marks opcode
  arguments that refer to windowed registers;
- translate windowed_register_op mask to a mask of actually used
  registers in the disassembly loop;
- add check for window overflow right after the check for debug
  exception;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |    9 +
 target/xtensa/op_helper.c |    5 -
 target/xtensa/translate.c | 1462 +++++++++++++++++++++++++++------------------
 3 files changed, 889 insertions(+), 587 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0a0323f3868e..be234958a228 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -351,6 +351,9 @@ typedef void (*XtensaOpcodeOp)(DisasContext *dc, const uint32_t arg[],
 typedef bool (*XtensaOpcodeBoolTest)(DisasContext *dc,
                                      const uint32_t arg[],
                                      const uint32_t par[]);
+typedef uint32_t (*XtensaOpcodeUintTest)(DisasContext *dc,
+                                         const uint32_t arg[],
+                                         const uint32_t par[]);
 
 enum {
     XTENSA_OP_ILL = 0x1,
@@ -374,8 +377,10 @@ typedef struct XtensaOpcodeOps {
     const char *name;
     XtensaOpcodeOp translate;
     XtensaOpcodeBoolTest test_ill;
+    XtensaOpcodeUintTest test_overflow;
     const uint32_t *par;
     uint32_t op_flags;
+    uint32_t windowed_register_op;
 } XtensaOpcodeOps;
 
 typedef struct XtensaOpcodeTranslators {
@@ -686,6 +691,8 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
 #define XTENSA_TBFLAG_WINDOW_SHIFT 15
 #define XTENSA_TBFLAG_YIELD 0x20000
 #define XTENSA_TBFLAG_CWOE 0x40000
+#define XTENSA_TBFLAG_CALLINC_MASK 0x180000
+#define XTENSA_TBFLAG_CALLINC_SHIFT 19
 
 static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
         target_ulong *cs_base, uint32_t *flags)
@@ -724,6 +731,8 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
         uint32_t w = ctz32(windowstart | 0x8);
 
         *flags |= (w << XTENSA_TBFLAG_WINDOW_SHIFT) | XTENSA_TBFLAG_CWOE;
+        *flags |= extract32(env->sregs[PS], PS_CALLINC_SHIFT,
+                            PS_CALLINC_LEN) << XTENSA_TBFLAG_CALLINC_SHIFT;
     } else {
         *flags |= 3 << XTENSA_TBFLAG_WINDOW_SHIFT;
     }
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index f5520659d8f9..68052851af32 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -253,12 +253,7 @@ void HELPER(wsr_windowbase)(CPUXtensaState *env, uint32_t v)
 void HELPER(entry)(CPUXtensaState *env, uint32_t pc, uint32_t s, uint32_t imm)
 {
     int callinc = (env->sregs[PS] & PS_CALLINC) >> PS_CALLINC_SHIFT;
-    uint32_t windowstart = xtensa_replicate_windowstart(env) >>
-        (env->sregs[WINDOW_BASE] + 1);
 
-    if (windowstart & ((1 << callinc) - 1)) {
-        HELPER(window_check)(env, pc, callinc);
-    }
     env->regs[(callinc << 2) | (s & 3)] = env->regs[s] - imm;
     xtensa_rotate_window(env, callinc);
     env->sregs[WINDOW_START] |=
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 5222c952a1b7..de306bdfd344 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -62,6 +62,7 @@ struct DisasContext {
     TCGv_i32 sar_m32;
 
     unsigned window;
+    unsigned callinc;
     bool cwoe;
 
     bool debug;
@@ -904,11 +905,13 @@ static void gen_waiti(DisasContext *dc, uint32_t imm4)
 }
 #endif
 
-static bool gen_window_check1(DisasContext *dc, unsigned r1)
+static bool gen_window_check(DisasContext *dc, uint32_t mask)
 {
-    if (r1 / 4 > dc->window) {
+    unsigned r = 31 - clz32(mask);
+
+    if (r / 4 > dc->window) {
         TCGv_i32 pc = tcg_const_i32(dc->pc);
-        TCGv_i32 w = tcg_const_i32(r1 / 4);
+        TCGv_i32 w = tcg_const_i32(r / 4);
 
         gen_helper_window_check(cpu_env, pc, w);
         dc->base.is_jmp = DISAS_NORETURN;
@@ -917,17 +920,6 @@ static bool gen_window_check1(DisasContext *dc, unsigned r1)
     return true;
 }
 
-static bool gen_window_check2(DisasContext *dc, unsigned r1, unsigned r2)
-{
-    return gen_window_check1(dc, r1 > r2 ? r1 : r2);
-}
-
-static bool gen_window_check3(DisasContext *dc, unsigned r1, unsigned r2,
-        unsigned r3)
-{
-    return gen_window_check2(dc, r1, r2 > r3 ? r2 : r3);
-}
-
 static TCGv_i32 gen_mac16_m(TCGv_i32 v, bool hi, bool is_unsigned)
 {
     TCGv_i32 m = tcg_temp_new_i32();
@@ -960,6 +952,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         uint32_t raw_arg[MAX_OPCODE_ARGS];
     } slot_prop[MAX_INSN_SLOTS];
     uint32_t debug_cause = 0;
+    uint32_t windowed_register = 0;
 
     if (len == XTENSA_UNDEFINED) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -1044,6 +1037,19 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         if (ops->op_flags & XTENSA_OP_DEBUG_BREAK) {
             debug_cause |= ops->par[0];
         }
+        if (ops->test_overflow) {
+            windowed_register |= ops->test_overflow(dc, arg, ops->par);
+        }
+        if (ops->windowed_register_op) {
+            uint32_t reg_opnd = ops->windowed_register_op;
+
+            while (reg_opnd) {
+                unsigned i = ctz32(reg_opnd);
+
+                windowed_register |= 1 << arg[i];
+                reg_opnd ^= 1 << i;
+            }
+        }
     }
 
     if ((op_flags & XTENSA_OP_PRIVILEGED) &&
@@ -1061,6 +1067,10 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         return;
     }
 
+    if (windowed_register && !gen_window_check(dc, windowed_register)) {
+        return;
+    }
+
     for (slot = 0; slot < slots; ++slot) {
         XtensaOpcodeOps *ops = slot_prop[slot].ops;
 
@@ -1112,6 +1122,8 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
     dc->window = ((tb_flags & XTENSA_TBFLAG_WINDOW_MASK) >>
                  XTENSA_TBFLAG_WINDOW_SHIFT);
     dc->cwoe = tb_flags & XTENSA_TBFLAG_CWOE;
+    dc->callinc = ((tb_flags & XTENSA_TBFLAG_CALLINC_MASK) >>
+                   XTENSA_TBFLAG_CALLINC_SHIFT);
 
     if (dc->config->isa) {
         dc->insnbuf = xtensa_insnbuf_alloc(dc->config->isa);
@@ -1333,43 +1345,35 @@ xtensa_find_opcode_ops(const XtensaOpcodeTranslators *t,
 static void translate_abs(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 zero = tcg_const_i32(0);
-        TCGv_i32 neg = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 neg = tcg_temp_new_i32();
 
-        tcg_gen_neg_i32(neg, cpu_R[arg[1]]);
-        tcg_gen_movcond_i32(TCG_COND_GE, cpu_R[arg[0]],
-                            cpu_R[arg[1]], zero, cpu_R[arg[1]], neg);
-        tcg_temp_free(neg);
-        tcg_temp_free(zero);
-    }
+    tcg_gen_neg_i32(neg, cpu_R[arg[1]]);
+    tcg_gen_movcond_i32(TCG_COND_GE, cpu_R[arg[0]],
+                        cpu_R[arg[1]], zero, cpu_R[arg[1]], neg);
+    tcg_temp_free(neg);
+    tcg_temp_free(zero);
 }
 
 static void translate_add(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_add_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_add_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_addi(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        tcg_gen_addi_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
-    }
+    tcg_gen_addi_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
 }
 
 static void translate_addx(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_shli_i32(tmp, cpu_R[arg[1]], par[0]);
-        tcg_gen_add_i32(cpu_R[arg[0]], tmp, cpu_R[arg[2]]);
-        tcg_temp_free(tmp);
-    }
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_shli_i32(tmp, cpu_R[arg[1]], par[0]);
+    tcg_gen_add_i32(cpu_R[arg[0]], tmp, cpu_R[arg[2]]);
+    tcg_temp_free(tmp);
 }
 
 static void translate_all(DisasContext *dc, const uint32_t arg[],
@@ -1395,93 +1399,77 @@ static void translate_all(DisasContext *dc, const uint32_t arg[],
 static void translate_and(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_and_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_and_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_ball(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_and_i32(tmp, cpu_R[arg[0]], cpu_R[arg[1]]);
-        gen_brcond(dc, par[0], tmp, cpu_R[arg[1]], arg[2]);
-        tcg_temp_free(tmp);
-    }
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_and_i32(tmp, cpu_R[arg[0]], cpu_R[arg[1]]);
+    gen_brcond(dc, par[0], tmp, cpu_R[arg[1]], arg[2]);
+    tcg_temp_free(tmp);
 }
 
 static void translate_bany(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_and_i32(tmp, cpu_R[arg[0]], cpu_R[arg[1]]);
-        gen_brcondi(dc, par[0], tmp, 0, arg[2]);
-        tcg_temp_free(tmp);
-    }
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_and_i32(tmp, cpu_R[arg[0]], cpu_R[arg[1]]);
+    gen_brcondi(dc, par[0], tmp, 0, arg[2]);
+    tcg_temp_free(tmp);
 }
 
 static void translate_b(DisasContext *dc, const uint32_t arg[],
                         const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        gen_brcond(dc, par[0], cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
-    }
+    gen_brcond(dc, par[0], cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
 }
 
 static void translate_bb(DisasContext *dc, const uint32_t arg[],
                          const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
 #ifdef TARGET_WORDS_BIGENDIAN
-        TCGv_i32 bit = tcg_const_i32(0x80000000u);
+    TCGv_i32 bit = tcg_const_i32(0x80000000u);
 #else
-        TCGv_i32 bit = tcg_const_i32(0x00000001u);
+    TCGv_i32 bit = tcg_const_i32(0x00000001u);
 #endif
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_andi_i32(tmp, cpu_R[arg[1]], 0x1f);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_andi_i32(tmp, cpu_R[arg[1]], 0x1f);
 #ifdef TARGET_WORDS_BIGENDIAN
-        tcg_gen_shr_i32(bit, bit, tmp);
+    tcg_gen_shr_i32(bit, bit, tmp);
 #else
-        tcg_gen_shl_i32(bit, bit, tmp);
+    tcg_gen_shl_i32(bit, bit, tmp);
 #endif
-        tcg_gen_and_i32(tmp, cpu_R[arg[0]], bit);
-        gen_brcondi(dc, par[0], tmp, 0, arg[2]);
-        tcg_temp_free(tmp);
-        tcg_temp_free(bit);
-    }
+    tcg_gen_and_i32(tmp, cpu_R[arg[0]], bit);
+    gen_brcondi(dc, par[0], tmp, 0, arg[2]);
+    tcg_temp_free(tmp);
+    tcg_temp_free(bit);
 }
 
 static void translate_bbi(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
+    TCGv_i32 tmp = tcg_temp_new_i32();
 #ifdef TARGET_WORDS_BIGENDIAN
-        tcg_gen_andi_i32(tmp, cpu_R[arg[0]], 0x80000000u >> arg[1]);
+    tcg_gen_andi_i32(tmp, cpu_R[arg[0]], 0x80000000u >> arg[1]);
 #else
-        tcg_gen_andi_i32(tmp, cpu_R[arg[0]], 0x00000001u << arg[1]);
+    tcg_gen_andi_i32(tmp, cpu_R[arg[0]], 0x00000001u << arg[1]);
 #endif
-        gen_brcondi(dc, par[0], tmp, 0, arg[2]);
-        tcg_temp_free(tmp);
-    }
+    gen_brcondi(dc, par[0], tmp, 0, arg[2]);
+    tcg_temp_free(tmp);
 }
 
 static void translate_bi(DisasContext *dc, const uint32_t arg[],
                          const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        gen_brcondi(dc, par[0], cpu_R[arg[0]], arg[1], arg[2]);
-    }
+    gen_brcondi(dc, par[0], cpu_R[arg[0]], arg[1], arg[2]);
 }
 
 static void translate_bz(DisasContext *dc, const uint32_t arg[],
                          const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        gen_brcondi(dc, par[0], cpu_R[arg[0]], 0, arg[1]);
-    }
+    gen_brcondi(dc, par[0], cpu_R[arg[0]], 0, arg[1]);
 }
 
 enum {
@@ -1531,50 +1519,48 @@ static void translate_call0(DisasContext *dc, const uint32_t arg[],
     gen_jumpi(dc, arg[0], 0);
 }
 
+static uint32_t test_overflow_callw(DisasContext *dc, const uint32_t arg[],
+                                    const uint32_t par[])
+{
+    return 1 << (par[0] * 4);
+}
+
 static void translate_callw(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_window_check1(dc, par[0] << 2)) {
-        gen_callwi(dc, par[0], arg[0], 0);
-    }
+    gen_callwi(dc, par[0], arg[0], 0);
 }
 
 static void translate_callx0(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
-        tcg_gen_movi_i32(cpu_R[0], dc->base.pc_next);
-        gen_jump(dc, tmp);
-        tcg_temp_free(tmp);
-    }
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
+    tcg_gen_movi_i32(cpu_R[0], dc->base.pc_next);
+    gen_jump(dc, tmp);
+    tcg_temp_free(tmp);
 }
 
 static void translate_callxw(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], par[0] << 2)) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-        tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
-        gen_callw(dc, par[0], tmp);
-        tcg_temp_free(tmp);
-    }
+    tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
+    gen_callw(dc, par[0], tmp);
+    tcg_temp_free(tmp);
 }
 
 static void translate_clamps(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 tmp1 = tcg_const_i32(-1u << arg[2]);
-        TCGv_i32 tmp2 = tcg_const_i32((1 << arg[2]) - 1);
+    TCGv_i32 tmp1 = tcg_const_i32(-1u << arg[2]);
+    TCGv_i32 tmp2 = tcg_const_i32((1 << arg[2]) - 1);
 
-        tcg_gen_smax_i32(tmp1, tmp1, cpu_R[arg[1]]);
-        tcg_gen_smin_i32(cpu_R[arg[0]], tmp1, tmp2);
-        tcg_temp_free(tmp1);
-        tcg_temp_free(tmp2);
-    }
+    tcg_gen_smax_i32(tmp1, tmp1, cpu_R[arg[1]]);
+    tcg_gen_smin_i32(cpu_R[arg[0]], tmp1, tmp2);
+    tcg_temp_free(tmp1);
+    tcg_temp_free(tmp2);
 }
 
 static void translate_clrb_expstate(DisasContext *dc, const uint32_t arg[],
@@ -1587,36 +1573,29 @@ static void translate_clrb_expstate(DisasContext *dc, const uint32_t arg[],
 static void translate_const16(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        TCGv_i32 c = tcg_const_i32(arg[1]);
+    TCGv_i32 c = tcg_const_i32(arg[1]);
 
-        tcg_gen_deposit_i32(cpu_R[arg[0]], c, cpu_R[arg[0]], 16, 16);
-        tcg_temp_free(c);
-    }
+    tcg_gen_deposit_i32(cpu_R[arg[0]], c, cpu_R[arg[0]], 16, 16);
+    tcg_temp_free(c);
 }
 
-/* par[0]: check memory access */
 static void translate_dcache(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0]) && par[0]) {
-        TCGv_i32 addr = tcg_temp_new_i32();
-        TCGv_i32 res = tcg_temp_new_i32();
+    TCGv_i32 addr = tcg_temp_new_i32();
+    TCGv_i32 res = tcg_temp_new_i32();
 
-        tcg_gen_addi_i32(addr, cpu_R[arg[0]], arg[1]);
-        tcg_gen_qemu_ld8u(res, addr, dc->cring);
-        tcg_temp_free(addr);
-        tcg_temp_free(res);
-    }
+    tcg_gen_addi_i32(addr, cpu_R[arg[0]], arg[1]);
+    tcg_gen_qemu_ld8u(res, addr, dc->cring);
+    tcg_temp_free(addr);
+    tcg_temp_free(res);
 }
 
 static void translate_depbits(DisasContext *dc, const uint32_t arg[],
                               const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        tcg_gen_deposit_i32(cpu_R[arg[1]], cpu_R[arg[1]], cpu_R[arg[0]],
-                            arg[2], arg[3]);
-    }
+    tcg_gen_deposit_i32(cpu_R[arg[1]], cpu_R[arg[1]], cpu_R[arg[0]],
+                        arg[2], arg[3]);
 }
 
 static bool test_ill_entry(DisasContext *dc, const uint32_t arg[],
@@ -1631,6 +1610,12 @@ static bool test_ill_entry(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static uint32_t test_overflow_entry(DisasContext *dc, const uint32_t arg[],
+                                    const uint32_t par[])
+{
+    return 1 << (dc->callinc * 4);
+}
+
 static void translate_entry(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
@@ -1648,45 +1633,38 @@ static void translate_entry(DisasContext *dc, const uint32_t arg[],
 static void translate_extui(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        int maskimm = (1 << arg[3]) - 1;
+    int maskimm = (1 << arg[3]) - 1;
 
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_shri_i32(tmp, cpu_R[arg[1]], arg[2]);
-        tcg_gen_andi_i32(cpu_R[arg[0]], tmp, maskimm);
-        tcg_temp_free(tmp);
-    }
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_shri_i32(tmp, cpu_R[arg[1]], arg[2]);
+    tcg_gen_andi_i32(cpu_R[arg[0]], tmp, maskimm);
+    tcg_temp_free(tmp);
 }
 
-/* par[0]: check memory access */
 static void translate_icache(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0]) && par[0]) {
 #ifndef CONFIG_USER_ONLY
-        TCGv_i32 addr = tcg_temp_new_i32();
+    TCGv_i32 addr = tcg_temp_new_i32();
 
-        tcg_gen_movi_i32(cpu_pc, dc->pc);
-        tcg_gen_addi_i32(addr, cpu_R[arg[0]], arg[1]);
-        gen_helper_itlb_hit_test(cpu_env, addr);
-        tcg_temp_free(addr);
+    tcg_gen_movi_i32(cpu_pc, dc->pc);
+    tcg_gen_addi_i32(addr, cpu_R[arg[0]], arg[1]);
+    gen_helper_itlb_hit_test(cpu_env, addr);
+    tcg_temp_free(addr);
 #endif
-    }
 }
 
 static void translate_itlb(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
 #ifndef CONFIG_USER_ONLY
-        TCGv_i32 dtlb = tcg_const_i32(par[0]);
+    TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
-        gen_helper_itlb(cpu_env, cpu_R[arg[0]], dtlb);
-        /* This could change memory mapping, so exit tb */
-        gen_jumpi_check_loop_end(dc, -1);
-        tcg_temp_free(dtlb);
+    gen_helper_itlb(cpu_env, cpu_R[arg[0]], dtlb);
+    /* This could change memory mapping, so exit tb */
+    gen_jumpi_check_loop_end(dc, -1);
+    tcg_temp_free(dtlb);
 #endif
-    }
 }
 
 static void translate_j(DisasContext *dc, const uint32_t arg[],
@@ -1698,87 +1676,77 @@ static void translate_j(DisasContext *dc, const uint32_t arg[],
 static void translate_jx(DisasContext *dc, const uint32_t arg[],
                          const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        gen_jump(dc, cpu_R[arg[0]]);
-    }
+    gen_jump(dc, cpu_R[arg[0]]);
 }
 
 static void translate_l32e(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 addr = tcg_temp_new_i32();
+    TCGv_i32 addr = tcg_temp_new_i32();
 
-        tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
-        gen_load_store_alignment(dc, 2, addr, false);
-        tcg_gen_qemu_ld_tl(cpu_R[arg[0]], addr, dc->ring, MO_TEUL);
-        tcg_temp_free(addr);
-    }
+    tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+    gen_load_store_alignment(dc, 2, addr, false);
+    tcg_gen_qemu_ld_tl(cpu_R[arg[0]], addr, dc->ring, MO_TEUL);
+    tcg_temp_free(addr);
 }
 
 static void translate_ldst(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 addr = tcg_temp_new_i32();
+    TCGv_i32 addr = tcg_temp_new_i32();
 
-        tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
-        if (par[0] & MO_SIZE) {
-            gen_load_store_alignment(dc, par[0] & MO_SIZE, addr, par[1]);
+    tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+    if (par[0] & MO_SIZE) {
+        gen_load_store_alignment(dc, par[0] & MO_SIZE, addr, par[1]);
+    }
+    if (par[2]) {
+        if (par[1]) {
+            tcg_gen_mb(TCG_BAR_STRL | TCG_MO_ALL);
         }
-        if (par[2]) {
-            if (par[1]) {
-                tcg_gen_mb(TCG_BAR_STRL | TCG_MO_ALL);
-            }
-            tcg_gen_qemu_st_tl(cpu_R[arg[0]], addr, dc->cring, par[0]);
-        } else {
-            tcg_gen_qemu_ld_tl(cpu_R[arg[0]], addr, dc->cring, par[0]);
-            if (par[1]) {
-                tcg_gen_mb(TCG_BAR_LDAQ | TCG_MO_ALL);
-            }
+        tcg_gen_qemu_st_tl(cpu_R[arg[0]], addr, dc->cring, par[0]);
+    } else {
+        tcg_gen_qemu_ld_tl(cpu_R[arg[0]], addr, dc->cring, par[0]);
+        if (par[1]) {
+            tcg_gen_mb(TCG_BAR_LDAQ | TCG_MO_ALL);
         }
-        tcg_temp_free(addr);
     }
+    tcg_temp_free(addr);
 }
 
 static void translate_l32r(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        TCGv_i32 tmp;
+    TCGv_i32 tmp;
 
-        if (dc->base.tb->flags & XTENSA_TBFLAG_LITBASE) {
-            tmp = tcg_const_i32(dc->raw_arg[1] - 1);
-            tcg_gen_add_i32(tmp, cpu_SR[LITBASE], tmp);
-        } else {
-            tmp = tcg_const_i32(arg[1]);
-        }
-        tcg_gen_qemu_ld32u(cpu_R[arg[0]], tmp, dc->cring);
-        tcg_temp_free(tmp);
+    if (dc->base.tb->flags & XTENSA_TBFLAG_LITBASE) {
+        tmp = tcg_const_i32(dc->raw_arg[1] - 1);
+        tcg_gen_add_i32(tmp, cpu_SR[LITBASE], tmp);
+    } else {
+        tmp = tcg_const_i32(arg[1]);
     }
+    tcg_gen_qemu_ld32u(cpu_R[arg[0]], tmp, dc->cring);
+    tcg_temp_free(tmp);
 }
 
 static void translate_loop(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        uint32_t lend = arg[1];
-        TCGv_i32 tmp = tcg_const_i32(lend);
-
-        tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_R[arg[0]], 1);
-        tcg_gen_movi_i32(cpu_SR[LBEG], dc->base.pc_next);
-        gen_helper_wsr_lend(cpu_env, tmp);
-        tcg_temp_free(tmp);
+    uint32_t lend = arg[1];
+    TCGv_i32 tmp = tcg_const_i32(lend);
 
-        if (par[0] != TCG_COND_NEVER) {
-            TCGLabel *label = gen_new_label();
-            tcg_gen_brcondi_i32(par[0], cpu_R[arg[0]], 0, label);
-            gen_jumpi(dc, lend, 1);
-            gen_set_label(label);
-        }
+    tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_R[arg[0]], 1);
+    tcg_gen_movi_i32(cpu_SR[LBEG], dc->base.pc_next);
+    gen_helper_wsr_lend(cpu_env, tmp);
+    tcg_temp_free(tmp);
 
-        gen_jumpi(dc, dc->base.pc_next, 0);
+    if (par[0] != TCG_COND_NEVER) {
+        TCGLabel *label = gen_new_label();
+        tcg_gen_brcondi_i32(par[0], cpu_R[arg[0]], 0, label);
+        gen_jumpi(dc, lend, 1);
+        gen_set_label(label);
     }
+
+    gen_jumpi(dc, dc->base.pc_next, 0);
 }
 
 enum {
@@ -1818,78 +1786,60 @@ static void translate_mac16(DisasContext *dc, const uint32_t arg[],
     unsigned half = par[2];
     uint32_t ld_offset = par[3];
     unsigned off = ld_offset ? 2 : 0;
-    uint32_t ar[3] = {0};
-    unsigned n_ar = 0;
-
-    if (op != MAC16_NONE) {
-        if (!is_m1_sr) {
-            ar[n_ar++] = arg[off];
-        }
-        if (!is_m2_sr) {
-            ar[n_ar++] = arg[off + 1];
-        }
-    }
+    TCGv_i32 vaddr = tcg_temp_new_i32();
+    TCGv_i32 mem32 = tcg_temp_new_i32();
 
     if (ld_offset) {
-        ar[n_ar++] = arg[1];
+        tcg_gen_addi_i32(vaddr, cpu_R[arg[1]], ld_offset);
+        gen_load_store_alignment(dc, 2, vaddr, false);
+        tcg_gen_qemu_ld32u(mem32, vaddr, dc->cring);
     }
-
-    if (gen_window_check3(dc, ar[0], ar[1], ar[2])) {
-        TCGv_i32 vaddr = tcg_temp_new_i32();
-        TCGv_i32 mem32 = tcg_temp_new_i32();
-
-        if (ld_offset) {
-            tcg_gen_addi_i32(vaddr, cpu_R[arg[1]], ld_offset);
-            gen_load_store_alignment(dc, 2, vaddr, false);
-            tcg_gen_qemu_ld32u(mem32, vaddr, dc->cring);
-        }
-        if (op != MAC16_NONE) {
-            TCGv_i32 m1 = gen_mac16_m(is_m1_sr ?
-                                      cpu_SR[MR + arg[off]] :
-                                      cpu_R[arg[off]],
-                                      half & MAC16_HX, op == MAC16_UMUL);
-            TCGv_i32 m2 = gen_mac16_m(is_m2_sr ?
-                                      cpu_SR[MR + arg[off + 1]] :
-                                      cpu_R[arg[off + 1]],
-                                      half & MAC16_XH, op == MAC16_UMUL);
-
-            if (op == MAC16_MUL || op == MAC16_UMUL) {
-                tcg_gen_mul_i32(cpu_SR[ACCLO], m1, m2);
-                if (op == MAC16_UMUL) {
-                    tcg_gen_movi_i32(cpu_SR[ACCHI], 0);
-                } else {
-                    tcg_gen_sari_i32(cpu_SR[ACCHI], cpu_SR[ACCLO], 31);
-                }
+    if (op != MAC16_NONE) {
+        TCGv_i32 m1 = gen_mac16_m(is_m1_sr ?
+                                  cpu_SR[MR + arg[off]] :
+                                  cpu_R[arg[off]],
+                                  half & MAC16_HX, op == MAC16_UMUL);
+        TCGv_i32 m2 = gen_mac16_m(is_m2_sr ?
+                                  cpu_SR[MR + arg[off + 1]] :
+                                  cpu_R[arg[off + 1]],
+                                  half & MAC16_XH, op == MAC16_UMUL);
+
+        if (op == MAC16_MUL || op == MAC16_UMUL) {
+            tcg_gen_mul_i32(cpu_SR[ACCLO], m1, m2);
+            if (op == MAC16_UMUL) {
+                tcg_gen_movi_i32(cpu_SR[ACCHI], 0);
             } else {
-                TCGv_i32 lo = tcg_temp_new_i32();
-                TCGv_i32 hi = tcg_temp_new_i32();
-
-                tcg_gen_mul_i32(lo, m1, m2);
-                tcg_gen_sari_i32(hi, lo, 31);
-                if (op == MAC16_MULA) {
-                    tcg_gen_add2_i32(cpu_SR[ACCLO], cpu_SR[ACCHI],
-                                     cpu_SR[ACCLO], cpu_SR[ACCHI],
-                                     lo, hi);
-                } else {
-                    tcg_gen_sub2_i32(cpu_SR[ACCLO], cpu_SR[ACCHI],
-                                     cpu_SR[ACCLO], cpu_SR[ACCHI],
-                                     lo, hi);
-                }
-                tcg_gen_ext8s_i32(cpu_SR[ACCHI], cpu_SR[ACCHI]);
-
-                tcg_temp_free_i32(lo);
-                tcg_temp_free_i32(hi);
+                tcg_gen_sari_i32(cpu_SR[ACCHI], cpu_SR[ACCLO], 31);
             }
-            tcg_temp_free(m1);
-            tcg_temp_free(m2);
-        }
-        if (ld_offset) {
-            tcg_gen_mov_i32(cpu_R[arg[1]], vaddr);
-            tcg_gen_mov_i32(cpu_SR[MR + arg[0]], mem32);
+        } else {
+            TCGv_i32 lo = tcg_temp_new_i32();
+            TCGv_i32 hi = tcg_temp_new_i32();
+
+            tcg_gen_mul_i32(lo, m1, m2);
+            tcg_gen_sari_i32(hi, lo, 31);
+            if (op == MAC16_MULA) {
+                tcg_gen_add2_i32(cpu_SR[ACCLO], cpu_SR[ACCHI],
+                                 cpu_SR[ACCLO], cpu_SR[ACCHI],
+                                 lo, hi);
+            } else {
+                tcg_gen_sub2_i32(cpu_SR[ACCLO], cpu_SR[ACCHI],
+                                 cpu_SR[ACCLO], cpu_SR[ACCHI],
+                                 lo, hi);
+            }
+            tcg_gen_ext8s_i32(cpu_SR[ACCHI], cpu_SR[ACCHI]);
+
+            tcg_temp_free_i32(lo);
+            tcg_temp_free_i32(hi);
         }
-        tcg_temp_free(vaddr);
-        tcg_temp_free(mem32);
+        tcg_temp_free(m1);
+        tcg_temp_free(m2);
+    }
+    if (ld_offset) {
+        tcg_gen_mov_i32(cpu_R[arg[1]], vaddr);
+        tcg_gen_mov_i32(cpu_SR[MR + arg[0]], mem32);
     }
+    tcg_temp_free(vaddr);
+    tcg_temp_free(mem32);
 }
 
 static void translate_memw(DisasContext *dc, const uint32_t arg[],
@@ -1901,139 +1851,113 @@ static void translate_memw(DisasContext *dc, const uint32_t arg[],
 static void translate_smin(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_smin_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_smin_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_umin(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_umin_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_umin_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_smax(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_smax_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_smax_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_umax(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_umax_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_umax_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_mov(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        tcg_gen_mov_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
-    }
+    tcg_gen_mov_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
 }
 
 static void translate_movcond(DisasContext *dc, const uint32_t arg[],
                               const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 zero = tcg_const_i32(0);
 
-        tcg_gen_movcond_i32(par[0], cpu_R[arg[0]],
-                            cpu_R[arg[2]], zero, cpu_R[arg[1]], cpu_R[arg[0]]);
-        tcg_temp_free(zero);
-    }
+    tcg_gen_movcond_i32(par[0], cpu_R[arg[0]],
+                        cpu_R[arg[2]], zero, cpu_R[arg[1]], cpu_R[arg[0]]);
+    tcg_temp_free(zero);
 }
 
 static void translate_movi(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        tcg_gen_movi_i32(cpu_R[arg[0]], arg[1]);
-    }
+    tcg_gen_movi_i32(cpu_R[arg[0]], arg[1]);
 }
 
 static void translate_movp(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 zero = tcg_const_i32(0);
-        TCGv_i32 tmp = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-        tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2]);
-        tcg_gen_movcond_i32(par[0],
-                            cpu_R[arg[0]], tmp, zero,
-                            cpu_R[arg[1]], cpu_R[arg[0]]);
-        tcg_temp_free(tmp);
-        tcg_temp_free(zero);
-    }
+    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2]);
+    tcg_gen_movcond_i32(par[0],
+                        cpu_R[arg[0]], tmp, zero,
+                        cpu_R[arg[1]], cpu_R[arg[0]]);
+    tcg_temp_free(tmp);
+    tcg_temp_free(zero);
 }
 
 static void translate_movsp(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 pc = tcg_const_i32(dc->pc);
-        gen_helper_movsp(cpu_env, pc);
-        tcg_gen_mov_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
-        tcg_temp_free(pc);
-    }
+    TCGv_i32 pc = tcg_const_i32(dc->pc);
+    gen_helper_movsp(cpu_env, pc);
+    tcg_gen_mov_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+    tcg_temp_free(pc);
 }
 
 static void translate_mul16(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        TCGv_i32 v1 = tcg_temp_new_i32();
-        TCGv_i32 v2 = tcg_temp_new_i32();
+    TCGv_i32 v1 = tcg_temp_new_i32();
+    TCGv_i32 v2 = tcg_temp_new_i32();
 
-        if (par[0]) {
-            tcg_gen_ext16s_i32(v1, cpu_R[arg[1]]);
-            tcg_gen_ext16s_i32(v2, cpu_R[arg[2]]);
-        } else {
-            tcg_gen_ext16u_i32(v1, cpu_R[arg[1]]);
-            tcg_gen_ext16u_i32(v2, cpu_R[arg[2]]);
-        }
-        tcg_gen_mul_i32(cpu_R[arg[0]], v1, v2);
-        tcg_temp_free(v2);
-        tcg_temp_free(v1);
+    if (par[0]) {
+        tcg_gen_ext16s_i32(v1, cpu_R[arg[1]]);
+        tcg_gen_ext16s_i32(v2, cpu_R[arg[2]]);
+    } else {
+        tcg_gen_ext16u_i32(v1, cpu_R[arg[1]]);
+        tcg_gen_ext16u_i32(v2, cpu_R[arg[2]]);
     }
+    tcg_gen_mul_i32(cpu_R[arg[0]], v1, v2);
+    tcg_temp_free(v2);
+    tcg_temp_free(v1);
 }
 
 static void translate_mull(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_mul_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_mul_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_mulh(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        TCGv_i32 lo = tcg_temp_new();
+    TCGv_i32 lo = tcg_temp_new();
 
-        if (par[0]) {
-            tcg_gen_muls2_i32(lo, cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-        } else {
-            tcg_gen_mulu2_i32(lo, cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-        }
-        tcg_temp_free(lo);
+    if (par[0]) {
+        tcg_gen_muls2_i32(lo, cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    } else {
+        tcg_gen_mulu2_i32(lo, cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
     }
+    tcg_temp_free(lo);
 }
 
 static void translate_neg(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        tcg_gen_neg_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
-    }
+    tcg_gen_neg_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
 }
 
 static void translate_nop(DisasContext *dc, const uint32_t arg[],
@@ -2044,39 +1968,31 @@ static void translate_nop(DisasContext *dc, const uint32_t arg[],
 static void translate_nsa(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        tcg_gen_clrsb_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
-    }
+    tcg_gen_clrsb_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
 }
 
 static void translate_nsau(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        tcg_gen_clzi_i32(cpu_R[arg[0]], cpu_R[arg[1]], 32);
-    }
+    tcg_gen_clzi_i32(cpu_R[arg[0]], cpu_R[arg[1]], 32);
 }
 
 static void translate_or(DisasContext *dc, const uint32_t arg[],
                          const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_or_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_or_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_ptlb(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
 #ifndef CONFIG_USER_ONLY
-        TCGv_i32 dtlb = tcg_const_i32(par[0]);
+    TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
-        tcg_gen_movi_i32(cpu_pc, dc->pc);
-        gen_helper_ptlb(cpu_R[arg[0]], cpu_env, cpu_R[arg[1]], dtlb);
-        tcg_temp_free(dtlb);
+    tcg_gen_movi_i32(cpu_pc, dc->pc);
+    gen_helper_ptlb(cpu_R[arg[0]], cpu_env, cpu_R[arg[1]], dtlb);
+    tcg_temp_free(dtlb);
 #endif
-    }
 }
 
 static void gen_zero_check(DisasContext *dc, const uint32_t arg[])
@@ -2091,61 +2007,53 @@ static void gen_zero_check(DisasContext *dc, const uint32_t arg[])
 static void translate_quos(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        TCGLabel *label1 = gen_new_label();
-        TCGLabel *label2 = gen_new_label();
+    TCGLabel *label1 = gen_new_label();
+    TCGLabel *label2 = gen_new_label();
 
-        gen_zero_check(dc, arg);
+    gen_zero_check(dc, arg);
 
-        tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[1]], 0x80000000,
-                            label1);
-        tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[2]], 0xffffffff,
-                            label1);
-        tcg_gen_movi_i32(cpu_R[arg[0]],
-                         par[0] ? 0x80000000 : 0);
-        tcg_gen_br(label2);
-        gen_set_label(label1);
-        if (par[0]) {
-            tcg_gen_div_i32(cpu_R[arg[0]],
-                            cpu_R[arg[1]], cpu_R[arg[2]]);
-        } else {
-            tcg_gen_rem_i32(cpu_R[arg[0]],
-                            cpu_R[arg[1]], cpu_R[arg[2]]);
-        }
-        gen_set_label(label2);
+    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[1]], 0x80000000,
+                        label1);
+    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[2]], 0xffffffff,
+                        label1);
+    tcg_gen_movi_i32(cpu_R[arg[0]],
+                     par[0] ? 0x80000000 : 0);
+    tcg_gen_br(label2);
+    gen_set_label(label1);
+    if (par[0]) {
+        tcg_gen_div_i32(cpu_R[arg[0]],
+                        cpu_R[arg[1]], cpu_R[arg[2]]);
+    } else {
+        tcg_gen_rem_i32(cpu_R[arg[0]],
+                        cpu_R[arg[1]], cpu_R[arg[2]]);
     }
+    gen_set_label(label2);
 }
 
 static void translate_quou(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        gen_zero_check(dc, arg);
-        if (par[0]) {
-            tcg_gen_divu_i32(cpu_R[arg[0]],
-                             cpu_R[arg[1]], cpu_R[arg[2]]);
-        } else {
-            tcg_gen_remu_i32(cpu_R[arg[0]],
-                             cpu_R[arg[1]], cpu_R[arg[2]]);
-        }
+    gen_zero_check(dc, arg);
+    if (par[0]) {
+        tcg_gen_divu_i32(cpu_R[arg[0]],
+                         cpu_R[arg[1]], cpu_R[arg[2]]);
+    } else {
+        tcg_gen_remu_i32(cpu_R[arg[0]],
+                         cpu_R[arg[1]], cpu_R[arg[2]]);
     }
 }
 
 static void translate_read_impwire(DisasContext *dc, const uint32_t arg[],
                                    const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        /* TODO: GPIO32 may be a part of coprocessor */
-        tcg_gen_movi_i32(cpu_R[arg[0]], 0);
-    }
+    /* TODO: GPIO32 may be a part of coprocessor */
+    tcg_gen_movi_i32(cpu_R[arg[0]], 0);
 }
 
 static void translate_rer(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        gen_helper_rer(cpu_R[arg[0]], cpu_env, cpu_R[arg[1]]);
-    }
+    gen_helper_rer(cpu_R[arg[0]], cpu_env, cpu_R[arg[1]]);
 }
 
 static void translate_ret(DisasContext *dc, const uint32_t arg[],
@@ -2237,13 +2145,11 @@ static void translate_rotw(DisasContext *dc, const uint32_t arg[],
 static void translate_rsil(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        tcg_gen_mov_i32(cpu_R[arg[0]], cpu_SR[PS]);
-        tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_INTLEVEL);
-        tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], arg[1]);
-        gen_check_interrupts(dc);
-        gen_jumpi_check_loop_end(dc, 0);
-    }
+    tcg_gen_mov_i32(cpu_R[arg[0]], cpu_SR[PS]);
+    tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_INTLEVEL);
+    tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], arg[1]);
+    gen_check_interrupts(dc);
+    gen_jumpi_check_loop_end(dc, 0);
 }
 
 static bool test_ill_rsr(DisasContext *dc, const uint32_t arg[],
@@ -2255,10 +2161,8 @@ static bool test_ill_rsr(DisasContext *dc, const uint32_t arg[],
 static void translate_rsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        if (gen_rsr(dc, cpu_R[arg[0]], par[0])) {
-            gen_jumpi_check_loop_end(dc, 0);
-        }
+    if (gen_rsr(dc, cpu_R[arg[0]], par[0])) {
+        gen_jumpi_check_loop_end(dc, 0);
     }
 }
 
@@ -2271,25 +2175,20 @@ static void translate_rtlb(DisasContext *dc, const uint32_t arg[],
         gen_helper_rtlb0,
         gen_helper_rtlb1,
     };
+    TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 dtlb = tcg_const_i32(par[0]);
-
-        helper[par[1]](cpu_R[arg[0]], cpu_env, cpu_R[arg[1]], dtlb);
-        tcg_temp_free(dtlb);
-    }
+    helper[par[1]](cpu_R[arg[0]], cpu_env, cpu_R[arg[1]], dtlb);
+    tcg_temp_free(dtlb);
 #endif
 }
 
 static void translate_rur(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        if (uregnames[par[0]].name) {
-            tcg_gen_mov_i32(cpu_R[arg[0]], cpu_UR[par[0]]);
-        } else {
-            qemu_log_mask(LOG_UNIMP, "RUR %d not implemented\n", par[0]);
-        }
+    if (uregnames[par[0]].name) {
+        tcg_gen_mov_i32(cpu_R[arg[0]], cpu_UR[par[0]]);
+    } else {
+        qemu_log_mask(LOG_UNIMP, "RUR %d not implemented\n", par[0]);
     }
 }
 
@@ -2317,60 +2216,52 @@ static void gen_check_atomctl(DisasContext *dc, TCGv_i32 addr)
 static void translate_s32c1i(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 tmp = tcg_temp_local_new_i32();
-        TCGv_i32 addr = tcg_temp_local_new_i32();
+    TCGv_i32 tmp = tcg_temp_local_new_i32();
+    TCGv_i32 addr = tcg_temp_local_new_i32();
 
-        tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
-        tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
-        gen_load_store_alignment(dc, 2, addr, true);
-        gen_check_atomctl(dc, addr);
-        tcg_gen_atomic_cmpxchg_i32(cpu_R[arg[0]], addr, cpu_SR[SCOMPARE1],
-                                   tmp, dc->cring, MO_32);
-        tcg_temp_free(addr);
-        tcg_temp_free(tmp);
-    }
+    tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
+    tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+    gen_load_store_alignment(dc, 2, addr, true);
+    gen_check_atomctl(dc, addr);
+    tcg_gen_atomic_cmpxchg_i32(cpu_R[arg[0]], addr, cpu_SR[SCOMPARE1],
+                               tmp, dc->cring, MO_32);
+    tcg_temp_free(addr);
+    tcg_temp_free(tmp);
 }
 
 static void translate_s32e(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGv_i32 addr = tcg_temp_new_i32();
+    TCGv_i32 addr = tcg_temp_new_i32();
 
-        tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
-        gen_load_store_alignment(dc, 2, addr, false);
-        tcg_gen_qemu_st_tl(cpu_R[arg[0]], addr, dc->ring, MO_TEUL);
-        tcg_temp_free(addr);
-    }
+    tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+    gen_load_store_alignment(dc, 2, addr, false);
+    tcg_gen_qemu_st_tl(cpu_R[arg[0]], addr, dc->ring, MO_TEUL);
+    tcg_temp_free(addr);
 }
 
 static void translate_salt(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_setcond_i32(par[0],
-                            cpu_R[arg[0]],
-                            cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_setcond_i32(par[0],
+                        cpu_R[arg[0]],
+                        cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_sext(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        int shift = 31 - arg[2];
+    int shift = 31 - arg[2];
 
-        if (shift == 24) {
-            tcg_gen_ext8s_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
-        } else if (shift == 16) {
-            tcg_gen_ext16s_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
-        } else {
-            TCGv_i32 tmp = tcg_temp_new_i32();
-            tcg_gen_shli_i32(tmp, cpu_R[arg[1]], shift);
-            tcg_gen_sari_i32(cpu_R[arg[0]], tmp, shift);
-            tcg_temp_free(tmp);
-        }
+    if (shift == 24) {
+        tcg_gen_ext8s_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+    } else if (shift == 16) {
+        tcg_gen_ext16s_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
+    } else {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        tcg_gen_shli_i32(tmp, cpu_R[arg[1]], shift);
+        tcg_gen_sari_i32(cpu_R[arg[0]], tmp, shift);
+        tcg_temp_free(tmp);
     }
 }
 
@@ -2414,76 +2305,64 @@ static void translate_simcall(DisasContext *dc, const uint32_t arg[],
 static void translate_sll(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        if (dc->sar_m32_5bit) {
-            tcg_gen_shl_i32(cpu_R[arg[0]], cpu_R[arg[1]], dc->sar_m32);
-        } else {
-            TCGv_i64 v = tcg_temp_new_i64();
-            TCGv_i32 s = tcg_const_i32(32);
-            tcg_gen_sub_i32(s, s, cpu_SR[SAR]);
-            tcg_gen_andi_i32(s, s, 0x3f);
-            tcg_gen_extu_i32_i64(v, cpu_R[arg[1]]);
-            gen_shift_reg(shl, s);
-            tcg_temp_free(s);
-        }
+    if (dc->sar_m32_5bit) {
+        tcg_gen_shl_i32(cpu_R[arg[0]], cpu_R[arg[1]], dc->sar_m32);
+    } else {
+        TCGv_i64 v = tcg_temp_new_i64();
+        TCGv_i32 s = tcg_const_i32(32);
+        tcg_gen_sub_i32(s, s, cpu_SR[SAR]);
+        tcg_gen_andi_i32(s, s, 0x3f);
+        tcg_gen_extu_i32_i64(v, cpu_R[arg[1]]);
+        gen_shift_reg(shl, s);
+        tcg_temp_free(s);
     }
 }
 
 static void translate_slli(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        if (arg[2] == 32) {
-            qemu_log_mask(LOG_GUEST_ERROR, "slli a%d, a%d, 32 is undefined\n",
-                          arg[0], arg[1]);
-        }
-        tcg_gen_shli_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2] & 0x1f);
+    if (arg[2] == 32) {
+        qemu_log_mask(LOG_GUEST_ERROR, "slli a%d, a%d, 32 is undefined\n",
+                      arg[0], arg[1]);
     }
+    tcg_gen_shli_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2] & 0x1f);
 }
 
 static void translate_sra(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        if (dc->sar_m32_5bit) {
-            tcg_gen_sar_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_SR[SAR]);
-        } else {
-            TCGv_i64 v = tcg_temp_new_i64();
-            tcg_gen_ext_i32_i64(v, cpu_R[arg[1]]);
-            gen_shift(sar);
-        }
+    if (dc->sar_m32_5bit) {
+        tcg_gen_sar_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_SR[SAR]);
+    } else {
+        TCGv_i64 v = tcg_temp_new_i64();
+        tcg_gen_ext_i32_i64(v, cpu_R[arg[1]]);
+        gen_shift(sar);
     }
 }
 
 static void translate_srai(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        tcg_gen_sari_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
-    }
+    tcg_gen_sari_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
 }
 
 static void translate_src(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        TCGv_i64 v = tcg_temp_new_i64();
-        tcg_gen_concat_i32_i64(v, cpu_R[arg[2]], cpu_R[arg[1]]);
-        gen_shift(shr);
-    }
+    TCGv_i64 v = tcg_temp_new_i64();
+    tcg_gen_concat_i32_i64(v, cpu_R[arg[2]], cpu_R[arg[1]]);
+    gen_shift(shr);
 }
 
 static void translate_srl(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        if (dc->sar_m32_5bit) {
-            tcg_gen_shr_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_SR[SAR]);
-        } else {
-            TCGv_i64 v = tcg_temp_new_i64();
-            tcg_gen_extu_i32_i64(v, cpu_R[arg[1]]);
-            gen_shift(shr);
-        }
+    if (dc->sar_m32_5bit) {
+        tcg_gen_shr_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_SR[SAR]);
+    } else {
+        TCGv_i64 v = tcg_temp_new_i64();
+        tcg_gen_extu_i32_i64(v, cpu_R[arg[1]]);
+        gen_shift(shr);
     }
 }
 
@@ -2493,31 +2372,25 @@ static void translate_srl(DisasContext *dc, const uint32_t arg[],
 static void translate_srli(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        tcg_gen_shri_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
-    }
+    tcg_gen_shri_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2]);
 }
 
 static void translate_ssa8b(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_shli_i32(tmp, cpu_R[arg[0]], 3);
-        gen_left_shift_sar(dc, tmp);
-        tcg_temp_free(tmp);
-    }
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_shli_i32(tmp, cpu_R[arg[0]], 3);
+    gen_left_shift_sar(dc, tmp);
+    tcg_temp_free(tmp);
 }
 
 static void translate_ssa8l(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_shli_i32(tmp, cpu_R[arg[0]], 3);
-        gen_right_shift_sar(dc, tmp);
-        tcg_temp_free(tmp);
-    }
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_shli_i32(tmp, cpu_R[arg[0]], 3);
+    gen_right_shift_sar(dc, tmp);
+    tcg_temp_free(tmp);
 }
 
 static void translate_ssai(DisasContext *dc, const uint32_t arg[],
@@ -2531,36 +2404,28 @@ static void translate_ssai(DisasContext *dc, const uint32_t arg[],
 static void translate_ssl(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        gen_left_shift_sar(dc, cpu_R[arg[0]]);
-    }
+    gen_left_shift_sar(dc, cpu_R[arg[0]]);
 }
 
 static void translate_ssr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        gen_right_shift_sar(dc, cpu_R[arg[0]]);
-    }
+    gen_right_shift_sar(dc, cpu_R[arg[0]]);
 }
 
 static void translate_sub(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_sub_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_sub_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_subx(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_shli_i32(tmp, cpu_R[arg[1]], par[0]);
-        tcg_gen_sub_i32(cpu_R[arg[0]], tmp, cpu_R[arg[2]]);
-        tcg_temp_free(tmp);
-    }
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_shli_i32(tmp, cpu_R[arg[1]], par[0]);
+    tcg_gen_sub_i32(cpu_R[arg[0]], tmp, cpu_R[arg[2]]);
+    tcg_temp_free(tmp);
 }
 
 static void translate_waiti(DisasContext *dc, const uint32_t arg[],
@@ -2574,33 +2439,27 @@ static void translate_waiti(DisasContext *dc, const uint32_t arg[],
 static void translate_wtlb(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
 #ifndef CONFIG_USER_ONLY
-        TCGv_i32 dtlb = tcg_const_i32(par[0]);
+    TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
-        gen_helper_wtlb(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]], dtlb);
-        /* This could change memory mapping, so exit tb */
-        gen_jumpi_check_loop_end(dc, -1);
-        tcg_temp_free(dtlb);
+    gen_helper_wtlb(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]], dtlb);
+    /* This could change memory mapping, so exit tb */
+    gen_jumpi_check_loop_end(dc, -1);
+    tcg_temp_free(dtlb);
 #endif
-    }
 }
 
 static void translate_wer(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        gen_helper_wer(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]]);
-    }
+    gen_helper_wer(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]]);
 }
 
 static void translate_wrmsk_expstate(DisasContext *dc, const uint32_t arg[],
                                      const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[0], arg[1])) {
-        /* TODO: GPIO32 may be a part of coprocessor */
-        tcg_gen_and_i32(cpu_UR[EXPSTATE], cpu_R[arg[0]], cpu_R[arg[1]]);
-    }
+    /* TODO: GPIO32 may be a part of coprocessor */
+    tcg_gen_and_i32(cpu_UR[EXPSTATE], cpu_R[arg[0]], cpu_R[arg[1]]);
 }
 
 static bool test_ill_wsr(DisasContext *dc, const uint32_t arg[],
@@ -2612,29 +2471,23 @@ static bool test_ill_wsr(DisasContext *dc, const uint32_t arg[],
 static void translate_wsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        gen_wsr(dc, par[0], cpu_R[arg[0]]);
-    }
+    gen_wsr(dc, par[0], cpu_R[arg[0]]);
 }
 
 static void translate_wur(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        if (uregnames[par[0]].name) {
-            gen_wur(par[0], cpu_R[arg[0]]);
-        } else {
-            qemu_log_mask(LOG_UNIMP, "WUR %d not implemented\n", par[0]);
-        }
+    if (uregnames[par[0]].name) {
+        gen_wur(par[0], cpu_R[arg[0]]);
+    } else {
+        qemu_log_mask(LOG_UNIMP, "WUR %d not implemented\n", par[0]);
     }
 }
 
 static void translate_xor(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_xor_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_xor_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static bool test_ill_xsr(DisasContext *dc, const uint32_t arg[],
@@ -2646,17 +2499,15 @@ static bool test_ill_xsr(DisasContext *dc, const uint32_t arg[],
 static void translate_xsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0])) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        bool rsr_end, wsr_end;
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    bool rsr_end, wsr_end;
 
-        tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
-        rsr_end = gen_rsr(dc, cpu_R[arg[0]], par[0]);
-        wsr_end = gen_wsr(dc, par[0], tmp);
-        tcg_temp_free(tmp);
-        if (rsr_end && !wsr_end) {
-            gen_jumpi_check_loop_end(dc, 0);
-        }
+    tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
+    rsr_end = gen_rsr(dc, cpu_R[arg[0]], par[0]);
+    wsr_end = gen_wsr(dc, par[0], tmp);
+    tcg_temp_free(tmp);
+    if (rsr_end && !wsr_end) {
+        gen_jumpi_check_loop_end(dc, 0);
     }
 }
 
@@ -2664,33 +2515,42 @@ static const XtensaOpcodeOps core_ops[] = {
     {
         .name = "abs",
         .translate = translate_abs,
+        .windowed_register_op = 0x3,
     }, {
         .name = "add",
         .translate = translate_add,
+        .windowed_register_op = 0x7,
     }, {
         .name = "add.n",
         .translate = translate_add,
+        .windowed_register_op = 0x7,
     }, {
         .name = "addi",
         .translate = translate_addi,
+        .windowed_register_op = 0x3,
     }, {
         .name = "addi.n",
         .translate = translate_addi,
+        .windowed_register_op = 0x3,
     }, {
         .name = "addmi",
         .translate = translate_addi,
+        .windowed_register_op = 0x3,
     }, {
         .name = "addx2",
         .translate = translate_addx,
         .par = (const uint32_t[]){1},
+        .windowed_register_op = 0x7,
     }, {
         .name = "addx4",
         .translate = translate_addx,
         .par = (const uint32_t[]){2},
+        .windowed_register_op = 0x7,
     }, {
         .name = "addx8",
         .translate = translate_addx,
         .par = (const uint32_t[]){3},
+        .windowed_register_op = 0x7,
     }, {
         .name = "all4",
         .translate = translate_all,
@@ -2702,6 +2562,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "and",
         .translate = translate_and,
+        .windowed_register_op = 0x7,
     }, {
         .name = "andb",
         .translate = translate_boolean,
@@ -2722,42 +2583,52 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "ball",
         .translate = translate_ball,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x3,
     }, {
         .name = "bany",
         .translate = translate_bany,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x3,
     }, {
         .name = "bbc",
         .translate = translate_bb,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x3,
     }, {
         .name = "bbci",
         .translate = translate_bbi,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x1,
     }, {
         .name = "bbs",
         .translate = translate_bb,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x3,
     }, {
         .name = "bbsi",
         .translate = translate_bbi,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "beq",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x3,
     }, {
         .name = "beqi",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x1,
     }, {
         .name = "beqz",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x1,
     }, {
         .name = "beqz.n",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x1,
     }, {
         .name = "bf",
         .translate = translate_bp,
@@ -2766,66 +2637,82 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "bge",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_GE},
+        .windowed_register_op = 0x3,
     }, {
         .name = "bgei",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_GE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "bgeu",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_GEU},
+        .windowed_register_op = 0x3,
     }, {
         .name = "bgeui",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_GEU},
+        .windowed_register_op = 0x1,
     }, {
         .name = "bgez",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_GE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "blt",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_LT},
+        .windowed_register_op = 0x3,
     }, {
         .name = "blti",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_LT},
+        .windowed_register_op = 0x1,
     }, {
         .name = "bltu",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_LTU},
+        .windowed_register_op = 0x3,
     }, {
         .name = "bltui",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_LTU},
+        .windowed_register_op = 0x1,
     }, {
         .name = "bltz",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_LT},
+        .windowed_register_op = 0x1,
     }, {
         .name = "bnall",
         .translate = translate_ball,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x3,
     }, {
         .name = "bne",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x3,
     }, {
         .name = "bnei",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "bnez",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "bnez.n",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "bnone",
         .translate = translate_bany,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x3,
     }, {
         .name = "break",
         .translate = translate_nop,
@@ -2846,101 +2733,114 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "call12",
         .translate = translate_callw,
+        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){3},
     }, {
         .name = "call4",
         .translate = translate_callw,
+        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){1},
     }, {
         .name = "call8",
         .translate = translate_callw,
+        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){2},
     }, {
         .name = "callx0",
         .translate = translate_callx0,
+        .windowed_register_op = 0x1,
     }, {
         .name = "callx12",
         .translate = translate_callxw,
+        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){3},
+        .windowed_register_op = 0x1,
     }, {
         .name = "callx4",
         .translate = translate_callxw,
+        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){1},
+        .windowed_register_op = 0x1,
     }, {
         .name = "callx8",
         .translate = translate_callxw,
+        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){2},
+        .windowed_register_op = 0x1,
     }, {
         .name = "clamps",
         .translate = translate_clamps,
+        .windowed_register_op = 0x3,
     }, {
         .name = "clrb_expstate",
         .translate = translate_clrb_expstate,
     }, {
         .name = "const16",
         .translate = translate_const16,
+        .windowed_register_op = 0x1,
     }, {
         .name = "depbits",
         .translate = translate_depbits,
+        .windowed_register_op = 0x3,
     }, {
         .name = "dhi",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "dhu",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "dhwb",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true},
+        .windowed_register_op = 0x1,
     }, {
         .name = "dhwbi",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true},
+        .windowed_register_op = 0x1,
     }, {
         .name = "dii",
-        .translate = translate_dcache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "diu",
-        .translate = translate_dcache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "diwb",
-        .translate = translate_dcache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "diwbi",
-        .translate = translate_dcache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "dpfl",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "dpfr",
-        .translate = translate_dcache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
+        .windowed_register_op = 0x1,
     }, {
         .name = "dpfro",
-        .translate = translate_dcache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
+        .windowed_register_op = 0x1,
     }, {
         .name = "dpfw",
-        .translate = translate_dcache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
+        .windowed_register_op = 0x1,
     }, {
         .name = "dpfwo",
-        .translate = translate_dcache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
+        .windowed_register_op = 0x1,
     }, {
         .name = "dsync",
         .translate = translate_nop,
@@ -2948,6 +2848,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "entry",
         .translate = translate_entry,
         .test_ill = test_ill_entry,
+        .test_overflow = test_overflow_entry,
     }, {
         .name = "esync",
         .translate = translate_nop,
@@ -2957,6 +2858,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "extui",
         .translate = translate_extui,
+        .windowed_register_op = 0x3,
     }, {
         .name = "extw",
         .translate = translate_memw,
@@ -2971,30 +2873,32 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_itlb,
         .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "ihi",
         .translate = translate_icache,
-        .par = (const uint32_t[]){true},
+        .windowed_register_op = 0x1,
     }, {
         .name = "ihu",
         .translate = translate_icache,
-        .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "iii",
-        .translate = translate_icache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "iitlb",
         .translate = translate_itlb,
         .par = (const uint32_t[]){false},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "iiu",
-        .translate = translate_icache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "ill",
         .op_flags = XTENSA_OP_ILL,
@@ -3003,13 +2907,13 @@ static const XtensaOpcodeOps core_ops[] = {
         .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "ipf",
-        .translate = translate_icache,
-        .par = (const uint32_t[]){false},
+        .translate = translate_nop,
+        .windowed_register_op = 0x1,
     }, {
         .name = "ipfl",
         .translate = translate_icache,
-        .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "isync",
         .translate = translate_nop,
@@ -3019,45 +2923,56 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "jx",
         .translate = translate_jx,
+        .windowed_register_op = 0x1,
     }, {
         .name = "l16si",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TESW, false, false},
+        .windowed_register_op = 0x3,
     }, {
         .name = "l16ui",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUW, false, false},
+        .windowed_register_op = 0x3,
     }, {
         .name = "l32ai",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, true, false},
+        .windowed_register_op = 0x3,
     }, {
         .name = "l32e",
         .translate = translate_l32e,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "l32i",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, false},
+        .windowed_register_op = 0x3,
     }, {
         .name = "l32i.n",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, false},
+        .windowed_register_op = 0x3,
     }, {
         .name = "l32r",
         .translate = translate_l32r,
+        .windowed_register_op = 0x1,
     }, {
         .name = "l8ui",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_UB, false, false},
+        .windowed_register_op = 0x3,
     }, {
         .name = "lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_NONE, 0, 0, -4},
+        .windowed_register_op = 0x2,
     }, {
         .name = "ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_NONE, 0, 0, 4},
+        .windowed_register_op = 0x2,
     }, {
         .name = "ldpte",
         .op_flags = XTENSA_OP_ILL,
@@ -3065,116 +2980,146 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "loop",
         .translate = translate_loop,
         .par = (const uint32_t[]){TCG_COND_NEVER},
+        .windowed_register_op = 0x1,
     }, {
         .name = "loopgtz",
         .translate = translate_loop,
         .par = (const uint32_t[]){TCG_COND_GT},
+        .windowed_register_op = 0x1,
     }, {
         .name = "loopnez",
         .translate = translate_loop,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "max",
         .translate = translate_smax,
+        .windowed_register_op = 0x7,
     }, {
         .name = "maxu",
         .translate = translate_umax,
+        .windowed_register_op = 0x7,
     }, {
         .name = "memw",
         .translate = translate_memw,
     }, {
         .name = "min",
         .translate = translate_smin,
+        .windowed_register_op = 0x7,
     }, {
         .name = "minu",
         .translate = translate_umin,
+        .windowed_register_op = 0x7,
     }, {
         .name = "mov",
         .translate = translate_mov,
+        .windowed_register_op = 0x3,
     }, {
         .name = "mov.n",
         .translate = translate_mov,
+        .windowed_register_op = 0x3,
     }, {
         .name = "moveqz",
         .translate = translate_movcond,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x7,
     }, {
         .name = "movf",
         .translate = translate_movp,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x3,
     }, {
         .name = "movgez",
         .translate = translate_movcond,
         .par = (const uint32_t[]){TCG_COND_GE},
+        .windowed_register_op = 0x7,
     }, {
         .name = "movi",
         .translate = translate_movi,
+        .windowed_register_op = 0x1,
     }, {
         .name = "movi.n",
         .translate = translate_movi,
+        .windowed_register_op = 0x1,
     }, {
         .name = "movltz",
         .translate = translate_movcond,
         .par = (const uint32_t[]){TCG_COND_LT},
+        .windowed_register_op = 0x7,
     }, {
         .name = "movnez",
         .translate = translate_movcond,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x7,
     }, {
         .name = "movsp",
         .translate = translate_movsp,
+        .windowed_register_op = 0x3,
     }, {
         .name = "movt",
         .translate = translate_movp,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x3,
     }, {
         .name = "mul.aa.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_HH, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "mul.aa.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_HL, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "mul.aa.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_LH, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "mul.aa.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_LL, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "mul.ad.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_HH, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "mul.ad.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_HL, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "mul.ad.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_LH, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "mul.ad.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_LL, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "mul.da.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_HH, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mul.da.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_HL, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mul.da.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_LH, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mul.da.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_LL, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mul.dd.hh",
         .translate = translate_mac16,
@@ -3195,90 +3140,112 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mul16s",
         .translate = translate_mul16,
         .par = (const uint32_t[]){true},
+        .windowed_register_op = 0x7,
     }, {
         .name = "mul16u",
         .translate = translate_mul16,
         .par = (const uint32_t[]){false},
+        .windowed_register_op = 0x7,
     }, {
         .name = "mula.aa.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_HH, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "mula.aa.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_HL, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "mula.aa.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_LH, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "mula.aa.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_LL, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "mula.ad.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_HH, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "mula.ad.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_HL, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "mula.ad.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_LH, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "mula.ad.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_LL, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "mula.da.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.da.hh.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, -4},
+        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.hh.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, 4},
+        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.da.hl.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, -4},
+        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.hl.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, 4},
+        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.da.lh.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, -4},
+        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.lh.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, 4},
+        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.da.ll.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, -4},
+        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.ll.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, 4},
+        .windowed_register_op = 0xa,
     }, {
         .name = "mula.dd.hh",
         .translate = translate_mac16,
@@ -3287,10 +3254,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mula.dd.hh.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HH, -4},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.hh.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HH, 4},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.hl",
         .translate = translate_mac16,
@@ -3299,10 +3268,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mula.dd.hl.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HL, -4},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.hl.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HL, 4},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.lh",
         .translate = translate_mac16,
@@ -3311,10 +3282,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mula.dd.lh.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LH, -4},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.lh.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LH, 4},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.ll",
         .translate = translate_mac16,
@@ -3323,61 +3296,76 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mula.dd.ll.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LL, -4},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.ll.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LL, 4},
+        .windowed_register_op = 0x2,
     }, {
         .name = "mull",
         .translate = translate_mull,
+        .windowed_register_op = 0x7,
     }, {
         .name = "muls.aa.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_HH, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "muls.aa.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_HL, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "muls.aa.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_LH, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "muls.aa.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_LL, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "muls.ad.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_HH, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "muls.ad.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_HL, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "muls.ad.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_LH, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "muls.ad.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_LL, 0},
+        .windowed_register_op = 0x1,
     }, {
         .name = "muls.da.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_HH, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "muls.da.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_HL, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "muls.da.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_LH, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "muls.da.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_LL, 0},
+        .windowed_register_op = 0x2,
     }, {
         .name = "muls.dd.hh",
         .translate = translate_mac16,
@@ -3398,13 +3386,16 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mulsh",
         .translate = translate_mulh,
         .par = (const uint32_t[]){true},
+        .windowed_register_op = 0x7,
     }, {
         .name = "muluh",
         .translate = translate_mulh,
         .par = (const uint32_t[]){false},
+        .windowed_register_op = 0x7,
     }, {
         .name = "neg",
         .translate = translate_neg,
+        .windowed_register_op = 0x3,
     }, {
         .name = "nop",
         .translate = translate_nop,
@@ -3414,12 +3405,15 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "nsa",
         .translate = translate_nsa,
+        .windowed_register_op = 0x3,
     }, {
         .name = "nsau",
         .translate = translate_nsau,
+        .windowed_register_op = 0x3,
     }, {
         .name = "or",
         .translate = translate_or,
+        .windowed_register_op = 0x7,
     }, {
         .name = "orb",
         .translate = translate_boolean,
@@ -3433,44 +3427,54 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_ptlb,
         .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "pitlb",
         .translate = translate_ptlb,
         .par = (const uint32_t[]){false},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "quos",
         .translate = translate_quos,
         .par = (const uint32_t[]){true},
+        .windowed_register_op = 0x7,
     }, {
         .name = "quou",
         .translate = translate_quou,
         .par = (const uint32_t[]){true},
+        .windowed_register_op = 0x7,
     }, {
         .name = "rdtlb0",
         .translate = translate_rtlb,
         .par = (const uint32_t[]){true, 0},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "rdtlb1",
         .translate = translate_rtlb,
         .par = (const uint32_t[]){true, 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "read_impwire",
         .translate = translate_read_impwire,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rems",
         .translate = translate_quos,
         .par = (const uint32_t[]){false},
+        .windowed_register_op = 0x7,
     }, {
         .name = "remu",
         .translate = translate_quou,
         .par = (const uint32_t[]){false},
+        .windowed_register_op = 0x7,
     }, {
         .name = "rer",
         .translate = translate_rer,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "ret",
         .translate = translate_ret,
@@ -3518,11 +3522,13 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rtlb,
         .par = (const uint32_t[]){false, 0},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "ritlb1",
         .translate = translate_rtlb,
         .par = (const uint32_t[]){false, 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "rotw",
         .translate = translate_rotw,
@@ -3531,449 +3537,526 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "rsil",
         .translate = translate_rsil,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.176",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){176},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.208",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){208},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.acchi",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ACCHI},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.acclo",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ACCLO},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.atomctl",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ATOMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.br",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){BR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.cacheattr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CACHEATTR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ccompare0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ccompare1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ccompare2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ccount",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.configid0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CONFIGID0},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.configid1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CONFIGID1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.cpenable",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CPENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.dbreaka0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.dbreaka1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.dbreakc0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKC},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.dbreakc1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ddr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.debugcause",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.depc",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DEPC},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.dtlbcfg",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DTLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc4",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc5",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc6",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc7",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps4",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps5",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps6",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps7",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.exccause",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave4",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave5",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave6",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave7",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excvaddr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ibreaka0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ibreaka1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ibreakenable",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.icount",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ICOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.icountlevel",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.intclear",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTCLEAR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.intenable",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.interrupt",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTSET},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.intset",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTSET},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.itlbcfg",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ITLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.lbeg",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LBEG},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.lcount",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LCOUNT},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.lend",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LEND},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.litbase",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LITBASE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.m0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.m1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR + 1},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.m2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR + 2},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.m3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR + 3},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.memctl",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.misc0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.misc1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.misc2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.misc3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.prid",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PRID},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ps",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PS},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ptevaddr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PTEVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.rasid",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){RASID},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.sar",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){SAR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.scompare1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){SCOMPARE1},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.vecbase",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){VECBASE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.windowbase",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){WINDOW_BASE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.windowstart",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){WINDOW_START},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "rsync",
         .translate = translate_nop,
@@ -3981,63 +4064,78 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "rur.expstate",
         .translate = translate_rur,
         .par = (const uint32_t[]){EXPSTATE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rur.fcr",
         .translate = translate_rur,
         .par = (const uint32_t[]){FCR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rur.fsr",
         .translate = translate_rur,
         .par = (const uint32_t[]){FSR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "rur.threadptr",
         .translate = translate_rur,
         .par = (const uint32_t[]){THREADPTR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "s16i",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUW, false, true},
+        .windowed_register_op = 0x3,
     }, {
         .name = "s32c1i",
         .translate = translate_s32c1i,
+        .windowed_register_op = 0x3,
     }, {
         .name = "s32e",
         .translate = translate_s32e,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "s32i",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, true},
+        .windowed_register_op = 0x3,
     }, {
         .name = "s32i.n",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, true},
+        .windowed_register_op = 0x3,
     }, {
         .name = "s32nb",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, true},
+        .windowed_register_op = 0x3,
     }, {
         .name = "s32ri",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, true, true},
+        .windowed_register_op = 0x3,
     }, {
         .name = "s8i",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_UB, false, true},
+        .windowed_register_op = 0x3,
     }, {
         .name = "salt",
         .translate = translate_salt,
         .par = (const uint32_t[]){TCG_COND_LT},
+        .windowed_register_op = 0x7,
     }, {
         .name = "saltu",
         .translate = translate_salt,
         .par = (const uint32_t[]){TCG_COND_LTU},
+        .windowed_register_op = 0x7,
     }, {
         .name = "setb_expstate",
         .translate = translate_setb_expstate,
     }, {
         .name = "sext",
         .translate = translate_sext,
+        .windowed_register_op = 0x3,
     }, {
         .name = "simcall",
         .translate = translate_simcall,
@@ -4046,54 +4144,69 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "sll",
         .translate = translate_sll,
+        .windowed_register_op = 0x3,
     }, {
         .name = "slli",
         .translate = translate_slli,
+        .windowed_register_op = 0x3,
     }, {
         .name = "sra",
         .translate = translate_sra,
+        .windowed_register_op = 0x3,
     }, {
         .name = "srai",
         .translate = translate_srai,
+        .windowed_register_op = 0x3,
     }, {
         .name = "src",
         .translate = translate_src,
+        .windowed_register_op = 0x7,
     }, {
         .name = "srl",
         .translate = translate_srl,
+        .windowed_register_op = 0x3,
     }, {
         .name = "srli",
         .translate = translate_srli,
+        .windowed_register_op = 0x3,
     }, {
         .name = "ssa8b",
         .translate = translate_ssa8b,
+        .windowed_register_op = 0x1,
     }, {
         .name = "ssa8l",
         .translate = translate_ssa8l,
+        .windowed_register_op = 0x1,
     }, {
         .name = "ssai",
         .translate = translate_ssai,
     }, {
         .name = "ssl",
         .translate = translate_ssl,
+        .windowed_register_op = 0x1,
     }, {
         .name = "ssr",
         .translate = translate_ssr,
+        .windowed_register_op = 0x1,
     }, {
         .name = "sub",
         .translate = translate_sub,
+        .windowed_register_op = 0x7,
     }, {
         .name = "subx2",
         .translate = translate_subx,
         .par = (const uint32_t[]){1},
+        .windowed_register_op = 0x7,
     }, {
         .name = "subx4",
         .translate = translate_subx,
         .par = (const uint32_t[]){2},
+        .windowed_register_op = 0x7,
     }, {
         .name = "subx8",
         .translate = translate_subx,
         .par = (const uint32_t[]){3},
+        .windowed_register_op = 0x7,
     }, {
         .name = "syscall",
         .op_flags = XTENSA_OP_SYSCALL,
@@ -4101,18 +4214,22 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "umul.aa.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_HH, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "umul.aa.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_HL, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "umul.aa.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_LH, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "umul.aa.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_LL, 0},
+        .windowed_register_op = 0x3,
     }, {
         .name = "waiti",
         .translate = translate_waiti,
@@ -4122,486 +4239,572 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wtlb,
         .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "wer",
         .translate = translate_wer,
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "witlb",
         .translate = translate_wtlb,
         .par = (const uint32_t[]){false},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x3,
     }, {
         .name = "wrmsk_expstate",
         .translate = translate_wrmsk_expstate,
+        .windowed_register_op = 0x3,
     }, {
         .name = "wsr.176",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){176},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.208",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){208},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.acchi",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ACCHI},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.acclo",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ACCLO},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.atomctl",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ATOMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.br",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){BR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.cacheattr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CACHEATTR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccompare0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccompare1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccompare2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccount",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.configid0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CONFIGID0},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.configid1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CONFIGID1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.cpenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CPENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dbreaka0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dbreaka1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dbreakc0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKC},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dbreakc1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ddr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.debugcause",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.depc",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DEPC},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dtlbcfg",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DTLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc4",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc5",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc6",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc7",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps4",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps5",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps6",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps7",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.exccause",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave4",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave5",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave6",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave7",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excvaddr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ibreaka0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ibreaka1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ibreakenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.icount",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ICOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.icountlevel",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intclear",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTCLEAR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.interrupt",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTSET},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intset",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTSET},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.itlbcfg",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ITLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.lbeg",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LBEG},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.lcount",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LCOUNT},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.lend",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LEND},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.litbase",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LITBASE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.m0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.m1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR + 1},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.m2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR + 2},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.m3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR + 3},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.memctl",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.misc0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.misc1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.misc2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.misc3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.mmid",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MMID},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.prid",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PRID},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ps",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PS},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ptevaddr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PTEVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.rasid",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){RASID},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.sar",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){SAR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.scompare1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){SCOMPARE1},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.vecbase",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){VECBASE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.windowbase",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_BASE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.windowstart",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_START},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "wur.expstate",
         .translate = translate_wur,
         .par = (const uint32_t[]){EXPSTATE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wur.fcr",
         .translate = translate_wur,
         .par = (const uint32_t[]){FCR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wur.fsr",
         .translate = translate_wur,
         .par = (const uint32_t[]){FSR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wur.threadptr",
         .translate = translate_wur,
         .par = (const uint32_t[]){THREADPTR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xor",
         .translate = translate_xor,
+        .windowed_register_op = 0x7,
     }, {
         .name = "xorb",
         .translate = translate_boolean,
@@ -4612,443 +4815,519 @@ static const XtensaOpcodeOps core_ops[] = {
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){176},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.208",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){208},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.acchi",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ACCHI},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.acclo",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ACCLO},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.atomctl",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ATOMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.br",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){BR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.cacheattr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CACHEATTR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccompare0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccompare1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccompare2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccount",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.configid0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CONFIGID0},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.configid1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CONFIGID1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.cpenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CPENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dbreaka0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dbreaka1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dbreakc0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKC},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dbreakc1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ddr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.debugcause",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.depc",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DEPC},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dtlbcfg",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DTLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc4",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc5",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc6",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc7",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps4",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps5",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps6",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps7",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.exccause",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave4",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave5",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave6",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave7",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excvaddr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ibreaka0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ibreaka1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ibreakenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.icount",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ICOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.icountlevel",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intclear",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTCLEAR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.interrupt",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTSET},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intset",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTSET},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.itlbcfg",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ITLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.lbeg",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LBEG},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.lcount",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LCOUNT},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.lend",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LEND},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.litbase",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LITBASE},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.m0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.m1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR + 1},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.m2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR + 2},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.m3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR + 3},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.memctl",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.misc0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.misc1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.misc2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.misc3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.prid",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PRID},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ps",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PS},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ptevaddr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PTEVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.rasid",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){RASID},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.sar",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){SAR},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.scompare1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){SCOMPARE1},
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.vecbase",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){VECBASE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.windowbase",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_BASE},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.windowstart",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_START},
         .op_flags = XTENSA_OP_PRIVILEGED,
+        .windowed_register_op = 0x1,
     },
 };
 
@@ -5110,7 +5389,7 @@ static void translate_compare_s(DisasContext *dc, const uint32_t arg[],
 static void translate_float_s(DisasContext *dc, const uint32_t arg[],
                               const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[1]) && gen_check_cpenable(dc, 0)) {
+    if (gen_check_cpenable(dc, 0)) {
         TCGv_i32 scale = tcg_const_i32(-arg[2]);
 
         if (par[0]) {
@@ -5125,7 +5404,7 @@ static void translate_float_s(DisasContext *dc, const uint32_t arg[],
 static void translate_ftoi_s(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0]) && gen_check_cpenable(dc, 0)) {
+    if (gen_check_cpenable(dc, 0)) {
         TCGv_i32 rounding_mode = tcg_const_i32(par[0]);
         TCGv_i32 scale = tcg_const_i32(arg[2]);
 
@@ -5144,7 +5423,7 @@ static void translate_ftoi_s(DisasContext *dc, const uint32_t arg[],
 static void translate_ldsti(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[1]) && gen_check_cpenable(dc, 0)) {
+    if (gen_check_cpenable(dc, 0)) {
         TCGv_i32 addr = tcg_temp_new_i32();
 
         tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
@@ -5164,7 +5443,7 @@ static void translate_ldsti(DisasContext *dc, const uint32_t arg[],
 static void translate_ldstx(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_window_check2(dc, arg[1], arg[2]) && gen_check_cpenable(dc, 0)) {
+    if (gen_check_cpenable(dc, 0)) {
         TCGv_i32 addr = tcg_temp_new_i32();
 
         tcg_gen_add_i32(addr, cpu_R[arg[1]], cpu_R[arg[2]]);
@@ -5201,7 +5480,7 @@ static void translate_mov_s(DisasContext *dc, const uint32_t arg[],
 static void translate_movcond_s(DisasContext *dc, const uint32_t arg[],
                                 const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[2]) && gen_check_cpenable(dc, 0)) {
+    if (gen_check_cpenable(dc, 0)) {
         TCGv_i32 zero = tcg_const_i32(0);
 
         tcg_gen_movcond_i32(par[0], cpu_FR[arg[0]],
@@ -5256,8 +5535,7 @@ static void translate_neg_s(DisasContext *dc, const uint32_t arg[],
 static void translate_rfr_s(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[0]) &&
-        gen_check_cpenable(dc, 0)) {
+    if (gen_check_cpenable(dc, 0)) {
         tcg_gen_mov_i32(cpu_R[arg[0]], cpu_FR[arg[1]]);
     }
 }
@@ -5274,8 +5552,7 @@ static void translate_sub_s(DisasContext *dc, const uint32_t arg[],
 static void translate_wfr_s(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_window_check1(dc, arg[1]) &&
-        gen_check_cpenable(dc, 0)) {
+    if (gen_check_cpenable(dc, 0)) {
         tcg_gen_mov_i32(cpu_FR[arg[0]], cpu_R[arg[1]]);
     }
 }
@@ -5291,30 +5568,37 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "ceil.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_up, false},
+        .windowed_register_op = 0x1,
     }, {
         .name = "float.s",
         .translate = translate_float_s,
         .par = (const uint32_t[]){false},
+        .windowed_register_op = 0x2,
     }, {
         .name = "floor.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_down, false},
+        .windowed_register_op = 0x1,
     }, {
         .name = "lsi",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){false, false},
+        .windowed_register_op = 0x2,
     }, {
         .name = "lsiu",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){false, true},
+        .windowed_register_op = 0x2,
     }, {
         .name = "lsx",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){false, false},
+        .windowed_register_op = 0x6,
     }, {
         .name = "lsxu",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){false, true},
+        .windowed_register_op = 0x6,
     }, {
         .name = "madd.s",
         .translate = translate_madd_s,
@@ -5325,6 +5609,7 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "moveqz.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .windowed_register_op = 0x4,
     }, {
         .name = "movf.s",
         .translate = translate_movp_s,
@@ -5333,14 +5618,17 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "movgez.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_GE},
+        .windowed_register_op = 0x4,
     }, {
         .name = "movltz.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_LT},
+        .windowed_register_op = 0x4,
     }, {
         .name = "movnez.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .windowed_register_op = 0x4,
     }, {
         .name = "movt.s",
         .translate = translate_movp_s,
@@ -5369,26 +5657,32 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
     }, {
         .name = "rfr",
         .translate = translate_rfr_s,
+        .windowed_register_op = 0x1,
     }, {
         .name = "round.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_nearest_even, false},
+        .windowed_register_op = 0x1,
     }, {
         .name = "ssi",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){true, false},
+        .windowed_register_op = 0x2,
     }, {
         .name = "ssiu",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){true, true},
+        .windowed_register_op = 0x2,
     }, {
         .name = "ssx",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){true, false},
+        .windowed_register_op = 0x6,
     }, {
         .name = "ssxu",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){true, true},
+        .windowed_register_op = 0x6,
     }, {
         .name = "sub.s",
         .translate = translate_sub_s,
@@ -5396,6 +5690,7 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "trunc.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_to_zero, false},
+        .windowed_register_op = 0x1,
     }, {
         .name = "ueq.s",
         .translate = translate_compare_s,
@@ -5404,6 +5699,7 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "ufloat.s",
         .translate = translate_float_s,
         .par = (const uint32_t[]){true},
+        .windowed_register_op = 0x2,
     }, {
         .name = "ule.s",
         .translate = translate_compare_s,
@@ -5420,9 +5716,11 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "utrunc.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_to_zero, true},
+        .windowed_register_op = 0x1,
     }, {
         .name = "wfr",
         .translate = translate_wfr_s,
+        .windowed_register_op = 0x2,
     },
 };
 
-- 
2.11.0
