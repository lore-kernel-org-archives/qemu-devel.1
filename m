Received: from eggs.gnu.org ([2001:4830:134:3::10]:43347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4q-0007E3-Aa
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4n-0000zV-45
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQg4m-0000xK-Qg
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 29 Jun 2017 16:28:25 -0400
Message-Id: <1498768109-4092-4-git-send-email-cota@braap.org>
In-Reply-To: <1498768109-4092-1-git-send-email-cota@braap.org>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 3/7] translate-all: use a binary search tree to
 track TBs in TBContext
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

Note that tb_free does not free space in the code_gen_buffer anymore,
since we cannot easily know whether the tb is the last one inserted
in code_gen_buffer.

Performance-wise, lookups in tb_find_pc are the same as before:
O(log n). However, insertions are O(log n) instead of O(1), which results
in a small slowdown when booting debian-arm:

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
      10289.389753      task-clock (msec)         #    0.952 CPUs utilized            ( +-  0.13% )
            18,238      context-switches          #    0.002 M/sec                    ( +-  0.73% )
                 0      cpu-migrations            #    0.000 K/sec
            86,555      page-faults               #    0.008 M/sec                    ( +-  0.49% )
    45,079,926,395      cycles                    #    4.381 GHz                      ( +-  0.14% )
   <not supported>      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend
    84,582,463,603      instructions              #    1.88  insns per cycle          ( +-  0.26% )
    14,964,335,400      branches                  # 1454.346 M/sec                    ( +-  0.29% )
       288,324,215      branch-misses             #    1.93% of all branches          ( +-  0.34% )

      10.813687279 seconds time elapsed                                          ( +-  0.42% )

- After:
      10333.181473      task-clock (msec)         #    0.944 CPUs utilized            ( +-  0.27% )
            18,167      context-switches          #    0.002 M/sec                    ( +-  0.20% )
                 0      cpu-migrations            #    0.000 K/sec
            83,354      page-faults               #    0.008 M/sec                    ( +-  0.92% )
    45,247,697,926      cycles                    #    4.379 GHz                      ( +-  0.23% )
   <not supported>      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend
    84,537,657,945      instructions              #    1.87  insns per cycle          ( +-  0.18% )
    14,988,568,500      branches                  # 1450.528 M/sec                    ( +-  0.21% )
       294,765,097      branch-misses             #    1.97% of all branches          ( +-  0.43% )

      10.946641611 seconds time elapsed                                          ( +-  0.79% )

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/tb-context.h |   4 +-
 accel/tcg/translate-all.c | 181 ++++++++++++++++++++--------------------------
 2 files changed, 81 insertions(+), 104 deletions(-)

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
index da91482..a18fbf7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -770,6 +770,21 @@ static inline void *alloc_code_gen_buffer(void)
 }
 #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
 
+/* @key is already in the tree so it's safe to use container_of on it */
+static gint tc_ptr_cmp(gconstpointer candidate, gconstpointer key)
+{
+    uintptr_t a = *(uintptr_t *)candidate;
+    const TranslationBlock *tb = container_of(key, TranslationBlock, tc_ptr);
+    uintptr_t b = (uintptr_t)tb->tc_ptr;
+
+    if (a >= b + tb->out_size) {
+        return 1;
+    } else if (a < b) {
+        return -1;
+    }
+    return 0;
+}
+
 static inline void code_gen_alloc(size_t tb_size)
 {
     tcg_ctx.code_gen_buffer_size = size_code_gen_buffer(tb_size);
@@ -778,15 +793,7 @@ static inline void code_gen_alloc(size_t tb_size)
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
 
@@ -827,7 +834,6 @@ bool tcg_enabled(void)
 static TranslationBlock *tb_alloc(target_ulong pc)
 {
     TranslationBlock *tb;
-    TBContext *ctx;
 
     assert_tb_locked();
 
@@ -835,12 +841,6 @@ static TranslationBlock *tb_alloc(target_ulong pc)
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
 
@@ -849,16 +849,7 @@ void tb_free(TranslationBlock *tb)
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
@@ -906,6 +897,8 @@ static void page_flush_tb(void)
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
+    int nb_tbs __attribute__((unused));
+
     tb_lock();
 
     /* If it is already been done on request of another CPU,
@@ -916,11 +909,12 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
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
@@ -935,7 +929,10 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
         }
     }
 
-    tcg_ctx.tb_ctx.nb_tbs = 0;
+    /* Increment the refcount first so that destroy acts as a reset */
+    g_tree_ref(tcg_ctx.tb_ctx.tb_tree);
+    g_tree_destroy(tcg_ctx.tb_ctx.tb_tree);
+
     qht_reset_size(&tcg_ctx.tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
 
@@ -1385,6 +1382,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      * through the physical hash table and physical page list.
      */
     tb_link_page(tb, phys_pc, phys_page2);
+    g_tree_insert(tcg_ctx.tb_ctx.tb_tree, &tb->tc_ptr, tb);
     return tb;
 }
 
@@ -1653,37 +1651,14 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
 }
 #endif
 
-/* find the TB 'tb' such that tb[0].tc_ptr <= tc_ptr <
-   tb[1].tc_ptr. Return NULL if not found */
+/*
+ * Find the TB 'tb' such that
+ * tb->tc_ptr <= tc_ptr < tb->tc_ptr + tb->out_size
+ * Return NULL if not found.
+ */
 static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
 {
-    int m_min, m_max, m;
-    uintptr_t v;
-    TranslationBlock *tb;
-
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
+    return g_tree_lookup(tcg_ctx.tb_ctx.tb_tree, &tc_ptr);
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1866,63 +1841,67 @@ static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
     g_free(hgram);
 }
 
+struct tb_tree_stats {
+    int target_size;
+    int max_target_size;
+    int direct_jmp_count;
+    int direct_jmp2_count;
+    int cross_page;
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
+    cpu_fprintf(f, "TB count            %d\n", nb_tbs);
     cpu_fprintf(f, "TB avg target size  %d max=%d bytes\n",
-            tcg_ctx.tb_ctx.nb_tbs ? target_code_size /
-                    tcg_ctx.tb_ctx.nb_tbs : 0,
-            max_target_code_size);
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
+                nb_tbs ? (tcg_ctx.code_gen_ptr -
+                          tcg_ctx.code_gen_buffer) / nb_tbs : 0,
+                tst.target_size ? (double) (tcg_ctx.code_gen_ptr -
+                                            tcg_ctx.code_gen_buffer) /
+                                            tst.target_size : 0);
+    cpu_fprintf(f, "cross page TB count %d (%d%%)\n", tst.cross_page,
+            nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
     cpu_fprintf(f, "direct jump count   %d (%d%%) (2 jumps=%d %d%%)\n",
-                direct_jmp_count,
-                tcg_ctx.tb_ctx.nb_tbs ? (direct_jmp_count * 100) /
-                        tcg_ctx.tb_ctx.nb_tbs : 0,
-                direct_jmp2_count,
-                tcg_ctx.tb_ctx.nb_tbs ? (direct_jmp2_count * 100) /
-                        tcg_ctx.tb_ctx.nb_tbs : 0);
+                tst.direct_jmp_count,
+                nb_tbs ? (tst.direct_jmp_count * 100) / nb_tbs : 0,
+                tst.direct_jmp2_count,
+                nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
 
     qht_statistics_init(&tcg_ctx.tb_ctx.htable, &hst);
     print_qht_statistics(f, cpu_fprintf, hst);
-- 
2.7.4
