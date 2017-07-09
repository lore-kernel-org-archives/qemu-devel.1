Received: from eggs.gnu.org ([2001:4830:134:3::10]:46520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zN-0004Sn-8a
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zF-000320-Cl
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:45 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-000308-Te
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:37 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:12 -0400
Message-Id: <1499586614-20507-21-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 20/22] tcg: dynamically allocate from
 code_gen_buffer using equally-sized regions
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

In preparation for having multiple TCG threads.

The naive solution here is to split code_gen_buffer statically
among the TCG threads; this however results in poor utilization
if translation needs are different across TCG threads.

What we do here is to add an extra layer of indirection, assigning
regions that act just like pages do in virtual memory allocation.
(BTW if you are wondering about the chosen naming, I did not want
to use blocks or pages because those are already heavily used in QEMU).

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
 tcg/tcg.h                 |   8 +++
 accel/tcg/translate-all.c |  61 ++++++++++++----
 bsd-user/main.c           |   1 +
 linux-user/main.c         |   1 +
 tcg/tcg.c                 | 175 +++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 230 insertions(+), 16 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index be5f3fd..a767a33 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -761,6 +761,14 @@ void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
+void tcg_region_init(TCGContext *s);
+bool tcg_region_alloc(TCGContext *s);
+void tcg_region_set_size(size_t size);
+void tcg_region_reset_all(void);
+
+size_t tcg_code_size(void);
+size_t tcg_code_capacity(void);
+
 /* Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
 {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 31a9d42..ce9d746 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -53,11 +53,13 @@
 #include "exec/cputlb.h"
 #include "exec/tb-hash.h"
 #include "translate-all.h"
+#include "qemu/error-report.h"
 #include "qemu/bitmap.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "sysemu/cpus.h"
+#include "sysemu/sysemu.h"
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
@@ -808,6 +810,41 @@ static inline void code_gen_alloc(size_t tb_size)
     qemu_mutex_init(&tb_ctx.tb_lock);
 }
 
+#ifdef CONFIG_SOFTMMU
+/*
+ * It is likely that some vCPUs will translate more code than others, so we
+ * first try to set more regions than smp_cpus, with those regions being
+ * larger than the minimum code_gen_buffer size. If that's not possible we
+ * make do by evenly dividing the code_gen_buffer among the vCPUs.
+ */
+static void code_gen_set_region_size(TCGContext *s)
+{
+    size_t per_cpu = s->code_gen_buffer_size / smp_cpus;
+    size_t div;
+
+    assert(per_cpu);
+    /*
+     * Use a single region if all we have is one vCPU.
+     * We could also use a single region with !mttcg, but at this time we have
+     * not yet processed the thread=single|multi flag.
+     */
+    if (smp_cpus == 1) {
+        tcg_region_set_size(0);
+        return;
+    }
+
+    for (div = 8; div > 0; div--) {
+        size_t region_size = per_cpu / div;
+
+        if (region_size >= 2 * MIN_CODE_GEN_BUFFER_SIZE) {
+            tcg_region_set_size(region_size);
+            return;
+        }
+    }
+    tcg_region_set_size(per_cpu);
+}
+#endif
+
 static void tb_htable_init(void)
 {
     unsigned int mode = QHT_MODE_AUTO_RESIZE;
@@ -829,6 +866,8 @@ void tcg_exec_init(unsigned long tb_size)
     /* There's no guest base to take into account, so go ahead and
        initialize the prologue now.  */
     tcg_prologue_init(&tcg_ctx);
+    code_gen_set_region_size(&tcg_ctx);
+    tcg_region_init(&tcg_ctx);
 #endif
 }
 
@@ -929,14 +968,9 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 #if defined(DEBUG_TB_FLUSH)
     g_tree_foreach(tb_ctx.tb_tree, tb_host_size_iter, &host_size);
     nb_tbs = g_tree_nnodes(tb_ctx.tb_tree);
-    printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%zu\n",
-           (unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer),
-           nb_tbs, nb_tbs > 0 ? host_size / nb_tbs : 0);
+    fprintf(stderr, "qemu: flush code_size=%zu nb_tbs=%d avg_tb_size=%zu\n",
+           tcg_code_size(), nb_tbs, nb_tbs > 0 ? host_size / nb_tbs : 0);
 #endif
-    if ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)
-        > tcg_ctx.code_gen_buffer_size) {
-        cpu_abort(cpu, "Internal error: code buffer overflow\n");
-    }
 
     CPU_FOREACH(cpu) {
         cpu_tb_jmp_cache_clear(cpu);
@@ -949,7 +983,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
 
-    tcg_ctx.code_gen_ptr = tcg_ctx.code_gen_buffer;
+    tcg_region_reset_all();
     /* XXX: flush processor icache at this point if cache flush is
        expensive */
     atomic_mb_set(&tb_ctx.tb_flush_count, tb_ctx.tb_flush_count + 1);
@@ -1281,9 +1315,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         cflags |= CF_USE_ICOUNT;
     }
 
+ buffer_overflow:
     tb = tb_alloc(pc);
     if (unlikely(!tb)) {
- buffer_overflow:
         /* flush must be done */
         tb_flush(cpu);
         mmap_unlock();
@@ -1366,9 +1400,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 #endif
 
-    tcg_ctx.code_gen_ptr = (void *)
+    atomic_set(&tcg_ctx.code_gen_ptr, (void *)
         ROUND_UP((uintptr_t)gen_code_buf + gen_code_size + search_size,
-                 CODE_GEN_ALIGN);
+                 CODE_GEN_ALIGN));
 
     /* init jump list */
     assert(((uintptr_t)tb & 3) == 0);
@@ -1907,9 +1941,8 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
      * otherwise users might think "-tb-size" is not honoured.
      * For avg host size we use the precise numbers from tb_tree_stats though.
      */
-    cpu_fprintf(f, "gen code size       %td/%zd\n",
-                tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer,
-                tcg_ctx.code_gen_highwater - tcg_ctx.code_gen_buffer);
+    cpu_fprintf(f, "gen code size       %zu/%zd\n",
+                tcg_code_size(), tcg_code_capacity());
     cpu_fprintf(f, "TB count            %d\n", nb_tbs);
     cpu_fprintf(f, "TB avg target size  %zu max=%zu bytes\n",
                 nb_tbs ? tst.target_size / nb_tbs : 0,
diff --git a/bsd-user/main.c b/bsd-user/main.c
index fa9c012..1a16052 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -979,6 +979,7 @@ int main(int argc, char **argv)
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init(&tcg_ctx);
+    tcg_region_init(&tcg_ctx);
 
     /* build Task State */
     memset(ts, 0, sizeof(TaskState));
diff --git a/linux-user/main.c b/linux-user/main.c
index 630c73d..b73759c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4457,6 +4457,7 @@ int main(int argc, char **argv, char **envp)
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init(&tcg_ctx);
+    tcg_region_init(&tcg_ctx);
 
 #if defined(TARGET_I386)
     env->cr[0] = CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8febf53..03ebc8c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -129,6 +129,23 @@ static QemuMutex tcg_lock;
 static QSIMPLEQ_HEAD(, TCGContext) ctx_list =
     QSIMPLEQ_HEAD_INITIALIZER(ctx_list);
 
+/*
+ * We divide code_gen_buffer into equally-sized "regions" that TCG threads
+ * dynamically allocate from as demand dictates. Given appropriate region
+ * sizing, this minimizes flushes even when some TCG threads generate a lot
+ * more code than others.
+ */
+struct tcg_region_state {
+    void *buf;
+    size_t n;
+    size_t current;
+    size_t n_full;
+    size_t size; /* size of one region */
+};
+
+/* protected by tcg_lock */
+static struct tcg_region_state region;
+
 static TCGRegSet tcg_target_available_regs[2];
 static TCGRegSet tcg_target_call_clobber_regs;
 
@@ -410,6 +427,156 @@ void tcg_context_init(TCGContext *s)
     tcg_register_thread();
 }
 
+static void tcg_region_set_size__locked(size_t size)
+{
+    if (!size) {
+        region.size = tcg_init_ctx->code_gen_buffer_size;
+        region.n = 1;
+    } else {
+        region.size = size;
+        region.n = tcg_init_ctx->code_gen_buffer_size / size;
+    }
+    if (unlikely(region.size < TCG_HIGHWATER)) {
+        tcg_abort();
+    }
+}
+
+/*
+ * Call this function at init time (i.e. only once). Calling this function is
+ * optional: if no region size is set, a single region will be used.
+ *
+ * Note: calling this function *after* calling tcg_region_init() is a bug.
+ */
+void tcg_region_set_size(size_t size)
+{
+    tcg_debug_assert(!region.size);
+
+    qemu_mutex_lock(&tcg_lock);
+    tcg_region_set_size__locked(size);
+    qemu_mutex_unlock(&tcg_lock);
+}
+
+static void tcg_region_assign__locked(TCGContext *s)
+{
+    void *buf = region.buf + region.size * region.current;
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
+        return false;
+    }
+    tcg_region_assign__locked(s);
+    region.current++;
+    return true;
+}
+
+/*
+ * Request a new region once the one in use has filled up.
+ * Note: upon initializing a TCG thread, allocate a new region with
+ * tcg_region_init() instead.
+ * Returns true on success.
+ * */
+bool tcg_region_alloc(TCGContext *s)
+{
+    bool success;
+
+    qemu_mutex_lock(&tcg_lock);
+    success = tcg_region_alloc__locked(s);
+    if (success) {
+        region.n_full++;
+    }
+    qemu_mutex_unlock(&tcg_lock);
+    return success;
+}
+
+/*
+ * Allocate an initial region.
+ * All TCG threads must have called this function before any of them initiates
+ * translation.
+ *
+ * The region size might have previously been set by tcg_region_set_size();
+ * otherwise a single region will be used on the entire code_gen_buffer.
+ *
+ * Note: allocate subsequent regions with tcg_region_alloc().
+ */
+void tcg_region_init(TCGContext *s)
+{
+    qemu_mutex_lock(&tcg_lock);
+    if (region.buf == NULL) {
+        region.buf = tcg_init_ctx->code_gen_buffer;
+    }
+    if (!region.size) {
+        tcg_region_set_size__locked(0);
+    }
+    /* if we cannot allocate on init, then we did something wrong */
+    if (!tcg_region_alloc__locked(s)) {
+        tcg_abort();
+    }
+    qemu_mutex_unlock(&tcg_lock);
+
+}
+
+/* Call from a safe-work context */
+void tcg_region_reset_all(void)
+{
+    TCGContext *s;
+
+    qemu_mutex_lock(&tcg_lock);
+    region.current = 0;
+    region.n_full = 0;
+
+    QSIMPLEQ_FOREACH(s, &ctx_list, entry) {
+        if (unlikely(!tcg_region_alloc__locked(s))) {
+            tcg_abort();
+        }
+    }
+    qemu_mutex_unlock(&tcg_lock);
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
+    const TCGContext *s;
+    size_t total;
+
+    qemu_mutex_lock(&tcg_lock);
+    total = region.n_full * (region.size - TCG_HIGHWATER);
+    QSIMPLEQ_FOREACH(s, &ctx_list, entry) {
+        size_t size;
+
+        size = atomic_read(&s->code_gen_ptr) - s->code_gen_buffer;
+        if (unlikely(size > s->code_gen_buffer_size)) {
+            tcg_abort();
+        }
+        total += size;
+    }
+    qemu_mutex_unlock(&tcg_lock);
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
 /*
  * Clone the initial TCGContext. Used by TCG threads to copy the TCGContext
  * set up by their parent thread via tcg_context_init().
@@ -432,13 +599,17 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
     TranslationBlock *tb;
     void *next;
 
+ retry:
     tb = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
     next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);
 
     if (unlikely(next > s->code_gen_highwater)) {
-        return NULL;
+        if (!tcg_region_alloc(s)) {
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
