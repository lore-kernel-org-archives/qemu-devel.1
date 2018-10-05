Received: from eggs.gnu.org ([2001:4830:134:3::10]:56998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMB-0006bn-Nw
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM8-0006Br-6D
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:56268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM7-000637-MH
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id 206-v6so2310015wmb.5
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:56 +0100
Message-Id: <20181005154910.3099-8-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 07/21] accel/tcg/cputlb: convert tlb_flush
 debugging into trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Given the range of costs for various SoftMMU TLB operations from
deferring work for the currently running vCPU to bring the whole
emulated machine to a stop for synchronised updates simple counters
are less useful. Instead we log events via the trace infrastructure
and we can then post-process the data in a range of ways.

  tlb_flush_self - the vCPU flushed its own TLB
  tlb_flush_async_schedule - work was scheduled and the vCPU kicked
  tlb_flush_synced_schedule - exclusive work was scheduled on a vCPU
  tlb_flush_work - scheduled work was done
  tlb_flush_work_complete - scheduled work was completed

We can use the difference between the work being scheduled and
tlb_flush_work to calculate the latency introduced.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add tlb_flush_work_completed
  - removed tlb_debugs at the same time
---
 accel/tcg/cputlb.c     | 72 ++++++++++++++++++++++++------------------
 accel/tcg/trace-events | 16 ++++++++++
 2 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f4702ce91f..f1d4f7da44 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "trace.h"
 #include "exec/exec-all.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
@@ -138,7 +139,9 @@ static void tlb_flush_nocheck(CPUState *cpu)
 
 static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
 {
+    trace_tlb_flush_all_work(cpu->cpu_index);
     tlb_flush_nocheck(cpu);
+    trace_tlb_flush_work_complete(__LINE__, cpu->cpu_index);
 }
 
 void tlb_flush(CPUState *cpu)
@@ -146,17 +149,22 @@ void tlb_flush(CPUState *cpu)
     if (cpu->created && !qemu_cpu_is_self(cpu)) {
         if (atomic_mb_read(&cpu->pending_tlb_flush) != ALL_MMUIDX_BITS) {
             atomic_mb_set(&cpu->pending_tlb_flush, ALL_MMUIDX_BITS);
+            trace_tlb_flush_async_schedule(__LINE__, current_cpu ?
+                                           current_cpu->cpu_index :
+                                           cpu->cpu_index, cpu->cpu_index);
             async_run_on_cpu(cpu, tlb_flush_global_async_work,
                              RUN_ON_CPU_NULL);
         }
     } else {
-        tlb_flush_nocheck(cpu);
+        trace_tlb_flush_self(__LINE__, cpu->cpu_index);
+        tlb_flush_global_async_work(cpu, RUN_ON_CPU_NULL);
     }
 }
 
 void tlb_flush_all_cpus(CPUState *src_cpu)
 {
     const run_on_cpu_func fn = tlb_flush_global_async_work;
+    trace_tlb_flush_async_schedule(__LINE__, src_cpu->cpu_index, -1);
     flush_all_helper(src_cpu, fn, RUN_ON_CPU_NULL);
     fn(src_cpu, RUN_ON_CPU_NULL);
 }
@@ -164,6 +172,7 @@ void tlb_flush_all_cpus(CPUState *src_cpu)
 void tlb_flush_all_cpus_synced(CPUState *src_cpu)
 {
     const run_on_cpu_func fn = tlb_flush_global_async_work;
+    trace_tlb_flush_synced_schedule(__LINE__, src_cpu->cpu_index, -1);
     flush_all_helper(src_cpu, fn, RUN_ON_CPU_NULL);
     async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_NULL);
 }
@@ -174,15 +183,12 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     unsigned long mmu_idx_bitmask = data.host_int;
     int mmu_idx;
 
-    assert_cpu_is_self(cpu);
+    trace_tlb_flush_work(__LINE__, cpu->cpu_index, mmu_idx_bitmask);
 
-    tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
+    assert_cpu_is_self(cpu);
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-
         if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
-            tlb_debug("%d\n", mmu_idx);
-
             memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
             memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
         }
@@ -190,25 +196,26 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     cpu_tb_jmp_cache_clear(cpu);
 
-    tlb_debug("done\n");
+    trace_tlb_flush_work_complete(__LINE__, cpu->cpu_index);
 }
 
 void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
-    tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
-
     if (!qemu_cpu_is_self(cpu)) {
         uint16_t pending_flushes = idxmap;
         pending_flushes &= ~atomic_mb_read(&cpu->pending_tlb_flush);
 
         if (pending_flushes) {
-            tlb_debug("reduced mmu_idx: 0x%" PRIx16 "\n", pending_flushes);
+            trace_tlb_flush_async_schedule(__LINE__,
+                                           current_cpu->cpu_index,
+                                           cpu->cpu_index);
 
             atomic_or(&cpu->pending_tlb_flush, pending_flushes);
             async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
                              RUN_ON_CPU_HOST_INT(pending_flushes));
         }
     } else {
+        trace_tlb_flush_self(__LINE__, cpu->cpu_index);
         tlb_flush_by_mmuidx_async_work(cpu,
                                        RUN_ON_CPU_HOST_INT(idxmap));
     }
@@ -218,7 +225,7 @@ void tlb_flush_by_mmuidx_all_cpus(CPUState *src_cpu, uint16_t idxmap)
 {
     const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
 
-    tlb_debug("mmu_idx: 0x%"PRIx16"\n", idxmap);
+    trace_tlb_flush_async_schedule(__LINE__, src_cpu->cpu_index, -1);
 
     flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
     fn(src_cpu, RUN_ON_CPU_HOST_INT(idxmap));
@@ -229,7 +236,7 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
 {
     const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
 
-    tlb_debug("mmu_idx: 0x%"PRIx16"\n", idxmap);
+    trace_tlb_flush_synced_schedule(__LINE__, src_cpu->cpu_index, -1);
 
     flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
     async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
@@ -268,14 +275,10 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("page :" TARGET_FMT_lx "\n", addr);
+    trace_tlb_flush_work(__LINE__, cpu->cpu_index, addr);
 
     /* Check if we need to flush due to large pages.  */
     if ((addr & env->tlb_flush_mask) == env->tlb_flush_addr) {
-        tlb_debug("forcing full flush ("
-                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
-                  env->tlb_flush_addr, env->tlb_flush_mask);
-
         tlb_flush(cpu);
         return;
     }
@@ -288,16 +291,19 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
     }
 
     tb_flush_jmp_cache(cpu, addr);
+
+    trace_tlb_flush_work_complete(__LINE__, cpu->cpu_index);
 }
 
 void tlb_flush_page(CPUState *cpu, target_ulong addr)
 {
-    tlb_debug("page :" TARGET_FMT_lx "\n", addr);
-
     if (!qemu_cpu_is_self(cpu)) {
+        trace_tlb_flush_async_schedule(__LINE__, current_cpu->cpu_index,
+                                       cpu->cpu_index);
         async_run_on_cpu(cpu, tlb_flush_page_async_work,
                          RUN_ON_CPU_TARGET_PTR(addr));
     } else {
+        trace_tlb_flush_self(__LINE__, cpu->cpu_index);
         tlb_flush_page_async_work(cpu, RUN_ON_CPU_TARGET_PTR(addr));
     }
 }
@@ -319,8 +325,7 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("page:%d addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
-              page, addr, mmu_idx_bitmap);
+    trace_tlb_flush_work(__LINE__, cpu->cpu_index, addr_and_mmuidx);
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
@@ -330,6 +335,8 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     }
 
     tb_flush_jmp_cache(cpu, addr);
+
+    trace_tlb_flush_work_complete(__LINE__, cpu->cpu_index);
 }
 
 static void tlb_check_page_and_flush_by_mmuidx_async_work(CPUState *cpu,
@@ -340,35 +347,36 @@ static void tlb_check_page_and_flush_by_mmuidx_async_work(CPUState *cpu,
     target_ulong addr = addr_and_mmuidx & TARGET_PAGE_MASK;
     unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
 
-    tlb_debug("addr:"TARGET_FMT_lx" mmu_idx: %04lx\n", addr, mmu_idx_bitmap);
+    trace_tlb_flush_work(__LINE__, cpu->cpu_index, addr_and_mmuidx);
 
     /* Check if we need to flush due to large pages.  */
     if ((addr & env->tlb_flush_mask) == env->tlb_flush_addr) {
-        tlb_debug("forced full flush ("
-                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
-                  env->tlb_flush_addr, env->tlb_flush_mask);
-
+        trace_tlb_flush_self(__LINE__, cpu->cpu_index);
         tlb_flush_by_mmuidx_async_work(cpu,
                                        RUN_ON_CPU_HOST_INT(mmu_idx_bitmap));
     } else {
+        trace_tlb_flush_self(__LINE__, cpu->cpu_index);
         tlb_flush_page_by_mmuidx_async_work(cpu, data);
     }
+
+    trace_tlb_flush_work_complete(__LINE__, cpu->cpu_index);
 }
 
 void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
 {
     target_ulong addr_and_mmu_idx;
 
-    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%" PRIx16 "\n", addr, idxmap);
-
     /* This should already be page aligned */
     addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
     addr_and_mmu_idx |= idxmap;
 
     if (!qemu_cpu_is_self(cpu)) {
+        trace_tlb_flush_async_schedule(__LINE__, current_cpu->cpu_index,
+                                       cpu->cpu_index);
         async_run_on_cpu(cpu, tlb_check_page_and_flush_by_mmuidx_async_work,
                          RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
     } else {
+        trace_tlb_flush_self(__LINE__, cpu->cpu_index);
         tlb_check_page_and_flush_by_mmuidx_async_work(
             cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
     }
@@ -380,7 +388,7 @@ void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
     const run_on_cpu_func fn = tlb_check_page_and_flush_by_mmuidx_async_work;
     target_ulong addr_and_mmu_idx;
 
-    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
+    trace_tlb_flush_async_schedule(__LINE__, src_cpu->cpu_index, -1);
 
     /* This should already be page aligned */
     addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
@@ -397,7 +405,7 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     const run_on_cpu_func fn = tlb_check_page_and_flush_by_mmuidx_async_work;
     target_ulong addr_and_mmu_idx;
 
-    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
+    trace_tlb_flush_synced_schedule(__LINE__, src_cpu->cpu_index, -1);
 
     /* This should already be page aligned */
     addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
@@ -411,6 +419,8 @@ void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
 {
     const run_on_cpu_func fn = tlb_flush_page_async_work;
 
+    trace_tlb_flush_async_schedule(__LINE__, src->cpu_index, -1);
+
     flush_all_helper(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
     fn(src, RUN_ON_CPU_TARGET_PTR(addr));
 }
@@ -420,6 +430,8 @@ void tlb_flush_page_all_cpus_synced(CPUState *src,
 {
     const run_on_cpu_func fn = tlb_flush_page_async_work;
 
+    trace_tlb_flush_synced_schedule(__LINE__, src->cpu_index, -1);
+
     flush_all_helper(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
     async_safe_run_on_cpu(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
 }
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 618cc07738..0d2b1c47ac 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -1,5 +1,21 @@
 # Trace events for debugging and performance instrumentation
 
+# cputlb.c - SoftMMU TLB flushes
+#
+# There a numerous different functions for variations on flushing by
+# page/mmuidx and other critera. However we use common events and tag
+# them with the appropriate line number in cputlb.c
+#
+#   - setting to=-1 indicates work scheduled on all vCPUs
+#
+tlb_flush_self(int line, int vcpu) "cputlb.c:%d cpu %d"
+tlb_flush_async_schedule(int line, int from, int to) "cputlb.c:%d from_cpu=%d to_cpu=%d"
+tlb_flush_synced_schedule(int line, int from, int to) "cputlb.c:%d from_cpu=%d to_cpu=%d"
+# The following are the workers, usually running from a async work queue
+tlb_flush_all_work(int vcpu) "cpu %d"
+tlb_flush_work(int line, int vcpu, unsigned long data) "cputlb.c:%d cpu %d, %lux"
+tlb_flush_work_complete(int line, int vcpu) "cputlb.c:%d cpu %d"
+
 # TCG related tracing (you still need -d nochain to get a full picture
 # as otherwise you'll only see the first TB executed in a chain)
 # cpu-exec.c
-- 
2.17.1
