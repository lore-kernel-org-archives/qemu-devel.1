Received: from eggs.gnu.org ([2001:4830:134:3::10]:46482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmj-0001GT-0q
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpma-0008SM-TO
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46541)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpma-0008Rg-KJ
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:26 -0400
Message-Id: <1500235468-15341-44-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 43/45] tcg: introduce regions to split
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
Cc: Richard Henderson <rth@twiddle.net>

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

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   |   3 +
 tcg/tcg.h                 |   6 ++
 accel/tcg/translate-all.c |  56 +++++++++----
 bsd-user/main.c           |   1 +
 cpus.c                    |  12 +++
 linux-user/main.c         |   1 +
 tcg/tcg.c                 | 197 +++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 260 insertions(+), 16 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 37487d7..69a2a21 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -49,6 +49,9 @@ void gen_intermediate_code(CPUArchState *env, struct TranslationBlock *tb);
 void restore_state_to_opc(CPUArchState *env, struct TranslationBlock *tb,
                           target_ulong *data);
 
+#ifdef CONFIG_SOFTMMU
+void softmmu_tcg_region_init(void);
+#endif
 void cpu_gen_init(void);
 bool cpu_restore_state(CPUState *cpu, uintptr_t searched_pc);
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 9d17584..6f6720b 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -772,6 +772,12 @@ void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
+void tcg_region_init(size_t n_regions);
+void tcg_region_reset_all(void);
+
+size_t tcg_code_size(void);
+size_t tcg_code_capacity(void);
+
 /* Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
 {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 913b1c5..c30d400 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -59,6 +59,7 @@
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "sysemu/cpus.h"
+#include "sysemu/sysemu.h"
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
@@ -797,6 +798,39 @@ static inline void code_gen_alloc(size_t tb_size)
     qemu_mutex_init(&tb_ctx.tb_lock);
 }
 
+#ifdef CONFIG_SOFTMMU
+/*
+ * It is likely that some vCPUs will translate more code than others, so we
+ * first try to set more regions than smp_cpus, with those regions being
+ * larger than the minimum code_gen_buffer size. If that's not possible we
+ * make do by evenly dividing the code_gen_buffer among the vCPUs.
+ */
+void softmmu_tcg_region_init(void)
+{
+    size_t i;
+
+    /* Use a single region if all we have is one vCPU thread */
+    if (smp_cpus == 1 || !qemu_tcg_mttcg_enabled()) {
+        tcg_region_init(0);
+        return;
+    }
+
+    for (i = 8; i > 0; i--) {
+        size_t regions_per_thread = i;
+        size_t region_size;
+
+        region_size = tcg_init_ctx.code_gen_buffer_size;
+        region_size /= smp_cpus * regions_per_thread;
+
+        if (region_size >= 2 * MIN_CODE_GEN_BUFFER_SIZE) {
+            tcg_region_init(smp_cpus * regions_per_thread);
+            return;
+        }
+    }
+    tcg_region_init(smp_cpus);
+}
+#endif
+
 static void tb_htable_init(void)
 {
     unsigned int mode = QHT_MODE_AUTO_RESIZE;
@@ -916,13 +950,8 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
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
@@ -936,7 +965,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
 
-    tcg_ctx->code_gen_ptr = tcg_ctx->code_gen_buffer;
+    tcg_region_reset_all();
     /* XXX: flush processor icache at this point if cache flush is
        expensive */
     atomic_mb_set(&tb_ctx.tb_flush_count, tb_ctx.tb_flush_count + 1);
@@ -1281,9 +1310,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         cflags |= CF_USE_ICOUNT;
     }
 
+ buffer_overflow:
     tb = tb_alloc(pc);
     if (unlikely(!tb)) {
- buffer_overflow:
         /* flush must be done */
         tb_flush(cpu);
         mmap_unlock();
@@ -1367,9 +1396,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 #endif
 
-    tcg_ctx->code_gen_ptr = (void *)
+    atomic_set(&tcg_ctx->code_gen_ptr, (void *)
         ROUND_UP((uintptr_t)gen_code_buf + gen_code_size + search_size,
-                 CODE_GEN_ALIGN);
+                 CODE_GEN_ALIGN));
 
     /* init jump list */
     assert(((uintptr_t)tb & 3) == 0);
@@ -1921,9 +1950,8 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
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
index 7a8b29e..bc06c1c 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -979,6 +979,7 @@ int main(int argc, char **argv)
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init(tcg_ctx);
+    tcg_region_init(0);
 
     /* build Task State */
     memset(ts, 0, sizeof(TaskState));
diff --git a/cpus.c b/cpus.c
index 14bb8d5..5455819 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1664,6 +1664,18 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     char thread_name[VCPU_THREAD_NAME_SIZE];
     static QemuCond *single_tcg_halt_cond;
     static QemuThread *single_tcg_cpu_thread;
+    static int tcg_region_inited;
+
+    /*
+     * Initialize TCG regions--once, of course. Now is a good time, because:
+     * (1) TCG's init context, prologue and target globals have been set up.
+     * (2) qemu_tcg_mttcg_enabled() works now (TCG init code runs before the
+     *     -accel flag is processed, so the check doesn't work then).
+     */
+    if (!tcg_region_inited) {
+        softmmu_tcg_region_init();
+        tcg_region_inited = 1;
+    }
 
     if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
         cpu->thread = g_malloc0(sizeof(QemuThread));
diff --git a/linux-user/main.c b/linux-user/main.c
index ad4c6f5..0500628 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4457,6 +4457,7 @@ int main(int argc, char **argv, char **envp)
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init(tcg_ctx);
+    tcg_region_init(0);
 
 #if defined(TARGET_I386)
     env->cr[0] = CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e8aae1f..daec7d1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -33,6 +33,7 @@
 #include "qemu/cutils.h"
 #include "qemu/host-utils.h"
 #include "qemu/timer.h"
+#include "qemu/osdep.h"
 
 /* Note: the long term plan is to reduce the dependencies on the QEMU
    CPU definitions. Currently they are used for qemu_ld/st
@@ -120,6 +121,23 @@ static bool tcg_out_tb_finalize(TCGContext *s);
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
+    void *buf;      /* set at init time */
+    size_t n;       /* set at init time */
+    size_t size;    /* size of one region; set at init time */
+    size_t current; /* protected by the lock */
+    size_t n_full;  /* protected by the lock */
+};
+
+static struct tcg_region_state region;
+
 static TCGRegSet tcg_target_available_regs[2];
 static TCGRegSet tcg_target_call_clobber_regs;
 
@@ -257,6 +275,177 @@ TCGLabel *gen_new_label(void)
 
 #include "tcg-target.inc.c"
 
+static void tcg_region_assign(TCGContext *s, size_t curr_region)
+{
+    size_t guard_size = qemu_real_host_page_size;
+    void *buf = region.buf + curr_region * (region.size + guard_size);
+
+    s->code_gen_buffer = buf;
+    s->code_gen_ptr = buf;
+    s->code_gen_buffer_size = region.size;
+    s->code_gen_highwater = buf + region.size - TCG_HIGHWATER;
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
+
+    qemu_mutex_lock(&region.lock);
+    err = tcg_region_alloc__locked(s);
+    if (!err) {
+        region.n_full++;
+    }
+    qemu_mutex_unlock(&region.lock);
+    return err;
+}
+
+/*
+ * Perform a context's first region allocation.
+ * This function does _not_ increment region.n_full.
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
+    region.n_full = 0;
+
+    for (i = 0; i < n_tcg_ctxs; i++) {
+        if (unlikely(tcg_region_initial_alloc__locked(tcg_ctxs[i]))) {
+            tcg_abort();
+        }
+    }
+    qemu_mutex_unlock(&region.lock);
+}
+
+static void tcg_region_set_guard_pages(void)
+{
+    size_t guard_size = qemu_real_host_page_size;
+    size_t i;
+
+    for (i = 0; i < region.n; i++) {
+        void *guard = region.buf + region.size + i * (region.size + guard_size);
+
+        if (qemu_mprotect_none(guard, qemu_real_host_page_size)) {
+            tcg_abort();
+        }
+    }
+}
+
+/*
+ * Initializes region partitioning, setting the number of regions via
+ * @n_regions.
+ * Set @n_regions to 0 or 1 to use a single region that uses all of
+ * code_gen_buffer.
+ *
+ * Called at init time from the parent thread (i.e. the one calling
+ * tcg_context_init), after the target's TCG globals have been set.
+ *
+ * Region partitioning works by splitting code_gen_buffer into separate regions,
+ * and then assigning regions to TCG threads so that the threads can translate
+ * code in parallel without synchronization.
+ */
+void tcg_region_init(size_t n_regions)
+{
+    void *buf = tcg_init_ctx.code_gen_buffer;
+    size_t size = tcg_init_ctx.code_gen_buffer_size;
+
+    if (!n_regions) {
+        n_regions = 1;
+    }
+
+    /* start on a page-aligned address */
+    buf = QEMU_ALIGN_PTR_UP(buf, qemu_real_host_page_size);
+    if (unlikely(buf > tcg_init_ctx.code_gen_buffer + size)) {
+        tcg_abort();
+    }
+    /* discard that initial portion */
+    size -= buf - tcg_init_ctx.code_gen_buffer;
+
+    /* make region.size a multiple of page_size */
+    region.size = size / n_regions;
+    region.size &= qemu_real_host_page_mask;
+
+    /* A region must have at least 2 pages; one code, one guard */
+    if (unlikely(region.size < 2 * qemu_real_host_page_size)) {
+        tcg_abort();
+    }
+
+    /* do not count the guard page in region.size */
+    region.size -= qemu_real_host_page_size;
+    region.n = n_regions;
+    region.buf = buf;
+    tcg_region_set_guard_pages();
+    qemu_mutex_init(&region.lock);
+    /*
+     * We do not yet support multiple TCG contexts, so do the initial
+     * allocation now.
+     */
+    if (unlikely(tcg_region_initial_alloc__locked(tcg_ctx))) {
+        tcg_abort();
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
+    total = region.n_full * (region.size - TCG_HIGHWATER);
+    for (i = 0; i < n_tcg_ctxs; i++) {
+        const TCGContext *s = tcg_ctxs[i];
+        size_t size;
+
+        size = atomic_read(&s->code_gen_ptr) - s->code_gen_buffer;
+        if (unlikely(size > s->code_gen_buffer_size)) {
+            tcg_abort();
+        }
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
+    /* no need for synchronization; these variables are set at init time */
+    return region.n * (region.size - TCG_HIGHWATER);
+}
+
 /* pool based memory allocation */
 void *tcg_malloc_internal(TCGContext *s, int size)
 {
@@ -406,13 +595,17 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
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
     return tb;
 }
 
-- 
2.7.4
