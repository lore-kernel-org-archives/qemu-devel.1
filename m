Received: from eggs.gnu.org ([2001:4830:134:3::10]:60133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqm3-0008Ro-Kl
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqid-0003tD-S9
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEqid-0003kv-EJ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id 143-v6so529641wmf.1
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 00:03:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 08:02:46 +0100
Message-Id: <20181023070253.6407-5-richard.henderson@linaro.org>
In-Reply-To: <20181023070253.6407-1-richard.henderson@linaro.org>
References: <20181023070253.6407-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/10] cputlb: Move cpu->pending_tlb_flush to
 env->tlb_c.pending_flush
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

Protect it with the tlb_lock instead of using atomics.
The move puts it in or near the same cacheline as the lock;
using the lock means we don't need a second atomic operation
in order to perform the update.  Which makes it cheap to also
update pending_flush in tlb_flush_by_mmuidx_async_work.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h |  8 +++++++-
 include/qom/cpu.h       |  6 ------
 accel/tcg/cputlb.c      | 35 +++++++++++++++++++++++------------
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 9005923b4d..659c73d2a1 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -145,8 +145,14 @@ typedef struct CPUIOTLBEntry {
  * Data elements that are shared between all MMU modes.
  */
 typedef struct CPUTLBCommon {
-    /* lock serializes updates to tlb_table and tlb_v_table */
+    /* Serialize updates to tlb_table and tlb_v_table, and others as noted. */
     QemuSpin lock;
+    /*
+     * Within pending_flush, for each bit N, there exists an outstanding
+     * cross-cpu flush for mmu_idx N.  Further cross-cpu flushes to that
+     * mmu_idx may be discarded.  Protected by tlb_c.lock.
+     */
+    uint16_t pending_flush;
 } CPUTLBCommon;
 
 /*
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 4e238b0d9f..c0d13064c9 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -429,12 +429,6 @@ struct CPUState {
 
     struct hax_vcpu_state *hax_vcpu;
 
-    /* The pending_tlb_flush flag is set and cleared atomically to
-     * avoid potential races. The aim of the flag is to avoid
-     * unnecessary flushes.
-     */
-    uint16_t pending_tlb_flush;
-
     int hvf_fd;
 
     /* track IOMMUs whose translations we've cached in the TCG TLB */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d080769c83..abcd08a8a2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -133,6 +133,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
      * that do not hold the lock are performed by the same owner thread.
      */
     qemu_spin_lock(&env->tlb_c.lock);
+    env->tlb_c.pending_flush = 0;
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
     qemu_spin_unlock(&env->tlb_c.lock);
@@ -142,8 +143,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
     env->vtlb_index = 0;
     env->tlb_flush_addr = -1;
     env->tlb_flush_mask = 0;
-
-    atomic_mb_set(&cpu->pending_tlb_flush, 0);
 }
 
 static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
@@ -154,8 +153,15 @@ static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
 void tlb_flush(CPUState *cpu)
 {
     if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        if (atomic_mb_read(&cpu->pending_tlb_flush) != ALL_MMUIDX_BITS) {
-            atomic_mb_set(&cpu->pending_tlb_flush, ALL_MMUIDX_BITS);
+        CPUArchState *env = cpu->env_ptr;
+        uint16_t pending;
+
+        qemu_spin_lock(&env->tlb_c.lock);
+        pending = env->tlb_c.pending_flush;
+        env->tlb_c.pending_flush = ALL_MMUIDX_BITS;
+        qemu_spin_unlock(&env->tlb_c.lock);
+
+        if (pending != ALL_MMUIDX_BITS) {
             async_run_on_cpu(cpu, tlb_flush_global_async_work,
                              RUN_ON_CPU_NULL);
         }
@@ -189,6 +195,8 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
 
     qemu_spin_lock(&env->tlb_c.lock);
+    env->tlb_c.pending_flush &= ~mmu_idx_bitmask;
+
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
 
         if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
@@ -210,19 +218,22 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
     if (!qemu_cpu_is_self(cpu)) {
-        uint16_t pending_flushes = idxmap;
-        pending_flushes &= ~atomic_mb_read(&cpu->pending_tlb_flush);
+        CPUArchState *env = cpu->env_ptr;
+        uint16_t pending, to_clean;
 
-        if (pending_flushes) {
-            tlb_debug("reduced mmu_idx: 0x%" PRIx16 "\n", pending_flushes);
+        qemu_spin_lock(&env->tlb_c.lock);
+        pending = env->tlb_c.pending_flush;
+        to_clean = idxmap & ~pending;
+        env->tlb_c.pending_flush = pending | idxmap;
+        qemu_spin_unlock(&env->tlb_c.lock);
 
-            atomic_or(&cpu->pending_tlb_flush, pending_flushes);
+        if (to_clean) {
+            tlb_debug("reduced mmu_idx: 0x%" PRIx16 "\n", to_clean);
             async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
-                             RUN_ON_CPU_HOST_INT(pending_flushes));
+                             RUN_ON_CPU_HOST_INT(to_clean));
         }
     } else {
-        tlb_flush_by_mmuidx_async_work(cpu,
-                                       RUN_ON_CPU_HOST_INT(idxmap));
+        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
     }
 }
 
-- 
2.17.2
