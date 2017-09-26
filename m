Received: from eggs.gnu.org ([2001:4830:134:3::10]:45207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufs-0004Wm-BN
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufr-0003Vj-Je
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwufr-0003VH-E1
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:39 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Sep 2017 20:33:18 +0200
Message-Id: <20170926183318.12995-7-david@redhat.com>
In-Reply-To: <20170926183318.12995-1-david@redhat.com>
References: <20170926183318.12995-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/6] s390x/tcg: make idte/ipte use the new
 _real mmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

We don't wrap addresses in the mmu for the _real case, therefore the
behavior should be unchanged.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4cf4f29171..010f509ac5 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1889,11 +1889,11 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
         for (i = 0; i < entries; i++) {
             /* addresses are not wrapped in 24/31bit mode but table index is */
             raddr = table + ((index + i) & 0x7ff) * sizeof(entry);
-            entry = ldq_phys(cs->as, raddr);
+            entry = cpu_ldq_real_ra(env, raddr, ra);
             if (!(entry & _REGION_ENTRY_INV)) {
                 /* we are allowed to not store if already invalid */
                 entry |= _REGION_ENTRY_INV;
-                stq_phys(cs->as, raddr, entry);
+                cpu_stq_real_ra(env, raddr, entry, ra);
             }
         }
     }
@@ -1911,6 +1911,7 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
                   uint32_t m4)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
+    const uintptr_t ra = GETPC();
     uint64_t page = vaddr & TARGET_PAGE_MASK;
     uint64_t pte_addr, pte;
 
@@ -1919,9 +1920,9 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
     pte_addr += (vaddr & VADDR_PX) >> 9;
 
     /* Mark the page table entry as invalid */
-    pte = ldq_phys(cs->as, pte_addr);
+    pte = cpu_ldq_real_ra(env, pte_addr, ra);
     pte |= _PAGE_INVALID;
-    stq_phys(cs->as, pte_addr, pte);
+    cpu_stq_real_ra(env, pte_addr, pte, ra);
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
-- 
2.13.5
