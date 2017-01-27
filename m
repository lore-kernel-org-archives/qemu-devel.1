Received: from eggs.gnu.org ([2001:4830:134:3::10]:48112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3sP-00081m-9C
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3sN-0002FM-5y
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:29 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX3sM-0002Eq-Tm
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:27 -0500
Received: by mail-wm0-x232.google.com with SMTP id r126so110796511wmr.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:35:26 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:34:59 +0000
Message-Id: <20170127103505.18606-20-alex.bennee@linaro.org>
In-Reply-To: <20170127103505.18606-1-alex.bennee@linaro.org>
References: <20170127103505.18606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 19/25] cputlb: introduce
 tlb_flush_*_all_cpus[_synced]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>

This introduces support to the cputlb API for flushing all CPUs TLBs
with one call. This avoids the need for target helpers to iterate
through the vCPUs themselves.

An additional variant of the API (_synced) do not return from the
caller and will cause the work to be scheduled as "safe work". The
result will be all the flush operations will be complete by the time
the originating vCPU starts executing again. It is up to the caller to
ensure enough state has been saved so execution can be restarted at
the next appropriate instruction.

Some guest architectures can defer completion of flush operations
until later. If they later schedule work using the async_safe_work
mechanism they can be sure other vCPUs will have flushed their TLBs by
the point execution returns from the safe work.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v7
  - some checkpatch long line fixes
v8
  - change from varg to bitmap calling convention
  - add _synced variants, re-factored helper
---
 cputlb.c                | 110 +++++++++++++++++++++++++++++++++++++++++++---
 include/exec/exec-all.h | 114 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 215 insertions(+), 9 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 65003350e3..7f9a54f253 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -73,6 +73,25 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
+/* flush_all_helper: run fn across all cpus
+ *
+ * If the wait flag is set then the src cpu's helper will be queued as
+ * "safe" work and the loop exited creating a synchronisation point
+ * where all queued work will be finished before execution starts
+ * again.
+ */
+static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
+                             run_on_cpu_data d)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (cpu != src) {
+            async_run_on_cpu(cpu, fn, d);
+        }
+    }
+}
+
 /* statistics */
 int tlb_flush_count;
 
@@ -128,6 +147,19 @@ void tlb_flush(CPUState *cpu)
     }
 }
 
+void tlb_flush_all_cpus(CPUState *src_cpu)
+{
+    flush_all_helper(src_cpu, tlb_flush_global_async_work, RUN_ON_CPU_NULL);
+    tlb_flush_global_async_work(src_cpu, RUN_ON_CPU_NULL);
+}
+
+void QEMU_NORETURN tlb_flush_all_cpus_synced(CPUState *src_cpu)
+{
+    flush_all_helper(src_cpu, tlb_flush_global_async_work, RUN_ON_CPU_NULL);
+    tlb_flush_global_async_work(src_cpu, RUN_ON_CPU_NULL);
+    cpu_loop_exit(src_cpu);
+}
+
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -178,6 +210,30 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
     }
 }
 
+void tlb_flush_by_mmuidx_all_cpus(CPUState *src_cpu, uint16_t idxmap)
+{
+    const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
+
+    tlb_debug("mmu_idx: 0x%"PRIx16"\n", idxmap);
+
+    flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
+    fn(src_cpu, RUN_ON_CPU_HOST_INT(idxmap));
+}
+
+void QEMU_NORETURN tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
+                                                       uint16_t idxmap)
+{
+    const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
+
+    tlb_debug("mmu_idx: 0x%"PRIx16"\n", idxmap);
+
+    flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
+    async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
+    cpu_loop_exit(src_cpu);
+}
+
+
+
 static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
 {
     if (addr == (tlb_entry->addr_read &
@@ -317,14 +373,56 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
     }
 }
 
-void tlb_flush_page_all(target_ulong addr)
+void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
+                                       uint16_t idxmap)
 {
-    CPUState *cpu;
+    const run_on_cpu_func fn = tlb_check_page_and_flush_by_mmuidx_async_work;
+    target_ulong addr_and_mmu_idx;
 
-    CPU_FOREACH(cpu) {
-        async_run_on_cpu(cpu, tlb_flush_page_async_work,
-                         RUN_ON_CPU_TARGET_PTR(addr));
-    }
+    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
+
+    /* This should already be page aligned */
+    addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
+    addr_and_mmu_idx |= idxmap;
+
+    flush_all_helper(src_cpu, fn, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    fn(src_cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+}
+
+void QEMU_NORETURN tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
+                                                            target_ulong addr,
+                                                            uint16_t idxmap)
+{
+    const run_on_cpu_func fn = tlb_check_page_and_flush_by_mmuidx_async_work;
+    target_ulong addr_and_mmu_idx;
+
+    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
+
+    /* This should already be page aligned */
+    addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
+    addr_and_mmu_idx |= idxmap;
+
+    flush_all_helper(src_cpu, fn, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    cpu_loop_exit(src_cpu);
+}
+
+void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
+{
+    const run_on_cpu_func fn = tlb_flush_page_async_work;
+
+    flush_all_helper(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
+    fn(src, RUN_ON_CPU_TARGET_PTR(addr));
+}
+
+void QEMU_NORETURN tlb_flush_page_all_cpus_synced(CPUState *src,
+                                                  target_ulong addr)
+{
+    const run_on_cpu_func fn = tlb_flush_page_async_work;
+
+    flush_all_helper(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
+    async_safe_run_on_cpu(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
+    cpu_loop_exit(src);
 }
 
 /* update the TLBs so that writes to code in the virtual page 'addr'
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a6c17ed74a..cffed39fe9 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -93,6 +93,27 @@ void cpu_address_space_init(CPUState *cpu, AddressSpace *as, int asidx);
  */
 void tlb_flush_page(CPUState *cpu, target_ulong addr);
 /**
+ * tlb_flush_page_all_cpus:
+ * @cpu: src CPU of the flush
+ * @addr: virtual address of page to be flushed
+ *
+ * Flush one page from the TLB of the specified CPU, for all
+ * MMU indexes.
+ */
+void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr);
+/**
+ * tlb_flush_page_all_cpus_synced:
+ * @cpu: src CPU of the flush
+ * @addr: virtual address of page to be flushed
+ *
+ * Flush one page from the TLB of the specified CPU, for all
+ * MMU indexes like tlb_flush_page_all_cpus except this function does
+ * not return and will restart the run-loop once all CPUs have
+ * executed the flush.
+ */
+void QEMU_NORETURN tlb_flush_page_all_cpus_synced(CPUState *src,
+                                                  target_ulong addr);
+/**
  * tlb_flush:
  * @cpu: CPU whose TLB should be flushed
  *
@@ -103,6 +124,19 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr);
  */
 void tlb_flush(CPUState *cpu);
 /**
+ * tlb_flush_all_cpus:
+ * @cpu: src CPU of the flush
+ */
+void tlb_flush_all_cpus(CPUState *src_cpu);
+/**
+ * tlb_flush_all_cpus_synced:
+ * @cpu: src CPU of the flush
+ *
+ * Like tlb_flush_all_cpus except this function does not return and
+ * will restart the run-loop once all CPUs have executed the flush.
+ */
+void QEMU_NORETURN tlb_flush_all_cpus_synced(CPUState *src_cpu);
+/**
  * tlb_flush_page_by_mmuidx:
  * @cpu: CPU whose TLB should be flushed
  * @addr: virtual address of page to be flushed
@@ -114,8 +148,34 @@ void tlb_flush(CPUState *cpu);
 void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr,
                               uint16_t idxmap);
 /**
+ * tlb_flush_page_by_mmuidx_all_cpus:
+ * @cpu: Originating CPU of the flush
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush one page from the TLB of all CPUs, for the specified
+ * MMU indexes.
+ */
+void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu, target_ulong addr,
+                                       uint16_t idxmap);
+/**
+ * tlb_flush_page_by_mmuidx_all_cpus_synced:
+ * @cpu: Originating CPU of the flush
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush one page from the TLB of all CPUs, for the specified MMU
+ * indexes like tlb_flush_page_by_mmuidx_all_cpus except this function
+ * does not return and will restart the run-loop once all CPUs have
+ * executed the flush.
+ */
+void QEMU_NORETURN tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                            target_ulong addr,
+                                                            uint16_t idxmap);
+/**
  * tlb_flush_by_mmuidx:
  * @cpu: CPU whose TLB should be flushed
+ * @wait: If true ensure synchronisation by exiting the cpu_loop
  * @idxmap: bitmap of MMU indexes to flush
  *
  * Flush all entries from the TLB of the specified CPU, for the specified
@@ -123,6 +183,27 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr,
  */
 void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
 /**
+ * tlb_flush_by_mmuidx_all_cpus:
+ * @cpu: Originating CPU of the flush
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush all entries from all TLBs of all CPUs, for the specified
+ * MMU indexes.
+ */
+void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap);
+/**
+ * tlb_flush_by_mmuidx_all_cpus_synced:
+ * @cpu: Originating CPU of the flush
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush all entries from all TLBs of all CPUs, for the specified
+ * MMU indexes like tlb_flush_by_mmuidx_all_cpus except this function
+ * does not return and will restart the run-loop once all CPUs have
+ * executed the flush.
+ */
+void QEMU_NORETURN tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                       uint16_t idxmap);
+/**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
  * @vaddr: virtual address of page to add entry for
@@ -159,16 +240,26 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
 void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr);
 void probe_write(CPUArchState *env, target_ulong addr, int mmu_idx,
                  uintptr_t retaddr);
-void tlb_flush_page_all(target_ulong addr);
 #else
 static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
 {
 }
-
+static inline void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
+{
+}
+static inline void tlb_flush_page_all_cpus_synced(CPUState *src,
+                                                  target_ulong addr)
+{
+}
 static inline void tlb_flush(CPUState *cpu)
 {
 }
-
+static inline void tlb_flush_all_cpus(CPUState *src_cpu)
+{
+}
+static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
+{
+}
 static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
                                             target_ulong addr, uint16_t idxmap)
 {
@@ -177,6 +268,23 @@ static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
 static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
 }
+static inline void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu,
+                                                     target_ulong addr,
+                                                     uint16_t idxmap)
+{
+}
+static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                            target_ulong addr,
+                                                            uint16_t idxmap)
+{
+}
+static inline void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap)
+{
+}
+static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                       uint16_t idxmap)
+{
+}
 #endif
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
-- 
2.11.0
