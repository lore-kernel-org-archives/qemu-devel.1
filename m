Received: from eggs.gnu.org ([2001:4830:134:3::10]:50385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX45A-00045G-0j
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX457-0005nD-Rw
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:48:40 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX457-0005n2-Il
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:48:37 -0500
Received: by mail-wm0-x235.google.com with SMTP id c206so130574305wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:48:37 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:39:14 +0000
Message-Id: <20170127103922.19658-18-alex.bennee@linaro.org>
In-Reply-To: <20170127103922.19658-1-alex.bennee@linaro.org>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 17/25] cputlb: add tlb_flush_by_mmuidx async
 routines
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

This converts the remaining TLB flush routines to use async work when
detecting a cross-vCPU flush. The only minor complication is having to
serialise the var_list of MMU indexes into a form that can be punted
to an asynchronous job.

The pending_tlb_flush field on QOM's CPU structure also becomes a
bitfield rather than a boolean.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v7
  - un-merged from the atomic cputlb patch in the last series
  - fix long line reported by checkpatch
v8
  - re-base merge/fixes
---
 cputlb.c          | 110 +++++++++++++++++++++++++++++++++++++++++++-----------
 include/qom/cpu.h |   2 +-
 2 files changed, 89 insertions(+), 23 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 97e5c12de8..c50254be26 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -68,6 +68,11 @@
  * target_ulong even on 32 bit builds */
 QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
 
+/* We currently can't handle more than 16 bits in the MMUIDX bitmask.
+ */
+QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
+#define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
+
 /* statistics */
 int tlb_flush_count;
 
@@ -102,7 +107,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
 
     tb_unlock();
 
-    atomic_mb_set(&cpu->pending_tlb_flush, false);
+    atomic_mb_set(&cpu->pending_tlb_flush, 0);
 }
 
 static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
@@ -113,7 +118,8 @@ static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
 void tlb_flush(CPUState *cpu)
 {
     if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        if (atomic_cmpxchg(&cpu->pending_tlb_flush, false, true) == true) {
+        if (atomic_mb_read(&cpu->pending_tlb_flush) != ALL_MMUIDX_BITS) {
+            atomic_mb_set(&cpu->pending_tlb_flush, ALL_MMUIDX_BITS);
             async_run_on_cpu(cpu, tlb_flush_global_async_work,
                              RUN_ON_CPU_NULL);
         }
@@ -122,17 +128,18 @@ void tlb_flush(CPUState *cpu)
     }
 }
 
-static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
+static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
-    unsigned long mmu_idx_bitmask = idxmap;
+    unsigned long mmu_idx_bitmask = data.host_int;
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
-    tlb_debug("start\n");
 
     tb_lock();
 
+    tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
+
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
 
         if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
@@ -145,12 +152,30 @@ static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 
     memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
 
+    tlb_debug("done\n");
+
     tb_unlock();
 }
 
 void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
-    v_tlb_flush_by_mmuidx(cpu, idxmap);
+    tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
+
+    if (!qemu_cpu_is_self(cpu)) {
+        uint16_t pending_flushes = idxmap;
+        pending_flushes &= ~atomic_mb_read(&cpu->pending_tlb_flush);
+
+        if (pending_flushes) {
+            tlb_debug("reduced mmu_idx: 0x%" PRIx16 "\n", pending_flushes);
+
+            atomic_or(&cpu->pending_tlb_flush, pending_flushes);
+            async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
+                             RUN_ON_CPU_HOST_INT(pending_flushes));
+        }
+    } else {
+        tlb_flush_by_mmuidx_async_work(cpu,
+                                       RUN_ON_CPU_HOST_INT(idxmap));
+    }
 }
 
 static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
@@ -215,27 +240,26 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
     }
 }
 
-void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
+/* As we are going to hijack the bottom bits of the page address for a
+ * mmuidx bit mask we need to fail to build if we can't do that
+ */
+QEMU_BUILD_BUG_ON(NB_MMU_MODES > TARGET_PAGE_BITS_MIN);
+
+static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
+                                                run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
-    unsigned long mmu_idx_bitmap = idxmap;
-    int i, page, mmu_idx;
+    target_ulong addr_and_mmuidx = (target_ulong) data.target_ptr;
+    target_ulong addr = addr_and_mmuidx & TARGET_PAGE_MASK;
+    unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
+    int page = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    int mmu_idx;
+    int i;
 
     assert_cpu_is_self(cpu);
-    tlb_debug("addr "TARGET_FMT_lx"\n", addr);
-
-    /* Check if we need to flush due to large pages.  */
-    if ((addr & env->tlb_flush_mask) == env->tlb_flush_addr) {
-        tlb_debug("forced full flush ("
-                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
-                  env->tlb_flush_addr, env->tlb_flush_mask);
-
-        v_tlb_flush_by_mmuidx(cpu, idxmap);
-        return;
-    }
 
-    addr &= TARGET_PAGE_MASK;
-    page = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    tlb_debug("page:%d addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
+              page, addr, mmu_idx_bitmap);
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
@@ -251,6 +275,48 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
     tb_flush_jmp_cache(cpu, addr);
 }
 
+static void tlb_check_page_and_flush_by_mmuidx_async_work(CPUState *cpu,
+                                                          run_on_cpu_data data)
+{
+    CPUArchState *env = cpu->env_ptr;
+    target_ulong addr_and_mmuidx = (target_ulong) data.target_ptr;
+    target_ulong addr = addr_and_mmuidx & TARGET_PAGE_MASK;
+    unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
+
+    tlb_debug("addr:"TARGET_FMT_lx" mmu_idx: %04lx\n", addr, mmu_idx_bitmap);
+
+    /* Check if we need to flush due to large pages.  */
+    if ((addr & env->tlb_flush_mask) == env->tlb_flush_addr) {
+        tlb_debug("forced full flush ("
+                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
+                  env->tlb_flush_addr, env->tlb_flush_mask);
+
+        tlb_flush_by_mmuidx_async_work(cpu,
+                                       RUN_ON_CPU_HOST_INT(mmu_idx_bitmap));
+    } else {
+        tlb_flush_page_by_mmuidx_async_work(cpu, data);
+    }
+}
+
+void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
+{
+    target_ulong addr_and_mmu_idx;
+
+    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%" PRIx16 "\n", addr, idxmap);
+
+    /* This should already be page aligned */
+    addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
+    addr_and_mmu_idx |= idxmap;
+
+    if (!qemu_cpu_is_self(cpu)) {
+        async_run_on_cpu(cpu, tlb_check_page_and_flush_by_mmuidx_async_work,
+                         RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    } else {
+        tlb_check_page_and_flush_by_mmuidx_async_work(
+            cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    }
+}
+
 void tlb_flush_page_all(target_ulong addr)
 {
     CPUState *cpu;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 7f1d6a81a0..d996e5a0f4 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -403,7 +403,7 @@ struct CPUState {
      * avoid potential races. The aim of the flag is to avoid
      * unnecessary flushes.
      */
-    bool pending_tlb_flush;
+    uint16_t pending_tlb_flush;
 };
 
 QTAILQ_HEAD(CPUTailQ, CPUState);
-- 
2.11.0
