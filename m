Received: from eggs.gnu.org ([209.51.188.92]:59160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gueWO-0007on-UU
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gueWM-0000BH-RH
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:20 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gueWM-0000Ac-Dm
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:18 -0500
Received: by mail-wm1-x336.google.com with SMTP id m1so10165082wml.2
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:31:18 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Feb 2019 14:31:13 +0000
Message-Id: <20190215143115.28777-2-alex.bennee@linaro.org>
In-Reply-To: <20190215143115.28777-1-alex.bennee@linaro.org>
References: <20190215143115.28777-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v3 1/3] accel/tcg: demacro cputlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, mark.cave-ayland@ilande.co.uk, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Instead of expanding a series of macros to generate the load/store
helpers we move stuff into common functions and rely on the compiler
to eliminate the dead code for each variant.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - rebase, apply tlb_fill fixes from 20190209162745.12668-3-cota@braap.org
  - ensure load_helper honours code/read in the victim_tlb access
  - convert comments to proper block style
---
 accel/tcg/cputlb.c | 483 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 457 insertions(+), 26 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 88cc8389e9..351f579fed 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1167,26 +1167,426 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 }
 
 #ifdef TARGET_WORDS_BIGENDIAN
-# define TGT_BE(X)  (X)
-# define TGT_LE(X)  BSWAP(X)
+#define NEED_BE_BSWAP 0
+#define NEED_LE_BSWAP 1
 #else
-# define TGT_BE(X)  BSWAP(X)
-# define TGT_LE(X)  (X)
+#define NEED_BE_BSWAP 1
+#define NEED_LE_BSWAP 0
 #endif
 
-#define MMUSUFFIX _mmu
+/*
+ * Byte Swap Helper
+ *
+ * This should all dead code away depending on the build host and
+ * access type.
+ */
 
-#define DATA_SIZE 1
-#include "softmmu_template.h"
+static inline uint64_t handle_bswap(uint64_t val, int size, bool big_endian)
+{
+    if ((big_endian && NEED_BE_BSWAP) || (!big_endian && NEED_LE_BSWAP)) {
+        switch (size) {
+        case 1: return val;
+        case 2: return bswap16(val);
+        case 4: return bswap32(val);
+        case 8: return bswap64(val);
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        return val;
+    }
+}
 
-#define DATA_SIZE 2
-#include "softmmu_template.h"
+/*
+ * Load Helpers
+ *
+ * We support two different access types. SOFTMMU_CODE_ACCESS is
+ * specifically for reading instructions from system memory. It is
+ * called by the translation loop and in some helpers where the code
+ * is disassembled. It shouldn't be called directly by guest code.
+ */
 
-#define DATA_SIZE 4
-#include "softmmu_template.h"
+static tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr,
+                                    size_t size, bool big_endian,
+                                    bool code_read)
+{
+    uintptr_t mmu_idx = get_mmuidx(oi);
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+    target_ulong tlb_addr = code_read ? entry->addr_code : entry->addr_read;
+    const size_t tlb_off = code_read ?
+        offsetof(CPUTLBEntry, addr_code) : offsetof(CPUTLBEntry, addr_read);
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+    tcg_target_ulong res;
+
+    /* Handle CPU specific unaligned behaviour */
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr,
+                             code_read ? MMU_INST_FETCH : MMU_DATA_LOAD,
+                             mmu_idx, retaddr);
+    }
 
-#define DATA_SIZE 8
-#include "softmmu_template.h"
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if (!tlb_hit(tlb_addr, addr)) {
+        if (!victim_tlb_hit(env, mmu_idx, index, tlb_off,
+                            addr & TARGET_PAGE_MASK)) {
+            tlb_fill(ENV_GET_CPU(env), addr, size,
+                     code_read ? MMU_INST_FETCH : MMU_DATA_LOAD,
+                     mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
+        }
+        tlb_addr = code_read ? entry->addr_code : entry->addr_read;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+        uint64_t tmp;
+
+        if ((addr & (size - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        tmp = io_readx(env, iotlbentry, mmu_idx, addr, retaddr,
+                       addr & tlb_addr & TLB_RECHECK,
+                       code_read ? MMU_INST_FETCH : MMU_DATA_LOAD, size);
+        return handle_bswap(tmp, size, big_endian);
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (size > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
+                    >= TARGET_PAGE_SIZE)) {
+        target_ulong addr1, addr2;
+        tcg_target_ulong r1, r2;
+        unsigned shift;
+    do_unaligned_access:
+        addr1 = addr & ~(size - 1);
+        addr2 = addr1 + size;
+        r1 = load_helper(env, addr1, oi, retaddr, size, big_endian, code_read);
+        r2 = load_helper(env, addr2, oi, retaddr, size, big_endian, code_read);
+        shift = (addr & (size - 1)) * 8;
+
+        if (big_endian) {
+            /* Big-endian combine.  */
+            res = (r1 << shift) | (r2 >> ((size * 8) - shift));
+        } else {
+            /* Little-endian combine.  */
+            res = (r1 >> shift) | (r2 << ((size * 8) - shift));
+        }
+        return res;
+    }
+
+    haddr = addr + entry->addend;
+
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
+    case 4:
+        if (big_endian) {
+            res = ldl_be_p((uint8_t *)haddr);
+        } else {
+            res = ldl_le_p((uint8_t *)haddr);
+        }
+        break;
+    case 8:
+        if (big_endian) {
+            res = ldq_be_p((uint8_t *)haddr);
+        } else {
+            res = ldq_le_p((uint8_t *)haddr);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    return res;
+}
+
+/*
+ * For the benefit of TCG generated code, we want to avoid the
+ * complication of ABI-specific return type promotion and always
+ * return a value extended to the register size of the host. This is
+ * tcg_target_long, except in the case of a 32-bit host and 64-bit
+ * data, and for that we always have uint64_t.
+ *
+ * We don't bother with this widened value for SOFTMMU_CODE_ACCESS.
+ */
+
+tcg_target_ulong __attribute__((flatten))
+helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                    uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 1, false, false);
+}
+
+tcg_target_ulong __attribute__((flatten))
+helper_le_lduw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, false, false);
+}
+
+tcg_target_ulong __attribute__((flatten))
+helper_be_lduw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, true, false);
+}
+
+tcg_target_ulong __attribute__((flatten))
+helper_le_ldul_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, false, false);
+}
+
+tcg_target_ulong __attribute__((flatten))
+helper_be_ldul_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, true, false);
+}
+
+uint64_t __attribute__((flatten))
+helper_le_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                  uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 8, false, false);
+}
+
+uint64_t __attribute__((flatten))
+helper_be_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                  uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 8, true, false);
+}
+
+/*
+ * Provide signed versions of the load routines as well.  We can of course
+ * avoid this for 64-bit data, or for 32-bit data on 32-bit host.
+ */
+
+
+tcg_target_ulong __attribute__((flatten))
+helper_ret_ldsb_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                    uintptr_t retaddr)
+{
+    return (int8_t)helper_ret_ldub_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong __attribute__((flatten))
+helper_le_ldsw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return (int16_t)helper_le_lduw_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong __attribute__((flatten))
+helper_be_ldsw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return (int16_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong
+helper_le_ldsl_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return (int32_t)helper_le_lduw_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong
+helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return (int32_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
+}
+
+/*
+ * Store Helpers
+ */
+
+static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+                         TCGMemOpIdx oi, uintptr_t retaddr, size_t size,
+                         bool big_endian)
+{
+    uintptr_t mmu_idx = get_mmuidx(oi);
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+    target_ulong tlb_addr = tlb_addr_write(entry);
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+
+    /* Handle CPU specific unaligned behaviour */
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if (!tlb_hit(tlb_addr, addr)) {
+        if (!VICTIM_TLB_HIT(addr_write, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
+        }
+        tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+
+        if ((addr & (size - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        io_writex(env, iotlbentry, mmu_idx,
+                  handle_bswap(val, size, big_endian),
+                  addr, retaddr, tlb_addr & TLB_RECHECK, size);
+        return;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (size > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
+                     >= TARGET_PAGE_SIZE)) {
+        int i;
+        uintptr_t index2;
+        CPUTLBEntry *entry2;
+        target_ulong page2, tlb_addr2;
+    do_unaligned_access:
+        /*
+         * Ensure the second page is in the TLB.  Note that the first page
+         * is already guaranteed to be filled, and that the second page
+         * cannot evict the first.
+         */
+        page2 = (addr + size) & TARGET_PAGE_MASK;
+        index2 = tlb_index(env, mmu_idx, page2);
+        entry2 = tlb_entry(env, mmu_idx, index2);
+        tlb_addr2 = tlb_addr_write(entry2);
+        if (!tlb_hit_page(tlb_addr2, page2)
+            && !VICTIM_TLB_HIT(addr_write, page2)) {
+            tlb_fill(ENV_GET_CPU(env), page2, size, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+            index2 = tlb_index(env, mmu_idx, page2);
+            entry2 = tlb_entry(env, mmu_idx, index2);
+        }
+
+        /*
+         * XXX: not efficient, but simple.
+         * This loop must go in the forward direction to avoid issues
+         * with self-modifying code in Windows 64-bit.
+         */
+        for (i = 0; i < size; ++i) {
+            uint8_t val8;
+            if (big_endian) {
+                /* Big-endian extract.  */
+                val8 = val >> (((size - 1) * 8) - (i * 8));
+            } else {
+                /* Little-endian extract.  */
+                val8 = val >> (i * 8);
+            }
+            store_helper(env, addr + i, val8, oi, retaddr, 1, big_endian);
+        }
+        return;
+    }
+
+    haddr = addr + entry->addend;
+
+    switch (size) {
+    case 1:
+        stb_p((uint8_t *)haddr, val);
+        break;
+    case 2:
+        if (big_endian) {
+            stw_be_p((uint8_t *)haddr, val);
+        } else {
+            stw_le_p((uint8_t *)haddr, val);
+        }
+        break;
+    case 4:
+        if (big_endian) {
+            stl_be_p((uint8_t *)haddr, val);
+        } else {
+            stl_le_p((uint8_t *)haddr, val);
+        }
+        break;
+    case 8:
+        if (big_endian) {
+            stq_be_p((uint8_t *)haddr, val);
+        } else {
+            stq_le_p((uint8_t *)haddr, val);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+void __attribute__((flatten))
+helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
+                   TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 1, false);
+}
+
+void __attribute__((flatten))
+helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 2, false);
+}
+
+void __attribute__((flatten))
+helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 2, true);
+}
+
+void __attribute__((flatten))
+helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 4, false);
+}
+
+void __attribute__((flatten))
+helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 4, true);
+}
+
+void __attribute__((flatten))
+helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 8, false);
+}
+
+void __attribute__((flatten))
+helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 8, true);
+}
 
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
    them callable from other helpers.  */
@@ -1247,20 +1647,51 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
 /* Code access functions.  */
 
-#undef MMUSUFFIX
-#define MMUSUFFIX _cmmu
-#undef GETPC
-#define GETPC() ((uintptr_t)0)
-#define SOFTMMU_CODE_ACCESS
+uint8_t __attribute__((flatten))
+helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                    uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 1, false, true);
+}
 
-#define DATA_SIZE 1
-#include "softmmu_template.h"
+uint16_t __attribute__((flatten))
+helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, false, true);
+}
 
-#define DATA_SIZE 2
-#include "softmmu_template.h"
+uint16_t __attribute__((flatten))
+helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, true, true);
+}
 
-#define DATA_SIZE 4
-#include "softmmu_template.h"
+uint32_t __attribute__((flatten))
+helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, false, true);
+}
 
-#define DATA_SIZE 8
-#include "softmmu_template.h"
+uint32_t __attribute__((flatten))
+helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, true, true);
+}
+
+uint64_t __attribute__((flatten))
+helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 8, false, true);
+}
+
+uint64_t __attribute__((flatten))
+helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 8, true, true);
+}
-- 
2.20.1
