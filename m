Received: from eggs.gnu.org ([2001:4830:134:3::10]:47868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cK8IN-00070Z-Cc
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cK8IL-0004jC-E2
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:40:51 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:35588)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cK8IK-0004cf-RJ
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:40:49 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 22 Dec 2016 19:35:53 +0100
Message-Id: <148243175369.7321.10542077289437598179.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148243173750.7321.8231977784466776952.stgit@fimbulvetr.bsc.es>
References: <148243173750.7321.8231977784466776952.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/6] exec: [tcg] Use multiple physical TB
 caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

The physical TB cache is split into 2^E caches, where E is the number of
events with the "vcpu" and without the "disable" properties.

The virtual TB cache on each vCPU uses a (potentially) different
physical TB cache.

This is later exploited to support different tracing event states on a
per-vCPU basis.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 cpu-exec.c                |    5 +++-
 include/exec/exec-all.h   |    6 +++++
 include/exec/tb-context.h |    2 +-
 include/qom/cpu.h         |    2 ++
 qom/cpu.c                 |    2 ++
 translate-all.c           |   54 ++++++++++++++++++++++++++++++++++++++-=
------
 translate-all.h           |   17 ++++++++++++++
 translate-all.inc.h       |   13 +++++++++++
 8 files changed, 90 insertions(+), 11 deletions(-)
 create mode 100644 translate-all.inc.h

diff --git a/cpu-exec.c b/cpu-exec.c
index 4188fed3c6..a3d9eee17e 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -33,6 +33,7 @@
 #include "hw/i386/apic.h"
 #endif
 #include "sysemu/replay.h"
+#include "translate-all.h"
=20
 /* -icount align implementation. */
=20
@@ -298,6 +299,7 @@ static TranslationBlock *tb_htable_lookup(CPUState *c=
pu,
     tb_page_addr_t phys_pc;
     struct tb_desc desc;
     uint32_t h;
+    struct qht *qht;
=20
     desc.env =3D (CPUArchState *)cpu->env_ptr;
     desc.cs_base =3D cs_base;
@@ -306,7 +308,8 @@ static TranslationBlock *tb_htable_lookup(CPUState *c=
pu,
     phys_pc =3D get_page_addr_code(desc.env, pc);
     desc.phys_page1 =3D phys_pc & TARGET_PAGE_MASK;
     h =3D tb_hash_func(phys_pc, pc, flags);
-    return qht_lookup(&tcg_ctx.tb_ctx.htable, tb_cmp, &desc, h);
+    qht =3D tb_caches_get(&tcg_ctx.tb_ctx, cpu->tb_cache_idx);
+    return qht_lookup(qht, tb_cmp, &desc, h);
 }
=20
 static inline TranslationBlock *tb_find(CPUState *cpu,
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 57cd978578..feec0f2545 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -200,6 +200,10 @@ static inline void tlb_flush_by_mmuidx(CPUState *cpu=
, ...)
 #define USE_DIRECT_JUMP
 #endif
=20
+/**
+ * TranslationBlock:
+ * @tb_cache_idx: Index of physical TB cache where this TB has been allo=
cated.
+ */
 struct TranslationBlock {
     target_ulong pc;   /* simulated PC corresponding to this block (EIP =
+ CS base) */
     target_ulong cs_base; /* CS base for this block */
@@ -253,6 +257,8 @@ struct TranslationBlock {
      */
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_list_first;
+
+    unsigned long *tb_cache_idx;
 };
=20
 void tb_free(TranslationBlock *tb);
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index c7f17f26e0..f6a2b356e6 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -32,7 +32,7 @@ typedef struct TBContext TBContext;
 struct TBContext {
=20
     TranslationBlock *tbs;
-    struct qht htable;
+    struct qht *htables;
     int nb_tbs;
     /* any access to the tbs or the page table must use this lock */
     QemuMutex tb_lock;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 3f79a8e955..486872b752 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -295,6 +295,7 @@ struct qemu_work_item;
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to queued_work_*.
  * @queued_work_first: First asynchronous work pending.
+ * @tb_cache_idx: Index of current TB cache.
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask=
).
  *
  * State of one CPU core or thread.
@@ -370,6 +371,7 @@ struct CPUState {
      * Dynamically allocated based on bitmap requried to hold up to
      * trace_get_vcpu_event_count() entries.
      */
+    unsigned long *tb_cache_idx;
     unsigned long *trace_dstate;
=20
     /* TODO Move common fields from CPUArchState here. */
diff --git a/qom/cpu.c b/qom/cpu.c
index 03d9190f8c..8c702b7818 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -367,6 +367,7 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
=20
+    cpu->tb_cache_idx =3D bitmap_new(trace_get_vcpu_event_count());
     cpu->trace_dstate =3D bitmap_new(trace_get_vcpu_event_count());
=20
     cpu_exec_initfn(cpu);
@@ -376,6 +377,7 @@ static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu =3D CPU(obj);
     g_free(cpu->trace_dstate);
+    g_free(cpu->tb_cache_idx);
 }
=20
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
diff --git a/translate-all.c b/translate-all.c
index 29ccb9e546..1051ec6271 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -53,6 +53,7 @@
 #include "exec/cputlb.h"
 #include "exec/tb-hash.h"
 #include "translate-all.h"
+#include "qemu/error-report.h"
 #include "qemu/bitmap.h"
 #include "qemu/timer.h"
 #include "exec/log.h"
@@ -811,9 +812,19 @@ static inline void code_gen_alloc(size_t tb_size)
=20
 static void tb_htable_init(void)
 {
+    int cache;
     unsigned int mode =3D QHT_MODE_AUTO_RESIZE;
=20
-    qht_init(&tcg_ctx.tb_ctx.htable, CODE_GEN_HTABLE_SIZE, mode);
+    if (tb_caches_count() > ULONG_MAX) {
+        /* Ensure bitmaps can be used as indexes */
+        error_report("too many 'vcpu' events to index TB caches");
+    }
+
+    tcg_ctx.tb_ctx.htables =3D g_malloc(
+        sizeof(tcg_ctx.tb_ctx.htables[0]) * tb_caches_count());
+    for (cache =3D 0; cache < tb_caches_count(); cache++) {
+        qht_init(&tcg_ctx.tb_ctx.htables[cache], CODE_GEN_HTABLE_SIZE, m=
ode);
+    }
 }
=20
 /* Must be called before using the QEMU cpus. 'tb_size' is the size
@@ -856,6 +867,7 @@ static TranslationBlock *tb_alloc(target_ulong pc)
     tb->pc =3D pc;
     tb->cflags =3D 0;
     tb->invalid =3D false;
+    tb->tb_cache_idx =3D bitmap_new(trace_get_vcpu_event_count());
     return tb;
 }
=20
@@ -872,6 +884,8 @@ void tb_free(TranslationBlock *tb)
         tcg_ctx.code_gen_ptr =3D tb->tc_ptr;
         tcg_ctx.tb_ctx.nb_tbs--;
     }
+
+    g_free(tb->tb_cache_idx);
 }
=20
 static inline void invalidate_page_bitmap(PageDesc *p)
@@ -919,6 +933,8 @@ static void page_flush_tb(void)
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
+    int i;
+
     tb_lock();
=20
     /* If it is already been done on request of another CPU,
@@ -945,7 +961,9 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_dat=
a tb_flush_count)
     }
=20
     tcg_ctx.tb_ctx.nb_tbs =3D 0;
-    qht_reset_size(&tcg_ctx.tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
+    for (i =3D 0; i < tb_caches_count(); i++) {
+        qht_reset_size(&tcg_ctx.tb_ctx.htables[i], CODE_GEN_HTABLE_SIZE)=
;
+    }
     page_flush_tb();
=20
     tcg_ctx.code_gen_ptr =3D tcg_ctx.code_gen_buffer;
@@ -987,8 +1005,12 @@ do_tb_invalidate_check(struct qht *ht, void *p, uin=
t32_t hash, void *userp)
  */
 static void tb_invalidate_check(target_ulong address)
 {
+    int i;
+
     address &=3D TARGET_PAGE_MASK;
-    qht_iter(&tcg_ctx.tb_ctx.htable, do_tb_invalidate_check, &address);
+    for (i =3D 0; i < tb_caches_count(); i++) {
+        qht_iter(&tcg_ctx.tb_ctx.htables[i], do_tb_invalidate_check, &ad=
dress);
+    }
 }
=20
 static void
@@ -1008,7 +1030,10 @@ do_tb_page_check(struct qht *ht, void *p, uint32_t=
 hash, void *userp)
 /* verify that all the pages have correct rights for code */
 static void tb_page_check(void)
 {
-    qht_iter(&tcg_ctx.tb_ctx.htable, do_tb_page_check, NULL);
+    int i;
+    for (i =3D 0; i < tb_caches_count(); i++) {
+        qht_iter(&tcg_ctx.tb_ctx.htables[i], do_tb_page_check, NULL);
+    }
 }
=20
 #endif
@@ -1098,6 +1123,7 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_pa=
ge_addr_t page_addr)
     CPUState *cpu;
     PageDesc *p;
     uint32_t h;
+    struct qht *qht;
     tb_page_addr_t phys_pc;
=20
     assert_tb_lock();
@@ -1107,7 +1133,8 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_pa=
ge_addr_t page_addr)
     /* remove the TB from the hash list */
     phys_pc =3D tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
     h =3D tb_hash_func(phys_pc, tb->pc, tb->flags);
-    qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
+    qht =3D tb_caches_get(&tcg_ctx.tb_ctx, tb->tb_cache_idx);
+    qht_remove(qht, tb, h);
=20
     /* remove the TB from the page list */
     if (tb->page_addr[0] !=3D page_addr) {
@@ -1239,6 +1266,7 @@ static void tb_link_page(TranslationBlock *tb, tb_p=
age_addr_t phys_pc,
                          tb_page_addr_t phys_page2)
 {
     uint32_t h;
+    struct qht *qht;
=20
     assert_memory_lock();
=20
@@ -1252,7 +1280,8 @@ static void tb_link_page(TranslationBlock *tb, tb_p=
age_addr_t phys_pc,
=20
     /* add in the hash table */
     h =3D tb_hash_func(phys_pc, tb->pc, tb->flags);
-    qht_insert(&tcg_ctx.tb_ctx.htable, tb, h);
+    qht =3D tb_caches_get(&tcg_ctx.tb_ctx, tb->tb_cache_idx);
+    qht_insert(qht, tb, h);
=20
 #ifdef DEBUG_TB_CHECK
     tb_page_check();
@@ -1294,6 +1323,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cs_base =3D cs_base;
     tb->flags =3D flags;
     tb->cflags =3D cflags;
+    bitmap_copy(tb->tb_cache_idx, ENV_GET_CPU(env)->tb_cache_idx,
+                trace_get_vcpu_event_count());
=20
 #ifdef CONFIG_PROFILER
     tcg_ctx.tb_count1++; /* includes aborted translations because of
@@ -1798,6 +1829,8 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t reta=
ddr)
     pc =3D tb->pc;
     cs_base =3D tb->cs_base;
     flags =3D tb->flags;
+    /* XXX: It is OK to invalidate only this TB, as this is the one trig=
gering
+     * the memory access */
     tb_phys_invalidate(tb, -1);
     if (tb->cflags & CF_NOCACHE) {
         if (tb->orig_tb) {
@@ -1882,6 +1915,7 @@ void dump_exec_info(FILE *f, fprintf_function cpu_f=
printf)
     int direct_jmp_count, direct_jmp2_count, cross_page;
     TranslationBlock *tb;
     struct qht_stats hst;
+    int cache;
=20
     tb_lock();
=20
@@ -1935,9 +1969,11 @@ void dump_exec_info(FILE *f, fprintf_function cpu_=
fprintf)
                 tcg_ctx.tb_ctx.nb_tbs ? (direct_jmp2_count * 100) /
                         tcg_ctx.tb_ctx.nb_tbs : 0);
=20
-    qht_statistics_init(&tcg_ctx.tb_ctx.htable, &hst);
-    print_qht_statistics(f, cpu_fprintf, hst);
-    qht_statistics_destroy(&hst);
+    for (cache =3D 0; cache < tb_caches_count(); cache++) {
+        qht_statistics_init(&tcg_ctx.tb_ctx.htables[cache], &hst);
+        print_qht_statistics(f, cpu_fprintf, hst);
+        qht_statistics_destroy(&hst);
+    }
=20
     cpu_fprintf(f, "\nStatistics:\n");
     cpu_fprintf(f, "TB flush count      %u\n",
diff --git a/translate-all.h b/translate-all.h
index ba8e4d63c4..d39bf325d9 100644
--- a/translate-all.h
+++ b/translate-all.h
@@ -20,7 +20,21 @@
 #define TRANSLATE_ALL_H
=20
 #include "exec/exec-all.h"
+#include "qemu/typedefs.h"
=20
+/**
+ * tb_caches_count:
+ *
+ * Number of TB caches.
+ */
+static size_t tb_caches_count(void);
+
+/**
+ * tb_caches_get:
+ *
+ * Get the TB cache for the given bitmap index.
+ */
+static struct qht *tb_caches_get(TBContext *tb_ctx, unsigned long *bitma=
p);
=20
 /* translate-all.c */
 void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len);
@@ -33,4 +47,7 @@ void tb_check_watchpoint(CPUState *cpu);
 int page_unprotect(target_ulong address, uintptr_t pc);
 #endif
=20
+
+#include "translate-all.inc.h"
+
 #endif /* TRANSLATE_ALL_H */
diff --git a/translate-all.inc.h b/translate-all.inc.h
new file mode 100644
index 0000000000..f52627cfd6
--- /dev/null
+++ b/translate-all.inc.h
@@ -0,0 +1,13 @@
+/* Inline implementations for translate-all.h */
+
+static inline size_t tb_caches_count(void)
+{
+    return 1ULL << trace_get_vcpu_event_count();
+}
+
+static inline struct qht *tb_caches_get(TBContext *tb_ctx,
+                                        unsigned long *bitmap)
+{
+    unsigned long idx =3D *bitmap;
+    return &tb_ctx->htables[idx];
+}
