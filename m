Received: from eggs.gnu.org ([209.51.188.92]:59185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gueWQ-0007qM-SQ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gueWO-0000DR-JP
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:55252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gueWN-0000Bh-Up
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:20 -0500
Received: by mail-wm1-x32a.google.com with SMTP id a62so10153186wmh.4
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:31:19 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Feb 2019 14:31:15 +0000
Message-Id: <20190215143115.28777-4-alex.bennee@linaro.org>
In-Reply-To: <20190215143115.28777-1-alex.bennee@linaro.org>
References: <20190215143115.28777-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/3] accel/tcg: move unaligned helpers out
 of core helpers
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

Using __flatten__ ends up with fairly large functions. Attempt to
ameliorate this by moving the unaligned handling out of the main
helper. We can now use __always_inline__ instead of __flatten__ and
keep the main functions relatively small.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - take care to mask high bits in unaligned_load_helper
---
 accel/tcg/cputlb.c | 200 ++++++++++++++++++++++++---------------------
 1 file changed, 109 insertions(+), 91 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 351f579fed..5f225e3623 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1206,10 +1206,47 @@ static inline uint64_t handle_bswap(uint64_t val, int size, bool big_endian)
  * is disassembled. It shouldn't be called directly by guest code.
  */
 
-static tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
-                                    TCGMemOpIdx oi, uintptr_t retaddr,
-                                    size_t size, bool big_endian,
-                                    bool code_read)
+static inline __attribute__((__always_inline__))
+tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
+                             TCGMemOpIdx oi, uintptr_t retaddr,
+                             size_t size, bool big_endian,
+                             bool code_read);
+
+static tcg_target_ulong unaligned_load_helper(CPUArchState *env, target_ulong addr,
+                                              TCGMemOpIdx oi, uintptr_t retaddr,
+                                              size_t size, bool big_endian,
+                                              bool code_read)
+{
+    target_ulong addr1, addr2;
+    tcg_target_ulong res, r1, r2;
+    const tcg_target_ulong size_mask = MAKE_64BIT_MASK(0, size * 8);
+    unsigned shift;
+
+    addr1 = addr & ~(size - 1);
+    addr2 = addr1 + size;
+
+    r1 = load_helper(env, addr1, oi, retaddr, size, big_endian, code_read);
+    r2 = load_helper(env, addr2, oi, retaddr, size, big_endian, code_read);
+    shift = (addr & (size - 1)) * 8;
+
+    if (big_endian) {
+        /* Big-endian combine.  */
+        r2 &= size_mask;
+        res = (r1 << shift) | (r2 >> ((size * 8) - shift));
+    } else {
+        /* Little-endian combine.  */
+        r1 &= size_mask;
+        res = (r1 >> shift) | (r2 << ((size * 8) - shift));
+    }
+    return res;
+}
+
+
+static inline __attribute__((__always_inline__))
+tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
+                             TCGMemOpIdx oi, uintptr_t retaddr,
+                             size_t size, bool big_endian,
+                             bool code_read)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1247,7 +1284,8 @@ static tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
         uint64_t tmp;
 
         if ((addr & (size - 1)) != 0) {
-            goto do_unaligned_access;
+            return unaligned_load_helper(env, addr, oi, retaddr,
+                                         size, big_endian, code_read);
         }
 
         tmp = io_readx(env, iotlbentry, mmu_idx, addr, retaddr,
@@ -1260,24 +1298,9 @@ static tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
     if (size > 1
         && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
                     >= TARGET_PAGE_SIZE)) {
-        target_ulong addr1, addr2;
-        tcg_target_ulong r1, r2;
-        unsigned shift;
-    do_unaligned_access:
-        addr1 = addr & ~(size - 1);
-        addr2 = addr1 + size;
-        r1 = load_helper(env, addr1, oi, retaddr, size, big_endian, code_read);
-        r2 = load_helper(env, addr2, oi, retaddr, size, big_endian, code_read);
-        shift = (addr & (size - 1)) * 8;
 
-        if (big_endian) {
-            /* Big-endian combine.  */
-            res = (r1 << shift) | (r2 >> ((size * 8) - shift));
-        } else {
-            /* Little-endian combine.  */
-            res = (r1 >> shift) | (r2 << ((size * 8) - shift));
-        }
-        return res;
+        return unaligned_load_helper(env, addr, oi, retaddr,
+                                     size, big_endian, code_read);
     }
 
     haddr = addr + entry->addend;
@@ -1325,50 +1348,49 @@ static tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
  * We don't bother with this widened value for SOFTMMU_CODE_ACCESS.
  */
 
-tcg_target_ulong __attribute__((flatten))
+tcg_target_ulong
 helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                     uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 1, false, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
+tcg_target_ulong
 helper_le_lduw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, false, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
+tcg_target_ulong
 helper_be_lduw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, true, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
+tcg_target_ulong
 helper_le_ldul_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, false, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
+tcg_target_ulong
 helper_be_ldul_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, true, false);
 }
 
-uint64_t __attribute__((flatten))
-helper_le_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+
+uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                   uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, false, false);
 }
 
-uint64_t __attribute__((flatten))
-helper_be_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                   uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, true, false);
@@ -1379,22 +1401,21 @@ helper_be_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
  * avoid this for 64-bit data, or for 32-bit data on 32-bit host.
  */
 
-
-tcg_target_ulong __attribute__((flatten))
+tcg_target_ulong
 helper_ret_ldsb_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                     uintptr_t retaddr)
 {
     return (int8_t)helper_ret_ldub_mmu(env, addr, oi, retaddr);
 }
 
-tcg_target_ulong __attribute__((flatten))
+tcg_target_ulong
 helper_le_ldsw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
     return (int16_t)helper_le_lduw_mmu(env, addr, oi, retaddr);
 }
 
-tcg_target_ulong __attribute__((flatten))
+tcg_target_ulong
 helper_be_ldsw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
@@ -1418,10 +1439,43 @@ helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 /*
  * Store Helpers
  */
+static inline __attribute__((__always_inline__))
+void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr, size_t size,
+                  bool big_endian);
 
-static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
-                         TCGMemOpIdx oi, uintptr_t retaddr, size_t size,
-                         bool big_endian)
+
+static void
+unaligned_store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr, size_t size,
+                       bool big_endian)
+{
+    int i;
+
+    /*
+     * This is inefficient but simple and hopefully on the slow path
+     * anyway. The loop must go in the forward direction to avoid
+     * issues with self-modifying code in Windows 64-bit.
+     */
+    for (i = 0; i < size; ++i) {
+        uint8_t val8;
+        if (big_endian) {
+            /* Big-endian extract.  */
+            val8 = val >> (((size - 1) * 8) - (i * 8));
+        } else {
+            /* Little-endian extract.  */
+            val8 = val >> (i * 8);
+        }
+        store_helper(env, addr + i, val8, oi, retaddr, 1, big_endian);
+    }
+    return;
+}
+
+
+static inline __attribute__((__always_inline__))
+void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr, size_t size,
+                  bool big_endian)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1452,7 +1506,8 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
 
         if ((addr & (size - 1)) != 0) {
-            goto do_unaligned_access;
+            unaligned_store_helper(env, addr, val, oi, retaddr, size, big_endian);
+            return;
         }
 
         io_writex(env, iotlbentry, mmu_idx,
@@ -1465,44 +1520,7 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     if (size > 1
         && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
                      >= TARGET_PAGE_SIZE)) {
-        int i;
-        uintptr_t index2;
-        CPUTLBEntry *entry2;
-        target_ulong page2, tlb_addr2;
-    do_unaligned_access:
-        /*
-         * Ensure the second page is in the TLB.  Note that the first page
-         * is already guaranteed to be filled, and that the second page
-         * cannot evict the first.
-         */
-        page2 = (addr + size) & TARGET_PAGE_MASK;
-        index2 = tlb_index(env, mmu_idx, page2);
-        entry2 = tlb_entry(env, mmu_idx, index2);
-        tlb_addr2 = tlb_addr_write(entry2);
-        if (!tlb_hit_page(tlb_addr2, page2)
-            && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, size, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-            index2 = tlb_index(env, mmu_idx, page2);
-            entry2 = tlb_entry(env, mmu_idx, index2);
-        }
-
-        /*
-         * XXX: not efficient, but simple.
-         * This loop must go in the forward direction to avoid issues
-         * with self-modifying code in Windows 64-bit.
-         */
-        for (i = 0; i < size; ++i) {
-            uint8_t val8;
-            if (big_endian) {
-                /* Big-endian extract.  */
-                val8 = val >> (((size - 1) * 8) - (i * 8));
-            } else {
-                /* Little-endian extract.  */
-                val8 = val >> (i * 8);
-            }
-            store_helper(env, addr + i, val8, oi, retaddr, 1, big_endian);
-        }
+        unaligned_store_helper(env, addr, val, oi, retaddr, size, big_endian);
         return;
     }
 
@@ -1539,49 +1557,49 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     }
 }
 
-void __attribute__((flatten))
+void
 helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
                    TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 1, false);
 }
 
-void __attribute__((flatten))
+void
 helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 2, false);
 }
 
-void __attribute__((flatten))
+void
 helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 2, true);
 }
 
-void __attribute__((flatten))
+void
 helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 4, false);
 }
 
-void __attribute__((flatten))
+void
 helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 4, true);
 }
 
-void __attribute__((flatten))
+void
 helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 8, false);
 }
 
-void __attribute__((flatten))
+void
 helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
@@ -1647,49 +1665,49 @@ helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 
 /* Code access functions.  */
 
-uint8_t __attribute__((flatten))
+uint8_t
 helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                     uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 1, false, true);
 }
 
-uint16_t __attribute__((flatten))
+uint16_t
 helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, false, true);
 }
 
-uint16_t __attribute__((flatten))
+uint16_t
 helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, true, true);
 }
 
-uint32_t __attribute__((flatten))
+uint32_t
 helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, false, true);
 }
 
-uint32_t __attribute__((flatten))
+uint32_t
 helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, true, true);
 }
 
-uint64_t __attribute__((flatten))
+uint64_t
 helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, false, true);
 }
 
-uint64_t __attribute__((flatten))
+uint64_t
 helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
                    uintptr_t retaddr)
 {
-- 
2.20.1
