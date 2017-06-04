Received: from eggs.gnu.org ([2001:4830:134:3::10]:50520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRj-0007sm-8S
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRi-0003eE-7a
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:11 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRi-0003do-2H
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:10 -0400
Received: by mail-pf0-x243.google.com with SMTP id w69so18143717pfk.1
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:36:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:41 -0700
Message-Id: <20170604173509.29684-42-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 41/69] target/s390x: remove some Linux
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
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

From: Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-3-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h        |  2 ++
 target/s390x/mem_helper.c | 17 ++++++++++-------
 target/s390x/mmu_helper.c |  2 --
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index fdb2f50..a4d31df 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1035,6 +1035,8 @@ struct sysib_322 {
 #define _SEGMENT_ENTRY_RO       0x200     /* page protection bit              */
 #define _SEGMENT_ENTRY_INV      0x20      /* invalid segment table entry      */
 
+#define VADDR_PX                0xff000   /* page index bits                  */
+
 #define _PAGE_RO        0x200            /* HW read-only bit  */
 #define _PAGE_INVALID   0x400            /* HW invalid bit    */
 #define _PAGE_RES0      0x800            /* bit must be zero  */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e35571e..0ebd65d 100644
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
index 31eb9ef..501e390 100644
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
-- 
2.9.4
