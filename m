Received: from eggs.gnu.org ([2001:4830:134:3::10]:46501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zM-0004S4-Kd
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zF-00031f-Bs
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51035)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-000302-Pi
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:13 -0400
Message-Id: <1499586614-20507-22-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 21/22] tcg: enable per-thread TCG for softmmu
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

This allows us to generate TCG code in parallel. MTTCG already uses
it, although the next commit pushes down a lock to actually
perform parallel generation.

User-mode is kept out of this: contention due to concurrent translation
is more commonly found in full-system mode.

This patch is fairly small due to the preparation work done in previous
patches.

Note that targets do not need any conversion: the TCGContext set up
during initialization (i.e. where globals are set) is then cloned
by the vCPU threads, which also double as TCG threads.

I searched for globals under tcg/ that might have to be converted
to thread-local. I converted the ones that I saw, and I wrote down the
ones that I found are non-const globals that are only set at init-time:

Only written by tcg_context_init:
- indirect_reg_alloc_order
- tcg_op_defs
Only written by tcg_target_init (called from tcg_context_init):
- tcg_target_available_regs
- tcg_target_call_clobber_regs
- arm: arm_arch, use_idiv_instructions
- i386: have_cmov, have_bmi1, have_bmi2, have_lzcnt,
        have_movbe, have_popcnt
- mips: use_movnz_instructions, use_mips32_instructions,
        use_mips32r2_instructions, got_sigill (tcg_target_detect_isa)
- ppc: have_isa_2_06, have_isa_3_00, tb_ret_addr
- s390: tb_ret_addr, s390_facilities
- sparc: qemu_ld_trampoline, qemu_st_trampoline (build_trampolines),
         use_vis3_instructions

Only written by tcg_prologue_init:
- 'struct jit_code_entry one_entry'
- aarch64: tb_ret_addr
- arm: tb_ret_addr
- i386: tb_ret_addr, guest_base_flags
- ia64: tb_ret_addr
- mips: tb_ret_addr, bswap32_addr, bswap32u_addr, bswap64_addr

I was not sure about tci_regs. From code inspection it seems that
they have to be per-thread, so I converted them, but I do not think
anyone has ever tried to get MTTCG working with TCI.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   |  4 +++-
 tcg/tcg.h                 | 12 +++++++++---
 accel/tcg/translate-all.c | 20 +++++++++++++-------
 cpus.c                    |  3 +++
 tcg/optimize.c            |  4 ++--
 tcg/tcg.c                 | 10 ++++++++++
 tcg/tci.c                 |  2 +-
 7 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 673b26d..5334b7a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -47,7 +47,9 @@ void gen_intermediate_code(CPUArchState *env, struct TranslationBlock *tb);
 void restore_state_to_opc(CPUArchState *env, struct TranslationBlock *tb,
                           target_ulong *data);
 
-void cpu_gen_init(void);
+#ifdef CONFIG_SOFTMMU
+void cpu_thread_tcg_init(void);
+#endif
 bool cpu_restore_state(CPUState *cpu, uintptr_t searched_pc);
 
 void QEMU_NORETURN cpu_loop_exit_noexc(CPUState *cpu);
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a767a33..0cc2cab 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -733,7 +733,13 @@ struct TCGContext {
     QSIMPLEQ_ENTRY(TCGContext) entry;
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
@@ -756,7 +762,7 @@ static inline bool tcg_op_buf_full(void)
 
 /* pool based memory allocation */
 
-/* tb_lock must be held for tcg_malloc_internal. */
+/* user-mode: tb_lock must be held for tcg_malloc_internal. */
 void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
@@ -769,7 +775,7 @@ void tcg_region_reset_all(void);
 size_t tcg_code_size(void);
 size_t tcg_code_capacity(void);
 
-/* Called with tb_lock held.  */
+/* user-mode: Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
 {
     TCGContext *s = &tcg_ctx;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ce9d746..17b18a9 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -131,7 +131,7 @@ static int v_l2_levels;
 static void *l1_map[V_L1_MAX_SIZE];
 
 /* code generation context */
-TCGContext tcg_ctx;
+TCG_THREAD TCGContext tcg_ctx;
 TBContext tb_ctx;
 bool parallel_cpus;
 
@@ -185,10 +185,6 @@ void tb_lock_reset(void)
 
 static TranslationBlock *tb_find_pc(uintptr_t tc_ptr);
 
-void cpu_gen_init(void)
-{
-    tcg_context_init(&tcg_ctx); 
-}
 
 /* Encode VAL as a signed leb128 sequence at P.
    Return P incremented past the encoded value.  */
@@ -812,6 +808,17 @@ static inline void code_gen_alloc(size_t tb_size)
 
 #ifdef CONFIG_SOFTMMU
 /*
+ * Threads calling this function must be the TCG threads, i.e. they
+ * have their own tcg_ctx.
+ */
+void cpu_thread_tcg_init(void)
+{
+    tcg_context_clone(&tcg_ctx);
+    tcg_register_thread();
+    tcg_region_init(&tcg_ctx);
+}
+
+/*
  * It is likely that some vCPUs will translate more code than others, so we
  * first try to set more regions than smp_cpus, with those regions being
  * larger than the minimum code_gen_buffer size. If that's not possible we
@@ -858,7 +865,7 @@ static void tb_htable_init(void)
 void tcg_exec_init(unsigned long tb_size)
 {
     tcg_allowed = true;
-    cpu_gen_init();
+    tcg_context_init(&tcg_ctx);
     page_init();
     tb_htable_init();
     code_gen_alloc(tb_size);
@@ -867,7 +874,6 @@ void tcg_exec_init(unsigned long tb_size)
        initialize the prologue now.  */
     tcg_prologue_init(&tcg_ctx);
     code_gen_set_region_size(&tcg_ctx);
-    tcg_region_init(&tcg_ctx);
 #endif
 }
 
diff --git a/cpus.c b/cpus.c
index 14bb8d5..58efc95 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1307,6 +1307,8 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     CPUState *cpu = arg;
 
     rcu_register_thread();
+    /* For single-threaded TCG we just need to initialize one tcg_ctx */
+    cpu_thread_tcg_init();
 
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
@@ -1454,6 +1456,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     g_assert(!use_icount);
 
     rcu_register_thread();
+    cpu_thread_tcg_init();
 
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
diff --git a/tcg/optimize.c b/tcg/optimize.c
index adfc56c..71af19b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -40,8 +40,8 @@ struct tcg_temp_info {
     tcg_target_ulong mask;
 };
 
-static struct tcg_temp_info temps[TCG_MAX_TEMPS];
-static TCGTempSet temps_used;
+static TCG_THREAD struct tcg_temp_info temps[TCG_MAX_TEMPS];
+static TCG_THREAD TCGTempSet temps_used;
 
 static inline bool temp_is_const(TCGArg arg)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 03ebc8c..0ba61ea 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -532,6 +532,11 @@ void tcg_region_reset_all(void)
     region.n_full = 0;
 
     QSIMPLEQ_FOREACH(s, &ctx_list, entry) {
+#ifdef CONFIG_SOFTMMU
+        if (s == tcg_init_ctx) {
+            continue;
+        }
+#endif
         if (unlikely(!tcg_region_alloc__locked(s))) {
             tcg_abort();
         }
@@ -556,6 +561,11 @@ size_t tcg_code_size(void)
     QSIMPLEQ_FOREACH(s, &ctx_list, entry) {
         size_t size;
 
+#ifdef CONFIG_SOFTMMU
+        if (s == tcg_init_ctx) {
+            continue;
+        }
+#endif
         size = atomic_read(&s->code_gen_ptr) - s->code_gen_buffer;
         if (unlikely(size > s->code_gen_buffer_size)) {
             tcg_abort();
diff --git a/tcg/tci.c b/tcg/tci.c
index 4bdc645..d374ddc 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -55,7 +55,7 @@ typedef uint64_t (*helper_function)(tcg_target_ulong, tcg_target_ulong,
                                     tcg_target_ulong);
 #endif
 
-static tcg_target_ulong tci_reg[TCG_TARGET_NB_REGS];
+static TCG_THREAD tcg_target_ulong tci_reg[TCG_TARGET_NB_REGS];
 
 static tcg_target_ulong tci_read_reg(TCGReg index)
 {
-- 
2.7.4
