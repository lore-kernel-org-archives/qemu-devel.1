Received: from eggs.gnu.org ([2001:4830:134:3::10]:43358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4q-0007E8-Dy
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4n-000105-Jy
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQg4n-0000zZ-EW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 29 Jun 2017 16:28:28 -0400
Message-Id: <1498768109-4092-7-git-send-email-cota@braap.org>
In-Reply-To: <1498768109-4092-1-git-send-email-cota@braap.org>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 6/7] [XXX] tcg: make TCGContext thread-local for
 softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

This will allow us to generate TCG code in parallel.

User-mode is kept out of this: contention due to concurrent translation
is more commonly found in full-system mode (e.g. booting a many-core guest).

XXX: For now, only convert arm/a64, since these are the only guests that
have proper MTTCG support.

XXX: arm_translate_init needs to be called from a proper place.

XXX: TCG profiling info and statistics are broken by this

XXX: This is calling prologue_init once per vCPU, i.e. each TCGContext
     gets a different prologue/epilogue (all of them with the same
     contents though). Far from ideal, but for an experiment it
     "should" work, right?

XXX: Giving the same amount of code_gen_buffer to each vCPU is certainly
     a bad idea. A "page-like" allocation policy would be better, e.g.
     give chunks of 1MB to each vCPU as they need it. But for now I'm
     just trying to see whether this can ever work.

XXX: After allowing tb_gen_code to run in parallel (see next patch),
     crashes due to races in TCG code are found very quickly with -smp > 1
     (e.g. "tcg/tcg.c:233: tcg_out_label: Assertion `!l->has_value' failed.")
     Note that with -smp 1 it works fine; with smp > 1 I can make it
     fail later with "taskset -c 0", so clearly there is a race going on.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h    |  4 +++-
 target/arm/translate.h     |  8 +++----
 tcg/tcg.h                  | 10 +++++++--
 accel/tcg/translate-all.c  | 56 ++++++++++++++++++++++++++++++++++++++++------
 cpus.c                     |  2 ++
 target/arm/cpu.c           |  4 +++-
 target/arm/translate-a64.c |  6 ++---
 target/arm/translate.c     | 16 ++++++-------
 tcg/i386/tcg-target.inc.c  |  2 +-
 tcg/tcg-common.c           |  2 +-
 tcg/tcg.c                  |  6 ++---
 11 files changed, 85 insertions(+), 31 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index df12338..4b4c143 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -47,7 +47,9 @@ void gen_intermediate_code(CPUArchState *env, struct TranslationBlock *tb);
 void restore_state_to_opc(CPUArchState *env, struct TranslationBlock *tb,
                           target_ulong *data);
 
-void cpu_gen_init(void);
+#ifdef CONFIG_SOFTMMU
+void cpu_gen_init(int cpu_index);
+#endif
 bool cpu_restore_state(CPUState *cpu, uintptr_t searched_pc);
 
 void QEMU_NORETURN cpu_loop_exit_noexc(CPUState *cpu);
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 15d383d..8f04c57 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -76,10 +76,10 @@ typedef struct DisasCompare {
 } DisasCompare;
 
 /* Share the TCG temporaries common between 32 and 64 bit modes.  */
-extern TCGv_env cpu_env;
-extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
-extern TCGv_i64 cpu_exclusive_addr;
-extern TCGv_i64 cpu_exclusive_val;
+extern TCG_THREAD TCGv_env cpu_env;
+extern TCG_THREAD TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
+extern TCG_THREAD TCGv_i64 cpu_exclusive_addr;
+extern TCG_THREAD TCGv_i64 cpu_exclusive_val;
 
 static inline int arm_dc_feature(DisasContext *dc, int feature)
 {
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 3b3359c..01cf21f 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -727,7 +727,13 @@ struct TCGContext {
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
 };
 
-extern TCGContext tcg_ctx;
+#ifdef CONFIG_SOFTMMU
+#define TCG_THREAD __thread
+#else
+#define TCG_THREAD
+#endif
+
+extern TCG_THREAD TCGContext tcg_ctx;
 extern bool parallel_cpus;
 
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
@@ -887,7 +893,7 @@ typedef struct TCGOpDef {
 #endif
 } TCGOpDef;
 
-extern TCGOpDef tcg_op_defs[];
+extern TCG_THREAD TCGOpDef tcg_op_defs[];
 extern const size_t tcg_op_defs_max;
 
 typedef struct TCGTargetOpDef {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2869c79..125b1a8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -58,6 +58,7 @@
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "sysemu/cpus.h"
+#include "sysemu/sysemu.h"
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
@@ -132,9 +133,12 @@ static int v_l2_levels;
 static void *l1_map[V_L1_MAX_SIZE];
 
 /* code generation context */
-TCGContext tcg_ctx;
+TCG_THREAD TCGContext tcg_ctx;
 TBContext tb_ctx;
 bool parallel_cpus;
+#ifdef CONFIG_SOFTMMU
+static TCGContext *tcg_common_ctx;
+#endif
 
 /* translation block context */
 __thread int have_tb_lock;
@@ -186,10 +190,35 @@ void tb_lock_reset(void)
 
 static TranslationBlock *tb_find_pc(uintptr_t tc_ptr);
 
-void cpu_gen_init(void)
+#ifdef CONFIG_SOFTMMU
+
+/* XXX, see below */
+void arm_translate_init(void);
+
+void cpu_gen_init(int cpu_index)
 {
-    tcg_context_init(&tcg_ctx); 
+    uintptr_t addr;
+    size_t size;
+
+    tcg_context_init(&tcg_ctx);
+    size = tcg_common_ctx->code_gen_buffer_size / smp_cpus;
+    assert(!(tcg_common_ctx->code_gen_buffer_size % smp_cpus));
+    addr = (uintptr_t)tcg_common_ctx->code_gen_buffer;
+    addr += size * cpu_index;
+    tcg_ctx.code_gen_buffer = (void *)addr;
+    tcg_ctx.code_gen_buffer_size = size;
+    tcg_prologue_init(&tcg_ctx);
+    /*
+     * XXX find a proper place to init the TCG globals. This should be trivial
+     * once when the "generic translation loop" work is finished.
+     *
+     * Note that initialising the TCG globals (that are __thread variables
+     * in full-system mode) from a *_cpu_initfn is not a viable option, since
+     * this function is called before the vCPU threads are created.
+     */
+    arm_translate_init();
 }
+#endif
 
 /* Encode VAL as a signed leb128 sequence at P.
    Return P incremented past the encoded value.  */
@@ -561,6 +590,18 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
     if (tb_size > MAX_CODE_GEN_BUFFER_SIZE) {
         tb_size = MAX_CODE_GEN_BUFFER_SIZE;
     }
+#ifdef CONFIG_SOFTMMU
+    {
+        size_t per_cpu = tb_size / smp_cpus;
+
+        if (per_cpu < MIN_CODE_GEN_BUFFER_SIZE) {
+            tb_size = MIN_CODE_GEN_BUFFER_SIZE * smp_cpus;
+            per_cpu = MIN_CODE_GEN_BUFFER_SIZE;
+        }
+        /* make sure tb_size divides smp_cpus evenly */
+        tb_size = per_cpu * smp_cpus;
+    }
+#endif
     return tb_size;
 }
 
@@ -810,20 +851,21 @@ static void tb_htable_init(void)
    size. */
 void tcg_exec_init(unsigned long tb_size)
 {
-    cpu_gen_init();
     page_init();
     tb_htable_init();
     code_gen_alloc(tb_size);
 #if defined(CONFIG_SOFTMMU)
-    /* There's no guest base to take into account, so go ahead and
-       initialize the prologue now.  */
-    tcg_prologue_init(&tcg_ctx);
+    tcg_common_ctx = &tcg_ctx;
 #endif
 }
 
 bool tcg_enabled(void)
 {
+#ifdef CONFIG_SOFTMMU
+    return tcg_common_ctx->code_gen_buffer != NULL;
+#else
     return tcg_ctx.code_gen_buffer != NULL;
+#endif
 }
 
 /*
diff --git a/cpus.c b/cpus.c
index 14bb8d5..1a5437b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1307,6 +1307,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     CPUState *cpu = arg;
 
     rcu_register_thread();
+    cpu_gen_init(cpu->cpu_index);
 
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
@@ -1454,6 +1455,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     g_assert(!use_icount);
 
     rcu_register_thread();
+    cpu_gen_init(cpu->cpu_index);
 
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 28a9141..43948ef 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -469,7 +469,7 @@ static void arm_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
     ARMCPU *cpu = ARM_CPU(obj);
-    static bool inited;
+    static bool inited __attribute__((unused));
 
     cs->env_ptr = &cpu->env;
     cpu->cp_regs = g_hash_table_new_full(g_int_hash, g_int_equal,
@@ -511,10 +511,12 @@ static void arm_cpu_initfn(Object *obj)
 
     if (tcg_enabled()) {
         cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
+#ifndef CONFIG_SOFTMMU
         if (!inited) {
             inited = true;
             arm_translate_init();
         }
+#endif
     }
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e55547d..9450551 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -36,11 +36,11 @@
 
 #include "trace-tcg.h"
 
-static TCGv_i64 cpu_X[32];
-static TCGv_i64 cpu_pc;
+static TCG_THREAD TCGv_i64 cpu_X[32];
+static TCG_THREAD TCGv_i64 cpu_pc;
 
 /* Load/store exclusive handling */
-static TCGv_i64 cpu_exclusive_high;
+static TCG_THREAD TCGv_i64 cpu_exclusive_high;
 static TCGv_i64 cpu_reg(DisasContext *s, int reg);
 
 static const char *regnames[] = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0862f9e..9ad4bbb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -58,17 +58,17 @@
 #define IS_USER(s) (s->user)
 #endif
 
-TCGv_env cpu_env;
+TCG_THREAD TCGv_env cpu_env;
 /* We reuse the same 64-bit temporaries for efficiency.  */
-static TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
-static TCGv_i32 cpu_R[16];
-TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
-TCGv_i64 cpu_exclusive_addr;
-TCGv_i64 cpu_exclusive_val;
+static TCG_THREAD TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
+static TCG_THREAD TCGv_i32 cpu_R[16];
+TCG_THREAD TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
+TCG_THREAD TCGv_i64 cpu_exclusive_addr;
+TCG_THREAD TCGv_i64 cpu_exclusive_val;
 
 /* FIXME:  These should be removed.  */
-static TCGv_i32 cpu_F0s, cpu_F1s;
-static TCGv_i64 cpu_F0d, cpu_F1d;
+static TCG_THREAD TCGv_i32 cpu_F0s, cpu_F1s;
+static TCG_THREAD TCGv_i64 cpu_F0d, cpu_F1d;
 
 #include "exec/gen-icount.h"
 
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 01e3b4e..608264a 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -146,7 +146,7 @@ static bool have_lzcnt;
 # define have_lzcnt 0
 #endif
 
-static tcg_insn_unit *tb_ret_addr;
+static TCG_THREAD tcg_insn_unit *tb_ret_addr;
 
 static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 2f139de..7f6edb8 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -31,7 +31,7 @@
 uintptr_t tci_tb_ptr;
 #endif
 
-TCGOpDef tcg_op_defs[] = {
+TCG_THREAD TCGOpDef tcg_op_defs[] = {
 #define DEF(s, oargs, iargs, cargs, flags) \
          { #s, oargs, iargs, cargs, iargs + oargs + cargs, flags },
 #include "tcg-opc.h"
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3559829..326c25a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -117,8 +117,8 @@ static bool tcg_out_tb_finalize(TCGContext *s);
 
 
 
-static TCGRegSet tcg_target_available_regs[2];
-static TCGRegSet tcg_target_call_clobber_regs;
+static TCG_THREAD TCGRegSet tcg_target_available_regs[2];
+static TCG_THREAD TCGRegSet tcg_target_call_clobber_regs;
 
 #if TCG_TARGET_INSN_UNIT_SIZE == 1
 static __attribute__((unused)) inline void tcg_out8(TCGContext *s, uint8_t v)
@@ -320,7 +320,7 @@ static const TCGHelperInfo all_helpers[] = {
 #include "exec/helper-tcg.h"
 };
 
-static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
+static TCG_THREAD int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
 static void process_op_defs(TCGContext *s);
 
 void tcg_context_init(TCGContext *s)
-- 
2.7.4
