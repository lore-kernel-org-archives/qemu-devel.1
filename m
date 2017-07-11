Received: from eggs.gnu.org ([2001:4830:134:3::10]:40568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxM-0002IP-1Q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxK-0007TE-TP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:12 +1000
Message-Id: <20170711043917.1757-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/17] target/ppc: Add debug function for radix
 mmu translation
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

In target/ppc/mmu-hash64.c there already exists the function
ppc_hash64_get_phys_page_debug() to get the physical (real) address for
a given effective address in hash mode.

Implement the function ppc_radix64_get_phys_page_debug() to allow a real
address to be obtained for a given effective address in radix mode.
This is used when a debugger is attached to qemu.

Previously we just had a comment saying this is unimplemented which then
fell through to the default case and caused an abort due to
unrecognised mmu model as the default had no case for the V3 mmu, which
was misleading at best.

We reuse ppc_radix64_walk_tree() which is used by the radix fault
handler since the process of walking the radix tree is identical.

Reported-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-radix64.h |  1 +
 target/ppc/mmu_helper.c  |  3 ++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 1a650fd..bbd37e3 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -251,3 +251,48 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                  prot, mmu_idx, 1UL << page_size);
     return 0;
 }
+
+hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong eaddr)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    PPCVirtualHypervisorClass *vhc =
+        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+    hwaddr raddr, pte_addr;
+    uint64_t lpid = 0, pid = 0, offset, size, patbe, prtbe0, pte;
+    int page_size, fault_cause = 0;
+
+    /* Handle Real Mode */
+    if (msr_dr == 0) {
+        /* In real mode top 4 effective addr bits (mostly) ignored */
+        return eaddr & 0x0FFFFFFFFFFFFFFFULL;
+    }
+
+    /* Virtual Mode Access - get the fully qualified address */
+    if (!ppc_radix64_get_fully_qualified_addr(env, eaddr, &lpid, &pid)) {
+        return -1;
+    }
+
+    /* Get Process Table */
+    patbe = vhc->get_patbe(cpu->vhyp);
+
+    /* Index Process Table by PID to Find Corresponding Process Table Entry */
+    offset = pid * sizeof(struct prtb_entry);
+    size = 1ULL << ((patbe & PATBE1_R_PRTS) + 12);
+    if (offset >= size) {
+        /* offset exceeds size of the process table */
+        return -1;
+    }
+    prtbe0 = ldq_phys(cs->as, (patbe & PATBE1_R_PRTB) + offset);
+
+    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
+    page_size = PRTBE_R_GET_RTS(prtbe0);
+    pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
+                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
+                                &raddr, &page_size, &fault_cause, &pte_addr);
+    if (!pte) {
+        return -1;
+    }
+
+    return raddr & TARGET_PAGE_MASK;
+}
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index 1d5c7cf..0ecf063 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -46,6 +46,7 @@
 
 int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                                  int mmu_idx);
+hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr);
 
 static inline int ppc_radix64_get_prot_eaa(uint64_t pte)
 {
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 65d1c86..b7b9088 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -30,6 +30,7 @@
 #include "helper_regs.h"
 #include "qemu/error-report.h"
 #include "mmu-book3s-v3.h"
+#include "mmu-radix64.h"
 
 //#define DEBUG_MMU
 //#define DEBUG_BATS
@@ -1432,7 +1433,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         return ppc_hash64_get_phys_page_debug(cpu, addr);
     case POWERPC_MMU_VER_3_00:
         if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
-            /* TODO - Unsupported */
+            return ppc_radix64_get_phys_page_debug(cpu, addr);
         } else {
             return ppc_hash64_get_phys_page_debug(cpu, addr);
         }
-- 
2.9.4
