Received: from eggs.gnu.org ([2001:4830:134:3::10]:48918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVg-0000pd-8L
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVd-0001rE-1j
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:53756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHpVY-0001Ei-IV
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id v24-v6so5087175wmh.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:21:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 12:21:18 +0000
Message-Id: <20181031122119.1669-10-richard.henderson@linaro.org>
In-Reply-To: <20181031122119.1669-1-richard.henderson@linaro.org>
References: <20181031122119.1669-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 09/10] cputlb: Filter flushes on already clean
 tlbs
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

Especially for guests with large numbers of tlbs, like ARM or PPC,
we may well not use all of them in between flush operations.
Remember which tlbs have been used since the last flush, and
avoid any useless flushing.

Tested-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h |  7 ++++++-
 accel/tcg/cputlb.c      | 35 +++++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index c7b501d627..ca0fea8b27 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -166,7 +166,12 @@ typedef struct CPUTLBCommon {
      * mmu_idx may be discarded.  Protected by tlb_c.lock.
      */
     uint16_t pending_flush;
-
+    /*
+     * Within dirty, for each bit N, modifications have been made to
+     * mmu_idx N since the last time that mmu_idx was flushed.
+     * Protected by tlb_c.lock.
+     */
+    uint16_t dirty;
     /*
      * Statistics.  These are not lock protected, but are read and
      * written atomically.  This allows the monitor to print a snapshot
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e60628c350..f6c37bc4db 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -79,6 +79,9 @@ void tlb_init(CPUState *cpu)
     CPUArchState *env = cpu->env_ptr;
 
     qemu_spin_init(&env->tlb_c.lock);
+
+    /* Ensure that cpu_reset performs a full flush.  */
+    env->tlb_c.dirty = ALL_MMUIDX_BITS;
 }
 
 /* flush_all_helper: run fn across all cpus
@@ -129,31 +132,40 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
-    unsigned long mmu_idx_bitmask = data.host_int;
-    int mmu_idx;
+    uint16_t asked = data.host_int;
+    uint16_t all_dirty, work, to_clean;
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("mmu_idx:0x%04lx\n", mmu_idx_bitmask);
+    tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
 
     qemu_spin_lock(&env->tlb_c.lock);
-    env->tlb_c.pending_flush &= ~mmu_idx_bitmask;
 
-    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
-            tlb_flush_one_mmuidx_locked(env, mmu_idx);
-        }
+    all_dirty = env->tlb_c.dirty;
+    to_clean = asked & all_dirty;
+    all_dirty &= ~to_clean;
+    env->tlb_c.dirty = all_dirty;
+
+    for (work = to_clean; work != 0; work &= work - 1) {
+        int mmu_idx = ctz32(work);
+        tlb_flush_one_mmuidx_locked(env, mmu_idx);
     }
+
     qemu_spin_unlock(&env->tlb_c.lock);
 
     cpu_tb_jmp_cache_clear(cpu);
 
-    if (mmu_idx_bitmask == ALL_MMUIDX_BITS) {
+    if (to_clean == ALL_MMUIDX_BITS) {
         atomic_set(&env->tlb_c.full_flush_count,
                    env->tlb_c.full_flush_count + 1);
     } else {
         atomic_set(&env->tlb_c.part_flush_count,
-                   env->tlb_c.part_flush_count + ctpop16(mmu_idx_bitmask));
+                   env->tlb_c.part_flush_count + ctpop16(to_clean));
+        if (to_clean != asked) {
+            atomic_set(&env->tlb_c.elide_flush_count,
+                       env->tlb_c.elide_flush_count +
+                       ctpop16(asked & ~to_clean));
+        }
     }
 }
 
@@ -581,6 +593,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
      */
     qemu_spin_lock(&env->tlb_c.lock);
 
+    /* Note that the tlb is no longer clean.  */
+    env->tlb_c.dirty |= 1 << mmu_idx;
+
     /* Make sure there's no cached translation for the new page.  */
     tlb_flush_vtlb_page_locked(env, mmu_idx, vaddr_page);
 
-- 
2.17.2
