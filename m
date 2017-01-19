Received: from eggs.gnu.org ([2001:4830:134:3::10]:38911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9V-0007hL-7E
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9R-0007u4-UG
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:33 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUG9R-0007ta-L8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:29 -0500
Received: by mail-wm0-x233.google.com with SMTP id c206so2827519wme.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:05:29 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:04:56 +0000
Message-Id: <20170119170507.16185-17-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 16/27] cputlb: add tlb_flush_by_mmuidx async
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
---
 cputlb.c          | 160 +++++++++++++++++++++++++++++++++++++++++-------------
 include/qom/cpu.h |  12 ++--
 2 files changed, 127 insertions(+), 45 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 36388b29b8..207faf2ea0 100644
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
@@ -125,7 +130,8 @@ static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
 void tlb_flush(CPUState *cpu)
 {
     if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        if (atomic_cmpxchg(&cpu->pending_tlb_flush, false, true) == true) {
+        if (atomic_mb_read(&cpu->pending_tlb_flush) != ALL_MMUIDX_BITS) {
+            atomic_mb_set(&cpu->pending_tlb_flush, ALL_MMUIDX_BITS);
             async_run_on_cpu(cpu, tlb_flush_global_async_work,
                              RUN_ON_CPU_NULL);
         }
@@ -134,39 +140,78 @@ void tlb_flush(CPUState *cpu)
     }
 }
 
-static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, va_list argp)
+static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
+    unsigned long mmu_idx_bitmask = data.host_ulong;
+    int mmu_idx;
 
     assert_cpu_is_self(cpu);
-    tlb_debug("start\n");
 
     tb_lock();
 
-    for (;;) {
-        int mmu_idx = va_arg(argp, int);
+    tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
 
-        if (mmu_idx < 0) {
-            break;
-        }
+    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
 
-        tlb_debug("%d\n", mmu_idx);
+        if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
+            tlb_debug("%d\n", mmu_idx);
 
-        memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
-        memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
+            memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
+            memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
+        }
     }
 
     memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
 
+    tlb_debug("done\n");
+
     tb_unlock();
 }
 
+/* Helper function to slurp va_args list into a bitmap
+ */
+static inline unsigned long make_mmu_index_bitmap(va_list args)
+{
+    unsigned long bitmap = 0;
+    int mmu_index = va_arg(args, int);
+
+    /* An empty va_list would be a bad call */
+    g_assert(mmu_index > 0);
+
+    do {
+        set_bit(mmu_index, &bitmap);
+        mmu_index = va_arg(args, int);
+    } while (mmu_index >= 0);
+
+    return bitmap;
+}
+
 void tlb_flush_by_mmuidx(CPUState *cpu, ...)
 {
     va_list argp;
+    unsigned long mmu_idx_bitmap;
+
     va_start(argp, cpu);
-    v_tlb_flush_by_mmuidx(cpu, argp);
+    mmu_idx_bitmap = make_mmu_index_bitmap(argp);
     va_end(argp);
+
+    tlb_debug("mmu_idx: 0x%04lx\n", mmu_idx_bitmap);
+
+    if (!qemu_cpu_is_self(cpu)) {
+        uint16_t pending_flushes =
+            mmu_idx_bitmap & ~atomic_mb_read(&cpu->pending_tlb_flush);
+        if (pending_flushes) {
+            tlb_debug("reduced mmu_idx: 0x%" PRIx16 "\n", pending_flushes);
+
+            atomic_or(&cpu->pending_tlb_flush, pending_flushes);
+            async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
+                             RUN_ON_CPU_HOST_INT(pending_flushes));
+        }
+    } else {
+        tlb_flush_by_mmuidx_async_work(cpu,
+                                       RUN_ON_CPU_HOST_ULONG(mmu_idx_bitmap));
+    }
 }
 
 static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
@@ -231,16 +276,50 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
     }
 }
 
-void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
+/* As we are going to hijack the bottom bits of the page address for a
+ * mmuidx bit mask we need to fail to build if we can't do that
+ */
+QEMU_BUILD_BUG_ON(NB_MMU_MODES > TARGET_PAGE_BITS_MIN);
+
+static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
+                                                run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
-    int i, k;
-    va_list argp;
-
-    va_start(argp, addr);
+    target_ulong addr_and_mmuidx = (target_ulong) data.target_ptr;
+    target_ulong addr = addr_and_mmuidx & TARGET_PAGE_MASK;
+    unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
+    int page = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    int mmu_idx;
+    int i;
 
     assert_cpu_is_self(cpu);
-    tlb_debug("addr "TARGET_FMT_lx"\n", addr);
+
+    tlb_debug("page:%d addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
+              page, addr, mmu_idx_bitmap);
+
+    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+        if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
+            tlb_flush_entry(&env->tlb_table[mmu_idx][page], addr);
+
+            /* check whether there are vltb entries that need to be flushed */
+            for (i = 0; i < CPU_VTLB_SIZE; i++) {
+                tlb_flush_entry(&env->tlb_v_table[mmu_idx][i], addr);
+            }
+        }
+    }
+
+    tb_flush_jmp_cache(cpu, addr);
+}
+
+static void tlb_check_page_and_flush_by_mmuidx_async_work(CPUState *cpu,
+                                                          run_on_cpu_data data)
+{
+    CPUArchState *env = cpu->env_ptr;
+    target_ulong addr_and_mmuidx = (target_ulong) data.target_ptr;
+    target_ulong addr = addr_and_mmuidx & TARGET_PAGE_MASK;
+    unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
+
+    tlb_debug("addr:"TARGET_FMT_lx" mmu_idx: %04lx\n", addr, mmu_idx_bitmap);
 
     /* Check if we need to flush due to large pages.  */
     if ((addr & env->tlb_flush_mask) == env->tlb_flush_addr) {
@@ -248,33 +327,36 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
                   TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
                   env->tlb_flush_addr, env->tlb_flush_mask);
 
-        v_tlb_flush_by_mmuidx(cpu, argp);
-        va_end(argp);
-        return;
+        tlb_flush_by_mmuidx_async_work(cpu,
+                                       RUN_ON_CPU_HOST_ULONG(mmu_idx_bitmap));
+    } else {
+        tlb_flush_page_by_mmuidx_async_work(cpu, data);
     }
+}
 
-    addr &= TARGET_PAGE_MASK;
-    i = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-
-    for (;;) {
-        int mmu_idx = va_arg(argp, int);
+void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
+{
+    unsigned long mmu_idx_bitmap;
+    target_ulong addr_and_mmu_idx;
+    va_list argp;
 
-        if (mmu_idx < 0) {
-            break;
-        }
+    va_start(argp, addr);
+    mmu_idx_bitmap = make_mmu_index_bitmap(argp);
+    va_end(argp);
 
-        tlb_debug("idx %d\n", mmu_idx);
+    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%lx\n", addr, mmu_idx_bitmap);
 
-        tlb_flush_entry(&env->tlb_table[mmu_idx][i], addr);
+    /* This should already be page aligned */
+    addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
+    addr_and_mmu_idx |= mmu_idx_bitmap;
 
-        /* check whether there are vltb entries that need to be flushed */
-        for (k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_flush_entry(&env->tlb_v_table[mmu_idx][k], addr);
-        }
+    if (!qemu_cpu_is_self(cpu)) {
+        async_run_on_cpu(cpu, tlb_check_page_and_flush_by_mmuidx_async_work,
+                         RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    } else {
+        tlb_check_page_and_flush_by_mmuidx_async_work(
+            cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
     }
-    va_end(argp);
-
-    tb_flush_jmp_cache(cpu, addr);
 }
 
 void tlb_flush_page_all(target_ulong addr)
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 880ba4254e..d945221811 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -388,17 +388,17 @@ struct CPUState {
      */
     bool throttle_thread_scheduled;
 
+    /* The pending_tlb_flush flag is set and cleared atomically to
+     * avoid potential races. The aim of the flag is to avoid
+     * unnecessary flushes.
+     */
+    uint16_t pending_tlb_flush;
+
     /* Note that this is accessed at the start of every TB via a negative
        offset from AREG0.  Leave this field at the end so as to make the
        (absolute value) offset as small as possible.  This reduces code
        size, especially for hosts without large memory offsets.  */
     uint32_t tcg_exit_req;
-
-    /* The pending_tlb_flush flag is set and cleared atomically to
-     * avoid potential races. The aim of the flag is to avoid
-     * unnecessary flushes.
-     */
-    bool pending_tlb_flush;
 };
 
 QTAILQ_HEAD(CPUTailQ, CPUState);
-- 
2.11.0
