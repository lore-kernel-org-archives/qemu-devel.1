Received: from eggs.gnu.org ([2001:4830:134:3::10]:47939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpT-00060O-LR
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpJ-0005lU-Uv
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpJ-0005lD-Q6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:38 -0400
Message-Id: <1502149958-23381-23-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 22/22] tcg: remove tb_lock
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

Use mmap_lock in user-mode to protect TCG state and the page
descriptors.
In !user-mode, each vCPU has its own TCG state, so no locks
needed. Per-page locks are used to protect the page descriptors.

Per-TB locks are used in both modes to protect TB jumps.

Some notes:

- tcg_tb_lookup/remove/insert/etc have their own internal lock(s),
  so there is no need to further serialize access to them.

- do_tb_flush is run in a safe async context, meaning no other
  vCPU threads are running. Therefore acquiring mmap_lock there
  is just to please tools such as thread sanitizer.

- Not visible in the diff, but tb_invalidate_phys_page already
  has an assert_memory_lock.

- cpu_io_recompile is !user-only, so no mmap_lock there.

- Added mmap_unlock()'s before all siglongjmp's that could
  be called in user-mode while mmap_lock is held.
  + Added an assert for !have_mmap_lock() after returning from
    the longjmp in cpu_exec, just like we do in cpu_exec_step_atomic.

Performance numbers for the entire series (i.e. since "tcg: enable
multiple TCG contexts in softmmu"):

Host: Intel(R) Xeon(R) CPU E5-2690 0 @ 2.90GHz, 16 2-way cores

- Single-threaded, debian-arm bootup+shutdown (5 runs):
  * Before:
    20.617793812 seconds time elapsed  ( +-  0.73% )
  * After:
    20.713322693 seconds time elapsed  ( +-  0.93% )

- "-smp 8", debian-arm bootup+shutdown (5 runs):
  * Before:
    16.900252299 seconds time elapsed  ( +-  1.30% )
  * After:
    12.777150639 seconds time elapsed  ( +-  1.11% )

- "-smp 16", bootup+shutdown of ubuntu-17.10-ppc64el (5 runs):
  [ NB. The actual times are 27s longer, but I'm subtracting that
    since that's the time it takes on this host to start loading
    the guest kernel (there's grub, etc) ]
  * Before:
    115.382853773 seconds time elapsed ( +-  1.24% )
  * After:
    76.361623367 seconds time elapsed ( +-  0.49% )

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 docs/devel/multi-thread-tcg.txt |  11 ++--
 include/exec/cpu-common.h       |   1 -
 include/exec/exec-all.h         |   4 --
 include/exec/tb-context.h       |   2 -
 tcg/tcg.h                       |   4 +-
 accel/tcg/cpu-exec.c            |  34 +++-------
 accel/tcg/translate-all.c       | 135 ++++++++++++----------------------------
 exec.c                          |  14 ++---
 linux-user/main.c               |   3 -
 9 files changed, 62 insertions(+), 146 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
index 36da1f1..e1e002b 100644
--- a/docs/devel/multi-thread-tcg.txt
+++ b/docs/devel/multi-thread-tcg.txt
@@ -61,6 +61,7 @@ have their block-to-block jumps patched.
 Global TCG State
 ----------------
 
+### User-mode emulation
 We need to protect the entire code generation cycle including any post
 generation patching of the translated code. This also implies a shared
 translation buffer which contains code running on all cores. Any
@@ -75,9 +76,11 @@ patching.
 
 (Current solution)
 
-Mainly as part of the linux-user work all code generation is
-serialised with a tb_lock(). For the SoftMMU tb_lock() also takes the
-place of mmap_lock() in linux-user.
+Code generation is serialised with mmap_lock().
+
+### !User-mode emulation
+Each vCPU has its own TCG context and associated TCG region, thereby
+requiring no locking.
 
 Translation Blocks
 ------------------
@@ -192,7 +195,7 @@ work as "safe work" and exiting the cpu run loop. This ensure by the
 time execution restarts all flush operations have completed.
 
 TLB flag updates are all done atomically and are also protected by the
-tb_lock() which is used by the functions that update the TLB in bulk.
+corresponding page lock.
 
 (Known limitation)
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 74341b1..6f64df0 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -23,7 +23,6 @@ typedef struct CPUListState {
     FILE *file;
 } CPUListState;
 
-/* The CPU list lock nests outside tb_lock/tb_unlock.  */
 void qemu_init_cpu_list(void);
 void cpu_list_lock(void);
 void cpu_list_unlock(void);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 64753a0..bc71014 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -557,10 +557,6 @@ extern uintptr_t tci_tb_ptr;
    smaller than 4 bytes, so we don't worry about special-casing this.  */
 #define GETPC_ADJ   2
 
-void tb_lock(void);
-void tb_unlock(void);
-void tb_lock_reset(void);
-
 #if !defined(CONFIG_USER_ONLY)
 
 struct MemoryRegion *iotlb_to_region(CPUState *cpu,
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index 8c9b49c..feb585e 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -32,8 +32,6 @@ typedef struct TBContext TBContext;
 struct TBContext {
 
     struct qht htable;
-    /* any access to the tbs or the page table must use this lock */
-    QemuMutex tb_lock;
 
     /* statistics */
     unsigned tb_flush_count;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 680df31..cf4eeaf 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -757,7 +757,7 @@ static inline bool tcg_op_buf_full(void)
 
 /* pool based memory allocation */
 
-/* user-mode: tb_lock must be held for tcg_malloc_internal. */
+/* user-mode: mmap_lock must be held for tcg_malloc_internal. */
 void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
@@ -775,7 +775,7 @@ TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);
 void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
 size_t tcg_nb_tbs(void);
 
-/* user-mode: Called with tb_lock held.  */
+/* user-mode: Called with mmap_lock held.  */
 static inline void *tcg_malloc(int size)
 {
     TCGContext *s = tcg_ctx;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 766dcb5..e38479b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -204,22 +204,22 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
     if (max_cycles > CF_COUNT_MASK)
         max_cycles = CF_COUNT_MASK;
 
-    tb_lock();
+    mmap_lock();
     tb = tb_gen_code(cpu, orig_tb->pc, orig_tb->cs_base, orig_tb->flags,
                      max_cycles | CF_NOCACHE
                          | (ignore_icount ? CF_IGNORE_ICOUNT : 0)
                          | curr_cflags());
     tb->orig_tb = orig_tb;
-    tb_unlock();
+    mmap_unlock();
 
     /* execute the generated code */
     trace_exec_tb_nocache(tb, tb->pc);
     cpu_tb_exec(cpu, tb);
 
-    tb_lock();
+    mmap_lock();
     tb_phys_invalidate(tb, -1);
+    mmap_unlock();
     tcg_tb_remove(tb);
-    tb_unlock();
 }
 #endif
 
@@ -236,9 +236,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
         if (tb == NULL) {
             mmap_lock();
-            tb_lock();
             tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
-            tb_unlock();
             mmap_unlock();
         }
 
@@ -255,15 +253,13 @@ void cpu_exec_step_atomic(CPUState *cpu)
 
         end_exclusive();
     } else {
-        /* We may have exited due to another problem here, so we need
-         * to reset any tb_locks we may have taken but didn't release.
+        /*
          * The mmap_lock is dropped by tb_gen_code if it runs out of
          * memory.
          */
 #ifndef CONFIG_SOFTMMU
         tcg_debug_assert(!have_mmap_lock());
 #endif
-        tb_lock_reset();
     }
 }
 
@@ -332,21 +328,12 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
-    bool acquired_tb_lock = false;
     uint32_t cf_mask = curr_cflags();
 
     tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
     if (tb == NULL) {
-        /* mmap_lock is needed by tb_gen_code, and mmap_lock must be
-         * taken outside tb_lock. As system emulation is currently
-         * single threaded the locks are NOPs.
-         */
         mmap_lock();
-        tb_lock();
-        acquired_tb_lock = true;
-
         tb = tb_gen_code(cpu, pc, cs_base, flags, cf_mask);
-
         mmap_unlock();
         /* We add the TB in the virtual pc hash table for the fast lookup */
         atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)], tb);
@@ -362,15 +349,8 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
 #endif
     /* See if we can patch the calling TB. */
     if (last_tb && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
-        if (!acquired_tb_lock) {
-            tb_lock();
-            acquired_tb_lock = true;
-        }
         tb_add_jump(last_tb, tb_exit, tb);
     }
-    if (acquired_tb_lock) {
-        tb_unlock();
-    }
     return tb;
 }
 
@@ -636,7 +616,9 @@ int cpu_exec(CPUState *cpu)
         g_assert(cc == CPU_GET_CLASS(cpu));
 #endif /* buggy compiler */
         cpu->can_do_io = 1;
-        tb_lock_reset();
+#ifndef CONFIG_SOFTMMU
+        tcg_debug_assert(!have_mmap_lock());
+#endif
         if (qemu_mutex_iothread_locked()) {
             qemu_mutex_unlock_iothread();
         }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 863b418..69cc7dc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -89,13 +89,13 @@
 #endif
 
 /* Access to the various translations structures need to be serialised via locks
- * for consistency. This is automatic for SoftMMU based system
- * emulation due to its single threaded nature. In user-mode emulation
- * access to the memory related structures are protected with the
- * mmap_lock.
+ * for consistency.
+ * In user-mode emulation access to the memory related structures are protected
+ * with mmap_lock.
+ * In !user-mode we use per-page locks.
  */
 #ifdef CONFIG_SOFTMMU
-#define assert_memory_lock() tcg_debug_assert(have_tb_lock)
+#define assert_memory_lock()
 #else
 #define assert_memory_lock() tcg_debug_assert(have_mmap_lock())
 #endif
@@ -236,9 +236,6 @@ __thread TCGContext *tcg_ctx;
 TBContext tb_ctx;
 bool parallel_cpus;
 
-/* translation block context */
-static __thread int have_tb_lock;
-
 static void page_table_config_init(void)
 {
     uint32_t v_l1_bits;
@@ -259,31 +256,6 @@ static void page_table_config_init(void)
     assert(v_l2_levels >= 0);
 }
 
-#define assert_tb_locked() tcg_debug_assert(have_tb_lock)
-#define assert_tb_unlocked() tcg_debug_assert(!have_tb_lock)
-
-void tb_lock(void)
-{
-    assert_tb_unlocked();
-    qemu_mutex_lock(&tb_ctx.tb_lock);
-    have_tb_lock++;
-}
-
-void tb_unlock(void)
-{
-    assert_tb_locked();
-    have_tb_lock--;
-    qemu_mutex_unlock(&tb_ctx.tb_lock);
-}
-
-void tb_lock_reset(void)
-{
-    if (have_tb_lock) {
-        qemu_mutex_unlock(&tb_ctx.tb_lock);
-        have_tb_lock = 0;
-    }
-}
-
 void cpu_gen_init(void)
 {
     tcg_context_init(&tcg_init_ctx);
@@ -435,10 +407,9 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t retaddr)
 
     /* A retaddr of zero is invalid so we really shouldn't have ended
      * up here. The target code has likely forgotten to check retaddr
-     * != 0 before attempting to restore state. We return early to
-     * avoid blowing up on a recursive tb_lock(). The target must have
-     * previously survived a failed cpu_restore_state because
-     * tcg_tb_lookup(0) would have failed anyway. It still should be
+     * != 0 before attempting to restore state.
+     * The target must have previously survived a failed cpu_restore_state
+     * because tcg_tb_lookup(0) would have failed anyway. It still should be
      * fixed though.
      */
 
@@ -446,7 +417,6 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t retaddr)
         return r;
     }
 
-    tb_lock();
     tb = tcg_tb_lookup(retaddr);
     if (tb) {
         cpu_restore_state_from_tb(cpu, tb, retaddr);
@@ -457,7 +427,6 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t retaddr)
         }
         r = true;
     }
-    tb_unlock();
 
     return r;
 }
@@ -1046,7 +1015,6 @@ static inline void code_gen_alloc(size_t tb_size)
         fprintf(stderr, "Could not allocate dynamic translator buffer\n");
         exit(1);
     }
-    qemu_mutex_init(&tb_ctx.tb_lock);
 }
 
 static bool tb_cmp(const void *ap, const void *bp)
@@ -1090,14 +1058,12 @@ void tcg_exec_init(unsigned long tb_size)
 /*
  * Allocate a new translation block. Flush the translation buffer if
  * too many translation blocks or too much generated code.
- *
- * Called with tb_lock held.
  */
 static TranslationBlock *tb_alloc(target_ulong pc)
 {
     TranslationBlock *tb;
 
-    assert_tb_locked();
+    assert_memory_lock();
 
     tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(tb == NULL)) {
@@ -1163,8 +1129,7 @@ static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
-    tb_lock();
-
+    mmap_lock();
     /* If it is already been done on request of another CPU,
      * just retry.
      */
@@ -1194,7 +1159,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     atomic_mb_set(&tb_ctx.tb_flush_count, tb_ctx.tb_flush_count + 1);
 
 done:
-    tb_unlock();
+    mmap_unlock();
 }
 
 void tb_flush(CPUState *cpu)
@@ -1228,7 +1193,7 @@ do_tb_invalidate_check(struct qht *ht, void *p, uint32_t hash, void *userp)
 
 /* verify that all the pages have correct rights for code
  *
- * Called with tb_lock held.
+ * Called with mmap_lock held.
  */
 static void tb_invalidate_check(target_ulong address)
 {
@@ -1258,13 +1223,18 @@ static void tb_page_check(void)
 
 #endif /* CONFIG_USER_ONLY */
 
-/* call with @pd->lock held */
+/*
+ * user-mode: call with mmap_lock held
+ * !user-mode: call with @pd->lock held
+ */
 static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
 {
     TranslationBlock *tb1;
     uintptr_t *prev;
     unsigned int n1;
 
+    assert_memory_lock();
+
     page_for_each_tb_safe(pd, tb1, n1, prev) {
         if (tb1 == tb) {
             *prev = tb1->page_next[n1];
@@ -1352,7 +1322,11 @@ static inline void tb_jmp_unlink(TranslationBlock *dest)
     qemu_spin_unlock(&dest->jmp_lock);
 }
 
-/* If @rm_from_page_list is set, call with the TB's pages' locks held */
+/*
+ * In user-mode, call with mmap_lock held.
+ * In !user-mode, if @rm_from_page_list is set, call with the TB's pages'
+ * locks held.
+ */
 static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
 {
     CPUState *cpu;
@@ -1360,7 +1334,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     uint32_t h;
     tb_page_addr_t phys_pc;
 
-    assert_tb_locked();
+    assert_memory_lock();
 
     /* make sure no further incoming jumps will be chained to this TB */
     qemu_spin_lock(&tb->jmp_lock);
@@ -1413,7 +1387,7 @@ static void tb_phys_invalidate__locked(TranslationBlock *tb)
 
 /* invalidate one TB
  *
- * Called with tb_lock held.
+ * Called with mmap_lock held in user-mode.
  */
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
 {
@@ -1457,7 +1431,7 @@ static void build_page_bitmap(PageDesc *p)
 /* add the tb in the target page and protect it if necessary
  *
  * Called with mmap_lock held for user-mode emulation.
- * Called with @p->lock held.
+ * Called with @p->lock held in !user-mode.
  */
 static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
                                unsigned int n, tb_page_addr_t page_addr)
@@ -1720,10 +1694,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if ((pc & TARGET_PAGE_MASK) != virt_page2) {
         phys_page2 = get_page_addr_code(env, virt_page2);
     }
-    /* As long as consistency of the TB stuff is provided by tb_lock in user
-     * mode and is implicit in single-threaded softmmu emulation, no explicit
-     * memory barrier is required before tb_link_page() makes the TB visible
-     * through the physical hash table and physical page list.
+    /*
+     * No explicit memory barrier is required -- tb_link_page() makes the
+     * TB visible in a consistent state.
      */
     existing_tb = tb_link_page(tb, phys_pc, phys_page2);
     /* if the TB already exists, discard what we just translated */
@@ -1739,8 +1712,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 }
 
 /*
- * Call with all @pages locked.
  * @p must be non-NULL.
+ * user-mode: call with mmap_lock held.
+ * !user-mode: call with all @pages locked.
  */
 static void
 tb_invalidate_phys_page_range__locked(struct page_collection *pages,
@@ -1765,7 +1739,6 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
 #endif /* TARGET_HAS_PRECISE_SMC */
 
     assert_memory_lock();
-    assert_tb_locked();
 
 #if defined(TARGET_HAS_PRECISE_SMC)
     if (cpu != NULL) {
@@ -1829,6 +1802,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
         page_collection_unlock(pages);
         tb_gen_code(cpu, current_pc, current_cs_base, current_flags,
                     1 | curr_cflags());
+        mmap_unlock();
         cpu_loop_exit_noexc(cpu);
     }
 #endif
@@ -1841,8 +1815,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
  * access: the virtual CPU will exit the current TB if code is modified inside
  * this TB.
  *
- * Called with tb_lock/mmap_lock held for user-mode emulation
- * Called with tb_lock held for system-mode emulation
+ * Called with mmap_lock held for user-mode emulation
  */
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access)
@@ -1851,7 +1824,6 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
     PageDesc *p;
 
     assert_memory_lock();
-    assert_tb_locked();
 
     p = page_find(start >> TARGET_PAGE_BITS);
     if (p == NULL) {
@@ -1870,14 +1842,15 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
  * access: the virtual CPU will exit the current TB if code is modified inside
  * this TB.
  *
- * Called with mmap_lock held for user-mode emulation, grabs tb_lock
- * Called with tb_lock held for system-mode emulation
+ * Called with mmap_lock held for user-mode emulation.
  */
-static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_addr_t end)
+void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
 {
     struct page_collection *pages;
     tb_page_addr_t next;
 
+    assert_memory_lock();
+
     pages = page_collection_lock(start, end);
     for (next = (start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
          start < end;
@@ -1894,22 +1867,6 @@ static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_addr_t end)
 }
 
 #ifdef CONFIG_SOFTMMU
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
-{
-    assert_tb_locked();
-    tb_invalidate_phys_range_1(start, end);
-}
-#else
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
-{
-    assert_memory_lock();
-    tb_lock();
-    tb_invalidate_phys_range_1(start, end);
-    tb_unlock();
-}
-#endif
-
-#ifdef CONFIG_SOFTMMU
 /* len must be <= 8 and start must be a multiple of len.
  * Called via softmmu_template.h when code areas are written to with
  * iothread mutex not held.
@@ -1985,7 +1942,6 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
         return false;
     }
 
-    tb_lock();
 #ifdef TARGET_HAS_PRECISE_SMC
     if (p->first_tb && pc != 0) {
         current_tb = tcg_tb_lookup(pc);
@@ -2020,12 +1976,9 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
            itself */
         tb_gen_code(cpu, current_pc, current_cs_base, current_flags,
                     1 | curr_cflags());
-        /* tb_lock will be reset after cpu_loop_exit_noexc longjmps
-         * back into the cpu_exec loop. */
         return true;
     }
 #endif
-    tb_unlock();
 
     return false;
 }
@@ -2046,18 +1999,18 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
         return;
     }
     ram_addr = memory_region_get_ram_addr(mr) + addr;
-    tb_lock();
     tb_invalidate_phys_page_range(ram_addr, ram_addr + 1, 0);
-    tb_unlock();
     rcu_read_unlock();
 }
 #endif /* !defined(CONFIG_USER_ONLY) */
 
-/* Called with tb_lock held.  */
+/* user-mode: call with mmap_lock held */
 void tb_check_watchpoint(CPUState *cpu)
 {
     TranslationBlock *tb;
 
+    assert_memory_lock();
+
     tb = tcg_tb_lookup(cpu->mem_io_pc);
     if (tb) {
         /* We can use retranslation to find the PC.  */
@@ -2093,7 +2046,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     target_ulong pc, cs_base;
     uint32_t flags;
 
-    tb_lock();
     tb = tcg_tb_lookup(retaddr);
     if (!tb) {
         cpu_abort(cpu, "cpu_io_recompile: could not find TB for pc=%p",
@@ -2152,9 +2104,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      *  repeating the fault, which is horribly inefficient.
      *  Better would be to execute just this insn uncached, or generate a
      *  second new TB.
-     *
-     * cpu_loop_exit_noexc will longjmp back to cpu_exec where the
-     * tb_lock gets reset.
      */
     cpu_loop_exit_noexc(cpu);
 }
@@ -2253,8 +2202,6 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     struct qht_stats hst;
     size_t nb_tbs;
 
-    tb_lock();
-
     tcg_tb_foreach(tb_tree_stats_iter, &tst);
     nb_tbs = tst.nb_tbs;
     /* XXX: avoid using doubles ? */
@@ -2291,8 +2238,6 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     cpu_fprintf(f, "TB invalidate count %zu\n", tcg_tb_phys_invalidate_count());
     cpu_fprintf(f, "TLB flush count     %zu\n", tlb_flush_count());
     tcg_dump_info(f, cpu_fprintf);
-
-    tb_unlock();
 }
 
 void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
diff --git a/exec.c b/exec.c
index 620a496..eef035a 100644
--- a/exec.c
+++ b/exec.c
@@ -782,9 +782,7 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
     mmap_lock();
-    tb_lock();
     tb_invalidate_phys_page_range(pc, pc + 1, 0);
-    tb_unlock();
     mmap_unlock();
 }
 #else
@@ -2419,18 +2417,16 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                 }
                 cpu->watchpoint_hit = wp;
 
-                /* Both tb_lock and iothread_mutex will be reset when
-                 * cpu_loop_exit or cpu_loop_exit_noexc longjmp
-                 * back into the cpu_exec main loop.
-                 */
-                tb_lock();
+                mmap_lock();
                 tb_check_watchpoint(cpu);
                 if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                     cpu->exception_index = EXCP_DEBUG;
+                    mmap_unlock();
                     cpu_loop_exit(cpu);
                 } else {
                     cpu_get_tb_cpu_state(env, &pc, &cs_base, &cpu_flags);
                     tb_gen_code(cpu, pc, cs_base, cpu_flags, 1 | curr_cflags());
+                    mmap_unlock();
                     cpu_loop_exit_noexc(cpu);
                 }
             }
@@ -2838,9 +2834,9 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
     }
     if (dirty_log_mask & (1 << DIRTY_MEMORY_CODE)) {
         assert(tcg_enabled());
-        tb_lock();
+        mmap_lock();
         tb_invalidate_phys_range(addr, addr + length);
-        tb_unlock();
+        mmap_unlock();
         dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
     }
     cpu_physical_memory_set_dirty_range(addr, length, dirty_log_mask);
diff --git a/linux-user/main.c b/linux-user/main.c
index aab4433..31c8f1a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -114,7 +114,6 @@ int cpu_get_pic_interrupt(CPUX86State *env)
 void fork_start(void)
 {
     cpu_list_lock();
-    qemu_mutex_lock(&tb_ctx.tb_lock);
     mmap_fork_start();
 }
 
@@ -130,11 +129,9 @@ void fork_end(int child)
                 QTAILQ_REMOVE(&cpus, cpu, node);
             }
         }
-        qemu_mutex_init(&tb_ctx.tb_lock);
         qemu_init_cpu_list();
         gdbserver_fork(thread_cpu);
     } else {
-        qemu_mutex_unlock(&tb_ctx.tb_lock);
         cpu_list_unlock();
     }
 }
-- 
2.7.4
