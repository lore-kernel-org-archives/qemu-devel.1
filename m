Received: from eggs.gnu.org ([2001:4830:134:3::10]:59958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTZ-0004EV-4T
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTX-0001Ip-Ak
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:39644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTTW-0001Hf-Vg
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:47 -0400
Received: by mail-pl1-x631.google.com with SMTP id e67-v6so2385881plb.6
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:49:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 10:49:11 -0700
Message-Id: <20181016174911.9052-22-richard.henderson@linaro.org>
In-Reply-To: <20181016174911.9052-1-richard.henderson@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 21/21] cputlb: read CPUTLBEntry.addr_write
 atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Updates can come from other threads, so readers that do not
take tlb_lock must use atomic_read to avoid undefined
behaviour (UB).

This completes the conversion to tlb_lock. This conversion results
on average in no performance loss, as the following experiments
(run on an Intel i7-6700K CPU @ 4.00GHz) show.

1. aarch64 bootup+shutdown test:

- Before:
 Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 runs):

       7487.087786      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.12% )
    31,574,905,303      cycles                    #    4.217 GHz                      ( +-  0.12% )
    57,097,908,812      instructions              #    1.81  insns per cycle          ( +-  0.08% )
    10,255,415,367      branches                  # 1369.747 M/sec                    ( +-  0.08% )
       173,278,962      branch-misses             #    1.69% of all branches          ( +-  0.18% )

       7.504481349 seconds time elapsed                                          ( +-  0.14% )

- After:
 Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 runs):

       7462.441328      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.07% )
    31,478,476,520      cycles                    #    4.218 GHz                      ( +-  0.07% )
    57,017,330,084      instructions              #    1.81  insns per cycle          ( +-  0.05% )
    10,251,929,667      branches                  # 1373.804 M/sec                    ( +-  0.05% )
       173,023,787      branch-misses             #    1.69% of all branches          ( +-  0.11% )

       7.474970463 seconds time elapsed                                          ( +-  0.07% )

2. SPEC06int:
                                              SPEC06int (test set)
                                           [Y axis: Speedup over master]
  1.15 +-+----+------+------+------+------+------+-------+------+------+------+------+------+------+----+-+
       |                                                                                                  |
   1.1 +-+.................................+++.............................+  tlb-lock-v2 (m+++x)       +-+
       |                                +++ |                   +++        tlb-lock-v3 (spinl|ck)         |
       |                    +++          |  |     +++    +++     |                           |            |
  1.05 +-+....+++...........####.........|####.+++.|......|.....###....+++...........+++....###.........+-+
       |      ###         ++#| #         |# |# ***### +++### +++#+#     |     +++     |     #|#    ###    |
     1 +-+++***+#++++####+++#++#++++++++++#++#+*+*++#++++#+#+****+#++++###++++###++++###++++#+#++++#+#+++-+
       |    *+* #    #++# ***  #   #### ***  # * *++# ****+# *| * # ****|#   |# #    #|#    #+#    # #    |
  0.95 +-+..*.*.#....#..#.*|*..#...#..#.*|*..#.*.*..#.*|.*.#.*++*.#.*++*+#.****.#....#+#....#.#..++#.#..+-+
       |    * * #    #  # *|*  #   #  # *|*  # * *  # *++* # *  * # *  * # * |* #  ++# #    # #  *** #    |
       |    * * #  ++#  # *+*  #   #  # *|*  # * *  # *  * # *  * # *  * # *++* # **** #  ++# #  * * #    |
   0.9 +-+..*.*.#...|#..#.*.*..#.++#..#.*|*..#.*.*..#.*..*.#.*..*.#.*..*.#.*..*.#.*.|*.#...|#.#..*.*.#..+-+
       |    * * #  ***  # * *  #  |#  # *+*  # * *  # *  * # *  * # *  * # *  * # *++* #   |# #  * * #    |
  0.85 +-+..*.*.#..*|*..#.*.*..#.***..#.*.*..#.*.*..#.*..*.#.*..*.#.*..*.#.*..*.#.*..*.#.****.#..*.*.#..+-+
       |    * * #  *+*  # * *  # *|*  # * *  # * *  # *  * # *  * # *  * # *  * # *  * # * |* #  * * #    |
       |    * * #  * *  # * *  # *+*  # * *  # * *  # *  * # *  * # *  * # *  * # *  * # * |* #  * * #    |
   0.8 +-+..*.*.#..*.*..#.*.*..#.*.*..#.*.*..#.*.*..#.*..*.#.*..*.#.*..*.#.*..*.#.*..*.#.*++*.#..*.*.#..+-+
       |    * * #  * *  # * *  # * *  # * *  # * *  # *  * # *  * # *  * # *  * # *  * # *  * #  * * #    |
  0.75 +-+--***##--***###-***###-***###-***###-***###-****##-****##-****##-****##-****##-****##--***##--+-+
 400.perlben401.bzip2403.gcc429.m445.gob456.hmme45462.libqua464.h26471.omnet473483.xalancbmkgeomean

  png: https://imgur.com/a/BHzpPTW

Notes:
- tlb-lock-v2 corresponds to an implementation with a mutex.
- tlb-lock-v3 corresponds to the current implementation, i.e.
  a spinlock and a single lock acquisition in tlb_set_page_with_attrs.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20181016153840.25877-1-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/softmmu_template.h     | 12 ++++++------
 include/exec/cpu_ldst.h          | 11 ++++++++++-
 include/exec/cpu_ldst_template.h |  2 +-
 accel/tcg/cputlb.c               | 19 +++++++++++++------
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index 09538b5349..b0adea045e 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -280,7 +280,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = entry->addr_write;
+    target_ulong tlb_addr = tlb_addr_write(entry);
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
 
@@ -295,7 +295,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
-        tlb_addr = entry->addr_write & ~TLB_INVALID_MASK;
+        tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
     }
 
     /* Handle an IO access.  */
@@ -325,7 +325,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
            cannot evict the first.  */
         page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
         entry2 = tlb_entry(env, mmu_idx, page2);
-        if (!tlb_hit_page(entry2->addr_write, page2)
+        if (!tlb_hit_page(tlb_addr_write(entry2), page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
             tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
@@ -358,7 +358,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = entry->addr_write;
+    target_ulong tlb_addr = tlb_addr_write(entry);
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
 
@@ -373,7 +373,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
-        tlb_addr = entry->addr_write & ~TLB_INVALID_MASK;
+        tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
     }
 
     /* Handle an IO access.  */
@@ -403,7 +403,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
            cannot evict the first.  */
         page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
         entry2 = tlb_entry(env, mmu_idx, page2);
-        if (!tlb_hit_page(entry2->addr_write, page2)
+        if (!tlb_hit_page(tlb_addr_write(entry2), page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
             tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index f54d91ff68..959068495a 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -126,6 +126,15 @@ extern __thread uintptr_t helper_retaddr;
 /* The memory helpers for tcg-generated code need tcg_target_long etc.  */
 #include "tcg.h"
 
+static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
+{
+#if TCG_OVERSIZED_GUEST
+    return entry->addr_write;
+#else
+    return atomic_read(&entry->addr_write);
+#endif
+}
+
 /* Find the TLB index corresponding to the mmu_idx + address pair.  */
 static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
                                   target_ulong addr)
@@ -439,7 +448,7 @@ static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
         tlb_addr = tlbentry->addr_read;
         break;
     case 1:
-        tlb_addr = tlbentry->addr_write;
+        tlb_addr = tlb_addr_write(tlbentry);
         break;
     case 2:
         tlb_addr = tlbentry->addr_code;
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index d21a0b59bf..0f061d47ef 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -177,7 +177,7 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     addr = ptr;
     mmu_idx = CPU_MMU_INDEX;
     entry = tlb_entry(env, mmu_idx, addr);
-    if (unlikely(entry->addr_write !=
+    if (unlikely(tlb_addr_write(entry) !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
         oi = make_memop_idx(SHIFT, mmu_idx);
         glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 28b770a404..af57aca5e4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -258,7 +258,7 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
                                         target_ulong page)
 {
     return tlb_hit_page(tlb_entry->addr_read, page) ||
-           tlb_hit_page(tlb_entry->addr_write, page) ||
+           tlb_hit_page(tlb_addr_write(tlb_entry), page) ||
            tlb_hit_page(tlb_entry->addr_code, page);
 }
 
@@ -855,7 +855,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         tlb_fill(cpu, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
 
         entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = entry->addr_write;
+        tlb_addr = tlb_addr_write(entry);
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
             uintptr_t haddr = addr + entry->addend;
@@ -904,7 +904,14 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
     assert_cpu_is_self(ENV_GET_CPU(env));
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &env->tlb_v_table[mmu_idx][vidx];
-        target_ulong cmp = *(target_ulong *)((uintptr_t)vtlb + elt_ofs);
+        target_ulong cmp;
+
+        /* elt_ofs might correspond to .addr_write, so use atomic_read */
+#if TCG_OVERSIZED_GUEST
+        cmp = *(target_ulong *)((uintptr_t)vtlb + elt_ofs);
+#else
+        cmp = atomic_read((target_ulong *)((uintptr_t)vtlb + elt_ofs));
+#endif
 
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
@@ -977,7 +984,7 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
 
-    if (!tlb_hit(entry->addr_write, addr)) {
+    if (!tlb_hit(tlb_addr_write(entry), addr)) {
         /* TLB entry is for a different page */
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
@@ -995,7 +1002,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     size_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = tlbe->addr_write;
+    target_ulong tlb_addr = tlb_addr_write(tlbe);
     TCGMemOp mop = get_memop(oi);
     int a_bits = get_alignment_bits(mop);
     int s_bits = mop & MO_SIZE;
@@ -1026,7 +1033,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
             tlb_fill(ENV_GET_CPU(env), addr, 1 << s_bits, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
-        tlb_addr = tlbe->addr_write & ~TLB_INVALID_MASK;
+        tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
     }
 
     /* Notice an IO access or a needs-MMU-lookup access */
-- 
2.17.2
