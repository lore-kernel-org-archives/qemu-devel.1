Received: from eggs.gnu.org ([2001:4830:134:3::10]:50849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJM-0005yq-SI
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJK-0005uU-DE
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:56 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9YJK-0005u2-1d
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:54 -0400
Received: by mail-wr0-x242.google.com with SMTP id p18-v6so5051992wrm.1
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 08:50:53 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 20 Apr 2018 16:50:43 +0100
Message-Id: <20180420155045.18862-5-alex.bennee@linaro.org>
In-Reply-To: <20180420155045.18862-1-alex.bennee@linaro.org>
References: <20180420155045.18862-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 4/6] accel/tcg: create load_helper
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

Collapse all the helpers so far into a common load_helper which can be
used for mmu/cmmu and little/big endian functions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/softmmu.c | 578 ++++++++++++++------------------------------
 1 file changed, 183 insertions(+), 395 deletions(-)

diff --git a/accel/tcg/softmmu.c b/accel/tcg/softmmu.c
index fcad3d360f..e6f93250f9 100644
--- a/accel/tcg/softmmu.c
+++ b/accel/tcg/softmmu.c
@@ -15,88 +15,236 @@
   victim_tlb_hit(env, mmu_idx, index, offsetof(CPUTLBEntry, TY), \
                  (ADDR) & TARGET_PAGE_MASK)
 
-/* For the benefit of TCG generated code, we want to avoid the complication
-   of ABI-specific return type promotion and always return a value extended
-   to the register size of the host.  This is tcg_target_long, except in the
-   case of a 32-bit host and 64-bit data, and for that we always have
-   uint64_t.  Don't bother with this widened value for SOFTMMU_CODE_ACCESS.  */
-static inline uint8_t io_readb(CPUArchState *env,
-                                              size_t mmu_idx, size_t index,
-                                              target_ulong addr,
-                                              uintptr_t retaddr)
+
+/*
+ * Load Helpers
+ *
+ * We support two different access types. SOFTMMU_CODE_ACCESS is
+ * specifically for reading instructions from system memory. It is
+ * called by the translation loop and in some helpers where the code
+ * is disassembled. It shouldn't be called directly by guest code.
+ */
+
+static inline uint8_t io_readb(CPUArchState *env, size_t mmu_idx, size_t index,
+                               target_ulong addr, uintptr_t retaddr)
 {
     CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
     return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, 1);
 }
 
+static inline uint16_t io_readw(CPUArchState *env, size_t mmu_idx, size_t index,
+                                target_ulong addr, uintptr_t retaddr)
+{
+    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, 2);
+}
 
-tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+static tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
+                                    size_t size, bool big_endian,
+                                    bool code_read, TCGMemOpIdx oi,
+                                    uintptr_t retaddr)
 {
     unsigned mmu_idx = get_mmuidx(oi);
     int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
+    target_ulong tlb_addr;
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
-    uint8_t res;
+    tcg_target_ulong res;
+
+    if (code_read) {
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
+    } else {
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
+    }
 
+    /* Handle unaligned */
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_LOAD,
-                             mmu_idx, retaddr);
+        if (code_read) {
+            cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_INST_FETCH,
+                                 mmu_idx, retaddr);
+        } else {
+            cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_LOAD,
+                                 mmu_idx, retaddr);
+        }
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if ((addr & TARGET_PAGE_MASK)
          != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
-        if (!VICTIM_TLB_HIT(addr_read, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 1, MMU_DATA_LOAD,
-                     mmu_idx, retaddr);
+        if (code_read) {
+            if (!VICTIM_TLB_HIT(addr_code, addr)) {
+                tlb_fill(ENV_GET_CPU(env), addr, size, MMU_INST_FETCH,
+                         mmu_idx, retaddr);
+            }
+            tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
+        } else {
+            if (!VICTIM_TLB_HIT(addr_read, addr)) {
+                tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_LOAD,
+                         mmu_idx, retaddr);
+            }
+            tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
         }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
     }
 
     /* Handle an IO access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (1 - 1)) != 0) {
+        if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
 
         /* ??? Note that the io helpers always read data in the target
            byte ordering.  We should push the LE/BE request down into io.  */
-        res = io_readb(env, mmu_idx, index, addr, retaddr);
-        res = (res);
+        switch (size) {
+        case 1:
+        {
+            uint8_t rv = io_readb(env, mmu_idx, index, addr, retaddr);
+            res = rv;
+            break;
+        }
+        case 2:
+        {
+            uint16_t rv = io_readw(env, mmu_idx, index, addr, retaddr);
+            if (big_endian) {
+                res = bswap16(rv);
+            } else {
+                res = rv;
+            }
+            break;
+        }
+        default:
+            g_assert_not_reached();
+            break;
+        }
+
         return res;
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (1 > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + 1 - 1
+    if (size > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
                     >= TARGET_PAGE_SIZE)) {
         target_ulong addr1, addr2;
-        uint8_t res1, res2;
+        tcg_target_ulong res1, res2;
         unsigned shift;
     do_unaligned_access:
-        addr1 = addr & ~(1 - 1);
-        addr2 = addr1 + 1;
-        res1 = helper_ret_ldub_mmu(env, addr1, oi, retaddr);
-        res2 = helper_ret_ldub_mmu(env, addr2, oi, retaddr);
-        shift = (addr & (1 - 1)) * 8;
-
-        /* Little-endian combine.  */
-        res = (res1 >> shift) | (res2 << ((1 * 8) - shift));
+        addr1 = addr & ~(size - 1);
+        addr2 = addr1 + size;
+        res1 = load_helper(env, addr1, size, big_endian, code_read, oi, retaddr);
+        res2 = load_helper(env, addr2, size, big_endian, code_read, oi, retaddr);
+        shift = (addr & (size - 1)) * 8;
+
+        if (big_endian) {
+            /* Big-endian combine.  */
+            res = (res1 << shift) | (res2 >> ((size * 8) - shift));
+        } else {
+            /* Little-endian combine.  */
+            res = (res1 >> shift) | (res2 << ((size * 8) - shift));
+        }
         return res;
     }
 
     haddr = addr + env->tlb_table[mmu_idx][index].addend;
 
-    res = ldub_p((uint8_t *)haddr);
+    switch (size) {
+    case 1:
+        res = ldub_p((uint8_t *)haddr);
+        break;
+    case 2:
+        if (big_endian) {
+            res = lduw_be_p((uint8_t *)haddr);
+        } else {
+            res = lduw_le_p((uint8_t *)haddr);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
 
+    return res;
+}
 
+/*
+ * For the benefit of TCG generated code, we want to avoid the
+ * complication of ABI-specific return type promotion and always
+ * return a value extended to the register size of the host. This is
+ * tcg_target_long, except in the case of a 32-bit host and 64-bit
+ * data, and for that we always have uint64_t.
+ *
+ * We don't bother with this widened value for SOFTMMU_CODE_ACCESS.
+ */
 
-    return res;
+tcg_target_ulong __attribute__((flatten)) helper_ret_ldub_mmu(CPUArchState *env,
+                                                              target_ulong addr,
+                                                              TCGMemOpIdx oi,
+                                                              uintptr_t retaddr)
+{
+    return load_helper(env, addr, 1, false, false, oi, retaddr);
+}
+
+
+
+tcg_target_ulong __attribute__((flatten)) helper_le_lduw_mmu(CPUArchState *env,
+                                                             target_ulong addr,
+                                                             TCGMemOpIdx oi,
+                                                             uintptr_t retaddr)
+{
+    return load_helper(env, addr, 2, false, false, oi, retaddr);
 }
+
+
+tcg_target_ulong __attribute__((flatten)) helper_be_lduw_mmu(CPUArchState *env,
+                                                             target_ulong addr,
+                                                             TCGMemOpIdx oi,
+                                                             uintptr_t retaddr)
+{
+    return load_helper(env, addr, 2, true, false, oi, retaddr);
+}
+
+uint8_t __attribute__((flatten)) helper_ret_ldb_cmmu (CPUArchState *env,
+                                                      target_ulong addr,
+                                                      TCGMemOpIdx oi,
+                                                      uintptr_t retaddr)
+{
+    return load_helper(env, addr, 1, false, true, oi, retaddr);
+}
+
+uint16_t __attribute__((flatten)) helper_le_ldw_cmmu(CPUArchState *env,
+                                                     target_ulong addr,
+                                                     TCGMemOpIdx oi,
+                                                     uintptr_t retaddr)
+{
+    return load_helper(env, addr, 2, false, true, oi, retaddr);
+}
+
+uint16_t __attribute__((flatten)) helper_be_ldw_cmmu(CPUArchState *env,
+                                                     target_ulong addr,
+                                                     TCGMemOpIdx oi,
+                                                     uintptr_t retaddr)
+{
+    return load_helper(env, addr, 2, true, true, oi, retaddr);
+}
+
 /* Provide signed versions of the load routines as well.  We can of course
    avoid this for 64-bit data, or for 32-bit data on 32-bit host.  */
+
+tcg_target_ulong __attribute__((flatten)) helper_le_ldsw_mmu(CPUArchState *env,
+                                                             target_ulong addr,
+                                                             TCGMemOpIdx oi,
+                                                             uintptr_t retaddr)
+{
+    return (int16_t)helper_le_lduw_mmu(env, addr, oi, retaddr);
+}
+
+
+tcg_target_ulong __attribute__((flatten)) helper_be_ldsw_mmu(CPUArchState *env,
+                                                             target_ulong addr,
+                                                             TCGMemOpIdx oi,
+                                                             uintptr_t retaddr)
+{
+    return (int16_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
+}
+
 static inline void io_writeb(CPUArchState *env,
                                           size_t mmu_idx, size_t index,
                                           uint8_t val,
@@ -183,232 +331,6 @@ void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
 
 }
 
-/* For the benefit of TCG generated code, we want to avoid the complication
-   of ABI-specific return type promotion and always return a value extended
-   to the register size of the host.  This is tcg_target_long, except in the
-   case of a 32-bit host and 64-bit data, and for that we always have
-   uint64_t.  Don't bother with this widened value for SOFTMMU_CODE_ACCESS.  */
-uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-    uint8_t res;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_INST_FETCH,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
-        if (!VICTIM_TLB_HIT(addr_code, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 1, MMU_INST_FETCH,
-                     mmu_idx, retaddr);
-        }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
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
-        res = io_readb(env, mmu_idx, index, addr, retaddr);
-        res = (res);
-        return res;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (1 > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + 1 - 1
-                    >= TARGET_PAGE_SIZE)) {
-        target_ulong addr1, addr2;
-        uint8_t res1, res2;
-        unsigned shift;
-    do_unaligned_access:
-        addr1 = addr & ~(1 - 1);
-        addr2 = addr1 + 1;
-        res1 = helper_ret_ldb_cmmu(env, addr1, oi, retaddr);
-        res2 = helper_ret_ldb_cmmu(env, addr2, oi, retaddr);
-        shift = (addr & (1 - 1)) * 8;
-
-        /* Little-endian combine.  */
-        res = (res1 >> shift) | (res2 << ((1 * 8) - shift));
-        return res;
-    }
-
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-
-    res = ldub_p((uint8_t *)haddr);
-
-
-
-    return res;
-}
-
-static inline uint16_t io_readw(CPUArchState *env,
-                                              size_t mmu_idx, size_t index,
-                                              target_ulong addr,
-                                              uintptr_t retaddr)
-{
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, 2);
-}
-
-
-tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-    uint16_t res;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_LOAD,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
-        if (!VICTIM_TLB_HIT(addr_read, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_DATA_LOAD,
-                     mmu_idx, retaddr);
-        }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (2 - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        res = io_readw(env, mmu_idx, index, addr, retaddr);
-        res = (res);
-        return res;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (2 > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
-                    >= TARGET_PAGE_SIZE)) {
-        target_ulong addr1, addr2;
-        uint16_t res1, res2;
-        unsigned shift;
-    do_unaligned_access:
-        addr1 = addr & ~(2 - 1);
-        addr2 = addr1 + 2;
-        res1 = helper_le_lduw_mmu(env, addr1, oi, retaddr);
-        res2 = helper_le_lduw_mmu(env, addr2, oi, retaddr);
-        shift = (addr & (2 - 1)) * 8;
-
-        /* Little-endian combine.  */
-        res = (res1 >> shift) | (res2 << ((2 * 8) - shift));
-        return res;
-    }
-
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-
-
-
-    res = lduw_le_p((uint8_t *)haddr);
-
-    return res;
-}
-
-
-tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-    uint16_t res;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_LOAD,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
-        if (!VICTIM_TLB_HIT(addr_read, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_DATA_LOAD,
-                     mmu_idx, retaddr);
-        }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (2 - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        res = io_readw(env, mmu_idx, index, addr, retaddr);
-        res = bswap16(res);
-        return res;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (2 > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
-                    >= TARGET_PAGE_SIZE)) {
-        target_ulong addr1, addr2;
-        uint16_t res1, res2;
-        unsigned shift;
-    do_unaligned_access:
-        addr1 = addr & ~(2 - 1);
-        addr2 = addr1 + 2;
-        res1 = helper_be_lduw_mmu(env, addr1, oi, retaddr);
-        res2 = helper_be_lduw_mmu(env, addr2, oi, retaddr);
-        shift = (addr & (2 - 1)) * 8;
-
-        /* Big-endian combine.  */
-        res = (res1 << shift) | (res2 >> ((2 * 8) - shift));
-        return res;
-    }
-
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-    res = lduw_be_p((uint8_t *)haddr);
-    return res;
-}
-
-
-/* Provide signed versions of the load routines as well.  We can of course
-   avoid this for 64-bit data, or for 32-bit data on 32-bit host.  */
-
-tcg_target_ulong helper_le_ldsw_mmu(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return (int16_t)helper_le_lduw_mmu(env, addr, oi, retaddr);
-}
-
-
-tcg_target_ulong helper_be_ldsw_mmu(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return (int16_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
-}
 
 
 /* Provide signed versions of the load routines as well.  We can of course
@@ -571,137 +493,3 @@ void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
     haddr = addr + env->tlb_table[mmu_idx][index].addend;
     stw_be_p((uint8_t *)haddr, val);
 }
-
-/* For the benefit of TCG generated code, we want to avoid the complication
-   of ABI-specific return type promotion and always return a value extended
-   to the register size of the host.  This is tcg_target_long, except in the
-   case of a 32-bit host and 64-bit data, and for that we always have
-   uint64_t.  Don't bother with this widened value for SOFTMMU_CODE_ACCESS.  */
-uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-    uint16_t res;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_INST_FETCH,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
-        if (!VICTIM_TLB_HIT(addr_code, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_INST_FETCH,
-                     mmu_idx, retaddr);
-        }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (2 - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        res = io_readw(env, mmu_idx, index, addr, retaddr);
-        res = (res);
-        return res;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (2 > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
-                    >= TARGET_PAGE_SIZE)) {
-        target_ulong addr1, addr2;
-        uint16_t res1, res2;
-        unsigned shift;
-    do_unaligned_access:
-        addr1 = addr & ~(2 - 1);
-        addr2 = addr1 + 2;
-        res1 = helper_le_ldw_cmmu(env, addr1, oi, retaddr);
-        res2 = helper_le_ldw_cmmu(env, addr2, oi, retaddr);
-        shift = (addr & (2 - 1)) * 8;
-
-        /* Little-endian combine.  */
-        res = (res1 >> shift) | (res2 << ((2 * 8) - shift));
-        return res;
-    }
-
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-
-
-
-    res = lduw_le_p((uint8_t *)haddr);
-
-    return res;
-}
-
-
-uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-    uint16_t res;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_INST_FETCH,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
-        if (!VICTIM_TLB_HIT(addr_code, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_INST_FETCH,
-                     mmu_idx, retaddr);
-        }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (2 - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        res = io_readw(env, mmu_idx, index, addr, retaddr);
-        res = bswap16(res);
-        return res;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (2 > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
-                    >= TARGET_PAGE_SIZE)) {
-        target_ulong addr1, addr2;
-        uint16_t res1, res2;
-        unsigned shift;
-    do_unaligned_access:
-        addr1 = addr & ~(2 - 1);
-        addr2 = addr1 + 2;
-        res1 = helper_be_ldw_cmmu(env, addr1, oi, retaddr);
-        res2 = helper_be_ldw_cmmu(env, addr2, oi, retaddr);
-        shift = (addr & (2 - 1)) * 8;
-
-        /* Big-endian combine.  */
-        res = (res1 << shift) | (res2 >> ((2 * 8) - shift));
-        return res;
-    }
-
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-    res = lduw_be_p((uint8_t *)haddr);
-    return res;
-}
-- 
2.17.0
