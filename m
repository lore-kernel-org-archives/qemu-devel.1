Received: from eggs.gnu.org ([2001:4830:134:3::10]:38396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fa1Ks-0004dy-PZ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fa1Kr-0005P1-5E
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:54 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:33241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fa1Kq-0005Ok-Sn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:53 -0400
Received: by mail-pf0-x230.google.com with SMTP id b17-v6so7726945pfi.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:05:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  2 Jul 2018 09:05:42 -0700
Message-Id: <20180702160546.31969-3-richard.henderson@linaro.org>
In-Reply-To: <20180702160546.31969-1-richard.henderson@linaro.org>
References: <20180702160546.31969-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/6] tcg: Define and use new tlb_hit() and
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
Cc: peter.maydell@linaro.org

From: Peter Maydell <peter.maydell@linaro.org>

The condition to check whether an address has hit against a particular
TLB entry is not completely trivial. We do this in various places, and
in fact in one place (get_page_addr_code()) we have got the condition
wrong. Abstract it out into new tlb_hit() and tlb_hit_page() inline
functions (one for a known-page-aligned address and one for an
arbitrary address), and use them in all the places where we had the
condition correct.

This is a no-behaviour-change patch; we leave fixing the buggy
code in get_page_addr_code() to a subsequent patch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180629162122.19376-2-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/softmmu_template.h | 16 ++++++----------
 include/exec/cpu-all.h       | 23 +++++++++++++++++++++++
 include/exec/cpu_ldst.h      |  3 +--
 accel/tcg/cputlb.c           | 15 +++++----------
 4 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index c47591c970..badbf14880 100644
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
index 7338f57062..117d2fbbca 100644
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
index 5de8c8a5af..0f2cb717b1 100644
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
index eebe97dabb..adb711963b 100644
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
