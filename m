Received: from eggs.gnu.org ([2001:4830:134:3::10]:59736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dRuiO-0008CQ-QI
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dRuiN-0001ON-S5
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:20:08 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon,  3 Jul 2017 16:19:47 +1000
Message-Id: <20170703061948.18220-3-sjitindarsingh@gmail.com>
In-Reply-To: <20170703061948.18220-1-sjitindarsingh@gmail.com>
References: <20170703061948.18220-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [Qemu-PPC] [PATCH 2/3] target/ppc: Add debug function
 for radix mmu translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, bsingharora@gmail.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

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
