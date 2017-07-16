Received: from eggs.gnu.org ([2001:4830:134:3::10]:46494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmj-0001HX-TW
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmb-0008TW-LB
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmb-0008S5-4b
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:28 -0400
Message-Id: <1500235468-15341-46-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 45/45] tcg: enable multiple TCG contexts in
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

This enables parallel TCG code generation. However, we do not take
advantage of it yet since tb_lock is still held during tb_gen_code.

In user-mode we use a single TCG context; see the documentation
added to tcg_region_init for the rationale.

Note that targets do not need any conversion: targets initialize a
TCGContext (e.g. defining TCG globals), and after this initialization
has finished, the context is cloned by the vCPU threads, each of
them keeping a separate copy.

TCG threads claim one entry in tcg_ctxs[] atomically using cmpxchg.
They also increment n_tcg_ctxs atomically. Do not be too annoyed
by the subsequent atomic_read's of that variable; they are there just
to play nice with analysis tools such as thread sanitizer.

Previous patches folded some TCG globals into TCGContext. The non-const
globals remaining are only set at init time, i.e. before the TCG
threads are spawned. Here is a list of these set-at-init-time globals
under tcg/:

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

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h                 |   7 ++--
 accel/tcg/translate-all.c |   2 +-
 cpus.c                    |   2 +
 linux-user/syscall.c      |   1 +
 tcg/tcg.c                 | 103 ++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 104 insertions(+), 11 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6f6720b..2f7661b 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -745,7 +745,7 @@ struct TCGContext {
 };
 
 extern TCGContext tcg_init_ctx;
-extern TCGContext *tcg_ctx;
+extern __thread TCGContext *tcg_ctx;
 
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
 {
@@ -767,7 +767,7 @@ static inline bool tcg_op_buf_full(void)
 
 /* pool based memory allocation */
 
-/* tb_lock must be held for tcg_malloc_internal. */
+/* user-mode: tb_lock must be held for tcg_malloc_internal. */
 void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
@@ -778,7 +778,7 @@ void tcg_region_reset_all(void);
 size_t tcg_code_size(void);
 size_t tcg_code_capacity(void);
 
-/* Called with tb_lock held.  */
+/* user-mode: Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
 {
     TCGContext *s = tcg_ctx;
@@ -795,6 +795,7 @@ static inline void *tcg_malloc(int size)
 }
 
 void tcg_context_init(TCGContext *s);
+void tcg_register_thread(void);
 void tcg_prologue_init(TCGContext *s);
 void tcg_func_start(TCGContext *s);
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 98aa63e..78457a4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -155,7 +155,7 @@ static void *l1_map[V_L1_MAX_SIZE];
 
 /* code generation context */
 TCGContext tcg_init_ctx;
-TCGContext *tcg_ctx;
+__thread TCGContext *tcg_ctx;
 TBContext tb_ctx;
 bool parallel_cpus;
 
diff --git a/cpus.c b/cpus.c
index 5455819..170071c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1307,6 +1307,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     CPUState *cpu = arg;
 
     rcu_register_thread();
+    tcg_register_thread();
 
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
@@ -1454,6 +1455,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     g_assert(!use_icount);
 
     rcu_register_thread();
+    tcg_register_thread();
 
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 925ae11..1beb11c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6214,6 +6214,7 @@ static void *clone_func(void *arg)
     TaskState *ts;
 
     rcu_register_thread();
+    tcg_register_thread();
     env = info->env;
     cpu = ENV_GET_CPU(env);
     thread_cpu = cpu;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index daec7d1..f56ab44 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -59,6 +59,7 @@
 
 #include "elf.h"
 #include "exec/log.h"
+#include "sysemu/sysemu.h"
 
 /* Forward declarations for functions declared in tcg-target.inc.c and
    used here. */
@@ -325,13 +326,14 @@ static inline bool tcg_region_initial_alloc__locked(TCGContext *s)
 /* Call from a safe-work context */
 void tcg_region_reset_all(void)
 {
+    unsigned int n_ctxs = atomic_read(&n_tcg_ctxs);
     unsigned int i;
 
     qemu_mutex_lock(&region.lock);
     region.current = 0;
     region.n_full = 0;
 
-    for (i = 0; i < n_tcg_ctxs; i++) {
+    for (i = 0; i < n_ctxs; i++) {
         if (unlikely(tcg_region_initial_alloc__locked(tcg_ctxs[i]))) {
             tcg_abort();
         }
@@ -365,6 +367,23 @@ static void tcg_region_set_guard_pages(void)
  * Region partitioning works by splitting code_gen_buffer into separate regions,
  * and then assigning regions to TCG threads so that the threads can translate
  * code in parallel without synchronization.
+ *
+ * In softmmu the number of TCG threads is bounded by smp_cpus, so
+ * tcg_region_init callers must ensure that @n_regions is set so that there will
+ * be at least as many regions as TCG threads.
+ *
+ * User-mode callers must set @n_regions to 0/1, thereby using a single region.
+ * Having multiple regions in user-mode is not supported, since the number of
+ * vCPU threads (recall that each thread spawned by the guest corresponds to
+ * a vCPU thread) is only bounded by the OS, and usually this number is huge
+ * (tens of thousands is not uncommon).  Thus, given this large bound on the
+ * number of vCPU threads and the fact that code_gen_buffer is allocated at
+ * compile-time, we cannot guarantee that the availability of at least one
+ * region per vCPU thread.
+ *
+ * However, this user-mode limitation is unlikely to be a significant problem
+ * in practice. Multi-threaded guests share most if not all of their translated
+ * code, which makes parallel code generation less appealing than in softmmu.
  */
 void tcg_region_init(size_t n_regions)
 {
@@ -398,13 +417,71 @@ void tcg_region_init(size_t n_regions)
     region.buf = buf;
     tcg_region_set_guard_pages();
     qemu_mutex_init(&region.lock);
-    /*
-     * We do not yet support multiple TCG contexts, so do the initial
-     * allocation now.
-     */
+#ifdef CONFIG_USER_ONLY
+    /* In user-mode we support only one ctx, so do the initial allocation now */
     if (unlikely(tcg_region_initial_alloc__locked(tcg_ctx))) {
         tcg_abort();
     }
+#endif
+}
+
+/*
+ * All TCG threads except the parent (i.e. the one that called tcg_context_init
+ * and registered the target's TCG globals) must register with this function
+ * before initiating translation.
+ *
+ * In user-mode we just point tcg_ctx to tcg_init_ctx. See the documentation
+ * of tcg_region_init() for the reasoning behind this.
+ *
+ * In softmmu each caller registers its context in tcg_ctxs[]. Note that in
+ * softmmu tcg_ctxs[] does not track tcg_ctx_init, since the initial context
+ * is not used anymore for translation once this function is called.
+ *
+ * Not tracking tcg_init_ctx in tcg_ctxs[] in softmmu keeps code that iterates
+ * over the array (e.g. tcg_code_size() the same for both softmmu and user-mode.
+ */
+void tcg_register_thread(void)
+{
+#ifdef CONFIG_USER_ONLY
+    tcg_ctx = &tcg_init_ctx;
+#else
+    TCGContext *s = g_malloc(sizeof(*s));
+    int i;
+
+    memcpy(s, &tcg_init_ctx, sizeof(*s));
+    /* tcg_optimize will allocate a new opt_temps array for this ctx */
+    s->opt_temps = NULL;
+
+    /* claim the first free pointer in tcg_ctxs and increment n_tcg_ctxs */
+    for (i = 0; i < smp_cpus; i++) {
+        if (atomic_cmpxchg(&tcg_ctxs[i], NULL, s) == NULL) {
+            unsigned int n;
+
+            n = atomic_fetch_inc(&n_tcg_ctxs);
+            /*
+             * Zero out s->prof in all contexts but the first.
+             * This ensures that we correctly account for the profiling info
+             * generated during initialization, since tcg_init_ctx is not
+             * tracked by the array.
+             */
+            if (n != 0) {
+#ifdef CONFIG_PROFILER
+                memset(&s->prof, 0, sizeof(s->prof));
+#endif
+            }
+            break;
+        }
+    }
+    /* Only vCPU threads can call this function */
+    g_assert(i < smp_cpus);
+
+    tcg_ctx = s;
+    qemu_mutex_lock(&region.lock);
+    if (unlikely(tcg_region_initial_alloc__locked(tcg_ctx))) {
+        tcg_abort();
+    }
+    qemu_mutex_unlock(&region.lock);
+#endif
 }
 
 /*
@@ -416,12 +493,13 @@ void tcg_region_init(size_t n_regions)
  */
 size_t tcg_code_size(void)
 {
+    unsigned int n_ctxs = atomic_read(&n_tcg_ctxs);
     unsigned int i;
     size_t total;
 
     qemu_mutex_lock(&region.lock);
     total = region.n_full * (region.size - TCG_HIGHWATER);
-    for (i = 0; i < n_tcg_ctxs; i++) {
+    for (i = 0; i < n_ctxs; i++) {
         const TCGContext *s = tcg_ctxs[i];
         size_t size;
 
@@ -516,11 +594,21 @@ static GHashTable *helper_table;
 static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
 static void process_op_defs(TCGContext *s);
 
+/*
+ * In user-mode we simply share the init context among threads, since we
+ * use a single region. See the documentation tcg_region_init() for the
+ * reasoning behind this.
+ * In softmmu we will have at most smp_cpus TCG threads.
+ */
 static void tcg_ctxs_init(TCGContext *s)
 {
+#ifdef CONFIG_USER_ONLY
     tcg_ctxs = g_new(TCGContext *, 1);
     tcg_ctxs[0] = s;
     n_tcg_ctxs = 1;
+#else
+    tcg_ctxs = g_new0(TCGContext *, smp_cpus);
+#endif
 }
 
 void tcg_context_init(TCGContext *s)
@@ -2734,9 +2822,10 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
 static inline
 void tcg_profile_snapshot(TCGProfile *prof, bool counters, bool table)
 {
+    unsigned int n_ctxs = atomic_read(&n_tcg_ctxs);
     unsigned int i;
 
-    for (i = 0; i < n_tcg_ctxs; i++) {
+    for (i = 0; i < n_ctxs; i++) {
         const TCGProfile *orig = &tcg_ctxs[i]->prof;
 
         if (counters) {
-- 
2.7.4
