Received: from eggs.gnu.org ([2001:4830:134:3::10]:50893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJP-00061d-O5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJM-0005wJ-PQ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:59 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9YJM-0005vT-Af
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:56 -0400
Received: by mail-wr0-x241.google.com with SMTP id h3-v6so24247382wrh.5
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 08:50:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 20 Apr 2018 16:50:45 +0100
Message-Id: <20180420155045.18862-7-alex.bennee@linaro.org>
In-Reply-To: <20180420155045.18862-1-alex.bennee@linaro.org>
References: <20180420155045.18862-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 6/6] accel/tcg: convert 4/8 byte access and
 remove softmmu_template
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

With the basic helpers in place adding stubs for the remaining SoftMMU
helpers is easy. We shuffle handling of byte-swapping into a little
helper function and directly call io_readx/io_writex.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c           |  30 ---
 accel/tcg/softmmu.c          | 254 +++++++++++++-------
 accel/tcg/softmmu_template.h | 435 -----------------------------------
 3 files changed, 171 insertions(+), 548 deletions(-)
 delete mode 100644 accel/tcg/softmmu_template.h

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3747657a97..7e7b698eeb 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1022,22 +1022,6 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     cpu_loop_exit_atomic(ENV_GET_CPU(env), retaddr);
 }
 
-#ifdef TARGET_WORDS_BIGENDIAN
-# define TGT_BE(X)  (X)
-# define TGT_LE(X)  BSWAP(X)
-#else
-# define TGT_BE(X)  BSWAP(X)
-# define TGT_LE(X)  (X)
-#endif
-
-#define MMUSUFFIX _mmu
-
-#define DATA_SIZE 4
-#include "softmmu_template.h"
-
-#define DATA_SIZE 8
-#include "softmmu_template.h"
-
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
    them callable from other helpers.  */
 
@@ -1094,17 +1078,3 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define DATA_SIZE 8
 #include "atomic_template.h"
 #endif
-
-/* Code access functions.  */
-
-#undef MMUSUFFIX
-#define MMUSUFFIX _cmmu
-#undef GETPC
-#define GETPC() ((uintptr_t)0)
-#define SOFTMMU_CODE_ACCESS
-
-#define DATA_SIZE 4
-#include "softmmu_template.h"
-
-#define DATA_SIZE 8
-#include "softmmu_template.h"
diff --git a/accel/tcg/softmmu.c b/accel/tcg/softmmu.c
index 2be2d9025f..a0106cd9c0 100644
--- a/accel/tcg/softmmu.c
+++ b/accel/tcg/softmmu.c
@@ -10,12 +10,42 @@
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
 
+#ifdef TARGET_WORDS_BIGENDIAN
+#define NEED_BE_BSWAP 0
+#define NEED_LE_BSWAP 1
+#else
+#define NEED_BE_BSWAP 1
+#define NEED_LE_BSWAP 0
+#endif
+
+/*
+ * Byte Swap Helper
+ *
+ * This should all dead code away depending on the build host and
+ * access type.
+ */
+
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
+
 /* Macro to call the above, with local variables from the use context.  */
 #define VICTIM_TLB_HIT(TY, ADDR) \
   victim_tlb_hit(env, mmu_idx, index, offsetof(CPUTLBEntry, TY), \
                  (ADDR) & TARGET_PAGE_MASK)
 
-
 /*
  * Load Helpers
  *
@@ -25,19 +55,6 @@
  * is disassembled. It shouldn't be called directly by guest code.
  */
 
-static inline uint8_t io_readb(CPUArchState *env, size_t mmu_idx, size_t index,
-                               target_ulong addr, uintptr_t retaddr)
-{
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, 1);
-}
-
-static inline uint16_t io_readw(CPUArchState *env, size_t mmu_idx, size_t index,
-                                target_ulong addr, uintptr_t retaddr)
-{
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, 2);
-}
 
 static tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
                                     size_t size, bool big_endian,
@@ -88,35 +105,15 @@ static tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
 
     /* Handle an IO access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+        uint64_t tmp;
+
         if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
 
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        switch (size) {
-        case 1:
-        {
-            uint8_t rv = io_readb(env, mmu_idx, index, addr, retaddr);
-            res = rv;
-            break;
-        }
-        case 2:
-        {
-            uint16_t rv = io_readw(env, mmu_idx, index, addr, retaddr);
-            if (big_endian) {
-                res = bswap16(rv);
-            } else {
-                res = rv;
-            }
-            break;
-        }
-        default:
-            g_assert_not_reached();
-            break;
-        }
-
-        return res;
+        tmp = io_readx(env, iotlbentry, mmu_idx, addr, retaddr, size);
+        return handle_bswap(tmp, size, big_endian);
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -156,6 +153,20 @@ static tcg_target_ulong load_helper(CPUArchState *env, target_ulong addr,
             res = lduw_le_p((uint8_t *)haddr);
         }
         break;
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
     default:
         g_assert_not_reached();
         break;
@@ -201,6 +212,42 @@ tcg_target_ulong __attribute__((flatten)) helper_be_lduw_mmu(CPUArchState *env,
     return load_helper(env, addr, 2, true, false, oi, retaddr);
 }
 
+tcg_target_ulong __attribute__((flatten)) helper_le_ldul_mmu(CPUArchState *env,
+                                                             target_ulong addr,
+                                                             TCGMemOpIdx oi,
+                                                             uintptr_t retaddr)
+{
+    return load_helper(env, addr, 4, false, false, oi, retaddr);
+}
+
+tcg_target_ulong __attribute__((flatten)) helper_be_ldul_mmu(CPUArchState *env,
+                                                             target_ulong addr,
+                                                             TCGMemOpIdx oi,
+                                                             uintptr_t retaddr)
+{
+    return load_helper(env, addr, 4, true, false, oi, retaddr);
+}
+
+tcg_target_ulong __attribute__((flatten)) helper_le_ldq_mmu(CPUArchState *env,
+                                                            target_ulong addr,
+                                                            TCGMemOpIdx oi,
+                                                            uintptr_t retaddr)
+{
+    return load_helper(env, addr, 8, false, false, oi, retaddr);
+}
+
+tcg_target_ulong __attribute__((flatten)) helper_be_ldq_mmu(CPUArchState *env,
+                                                             target_ulong addr,
+                                                             TCGMemOpIdx oi,
+                                                             uintptr_t retaddr)
+{
+    return load_helper(env, addr, 8, true, false, oi, retaddr);
+}
+
+/*
+ * Code Access
+ */
+
 uint8_t __attribute__((flatten)) helper_ret_ldb_cmmu (CPUArchState *env,
                                                       target_ulong addr,
                                                       TCGMemOpIdx oi,
@@ -225,6 +272,38 @@ uint16_t __attribute__((flatten)) helper_be_ldw_cmmu(CPUArchState *env,
     return load_helper(env, addr, 2, true, true, oi, retaddr);
 }
 
+uint32_t __attribute__((flatten)) helper_le_ldl_cmmu(CPUArchState *env,
+                                                     target_ulong addr,
+                                                     TCGMemOpIdx oi,
+                                                     uintptr_t retaddr)
+{
+    return load_helper(env, addr, 4, false, true, oi, retaddr);
+}
+
+uint32_t __attribute__((flatten)) helper_be_ldl_cmmu(CPUArchState *env,
+                                                     target_ulong addr,
+                                                     TCGMemOpIdx oi,
+                                                     uintptr_t retaddr)
+{
+    return load_helper(env, addr, 4, true, true, oi, retaddr);
+}
+
+uint64_t __attribute__((flatten)) helper_le_ldq_cmmu(CPUArchState *env,
+                                                     target_ulong addr,
+                                                     TCGMemOpIdx oi,
+                                                     uintptr_t retaddr)
+{
+    return load_helper(env, addr, 8, false, true, oi, retaddr);
+}
+
+uint64_t __attribute__((flatten)) helper_be_ldq_cmmu(CPUArchState *env,
+                                                     target_ulong addr,
+                                                     TCGMemOpIdx oi,
+                                                     uintptr_t retaddr)
+{
+    return load_helper(env, addr, 8, true, true, oi, retaddr);
+}
+
 /* Provide signed versions of the load routines as well.  We can of course
    avoid this for 64-bit data, or for 32-bit data on 32-bit host.  */
 
@@ -249,26 +328,6 @@ tcg_target_ulong __attribute__((flatten)) helper_be_ldsw_mmu(CPUArchState *env,
  * Store Helpers
  */
 
-static inline void io_writeb(CPUArchState *env,
-                                          size_t mmu_idx, size_t index,
-                                          uint8_t val,
-                                          target_ulong addr,
-                                          uintptr_t retaddr)
-{
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, 1);
-}
-
-static inline void io_writew(CPUArchState *env,
-                                          size_t mmu_idx, size_t index,
-                                          uint16_t val,
-                                          target_ulong addr,
-                                          uintptr_t retaddr)
-{
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, 2);
-}
-
 static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
                          size_t size, bool big_endian, TCGMemOpIdx oi,
                          uintptr_t retaddr)
@@ -296,34 +355,15 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
     /* Handle an IO access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+
         if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
 
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        switch (size) {
-        case 1:
-        {
-            uint8_t wv = (val);
-            io_writeb(env, mmu_idx, index, wv, addr, retaddr);
-            break;
-        }
-        case 2:
-        {
-            uint16_t wv;
-            if (big_endian) {
-                wv = bswap16( (uint16_t) val);
-            } else {
-                wv = (val);
-            }
-            io_writew(env, mmu_idx, index, wv, addr, retaddr);
-            break;
-        }
-        default:
-            g_assert_not_reached();
-            break;
-        }
+        io_writex(env, iotlbentry, mmu_idx,
+                  handle_bswap(val, size, big_endian),
+                  addr, retaddr, size);
         return;
     }
 
@@ -376,6 +416,20 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             stw_le_p((uint8_t *)haddr, val);
         }
         break;
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
     default:
         g_assert_not_reached();
         break;
@@ -407,3 +461,37 @@ void __attribute__((flatten)) helper_be_stw_mmu(CPUArchState *env,
 {
     store_helper(env, addr, val, 2, true, oi, retaddr);
 }
+
+void __attribute__((flatten)) helper_le_stl_mmu(CPUArchState *env,
+                                                target_ulong addr, uint32_t val,
+                                                TCGMemOpIdx oi,
+                                                uintptr_t retaddr)
+{
+    store_helper(env, addr, val, 4, false, oi, retaddr);
+}
+
+
+void __attribute__((flatten)) helper_be_stl_mmu(CPUArchState *env,
+                                                target_ulong addr, uint32_t val,
+                                                TCGMemOpIdx oi,
+                                                uintptr_t retaddr)
+{
+    store_helper(env, addr, val, 4, true, oi, retaddr);
+}
+
+void __attribute__((flatten)) helper_le_stq_mmu(CPUArchState *env,
+                                                target_ulong addr, uint64_t val,
+                                                TCGMemOpIdx oi,
+                                                uintptr_t retaddr)
+{
+    store_helper(env, addr, val, 8, false, oi, retaddr);
+}
+
+
+void __attribute__((flatten)) helper_be_stq_mmu(CPUArchState *env,
+                                                target_ulong addr, uint64_t val,
+                                                TCGMemOpIdx oi,
+                                                uintptr_t retaddr)
+{
+    store_helper(env, addr, val, 8, true, oi, retaddr);
+}
diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
deleted file mode 100644
index 239ea6692b..0000000000
--- a/accel/tcg/softmmu_template.h
+++ /dev/null
@@ -1,435 +0,0 @@
-/*
- *  Software MMU support
- *
- * Generate helpers used by TCG for qemu_ld/st ops and code load
- * functions.
- *
- * Included from target op helpers and exec.c.
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-#if DATA_SIZE == 8
-#define SUFFIX q
-#define LSUFFIX q
-#define SDATA_TYPE  int64_t
-#define DATA_TYPE  uint64_t
-#elif DATA_SIZE == 4
-#define SUFFIX l
-#define LSUFFIX l
-#define SDATA_TYPE  int32_t
-#define DATA_TYPE  uint32_t
-#elif DATA_SIZE == 2
-#define SUFFIX w
-#define LSUFFIX uw
-#define SDATA_TYPE  int16_t
-#define DATA_TYPE  uint16_t
-#elif DATA_SIZE == 1
-#define SUFFIX b
-#define LSUFFIX ub
-#define SDATA_TYPE  int8_t
-#define DATA_TYPE  uint8_t
-#else
-#error unsupported data size
-#endif
-
-
-/* For the benefit of TCG generated code, we want to avoid the complication
-   of ABI-specific return type promotion and always return a value extended
-   to the register size of the host.  This is tcg_target_long, except in the
-   case of a 32-bit host and 64-bit data, and for that we always have
-   uint64_t.  Don't bother with this widened value for SOFTMMU_CODE_ACCESS.  */
-#if defined(SOFTMMU_CODE_ACCESS) || DATA_SIZE == 8
-# define WORD_TYPE  DATA_TYPE
-# define USUFFIX    SUFFIX
-#else
-# define WORD_TYPE  tcg_target_ulong
-# define USUFFIX    glue(u, SUFFIX)
-# define SSUFFIX    glue(s, SUFFIX)
-#endif
-
-#ifdef SOFTMMU_CODE_ACCESS
-#define READ_ACCESS_TYPE MMU_INST_FETCH
-#define ADDR_READ addr_code
-#else
-#define READ_ACCESS_TYPE MMU_DATA_LOAD
-#define ADDR_READ addr_read
-#endif
-
-#if DATA_SIZE == 8
-# define BSWAP(X)  bswap64(X)
-#elif DATA_SIZE == 4
-# define BSWAP(X)  bswap32(X)
-#elif DATA_SIZE == 2
-# define BSWAP(X)  bswap16(X)
-#else
-# define BSWAP(X)  (X)
-#endif
-
-#if DATA_SIZE == 1
-# define helper_le_ld_name  glue(glue(helper_ret_ld, USUFFIX), MMUSUFFIX)
-# define helper_be_ld_name  helper_le_ld_name
-# define helper_le_lds_name glue(glue(helper_ret_ld, SSUFFIX), MMUSUFFIX)
-# define helper_be_lds_name helper_le_lds_name
-# define helper_le_st_name  glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)
-# define helper_be_st_name  helper_le_st_name
-#else
-# define helper_le_ld_name  glue(glue(helper_le_ld, USUFFIX), MMUSUFFIX)
-# define helper_be_ld_name  glue(glue(helper_be_ld, USUFFIX), MMUSUFFIX)
-# define helper_le_lds_name glue(glue(helper_le_ld, SSUFFIX), MMUSUFFIX)
-# define helper_be_lds_name glue(glue(helper_be_ld, SSUFFIX), MMUSUFFIX)
-# define helper_le_st_name  glue(glue(helper_le_st, SUFFIX), MMUSUFFIX)
-# define helper_be_st_name  glue(glue(helper_be_st, SUFFIX), MMUSUFFIX)
-#endif
-
-#ifndef SOFTMMU_CODE_ACCESS
-static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArchState *env,
-                                              size_t mmu_idx, size_t index,
-                                              target_ulong addr,
-                                              uintptr_t retaddr)
-{
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, DATA_SIZE);
-}
-#endif
-
-WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-    DATA_TYPE res;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
-        if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
-                     mmu_idx, retaddr);
-        }
-        tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (DATA_SIZE - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr);
-        res = TGT_LE(res);
-        return res;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (DATA_SIZE > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
-                    >= TARGET_PAGE_SIZE)) {
-        target_ulong addr1, addr2;
-        DATA_TYPE res1, res2;
-        unsigned shift;
-    do_unaligned_access:
-        addr1 = addr & ~(DATA_SIZE - 1);
-        addr2 = addr1 + DATA_SIZE;
-        res1 = helper_le_ld_name(env, addr1, oi, retaddr);
-        res2 = helper_le_ld_name(env, addr2, oi, retaddr);
-        shift = (addr & (DATA_SIZE - 1)) * 8;
-
-        /* Little-endian combine.  */
-        res = (res1 >> shift) | (res2 << ((DATA_SIZE * 8) - shift));
-        return res;
-    }
-
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-#if DATA_SIZE == 1
-    res = glue(glue(ld, LSUFFIX), _p)((uint8_t *)haddr);
-#else
-    res = glue(glue(ld, LSUFFIX), _le_p)((uint8_t *)haddr);
-#endif
-    return res;
-}
-
-#if DATA_SIZE > 1
-WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-    DATA_TYPE res;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if ((addr & TARGET_PAGE_MASK)
-         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
-        if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
-                     mmu_idx, retaddr);
-        }
-        tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (DATA_SIZE - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr);
-        res = TGT_BE(res);
-        return res;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (DATA_SIZE > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
-                    >= TARGET_PAGE_SIZE)) {
-        target_ulong addr1, addr2;
-        DATA_TYPE res1, res2;
-        unsigned shift;
-    do_unaligned_access:
-        addr1 = addr & ~(DATA_SIZE - 1);
-        addr2 = addr1 + DATA_SIZE;
-        res1 = helper_be_ld_name(env, addr1, oi, retaddr);
-        res2 = helper_be_ld_name(env, addr2, oi, retaddr);
-        shift = (addr & (DATA_SIZE - 1)) * 8;
-
-        /* Big-endian combine.  */
-        res = (res1 << shift) | (res2 >> ((DATA_SIZE * 8) - shift));
-        return res;
-    }
-
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-    res = glue(glue(ld, LSUFFIX), _be_p)((uint8_t *)haddr);
-    return res;
-}
-#endif /* DATA_SIZE > 1 */
-
-#ifndef SOFTMMU_CODE_ACCESS
-
-/* Provide signed versions of the load routines as well.  We can of course
-   avoid this for 64-bit data, or for 32-bit data on 32-bit host.  */
-#if DATA_SIZE * 8 < TCG_TARGET_REG_BITS
-WORD_TYPE helper_le_lds_name(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return (SDATA_TYPE)helper_le_ld_name(env, addr, oi, retaddr);
-}
-
-# if DATA_SIZE > 1
-WORD_TYPE helper_be_lds_name(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return (SDATA_TYPE)helper_be_ld_name(env, addr, oi, retaddr);
-}
-# endif
-#endif
-
-static inline void glue(io_write, SUFFIX)(CPUArchState *env,
-                                          size_t mmu_idx, size_t index,
-                                          DATA_TYPE val,
-                                          target_ulong addr,
-                                          uintptr_t retaddr)
-{
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, DATA_SIZE);
-}
-
-void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
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
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-        }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (DATA_SIZE - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        val = TGT_LE(val);
-        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr);
-        return;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (DATA_SIZE > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
-                     >= TARGET_PAGE_SIZE)) {
-        int i, index2;
-        target_ulong page2, tlb_addr2;
-    do_unaligned_access:
-        /* Ensure the second page is in the TLB.  Note that the first page
-           is already guaranteed to be filled, and that the second page
-           cannot evict the first.  */
-        page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
-        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
-        if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
-            && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-        }
-
-        /* XXX: not efficient, but simple.  */
-        /* This loop must go in the forward direction to avoid issues
-           with self-modifying code in Windows 64-bit.  */
-        for (i = 0; i < DATA_SIZE; ++i) {
-            /* Little-endian extract.  */
-            uint8_t val8 = val >> (i * 8);
-            glue(helper_ret_stb, MMUSUFFIX)(env, addr + i, val8,
-                                            oi, retaddr);
-        }
-        return;
-    }
-
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-#if DATA_SIZE == 1
-    glue(glue(st, SUFFIX), _p)((uint8_t *)haddr, val);
-#else
-    glue(glue(st, SUFFIX), _le_p)((uint8_t *)haddr, val);
-#endif
-}
-
-#if DATA_SIZE > 1
-void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
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
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-        }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (DATA_SIZE - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        val = TGT_BE(val);
-        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr);
-        return;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (DATA_SIZE > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
-                     >= TARGET_PAGE_SIZE)) {
-        int i, index2;
-        target_ulong page2, tlb_addr2;
-    do_unaligned_access:
-        /* Ensure the second page is in the TLB.  Note that the first page
-           is already guaranteed to be filled, and that the second page
-           cannot evict the first.  */
-        page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
-        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
-        if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
-            && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-        }
-
-        /* XXX: not efficient, but simple */
-        /* This loop must go in the forward direction to avoid issues
-           with self-modifying code.  */
-        for (i = 0; i < DATA_SIZE; ++i) {
-            /* Big-endian extract.  */
-            uint8_t val8 = val >> (((DATA_SIZE - 1) * 8) - (i * 8));
-            glue(helper_ret_stb, MMUSUFFIX)(env, addr + i, val8,
-                                            oi, retaddr);
-        }
-        return;
-    }
-
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
-    glue(glue(st, SUFFIX), _be_p)((uint8_t *)haddr, val);
-}
-#endif /* DATA_SIZE > 1 */
-#endif /* !defined(SOFTMMU_CODE_ACCESS) */
-
-#undef READ_ACCESS_TYPE
-#undef DATA_TYPE
-#undef SUFFIX
-#undef LSUFFIX
-#undef DATA_SIZE
-#undef ADDR_READ
-#undef WORD_TYPE
-#undef SDATA_TYPE
-#undef USUFFIX
-#undef SSUFFIX
-#undef BSWAP
-#undef helper_le_ld_name
-#undef helper_be_ld_name
-#undef helper_le_lds_name
-#undef helper_be_lds_name
-#undef helper_le_st_name
-#undef helper_be_st_name
-- 
2.17.0
