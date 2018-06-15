Received: from eggs.gnu.org ([2001:4830:134:3::10]:51521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTudn-0000GL-6S
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTudk-0002RH-LJ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:11 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:35222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTudk-0002QY-AS
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:08 -0400
Received: by mail-pg0-x22e.google.com with SMTP id 15-v6so4858774pge.2
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:44:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Jun 2018 09:43:39 -1000
Message-Id: <20180615194354.12489-5-richard.henderson@linaro.org>
In-Reply-To: <20180615194354.12489-1-richard.henderson@linaro.org>
References: <20180615194354.12489-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 04/19] tcg: track TBs with per-region BST's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

This paves the way for enabling scalable parallel generation of TCG code.

Instead of tracking TBs with a single binary search tree (BST), use a
BST for each TCG region, protecting it with a lock. This is as scalable
as it gets, since each TCG thread operates on a separate region.

The core of this change is the introduction of struct tcg_region_tree,
which contains a pointer to a GTree and an associated lock to serialize
accesses to it. We then allocate an array of tcg_region_tree's, adding
the appropriate padding to avoid false sharing based on
qemu_dcache_linesize.

Given a tc_ptr, we first find the corresponding region_tree. This
is done by special-casing the first and last regions first, since they
might be of size != region.size; otherwise we just divide the offset
by region.stride. I was worried about this division (several dozen
cycles of latency), but profiling shows that this is not a fast path.
Note that region.stride is not required to be a power of two; it
is only required to be a multiple of the host's page size.

Note that with this design we can also provide consistent snapshots
about all region trees at once; for instance, tcg_tb_foreach
acquires/releases all region_tree locks before/after iterating over them.
For this reason we now drop tb_lock in dump_exec_info().

As an alternative I considered implementing a concurrent BST, but this
can be tricky to get right, offers no consistent snapshots of the BST,
and performance and scalability-wise I don't think it could ever beat
having separate GTrees, given that our workload is insert-mostly (all
concurrent BST designs I've seen focus, understandably, on making
lookups fast, which comes at the expense of convoluted, non-wait-free
insertions/removals).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   |   1 -
 include/exec/tb-context.h |   1 -
 tcg/tcg.h                 |   6 ++
 accel/tcg/cpu-exec.c      |   2 +-
 accel/tcg/translate-all.c | 101 +++-----------------
 tcg/tcg.c                 | 191 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 213 insertions(+), 89 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8bbea787a9..8d4306ac25 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -405,7 +405,6 @@ static inline uint32_t curr_cflags(void)
          | (use_icount ? CF_USE_ICOUNT : 0);
 }
 
-void tb_remove(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index 1d41202485..d8472c88fb 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -31,7 +31,6 @@ typedef struct TBContext TBContext;
 
 struct TBContext {
 
-    GTree *tb_tree;
     struct qht htable;
     /* any access to the tbs or the page table must use this lock */
     QemuMutex tb_lock;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 509f4d65d2..1e6df1906f 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -866,6 +866,12 @@ void tcg_region_reset_all(void);
 size_t tcg_code_size(void);
 size_t tcg_code_capacity(void);
 
+void tcg_tb_insert(TranslationBlock *tb);
+void tcg_tb_remove(TranslationBlock *tb);
+TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);
+void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
+size_t tcg_nb_tbs(void);
+
 /* user-mode: Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
 {
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6d6c51b686..7570c59f09 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -224,7 +224,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 
     tb_lock();
     tb_phys_invalidate(tb, -1);
-    tb_remove(tb);
+    tcg_tb_remove(tb);
     tb_unlock();
 }
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 1695f8c352..ef841c82cc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -205,8 +205,6 @@ void tb_lock_reset(void)
     }
 }
 
-static TranslationBlock *tb_find_pc(uintptr_t tc_ptr);
-
 void cpu_gen_init(void)
 {
     tcg_context_init(&tcg_init_ctx);
@@ -375,13 +373,13 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
 
     if (check_offset < tcg_init_ctx.code_gen_buffer_size) {
         tb_lock();
-        tb = tb_find_pc(host_pc);
+        tb = tcg_tb_lookup(host_pc);
         if (tb) {
             cpu_restore_state_from_tb(cpu, tb, host_pc, will_exit);
             if (tb->cflags & CF_NOCACHE) {
                 /* one-shot translation, invalidate it immediately */
                 tb_phys_invalidate(tb, -1);
-                tb_remove(tb);
+                tcg_tb_remove(tb);
             }
             r = true;
         }
@@ -728,48 +726,6 @@ static inline void *alloc_code_gen_buffer(void)
 }
 #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
 
-/* compare a pointer @ptr and a tb_tc @s */
-static int ptr_cmp_tb_tc(const void *ptr, const struct tb_tc *s)
-{
-    if (ptr >= s->ptr + s->size) {
-        return 1;
-    } else if (ptr < s->ptr) {
-        return -1;
-    }
-    return 0;
-}
-
-static gint tb_tc_cmp(gconstpointer ap, gconstpointer bp)
-{
-    const struct tb_tc *a = ap;
-    const struct tb_tc *b = bp;
-
-    /*
-     * When both sizes are set, we know this isn't a lookup.
-     * This is the most likely case: every TB must be inserted; lookups
-     * are a lot less frequent.
-     */
-    if (likely(a->size && b->size)) {
-        if (a->ptr > b->ptr) {
-            return 1;
-        } else if (a->ptr < b->ptr) {
-            return -1;
-        }
-        /* a->ptr == b->ptr should happen only on deletions */
-        g_assert(a->size == b->size);
-        return 0;
-    }
-    /*
-     * All lookups have either .size field set to 0.
-     * From the glib sources we see that @ap is always the lookup key. However
-     * the docs provide no guarantee, so we just mark this case as likely.
-     */
-    if (likely(a->size == 0)) {
-        return ptr_cmp_tb_tc(a->ptr, b);
-    }
-    return ptr_cmp_tb_tc(b->ptr, a);
-}
-
 static inline void code_gen_alloc(size_t tb_size)
 {
     tcg_ctx->code_gen_buffer_size = size_code_gen_buffer(tb_size);
@@ -778,7 +734,6 @@ static inline void code_gen_alloc(size_t tb_size)
         fprintf(stderr, "Could not allocate dynamic translator buffer\n");
         exit(1);
     }
-    tb_ctx.tb_tree = g_tree_new(tb_tc_cmp);
     qemu_mutex_init(&tb_ctx.tb_lock);
 }
 
@@ -839,14 +794,6 @@ static TranslationBlock *tb_alloc(target_ulong pc)
     return tb;
 }
 
-/* Called with tb_lock held.  */
-void tb_remove(TranslationBlock *tb)
-{
-    assert_tb_locked();
-
-    g_tree_remove(tb_ctx.tb_tree, &tb->tc);
-}
-
 static inline void invalidate_page_bitmap(PageDesc *p)
 {
 #ifdef CONFIG_SOFTMMU
@@ -911,10 +858,10 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     }
 
     if (DEBUG_TB_FLUSH_GATE) {
-        size_t nb_tbs = g_tree_nnodes(tb_ctx.tb_tree);
+        size_t nb_tbs = tcg_nb_tbs();
         size_t host_size = 0;
 
-        g_tree_foreach(tb_ctx.tb_tree, tb_host_size_iter, &host_size);
+        tcg_tb_foreach(tb_host_size_iter, &host_size);
         printf("qemu: flush code_size=%zu nb_tbs=%zu avg_tb_size=%zu\n",
                tcg_code_size(), nb_tbs, nb_tbs > 0 ? host_size / nb_tbs : 0);
     }
@@ -923,10 +870,6 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
         cpu_tb_jmp_cache_clear(cpu);
     }
 
-    /* Increment the refcount first so that destroy acts as a reset */
-    g_tree_ref(tb_ctx.tb_tree);
-    g_tree_destroy(tb_ctx.tb_tree);
-
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
 
@@ -1406,7 +1349,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      * through the physical hash table and physical page list.
      */
     tb_link_page(tb, phys_pc, phys_page2);
-    g_tree_insert(tb_ctx.tb_tree, &tb->tc, tb);
+    tcg_tb_insert(tb);
     return tb;
 }
 
@@ -1510,7 +1453,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                 current_tb = NULL;
                 if (cpu->mem_io_pc) {
                     /* now we have a real cpu fault */
-                    current_tb = tb_find_pc(cpu->mem_io_pc);
+                    current_tb = tcg_tb_lookup(cpu->mem_io_pc);
                 }
             }
             if (current_tb == tb &&
@@ -1627,7 +1570,7 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
     tb = p->first_tb;
 #ifdef TARGET_HAS_PRECISE_SMC
     if (tb && pc != 0) {
-        current_tb = tb_find_pc(pc);
+        current_tb = tcg_tb_lookup(pc);
     }
     if (cpu != NULL) {
         env = cpu->env_ptr;
@@ -1670,18 +1613,6 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
 }
 #endif
 
-/*
- * Find the TB 'tb' such that
- * tb->tc.ptr <= tc_ptr < tb->tc.ptr + tb->tc.size
- * Return NULL if not found.
- */
-static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
-{
-    struct tb_tc s = { .ptr = (void *)tc_ptr };
-
-    return g_tree_lookup(tb_ctx.tb_tree, &s);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
 {
@@ -1709,7 +1640,7 @@ void tb_check_watchpoint(CPUState *cpu)
 {
     TranslationBlock *tb;
 
-    tb = tb_find_pc(cpu->mem_io_pc);
+    tb = tcg_tb_lookup(cpu->mem_io_pc);
     if (tb) {
         /* We can use retranslation to find the PC.  */
         cpu_restore_state_from_tb(cpu, tb, cpu->mem_io_pc, true);
@@ -1743,7 +1674,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     uint32_t n;
 
     tb_lock();
-    tb = tb_find_pc(retaddr);
+    tb = tcg_tb_lookup(retaddr);
     if (!tb) {
         cpu_abort(cpu, "cpu_io_recompile: could not find TB for pc=%p",
                   (void *)retaddr);
@@ -1782,7 +1713,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
              * cpu_exec_nocache() */
             tb_phys_invalidate(tb->orig_tb, -1);
         }
-        tb_remove(tb);
+        tcg_tb_remove(tb);
     }
 
     /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
@@ -1853,6 +1784,7 @@ static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
 }
 
 struct tb_tree_stats {
+    size_t nb_tbs;
     size_t host_size;
     size_t target_size;
     size_t max_target_size;
@@ -1866,6 +1798,7 @@ static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
     const TranslationBlock *tb = value;
     struct tb_tree_stats *tst = data;
 
+    tst->nb_tbs++;
     tst->host_size += tb->tc.size;
     tst->target_size += tb->size;
     if (tb->size > tst->max_target_size) {
@@ -1889,10 +1822,8 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     struct qht_stats hst;
     size_t nb_tbs;
 
-    tb_lock();
-
-    nb_tbs = g_tree_nnodes(tb_ctx.tb_tree);
-    g_tree_foreach(tb_ctx.tb_tree, tb_tree_stats_iter, &tst);
+    tcg_tb_foreach(tb_tree_stats_iter, &tst);
+    nb_tbs = tst.nb_tbs;
     /* XXX: avoid using doubles ? */
     cpu_fprintf(f, "Translation buffer state:\n");
     /*
@@ -1927,8 +1858,6 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     cpu_fprintf(f, "TB invalidate count %d\n", tb_ctx.tb_phys_invalidate_count);
     cpu_fprintf(f, "TLB flush count     %zu\n", tlb_flush_count());
     tcg_dump_info(f, cpu_fprintf);
-
-    tb_unlock();
 }
 
 void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
@@ -2196,7 +2125,7 @@ int page_unprotect(target_ulong address, uintptr_t pc)
              * set the page to PAGE_WRITE and did the TB invalidate for us.
              */
 #ifdef TARGET_HAS_PRECISE_SMC
-            TranslationBlock *current_tb = tb_find_pc(pc);
+            TranslationBlock *current_tb = tcg_tb_lookup(pc);
             if (current_tb) {
                 current_tb_invalidated = tb_cflags(current_tb) & CF_INVALID;
             }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6eeebe0624..62e3391020 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -135,6 +135,12 @@ static TCGContext **tcg_ctxs;
 static unsigned int n_tcg_ctxs;
 TCGv_env cpu_env = 0;
 
+struct tcg_region_tree {
+    QemuMutex lock;
+    GTree *tree;
+    /* padding to avoid false sharing is computed at run-time */
+};
+
 /*
  * We divide code_gen_buffer into equally-sized "regions" that TCG threads
  * dynamically allocate from as demand dictates. Given appropriate region
@@ -158,6 +164,13 @@ struct tcg_region_state {
 };
 
 static struct tcg_region_state region;
+/*
+ * This is an array of struct tcg_region_tree's, with padding.
+ * We use void * to simplify the computation of region_trees[i]; each
+ * struct is found every tree_size bytes.
+ */
+static void *region_trees;
+static size_t tree_size;
 static TCGRegSet tcg_target_available_regs[TCG_TYPE_COUNT];
 static TCGRegSet tcg_target_call_clobber_regs;
 
@@ -295,6 +308,180 @@ TCGLabel *gen_new_label(void)
 
 #include "tcg-target.inc.c"
 
+/* compare a pointer @ptr and a tb_tc @s */
+static int ptr_cmp_tb_tc(const void *ptr, const struct tb_tc *s)
+{
+    if (ptr >= s->ptr + s->size) {
+        return 1;
+    } else if (ptr < s->ptr) {
+        return -1;
+    }
+    return 0;
+}
+
+static gint tb_tc_cmp(gconstpointer ap, gconstpointer bp)
+{
+    const struct tb_tc *a = ap;
+    const struct tb_tc *b = bp;
+
+    /*
+     * When both sizes are set, we know this isn't a lookup.
+     * This is the most likely case: every TB must be inserted; lookups
+     * are a lot less frequent.
+     */
+    if (likely(a->size && b->size)) {
+        if (a->ptr > b->ptr) {
+            return 1;
+        } else if (a->ptr < b->ptr) {
+            return -1;
+        }
+        /* a->ptr == b->ptr should happen only on deletions */
+        g_assert(a->size == b->size);
+        return 0;
+    }
+    /*
+     * All lookups have either .size field set to 0.
+     * From the glib sources we see that @ap is always the lookup key. However
+     * the docs provide no guarantee, so we just mark this case as likely.
+     */
+    if (likely(a->size == 0)) {
+        return ptr_cmp_tb_tc(a->ptr, b);
+    }
+    return ptr_cmp_tb_tc(b->ptr, a);
+}
+
+static void tcg_region_trees_init(void)
+{
+    size_t i;
+
+    tree_size = ROUND_UP(sizeof(struct tcg_region_tree), qemu_dcache_linesize);
+    region_trees = qemu_memalign(qemu_dcache_linesize, region.n * tree_size);
+    for (i = 0; i < region.n; i++) {
+        struct tcg_region_tree *rt = region_trees + i * tree_size;
+
+        qemu_mutex_init(&rt->lock);
+        rt->tree = g_tree_new(tb_tc_cmp);
+    }
+}
+
+static struct tcg_region_tree *tc_ptr_to_region_tree(void *p)
+{
+    size_t region_idx;
+
+    if (p < region.start_aligned) {
+        region_idx = 0;
+    } else {
+        ptrdiff_t offset = p - region.start_aligned;
+
+        if (offset > region.stride * (region.n - 1)) {
+            region_idx = region.n - 1;
+        } else {
+            region_idx = offset / region.stride;
+        }
+    }
+    return region_trees + region_idx * tree_size;
+}
+
+void tcg_tb_insert(TranslationBlock *tb)
+{
+    struct tcg_region_tree *rt = tc_ptr_to_region_tree(tb->tc.ptr);
+
+    qemu_mutex_lock(&rt->lock);
+    g_tree_insert(rt->tree, &tb->tc, tb);
+    qemu_mutex_unlock(&rt->lock);
+}
+
+void tcg_tb_remove(TranslationBlock *tb)
+{
+    struct tcg_region_tree *rt = tc_ptr_to_region_tree(tb->tc.ptr);
+
+    qemu_mutex_lock(&rt->lock);
+    g_tree_remove(rt->tree, &tb->tc);
+    qemu_mutex_unlock(&rt->lock);
+}
+
+/*
+ * Find the TB 'tb' such that
+ * tb->tc.ptr <= tc_ptr < tb->tc.ptr + tb->tc.size
+ * Return NULL if not found.
+ */
+TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr)
+{
+    struct tcg_region_tree *rt = tc_ptr_to_region_tree((void *)tc_ptr);
+    TranslationBlock *tb;
+    struct tb_tc s = { .ptr = (void *)tc_ptr };
+
+    qemu_mutex_lock(&rt->lock);
+    tb = g_tree_lookup(rt->tree, &s);
+    qemu_mutex_unlock(&rt->lock);
+    return tb;
+}
+
+static void tcg_region_tree_lock_all(void)
+{
+    size_t i;
+
+    for (i = 0; i < region.n; i++) {
+        struct tcg_region_tree *rt = region_trees + i * tree_size;
+
+        qemu_mutex_lock(&rt->lock);
+    }
+}
+
+static void tcg_region_tree_unlock_all(void)
+{
+    size_t i;
+
+    for (i = 0; i < region.n; i++) {
+        struct tcg_region_tree *rt = region_trees + i * tree_size;
+
+        qemu_mutex_unlock(&rt->lock);
+    }
+}
+
+void tcg_tb_foreach(GTraverseFunc func, gpointer user_data)
+{
+    size_t i;
+
+    tcg_region_tree_lock_all();
+    for (i = 0; i < region.n; i++) {
+        struct tcg_region_tree *rt = region_trees + i * tree_size;
+
+        g_tree_foreach(rt->tree, func, user_data);
+    }
+    tcg_region_tree_unlock_all();
+}
+
+size_t tcg_nb_tbs(void)
+{
+    size_t nb_tbs = 0;
+    size_t i;
+
+    tcg_region_tree_lock_all();
+    for (i = 0; i < region.n; i++) {
+        struct tcg_region_tree *rt = region_trees + i * tree_size;
+
+        nb_tbs += g_tree_nnodes(rt->tree);
+    }
+    tcg_region_tree_unlock_all();
+    return nb_tbs;
+}
+
+static void tcg_region_tree_reset_all(void)
+{
+    size_t i;
+
+    tcg_region_tree_lock_all();
+    for (i = 0; i < region.n; i++) {
+        struct tcg_region_tree *rt = region_trees + i * tree_size;
+
+        /* Increment the refcount first so that destroy acts as a reset */
+        g_tree_ref(rt->tree);
+        g_tree_destroy(rt->tree);
+    }
+    tcg_region_tree_unlock_all();
+}
+
 static void tcg_region_bounds(size_t curr_region, void **pstart, void **pend)
 {
     void *start, *end;
@@ -380,6 +567,8 @@ void tcg_region_reset_all(void)
         g_assert(!err);
     }
     qemu_mutex_unlock(&region.lock);
+
+    tcg_region_tree_reset_all();
 }
 
 #ifdef CONFIG_USER_ONLY
@@ -496,6 +685,8 @@ void tcg_region_init(void)
         g_assert(!rc);
     }
 
+    tcg_region_trees_init();
+
     /* In user-mode we support only one ctx, so do the initial allocation now */
 #ifdef CONFIG_USER_ONLY
     {
-- 
2.17.1
