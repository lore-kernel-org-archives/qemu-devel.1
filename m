Received: from eggs.gnu.org ([209.51.188.92]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2C-000491-WE
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzo-0000n0-7b
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzn-0000ln-W6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id t76so723335wmt.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 30 Apr 2019 17:52:27 +0100
Message-Id: <20190430165234.32272-9-alex.bennee@linaro.org>
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 08/15] cputlb: Move TLB_RECHECK handling
 into load/store_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Having this in io_readx/io_writex meant that we forgot to
re-compute index after tlb_fill.  It also means we can use
the normal aligned memory load path.  It also fixes a bug
in that we had cached a use of index across a tlb_fill.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 126 ++++++++++++++++++++-------------------------
 1 file changed, 55 insertions(+), 71 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 12f21865ee..9c04eb1687 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -856,9 +856,8 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
 }
 
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
-                         int mmu_idx,
-                         target_ulong addr, uintptr_t retaddr,
-                         bool recheck, MMUAccessType access_type, int size)
+                         int mmu_idx, target_ulong addr, uintptr_t retaddr,
+                         MMUAccessType access_type, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr mr_offset;
@@ -868,30 +867,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
-    if (recheck) {
-        /*
-         * This is a TLB_RECHECK access, where the MMU protection
-         * covers a smaller range than a target page, and we must
-         * repeat the MMU check here. This tlb_fill() call might
-         * longjump out if this access should cause a guest exception.
-         */
-        CPUTLBEntry *entry;
-        target_ulong tlb_addr;
-
-        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
-
-        entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = (access_type == MMU_DATA_LOAD ?
-                    entry->addr_read : entry->addr_code);
-        if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
-            /* RAM access */
-            uintptr_t haddr = addr + entry->addend;
-
-            return ldn_p((void *)haddr, size);
-        }
-        /* Fall through for handling IO accesses */
-    }
-
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -925,9 +900,8 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 }
 
 static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
-                      int mmu_idx,
-                      uint64_t val, target_ulong addr,
-                      uintptr_t retaddr, bool recheck, int size)
+                      int mmu_idx, uint64_t val, target_ulong addr,
+                      uintptr_t retaddr, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr mr_offset;
@@ -936,30 +910,6 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
-    if (recheck) {
-        /*
-         * This is a TLB_RECHECK access, where the MMU protection
-         * covers a smaller range than a target page, and we must
-         * repeat the MMU check here. This tlb_fill() call might
-         * longjump out if this access should cause a guest exception.
-         */
-        CPUTLBEntry *entry;
-        target_ulong tlb_addr;
-
-        tlb_fill(cpu, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
-
-        entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = tlb_addr_write(entry);
-        if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
-            /* RAM access */
-            uintptr_t haddr = addr + entry->addend;
-
-            stn_p((void *)haddr, size, val);
-            return;
-        }
-        /* Fall through for handling IO accesses */
-    }
-
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -1218,14 +1168,15 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
     target_ulong tlb_addr = code_read ? entry->addr_code : entry->addr_read;
     const size_t tlb_off = code_read ?
         offsetof(CPUTLBEntry, addr_code) : offsetof(CPUTLBEntry, addr_read);
+    const MMUAccessType access_type =
+        code_read ? MMU_INST_FETCH : MMU_DATA_LOAD;
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     void *haddr;
     uint64_t res;
 
     /* Handle CPU specific unaligned behaviour */
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr,
-                             code_read ? MMU_INST_FETCH : MMU_DATA_LOAD,
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, access_type,
                              mmu_idx, retaddr);
     }
 
@@ -1234,8 +1185,7 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
         if (!victim_tlb_hit(env, mmu_idx, index, tlb_off,
                             addr & TARGET_PAGE_MASK)) {
             tlb_fill(ENV_GET_CPU(env), addr, size,
-                     code_read ? MMU_INST_FETCH : MMU_DATA_LOAD,
-                     mmu_idx, retaddr);
+                     access_type, mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
         }
@@ -1244,17 +1194,33 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
 
     /* Handle an IO access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-        uint64_t tmp;
-
         if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
 
-        tmp = io_readx(env, iotlbentry, mmu_idx, addr, retaddr,
-                       tlb_addr & TLB_RECHECK,
-                       code_read ? MMU_INST_FETCH : MMU_DATA_LOAD, size);
-        return handle_bswap(tmp, size, big_endian);
+        if (tlb_addr & TLB_RECHECK) {
+            /*
+             * This is a TLB_RECHECK access, where the MMU protection
+             * covers a smaller range than a target page, and we must
+             * repeat the MMU check here. This tlb_fill() call might
+             * longjump out if this access should cause a guest exception.
+             */
+            tlb_fill(ENV_GET_CPU(env), addr, size,
+                     access_type, mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
+
+            tlb_addr = code_read ? entry->addr_code : entry->addr_read;
+            tlb_addr &= ~TLB_RECHECK;
+            if (!(tlb_addr & ~TARGET_PAGE_MASK)) {
+                /* RAM access */
+                goto do_aligned_access;
+            }
+        }
+
+        res = io_readx(env, &env->iotlb[mmu_idx][index], mmu_idx, addr,
+                       retaddr, access_type, size);
+        return handle_bswap(res, size, big_endian);
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1281,8 +1247,8 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
         return res & MAKE_64BIT_MASK(0, size * 8);
     }
 
+ do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-
     switch (size) {
     case 1:
         res = ldub_p(haddr);
@@ -1446,15 +1412,33 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
     /* Handle an IO access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-
         if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
 
-        io_writex(env, iotlbentry, mmu_idx,
+        if (tlb_addr & TLB_RECHECK) {
+            /*
+             * This is a TLB_RECHECK access, where the MMU protection
+             * covers a smaller range than a target page, and we must
+             * repeat the MMU check here. This tlb_fill() call might
+             * longjump out if this access should cause a guest exception.
+             */
+            tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
+
+            tlb_addr = tlb_addr_write(entry);
+            tlb_addr &= ~TLB_RECHECK;
+            if (!(tlb_addr & ~TARGET_PAGE_MASK)) {
+                /* RAM access */
+                goto do_aligned_access;
+            }
+        }
+
+        io_writex(env, &env->iotlb[mmu_idx][index], mmu_idx,
                   handle_bswap(val, size, big_endian),
-                  addr, retaddr, tlb_addr & TLB_RECHECK, size);
+                  addr, retaddr, size);
         return;
     }
 
@@ -1502,8 +1486,8 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         return;
     }
 
+ do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-
     switch (size) {
     case 1:
         stb_p(haddr, val);
-- 
2.20.1
