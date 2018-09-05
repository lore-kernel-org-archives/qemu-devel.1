Received: from eggs.gnu.org ([2001:4830:134:3::10]:57766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMrv-0005t0-Q8
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMrp-0006e1-W2
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:30 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a]:44387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMro-0006Xh-KG
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:25 -0400
Received: by mail-lf1-x12a.google.com with SMTP id g6-v6so4552450lfb.11
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:22 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:38 -0700
Message-Id: <20180905014352.970-2-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 01/15] target/xtensa: extract test for an
 illegal instruction
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

- TB flags: add XTENSA_TBFLAG_CWOE that corresponds to the architectural
  CWOE state;
- entry: move CWOE check from the helper to the test_ill_entry;
- retw: move CWOE check from the helper to the test_ill_retw;
- separate instruction disassembly loop and translation loop; save
  disassembly results in local array;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  27 +++-
 target/xtensa/helper.c    |   6 +
 target/xtensa/helper.h    |   1 +
 target/xtensa/op_helper.c |  72 +++++----
 target/xtensa/translate.c | 367 +++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 400 insertions(+), 73 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 1362772617ea..0a0323f3868e 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -217,6 +217,7 @@ enum {
 #define MEMCTL_IL0EN 0x1
 
 #define MAX_INSN_LENGTH 64
+#define MAX_INSN_SLOTS 32
 #define MAX_OPCODE_ARGS 16
 #define MAX_NAREG 64
 #define MAX_NINTERRUPT 32
@@ -347,11 +348,34 @@ typedef struct XtensaMemory {
 typedef struct DisasContext DisasContext;
 typedef void (*XtensaOpcodeOp)(DisasContext *dc, const uint32_t arg[],
                                const uint32_t par[]);
+typedef bool (*XtensaOpcodeBoolTest)(DisasContext *dc,
+                                     const uint32_t arg[],
+                                     const uint32_t par[]);
+
+enum {
+    XTENSA_OP_ILL = 0x1,
+    XTENSA_OP_PRIVILEGED = 0x2,
+    XTENSA_OP_SYSCALL = 0x4,
+    XTENSA_OP_DEBUG_BREAK = 0x8,
+
+    XTENSA_OP_OVERFLOW = 0x10,
+    XTENSA_OP_UNDERFLOW = 0x20,
+    XTENSA_OP_ALLOCA = 0x40,
+    XTENSA_OP_COPROCESSOR = 0x80,
+
+    XTENSA_OP_DIVIDE_BY_ZERO = 0x100,
+
+    XTENSA_OP_CHECK_INTERRUPTS = 0x200,
+    XTENSA_OP_EXIT_TB_M1 = 0x400,
+    XTENSA_OP_EXIT_TB_0 = 0x800,
+};
 
 typedef struct XtensaOpcodeOps {
     const char *name;
     XtensaOpcodeOp translate;
+    XtensaOpcodeBoolTest test_ill;
     const uint32_t *par;
+    uint32_t op_flags;
 } XtensaOpcodeOps;
 
 typedef struct XtensaOpcodeTranslators {
@@ -661,6 +685,7 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
 #define XTENSA_TBFLAG_WINDOW_MASK 0x18000
 #define XTENSA_TBFLAG_WINDOW_SHIFT 15
 #define XTENSA_TBFLAG_YIELD 0x20000
+#define XTENSA_TBFLAG_CWOE 0x40000
 
 static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
         target_ulong *cs_base, uint32_t *flags)
@@ -698,7 +723,7 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
             (env->sregs[WINDOW_BASE] + 1);
         uint32_t w = ctz32(windowstart | 0x8);
 
-        *flags |= w << XTENSA_TBFLAG_WINDOW_SHIFT;
+        *flags |= (w << XTENSA_TBFLAG_WINDOW_SHIFT) | XTENSA_TBFLAG_CWOE;
     } else {
         *flags |= 3 << XTENSA_TBFLAG_WINDOW_SHIFT;
     }
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 0484f5fab808..6241d1e7e42f 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -57,12 +57,18 @@ static void init_libisa(XtensaConfig *config)
 {
     unsigned i, j;
     unsigned opcodes;
+    unsigned formats;
 
     config->isa = xtensa_isa_init(config->isa_internal, NULL, NULL);
     assert(xtensa_isa_maxlength(config->isa) <= MAX_INSN_LENGTH);
     opcodes = xtensa_isa_num_opcodes(config->isa);
+    formats = xtensa_isa_num_formats(config->isa);
     config->opcode_ops = g_new(XtensaOpcodeOps *, opcodes);
 
+    for (i = 0; i < formats; ++i) {
+        assert(xtensa_format_num_slots(config->isa, i) <= MAX_INSN_SLOTS);
+    }
+
     for (i = 0; i < opcodes; ++i) {
         const char *opc_name = xtensa_opcode_name(config->isa, i);
         XtensaOpcodeOps *ops = NULL;
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 73444ae02ccd..c1b3bacb4cf2 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -5,6 +5,7 @@ DEF_HELPER_3(debug_exception, noreturn, env, i32, i32)
 
 DEF_HELPER_2(wsr_windowbase, void, env, i32)
 DEF_HELPER_4(entry, void, env, i32, i32, i32)
+DEF_HELPER_2(test_ill_retw, void, env, i32)
 DEF_HELPER_2(retw, i32, env, i32)
 DEF_HELPER_2(rotw, void, env, i32)
 DEF_HELPER_3(window_check, noreturn, env, i32, i32)
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 06fe346f02ff..f5520659d8f9 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -253,22 +253,16 @@ void HELPER(wsr_windowbase)(CPUXtensaState *env, uint32_t v)
 void HELPER(entry)(CPUXtensaState *env, uint32_t pc, uint32_t s, uint32_t imm)
 {
     int callinc = (env->sregs[PS] & PS_CALLINC) >> PS_CALLINC_SHIFT;
-    if (s > 3 || ((env->sregs[PS] & (PS_WOE | PS_EXCM)) ^ PS_WOE) != 0) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Illegal entry instruction(pc = %08x), PS = %08x\n",
-                      pc, env->sregs[PS]);
-        HELPER(exception_cause)(env, pc, ILLEGAL_INSTRUCTION_CAUSE);
-    } else {
-        uint32_t windowstart = xtensa_replicate_windowstart(env) >>
-            (env->sregs[WINDOW_BASE] + 1);
+    uint32_t windowstart = xtensa_replicate_windowstart(env) >>
+        (env->sregs[WINDOW_BASE] + 1);
 
-        if (windowstart & ((1 << callinc) - 1)) {
-            HELPER(window_check)(env, pc, callinc);
-        }
-        env->regs[(callinc << 2) | (s & 3)] = env->regs[s] - imm;
-        xtensa_rotate_window(env, callinc);
-        env->sregs[WINDOW_START] |=
-            windowstart_bit(env->sregs[WINDOW_BASE], env);
+    if (windowstart & ((1 << callinc) - 1)) {
+        HELPER(window_check)(env, pc, callinc);
     }
+    env->regs[(callinc << 2) | (s & 3)] = env->regs[s] - imm;
+    xtensa_rotate_window(env, callinc);
+    env->sregs[WINDOW_START] |=
+        windowstart_bit(env->sregs[WINDOW_BASE], env);
 }
 
 void HELPER(window_check)(CPUXtensaState *env, uint32_t pc, uint32_t w)
@@ -298,13 +292,12 @@ void HELPER(window_check)(CPUXtensaState *env, uint32_t pc, uint32_t w)
     }
 }
 
-uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
+void HELPER(test_ill_retw)(CPUXtensaState *env, uint32_t pc)
 {
     int n = (env->regs[0] >> 30) & 0x3;
     int m = 0;
     uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
     uint32_t windowstart = env->sregs[WINDOW_START];
-    uint32_t ret_pc = 0;
 
     if (windowstart & windowstart_bit(windowbase - 1, env)) {
         m = 1;
@@ -314,33 +307,38 @@ uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
         m = 3;
     }
 
-    if (n == 0 || (m != 0 && m != n) ||
-            ((env->sregs[PS] & (PS_WOE | PS_EXCM)) ^ PS_WOE) != 0) {
+    if (n == 0 || (m != 0 && m != n)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Illegal retw instruction(pc = %08x), "
                       "PS = %08x, m = %d, n = %d\n",
                       pc, env->sregs[PS], m, n);
         HELPER(exception_cause)(env, pc, ILLEGAL_INSTRUCTION_CAUSE);
-    } else {
-        int owb = windowbase;
+    }
+}
 
-        ret_pc = (pc & 0xc0000000) | (env->regs[0] & 0x3fffffff);
+uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
+{
+    int n = (env->regs[0] >> 30) & 0x3;
+    uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
+    uint32_t windowstart = env->sregs[WINDOW_START];
+    uint32_t ret_pc = 0;
 
-        xtensa_rotate_window(env, -n);
-        if (windowstart & windowstart_bit(env->sregs[WINDOW_BASE], env)) {
-            env->sregs[WINDOW_START] &= ~windowstart_bit(owb, env);
-        } else {
-            /* window underflow */
-            env->sregs[PS] = (env->sregs[PS] & ~PS_OWB) |
-                (windowbase << PS_OWB_SHIFT) | PS_EXCM;
-            env->sregs[EPC1] = env->pc = pc;
-
-            if (n == 1) {
-                HELPER(exception)(env, EXC_WINDOW_UNDERFLOW4);
-            } else if (n == 2) {
-                HELPER(exception)(env, EXC_WINDOW_UNDERFLOW8);
-            } else if (n == 3) {
-                HELPER(exception)(env, EXC_WINDOW_UNDERFLOW12);
-            }
+    ret_pc = (pc & 0xc0000000) | (env->regs[0] & 0x3fffffff);
+
+    xtensa_rotate_window(env, -n);
+    if (windowstart & windowstart_bit(env->sregs[WINDOW_BASE], env)) {
+        env->sregs[WINDOW_START] &= ~windowstart_bit(windowbase, env);
+    } else {
+        /* window underflow */
+        env->sregs[PS] = (env->sregs[PS] & ~PS_OWB) |
+            (windowbase << PS_OWB_SHIFT) | PS_EXCM;
+        env->sregs[EPC1] = env->pc = pc;
+
+        if (n == 1) {
+            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW4);
+        } else if (n == 2) {
+            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW8);
+        } else if (n == 3) {
+            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW12);
         }
     }
     return ret_pc;
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 25399058a0db..8c6d1e79866c 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -62,6 +62,7 @@ struct DisasContext {
     TCGv_i32 sar_m32;
 
     unsigned window;
+    bool cwoe;
 
     bool debug;
     bool icount;
@@ -469,7 +470,7 @@ static void gen_brcondi(DisasContext *dc, TCGCond cond,
     tcg_temp_free(tmp);
 }
 
-static bool gen_check_sr(DisasContext *dc, uint32_t sr, unsigned access)
+static bool check_sr(DisasContext *dc, uint32_t sr, unsigned access)
 {
     if (!xtensa_option_bits_enabled(dc->config, sregnames[sr].opt_bits)) {
         if (sregnames[sr].name) {
@@ -477,7 +478,6 @@ static bool gen_check_sr(DisasContext *dc, uint32_t sr, unsigned access)
         } else {
             qemu_log_mask(LOG_UNIMP, "SR %d is not implemented\n", sr);
         }
-        gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
         return false;
     } else if (!(sregnames[sr].access & access)) {
         static const char * const access_text[] = {
@@ -488,7 +488,6 @@ static bool gen_check_sr(DisasContext *dc, uint32_t sr, unsigned access)
         assert(access < ARRAY_SIZE(access_text) && access_text[access]);
         qemu_log_mask(LOG_GUEST_ERROR, "SR %s is not available for %s\n", sregnames[sr].name,
                       access_text[access]);
-        gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
         return false;
     }
     return true;
@@ -954,6 +953,12 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     xtensa_format fmt;
     int slot, slots;
     unsigned i;
+    uint32_t op_flags = 0;
+    struct {
+        XtensaOpcodeOps *ops;
+        uint32_t arg[MAX_OPCODE_ARGS];
+        uint32_t raw_arg[MAX_OPCODE_ARGS];
+    } slot_prop[MAX_INSN_SLOTS];
 
     if (len == XTENSA_UNDEFINED) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -987,8 +992,8 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     for (slot = 0; slot < slots; ++slot) {
         xtensa_opcode opc;
         int opnd, vopnd, opnds;
-        uint32_t raw_arg[MAX_OPCODE_ARGS];
-        uint32_t arg[MAX_OPCODE_ARGS];
+        uint32_t *raw_arg = slot_prop[slot].raw_arg;
+        uint32_t *arg = slot_prop[slot].arg;
         XtensaOpcodeOps *ops;
 
         dc->raw_arg = raw_arg;
@@ -1020,16 +1025,29 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
             }
         }
         ops = dc->config->opcode_ops[opc];
+        slot_prop[slot].ops = ops;
+
         if (ops) {
-            ops->translate(dc, arg, ops->par);
+            op_flags |= ops->op_flags;
         } else {
-            qemu_log_mask(LOG_GUEST_ERROR,
+            qemu_log_mask(LOG_UNIMP,
                           "unimplemented opcode '%s' in slot %d (pc = %08x)\n",
                           xtensa_opcode_name(isa, opc), slot, dc->pc);
+            op_flags |= XTENSA_OP_ILL;
+        }
+        if ((op_flags & XTENSA_OP_ILL) ||
+            (ops && ops->test_ill && ops->test_ill(dc, arg, ops->par))) {
             gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
             return;
         }
     }
+
+    for (slot = 0; slot < slots; ++slot) {
+        XtensaOpcodeOps *ops = slot_prop[slot].ops;
+
+        dc->raw_arg = slot_prop[slot].raw_arg;
+        ops->translate(dc, slot_prop[slot].arg, ops->par);
+    }
     if (dc->base.is_jmp == DISAS_NEXT) {
         gen_check_loop_end(dc, 0);
     }
@@ -1074,6 +1092,7 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
         XTENSA_TBFLAG_CPENABLE_SHIFT;
     dc->window = ((tb_flags & XTENSA_TBFLAG_WINDOW_MASK) >>
                  XTENSA_TBFLAG_WINDOW_SHIFT);
+    dc->cwoe = tb_flags & XTENSA_TBFLAG_CWOE;
 
     if (dc->config->isa) {
         dc->insnbuf = xtensa_insnbuf_alloc(dc->config->isa);
@@ -1590,6 +1609,18 @@ static void translate_depbits(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static bool test_ill_entry(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (arg[0] > 3 || !dc->cwoe) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Illegal entry instruction(pc = %08x)\n", dc->pc);
+        return true;
+    } else {
+        return false;
+    }
+}
+
 static void translate_entry(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
@@ -1650,12 +1681,6 @@ static void translate_itlb(DisasContext *dc, const uint32_t arg[],
     }
 }
 
-static void translate_ill(DisasContext *dc, const uint32_t arg[],
-                          const uint32_t par[])
-{
-    gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
-}
-
 static void translate_j(DisasContext *dc, const uint32_t arg[],
                         const uint32_t par[])
 {
@@ -2124,6 +2149,22 @@ static void translate_ret(DisasContext *dc, const uint32_t arg[],
     gen_jump(dc, cpu_R[0]);
 }
 
+static bool test_ill_retw(DisasContext *dc, const uint32_t arg[],
+                          const uint32_t par[])
+{
+    if (!dc->cwoe) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Illegal retw instruction(pc = %08x)\n", dc->pc);
+        return true;
+    } else {
+        TCGv_i32 tmp = tcg_const_i32(dc->pc);
+
+        gen_helper_test_ill_retw(cpu_env, tmp);
+        tcg_temp_free(tmp);
+        return false;
+    }
+}
+
 static void translate_retw(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
@@ -2211,11 +2252,16 @@ static void translate_rsil(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static bool test_ill_rsr(DisasContext *dc, const uint32_t arg[],
+                         const uint32_t par[])
+{
+    return !check_sr(dc, par[0], SR_R);
+}
+
 static void translate_rsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_check_sr(dc, par[0], SR_R) &&
-        (par[0] < 64 || gen_check_privilege(dc)) &&
+    if ((par[0] < 64 || gen_check_privilege(dc)) &&
         gen_window_check1(dc, arg[0])) {
         if (gen_rsr(dc, cpu_R[arg[0]], par[0])) {
             gen_jumpi_check_loop_end(dc, 0);
@@ -2337,20 +2383,28 @@ static void translate_sext(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static bool test_ill_simcall(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+#ifdef CONFIG_USER_ONLY
+    bool ill = true;
+#else
+    bool ill = !semihosting_enabled();
+#endif
+    if (ill) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
+    }
+    return ill;
+}
+
 static void translate_simcall(DisasContext *dc, const uint32_t arg[],
                               const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
-    if (semihosting_enabled()) {
-        if (gen_check_privilege(dc)) {
-            gen_helper_simcall(cpu_env);
-        }
-    } else
-#endif
-    {
-        qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
-        gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
+    if (gen_check_privilege(dc)) {
+        gen_helper_simcall(cpu_env);
     }
+#endif
 }
 
 /*
@@ -2570,11 +2624,16 @@ static void translate_wrmsk_expstate(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static bool test_ill_wsr(DisasContext *dc, const uint32_t arg[],
+                         const uint32_t par[])
+{
+    return !check_sr(dc, par[0], SR_W);
+}
+
 static void translate_wsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_check_sr(dc, par[0], SR_W) &&
-        (par[0] < 64 || gen_check_privilege(dc)) &&
+    if ((par[0] < 64 || gen_check_privilege(dc)) &&
         gen_window_check1(dc, arg[0])) {
         gen_wsr(dc, par[0], cpu_R[arg[0]]);
     }
@@ -2600,11 +2659,16 @@ static void translate_xor(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static bool test_ill_xsr(DisasContext *dc, const uint32_t arg[],
+                         const uint32_t par[])
+{
+    return !check_sr(dc, par[0], SR_X);
+}
+
 static void translate_xsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_check_sr(dc, par[0], SR_X) &&
-        (par[0] < 64 || gen_check_privilege(dc)) &&
+    if ((par[0] < 64 || gen_check_privilege(dc)) &&
         gen_window_check1(dc, arg[0])) {
         TCGv_i32 tmp = tcg_temp_new_i32();
         bool rsr_end, wsr_end;
@@ -2897,6 +2961,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "entry",
         .translate = translate_entry,
+        .test_ill = test_ill_entry,
     }, {
         .name = "esync",
         .translate = translate_nop,
@@ -2911,10 +2976,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_memw,
     }, {
         .name = "hwwdtlba",
-        .translate = translate_ill,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "hwwitlba",
-        .translate = translate_ill,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "idtlb",
         .translate = translate_itlb,
@@ -2941,10 +3006,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){true, false},
     }, {
         .name = "ill",
-        .translate = translate_ill,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "ill.n",
-        .translate = translate_ill,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "ipf",
         .translate = translate_icache,
@@ -3002,7 +3067,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){MAC16_NONE, 0, 0, 4},
     }, {
         .name = "ldpte",
-        .translate = translate_ill,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "loop",
         .translate = translate_loop,
@@ -3417,18 +3482,20 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "retw",
         .translate = translate_retw,
+        .test_ill = test_ill_retw,
     }, {
         .name = "retw.n",
         .translate = translate_retw,
+        .test_ill = test_ill_retw,
     }, {
         .name = "rfdd",
-        .translate = translate_ill,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "rfde",
         .translate = translate_rfde,
     }, {
         .name = "rfdo",
-        .translate = translate_ill,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "rfe",
         .translate = translate_rfe,
@@ -3460,306 +3527,382 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.176",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){176},
     }, {
         .name = "rsr.208",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){208},
     }, {
         .name = "rsr.acchi",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ACCHI},
     }, {
         .name = "rsr.acclo",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ACCLO},
     }, {
         .name = "rsr.atomctl",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ATOMCTL},
     }, {
         .name = "rsr.br",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){BR},
     }, {
         .name = "rsr.cacheattr",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CACHEATTR},
     }, {
         .name = "rsr.ccompare0",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE},
     }, {
         .name = "rsr.ccompare1",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
     }, {
         .name = "rsr.ccompare2",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
     }, {
         .name = "rsr.ccount",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOUNT},
     }, {
         .name = "rsr.configid0",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CONFIGID0},
     }, {
         .name = "rsr.configid1",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CONFIGID1},
     }, {
         .name = "rsr.cpenable",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CPENABLE},
     }, {
         .name = "rsr.dbreaka0",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKA},
     }, {
         .name = "rsr.dbreaka1",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKA + 1},
     }, {
         .name = "rsr.dbreakc0",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKC},
     }, {
         .name = "rsr.dbreakc1",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKC + 1},
     }, {
         .name = "rsr.ddr",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DDR},
     }, {
         .name = "rsr.debugcause",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
     }, {
         .name = "rsr.depc",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DEPC},
     }, {
         .name = "rsr.dtlbcfg",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DTLBCFG},
     }, {
         .name = "rsr.epc1",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1},
     }, {
         .name = "rsr.epc2",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 1},
     }, {
         .name = "rsr.epc3",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 2},
     }, {
         .name = "rsr.epc4",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 3},
     }, {
         .name = "rsr.epc5",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 4},
     }, {
         .name = "rsr.epc6",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 5},
     }, {
         .name = "rsr.epc7",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 6},
     }, {
         .name = "rsr.eps2",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2},
     }, {
         .name = "rsr.eps3",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 1},
     }, {
         .name = "rsr.eps4",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 2},
     }, {
         .name = "rsr.eps5",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 3},
     }, {
         .name = "rsr.eps6",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 4},
     }, {
         .name = "rsr.eps7",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 5},
     }, {
         .name = "rsr.exccause",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCCAUSE},
     }, {
         .name = "rsr.excsave1",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1},
     }, {
         .name = "rsr.excsave2",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
     }, {
         .name = "rsr.excsave3",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
     }, {
         .name = "rsr.excsave4",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
     }, {
         .name = "rsr.excsave5",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
     }, {
         .name = "rsr.excsave6",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
     }, {
         .name = "rsr.excsave7",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
     }, {
         .name = "rsr.excvaddr",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCVADDR},
     }, {
         .name = "rsr.ibreaka0",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKA},
     }, {
         .name = "rsr.ibreaka1",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKA + 1},
     }, {
         .name = "rsr.ibreakenable",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKENABLE},
     }, {
         .name = "rsr.icount",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ICOUNT},
     }, {
         .name = "rsr.icountlevel",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
     }, {
         .name = "rsr.intclear",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTCLEAR},
     }, {
         .name = "rsr.intenable",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTENABLE},
     }, {
         .name = "rsr.interrupt",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTSET},
     }, {
         .name = "rsr.intset",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTSET},
     }, {
         .name = "rsr.itlbcfg",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ITLBCFG},
     }, {
         .name = "rsr.lbeg",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LBEG},
     }, {
         .name = "rsr.lcount",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LCOUNT},
     }, {
         .name = "rsr.lend",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LEND},
     }, {
         .name = "rsr.litbase",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LITBASE},
     }, {
         .name = "rsr.m0",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR},
     }, {
         .name = "rsr.m1",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR + 1},
     }, {
         .name = "rsr.m2",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR + 2},
     }, {
         .name = "rsr.m3",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR + 3},
     }, {
         .name = "rsr.memctl",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MEMCTL},
     }, {
         .name = "rsr.misc0",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC},
     }, {
         .name = "rsr.misc1",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 1},
     }, {
         .name = "rsr.misc2",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 2},
     }, {
         .name = "rsr.misc3",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 3},
     }, {
         .name = "rsr.prid",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PRID},
     }, {
         .name = "rsr.ps",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PS},
     }, {
         .name = "rsr.ptevaddr",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PTEVADDR},
     }, {
         .name = "rsr.rasid",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){RASID},
     }, {
         .name = "rsr.sar",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){SAR},
     }, {
         .name = "rsr.scompare1",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){SCOMPARE1},
     }, {
         .name = "rsr.vecbase",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){VECBASE},
     }, {
         .name = "rsr.windowbase",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){WINDOW_BASE},
     }, {
         .name = "rsr.windowstart",
         .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){WINDOW_START},
     }, {
         .name = "rsync",
@@ -3827,6 +3970,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "simcall",
         .translate = translate_simcall,
+        .test_ill = test_ill_simcall,
     }, {
         .name = "sll",
         .translate = translate_sll,
@@ -3917,310 +4061,387 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.176",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){176},
     }, {
         .name = "wsr.208",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){208},
     }, {
         .name = "wsr.acchi",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ACCHI},
     }, {
         .name = "wsr.acclo",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ACCLO},
     }, {
         .name = "wsr.atomctl",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ATOMCTL},
     }, {
         .name = "wsr.br",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){BR},
     }, {
         .name = "wsr.cacheattr",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CACHEATTR},
     }, {
         .name = "wsr.ccompare0",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE},
     }, {
         .name = "wsr.ccompare1",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
     }, {
         .name = "wsr.ccompare2",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
     }, {
         .name = "wsr.ccount",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOUNT},
     }, {
         .name = "wsr.configid0",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CONFIGID0},
     }, {
         .name = "wsr.configid1",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CONFIGID1},
     }, {
         .name = "wsr.cpenable",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CPENABLE},
     }, {
         .name = "wsr.dbreaka0",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKA},
     }, {
         .name = "wsr.dbreaka1",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKA + 1},
     }, {
         .name = "wsr.dbreakc0",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKC},
     }, {
         .name = "wsr.dbreakc1",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKC + 1},
     }, {
         .name = "wsr.ddr",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DDR},
     }, {
         .name = "wsr.debugcause",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
     }, {
         .name = "wsr.depc",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DEPC},
     }, {
         .name = "wsr.dtlbcfg",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DTLBCFG},
     }, {
         .name = "wsr.epc1",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1},
     }, {
         .name = "wsr.epc2",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 1},
     }, {
         .name = "wsr.epc3",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 2},
     }, {
         .name = "wsr.epc4",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 3},
     }, {
         .name = "wsr.epc5",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 4},
     }, {
         .name = "wsr.epc6",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 5},
     }, {
         .name = "wsr.epc7",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 6},
     }, {
         .name = "wsr.eps2",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2},
     }, {
         .name = "wsr.eps3",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 1},
     }, {
         .name = "wsr.eps4",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 2},
     }, {
         .name = "wsr.eps5",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 3},
     }, {
         .name = "wsr.eps6",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 4},
     }, {
         .name = "wsr.eps7",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 5},
     }, {
         .name = "wsr.exccause",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCCAUSE},
     }, {
         .name = "wsr.excsave1",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1},
     }, {
         .name = "wsr.excsave2",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
     }, {
         .name = "wsr.excsave3",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
     }, {
         .name = "wsr.excsave4",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
     }, {
         .name = "wsr.excsave5",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
     }, {
         .name = "wsr.excsave6",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
     }, {
         .name = "wsr.excsave7",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
     }, {
         .name = "wsr.excvaddr",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCVADDR},
     }, {
         .name = "wsr.ibreaka0",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKA},
     }, {
         .name = "wsr.ibreaka1",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKA + 1},
     }, {
         .name = "wsr.ibreakenable",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKENABLE},
     }, {
         .name = "wsr.icount",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ICOUNT},
     }, {
         .name = "wsr.icountlevel",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
     }, {
         .name = "wsr.intclear",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTCLEAR},
     }, {
         .name = "wsr.intenable",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTENABLE},
     }, {
         .name = "wsr.interrupt",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTSET},
     }, {
         .name = "wsr.intset",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTSET},
     }, {
         .name = "wsr.itlbcfg",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ITLBCFG},
     }, {
         .name = "wsr.lbeg",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LBEG},
     }, {
         .name = "wsr.lcount",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LCOUNT},
     }, {
         .name = "wsr.lend",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LEND},
     }, {
         .name = "wsr.litbase",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LITBASE},
     }, {
         .name = "wsr.m0",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR},
     }, {
         .name = "wsr.m1",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR + 1},
     }, {
         .name = "wsr.m2",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR + 2},
     }, {
         .name = "wsr.m3",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR + 3},
     }, {
         .name = "wsr.memctl",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MEMCTL},
     }, {
         .name = "wsr.misc0",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC},
     }, {
         .name = "wsr.misc1",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 1},
     }, {
         .name = "wsr.misc2",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 2},
     }, {
         .name = "wsr.misc3",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 3},
     }, {
         .name = "wsr.mmid",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MMID},
     }, {
         .name = "wsr.prid",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PRID},
     }, {
         .name = "wsr.ps",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PS},
     }, {
         .name = "wsr.ptevaddr",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PTEVADDR},
     }, {
         .name = "wsr.rasid",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){RASID},
     }, {
         .name = "wsr.sar",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){SAR},
     }, {
         .name = "wsr.scompare1",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){SCOMPARE1},
     }, {
         .name = "wsr.vecbase",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){VECBASE},
     }, {
         .name = "wsr.windowbase",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_BASE},
     }, {
         .name = "wsr.windowstart",
         .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_START},
     }, {
         .name = "wur.expstate",
@@ -4248,306 +4469,382 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.176",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){176},
     }, {
         .name = "xsr.208",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){208},
     }, {
         .name = "xsr.acchi",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ACCHI},
     }, {
         .name = "xsr.acclo",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ACCLO},
     }, {
         .name = "xsr.atomctl",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ATOMCTL},
     }, {
         .name = "xsr.br",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){BR},
     }, {
         .name = "xsr.cacheattr",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CACHEATTR},
     }, {
         .name = "xsr.ccompare0",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE},
     }, {
         .name = "xsr.ccompare1",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
     }, {
         .name = "xsr.ccompare2",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
     }, {
         .name = "xsr.ccount",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOUNT},
     }, {
         .name = "xsr.configid0",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CONFIGID0},
     }, {
         .name = "xsr.configid1",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CONFIGID1},
     }, {
         .name = "xsr.cpenable",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CPENABLE},
     }, {
         .name = "xsr.dbreaka0",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKA},
     }, {
         .name = "xsr.dbreaka1",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKA + 1},
     }, {
         .name = "xsr.dbreakc0",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKC},
     }, {
         .name = "xsr.dbreakc1",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKC + 1},
     }, {
         .name = "xsr.ddr",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DDR},
     }, {
         .name = "xsr.debugcause",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
     }, {
         .name = "xsr.depc",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DEPC},
     }, {
         .name = "xsr.dtlbcfg",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DTLBCFG},
     }, {
         .name = "xsr.epc1",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1},
     }, {
         .name = "xsr.epc2",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 1},
     }, {
         .name = "xsr.epc3",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 2},
     }, {
         .name = "xsr.epc4",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 3},
     }, {
         .name = "xsr.epc5",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 4},
     }, {
         .name = "xsr.epc6",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 5},
     }, {
         .name = "xsr.epc7",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 6},
     }, {
         .name = "xsr.eps2",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2},
     }, {
         .name = "xsr.eps3",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 1},
     }, {
         .name = "xsr.eps4",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 2},
     }, {
         .name = "xsr.eps5",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 3},
     }, {
         .name = "xsr.eps6",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 4},
     }, {
         .name = "xsr.eps7",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 5},
     }, {
         .name = "xsr.exccause",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCCAUSE},
     }, {
         .name = "xsr.excsave1",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1},
     }, {
         .name = "xsr.excsave2",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
     }, {
         .name = "xsr.excsave3",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
     }, {
         .name = "xsr.excsave4",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
     }, {
         .name = "xsr.excsave5",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
     }, {
         .name = "xsr.excsave6",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
     }, {
         .name = "xsr.excsave7",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
     }, {
         .name = "xsr.excvaddr",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCVADDR},
     }, {
         .name = "xsr.ibreaka0",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKA},
     }, {
         .name = "xsr.ibreaka1",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKA + 1},
     }, {
         .name = "xsr.ibreakenable",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKENABLE},
     }, {
         .name = "xsr.icount",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ICOUNT},
     }, {
         .name = "xsr.icountlevel",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
     }, {
         .name = "xsr.intclear",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTCLEAR},
     }, {
         .name = "xsr.intenable",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTENABLE},
     }, {
         .name = "xsr.interrupt",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTSET},
     }, {
         .name = "xsr.intset",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTSET},
     }, {
         .name = "xsr.itlbcfg",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ITLBCFG},
     }, {
         .name = "xsr.lbeg",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LBEG},
     }, {
         .name = "xsr.lcount",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LCOUNT},
     }, {
         .name = "xsr.lend",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LEND},
     }, {
         .name = "xsr.litbase",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LITBASE},
     }, {
         .name = "xsr.m0",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR},
     }, {
         .name = "xsr.m1",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR + 1},
     }, {
         .name = "xsr.m2",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR + 2},
     }, {
         .name = "xsr.m3",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR + 3},
     }, {
         .name = "xsr.memctl",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MEMCTL},
     }, {
         .name = "xsr.misc0",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC},
     }, {
         .name = "xsr.misc1",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 1},
     }, {
         .name = "xsr.misc2",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 2},
     }, {
         .name = "xsr.misc3",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 3},
     }, {
         .name = "xsr.prid",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PRID},
     }, {
         .name = "xsr.ps",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PS},
     }, {
         .name = "xsr.ptevaddr",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PTEVADDR},
     }, {
         .name = "xsr.rasid",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){RASID},
     }, {
         .name = "xsr.sar",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){SAR},
     }, {
         .name = "xsr.scompare1",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){SCOMPARE1},
     }, {
         .name = "xsr.vecbase",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){VECBASE},
     }, {
         .name = "xsr.windowbase",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_BASE},
     }, {
         .name = "xsr.windowstart",
         .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_START},
     },
 };
-- 
2.11.0
