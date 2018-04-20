Received: from eggs.gnu.org ([2001:4830:134:3::10]:50895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJQ-000629-8R
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJM-0005wb-WC
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:51:00 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9YJM-0005vZ-Lp
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:56 -0400
Received: by mail-wr0-x242.google.com with SMTP id h3-v6so24247423wrh.5
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 08:50:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 20 Apr 2018 16:50:44 +0100
Message-Id: <20180420155045.18862-6-alex.bennee@linaro.org>
In-Reply-To: <20180420155045.18862-1-alex.bennee@linaro.org>
References: <20180420155045.18862-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 5/6] accel/tcg: create store_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This is a common helper for all stores (currently 1 and 2 byte
operations). It takes a size and endian parameter.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/softmmu.c | 244 ++++++++++++++------------------------------
 1 file changed, 79 insertions(+), 165 deletions(-)

diff --git a/accel/tcg/softmmu.c b/accel/tcg/softmmu.c
index e6f93250f9..2be2d9025f 100644
--- a/accel/tcg/softmmu.c
+++ b/accel/tcg/softmmu.c
@@ -245,6 +245,10 @@ tcg_target_ulong __attribute__((flatten)) helper_be_ldsw_mmu(CPUArchState *env,
     return (int16_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
 }
 
+/*
+ * Store Helpers
+ */
+
 static inline void io_writeb(CPUArchState *env,
                                           size_t mmu_idx, size_t index,
                                           uint8_t val,
@@ -255,86 +259,6 @@ static inline void io_writeb(CPUArchState *env,
     return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, 1);
 }
 
-void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
-                       TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
-        if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 1, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-        }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (1 - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        val = (val);
-        io_writeb(env, mmu_idx, index, val, addr, retaddr);
-        return;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (1 > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + 1 - 1
-                     >= TARGET_PAGE_SIZE)) {
-        int i, index2;
-        target_ulong page2, tlb_addr2;
-    do_unaligned_access:
-        /* Ensure the second page is in the TLB.  Note that the first page
-           is already guaranteed to be filled, and that the second page
-           cannot evict the first.  */
-        page2 = (addr + 1) & TARGET_PAGE_MASK;
-        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
-        if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
-            && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, 1, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-        }
-
-        /* XXX: not efficient, but simple.  */
-        /* This loop must go in the forward direction to avoid issues
-           with self-modifying code in Windows 64-bit.  */
-        for (i = 0; i < 1; ++i) {
-            /* Little-endian extract.  */
-            uint8_t val8 = val >> (i * 8);
-            helper_ret_stb_mmu(env, addr + i, val8,
-                                            oi, retaddr);
-        }
-        return;
-    }
-
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-
-    stb_p((uint8_t *)haddr, val);
-
-
-
-}
-
-
-
-/* Provide signed versions of the load routines as well.  We can of course
-   avoid this for 64-bit data, or for 32-bit data on 32-bit host.  */
 static inline void io_writew(CPUArchState *env,
                                           size_t mmu_idx, size_t index,
                                           uint16_t val,
@@ -345,8 +269,9 @@ static inline void io_writew(CPUArchState *env,
     return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, 2);
 }
 
-void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-                       TCGMemOpIdx oi, uintptr_t retaddr)
+static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+                         size_t size, bool big_endian, TCGMemOpIdx oi,
+                         uintptr_t retaddr)
 {
     unsigned mmu_idx = get_mmuidx(oi);
     int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
@@ -363,7 +288,7 @@ void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
     if ((addr & TARGET_PAGE_MASK)
         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_DATA_STORE,
+            tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
         tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
@@ -371,20 +296,40 @@ void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
 
     /* Handle an IO access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (2 - 1)) != 0) {
+        if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
 
         /* ??? Note that the io helpers always read data in the target
            byte ordering.  We should push the LE/BE request down into io.  */
-        val = (val);
-        io_writew(env, mmu_idx, index, val, addr, retaddr);
+        switch (size) {
+        case 1:
+        {
+            uint8_t wv = (val);
+            io_writeb(env, mmu_idx, index, wv, addr, retaddr);
+            break;
+        }
+        case 2:
+        {
+            uint16_t wv;
+            if (big_endian) {
+                wv = bswap16( (uint16_t) val);
+            } else {
+                wv = (val);
+            }
+            io_writew(env, mmu_idx, index, wv, addr, retaddr);
+            break;
+        }
+        default:
+            g_assert_not_reached();
+            break;
+        }
         return;
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (2 > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
+    if (size > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
                      >= TARGET_PAGE_SIZE)) {
         int i, index2;
         target_ulong page2, tlb_addr2;
@@ -392,104 +337,73 @@ void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
         /* Ensure the second page is in the TLB.  Note that the first page
            is already guaranteed to be filled, and that the second page
            cannot evict the first.  */
-        page2 = (addr + 2) & TARGET_PAGE_MASK;
+        page2 = (addr + size) & TARGET_PAGE_MASK;
         index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
         tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
         if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
             && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, 2, MMU_DATA_STORE,
+            tlb_fill(ENV_GET_CPU(env), page2, size, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
 
         /* XXX: not efficient, but simple.  */
         /* This loop must go in the forward direction to avoid issues
            with self-modifying code in Windows 64-bit.  */
-        for (i = 0; i < 2; ++i) {
-            /* Little-endian extract.  */
-            uint8_t val8 = val >> (i * 8);
-            helper_ret_stb_mmu(env, addr + i, val8,
-                                            oi, retaddr);
+        for (i = 0; i < size; ++i) {
+            uint8_t val8;
+            if (big_endian) {
+                /* Big-endian extract.  */
+                val8 = val >> (((size - 1) * 8) - (i * 8));
+            } else {
+                /* Little-endian extract.  */
+                val8 = val >> (i * 8);
+            }
+            store_helper(env, addr + i, val8, 1, big_endian, oi, retaddr);
         }
         return;
     }
 
     haddr = addr + env->tlb_table[mmu_idx][index].addend;
 
-
-
-    stw_le_p((uint8_t *)haddr, val);
-
-}
-
-
-void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-                       TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
-        if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
+    switch(size) {
+    case 1:
+        stb_p((uint8_t *)haddr, val);
+        break;
+    case 2:
+        if (big_endian) {
+            stw_be_p((uint8_t *)haddr, val);
+        } else {
+            stw_le_p((uint8_t *)haddr, val);
         }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
     }
+}
 
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (2 - 1)) != 0) {
-            goto do_unaligned_access;
-        }
+void __attribute__((flatten)) helper_ret_stb_mmu(CPUArchState *env,
+                                                 target_ulong addr, uint8_t val,
+                                                 TCGMemOpIdx oi,
+                                                 uintptr_t retaddr)
+{
+    store_helper(env, addr, val, 1, false, oi, retaddr);
+}
 
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        val = bswap16(val);
-        io_writew(env, mmu_idx, index, val, addr, retaddr);
-        return;
-    }
 
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (2 > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
-                     >= TARGET_PAGE_SIZE)) {
-        int i, index2;
-        target_ulong page2, tlb_addr2;
-    do_unaligned_access:
-        /* Ensure the second page is in the TLB.  Note that the first page
-           is already guaranteed to be filled, and that the second page
-           cannot evict the first.  */
-        page2 = (addr + 2) & TARGET_PAGE_MASK;
-        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
-        if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
-            && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, 2, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-        }
+void __attribute__((flatten)) helper_le_stw_mmu(CPUArchState *env,
+                                                target_ulong addr, uint16_t val,
+                                                TCGMemOpIdx oi,
+                                                uintptr_t retaddr)
+{
+    store_helper(env, addr, val, 2, false, oi, retaddr);
+}
 
-        /* XXX: not efficient, but simple */
-        /* This loop must go in the forward direction to avoid issues
-           with self-modifying code.  */
-        for (i = 0; i < 2; ++i) {
-            /* Big-endian extract.  */
-            uint8_t val8 = val >> (((2 - 1) * 8) - (i * 8));
-            helper_ret_stb_mmu(env, addr + i, val8,
-                                            oi, retaddr);
-        }
-        return;
-    }
 
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-    stw_be_p((uint8_t *)haddr, val);
+void __attribute__((flatten)) helper_be_stw_mmu(CPUArchState *env,
+                                                target_ulong addr, uint16_t val,
+                                                TCGMemOpIdx oi,
+                                                uintptr_t retaddr)
+{
+    store_helper(env, addr, val, 2, true, oi, retaddr);
 }
-- 
2.17.0
