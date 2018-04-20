Received: from eggs.gnu.org ([2001:4830:134:3::10]:50832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJL-0005x6-53
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJJ-0005tO-3I
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:55 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9YJI-0005sV-PC
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:53 -0400
Received: by mail-wr0-x243.google.com with SMTP id v15-v6so6124574wrm.10
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 08:50:52 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 20 Apr 2018 16:50:42 +0100
Message-Id: <20180420155045.18862-4-alex.bennee@linaro.org>
In-Reply-To: <20180420155045.18862-1-alex.bennee@linaro.org>
References: <20180420155045.18862-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/6] accel/tcg: add DATA_SIZE = 2 to softmmu
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

Expand the results of softmmu-template.h with DATA_SIZE 2. We have to
ensure we expand with TCG_TARGET_REG_BITS @ 32 to make sure we get all
the helpers as needed for all guests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c  |   6 -
 accel/tcg/softmmu.c | 452 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 452 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7104bacc0f..3747657a97 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1032,9 +1032,6 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
 #define MMUSUFFIX _mmu
 
-#define DATA_SIZE 2
-#include "softmmu_template.h"
-
 #define DATA_SIZE 4
 #include "softmmu_template.h"
 
@@ -1106,9 +1103,6 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define GETPC() ((uintptr_t)0)
 #define SOFTMMU_CODE_ACCESS
 
-#define DATA_SIZE 2
-#include "softmmu_template.h"
-
 #define DATA_SIZE 4
 #include "softmmu_template.h"
 
diff --git a/accel/tcg/softmmu.c b/accel/tcg/softmmu.c
index f09aff453a..fcad3d360f 100644
--- a/accel/tcg/softmmu.c
+++ b/accel/tcg/softmmu.c
@@ -251,5 +251,457 @@ uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
 
 
 
+    return res;
+}
+
+static inline uint16_t io_readw(CPUArchState *env,
+                                              size_t mmu_idx, size_t index,
+                                              target_ulong addr,
+                                              uintptr_t retaddr)
+{
+    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, 2);
+}
+
+
+tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    unsigned mmu_idx = get_mmuidx(oi);
+    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+    uint16_t res;
+
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_LOAD,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if ((addr & TARGET_PAGE_MASK)
+         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+        if (!VICTIM_TLB_HIT(addr_read, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_DATA_LOAD,
+                     mmu_idx, retaddr);
+        }
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        if ((addr & (2 - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        /* ??? Note that the io helpers always read data in the target
+           byte ordering.  We should push the LE/BE request down into io.  */
+        res = io_readw(env, mmu_idx, index, addr, retaddr);
+        res = (res);
+        return res;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (2 > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
+                    >= TARGET_PAGE_SIZE)) {
+        target_ulong addr1, addr2;
+        uint16_t res1, res2;
+        unsigned shift;
+    do_unaligned_access:
+        addr1 = addr & ~(2 - 1);
+        addr2 = addr1 + 2;
+        res1 = helper_le_lduw_mmu(env, addr1, oi, retaddr);
+        res2 = helper_le_lduw_mmu(env, addr2, oi, retaddr);
+        shift = (addr & (2 - 1)) * 8;
+
+        /* Little-endian combine.  */
+        res = (res1 >> shift) | (res2 << ((2 * 8) - shift));
+        return res;
+    }
+
+    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+
+
+
+    res = lduw_le_p((uint8_t *)haddr);
+
+    return res;
+}
+
+
+tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    unsigned mmu_idx = get_mmuidx(oi);
+    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+    uint16_t res;
+
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_LOAD,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if ((addr & TARGET_PAGE_MASK)
+         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+        if (!VICTIM_TLB_HIT(addr_read, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_DATA_LOAD,
+                     mmu_idx, retaddr);
+        }
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        if ((addr & (2 - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        /* ??? Note that the io helpers always read data in the target
+           byte ordering.  We should push the LE/BE request down into io.  */
+        res = io_readw(env, mmu_idx, index, addr, retaddr);
+        res = bswap16(res);
+        return res;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (2 > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
+                    >= TARGET_PAGE_SIZE)) {
+        target_ulong addr1, addr2;
+        uint16_t res1, res2;
+        unsigned shift;
+    do_unaligned_access:
+        addr1 = addr & ~(2 - 1);
+        addr2 = addr1 + 2;
+        res1 = helper_be_lduw_mmu(env, addr1, oi, retaddr);
+        res2 = helper_be_lduw_mmu(env, addr2, oi, retaddr);
+        shift = (addr & (2 - 1)) * 8;
+
+        /* Big-endian combine.  */
+        res = (res1 << shift) | (res2 >> ((2 * 8) - shift));
+        return res;
+    }
+
+    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+    res = lduw_be_p((uint8_t *)haddr);
+    return res;
+}
+
+
+/* Provide signed versions of the load routines as well.  We can of course
+   avoid this for 64-bit data, or for 32-bit data on 32-bit host.  */
+
+tcg_target_ulong helper_le_ldsw_mmu(CPUArchState *env, target_ulong addr,
+                             TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return (int16_t)helper_le_lduw_mmu(env, addr, oi, retaddr);
+}
+
+
+tcg_target_ulong helper_be_ldsw_mmu(CPUArchState *env, target_ulong addr,
+                             TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return (int16_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
+}
+
+
+/* Provide signed versions of the load routines as well.  We can of course
+   avoid this for 64-bit data, or for 32-bit data on 32-bit host.  */
+static inline void io_writew(CPUArchState *env,
+                                          size_t mmu_idx, size_t index,
+                                          uint16_t val,
+                                          target_ulong addr,
+                                          uintptr_t retaddr)
+{
+    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, 2);
+}
+
+void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    unsigned mmu_idx = get_mmuidx(oi);
+    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if ((addr & TARGET_PAGE_MASK)
+        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+        if (!VICTIM_TLB_HIT(addr_write, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+        }
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        if ((addr & (2 - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        /* ??? Note that the io helpers always read data in the target
+           byte ordering.  We should push the LE/BE request down into io.  */
+        val = (val);
+        io_writew(env, mmu_idx, index, val, addr, retaddr);
+        return;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (2 > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
+                     >= TARGET_PAGE_SIZE)) {
+        int i, index2;
+        target_ulong page2, tlb_addr2;
+    do_unaligned_access:
+        /* Ensure the second page is in the TLB.  Note that the first page
+           is already guaranteed to be filled, and that the second page
+           cannot evict the first.  */
+        page2 = (addr + 2) & TARGET_PAGE_MASK;
+        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
+        if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
+            && !VICTIM_TLB_HIT(addr_write, page2)) {
+            tlb_fill(ENV_GET_CPU(env), page2, 2, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+        }
+
+        /* XXX: not efficient, but simple.  */
+        /* This loop must go in the forward direction to avoid issues
+           with self-modifying code in Windows 64-bit.  */
+        for (i = 0; i < 2; ++i) {
+            /* Little-endian extract.  */
+            uint8_t val8 = val >> (i * 8);
+            helper_ret_stb_mmu(env, addr + i, val8,
+                                            oi, retaddr);
+        }
+        return;
+    }
+
+    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+
+
+
+    stw_le_p((uint8_t *)haddr, val);
+
+}
+
+
+void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    unsigned mmu_idx = get_mmuidx(oi);
+    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if ((addr & TARGET_PAGE_MASK)
+        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+        if (!VICTIM_TLB_HIT(addr_write, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+        }
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        if ((addr & (2 - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        /* ??? Note that the io helpers always read data in the target
+           byte ordering.  We should push the LE/BE request down into io.  */
+        val = bswap16(val);
+        io_writew(env, mmu_idx, index, val, addr, retaddr);
+        return;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (2 > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
+                     >= TARGET_PAGE_SIZE)) {
+        int i, index2;
+        target_ulong page2, tlb_addr2;
+    do_unaligned_access:
+        /* Ensure the second page is in the TLB.  Note that the first page
+           is already guaranteed to be filled, and that the second page
+           cannot evict the first.  */
+        page2 = (addr + 2) & TARGET_PAGE_MASK;
+        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
+        if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
+            && !VICTIM_TLB_HIT(addr_write, page2)) {
+            tlb_fill(ENV_GET_CPU(env), page2, 2, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+        }
+
+        /* XXX: not efficient, but simple */
+        /* This loop must go in the forward direction to avoid issues
+           with self-modifying code.  */
+        for (i = 0; i < 2; ++i) {
+            /* Big-endian extract.  */
+            uint8_t val8 = val >> (((2 - 1) * 8) - (i * 8));
+            helper_ret_stb_mmu(env, addr + i, val8,
+                                            oi, retaddr);
+        }
+        return;
+    }
+
+    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+    stw_be_p((uint8_t *)haddr, val);
+}
+
+/* For the benefit of TCG generated code, we want to avoid the complication
+   of ABI-specific return type promotion and always return a value extended
+   to the register size of the host.  This is tcg_target_long, except in the
+   case of a 32-bit host and 64-bit data, and for that we always have
+   uint64_t.  Don't bother with this widened value for SOFTMMU_CODE_ACCESS.  */
+uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    unsigned mmu_idx = get_mmuidx(oi);
+    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+    uint16_t res;
+
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_INST_FETCH,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if ((addr & TARGET_PAGE_MASK)
+         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+        if (!VICTIM_TLB_HIT(addr_code, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_INST_FETCH,
+                     mmu_idx, retaddr);
+        }
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        if ((addr & (2 - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        /* ??? Note that the io helpers always read data in the target
+           byte ordering.  We should push the LE/BE request down into io.  */
+        res = io_readw(env, mmu_idx, index, addr, retaddr);
+        res = (res);
+        return res;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (2 > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
+                    >= TARGET_PAGE_SIZE)) {
+        target_ulong addr1, addr2;
+        uint16_t res1, res2;
+        unsigned shift;
+    do_unaligned_access:
+        addr1 = addr & ~(2 - 1);
+        addr2 = addr1 + 2;
+        res1 = helper_le_ldw_cmmu(env, addr1, oi, retaddr);
+        res2 = helper_le_ldw_cmmu(env, addr2, oi, retaddr);
+        shift = (addr & (2 - 1)) * 8;
+
+        /* Little-endian combine.  */
+        res = (res1 >> shift) | (res2 << ((2 * 8) - shift));
+        return res;
+    }
+
+    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+
+
+
+    res = lduw_le_p((uint8_t *)haddr);
+
+    return res;
+}
+
+
+uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    unsigned mmu_idx = get_mmuidx(oi);
+    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+    uint16_t res;
+
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_INST_FETCH,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if ((addr & TARGET_PAGE_MASK)
+         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+        if (!VICTIM_TLB_HIT(addr_code, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, 2, MMU_INST_FETCH,
+                     mmu_idx, retaddr);
+        }
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        if ((addr & (2 - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        /* ??? Note that the io helpers always read data in the target
+           byte ordering.  We should push the LE/BE request down into io.  */
+        res = io_readw(env, mmu_idx, index, addr, retaddr);
+        res = bswap16(res);
+        return res;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (2 > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + 2 - 1
+                    >= TARGET_PAGE_SIZE)) {
+        target_ulong addr1, addr2;
+        uint16_t res1, res2;
+        unsigned shift;
+    do_unaligned_access:
+        addr1 = addr & ~(2 - 1);
+        addr2 = addr1 + 2;
+        res1 = helper_be_ldw_cmmu(env, addr1, oi, retaddr);
+        res2 = helper_be_ldw_cmmu(env, addr2, oi, retaddr);
+        shift = (addr & (2 - 1)) * 8;
+
+        /* Big-endian combine.  */
+        res = (res1 << shift) | (res2 >> ((2 * 8) - shift));
+        return res;
+    }
+
+    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+    res = lduw_be_p((uint8_t *)haddr);
     return res;
 }
-- 
2.17.0
