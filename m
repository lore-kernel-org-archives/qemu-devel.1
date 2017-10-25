Received: from eggs.gnu.org ([2001:4830:134:3::10]:46282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I79-0000Sz-1i
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I75-0000Mt-Kw
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:43 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:43319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I75-0000M4-9d
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:39 -0400
Received: by mail-wm0-x244.google.com with SMTP id m72so15235965wmc.0
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:32 +0200
Message-Id: <20171025093535.10175-49-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 48/51] tcg: introduce regions to split
 code_gen_buffer
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

This is groundwork for supporting multiple TCG contexts.

The naive solution here is to split code_gen_buffer statically
among the TCG threads; this however results in poor utilization
if translation needs are different across TCG threads.

What we do here is to add an extra layer of indirection, assigning
regions that act just like pages do in virtual memory allocation.
(BTW if you are wondering about the chosen naming, I did not want
to use blocks or pages because those are already heavily used in QEMU).

We use a global lock to serialize allocations as well as statistics
reporting (we now export the size of the used code_gen_buffer with
tcg_code_size()). Note that for the allocator we could just use
a counter and atomic_inc; however, that would complicate the gathering
of tcg_code_size()-like stats. So given that the region operations are
not a fast path, a lock seems the most reasonable choice.

The effectiveness of this approach is clear after seeing some numbers.
I used the bootup+shutdown of debian-arm with '-tb-size 80' as a benchmark.
Note that I'm evaluating this after enabling per-thread TCG (which
is done by a subsequent commit).

* -smp 1, 1 region (entire buffer):
    qemu: flush code_size=83885014 nb_tbs=154739 avg_tb_size=357
    qemu: flush code_size=83884902 nb_tbs=153136 avg_tb_size=363
    qemu: flush code_size=83885014 nb_tbs=152777 avg_tb_size=364
    qemu: flush code_size=83884950 nb_tbs=150057 avg_tb_size=373
    qemu: flush code_size=83884998 nb_tbs=150234 avg_tb_size=373
    qemu: flush code_size=83885014 nb_tbs=154009 avg_tb_size=360
    qemu: flush code_size=83885014 nb_tbs=151007 avg_tb_size=370
    qemu: flush code_size=83885014 nb_tbs=151816 avg_tb_size=367

That is, 8 flushes.

* -smp 8, 32 regions (80/32 MB per region) [i.e. this patch]:

    qemu: flush code_size=76328008 nb_tbs=141040 avg_tb_size=356
    qemu: flush code_size=75366534 nb_tbs=138000 avg_tb_size=361
    qemu: flush code_size=76864546 nb_tbs=140653 avg_tb_size=361
    qemu: flush code_size=76309084 nb_tbs=135945 avg_tb_size=375
    qemu: flush code_size=74581856 nb_tbs=132909 avg_tb_size=375
    qemu: flush code_size=73927256 nb_tbs=135616 avg_tb_size=360
    qemu: flush code_size=78629426 nb_tbs=142896 avg_tb_size=365
    qemu: flush code_size=76667052 nb_tbs=138508 avg_tb_size=368

Again, 8 flushes. Note how buffer utilization is not 100%, but it
is close. Smaller region sizes would yield higher utilization,
but we want region allocation to be rare (it acquires a lock), so
we do not want to go too small.

* -smp 8, static partitioning of 8 regions (10 MB per region):
    qemu: flush code_size=21936504 nb_tbs=40570 avg_tb_size=354
    qemu: flush code_size=11472174 nb_tbs=20633 avg_tb_size=370
    qemu: flush code_size=11603976 nb_tbs=21059 avg_tb_size=365
    qemu: flush code_size=23254872 nb_tbs=41243 avg_tb_size=377
    qemu: flush code_size=28289496 nb_tbs=52057 avg_tb_size=358
    qemu: flush code_size=43605160 nb_tbs=78896 avg_tb_size=367
    qemu: flush code_size=45166552 nb_tbs=82158 avg_tb_size=364
    qemu: flush code_size=63289640 nb_tbs=116494 avg_tb_size=358
    qemu: flush code_size=51389960 nb_tbs=93937 avg_tb_size=362
    qemu: flush code_size=59665928 nb_tbs=107063 avg_tb_size=372
    qemu: flush code_size=38380824 nb_tbs=68597 avg_tb_size=374
    qemu: flush code_size=44884568 nb_tbs=79901 avg_tb_size=376
    qemu: flush code_size=50782632 nb_tbs=90681 avg_tb_size=374
    qemu: flush code_size=39848888 nb_tbs=71433 avg_tb_size=372
    qemu: flush code_size=64708840 nb_tbs=119052 avg_tb_size=359
    qemu: flush code_size=49830008 nb_tbs=90992 avg_tb_size=362
    qemu: flush code_size=68372408 nb_tbs=123442 avg_tb_size=368
    qemu: flush code_size=33555560 nb_tbs=59514 avg_tb_size=378
    qemu: flush code_size=44748344 nb_tbs=80974 avg_tb_size=367
    qemu: flush code_size=37104248 nb_tbs=67609 avg_tb_size=364

That is, 20 flushes. Note how a static partitioning approach uses
the code buffer poorly, leading to many unnecessary flushes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h                 |   6 ++
 accel/tcg/translate-all.c |  63 +++++--------
 bsd-user/main.c           |   1 +
 cpus.c                    |  12 +++
 linux-user/main.c         |   1 +
 tcg/tcg.c                 | 222 +++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 260 insertions(+), 45 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 4b9958a179..9f95648282 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -802,6 +802,12 @@ void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
+void tcg_region_init(void);
+void tcg_region_reset_all(void);
+
+size_t tcg_code_size(void);
+size_t tcg_code_capacity(void);
+
 /* Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
 {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9061c0508c..f99bfd9309 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -606,15 +606,13 @@ static inline void *alloc_code_gen_buffer(void)
 {
     void *buf = static_code_gen_buffer;
     void *end = static_code_gen_buffer + sizeof(static_code_gen_buffer);
-    size_t full_size, size;
+    size_t size;
 
     /* page-align the beginning and end of the buffer */
     buf = QEMU_ALIGN_PTR_UP(buf, qemu_real_host_page_size);
     end = QEMU_ALIGN_PTR_DOWN(end, qemu_real_host_page_size);
 
-    /* Reserve a guard page.  */
-    full_size = end - buf;
-    size = full_size - qemu_real_host_page_size;
+    size = end - buf;
 
     /* Honor a command-line option limiting the size of the buffer.  */
     if (size > tcg_ctx->code_gen_buffer_size) {
@@ -633,9 +631,6 @@ static inline void *alloc_code_gen_buffer(void)
     if (qemu_mprotect_rwx(buf, size)) {
         abort();
     }
-    if (qemu_mprotect_none(buf + size, qemu_real_host_page_size)) {
-        abort();
-    }
     qemu_madvise(buf, size, QEMU_MADV_HUGEPAGE);
 
     return buf;
@@ -644,22 +639,16 @@ static inline void *alloc_code_gen_buffer(void)
 static inline void *alloc_code_gen_buffer(void)
 {
     size_t size = tcg_ctx->code_gen_buffer_size;
-    void *buf1, *buf2;
-
-    /* Perform the allocation in two steps, so that the guard page
-       is reserved but uncommitted.  */
-    buf1 = VirtualAlloc(NULL, size + qemu_real_host_page_size,
-                        MEM_RESERVE, PAGE_NOACCESS);
-    if (buf1 != NULL) {
-        buf2 = VirtualAlloc(buf1, size, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
-        assert(buf1 == buf2);
-    }
+    void *buf;
 
-    return buf1;
+    buf = VirtualAlloc(NULL, size, MEM_RESERVE | MEM_COMMIT,
+                        PAGE_EXECUTE_READWRITE);
+    return buf;
 }
 #else
 static inline void *alloc_code_gen_buffer(void)
 {
+    int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
     int flags = MAP_PRIVATE | MAP_ANONYMOUS;
     uintptr_t start = 0;
     size_t size = tcg_ctx->code_gen_buffer_size;
@@ -693,8 +682,7 @@ static inline void *alloc_code_gen_buffer(void)
 #  endif
 # endif
 
-    buf = mmap((void *)start, size + qemu_real_host_page_size,
-               PROT_NONE, flags, -1, 0);
+    buf = mmap((void *)start, size, prot, flags, -1, 0);
     if (buf == MAP_FAILED) {
         return NULL;
     }
@@ -704,24 +692,23 @@ static inline void *alloc_code_gen_buffer(void)
         /* Try again, with the original still mapped, to avoid re-acquiring
            that 256mb crossing.  This time don't specify an address.  */
         size_t size2;
-        void *buf2 = mmap(NULL, size + qemu_real_host_page_size,
-                          PROT_NONE, flags, -1, 0);
+        void *buf2 = mmap(NULL, size, prot, flags, -1, 0);
         switch ((int)(buf2 != MAP_FAILED)) {
         case 1:
             if (!cross_256mb(buf2, size)) {
                 /* Success!  Use the new buffer.  */
-                munmap(buf, size + qemu_real_host_page_size);
+                munmap(buf, size);
                 break;
             }
             /* Failure.  Work with what we had.  */
-            munmap(buf2, size + qemu_real_host_page_size);
+            munmap(buf2, size);
             /* fallthru */
         default:
             /* Split the original buffer.  Free the smaller half.  */
             buf2 = split_cross_256mb(buf, size);
             size2 = tcg_ctx->code_gen_buffer_size;
             if (buf == buf2) {
-                munmap(buf + size2 + qemu_real_host_page_size, size - size2);
+                munmap(buf + size2, size - size2);
             } else {
                 munmap(buf, size - size2);
             }
@@ -732,10 +719,6 @@ static inline void *alloc_code_gen_buffer(void)
     }
 #endif
 
-    /* Make the final buffer accessible.  The guard page at the end
-       will remain inaccessible with PROT_NONE.  */
-    mprotect(buf, size, PROT_WRITE | PROT_READ | PROT_EXEC);
-
     /* Request large pages for the buffer.  */
     qemu_madvise(buf, size, QEMU_MADV_HUGEPAGE);
 
@@ -916,13 +899,8 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
         size_t host_size = 0;
 
         g_tree_foreach(tb_ctx.tb_tree, tb_host_size_iter, &host_size);
-        printf("qemu: flush code_size=%td nb_tbs=%zu avg_tb_size=%zu\n",
-               tcg_ctx->code_gen_ptr - tcg_ctx->code_gen_buffer, nb_tbs,
-               nb_tbs > 0 ? host_size / nb_tbs : 0);
-    }
-    if ((unsigned long)(tcg_ctx->code_gen_ptr - tcg_ctx->code_gen_buffer)
-        > tcg_ctx->code_gen_buffer_size) {
-        cpu_abort(cpu, "Internal error: code buffer overflow\n");
+        printf("qemu: flush code_size=%zu nb_tbs=%zu avg_tb_size=%zu\n",
+               tcg_code_size(), nb_tbs, nb_tbs > 0 ? host_size / nb_tbs : 0);
     }
 
     CPU_FOREACH(cpu) {
@@ -936,7 +914,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
 
-    tcg_ctx->code_gen_ptr = tcg_ctx->code_gen_buffer;
+    tcg_region_reset_all();
     /* XXX: flush processor icache at this point if cache flush is
        expensive */
     atomic_mb_set(&tb_ctx.tb_flush_count, tb_ctx.tb_flush_count + 1);
@@ -1274,9 +1252,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     phys_pc = get_page_addr_code(env, pc);
 
+ buffer_overflow:
     tb = tb_alloc(pc);
     if (unlikely(!tb)) {
- buffer_overflow:
         /* flush must be done */
         tb_flush(cpu);
         mmap_unlock();
@@ -1380,9 +1358,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 #endif
 
-    tcg_ctx->code_gen_ptr = (void *)
+    atomic_set(&tcg_ctx->code_gen_ptr, (void *)
         ROUND_UP((uintptr_t)gen_code_buf + gen_code_size + search_size,
-                 CODE_GEN_ALIGN);
+                 CODE_GEN_ALIGN));
 
     /* init jump list */
     assert(((uintptr_t)tb & 3) == 0);
@@ -1908,9 +1886,8 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
      * otherwise users might think "-tb-size" is not honoured.
      * For avg host size we use the precise numbers from tb_tree_stats though.
      */
-    cpu_fprintf(f, "gen code size       %td/%zd\n",
-                tcg_ctx->code_gen_ptr - tcg_ctx->code_gen_buffer,
-                tcg_ctx->code_gen_highwater - tcg_ctx->code_gen_buffer);
+    cpu_fprintf(f, "gen code size       %zu/%zu\n",
+                tcg_code_size(), tcg_code_capacity());
     cpu_fprintf(f, "TB count            %zu\n", nb_tbs);
     cpu_fprintf(f, "TB avg target size  %zu max=%zu bytes\n",
                 nb_tbs ? tst.target_size / nb_tbs : 0,
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 392c0ed5fb..f1b244b59b 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -978,6 +978,7 @@ int main(int argc, char **argv)
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init(tcg_ctx);
+    tcg_region_init();
 
     /* build Task State */
     memset(ts, 0, sizeof(TaskState));
diff --git a/cpus.c b/cpus.c
index c9a624003a..8e06257a74 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1664,6 +1664,18 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     char thread_name[VCPU_THREAD_NAME_SIZE];
     static QemuCond *single_tcg_halt_cond;
     static QemuThread *single_tcg_cpu_thread;
+    static int tcg_region_inited;
+
+    /*
+     * Initialize TCG regions--once. Now is a good time, because:
+     * (1) TCG's init context, prologue and target globals have been set up.
+     * (2) qemu_tcg_mttcg_enabled() works now (TCG init code runs before the
+     *     -accel flag is processed, so the check doesn't work then).
+     */
+    if (!tcg_region_inited) {
+        tcg_region_inited = 1;
+        tcg_region_init();
+    }
 
     if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
         cpu->thread = g_malloc0(sizeof(QemuThread));
diff --git a/linux-user/main.c b/linux-user/main.c
index 8814906409..28353f1a75 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4477,6 +4477,7 @@ int main(int argc, char **argv, char **envp)
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init(tcg_ctx);
+    tcg_region_init();
 
 #if defined(TARGET_I386)
     env->cr[0] = CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f1bbfe37ff..3de5f7cf97 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -121,6 +121,30 @@ static bool tcg_out_ldst_finalize(TCGContext *s);
 static TCGContext **tcg_ctxs;
 static unsigned int n_tcg_ctxs;
 
+/*
+ * We divide code_gen_buffer into equally-sized "regions" that TCG threads
+ * dynamically allocate from as demand dictates. Given appropriate region
+ * sizing, this minimizes flushes even when some TCG threads generate a lot
+ * more code than others.
+ */
+struct tcg_region_state {
+    QemuMutex lock;
+
+    /* fields set at init time */
+    void *start;
+    void *start_aligned;
+    void *end;
+    size_t n;
+    size_t size; /* size of one region */
+    size_t stride; /* .size + guard size */
+
+    /* fields protected by the lock */
+    size_t current; /* current region index */
+    size_t agg_size_full; /* aggregate size of full regions */
+};
+
+static struct tcg_region_state region;
+
 static TCGRegSet tcg_target_available_regs[2];
 static TCGRegSet tcg_target_call_clobber_regs;
 
@@ -258,6 +282,196 @@ TCGLabel *gen_new_label(void)
 
 #include "tcg-target.inc.c"
 
+static void tcg_region_bounds(size_t curr_region, void **pstart, void **pend)
+{
+    void *start, *end;
+
+    start = region.start_aligned + curr_region * region.stride;
+    end = start + region.size;
+
+    if (curr_region == 0) {
+        start = region.start;
+    }
+    if (curr_region == region.n - 1) {
+        end = region.end;
+    }
+
+    *pstart = start;
+    *pend = end;
+}
+
+static void tcg_region_assign(TCGContext *s, size_t curr_region)
+{
+    void *start, *end;
+
+    tcg_region_bounds(curr_region, &start, &end);
+
+    s->code_gen_buffer = start;
+    s->code_gen_ptr = start;
+    s->code_gen_buffer_size = end - start;
+    s->code_gen_highwater = end - TCG_HIGHWATER;
+}
+
+static bool tcg_region_alloc__locked(TCGContext *s)
+{
+    if (region.current == region.n) {
+        return true;
+    }
+    tcg_region_assign(s, region.current);
+    region.current++;
+    return false;
+}
+
+/*
+ * Request a new region once the one in use has filled up.
+ * Returns true on error.
+ */
+static bool tcg_region_alloc(TCGContext *s)
+{
+    bool err;
+    /* read the region size now; alloc__locked will overwrite it on success */
+    size_t size_full = s->code_gen_buffer_size;
+
+    qemu_mutex_lock(&region.lock);
+    err = tcg_region_alloc__locked(s);
+    if (!err) {
+        region.agg_size_full += size_full - TCG_HIGHWATER;
+    }
+    qemu_mutex_unlock(&region.lock);
+    return err;
+}
+
+/*
+ * Perform a context's first region allocation.
+ * This function does _not_ increment region.agg_size_full.
+ */
+static inline bool tcg_region_initial_alloc__locked(TCGContext *s)
+{
+    return tcg_region_alloc__locked(s);
+}
+
+/* Call from a safe-work context */
+void tcg_region_reset_all(void)
+{
+    unsigned int i;
+
+    qemu_mutex_lock(&region.lock);
+    region.current = 0;
+    region.agg_size_full = 0;
+
+    for (i = 0; i < n_tcg_ctxs; i++) {
+        bool err = tcg_region_initial_alloc__locked(tcg_ctxs[i]);
+
+        g_assert(!err);
+    }
+    qemu_mutex_unlock(&region.lock);
+}
+
+/*
+ * Initializes region partitioning.
+ *
+ * Called at init time from the parent thread (i.e. the one calling
+ * tcg_context_init), after the target's TCG globals have been set.
+ */
+void tcg_region_init(void)
+{
+    void *buf = tcg_init_ctx.code_gen_buffer;
+    void *aligned;
+    size_t size = tcg_init_ctx.code_gen_buffer_size;
+    size_t page_size = qemu_real_host_page_size;
+    size_t region_size;
+    size_t n_regions;
+    size_t i;
+
+    /* We do not yet support multiple TCG contexts, so use one region for now */
+    n_regions = 1;
+
+    /* The first region will be 'aligned - buf' bytes larger than the others */
+    aligned = QEMU_ALIGN_PTR_UP(buf, page_size);
+    g_assert(aligned < tcg_init_ctx.code_gen_buffer + size);
+    /*
+     * Make region_size a multiple of page_size, using aligned as the start.
+     * As a result of this we might end up with a few extra pages at the end of
+     * the buffer; we will assign those to the last region.
+     */
+    region_size = (size - (aligned - buf)) / n_regions;
+    region_size = QEMU_ALIGN_DOWN(region_size, page_size);
+
+    /* A region must have at least 2 pages; one code, one guard */
+    g_assert(region_size >= 2 * page_size);
+
+    /* init the region struct */
+    qemu_mutex_init(&region.lock);
+    region.n = n_regions;
+    region.size = region_size - page_size;
+    region.stride = region_size;
+    region.start = buf;
+    region.start_aligned = aligned;
+    /* page-align the end, since its last page will be a guard page */
+    region.end = QEMU_ALIGN_PTR_DOWN(buf + size, page_size);
+    /* account for that last guard page */
+    region.end -= page_size;
+
+    /* set guard pages */
+    for (i = 0; i < region.n; i++) {
+        void *start, *end;
+        int rc;
+
+        tcg_region_bounds(i, &start, &end);
+        rc = qemu_mprotect_none(end, page_size);
+        g_assert(!rc);
+    }
+
+    /* We do not yet support multiple TCG contexts so allocate the region now */
+    {
+        bool err = tcg_region_initial_alloc__locked(tcg_ctx);
+
+        g_assert(!err);
+    }
+}
+
+/*
+ * Returns the size (in bytes) of all translated code (i.e. from all regions)
+ * currently in the cache.
+ * See also: tcg_code_capacity()
+ * Do not confuse with tcg_current_code_size(); that one applies to a single
+ * TCG context.
+ */
+size_t tcg_code_size(void)
+{
+    unsigned int i;
+    size_t total;
+
+    qemu_mutex_lock(&region.lock);
+    total = region.agg_size_full;
+    for (i = 0; i < n_tcg_ctxs; i++) {
+        const TCGContext *s = tcg_ctxs[i];
+        size_t size;
+
+        size = atomic_read(&s->code_gen_ptr) - s->code_gen_buffer;
+        g_assert(size <= s->code_gen_buffer_size);
+        total += size;
+    }
+    qemu_mutex_unlock(&region.lock);
+    return total;
+}
+
+/*
+ * Returns the code capacity (in bytes) of the entire cache, i.e. including all
+ * regions.
+ * See also: tcg_code_size()
+ */
+size_t tcg_code_capacity(void)
+{
+    size_t guard_size, capacity;
+
+    /* no need for synchronization; these variables are set at init time */
+    guard_size = region.stride - region.size;
+    capacity = region.end + guard_size - region.start;
+    capacity -= region.n * (guard_size + TCG_HIGHWATER);
+    return capacity;
+}
+
 /* pool based memory allocation */
 void *tcg_malloc_internal(TCGContext *s, int size)
 {
@@ -401,13 +615,17 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
     TranslationBlock *tb;
     void *next;
 
+ retry:
     tb = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
     next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);
 
     if (unlikely(next > s->code_gen_highwater)) {
-        return NULL;
+        if (tcg_region_alloc(s)) {
+            return NULL;
+        }
+        goto retry;
     }
-    s->code_gen_ptr = next;
+    atomic_set(&s->code_gen_ptr, next);
     s->data_gen_ptr = NULL;
     return tb;
 }
-- 
2.13.6
