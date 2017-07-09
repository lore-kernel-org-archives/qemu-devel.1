Received: from eggs.gnu.org ([2001:4830:134:3::10]:46346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zJ-0004R4-4o
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zE-00030Y-LF
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:41 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-0002z8-5v
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:03 -0400
Message-Id: <1499586614-20507-12-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 11/22] translate-all: use a binary search tree
 to track TBs in TBContext
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

This is a prerequisite for having threads generate code on separate
buffers, which will help scalability when booting multiple cores
under MTTCG.

For this we need a new field (.tc_size) in TranslationBlock to keep
track of the size of the translated code. This field is added into
a 4-byte hole that the previous commit created.

In order to use glib's binary search tree we embed a helper struct
in TranslationBlock to allow us to compare tb's based on their
tc_ptr as well as their tc_size fields. We use an anonymous struct
in TranslationBlock to minimize churn; the alternatives I can
see are to (a) just add a comment and cross our fingers, (b) use
-fms-extensions, and (c) embed the struct and update all calling
code. I think using an anonymous struct is superior, but I can be
persuaded otherwise.

The comparison function we use is optimized for the common case:
insertions. Profiling shows that upon booting debian-arm, 98%
of comparisons are between existing tb's (i.e. a->size and b->size
are both !0), which happens during insertions (and removals, but
those are rare). The remaining cases are lookups. From reading the glib
sources we see that the first key is always the lookup key. However,
the code does not assume this to always be the case because this
behaviour is not guaranteed in the glib docs. However, we embed
this knowledge in the code as a branch hint for the compiler.

Note that tb_free does not free space in the code_gen_buffer anymore,
since we cannot easily know whether the tb is the last one inserted
in code_gen_buffer.

Performance-wise, lookups in tb_find_pc are the same as before:
O(log n). However, insertions are O(log n) instead of O(1), which
results in a small slowdown when booting debian-arm:

Performance counter stats for 'build/arm-softmmu/qemu-system-arm \
	-machine type=virt -nographic -smp 1 -m 4096 \
	-netdev user,id=unet,hostfwd=tcp::2222-:22 \
	-device virtio-net-device,netdev=unet \
	-drive file=img/arm/jessie-arm32.qcow2,id=myblock,index=0,if=none \
	-device virtio-blk-device,drive=myblock \
	-kernel img/arm/aarch32-current-linux-kernel-only.img \
	-append console=ttyAMA0 root=/dev/vda1 \
	-name arm,debug-threads=on -smp 1' (10 runs):

- Before:

       8048.598422      task-clock (msec)         #    0.931 CPUs utilized            ( +-  0.28% )
            16,974      context-switches          #    0.002 M/sec                    ( +-  0.12% )
                 0      cpu-migrations            #    0.000 K/sec
            10,125      page-faults               #    0.001 M/sec                    ( +-  1.23% )
    35,144,901,879      cycles                    #    4.367 GHz                      ( +-  0.14% )
   <not supported>      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend
    65,758,252,643      instructions              #    1.87  insns per cycle          ( +-  0.33% )
    10,871,298,668      branches                  # 1350.707 M/sec                    ( +-  0.41% )
       192,322,212      branch-misses             #    1.77% of all branches          ( +-  0.32% )

       8.640869419 seconds time elapsed                                          ( +-  0.57% )

- After:
       8146.242027      task-clock (msec)         #    0.923 CPUs utilized            ( +-  1.23% )
            17,016      context-switches          #    0.002 M/sec                    ( +-  0.40% )
                 0      cpu-migrations            #    0.000 K/sec
            18,769      page-faults               #    0.002 M/sec                    ( +-  0.45% )
    35,660,956,120      cycles                    #    4.378 GHz                      ( +-  1.22% )
   <not supported>      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend
    65,095,366,607      instructions              #    1.83  insns per cycle          ( +-  1.73% )
    10,803,480,261      branches                  # 1326.192 M/sec                    ( +-  1.95% )
       195,601,289      branch-misses             #    1.81% of all branches          ( +-  0.39% )

       8.828660235 seconds time elapsed                                          ( +-  0.38% )

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   |  17 +++-
 include/exec/tb-context.h |   4 +-
 accel/tcg/translate-all.c | 212 ++++++++++++++++++++++++----------------------
 3 files changed, 125 insertions(+), 108 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index fd20bca..673b26d 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -320,14 +320,25 @@ struct TranslationBlock {
     uint16_t size;      /* size of target code for this block (1 <=
                            size <= TARGET_PAGE_SIZE) */
     uint16_t icount;
-    uint32_t cflags;    /* compile flags */
+    /*
+     * @tc_size must be kept right after @tc_ptr to facilitate TB lookups in a
+     * binary search tree -- see struct ptr_size.
+     * We use an anonymous struct here to avoid updating all calling code,
+     * which would be quite a lot of churn.
+     * The only reason to bring @cflags into the anonymous struct is to
+     * avoid inducing a hole in TranslationBlock.
+     */
+    struct {
+        void *tc_ptr;    /* pointer to the translated code */
+        uint32_t tc_size; /* size of translated code for this block */
+
+        uint32_t cflags;    /* compile flags */
 #define CF_COUNT_MASK  0x7fff
 #define CF_LAST_IO     0x8000 /* Last insn may be an IO access.  */
 #define CF_NOCACHE     0x10000 /* To be freed after execution */
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
-
-    void *tc_ptr;    /* pointer to the translated code */
+    };
     uint8_t *tc_search;  /* pointer to search data */
     /* original tb when cflags has CF_NOCACHE */
     struct TranslationBlock *orig_tb;
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index 25c2afe..1fa8dcc 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -31,10 +31,8 @@ typedef struct TBContext TBContext;
 
 struct TBContext {
 
-    TranslationBlock **tbs;
+    GTree *tb_tree;
     struct qht htable;
-    size_t tbs_size;
-    int nb_tbs;
     /* any access to the tbs or the page table must use this lock */
     QemuMutex tb_lock;
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2fa9f65..aa3a08b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -752,6 +752,47 @@ static inline void *alloc_code_gen_buffer(void)
 }
 #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
 
+struct ptr_size {
+    void *ptr;
+    uint32_t size;
+};
+
+/* compare a single @ptr and a ptr_size @s */
+static int ptr_size_cmp(const void *ptr, const struct ptr_size *s)
+{
+    if (ptr >= s->ptr + s->size) {
+        return 1;
+    } else if (ptr < s->ptr) {
+        return -1;
+    }
+    return 0;
+}
+
+static gint tc_ptr_cmp(gconstpointer ap, gconstpointer bp)
+{
+    const struct ptr_size *a = ap;
+    const struct ptr_size *b = bp;
+
+    /*
+     * When both sizes are set, we know this isn't a lookup and therefore
+     * the two buffers are non-overlapping: a pointer comparison will do.
+     * This is the most likely case: every TB must be inserted; lookups
+     * are a lot less frequent.
+     */
+    if (likely(a->size && b->size)) {
+        return a->ptr - b->ptr;
+    }
+    /*
+     * All lookups have either .size field set to 0.
+     * From the glib sources we see that @ap is always the lookup key. However
+     * the docs provide no guarantee, so we just mark this case as likely.
+     */
+    if (likely(a->size == 0)) {
+        return ptr_size_cmp(a->ptr, b);
+    }
+    return ptr_size_cmp(b->ptr, a);
+}
+
 static inline void code_gen_alloc(size_t tb_size)
 {
     tcg_ctx.code_gen_buffer_size = size_code_gen_buffer(tb_size);
@@ -760,15 +801,7 @@ static inline void code_gen_alloc(size_t tb_size)
         fprintf(stderr, "Could not allocate dynamic translator buffer\n");
         exit(1);
     }
-
-    /* size this conservatively -- realloc later if needed */
-    tcg_ctx.tb_ctx.tbs_size =
-        tcg_ctx.code_gen_buffer_size / CODE_GEN_AVG_BLOCK_SIZE / 8;
-    if (unlikely(!tcg_ctx.tb_ctx.tbs_size)) {
-        tcg_ctx.tb_ctx.tbs_size = 64 * 1024;
-    }
-    tcg_ctx.tb_ctx.tbs = g_new(TranslationBlock *, tcg_ctx.tb_ctx.tbs_size);
-
+    tcg_ctx.tb_ctx.tb_tree = g_tree_new(tc_ptr_cmp);
     qemu_mutex_init(&tcg_ctx.tb_ctx.tb_lock);
 }
 
@@ -805,7 +838,6 @@ void tcg_exec_init(unsigned long tb_size)
 static TranslationBlock *tb_alloc(target_ulong pc)
 {
     TranslationBlock *tb;
-    TBContext *ctx;
 
     assert_tb_locked();
 
@@ -813,12 +845,6 @@ static TranslationBlock *tb_alloc(target_ulong pc)
     if (unlikely(tb == NULL)) {
         return NULL;
     }
-    ctx = &tcg_ctx.tb_ctx;
-    if (unlikely(ctx->nb_tbs == ctx->tbs_size)) {
-        ctx->tbs_size *= 2;
-        ctx->tbs = g_renew(TranslationBlock *, ctx->tbs, ctx->tbs_size);
-    }
-    ctx->tbs[ctx->nb_tbs++] = tb;
     return tb;
 }
 
@@ -827,16 +853,7 @@ void tb_free(TranslationBlock *tb)
 {
     assert_tb_locked();
 
-    /* In practice this is mostly used for single use temporary TB
-       Ignore the hard cases and just back up if this TB happens to
-       be the last one generated.  */
-    if (tcg_ctx.tb_ctx.nb_tbs > 0 &&
-            tb == tcg_ctx.tb_ctx.tbs[tcg_ctx.tb_ctx.nb_tbs - 1]) {
-        size_t struct_size = ROUND_UP(sizeof(*tb), qemu_icache_linesize);
-
-        tcg_ctx.code_gen_ptr = tb->tc_ptr - struct_size;
-        tcg_ctx.tb_ctx.nb_tbs--;
-    }
+    g_tree_remove(tcg_ctx.tb_ctx.tb_tree, &tb->tc_ptr);
 }
 
 static inline void invalidate_page_bitmap(PageDesc *p)
@@ -884,6 +901,8 @@ static void page_flush_tb(void)
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
+    int nb_tbs __attribute__((unused));
+
     tb_lock();
 
     /* If it is already been done on request of another CPU,
@@ -894,11 +913,12 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     }
 
 #if defined(DEBUG_TB_FLUSH)
+    nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
     printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%ld\n",
            (unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer),
-           tcg_ctx.tb_ctx.nb_tbs, tcg_ctx.tb_ctx.nb_tbs > 0 ?
+           nb_tbs, nb_tbs > 0 ?
            ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)) /
-           tcg_ctx.tb_ctx.nb_tbs : 0);
+           nb_tbs : 0);
 #endif
     if ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)
         > tcg_ctx.code_gen_buffer_size) {
@@ -909,7 +929,10 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
         cpu_tb_jmp_cache_clear(cpu);
     }
 
-    tcg_ctx.tb_ctx.nb_tbs = 0;
+    /* Increment the refcount first so that destroy acts as a reset */
+    g_tree_ref(tcg_ctx.tb_ctx.tb_tree);
+    g_tree_destroy(tcg_ctx.tb_ctx.tb_tree);
+
     qht_reset_size(&tcg_ctx.tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
 
@@ -1309,6 +1332,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if (unlikely(search_size < 0)) {
         goto buffer_overflow;
     }
+    tb->tc_size = gen_code_size;
 
 #ifdef CONFIG_PROFILER
     tcg_ctx.code_time += profile_getclock() - ti;
@@ -1359,6 +1383,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      * through the physical hash table and physical page list.
      */
     tb_link_page(tb, phys_pc, phys_page2);
+    g_tree_insert(tcg_ctx.tb_ctx.tb_tree, &tb->tc_ptr, tb);
     return tb;
 }
 
@@ -1627,37 +1652,16 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
 }
 #endif
 
-/* find the TB 'tb' such that tb[0].tc_ptr <= tc_ptr <
-   tb[1].tc_ptr. Return NULL if not found */
+/*
+ * Find the TB 'tb' such that
+ * tb->tc_ptr <= tc_ptr < tb->tc_ptr + tb->tc_size
+ * Return NULL if not found.
+ */
 static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
 {
-    int m_min, m_max, m;
-    uintptr_t v;
-    TranslationBlock *tb;
+    struct ptr_size s = { .ptr = (void *)tc_ptr };
 
-    if (tcg_ctx.tb_ctx.nb_tbs <= 0) {
-        return NULL;
-    }
-    if (tc_ptr < (uintptr_t)tcg_ctx.code_gen_buffer ||
-        tc_ptr >= (uintptr_t)tcg_ctx.code_gen_ptr) {
-        return NULL;
-    }
-    /* binary search (cf Knuth) */
-    m_min = 0;
-    m_max = tcg_ctx.tb_ctx.nb_tbs - 1;
-    while (m_min <= m_max) {
-        m = (m_min + m_max) >> 1;
-        tb = tcg_ctx.tb_ctx.tbs[m];
-        v = (uintptr_t)tb->tc_ptr;
-        if (v == tc_ptr) {
-            return tb;
-        } else if (tc_ptr < v) {
-            m_max = m - 1;
-        } else {
-            m_min = m + 1;
-        }
-    }
-    return tcg_ctx.tb_ctx.tbs[m_max];
+    return g_tree_lookup(tcg_ctx.tb_ctx.tb_tree, &s);
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1842,63 +1846,67 @@ static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
     g_free(hgram);
 }
 
+struct tb_tree_stats {
+    size_t target_size;
+    size_t max_target_size;
+    size_t direct_jmp_count;
+    size_t direct_jmp2_count;
+    size_t cross_page;
+};
+
+static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
+{
+    const TranslationBlock *tb = value;
+    struct tb_tree_stats *tst = data;
+
+    tst->target_size += tb->size;
+    if (tb->size > tst->max_target_size) {
+        tst->max_target_size = tb->size;
+    }
+    if (tb->page_addr[1] != -1) {
+        tst->cross_page++;
+    }
+    if (tb->jmp_reset_offset[0] != TB_JMP_RESET_OFFSET_INVALID) {
+        tst->direct_jmp_count++;
+        if (tb->jmp_reset_offset[1] != TB_JMP_RESET_OFFSET_INVALID) {
+            tst->direct_jmp2_count++;
+        }
+    }
+    return false;
+}
+
 void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
 {
-    int i, target_code_size, max_target_code_size;
-    int direct_jmp_count, direct_jmp2_count, cross_page;
-    TranslationBlock *tb;
+    struct tb_tree_stats tst = {};
     struct qht_stats hst;
+    int nb_tbs;
 
     tb_lock();
 
-    target_code_size = 0;
-    max_target_code_size = 0;
-    cross_page = 0;
-    direct_jmp_count = 0;
-    direct_jmp2_count = 0;
-    for (i = 0; i < tcg_ctx.tb_ctx.nb_tbs; i++) {
-        tb = tcg_ctx.tb_ctx.tbs[i];
-        target_code_size += tb->size;
-        if (tb->size > max_target_code_size) {
-            max_target_code_size = tb->size;
-        }
-        if (tb->page_addr[1] != -1) {
-            cross_page++;
-        }
-        if (tb->jmp_reset_offset[0] != TB_JMP_RESET_OFFSET_INVALID) {
-            direct_jmp_count++;
-            if (tb->jmp_reset_offset[1] != TB_JMP_RESET_OFFSET_INVALID) {
-                direct_jmp2_count++;
-            }
-        }
-    }
+    nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
+    g_tree_foreach(tcg_ctx.tb_ctx.tb_tree, tb_tree_stats_iter, &tst);
     /* XXX: avoid using doubles ? */
     cpu_fprintf(f, "Translation buffer state:\n");
     cpu_fprintf(f, "gen code size       %td/%zd\n",
                 tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer,
                 tcg_ctx.code_gen_highwater - tcg_ctx.code_gen_buffer);
-    cpu_fprintf(f, "TB count            %d\n", tcg_ctx.tb_ctx.nb_tbs);
-    cpu_fprintf(f, "TB avg target size  %d max=%d bytes\n",
-            tcg_ctx.tb_ctx.nb_tbs ? target_code_size /
-                    tcg_ctx.tb_ctx.nb_tbs : 0,
-            max_target_code_size);
+    cpu_fprintf(f, "TB count            %d\n", nb_tbs);
+    cpu_fprintf(f, "TB avg target size  %zu max=%zu bytes\n",
+                nb_tbs ? tst.target_size / nb_tbs : 0,
+                tst.max_target_size);
     cpu_fprintf(f, "TB avg host size    %td bytes (expansion ratio: %0.1f)\n",
-            tcg_ctx.tb_ctx.nb_tbs ? (tcg_ctx.code_gen_ptr -
-                                     tcg_ctx.code_gen_buffer) /
-                                     tcg_ctx.tb_ctx.nb_tbs : 0,
-                target_code_size ? (double) (tcg_ctx.code_gen_ptr -
-                                             tcg_ctx.code_gen_buffer) /
-                                             target_code_size : 0);
-    cpu_fprintf(f, "cross page TB count %d (%d%%)\n", cross_page,
-            tcg_ctx.tb_ctx.nb_tbs ? (cross_page * 100) /
-                                    tcg_ctx.tb_ctx.nb_tbs : 0);
-    cpu_fprintf(f, "direct jump count   %d (%d%%) (2 jumps=%d %d%%)\n",
-                direct_jmp_count,
-                tcg_ctx.tb_ctx.nb_tbs ? (direct_jmp_count * 100) /
-                        tcg_ctx.tb_ctx.nb_tbs : 0,
-                direct_jmp2_count,
-                tcg_ctx.tb_ctx.nb_tbs ? (direct_jmp2_count * 100) /
-                        tcg_ctx.tb_ctx.nb_tbs : 0);
+                nb_tbs ? (tcg_ctx.code_gen_ptr -
+                          tcg_ctx.code_gen_buffer) / nb_tbs : 0,
+                tst.target_size ? (double) (tcg_ctx.code_gen_ptr -
+                                            tcg_ctx.code_gen_buffer) /
+                                            tst.target_size : 0);
+    cpu_fprintf(f, "cross page TB count %zu (%zu%%)\n", tst.cross_page,
+            nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
+    cpu_fprintf(f, "direct jump count   %zu (%zu%%) (2 jumps=%zu %zu%%)\n",
+                tst.direct_jmp_count,
+                nb_tbs ? (tst.direct_jmp_count * 100) / nb_tbs : 0,
+                tst.direct_jmp2_count,
+                nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
 
     qht_statistics_init(&tcg_ctx.tb_ctx.htable, &hst);
     print_qht_statistics(f, cpu_fprintf, hst);
-- 
2.7.4
