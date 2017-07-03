Received: from eggs.gnu.org ([2001:4830:134:3::10]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dRuiV-0008Go-Hp
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dRuiQ-0001T2-KU
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:20:15 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon,  3 Jul 2017 16:19:48 +1000
Message-Id: <20170703061948.18220-4-sjitindarsingh@gmail.com>
In-Reply-To: <20170703061948.18220-1-sjitindarsingh@gmail.com>
References: <20170703061948.18220-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [Qemu-PPC] [PATCH 3/3] target/ppc: Add debug function
 to dump radix mmu translations
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
dump_slb() to dump the hash translation entries (for effective to
virtual translation at least).

Implement the function ppc_radix64_dump() to allow all the kernel
effective to real address mappings and corresponding ptes to be dumped.
This is called when "info tlb" is invoked in the qemu console. Previously
this command had no output when invoked with a radix guest.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/mmu-radix64.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-radix64.h |  1 +
 target/ppc/mmu_helper.c  |  2 +-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index bbd37e3..f7eeead 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -296,3 +296,52 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong eaddr)
 
     return raddr & TARGET_PAGE_MASK;
 }
+
+static void ppc_radix64_dump_level(FILE *f, fprintf_function cpu_fprintf,
+                                   PowerPCCPU *cpu, uint64_t eaddr,
+                                   uint64_t base_addr, uint64_t nls,
+                                   uint64_t psize, int *num)
+{
+    CPUState *cs = CPU(cpu);
+    uint64_t i, pte;
+
+    for (i = 0; i < (1 << nls); i++) {
+        eaddr &= ~((1ULL << psize) - 1); /* Clear the low bits */
+        eaddr |= (i << (psize - nls));
+
+        pte = ldq_phys(cs->as, base_addr + (i * sizeof(pte)));
+        if (!(pte & R_PTE_VALID)) { /* Invalid Entry */
+            continue;
+        }
+
+        if (pte & R_PTE_LEAF) {
+            uint64_t mask = (1ULL << (psize - nls)) - 1;
+            cpu_fprintf(f, "%d\t0x%.16" PRIx64 " -> 0x%.16" PRIx64
+                           " pte: 0x%.16" PRIx64 "\n", (*num)++,
+                           eaddr, pte & R_PTE_RPN & ~mask, pte);
+        } else {
+            ppc_radix64_dump_level(f, cpu_fprintf, cpu, eaddr, pte & R_PDE_NLB,
+                                   pte & R_PDE_NLS, psize - nls, num);
+        }
+    }
+}
+
+void ppc_radix64_dump(FILE *f, fprintf_function cpu_fprintf, PowerPCCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    PPCVirtualHypervisorClass *vhc =
+        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+    uint64_t patbe, prtbe0;
+    int num = 0;
+
+    /* Get Process Table */
+    patbe = vhc->get_patbe(cpu->vhyp);
+
+    /* Load the first entry -> Guest kernel mappings (all we dump for now) */
+    prtbe0 = ldq_phys(cs->as, patbe & PATBE1_R_PRTB);
+
+    cpu_fprintf(f, "\tEADDR\t\t      RADDR\n");
+    ppc_radix64_dump_level(f, cpu_fprintf, cpu, 0ULL, prtbe0 & PRTBE_R_RPDB,
+                           prtbe0 & PRTBE_R_RPDS, PRTBE_R_GET_RTS(prtbe0),
+                           &num);
+}
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index 0ecf063..c6c22bd 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -47,6 +47,7 @@
 int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                                  int mmu_idx);
 hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr);
+void ppc_radix64_dump(FILE *f, fprintf_function cpu_fprintf, PowerPCCPU *cpu);
 
 static inline int ppc_radix64_get_prot_eaa(uint64_t pte)
 {
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index b7b9088..9587b07 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1287,7 +1287,7 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
         break;
     case POWERPC_MMU_VER_3_00:
         if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
-            /* TODO - Unsupported */
+            ppc_radix64_dump(f, cpu_fprintf, ppc_env_get_cpu(env));
         } else {
             dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
             break;
-- 
2.9.4
