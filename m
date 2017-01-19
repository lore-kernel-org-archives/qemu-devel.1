Received: from eggs.gnu.org ([2001:4830:134:3::10]:38857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9R-0007dW-7o
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9P-0007t0-Pl
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:29 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUG9P-0007se-HF
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:27 -0500
Received: by mail-wm0-x234.google.com with SMTP id c206so2825824wme.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:05:27 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:04:55 +0000
Message-Id: <20170119170507.16185-16-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 15/27] cputlb: introduce tlb_flush_* async
 work.
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

From: KONRAD Frederic <fred.konrad@greensocs.com>

Some architectures allow to flush the tlb of other VCPUs. This is not a problem
when we have only one thread for all VCPUs but it definitely needs to be an
asynchronous work when we are in true multithreaded work.

We take the tb_lock() when doing this to avoid racing with other threads
which may be invalidating TB's at the same time. The alternative would
be to use proper atomic primitives to clear the tlb entries en-mass.

This patch doesn't do anything to protect other cputlb function being
called in MTTCG mode making cross vCPU changes.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
[AJB: remove need for g_malloc on defer, make check fixes, tb_lock]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v6 (base patches)
  - don't use cmpxchg_bool (we drop it later anyway)
  - use RUN_ON_CPU macros instead of inlines
  - bug out of tlb_flush if !tcg_enabled() (MacOSX make check failure)
v5 (base patches)
  - take tb_lock() for memset
  - ensure tb_flush_page properly asyncs work for other vCPUs
  - use run_on_cpu_data
v4 (base_patches)
  - brought forward from arm enabling series
  - restore pending_tlb_flush flag
v1
  - Remove tlb_flush_all just do the check in tlb_flush.
  - remove the need to g_malloc
  - tlb_flush calls direct if !cpu->created

fixup! cputlb: introduce tlb_flush_* async work.
---
 cputlb.c                | 78 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/exec/exec-all.h |  1 +
 include/qom/cpu.h       |  6 ++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 94fa9977c5..36388b29b8 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -64,6 +64,10 @@
         }                                                         \
     } while (0)
 
+/* run_on_cpu_data.target_ptr should always be big enough for a
+ * target_ulong even on 32 bit builds */
+QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
+
 /* statistics */
 int tlb_flush_count;
 
@@ -72,13 +76,22 @@ int tlb_flush_count;
  * flushing more entries than required is only an efficiency issue,
  * not a correctness issue.
  */
-void tlb_flush(CPUState *cpu)
+static void tlb_flush_nocheck(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
 
+    /* The QOM tests will trigger tlb_flushes without setting up TCG
+     * so we bug out here in that case.
+     */
+    if (!tcg_enabled()) {
+        return;
+    }
+
     assert_cpu_is_self(cpu);
     tlb_debug("(count: %d)\n", tlb_flush_count++);
 
+    tb_lock();
+
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
     memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
@@ -86,6 +99,39 @@ void tlb_flush(CPUState *cpu)
     env->vtlb_index = 0;
     env->tlb_flush_addr = -1;
     env->tlb_flush_mask = 0;
+
+    tb_unlock();
+
+    atomic_mb_set(&cpu->pending_tlb_flush, false);
+}
+
+static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
+{
+    tlb_flush_nocheck(cpu);
+}
+
+/* NOTE:
+ * If flush_global is true (the usual case), flush all tlb entries.
+ * If flush_global is false, flush (at least) all tlb entries not
+ * marked global.
+ *
+ * Since QEMU doesn't currently implement a global/not-global flag
+ * for tlb entries, at the moment tlb_flush() will also flush all
+ * tlb entries in the flush_global == false case. This is OK because
+ * CPU architectures generally permit an implementation to drop
+ * entries from the TLB at any time, so flushing more entries than
+ * required is only an efficiency issue, not a correctness issue.
+ */
+void tlb_flush(CPUState *cpu)
+{
+    if (cpu->created && !qemu_cpu_is_self(cpu)) {
+        if (atomic_cmpxchg(&cpu->pending_tlb_flush, false, true) == true) {
+            async_run_on_cpu(cpu, tlb_flush_global_async_work,
+                             RUN_ON_CPU_NULL);
+        }
+    } else {
+        tlb_flush_nocheck(cpu);
+    }
 }
 
 static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, va_list argp)
@@ -95,6 +141,8 @@ static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, va_list argp)
     assert_cpu_is_self(cpu);
     tlb_debug("start\n");
 
+    tb_lock();
+
     for (;;) {
         int mmu_idx = va_arg(argp, int);
 
@@ -109,6 +157,8 @@ static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, va_list argp)
     }
 
     memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
+
+    tb_unlock();
 }
 
 void tlb_flush_by_mmuidx(CPUState *cpu, ...)
@@ -131,13 +181,15 @@ static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
     }
 }
 
-void tlb_flush_page(CPUState *cpu, target_ulong addr)
+static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
+    target_ulong addr = (target_ulong) data.target_ptr;
     int i;
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
+
     tlb_debug("page :" TARGET_FMT_lx "\n", addr);
 
     /* Check if we need to flush due to large pages.  */
@@ -167,6 +219,18 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
     tb_flush_jmp_cache(cpu, addr);
 }
 
+void tlb_flush_page(CPUState *cpu, target_ulong addr)
+{
+    tlb_debug("page :" TARGET_FMT_lx "\n", addr);
+
+    if (!qemu_cpu_is_self(cpu)) {
+        async_run_on_cpu(cpu, tlb_flush_page_async_work,
+                         RUN_ON_CPU_TARGET_PTR(addr));
+    } else {
+        tlb_flush_page_async_work(cpu, RUN_ON_CPU_TARGET_PTR(addr));
+    }
+}
+
 void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -213,6 +277,16 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
     tb_flush_jmp_cache(cpu, addr);
 }
 
+void tlb_flush_page_all(target_ulong addr)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        async_run_on_cpu(cpu, tlb_flush_page_async_work,
+                         RUN_ON_CPU_TARGET_PTR(addr));
+    }
+}
+
 /* update the TLBs so that writes to code in the virtual page 'addr'
    can be detected */
 void tlb_protect_code(ram_addr_t ram_addr)
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index bd4622ac5d..e43cb68355 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -158,6 +158,7 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
 void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr);
 void probe_write(CPUArchState *env, target_ulong addr, int mmu_idx,
                  uintptr_t retaddr);
+void tlb_flush_page_all(target_ulong addr);
 #else
 static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
 {
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1735374ad6..880ba4254e 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -393,6 +393,12 @@ struct CPUState {
        (absolute value) offset as small as possible.  This reduces code
        size, especially for hosts without large memory offsets.  */
     uint32_t tcg_exit_req;
+
+    /* The pending_tlb_flush flag is set and cleared atomically to
+     * avoid potential races. The aim of the flag is to avoid
+     * unnecessary flushes.
+     */
+    bool pending_tlb_flush;
 };
 
 QTAILQ_HEAD(CPUTailQ, CPUState);
-- 
2.11.0
