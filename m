Received: from eggs.gnu.org ([2001:4830:134:3::10]:58914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRJ-0006B8-L5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRG-0007tp-J5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PRG-0007sU-DW
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:39 +0200
Message-Id: <20171006095956.27534-17-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 16/33] s390x/tcg: make idte/ipte use the new
 _real mmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

We don't wrap addresses in the mmu for the _real case, therefore the
behavior should be unchanged.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170926183318.12995-7-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mem_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 3650c1b678..bbbe1c62b3 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1875,11 +1875,11 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
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
@@ -1897,6 +1897,7 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
                   uint32_t m4)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
+    const uintptr_t ra = GETPC();
     uint64_t page = vaddr & TARGET_PAGE_MASK;
     uint64_t pte_addr, pte;
 
@@ -1905,9 +1906,9 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
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
2.13.6
