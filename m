Received: from eggs.gnu.org ([2001:4830:134:3::10]:57769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXZ-0008Vp-4a
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXV-0001rR-75
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:20 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXU-0001cF-Jb
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:16 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue,  4 Sep 2018 16:14:35 -0700
Message-Id: <20180904231442.18932-3-alistair.francis@wdc.com>
In-Reply-To: <20180904231442.18932-1-alistair.francis@wdc.com>
References: <20180904231442.18932-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 2/9] RISC-V: Improve page table walker spec
 compliance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>

From: Michael Clark <mjc@sifive.com>

- Inline PTE_TABLE check for better readability
- Change access checks from ternary operator to if
- Improve readibility of User page U mode and SUM test
- Disallow non U mode from fetching from User pages
- Add reserved PTE flag check: W or W|X
- Add misaligned PPN check
- Set READ protection for PTE X flag and mstatus.mxr
- Use memory_region_is_ram in pte update

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  2 --
 target/riscv/helper.c   | 64 +++++++++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 64aa097181..12b4757088 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -407,5 +407,3 @@
 #define PTE_SOFT  0x300 /* Reserved for Software */
 
 #define PTE_PPN_SHIFT 10
-
-#define PTE_TABLE(PTE) (((PTE) & (PTE_V | PTE_R | PTE_W | PTE_X)) == PTE_V)
diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index 29e1a603dc..1f0527e07f 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -185,16 +185,39 @@ restart:
 #endif
         target_ulong ppn = pte >> PTE_PPN_SHIFT;
 
-        if (PTE_TABLE(pte)) { /* next level of page table */
+        if (!(pte & PTE_V)) {
+            /* Invalid PTE */
+            return TRANSLATE_FAIL;
+        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
+            /* Inner PTE, continue walking */
             base = ppn << PGSHIFT;
-        } else if ((pte & PTE_U) ? (mode == PRV_S) && !sum : !(mode == PRV_S)) {
-            break;
-        } else if (!(pte & PTE_V) || (!(pte & PTE_R) && (pte & PTE_W))) {
-            break;
-        } else if (access_type == MMU_INST_FETCH ? !(pte & PTE_X) :
-                  access_type == MMU_DATA_LOAD ?  !(pte & PTE_R) &&
-                  !(mxr && (pte & PTE_X)) : !((pte & PTE_R) && (pte & PTE_W))) {
-            break;
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
+            /* Reserved leaf PTE flags: PTE_W */
+            return TRANSLATE_FAIL;
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
+            /* Reserved leaf PTE flags: PTE_W + PTE_X */
+            return TRANSLATE_FAIL;
+        } else if ((pte & PTE_U) && ((mode != PRV_U) &&
+                   (!sum || access_type == MMU_INST_FETCH))) {
+            /* User PTE flags when not U mode and mstatus.SUM is not set,
+               or the access type is an instruction fetch */
+            return TRANSLATE_FAIL;
+        } else if (!(pte & PTE_U) && (mode != PRV_S)) {
+            /* Supervisor PTE flags when not S mode */
+            return TRANSLATE_FAIL;
+        } else if (ppn & ((1ULL << ptshift) - 1)) {
+            /* Misaligned PPN */
+            return TRANSLATE_FAIL;
+        } else if (access_type == MMU_DATA_LOAD && !((pte & PTE_R) ||
+                   ((pte & PTE_X) && mxr))) {
+            /* Read access check failed */
+            return TRANSLATE_FAIL;
+        } else if (access_type == MMU_DATA_STORE && !(pte & PTE_W)) {
+            /* Write access check failed */
+            return TRANSLATE_FAIL;
+        } else if (access_type == MMU_INST_FETCH && !(pte & PTE_X)) {
+            /* Fetch access check failed */
+            return TRANSLATE_FAIL;
         } else {
             /* if necessary, set accessed and dirty bits. */
             target_ulong updated_pte = pte | PTE_A |
@@ -202,16 +225,19 @@ restart:
 
             /* Page table updates need to be atomic with MTTCG enabled */
             if (updated_pte != pte) {
-                /* if accessed or dirty bits need updating, and the PTE is
-                 * in RAM, then we do so atomically with a compare and swap.
-                 * if the PTE is in IO space, then it can't be updated.
-                 * if the PTE changed, then we must re-walk the page table
-                   as the PTE is no longer valid */
+                /*
+                 * - if accessed or dirty bits need updating, and the PTE is
+                 *   in RAM, then we do so atomically with a compare and swap.
+                 * - if the PTE is in IO space or ROM, then it can't be updated
+                 *   and we return TRANSLATE_FAIL.
+                 * - if the PTE changed by the time we went to update it, then
+                 *   it is no longer valid and we must re-walk the page table.
+                 */
                 MemoryRegion *mr;
                 hwaddr l = sizeof(target_ulong), addr1;
                 mr = address_space_translate(cs->as, pte_addr,
                     &addr1, &l, false, MEMTXATTRS_UNSPECIFIED);
-                if (memory_access_is_direct(mr, true)) {
+                if (memory_region_is_ram(mr)) {
                     target_ulong *pte_pa =
                         qemu_map_ram_ptr(mr->ram_block, addr1);
 #if TCG_OVERSIZED_GUEST
@@ -239,15 +265,15 @@ restart:
             target_ulong vpn = addr >> PGSHIFT;
             *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
 
-            if ((pte & PTE_R)) {
+            /* set permissions on the TLB entry */
+            if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
                 *prot |= PAGE_READ;
             }
             if ((pte & PTE_X)) {
                 *prot |= PAGE_EXEC;
             }
-           /* only add write permission on stores or if the page
-              is already dirty, so that we don't miss further
-              page table walks to update the dirty bit */
+            /* add write permission on stores or if the page is already dirty,
+               so that we TLB miss on later writes to update the dirty bit */
             if ((pte & PTE_W) &&
                     (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
                 *prot |= PAGE_WRITE;
-- 
2.17.1
