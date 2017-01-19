Received: from eggs.gnu.org ([2001:4830:134:3::10]:38951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9W-0007j8-Qh
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9V-0007vg-AD
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:34 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUG9V-0007vI-13
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:33 -0500
Received: by mail-wm0-x236.google.com with SMTP id c206so2830262wme.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:05:32 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:04:58 +0000
Message-Id: <20170119170507.16185-19-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 18/27] cputlb: introduce tlb_flush_*_all_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This introduces support to the cputlb API for flushing all CPUs TLBs
with one call. This avoids the need for target helpers to iterate
through the vCPUs themselves. Additionally these functions provide a
"wait" argument which will cause the work to be scheduled and the
calling vCPU to exit its loop. The result will be all the flush
operations will be complete by the time the originating vCPU starts
executing again.

It is up to the caller to ensure enough state has been saved so
execution can be restarted at the next appropriate instruction.

Some guest architectures can defer completion of flush operations
until later and are free to set wait to false. If they later schedule
work using the async_safe_work mechanism they can be sure other vCPUs
will have flushed their TLBs by the point execution returns from the
safe work.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v7
  - some checkpatch long line fixes
---
 cputlb.c                | 100 +++++++++++++++++++++++++++++++++++++++++++++---
 include/exec/exec-all.h |  65 +++++++++++++++++++++++++++++--
 2 files changed, 156 insertions(+), 9 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 856213cbcb..3e1cf9b516 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -73,6 +73,40 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
+/* flush_all_helper: run fn across all cpus
+ *
+ * If the wait flag is set then the src cpu's helper will be queued as
+ * "safe" work and the loop exited creating a synchronisation point
+ * where all queued work will be finished before execution starts
+ * again.
+ */
+static void flush_all_helper(CPUState *src, bool wait,
+                             run_on_cpu_func fn, run_on_cpu_data d)
+{
+    CPUState *cpu;
+
+    if (!wait) {
+        CPU_FOREACH(cpu) {
+            if (cpu != src) {
+                async_run_on_cpu(cpu, fn, d);
+            } else {
+                g_assert(qemu_cpu_is_self(src));
+                fn(src, d);
+            }
+        }
+    } else {
+        CPU_FOREACH(cpu) {
+            if (cpu != src) {
+                async_run_on_cpu(cpu, fn, d);
+            } else {
+                async_safe_run_on_cpu(cpu, fn, d);
+            }
+
+        }
+        cpu_loop_exit(src);
+    }
+}
+
 /* statistics */
 int tlb_flush_count;
 
@@ -140,6 +174,12 @@ void tlb_flush(CPUState *cpu)
     }
 }
 
+void tlb_flush_all_cpus(CPUState *src_cpu, bool wait)
+{
+    flush_all_helper(src_cpu, wait, tlb_flush_global_async_work,
+                     RUN_ON_CPU_NULL);
+}
+
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -214,6 +254,29 @@ void tlb_flush_by_mmuidx(CPUState *cpu, ...)
     }
 }
 
+/* This function affects all vCPUs are will ensure all work is
+ * complete by the time the loop restarts
+ */
+void tlb_flush_by_mmuidx_all_cpus(CPUState *src_cpu, bool wait, ...)
+{
+    va_list argp;
+    unsigned long mmu_idx_bitmap;
+
+    va_start(argp, wait);
+    mmu_idx_bitmap = make_mmu_index_bitmap(argp);
+    va_end(argp);
+
+    tlb_debug("mmu_idx: 0x%04lx\n", mmu_idx_bitmap);
+
+    flush_all_helper(src_cpu, wait,
+                     tlb_flush_by_mmuidx_async_work,
+                     RUN_ON_CPU_HOST_ULONG(mmu_idx_bitmap));
+
+    /* Will not return if wait == true */
+    g_assert(!wait);
+}
+
+
 static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
 {
     if (addr == (tlb_entry->addr_read &
@@ -359,14 +422,39 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
     }
 }
 
-void tlb_flush_page_all(target_ulong addr)
+/* This function affects all vCPUs are will ensure all work is
+ * complete by the time the loop restarts
+ */
+void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, bool wait,
+                                       target_ulong addr, ...)
 {
-    CPUState *cpu;
+    unsigned long mmu_idx_bitmap;
+    target_ulong addr_and_mmu_idx;
+    va_list argp;
 
-    CPU_FOREACH(cpu) {
-        async_run_on_cpu(cpu, tlb_flush_page_async_work,
-                         RUN_ON_CPU_TARGET_PTR(addr));
-    }
+    va_start(argp, addr);
+    mmu_idx_bitmap = make_mmu_index_bitmap(argp);
+    va_end(argp);
+
+    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%lx\n", addr, mmu_idx_bitmap);
+
+    /* This should already be page aligned */
+    addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
+    addr_and_mmu_idx |= mmu_idx_bitmap;
+
+    flush_all_helper(src_cpu, wait,
+                     tlb_check_page_and_flush_by_mmuidx_async_work,
+                     RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    /* Will not return if wait == true */
+    g_assert(!wait);
+}
+
+void tlb_flush_page_all_cpus(CPUState *src, bool wait, target_ulong addr)
+{
+    flush_all_helper(src, wait,
+                     tlb_flush_page_async_work, RUN_ON_CPU_TARGET_PTR(addr));
+    /* Will not return if wait == true */
+    g_assert(!wait);
 }
 
 /* update the TLBs so that writes to code in the virtual page 'addr'
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index e43cb68355..c93e8fc090 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -93,6 +93,18 @@ void cpu_address_space_init(CPUState *cpu, AddressSpace *as, int asidx);
  */
 void tlb_flush_page(CPUState *cpu, target_ulong addr);
 /**
+ * tlb_flush_page_all_cpus:
+ * @cpu: src CPU of the flush
+ * @wait: If true ensure synchronisation by exiting the cpu_loop
+ * @addr: virtual address of page to be flushed
+ *
+ * Flush one page from the TLB of the specified CPU, for all
+ * MMU indexes. If the caller forces synchronisation they need to
+ * ensure all register state is synchronised as we will exit the
+ * cpu_loop.
+ */
+void tlb_flush_page_all_cpus(CPUState *src, bool wait, target_ulong addr);
+/**
  * tlb_flush:
  * @cpu: CPU whose TLB should be flushed
  *
@@ -103,6 +115,16 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr);
  */
 void tlb_flush(CPUState *cpu);
 /**
+ * tlb_flush_all_cpus:
+ * @cpu: src CPU of the flush
+ * @wait: If true ensure synchronisation by exiting the cpu_loop
+ *
+ * If the caller forces synchronisation they need to
+ * ensure all register state is synchronised as we will exit the
+ * cpu_loop.
+ */
+void tlb_flush_all_cpus(CPUState *src_cpu, bool wait);
+/**
  * tlb_flush_page_by_mmuidx:
  * @cpu: CPU whose TLB should be flushed
  * @addr: virtual address of page to be flushed
@@ -113,8 +135,22 @@ void tlb_flush(CPUState *cpu);
  */
 void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...);
 /**
+ * tlb_flush_page_by_mmuidx_all_cpus:
+ * @cpu: Originating CPU of the flush
+ * @wait: If true ensure synchronisation by exiting the cpu_loop
+ * @addr: virtual address of page to be flushed
+ * @...: list of MMU indexes to flush, terminated by a negative value
+ *
+ * Flush one page from the TLB of all CPUs, for the specified
+ * MMU indexes. This function does not return, the run loop will exit
+ * and restart once the flush is completed.
+ */
+void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu, bool wait,
+                                       target_ulong addr, ...);
+/**
  * tlb_flush_by_mmuidx:
  * @cpu: CPU whose TLB should be flushed
+ * @wait: If true ensure synchronisation by exiting the cpu_loop
  * @...: list of MMU indexes to flush, terminated by a negative value
  *
  * Flush all entries from the TLB of the specified CPU, for the specified
@@ -122,6 +158,18 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...);
  */
 void tlb_flush_by_mmuidx(CPUState *cpu, ...);
 /**
+ * tlb_flush_by_mmuidx_all_cpus:
+ * @cpu: Originating CPU of the flush
+ * @wait: If true ensure synchronisation by exiting the cpu_loop
+ * @...: list of MMU indexes to flush, terminated by a negative value
+ *
+ * Flush all entries from all TLBs of all CPUs, for the specified
+ * MMU indexes. If the caller forces synchronisation they need to
+ * ensure all register state is synchronised as we will exit the
+ * cpu_loop.
+ */
+void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, bool wait, ...);
+/**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
  * @vaddr: virtual address of page to add entry for
@@ -158,24 +206,35 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
 void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr);
 void probe_write(CPUArchState *env, target_ulong addr, int mmu_idx,
                  uintptr_t retaddr);
-void tlb_flush_page_all(target_ulong addr);
 #else
 static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
 {
 }
-
+static inline void tlb_flush_page_all_cpus(CPUState *src, bool wait,
+                                           target_ulong addr)
+{
+}
 static inline void tlb_flush(CPUState *cpu)
 {
 }
-
+static inline void tlb_flush_all_cpus(CPUState *src_cpu, bool wait)
+{
+}
 static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
                                             target_ulong addr, ...)
 {
 }
 
+static inline void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu, bool wait,
+                                                     target_ulong addr, ...)
+{
+}
 static inline void tlb_flush_by_mmuidx(CPUState *cpu, ...)
 {
 }
+static inline void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, bool wait, ...)
+{
+}
 #endif
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
-- 
2.11.0
