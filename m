Received: from eggs.gnu.org ([2001:4830:134:3::10]:38890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHd-0006UA-TD
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-000762-Ib
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:53 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHa-00072K-4e
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:13 +0200
Message-Id: <20170529192440.5990-3-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 02/29] target/s390x: remove some Linux
 assumptions from IPTE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/cpu.h        |  2 ++
 target/s390x/mem_helper.c | 17 ++++++++++-------
 target/s390x/mmu_helper.c |  4 +---
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 79235cfa45..d89ad83e71 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1033,6 +1033,8 @@ struct sysib_322 {
 #define _SEGMENT_ENTRY_RO       0x200     /* page protection bit              */
 #define _SEGMENT_ENTRY_INV      0x20      /* invalid segment table entry      */
 
+#define _VADDR_PX               0xff000   /* page index bits                  */
+
 #define _PAGE_RO        0x200            /* HW read-only bit  */
 #define _PAGE_INVALID   0x400            /* HW invalid bit    */
 #define _PAGE_RES0      0x800            /* bit must be zero  */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e35571e342..0ebd65d9ab 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1073,19 +1073,22 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 }
 
 /* invalidate pte */
-void HELPER(ipte)(CPUS390XState *env, uint64_t pte_addr, uint64_t vaddr)
+void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
     uint64_t page = vaddr & TARGET_PAGE_MASK;
-    uint64_t pte = 0;
+    uint64_t pte_addr, pte;
 
     /* XXX broadcast to other CPUs */
 
-    /* XXX Linux is nice enough to give us the exact pte address.
-       According to spec we'd have to find it out ourselves */
-    /* XXX Linux is fine with overwriting the pte, the spec requires
-       us to only set the invalid bit */
-    stq_phys(cs->as, pte_addr, pte | _PAGE_INVALID);
+    /* Compute the page table entry address */
+    pte_addr = (pto & _SEGMENT_ENTRY_ORIGIN);
+    pte_addr += (vaddr & _VADDR_PX) >> 9;
+
+    /* Mark the page table entry as invalid */
+    pte = ldq_phys(cs->as, pte_addr);
+    pte |= _PAGE_INVALID;
+    stq_phys(cs->as, pte_addr, pte);
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 31eb9efa9b..fb712c8d66 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -143,8 +143,6 @@ static int mmu_translate_pte(CPUS390XState *env, target_ulong vaddr,
     return 0;
 }
 
-#define VADDR_PX    0xff000         /* Page index bits */
-
 /* Decode segment table entry */
 static int mmu_translate_segment(CPUS390XState *env, target_ulong vaddr,
                                  uint64_t asc, uint64_t st_entry,
@@ -167,7 +165,7 @@ static int mmu_translate_segment(CPUS390XState *env, target_ulong vaddr,
 
     /* Look up 4KB page entry */
     origin = st_entry & _SEGMENT_ENTRY_ORIGIN;
-    offs  = (vaddr & VADDR_PX) >> 9;
+    offs  = (vaddr & _VADDR_PX) >> 9;
     pt_entry = ldq_phys(cs->as, origin + offs);
     PTE_DPRINTF("%s: 0x%" PRIx64 " + 0x%" PRIx64 " => 0x%016" PRIx64 "\n",
                 __func__, origin, offs, pt_entry);
-- 
2.11.0
