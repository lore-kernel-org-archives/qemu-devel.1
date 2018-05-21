Received: from eggs.gnu.org ([2001:4830:134:3::10]:57954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOy-0002hx-8N
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOr-0005ZL-D2
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fKuOq-0005Y9-W6
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:33 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 21 May 2018 19:39:27 -0400
Message-Id: <1526945967-9687-18-git-send-email-cota@braap.org>
In-Reply-To: <1526945967-9687-1-git-send-email-cota@braap.org>
References: <1526945967-9687-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 17/17] tcg: remove tb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Use mmap_lock in user-mode to protect TCG state and the page
descriptors.
In !user-mode, each vCPU has its own TCG state, so no locks
needed. Per-page locks are used to protect the page descriptors.

Per-TB locks are used in both modes to protect TB jumps.

Some notes:

- tb_lock is removed from notdirty_mem_write by passing a
  locked page_collection to tb_invalidate_phys_page_fast.

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

Performance numbers before/after:

Host: AMD Opteron(tm) Processor 6376

                 ubuntu 17.04 ppc64 bootup+shutdown time

  700 +-+--+----+------+------------+-----------+------------*--+-+
      |    +    +      +            +           +           *B    |
      |         before ***B***                            ** *    |
      |tb lock removal ###D###                         ***        |
  600 +-+                                           ***         +-+
      |                                           **         #    |
      |                                        *B*          #D    |
      |                                     *** *         ##      |
  500 +-+                                ***           ###      +-+
      |                             * ***           ###           |
      |                            *B*          # ##              |
      |                          ** *          #D#                |
  400 +-+                      **            ##                 +-+
      |                      **           ###                     |
      |                    **           ##                        |
      |                  **         # ##                          |
  300 +-+  *           B*          #D#                          +-+
      |    B         ***        ###                               |
      |    *       **       ####                                  |
      |     *   ***      ###                                      |
  200 +-+   B  *B     #D#                                       +-+
      |     #B* *   ## #                                          |
      |     #*    ##                                              |
      |    + D##D#     +            +           +            +    |
  100 +-+--+----+------+------------+-----------+------------+--+-+
           1    8      16      Guest CPUs       48           64
  png: https://imgur.com/HwmBHXe

              debian jessie aarch64 bootup+shutdown time

  90 +-+--+-----+-----+------------+------------+------------+--+-+
     |    +     +     +            +            +            +    |
     |         before ***B***                                B    |
  80 +tb lock removal ###D###                              **D  +-+
     |                                                   **###    |
     |                                                 **##       |
  70 +-+                                             ** #       +-+
     |                                             ** ##          |
     |                                           **  #            |
  60 +-+                                       *B  ##           +-+
     |                                       **  ##               |
     |                                    ***  #D                 |
  50 +-+                               ***   ##                 +-+
     |                             * **   ###                     |
     |                           **B*  ###                        |
  40 +-+                     ****  # ##                         +-+
     |                   ****     #D#                             |
     |             ***B**      ###                                |
  30 +-+    B***B**        ####                                 +-+
     |    B *   *     # ###                                       |
     |     B       ###D#                                          |
  20 +-+   D  ##D##                                             +-+
     |      D#                                                    |
     |    +     +     +            +            +            +    |
  10 +-+--+-----+-----+------------+------------+------------+--+-+
          1     8     16      Guest CPUs        48           64
  png: https://imgur.com/iGpGFtv

The gains are high for 4-8 CPUs. Beyond that point, however, unrelated
lock contention significantly hurts scalability.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 docs/devel/multi-thread-tcg.txt |  11 ++--
 accel/tcg/translate-all.h       |   3 +-
 include/exec/cpu-common.h       |   2 +-
 include/exec/exec-all.h         |   4 --
 include/exec/memory-internal.h  |   6 +-
 include/exec/tb-context.h       |   2 -
 tcg/tcg.h                       |   4 +-
 accel/tcg/cpu-exec.c            |  34 +++--------
 accel/tcg/translate-all.c       | 132 ++++++++++++----------------------------
 exec.c                          |  25 +++-----
 linux-user/main.c               |   3 -
 11 files changed, 74 insertions(+), 152 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
index df83445..06530be 100644
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
@@ -195,7 +198,7 @@ work as "safe work" and exiting the cpu run loop. This ensure by the
 time execution restarts all flush operations have completed.
 
 TLB flag updates are all done atomically and are also protected by the
-tb_lock() which is used by the functions that update the TLB in bulk.
+corresponding page lock.
 
 (Known limitation)
 
diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 6d1d258..e6cb963 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -26,7 +26,8 @@
 struct page_collection *page_collection_lock(tb_page_addr_t start,
                                              tb_page_addr_t end);
 void page_collection_unlock(struct page_collection *set);
-void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len);
+void tb_invalidate_phys_page_fast(struct page_collection *pages,
+                                  tb_page_addr_t start, int len);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access);
 void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end);
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 24d335f..46b3be5 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -23,7 +23,7 @@ typedef struct CPUListState {
     FILE *file;
 } CPUListState;
 
-/* The CPU list lock nests outside tb_lock/tb_unlock.  */
+/* The CPU list lock nests outside page_(un)lock or mmap_(un)lock */
 void qemu_init_cpu_list(void);
 void cpu_list_lock(void);
 void cpu_list_unlock(void);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index daac968..9ad159a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -439,10 +439,6 @@ extern uintptr_t tci_tb_ptr;
    smaller than 4 bytes, so we don't worry about special-casing this.  */
 #define GETPC_ADJ   2
 
-void tb_lock(void);
-void tb_unlock(void);
-void tb_lock_reset(void);
-
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_DEBUG_TCG)
 void assert_no_pages_locked(void);
 #else
diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 58399b9..93a1ec2 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -48,6 +48,8 @@ void mtree_print_dispatch(fprintf_function mon, void *f,
                           struct AddressSpaceDispatch *d,
                           MemoryRegion *root);
 
+struct page_collection;
+
 /* Opaque struct for passing info from memory_notdirty_write_prepare()
  * to memory_notdirty_write_complete(). Callers should treat all fields
  * as private, with the exception of @active.
@@ -59,10 +61,10 @@ void mtree_print_dispatch(fprintf_function mon, void *f,
  */
 typedef struct {
     CPUState *cpu;
+    struct page_collection *pages;
     ram_addr_t ram_addr;
     vaddr mem_vaddr;
     unsigned size;
-    bool locked;
     bool active;
 } NotDirtyInfo;
 
@@ -90,7 +92,7 @@ typedef struct {
  *
  * This must only be called if we are using TCG; it will assert otherwise.
  *
- * We may take a lock in the prepare call, so callers must ensure that
+ * We may take locks in the prepare call, so callers must ensure that
  * they don't exit (via longjump or otherwise) without calling complete.
  *
  * This call must only be made inside an RCU critical section.
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
index ec8027b..2fccd20 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -857,7 +857,7 @@ static inline bool tcg_op_buf_full(void)
 
 /* pool based memory allocation */
 
-/* user-mode: tb_lock must be held for tcg_malloc_internal. */
+/* user-mode: mmap_lock must be held for tcg_malloc_internal. */
 void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
@@ -875,7 +875,7 @@ TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);
 void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
 size_t tcg_nb_tbs(void);
 
-/* user-mode: Called with tb_lock held.  */
+/* user-mode: Called with mmap_lock held.  */
 static inline void *tcg_malloc(int size)
 {
     TCGContext *s = tcg_ctx;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c9db99d..f86d9cb 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -213,20 +213,20 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
        We only end up here when an existing TB is too long.  */
     cflags |= MIN(max_cycles, CF_COUNT_MASK);
 
-    tb_lock();
+    mmap_lock();
     tb = tb_gen_code(cpu, orig_tb->pc, orig_tb->cs_base,
                      orig_tb->flags, cflags);
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
 
@@ -245,9 +245,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
         if (tb == NULL) {
             mmap_lock();
-            tb_lock();
             tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
-            tb_unlock();
             mmap_unlock();
         }
 
@@ -262,15 +260,13 @@ void cpu_exec_step_atomic(CPUState *cpu)
         cpu_tb_exec(cpu, tb);
         cc->cpu_exec_exit(cpu);
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
         assert_no_pages_locked();
     }
 
@@ -399,20 +395,11 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
-    bool acquired_tb_lock = false;
 
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
@@ -428,15 +415,8 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
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
 
@@ -711,7 +691,9 @@ int cpu_exec(CPUState *cpu)
         g_assert(cpu == current_cpu);
         g_assert(cc == CPU_GET_CLASS(cpu));
 #endif /* buggy compiler */
-        tb_lock_reset();
+#ifndef CONFIG_SOFTMMU
+        tcg_debug_assert(!have_mmap_lock());
+#endif
         if (qemu_mutex_iothread_locked()) {
             qemu_mutex_unlock_iothread();
         }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 6cc7b94..9d76ec0 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -88,13 +88,13 @@
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
@@ -216,9 +216,6 @@ __thread TCGContext *tcg_ctx;
 TBContext tb_ctx;
 bool parallel_cpus;
 
-/* translation block context */
-static __thread int have_tb_lock;
-
 static void page_table_config_init(void)
 {
     uint32_t v_l1_bits;
@@ -239,31 +236,6 @@ static void page_table_config_init(void)
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
@@ -420,8 +392,7 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
      *  - fault during translation (instruction fetch)
      *  - fault from helper (not using GETPC() macro)
      *
-     * Either way we need return early to avoid blowing up on a
-     * recursive tb_lock() as we can't resolve it here.
+     * Either way we need return early as we can't resolve it here.
      *
      * We are using unsigned arithmetic so if host_pc <
      * tcg_init_ctx.code_gen_buffer check_offset will wrap to way
@@ -430,7 +401,6 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
     check_offset = host_pc - (uintptr_t) tcg_init_ctx.code_gen_buffer;
 
     if (check_offset < tcg_init_ctx.code_gen_buffer_size) {
-        tb_lock();
         tb = tcg_tb_lookup(host_pc);
         if (tb) {
             cpu_restore_state_from_tb(cpu, tb, host_pc, will_exit);
@@ -441,7 +411,6 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
             }
             r = true;
         }
-        tb_unlock();
     }
 
     return r;
@@ -1129,7 +1098,6 @@ static inline void code_gen_alloc(size_t tb_size)
         fprintf(stderr, "Could not allocate dynamic translator buffer\n");
         exit(1);
     }
-    qemu_mutex_init(&tb_ctx.tb_lock);
 }
 
 static bool tb_cmp(const void *ap, const void *bp)
@@ -1173,14 +1141,12 @@ void tcg_exec_init(unsigned long tb_size)
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
@@ -1247,8 +1213,7 @@ static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
-    tb_lock();
-
+    mmap_lock();
     /* If it is already been done on request of another CPU,
      * just retry.
      */
@@ -1278,7 +1243,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     atomic_mb_set(&tb_ctx.tb_flush_count, tb_ctx.tb_flush_count + 1);
 
 done:
-    tb_unlock();
+    mmap_unlock();
 }
 
 void tb_flush(CPUState *cpu)
@@ -1312,7 +1277,7 @@ do_tb_invalidate_check(struct qht *ht, void *p, uint32_t hash, void *userp)
 
 /* verify that all the pages have correct rights for code
  *
- * Called with tb_lock held.
+ * Called with mmap_lock held.
  */
 static void tb_invalidate_check(target_ulong address)
 {
@@ -1342,7 +1307,10 @@ static void tb_page_check(void)
 
 #endif /* CONFIG_USER_ONLY */
 
-/* call with @pd->lock held */
+/*
+ * user-mode: call with mmap_lock held
+ * !user-mode: call with @pd->lock held
+ */
 static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
 {
     TranslationBlock *tb1;
@@ -1436,7 +1404,11 @@ static inline void tb_jmp_unlink(TranslationBlock *dest)
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
@@ -1444,7 +1416,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     uint32_t h;
     tb_page_addr_t phys_pc;
 
-    assert_tb_locked();
+    assert_memory_lock();
 
     /* make sure no further incoming jumps will be chained to this TB */
     qemu_spin_lock(&tb->jmp_lock);
@@ -1497,7 +1469,7 @@ static void tb_phys_invalidate__locked(TranslationBlock *tb)
 
 /* invalidate one TB
  *
- * Called with tb_lock held.
+ * Called with mmap_lock held in user-mode.
  */
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
 {
@@ -1542,7 +1514,7 @@ static void build_page_bitmap(PageDesc *p)
 /* add the tb in the target page and protect it if necessary
  *
  * Called with mmap_lock held for user-mode emulation.
- * Called with @p->lock held.
+ * Called with @p->lock held in !user-mode.
  */
 static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
                                unsigned int n, tb_page_addr_t page_addr)
@@ -1814,10 +1786,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
@@ -1833,8 +1804,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 }
 
 /*
- * Call with all @pages locked.
  * @p must be non-NULL.
+ * user-mode: call with mmap_lock held.
+ * !user-mode: call with all @pages locked.
  */
 static void
 tb_invalidate_phys_page_range__locked(struct page_collection *pages,
@@ -1919,6 +1891,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
         cpu->cflags_next_tb = 1 | curr_cflags();
+        mmap_unlock();
         cpu_loop_exit_noexc(cpu);
     }
 #endif
@@ -1931,8 +1904,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
  * access: the virtual CPU will exit the current TB if code is modified inside
  * this TB.
  *
- * Called with tb_lock/mmap_lock held for user-mode emulation
- * Called with tb_lock held for system-mode emulation
+ * Called with mmap_lock held for user-mode emulation
  */
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access)
@@ -1941,7 +1913,6 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
     PageDesc *p;
 
     assert_memory_lock();
-    assert_tb_locked();
 
     p = page_find(start >> TARGET_PAGE_BITS);
     if (p == NULL) {
@@ -1960,14 +1931,15 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
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
@@ -1984,29 +1956,15 @@ static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_addr_t end)
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
+ *
+ * Call with all @pages in the range [@start, @start + len[ locked.
  */
-void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
+void tb_invalidate_phys_page_fast(struct page_collection *pages,
+                                  tb_page_addr_t start, int len)
 {
-    struct page_collection *pages;
     PageDesc *p;
 
 #if 0
@@ -2025,7 +1983,6 @@ void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
         return;
     }
 
-    pages = page_collection_lock(start, start + len);
     assert_page_locked(p);
     if (!p->code_bitmap &&
         ++p->code_write_count >= SMC_BITMAP_USE_THRESHOLD) {
@@ -2044,7 +2001,6 @@ void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
     do_invalidate:
         tb_invalidate_phys_page_range__locked(pages, p, start, start + len, 1);
     }
-    page_collection_unlock(pages);
 }
 #else
 /* Called with mmap_lock held. If pc is not 0 then it indicates the
@@ -2076,7 +2032,6 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
         return false;
     }
 
-    tb_lock();
 #ifdef TARGET_HAS_PRECISE_SMC
     if (p->first_tb && pc != 0) {
         current_tb = tcg_tb_lookup(pc);
@@ -2109,12 +2064,9 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
     if (current_tb_modified) {
         /* Force execution of one insn next time.  */
         cpu->cflags_next_tb = 1 | curr_cflags();
-        /* tb_lock will be reset after cpu_loop_exit_noexc longjmps
-         * back into the cpu_exec loop. */
         return true;
     }
 #endif
-    tb_unlock();
 
     return false;
 }
@@ -2135,18 +2087,18 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
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
@@ -2180,7 +2132,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     TranslationBlock *tb;
     uint32_t n;
 
-    tb_lock();
     tb = tcg_tb_lookup(retaddr);
     if (!tb) {
         cpu_abort(cpu, "cpu_io_recompile: could not find TB for pc=%p",
@@ -2228,9 +2179,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      *  repeating the fault, which is horribly inefficient.
      *  Better would be to execute just this insn uncached, or generate a
      *  second new TB.
-     *
-     * cpu_loop_exit_noexc will longjmp back to cpu_exec where the
-     * tb_lock gets reset.
      */
     cpu_loop_exit_noexc(cpu);
 }
diff --git a/exec.c b/exec.c
index ffa1099..afc37e0 100644
--- a/exec.c
+++ b/exec.c
@@ -884,9 +884,7 @@ const char *parse_cpu_model(const char *cpu_model)
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
     mmap_lock();
-    tb_lock();
     tb_invalidate_phys_page_range(pc, pc + 1, 0);
-    tb_unlock();
     mmap_unlock();
 }
 #else
@@ -2481,21 +2479,20 @@ void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
     ndi->ram_addr = ram_addr;
     ndi->mem_vaddr = mem_vaddr;
     ndi->size = size;
-    ndi->locked = false;
+    ndi->pages = NULL;
 
     assert(tcg_enabled());
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
-        ndi->locked = true;
-        tb_lock();
-        tb_invalidate_phys_page_fast(ram_addr, size);
+        ndi->pages = page_collection_lock(ram_addr, ram_addr + size);
+        tb_invalidate_phys_page_fast(ndi->pages, ram_addr, size);
     }
 }
 
 /* Called within RCU critical section. */
 void memory_notdirty_write_complete(NotDirtyInfo *ndi)
 {
-    if (ndi->locked) {
-        tb_unlock();
+    if (ndi->pages) {
+        page_collection_unlock(ndi->pages);
     }
 
     /* Set both VGA and migration bits for simplicity and to remove
@@ -2596,18 +2593,16 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
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
                     /* Force execution of one insn next time.  */
                     cpu->cflags_next_tb = 1 | curr_cflags();
+                    mmap_unlock();
                     cpu_loop_exit_noexc(cpu);
                 }
             }
@@ -3024,9 +3019,9 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
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
index 3234754..ae68b2e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -120,7 +120,6 @@ void fork_start(void)
 {
     start_exclusive();
     mmap_fork_start();
-    qemu_mutex_lock(&tb_ctx.tb_lock);
     cpu_list_lock();
 }
 
@@ -136,14 +135,12 @@ void fork_end(int child)
                 QTAILQ_REMOVE(&cpus, cpu, node);
             }
         }
-        qemu_mutex_init(&tb_ctx.tb_lock);
         qemu_init_cpu_list();
         gdbserver_fork(thread_cpu);
         /* qemu_init_cpu_list() takes care of reinitializing the
          * exclusive state, so we don't need to end_exclusive() here.
          */
     } else {
-        qemu_mutex_unlock(&tb_ctx.tb_lock);
         cpu_list_unlock();
         end_exclusive();
     }
-- 
2.7.4
