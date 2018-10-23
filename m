Received: from eggs.gnu.org ([2001:4830:134:3::10]:59467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqm4-0008O1-Vz
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqif-0003wI-39
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEqie-0003rh-CZ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id q7-v6so356515wrr.8
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 00:03:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 08:02:51 +0100
Message-Id: <20181023070253.6407-10-richard.henderson@linaro.org>
In-Reply-To: <20181023070253.6407-1-richard.henderson@linaro.org>
References: <20181023070253.6407-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/10] cputlb: Count "partial" and "elided" tlb
 flushes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

Our only statistic so far was "full" tlb flushes, where all mmu_idx
are flushed at the same time.

Now count "partial" tlb flushes where sets of mmu_idx are flushed,
but the set is not maximal.  Account one per mmu_idx flushed, as
that is the unit of work performed.

We don't actually count elided flushes yet, but go ahead and change
the interface presented to the monitor all at once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h   | 12 ++++++++++--
 include/exec/cputlb.h     |  2 +-
 accel/tcg/cputlb.c        | 18 +++++++++++++-----
 accel/tcg/translate-all.c |  8 ++++++--
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 181c0dbfa4..c7b501d627 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -166,6 +166,15 @@ typedef struct CPUTLBCommon {
      * mmu_idx may be discarded.  Protected by tlb_c.lock.
      */
     uint16_t pending_flush;
+
+    /*
+     * Statistics.  These are not lock protected, but are read and
+     * written atomically.  This allows the monitor to print a snapshot
+     * of the stats without interfering with the cpu.
+     */
+    size_t full_flush_count;
+    size_t part_flush_count;
+    size_t elide_flush_count;
 } CPUTLBCommon;
 
 /*
@@ -179,8 +188,7 @@ typedef struct CPUTLBCommon {
     CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];                  \
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
     CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
-    CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];                 \
-    size_t tlb_flush_count;
+    CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];
 
 #else
 
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index c91db211bc..5373188be3 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -23,6 +23,6 @@
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
-size_t tlb_flush_count(void);
+void tlb_flush_counts(size_t *full, size_t *part, size_t *elide);
 #endif
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 4447a5f028..5480115cb4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -100,17 +100,21 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
     }
 }
 
-size_t tlb_flush_count(void)
+void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
 {
     CPUState *cpu;
-    size_t count = 0;
+    size_t full = 0, part = 0, elide = 0;
 
     CPU_FOREACH(cpu) {
         CPUArchState *env = cpu->env_ptr;
 
-        count += atomic_read(&env->tlb_flush_count);
+        full += atomic_read(&env->tlb_c.full_flush_count);
+        part += atomic_read(&env->tlb_c.part_flush_count);
+        elide += atomic_read(&env->tlb_c.elide_flush_count);
     }
-    return count;
+    *pfull = full;
+    *ppart = part;
+    *pelide = elide;
 }
 
 static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
@@ -145,7 +149,11 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     cpu_tb_jmp_cache_clear(cpu);
 
     if (mmu_idx_bitmask == ALL_MMUIDX_BITS) {
-        atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
+        atomic_set(&env->tlb_c.full_flush_count,
+                   env->tlb_c.full_flush_count + 1);
+    } else {
+        atomic_set(&env->tlb_c.part_flush_count,
+                   env->tlb_c.part_flush_count + ctpop16(mmu_idx_bitmask));
     }
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 356dcd0948..639f0b2728 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2290,7 +2290,7 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
 {
     struct tb_tree_stats tst = {};
     struct qht_stats hst;
-    size_t nb_tbs;
+    size_t nb_tbs, flush_full, flush_part, flush_elide;
 
     tcg_tb_foreach(tb_tree_stats_iter, &tst);
     nb_tbs = tst.nb_tbs;
@@ -2326,7 +2326,11 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     cpu_fprintf(f, "TB flush count      %u\n",
                 atomic_read(&tb_ctx.tb_flush_count));
     cpu_fprintf(f, "TB invalidate count %zu\n", tcg_tb_phys_invalidate_count());
-    cpu_fprintf(f, "TLB flush count     %zu\n", tlb_flush_count());
+
+    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
+    cpu_fprintf(f, "TLB full flushes    %zu\n", flush_full);
+    cpu_fprintf(f, "TLB partial flushes %zu\n", flush_part);
+    cpu_fprintf(f, "TLB elided flushes  %zu\n", flush_elide);
     tcg_dump_info(f, cpu_fprintf);
 }
 
-- 
2.17.2
