Received: from eggs.gnu.org ([209.51.188.92]:48904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpe-0003Ky-2U
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpc-0000VU-Ib
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:58 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpc-0000Uk-8H
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:56 -0400
Received: by mail-pg1-x544.google.com with SMTP id j26so7590224pgl.5
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:56 -0700 (PDT)
Received: from cloudburst.imgcgcw.net ([147.50.13.10])
	by smtp.gmail.com with ESMTPSA id
	z6sm26753214pgo.31.2019.04.02.20.44.53 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Apr 2019 20:44:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:58 +0700
Message-Id: <20190403034358.21999-27-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 26/26] tcg: Use tlb_fill probe from
 tlb_vaddr_to_host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Most of the existing users would continue around a loop which
would fault the tlb entry in via a normal load/store.  But for
SVE we have a true non-faulting case which requires the new
probing form of tlb_fill.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 40 ++++--------------------
 accel/tcg/cputlb.c      | 69 ++++++++++++++++++++++++++++++++++++-----
 target/arm/sve_helper.c |  6 +---
 3 files changed, 68 insertions(+), 47 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index d78041d7a0..be8c3f4da2 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -440,43 +440,15 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
  * This is the equivalent of the initial fast-path code used by
  * TCG backends for guest load and store accesses.
  */
+#ifdef CONFIG_USER_ONLY
 static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
-                                      int access_type, int mmu_idx)
+                                      MMUAccessType access_type, int mmu_idx)
 {
-#if defined(CONFIG_USER_ONLY)
     return g2h(addr);
-#else
-    CPUTLBEntry *tlbentry = tlb_entry(env, mmu_idx, addr);
-    abi_ptr tlb_addr;
-    uintptr_t haddr;
-
-    switch (access_type) {
-    case 0:
-        tlb_addr = tlbentry->addr_read;
-        break;
-    case 1:
-        tlb_addr = tlb_addr_write(tlbentry);
-        break;
-    case 2:
-        tlb_addr = tlbentry->addr_code;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (!tlb_hit(tlb_addr, addr)) {
-        /* TLB entry is for a different page */
-        return NULL;
-    }
-
-    if (tlb_addr & ~TARGET_PAGE_MASK) {
-        /* IO access */
-        return NULL;
-    }
-
-    haddr = addr + tlbentry->addend;
-    return (void *)haddr;
-#endif /* defined(CONFIG_USER_ONLY) */
 }
+#else
+void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
+                        MMUAccessType access_type, int mmu_idx);
+#endif
 
 #endif /* CPU_LDST_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7f59d815db..959b6d4ded 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1006,6 +1006,16 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     }
 }
 
+static inline target_ulong tlb_read_ofs(CPUTLBEntry *entry, size_t ofs)
+{
+#if TCG_OVERSIZED_GUEST
+    return *(target_ulong *)((uintptr_t)entry + ofs);
+#else
+    /* ofs might correspond to .addr_write, so use atomic_read */
+    return atomic_read((target_ulong *)((uintptr_t)entry + ofs));
+#endif
+}
+
 /* Return true if ADDR is present in the victim tlb, and has been copied
    back to the main tlb.  */
 static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
@@ -1016,14 +1026,7 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
     assert_cpu_is_self(ENV_GET_CPU(env));
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &env->tlb_v_table[mmu_idx][vidx];
-        target_ulong cmp;
-
-        /* elt_ofs might correspond to .addr_write, so use atomic_read */
-#if TCG_OVERSIZED_GUEST
-        cmp = *(target_ulong *)((uintptr_t)vtlb + elt_ofs);
-#else
-        cmp = atomic_read((target_ulong *)((uintptr_t)vtlb + elt_ofs));
-#endif
+        target_ulong cmp = tlb_read_ofs(vtlb, elt_ofs);
 
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
@@ -1107,6 +1110,56 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
     }
 }
 
+void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
+                        MMUAccessType access_type, int mmu_idx)
+{
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+    uintptr_t tlb_addr, page;
+    size_t elt_ofs;
+
+    switch (access_type) {
+    case MMU_DATA_LOAD:
+        elt_ofs = offsetof(CPUTLBEntry, addr_read);
+        break;
+    case MMU_DATA_STORE:
+        elt_ofs = offsetof(CPUTLBEntry, addr_write);
+        break;
+    case MMU_INST_FETCH:
+        elt_ofs = offsetof(CPUTLBEntry, addr_code);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    page = addr & TARGET_PAGE_MASK;
+    tlb_addr = tlb_read_ofs(entry, elt_ofs);
+
+    if (!tlb_hit_page(tlb_addr, page)) {
+        uintptr_t index = tlb_index(env, mmu_idx, addr);
+
+        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs, page)) {
+            CPUState *cs = ENV_GET_CPU(env);
+            CPUClass *cc = CPU_GET_CLASS(cs);
+
+            if (!cc->tlb_fill(cs, addr, 0, access_type, mmu_idx, true, 0)) {
+                /* Non-faulting page table read failed.  */
+                return NULL;
+            }
+
+            /* TLB resize via tlb_fill may have moved the entry.  */
+            entry = tlb_entry(env, mmu_idx, addr);
+        }
+        tlb_addr = tlb_read_ofs(entry, elt_ofs);
+    }
+
+    if (tlb_addr & ~TARGET_PAGE_MASK) {
+        /* IO access */
+        return NULL;
+    }
+
+    return (void *)(addr + entry->addend);
+}
+
 /* Probe for a read-modify-write atomic operation.  Do not allow unaligned
  * operations, or io operations to proceed.  Return the host address.  */
 static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index bc847250dd..fd434c66ea 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4598,11 +4598,7 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
      * in the real world, obviously.)
      *
      * Then there are the annoying special cases with watchpoints...
-     *
-     * TODO: Add a form of tlb_fill that does not raise an exception,
-     * with a form of tlb_vaddr_to_host and a set of loads to match.
-     * The non_fault_vaddr_to_host would handle everything, usually,
-     * and the loads would handle the iomem path for watchpoints.
+     * TODO: Add a form of non-faulting loads using cc->tlb_fill(probe=true).
      */
     host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
     split = max_for_page(addr, mem_off, mem_max);
-- 
2.17.1
