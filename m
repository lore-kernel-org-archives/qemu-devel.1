Received: from eggs.gnu.org ([2001:4830:134:3::10]:42451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cg0Yz-0004kL-Nz
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cg0Yv-0005dQ-QG
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:52:25 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Feb 2017 13:52:11 +1100
Message-Id: <20170221025211.30007-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH] target/ppc: Fix serious bug in HPTE writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-stable@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

ppc_hash64_store_hpte() is used to update HPTEs in the hashed page table
(HPT) for 64-bit machines.  This is used when the (emulated) CPU needs to
update the referenced (R) or changed (C) bits in the HPTE.

Some time ago this was converted to take an HPTE index, instead of a
raw offset to the HPTE within the HPT (similar functions for 32-bit still
take an offset).  In the process a serious bug was introduced: we're
still using the index parameter as though it was an offset, failing to
multiply by the size of an HPTE, so it will update bits in the wrong part
of the HPT.  This can corrupt the guests's HPT, causing crashes or data
loss.

AFAICT the reason we haven't noticed this error earlier is that for 64-bit
machines we've been testing almost exclusively with Linux guests.  Linux
on ppc does not make use of the hardware R & C bits, so this writeback
will never be triggered.  It also occurs only on TCG, not KVM, guests.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index bb78fb5..dc3b5f7 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -894,12 +894,15 @@ void ppc_hash64_store_hpte(PowerPCCPU *cpu,
 
     pte_index *= HASH_PTE_SIZE_64;
     if (env->external_htab) {
-        stq_p(env->external_htab + pte_index, pte0);
-        stq_p(env->external_htab + pte_index + HASH_PTE_SIZE_64 / 2, pte1);
+        stq_p(env->external_htab + pte_index * HASH_PTE_SIZE_64, pte0);
+        stq_p(env->external_htab + pte_index * HASH_PTE_SIZE_64
+              + HASH_PTE_SIZE_64 / 2, pte1);
     } else {
-        stq_phys(CPU(cpu)->as, env->htab_base + pte_index, pte0);
         stq_phys(CPU(cpu)->as,
-                 env->htab_base + pte_index + HASH_PTE_SIZE_64 / 2, pte1);
+                 env->htab_base + pte_index * HASH_PTE_SIZE_64, pte0);
+        stq_phys(CPU(cpu)->as,
+                 env->htab_base + pte_index * HASH_PTE_SIZE_64
+                 + HASH_PTE_SIZE_64 / 2, pte1);
     }
 }
 
-- 
2.9.3
