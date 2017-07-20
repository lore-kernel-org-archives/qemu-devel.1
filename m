Received: from eggs.gnu.org ([2001:4830:134:3::10]:60444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qV-0001CG-7S
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qO-0005xc-1Q
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qN-0005x0-Px
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:09:29 -0400
Message-Id: <1500520169-23367-44-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 43/43] tcg: enable multiple TCG contexts in
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

TCG threads claim one entry in tcg_ctxs[] by atomically increasing
n_tcg_ctxs. Do not be too annoyed by the subsequent atomic_read's
of that variable; they are there just to play nice with analysis
tools such as thread sanitizer.

Note that we do not allocate an array of contexts (we allocate
an array of pointers instead) because when tcg_context_init
is called, we do not know yet how many contexts we'll use since
the bool behind qemu_tcg_mttcg_enabled() isn't set yet.

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
 tcg/tcg.h                 |   7 ++-
 accel/tcg/translate-all.c |   2 +-
 cpus.c                    |   2 +
 linux-user/syscall.c      |   1 +
 tcg/tcg.c                 | 141 ++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 143 insertions(+), 10 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 3365da8..68cd14e 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -733,7 +733,7 @@ struct TCGContext {
 };
 
 extern TCGContext tcg_init_ctx;
-extern TCGContext *tcg_ctx;
+extern __thread TCGContext *tcg_ctx;
 
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
 {
@@ -755,7 +755,7 @@ static inline bool tcg_op_buf_full(void)
 
 /* pool based memory allocation */
 
-/* tb_lock must be held for tcg_malloc_internal. */
+/* user-mode: tb_lock must be held for tcg_malloc_internal. */
 void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
@@ -766,7 +766,7 @@ void tcg_region_reset_all(void);
 size_t tcg_code_size(void);
 size_t tcg_code_capacity(void);
 
-/* Called with tb_lock held.  */
+/* user-mode: Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
 {
     TCGContext *s = tcg_ctx;
@@ -783,6 +783,7 @@ static inline void *tcg_malloc(int size)
 }
 
 void tcg_context_init(TCGContext *s);
+void tcg_register_thread(void);
 void tcg_prologue_init(TCGContext *s);
 void tcg_func_start(TCGContext *s);
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 623b9e7..2e810b9 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -154,7 +154,7 @@ static void *l1_map[V_L1_MAX_SIZE];
 
 /* code generation context */
 TCGContext tcg_init_ctx;
-TCGContext *tcg_ctx;
+__thread TCGContext *tcg_ctx;
 TBContext tb_ctx;
 bool parallel_cpus;
 
diff --git a/cpus.c b/cpus.c
index 6022d40..74ddd49 100644
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
index 003943b..bbf7913 100644
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
index 22a949f..a5c01be 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -58,6 +58,7 @@
 
 #include "elf.h"
 #include "exec/log.h"
+#include "sysemu/sysemu.h"
 
 /* Forward declarations for functions declared in tcg-target.inc.c and
    used here. */
@@ -324,13 +325,14 @@ static inline bool tcg_region_initial_alloc__locked(TCGContext *s)
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
         bool err = tcg_region_initial_alloc__locked(tcg_ctxs[i]);
 
         g_assert(!err);
@@ -338,11 +340,71 @@ void tcg_region_reset_all(void)
     qemu_mutex_unlock(&region.lock);
 }
 
+#ifdef CONFIG_SOFTMMU
+/*
+ * It is likely that some vCPUs will translate more code than others, so we
+ * first try to set more regions than smp_cpus, with those regions being of
+ * reasonable size. If that's not possible we make do by evenly dividing
+ * the code_gen_buffer among the vCPUs.
+ */
+static size_t tcg_n_regions(void)
+{
+    size_t i;
+
+    /* Use a single region if all we have is one vCPU thread */
+    if (smp_cpus == 1 || !qemu_tcg_mttcg_enabled()) {
+        return 1;
+    }
+
+    /* Try to have more regions than smp_cpus, with each region being >= 2 MB */
+    for (i = 8; i > 0; i--) {
+        size_t regions_per_thread = i;
+        size_t region_size;
+
+        region_size = tcg_init_ctx.code_gen_buffer_size;
+        region_size /= smp_cpus * regions_per_thread;
+
+        if (region_size >= 2 * 1024u * 1024) {
+            return smp_cpus * regions_per_thread;
+        }
+    }
+    /* If we can't, then just allocate one region per vCPU thread */
+    return smp_cpus;
+}
+#else /* user-mode */
+static size_t tcg_n_regions(void)
+{
+    return 1;
+}
+#endif
+
 /*
  * Initializes region partitioning.
  *
  * Called at init time from the parent thread (i.e. the one calling
  * tcg_context_init), after the target's TCG globals have been set.
+ *
+ * Region partitioning works by splitting code_gen_buffer into separate regions,
+ * and then assigning regions to TCG threads so that the threads can translate
+ * code in parallel without synchronization.
+ *
+ * In softmmu the number of TCG threads is bounded by smp_cpus, so we use at
+ * least smp_cpus regions in MTTCG. In !MTTCG we use a single region.
+ * Note that the TCG options from the command-line (i.e. -accel accel=tcg,[...])
+ * must have been parsed before calling this function, since it calls
+ * qemu_tcg_mttcg_enabled().
+ *
+ * In user-mode we use a single region.  Having multiple regions in user-mode
+ * is not supported, because the number of vCPU threads (recall that each thread
+ * spawned by the guest corresponds to a vCPU thread) is only bounded by the
+ * OS, and usually this number is huge (tens of thousands is not uncommon).
+ * Thus, given this large bound on the number of vCPU threads and the fact
+ * that code_gen_buffer is allocated at compile-time, we cannot guarantee
+ * that the availability of at least one region per vCPU thread.
+ *
+ * However, this user-mode limitation is unlikely to be a significant problem
+ * in practice. Multi-threaded guests share most if not all of their translated
+ * code, which makes parallel code generation less appealing than in softmmu.
  */
 void tcg_region_init(void)
 {
@@ -352,8 +414,7 @@ void tcg_region_init(void)
     size_t n_regions;
     size_t i;
 
-    /* We do not yet support multiple TCG contexts, so use one region for now */
-    n_regions = 1;
+    n_regions = tcg_n_regions();
 
     /* start on a page-aligned address */
     buf = QEMU_ALIGN_PTR_UP(buf, qemu_real_host_page_size);
@@ -387,13 +448,69 @@ void tcg_region_init(void)
         g_assert(!rc);
     }
 
-    /* We do not yet support multiple TCG contexts so allocate the region now */
+    /* In user-mode we support only one ctx, so do the initial allocation now */
+#ifdef CONFIG_USER_ONLY
     {
         bool err = tcg_region_initial_alloc__locked(tcg_ctx);
 
         g_assert(!err);
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
+#ifdef CONFIG_USER_ONLY
+void tcg_register_thread(void)
+{
+    tcg_ctx = &tcg_init_ctx;
+}
+#else
+void tcg_register_thread(void)
+{
+    TCGContext *s = g_malloc(sizeof(*s));
+    unsigned int n;
+    bool err;
+
+    memcpy(s, &tcg_init_ctx, sizeof(*s));
+
+    /* claim an entry in tcg_ctxs */
+    n = atomic_fetch_inc(&n_tcg_ctxs);
+    g_assert(n < smp_cpus);
+    tcg_ctxs[n] = s;
+
+    /*
+     * Zero out s->prof in all contexts but the first.
+     * This ensures that we correctly account for the profiling info
+     * generated during initialization, since tcg_init_ctx is not
+     * tracked by the array.
+     */
+    if (n != 0) {
+#ifdef CONFIG_PROFILER
+        memset(&s->prof, 0, sizeof(s->prof));
+#endif
+    }
+
+    tcg_ctx = s;
+    qemu_mutex_lock(&region.lock);
+    err = tcg_region_initial_alloc__locked(tcg_ctx);
+    g_assert(!err);
+    qemu_mutex_unlock(&region.lock);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 /*
  * Returns the size (in bytes) of all translated code (i.e. from all regions)
@@ -404,12 +521,13 @@ void tcg_region_init(void)
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
 
@@ -561,8 +679,18 @@ void tcg_context_init(TCGContext *s)
     }
 
     tcg_ctx = s;
+    /*
+     * In user-mode we simply share the init context among threads, since we
+     * use a single region. See the documentation tcg_region_init() for the
+     * reasoning behind this.
+     * In softmmu we will have at most smp_cpus TCG threads.
+     */
+#ifdef CONFIG_USER_ONLY
     tcg_ctxs = &tcg_ctx;
     n_tcg_ctxs = 1;
+#else
+    tcg_ctxs = g_new(TCGContext *, smp_cpus);
+#endif
 }
 
 /*
@@ -2714,9 +2842,10 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
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
