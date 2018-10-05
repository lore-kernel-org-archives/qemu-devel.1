Received: from eggs.gnu.org ([2001:4830:134:3::10]:54407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8XRc-0003gp-7J
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8XRR-0000m7-8N
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:15:28 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8XR9-0000cB-Ld
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:15:15 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri,  5 Oct 2018 17:14:50 -0400
Message-Id: <20181005211450.847-5-cota@braap.org>
In-Reply-To: <20181005211450.847-1-cota@braap.org>
References: <20181005211450.847-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 4/4] cputlb: read CPUTLBEntry.addr_write
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Updates can come from other threads, so readers that do not
take tlb_lock must use atomic_read to avoid undefined
behaviour (UB).

This and the previous commit result on average in no performance loss,
as the following experiments (run on an Intel i7-6700K CPU @ 4.00GHz)
show.

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
- tlb-lock-v3 is the current patch series, i.e. with a spinlock
  and a single lock acquisition in tlb_set_page_with_attrs.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/softmmu_template.h     | 16 ++++++++++------
 include/exec/cpu_ldst.h          |  2 +-
 include/exec/cpu_ldst_template.h |  2 +-
 accel/tcg/cputlb.c               | 15 +++++++++------
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index f060a693d4..1e50263871 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -277,7 +277,8 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
 {
     unsigned mmu_idx = get_mmuidx(oi);
     int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+    target_ulong tlb_addr =
+        atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
 
@@ -292,7 +293,8 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
+        tlb_addr = atomic_read(&env->tlb_table[mmu_idx][index].addr_write) &
+            ~TLB_INVALID_MASK;
     }
 
     /* Handle an IO access.  */
@@ -321,7 +323,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
            cannot evict the first.  */
         page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
         index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
+        tlb_addr2 = atomic_read(&env->tlb_table[mmu_idx][index2].addr_write);
         if (!tlb_hit_page(tlb_addr2, page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
             tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
@@ -354,7 +356,8 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
 {
     unsigned mmu_idx = get_mmuidx(oi);
     int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+    target_ulong tlb_addr =
+        atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
 
@@ -369,7 +372,8 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
+        tlb_addr = atomic_read(&env->tlb_table[mmu_idx][index].addr_write) &
+            ~TLB_INVALID_MASK;
     }
 
     /* Handle an IO access.  */
@@ -398,7 +402,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
            cannot evict the first.  */
         page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
         index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
+        tlb_addr2 = atomic_read(&env->tlb_table[mmu_idx][index2].addr_write);
         if (!tlb_hit_page(tlb_addr2, page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
             tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 41ed0526e2..9581587ce1 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -426,7 +426,7 @@ static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
         tlb_addr = tlbentry->addr_read;
         break;
     case 1:
-        tlb_addr = tlbentry->addr_write;
+        tlb_addr = atomic_read(&tlbentry->addr_write);
         break;
     case 2:
         tlb_addr = tlbentry->addr_code;
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 4db2302962..ba7a11123c 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -176,7 +176,7 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     addr = ptr;
     page_index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = CPU_MMU_INDEX;
-    if (unlikely(env->tlb_table[mmu_idx][page_index].addr_write !=
+    if (unlikely(atomic_read(&env->tlb_table[mmu_idx][page_index].addr_write) !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
         oi = make_memop_idx(SHIFT, mmu_idx);
         glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2b0ff47fdf..c7608ccdf8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -257,7 +257,7 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
                                         target_ulong page)
 {
     return tlb_hit_page(tlb_entry->addr_read, page) ||
-           tlb_hit_page(tlb_entry->addr_write, page) ||
+           tlb_hit_page(atomic_read(&tlb_entry->addr_write), page) ||
            tlb_hit_page(tlb_entry->addr_code, page);
 }
 
@@ -856,7 +856,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         tlb_fill(cpu, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
 
         index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+        tlb_addr = atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
             uintptr_t haddr = addr + env->tlb_table[mmu_idx][index].addend;
@@ -905,7 +905,9 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
     assert_cpu_is_self(ENV_GET_CPU(env));
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &env->tlb_v_table[mmu_idx][vidx];
-        target_ulong cmp = *(target_ulong *)((uintptr_t)vtlb + elt_ofs);
+        /* elt_ofs might correspond to .addr_write, so use atomic_read */
+        target_ulong cmp =
+            atomic_read((target_ulong *)((uintptr_t)vtlb + elt_ofs));
 
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
@@ -977,7 +979,8 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                  uintptr_t retaddr)
 {
     int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+    target_ulong tlb_addr =
+        atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
 
     if (!tlb_hit(tlb_addr, addr)) {
         /* TLB entry is for a different page */
@@ -997,7 +1000,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     size_t mmu_idx = get_mmuidx(oi);
     size_t index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     CPUTLBEntry *tlbe = &env->tlb_table[mmu_idx][index];
-    target_ulong tlb_addr = tlbe->addr_write;
+    target_ulong tlb_addr = atomic_read(&tlbe->addr_write);
     TCGMemOp mop = get_memop(oi);
     int a_bits = get_alignment_bits(mop);
     int s_bits = mop & MO_SIZE;
@@ -1028,7 +1031,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
             tlb_fill(ENV_GET_CPU(env), addr, 1 << s_bits, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
-        tlb_addr = tlbe->addr_write & ~TLB_INVALID_MASK;
+        tlb_addr = atomic_read(&tlbe->addr_write) & ~TLB_INVALID_MASK;
     }
 
     /* Notice an IO access or a needs-MMU-lookup access */
-- 
2.17.1
