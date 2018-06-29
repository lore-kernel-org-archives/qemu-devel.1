Received: from eggs.gnu.org ([2001:4830:134:3::10]:59353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYwCQ-0001uh-8I
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYwCO-0007DU-Pv
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:24:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYwCO-0007Bd-AY
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:24:40 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 17:21:21 +0100
Message-Id: <20180629162122.19376-2-peter.maydell@linaro.org>
In-Reply-To: <20180629162122.19376-1-peter.maydell@linaro.org>
References: <20180629162122.19376-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] tcg: Define and use new tlb_hit() and
 tlb_hit_page() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

The condition to check whether an address has hit against a particular
TLB entry is not completely trivial. We do this in various places, and
in fact in one place (get_page_addr_code()) we have got the condition
wrong. Abstract it out into new tlb_hit() and tlb_hit_page() inline
functions (one for a known-page-aligned address and one for an
arbitrary address), and use them in all the places where we had the
condition correct.

This is a no-behaviour-change patch; we leave fixing the buggy
code in get_page_addr_code() to a subsequent patch.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/softmmu_template.h | 16 ++++++----------
 include/exec/cpu-all.h       | 23 +++++++++++++++++++++++
 include/exec/cpu_ldst.h      |  3 +--
 accel/tcg/cputlb.c           | 15 +++++----------
 4 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index c47591c9709..badbf148803 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -123,8 +123,7 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+    if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
@@ -191,8 +190,7 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+    if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
@@ -286,8 +284,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+    if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
@@ -322,7 +319,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
         index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
         tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
-        if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
+        if (!tlb_hit_page(tlb_addr2, page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
             tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
@@ -364,8 +361,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+    if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
@@ -400,7 +396,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
         index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
         tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
-        if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
+        if (!tlb_hit_page(tlb_addr2, page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
             tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 7338f57062f..117d2fbbcac 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -339,6 +339,29 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
                          | TLB_RECHECK)
 
+/**
+ * tlb_hit_page: return true if page aligned @addr is a hit against the
+ * TLB entry @tlb_addr
+ *
+ * @addr: virtual address to test (must be page aligned)
+ * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
+ */
+static inline bool tlb_hit_page(target_ulong tlb_addr, target_ulong addr)
+{
+    return addr == (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK));
+}
+
+/**
+ * tlb_hit: return true if @addr is a hit against the TLB entry @tlb_addr
+ *
+ * @addr: virtual address to test (need not be page aligned)
+ * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
+ */
+static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
+{
+    return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
+}
+
 void dump_exec_info(FILE *f, fprintf_function cpu_fprintf);
 void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
 #endif /* !CONFIG_USER_ONLY */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 5de8c8a5afe..0f2cb717b15 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -422,8 +422,7 @@ static inline void *tlb_vaddr_to_host(CPUArchState *env, target_ulong addr,
         g_assert_not_reached();
     }
 
-    if ((addr & TARGET_PAGE_MASK)
-        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+    if (!tlb_hit(tlb_addr, addr)) {
         /* TLB entry is for a different page */
         return NULL;
     }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index eebe97dabb7..adb711963bf 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -239,12 +239,9 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
 
 static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
 {
-    if (addr == (tlb_entry->addr_read &
-                 (TARGET_PAGE_MASK | TLB_INVALID_MASK)) ||
-        addr == (tlb_entry->addr_write &
-                 (TARGET_PAGE_MASK | TLB_INVALID_MASK)) ||
-        addr == (tlb_entry->addr_code &
-                 (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+    if (tlb_hit_page(tlb_entry->addr_read, addr) ||
+        tlb_hit_page(tlb_entry->addr_write, addr) ||
+        tlb_hit_page(tlb_entry->addr_code, addr)) {
         memset(tlb_entry, -1, sizeof(*tlb_entry));
     }
 }
@@ -1046,8 +1043,7 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
     int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
 
-    if ((addr & TARGET_PAGE_MASK)
-        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+    if (!tlb_hit(tlb_addr, addr)) {
         /* TLB entry is for a different page */
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
@@ -1091,8 +1087,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     }
 
     /* Check TLB entry and enforce page permissions.  */
-    if ((addr & TARGET_PAGE_MASK)
-        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+    if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, 1 << s_bits, MMU_DATA_STORE,
                      mmu_idx, retaddr);
-- 
2.17.1
