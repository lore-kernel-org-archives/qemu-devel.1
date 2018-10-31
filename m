Received: from eggs.gnu.org ([2001:4830:134:3::10]:48921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVg-0000pw-Du
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVe-0001tu-Sv
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHpVc-0001CS-BH
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id j26-v6so2077117wre.1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:21:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 12:21:15 +0000
Message-Id: <20181031122119.1669-7-richard.henderson@linaro.org>
In-Reply-To: <20181031122119.1669-1-richard.henderson@linaro.org>
References: <20181031122119.1669-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 06/10] cputlb: Merge tlb_flush_nocheck into
 tlb_flush_by_mmuidx_async_work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The difference between the two sets of APIs is now miniscule.

This allows tlb_flush, tlb_flush_all_cpus, and tlb_flush_all_cpus_synced
to be merged with their corresponding by_mmuidx functions as well.  For
accounting, consider mmu_idx_bitmask = ALL_MMUIDX_BITS to be a full flush.

Tested-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 93 +++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 72 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2cd3886fd6..a3a417e81a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -122,75 +122,6 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
     env->tlb_d[mmu_idx].vindex = 0;
 }
 
-/* This is OK because CPU architectures generally permit an
- * implementation to drop entries from the TLB at any time, so
- * flushing more entries than required is only an efficiency issue,
- * not a correctness issue.
- */
-static void tlb_flush_nocheck(CPUState *cpu)
-{
-    CPUArchState *env = cpu->env_ptr;
-    int mmu_idx;
-
-    assert_cpu_is_self(cpu);
-    atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
-    tlb_debug("(count: %zu)\n", tlb_flush_count());
-
-    /*
-     * tlb_table/tlb_v_table updates from any thread must hold tlb_c.lock.
-     * However, updates from the owner thread (as is the case here; see the
-     * above assert_cpu_is_self) do not need atomic_set because all reads
-     * that do not hold the lock are performed by the same owner thread.
-     */
-    qemu_spin_lock(&env->tlb_c.lock);
-    env->tlb_c.pending_flush = 0;
-    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_flush_one_mmuidx_locked(env, mmu_idx);
-    }
-    qemu_spin_unlock(&env->tlb_c.lock);
-
-    cpu_tb_jmp_cache_clear(cpu);
-}
-
-static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
-{
-    tlb_flush_nocheck(cpu);
-}
-
-void tlb_flush(CPUState *cpu)
-{
-    if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        CPUArchState *env = cpu->env_ptr;
-        uint16_t pending;
-
-        qemu_spin_lock(&env->tlb_c.lock);
-        pending = env->tlb_c.pending_flush;
-        env->tlb_c.pending_flush = ALL_MMUIDX_BITS;
-        qemu_spin_unlock(&env->tlb_c.lock);
-
-        if (pending != ALL_MMUIDX_BITS) {
-            async_run_on_cpu(cpu, tlb_flush_global_async_work,
-                             RUN_ON_CPU_NULL);
-        }
-    } else {
-        tlb_flush_nocheck(cpu);
-    }
-}
-
-void tlb_flush_all_cpus(CPUState *src_cpu)
-{
-    const run_on_cpu_func fn = tlb_flush_global_async_work;
-    flush_all_helper(src_cpu, fn, RUN_ON_CPU_NULL);
-    fn(src_cpu, RUN_ON_CPU_NULL);
-}
-
-void tlb_flush_all_cpus_synced(CPUState *src_cpu)
-{
-    const run_on_cpu_func fn = tlb_flush_global_async_work;
-    flush_all_helper(src_cpu, fn, RUN_ON_CPU_NULL);
-    async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_NULL);
-}
-
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -212,13 +143,17 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     qemu_spin_unlock(&env->tlb_c.lock);
 
     cpu_tb_jmp_cache_clear(cpu);
+
+    if (mmu_idx_bitmask == ALL_MMUIDX_BITS) {
+        atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
+    }
 }
 
 void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
-    if (!qemu_cpu_is_self(cpu)) {
+    if (cpu->created && !qemu_cpu_is_self(cpu)) {
         CPUArchState *env = cpu->env_ptr;
         uint16_t pending, to_clean;
 
@@ -238,6 +173,11 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
     }
 }
 
+void tlb_flush(CPUState *cpu)
+{
+    tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
+}
+
 void tlb_flush_by_mmuidx_all_cpus(CPUState *src_cpu, uint16_t idxmap)
 {
     const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
@@ -248,8 +188,12 @@ void tlb_flush_by_mmuidx_all_cpus(CPUState *src_cpu, uint16_t idxmap)
     fn(src_cpu, RUN_ON_CPU_HOST_INT(idxmap));
 }
 
-void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
-                                                       uint16_t idxmap)
+void tlb_flush_all_cpus(CPUState *src_cpu)
+{
+    tlb_flush_by_mmuidx_all_cpus(src_cpu, ALL_MMUIDX_BITS);
+}
+
+void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu, uint16_t idxmap)
 {
     const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
 
@@ -259,6 +203,11 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
 }
 
+void tlb_flush_all_cpus_synced(CPUState *src_cpu)
+{
+    tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, ALL_MMUIDX_BITS);
+}
+
 static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
                                         target_ulong page)
 {
-- 
2.17.2
