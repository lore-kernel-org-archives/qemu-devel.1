Received: from eggs.gnu.org ([2001:4830:134:3::10]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxN-0002J4-4K
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxL-0007Tm-Sq
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:11 +1000
Message-Id: <20170711043917.1757-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/17] target/ppc: Refactor tcg radix mmu code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The mmu-radix64.c file implements functions to enable the radix mmu
emulation in tcg mode. There is a function ppc_radix64_walk_tree() which
performs the radix tree walk and also implicitly checks the pte
protection.

Move the protection checking of the pte from the ppc_radix64_walk_tree()
function into the caller. This means the ppc_radix64_walk_tree() function
can be used without protection checking which is useful for debugging.

ppc_radix64_walk_tree() no longer needs to take the rwx and prot variables.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 69fde65..1a650fd 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -147,11 +147,10 @@ static void ppc_radix64_set_rc(PowerPCCPU *cpu, int rwx, uint64_t pte,
     }
 }
 
-static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, int rwx, vaddr eaddr,
+static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
                                       uint64_t base_addr, uint64_t nls,
                                       hwaddr *raddr, int *psize,
-                                      int *fault_cause, int *prot,
-                                      hwaddr *pte_addr)
+                                      int *fault_cause, hwaddr *pte_addr)
 {
     CPUState *cs = CPU(cpu);
     uint64_t index, pde;
@@ -177,10 +176,6 @@ static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, int rwx, vaddr eaddr,
         uint64_t rpn = pde & R_PTE_RPN;
         uint64_t mask = (1UL << *psize) - 1;
 
-        if (ppc_radix64_check_prot(cpu, rwx, pde, fault_cause, prot)) {
-            return 0; /* Protection Denied Access */
-        }
-
         /* Or high bits of rpn and low bits to ea to form whole real addr */
         *raddr = (rpn & ~mask) | (eaddr & mask);
         *pte_addr = base_addr + (index * sizeof(pde));
@@ -188,9 +183,8 @@ static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, int rwx, vaddr eaddr,
     }
 
     /* Next Level of Radix Tree */
-    return ppc_radix64_walk_tree(cpu, rwx, eaddr, pde & R_PDE_NLB,
-                                 pde & R_PDE_NLS, raddr, psize,
-                                 fault_cause, prot, pte_addr);
+    return ppc_radix64_walk_tree(cpu, eaddr, pde & R_PDE_NLB, pde & R_PDE_NLS,
+                                 raddr, psize, fault_cause, pte_addr);
 }
 
 int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
@@ -241,11 +235,11 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
 
     /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
     page_size = PRTBE_R_GET_RTS(prtbe0);
-    pte = ppc_radix64_walk_tree(cpu, rwx, eaddr & R_EADDR_MASK,
+    pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
                                 prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
-                                &raddr, &page_size, &fault_cause, &prot,
-                                &pte_addr);
-    if (!pte) {
+                                &raddr, &page_size, &fault_cause, &pte_addr);
+    if (!pte || ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, &prot)) {
+        /* Couldn't get pte or access denied due to protection */
         ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
         return 1;
     }
-- 
2.9.4
