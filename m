Received: from eggs.gnu.org ([2001:4830:134:3::10]:56342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fV1-0005RX-K7
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUx-0001WO-FA
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:20 +1000
Message-Id: <20170511041426.6488-18-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/23] target/ppc: Implement ISA V3.00 radix
 page fault handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

ISA V3.00 introduced a new radix mmu model. Implement the page fault
handler for this so we can run a tcg guest in radix mode and perform
address translation correctly.

In real mode (mmu turned off) addresses are masked to remove the top
4 bits and then are subject to partition scoped translation, since we only
support pseries at this stage it is only necessary to perform the masking
and then we're done.

In virtual mode (mmu turned on) address translation if performed as
follows:

1. Use the quadrant to determine the fully qualified address.

The fully qualified address is defined as the combination of the effective
address, the effective logical partition id (LPID) and the effective
process id (PID). Based on the quadrant (EA63:62) we set the pid and lpid
like so:

quadrant 0: lpid = LPIDR, pid = PIDR
quadrant 1: HV only (not allowed in pseries)
quadrant 2: HV only (not allowed in pseries)
quadrant 3: lpid = LPIDR, pid = 0

If we can't get the fully qualified address we raise a segment interrupt.

2. Find the guest radix tree

We ask the virtual hypervisor for the partition table which was registered
with H_REGISTER_PROC_TBL which points us to the process table in guest
memory. We then index this table by pid to get the process table entry
which points us to the appropriate radix tree to translate the address.

If the process table isn't big enough to contain an entry for the current
pid then we raise a storage interrupt.

3. Walk the radix tree

Next we walk the radix tree where each level is a table of page directory
entries indexed by some number of bits from the effective address, where
the number of bits is determined by the table size. We continue to walk
the tree (while entries are valid and the table is of minimum size) until
we reach a table of page table entries, indicated by having the leaf bit
set. The appropriate pte is then checked for sufficient access permissions,
the reference and change bits are updated and the real address is
calculated from the real page number bits of the pte and the low bits of
the effective address.

If we can't find an entry or can't access the entry bacause of permissions
then we raise a storage interrupt.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Add missing parentheses to macro]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/Makefile.objs   |   1 +
 target/ppc/cpu.h           |   2 +
 target/ppc/mmu-book3s-v3.c |   6 +-
 target/ppc/mmu-book3s-v3.h |   5 +
 target/ppc/mmu-radix64.c   | 259 +++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-radix64.h   |  72 +++++++++++++
 6 files changed, 341 insertions(+), 4 deletions(-)
 create mode 100644 target/ppc/mmu-radix64.c
 create mode 100644 target/ppc/mmu-radix64.h

diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
index f963777..f92ba67 100644
--- a/target/ppc/Makefile.objs
+++ b/target/ppc/Makefile.objs
@@ -4,6 +4,7 @@ obj-y += translate.o
 ifeq ($(CONFIG_SOFTMMU),y)
 obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o arch_dump.o
 obj-$(TARGET_PPC64) += mmu-hash64.o mmu-book3s-v3.o compat.o
+obj-$(TARGET_PPC64) += mmu-radix64.o
 endif
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ece535d..c0f63f6 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -482,6 +482,8 @@ struct ppc_slb_t {
 #define DSISR_ISSTORE            0x02000000
 /* Not permitted by virtual page class key protection */
 #define DSISR_AMR                0x00200000
+/* Unsupported Radix Tree Configuration */
+#define DSISR_R_BADCONFIG        0x00080000
 
 /* SRR1 error code fields */
 
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index 005c963..e7798b3 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -22,15 +22,13 @@
 #include "cpu.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
-#include "qemu/error-report.h"
+#include "mmu-radix64.h"
 
 int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                               int mmu_idx)
 {
     if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
-        /* TODO - Unsupported */
-        error_report("Guest Radix Support Unimplemented");
-        exit(1);
+        return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
     } else { /* Guest uses hash */
         return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
     }
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 636f6ab..56095da 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -25,6 +25,11 @@
 /* Partition Table Entry Fields */
 #define PATBE1_GR 0x8000000000000000
 
+/* Process Table Entry */
+struct prtb_entry {
+    uint64_t prtbe0, prtbe1;
+};
+
 #ifdef TARGET_PPC64
 
 static inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
new file mode 100644
index 0000000..de18c0b
--- /dev/null
+++ b/target/ppc/mmu-radix64.c
@@ -0,0 +1,259 @@
+/*
+ *  PowerPC Radix MMU mulation helpers for QEMU.
+ *
+ *  Copyright (c) 2016 Suraj Jitindar Singh, IBM Corporation
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+#include "kvm_ppc.h"
+#include "exec/log.h"
+#include "mmu-radix64.h"
+#include "mmu-book3s-v3.h"
+
+static bool ppc_radix64_get_fully_qualified_addr(CPUPPCState *env, vaddr eaddr,
+                                                 uint64_t *lpid, uint64_t *pid)
+{
+    /* We don't have HV support yet and shouldn't get here with it set anyway */
+    assert(!msr_hv);
+
+    if (!msr_hv) { /* !MSR[HV] -> Guest */
+        switch (eaddr & R_EADDR_QUADRANT) {
+        case R_EADDR_QUADRANT0: /* Guest application */
+            *lpid = env->spr[SPR_LPIDR];
+            *pid = env->spr[SPR_BOOKS_PID];
+            break;
+        case R_EADDR_QUADRANT1: /* Illegal */
+        case R_EADDR_QUADRANT2:
+            return false;
+        case R_EADDR_QUADRANT3: /* Guest OS */
+            *lpid = env->spr[SPR_LPIDR];
+            *pid = 0; /* pid set to 0 -> addresses guest operating system */
+            break;
+        }
+    }
+
+    return true;
+}
+
+static void ppc_radix64_raise_segi(PowerPCCPU *cpu, int rwx, vaddr eaddr)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+
+    if (rwx == 2) { /* Instruction Segment Interrupt */
+        cs->exception_index = POWERPC_EXCP_ISEG;
+    } else { /* Data Segment Interrupt */
+        cs->exception_index = POWERPC_EXCP_DSEG;
+        env->spr[SPR_DAR] = eaddr;
+    }
+    env->error_code = 0;
+}
+
+static void ppc_radix64_raise_si(PowerPCCPU *cpu, int rwx, vaddr eaddr,
+                                uint32_t cause)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+
+    if (rwx == 2) { /* Instruction Storage Interrupt */
+        cs->exception_index = POWERPC_EXCP_ISI;
+        env->error_code = cause;
+    } else { /* Data Storage Interrupt */
+        cs->exception_index = POWERPC_EXCP_DSI;
+        if (rwx == 1) { /* Write -> Store */
+            cause |= DSISR_ISSTORE;
+        }
+        env->spr[SPR_DSISR] = cause;
+        env->spr[SPR_DAR] = eaddr;
+        env->error_code = 0;
+    }
+}
+
+
+static bool ppc_radix64_check_prot(PowerPCCPU *cpu, int rwx, uint64_t pte,
+                                   int *fault_cause, int *prot)
+{
+    CPUPPCState *env = &cpu->env;
+    const int need_prot[] = { PAGE_READ, PAGE_WRITE, PAGE_EXEC };
+
+    /* Check Page Attributes (pte58:59) */
+    if (((pte & R_PTE_ATT) == R_PTE_ATT_NI_IO) && (rwx == 2)) {
+        /*
+         * Radix PTE entries with the non-idempotent I/O attribute are treated
+         * as guarded storage
+         */
+        *fault_cause |= SRR1_NOEXEC_GUARD;
+        return true;
+    }
+
+    /* Determine permissions allowed by Encoded Access Authority */
+    if ((pte & R_PTE_EAA_PRIV) && msr_pr) { /* Insufficient Privilege */
+        *prot = 0;
+    } else if (msr_pr || (pte & R_PTE_EAA_PRIV)) {
+        *prot = ppc_radix64_get_prot_eaa(pte);
+    } else { /* !msr_pr && !(pte & R_PTE_EAA_PRIV) */
+        *prot = ppc_radix64_get_prot_eaa(pte);
+        *prot &= ppc_radix64_get_prot_amr(cpu); /* Least combined permissions */
+    }
+
+    /* Check if requested access type is allowed */
+    if (need_prot[rwx] & ~(*prot)) { /* Page Protected for that Access */
+        *fault_cause |= DSISR_PROTFAULT;
+        return true;
+    }
+
+    return false;
+}
+
+static void ppc_radix64_set_rc(PowerPCCPU *cpu, int rwx, uint64_t pte,
+                               hwaddr pte_addr, int *prot)
+{
+    CPUState *cs = CPU(cpu);
+    uint64_t npte;
+
+    npte = pte | R_PTE_R; /* Always set reference bit */
+
+    if (rwx == 1) { /* Store/Write */
+        npte |= R_PTE_C; /* Set change bit */
+    } else {
+        /*
+         * Treat the page as read-only for now, so that a later write
+         * will pass through this function again to set the C bit.
+         */
+        *prot &= ~PAGE_WRITE;
+    }
+
+    if (pte ^ npte) { /* If pte has changed then write it back */
+        stq_phys(cs->as, pte_addr, npte);
+    }
+}
+
+static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, int rwx, vaddr eaddr,
+                                      uint64_t base_addr, uint64_t nls,
+                                      hwaddr *raddr, int *psize,
+                                      int *fault_cause, int *prot,
+                                      hwaddr *pte_addr)
+{
+    CPUState *cs = CPU(cpu);
+    uint64_t index, pde;
+
+    if (nls < 5) { /* Directory maps less than 2**5 entries */
+        *fault_cause |= DSISR_R_BADCONFIG;
+        return 0;
+    }
+
+    /* Read page <directory/table> entry from guest address space */
+    index = eaddr >> (*psize - nls); /* Shift */
+    index &= ((1UL << nls) - 1); /* Mask */
+    pde = ldq_phys(cs->as, base_addr + (index * sizeof(pde)));
+    if (!(pde & R_PTE_VALID)) { /* Invalid Entry */
+        *fault_cause |= DSISR_NOPTE;
+        return 0;
+    }
+
+    *psize -= nls;
+
+    /* Check if Leaf Entry -> Page Table Entry -> Stop the Search */
+    if (pde & R_PTE_LEAF) {
+        uint64_t rpn = pde & R_PTE_RPN;
+        uint64_t mask = (1UL << *psize) - 1;
+
+        if (ppc_radix64_check_prot(cpu, rwx, pde, fault_cause, prot)) {
+            return 0; /* Protection Denied Access */
+        }
+
+        /* Or high bits of rpn and low bits to ea to form whole real addr */
+        *raddr = (rpn & ~mask) | (eaddr & mask);
+        *pte_addr = base_addr + (index * sizeof(pde));
+        return pde;
+    }
+
+    /* Next Level of Radix Tree */
+    return ppc_radix64_walk_tree(cpu, rwx, eaddr, pde & R_PDE_NLB,
+                                 pde & R_PDE_NLS, raddr, psize,
+                                 fault_cause, prot, pte_addr);
+}
+
+int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
+                                 int mmu_idx)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    PPCVirtualHypervisorClass *vhc =
+        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+    hwaddr raddr, pte_addr;
+    uint64_t lpid = 0, pid = 0, offset, size, patbe, prtbe0, pte;
+    int page_size, prot, fault_cause = 0;
+
+    assert((rwx == 0) || (rwx == 1) || (rwx == 2));
+    assert(!msr_hv); /* For now there is no Radix PowerNV Support */
+    assert(cpu->vhyp);
+    assert(ppc64_use_proc_tbl(cpu));
+
+    /* Real Mode Access */
+    if (((rwx == 2) && (msr_ir == 0)) || ((rwx != 2) && (msr_dr == 0))) {
+        /* In real mode top 4 effective addr bits (mostly) ignored */
+        raddr = eaddr & 0x0FFFFFFFFFFFFFFFULL;
+
+        tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
+                     PAGE_READ | PAGE_WRITE | PAGE_EXEC, mmu_idx,
+                     TARGET_PAGE_SIZE);
+        return 0;
+    }
+
+    /* Virtual Mode Access - get the fully qualified address */
+    if (!ppc_radix64_get_fully_qualified_addr(env, eaddr, &lpid, &pid)) {
+        ppc_radix64_raise_segi(cpu, rwx, eaddr);
+        return 1;
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
+        ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
+        return 1;
+    }
+    prtbe0 = ldq_phys(cs->as, (patbe & PATBE1_R_PRTB) + offset);
+
+    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
+    page_size = PRTBE_R_GET_RTS(prtbe0);
+    pte = ppc_radix64_walk_tree(cpu, rwx, eaddr & R_EADDR_MASK,
+                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
+                                &raddr, &page_size, &fault_cause, &prot,
+                                &pte_addr);
+    if (!pte) {
+        ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
+        return 1;
+    }
+
+    /* Update Reference and Change Bits */
+    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, &prot);
+
+    tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
+                 prot, mmu_idx, 1UL << page_size);
+    return 1;
+}
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
new file mode 100644
index 0000000..1d5c7cf
--- /dev/null
+++ b/target/ppc/mmu-radix64.h
@@ -0,0 +1,72 @@
+#ifndef MMU_RADIX64_H
+#define MMU_RADIX64_H
+
+#ifndef CONFIG_USER_ONLY
+
+/* Radix Quadrants */
+#define R_EADDR_MASK            0x3FFFFFFFFFFFFFFF
+#define R_EADDR_QUADRANT        0xC000000000000000
+#define R_EADDR_QUADRANT0       0x0000000000000000
+#define R_EADDR_QUADRANT1       0x4000000000000000
+#define R_EADDR_QUADRANT2       0x8000000000000000
+#define R_EADDR_QUADRANT3       0xC000000000000000
+
+/* Radix Partition Table Entry Fields */
+#define PATBE1_R_PRTB           0x0FFFFFFFFFFFF000
+#define PATBE1_R_PRTS           0x000000000000001F
+
+/* Radix Process Table Entry Fields */
+#define PRTBE_R_GET_RTS(rts) \
+    ((((rts >> 58) & 0x18) | ((rts >> 5) & 0x7)) + 31)
+#define PRTBE_R_RPDB            0x0FFFFFFFFFFFFF00
+#define PRTBE_R_RPDS            0x000000000000001F
+
+/* Radix Page Directory/Table Entry Fields */
+#define R_PTE_VALID             0x8000000000000000
+#define R_PTE_LEAF              0x4000000000000000
+#define R_PTE_SW0               0x2000000000000000
+#define R_PTE_RPN               0x01FFFFFFFFFFF000
+#define R_PTE_SW1               0x0000000000000E00
+#define R_GET_SW(sw)            (((sw >> 58) & 0x8) | ((sw >> 9) & 0x7))
+#define R_PTE_R                 0x0000000000000100
+#define R_PTE_C                 0x0000000000000080
+#define R_PTE_ATT               0x0000000000000030
+#define R_PTE_ATT_NORMAL        0x0000000000000000
+#define R_PTE_ATT_SAO           0x0000000000000010
+#define R_PTE_ATT_NI_IO         0x0000000000000020
+#define R_PTE_ATT_TOLERANT_IO   0x0000000000000030
+#define R_PTE_EAA_PRIV          0x0000000000000008
+#define R_PTE_EAA_R             0x0000000000000004
+#define R_PTE_EAA_RW            0x0000000000000002
+#define R_PTE_EAA_X             0x0000000000000001
+#define R_PDE_NLB               PRTBE_R_RPDB
+#define R_PDE_NLS               PRTBE_R_RPDS
+
+#ifdef TARGET_PPC64
+
+int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
+                                 int mmu_idx);
+
+static inline int ppc_radix64_get_prot_eaa(uint64_t pte)
+{
+    return (pte & R_PTE_EAA_R ? PAGE_READ : 0) |
+           (pte & R_PTE_EAA_RW ? PAGE_READ | PAGE_WRITE : 0) |
+           (pte & R_PTE_EAA_X ? PAGE_EXEC : 0);
+}
+
+static inline int ppc_radix64_get_prot_amr(PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+    int amr = env->spr[SPR_AMR] >> 62; /* We only care about key0 AMR63:62 */
+    int iamr = env->spr[SPR_IAMR] >> 62; /* We only care about key0 IAMR63:62 */
+
+    return (amr & 0x2 ? 0 : PAGE_WRITE) | /* Access denied if bit is set */
+           (amr & 0x1 ? 0 : PAGE_READ) |
+           (iamr & 0x1 ? 0 : PAGE_EXEC);
+}
+
+#endif /* TARGET_PPC64 */
+
+#endif /* CONFIG_USER_ONLY */
+
+#endif /* MMU_RADIX64_H */
-- 
2.9.3
