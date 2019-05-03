Received: from eggs.gnu.org ([209.51.188.92]:54669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9H-0005XE-Od
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9E-00035K-4h
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:19 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  3 May 2019 15:53:10 +1000
Message-Id: <20190503055316.6441-8-sjitindarsingh@gmail.com>
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 07/13] target/ppc: Handle partition
 scoped radix tree translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, clg@kaod.org, groug@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Radix tree translation is a 2 step process:

Process Scoped Translation:
Effective Address (EA) -> Virtual Address (VA)

Paritition Scoped Translation:
Virtual Address (VA) -> Real Address (RA)

Performed based on:
                                      MSR[HV]
           -----------------------------------------------
           |             |     HV = 0    |     HV = 1    |
           -----------------------------------------------
           | Relocation  |   Partition   |      No       |
           | = Off       |    Scoped     |  Translation  |
Relocation -----------------------------------------------
           | Relocation  |  Partition &  |    Process    |
           | = On        |Process Scoped |    Scoped     |
           -----------------------------------------------

Currently only process scoped translation is handled.
Implement partitition scoped translation.

The process of using the radix trees to perform partition scoped
translation is identical to process scoped translation, however
hypervisor exceptions are generated, and thus we can reuse the radix
tree traversing code.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu.h         |   2 +
 target/ppc/excp_helper.c |   3 +-
 target/ppc/mmu-radix64.c | 407 +++++++++++++++++++++++++++++++++--------------
 3 files changed, 293 insertions(+), 119 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1d2a088391..3acc248f40 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -501,6 +501,8 @@ typedef struct ppc_v3_pate_t {
 /* Unsupported Radix Tree Configuration */
 #define DSISR_R_BADCONFIG        0x00080000
 #define DSISR_ATOMIC_RC          0x00040000
+/* Unable to translate address of (guest) pde or process/page table entry */
+#define DSISR_PRTABLE_FAULT      0x00020000
 
 /* SRR1 error code fields */
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7a4da7bdba..10091d4624 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -441,9 +441,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
         break;
+    case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
+        msr |= env->error_code;
     case POWERPC_EXCP_HDECR:     /* Hypervisor decrementer exception         */
     case POWERPC_EXCP_HDSI:      /* Hypervisor data storage exception        */
-    case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
     case POWERPC_EXCP_HDSEG:     /* Hypervisor data segment exception        */
     case POWERPC_EXCP_HISEG:     /* Hypervisor instruction segment exception */
     case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt            */
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index afa5ba506a..6118ad1b00 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -112,9 +112,31 @@ static void ppc_radix64_raise_si(PowerPCCPU *cpu, int rwx, vaddr eaddr,
     }
 }
 
+static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, int rwx, vaddr eaddr,
+                                  hwaddr g_raddr, uint32_t cause)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+
+    if (rwx == 2) { /* H Instruction Storage Interrupt */
+        cs->exception_index = POWERPC_EXCP_HISI;
+        env->spr[SPR_ASDR] = g_raddr;
+        env->error_code = cause;
+    } else { /* H Data Storage Interrupt */
+        cs->exception_index = POWERPC_EXCP_HDSI;
+        if (rwx == 1) { /* Write -> Store */
+            cause |= DSISR_ISSTORE;
+        }
+        env->spr[SPR_HDSISR] = cause;
+        env->spr[SPR_HDAR] = eaddr;
+        env->spr[SPR_ASDR] = g_raddr;
+        env->error_code = 0;
+    }
+}
 
 static bool ppc_radix64_check_prot(PowerPCCPU *cpu, int rwx, uint64_t pte,
-                                   int *fault_cause, int *prot)
+                                   int *fault_cause, int *prot,
+                                   bool partition_scoped)
 {
     CPUPPCState *env = &cpu->env;
     const int need_prot[] = { PAGE_READ, PAGE_WRITE, PAGE_EXEC };
@@ -130,11 +152,11 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, int rwx, uint64_t pte,
     }
 
     /* Determine permissions allowed by Encoded Access Authority */
-    if ((pte & R_PTE_EAA_PRIV) && msr_pr) { /* Insufficient Privilege */
+    if (!partition_scoped && (pte & R_PTE_EAA_PRIV) && msr_pr) {
         *prot = 0;
-    } else if (msr_pr || (pte & R_PTE_EAA_PRIV)) {
+    } else if (msr_pr || (pte & R_PTE_EAA_PRIV) || partition_scoped) {
         *prot = ppc_radix64_get_prot_eaa(pte);
-    } else { /* !msr_pr && !(pte & R_PTE_EAA_PRIV) */
+    } else { /* !msr_pr && !(pte & R_PTE_EAA_PRIV) && !partition_scoped */
         *prot = ppc_radix64_get_prot_eaa(pte);
         *prot &= ppc_radix64_get_prot_amr(cpu); /* Least combined permissions */
     }
@@ -199,44 +221,196 @@ static uint64_t ppc_radix64_set_rc(PowerPCCPU *cpu, int rwx, uint64_t pte, hwadd
     return npte;
 }
 
-static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
-                                      uint64_t base_addr, uint64_t nls,
-                                      hwaddr *raddr, int *psize,
-                                      int *fault_cause, hwaddr *pte_addr)
+static uint64_t ppc_radix64_next_level(PowerPCCPU *cpu, vaddr eaddr,
+                                       uint64_t *pte_addr, uint64_t *nls,
+                                       int *psize, int *fault_cause)
 {
     CPUState *cs = CPU(cpu);
     uint64_t index, pde;
 
-    if (nls < 5) { /* Directory maps less than 2**5 entries */
+    if (*nls < 5) { /* Directory maps less than 2**5 entries */
         *fault_cause |= DSISR_R_BADCONFIG;
         return 0;
     }
 
     /* Read page <directory/table> entry from guest address space */
-    index = eaddr >> (*psize - nls); /* Shift */
-    index &= ((1UL << nls) - 1); /* Mask */
-    pde = ldq_phys(cs->as, base_addr + (index * sizeof(pde)));
-    if (!(pde & R_PTE_VALID)) { /* Invalid Entry */
+    pde = ldq_phys(cs->as, *pte_addr);
+    if (!(pde & R_PTE_VALID)) {         /* Invalid Entry */
         *fault_cause |= DSISR_NOPTE;
         return 0;
     }
 
-    *psize -= nls;
+    *psize -= *nls;
+    if (!(pde & R_PTE_LEAF)) { /* Prepare for next iteration */
+        *nls = pde & R_PDE_NLS;
+        index = eaddr >> (*psize - *nls);       /* Shift */
+        index &= ((1UL << *nls) - 1);           /* Mask */
+        *pte_addr = (pde & R_PDE_NLB) + (index * sizeof(pde));
+    }
+    return pde;
+}
+
+static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
+                                      uint64_t base_addr, uint64_t nls,
+                                      hwaddr *raddr, int *psize,
+                                      int *fault_cause, hwaddr *pte_addr)
+{
+    uint64_t index, pde;
+
+    index = eaddr >> (*psize - nls);    /* Shift */
+    index &= ((1UL << nls) - 1);       /* Mask */
+    *pte_addr = base_addr + (index * sizeof(pde));
+    do {
+        pde = ppc_radix64_next_level(cpu, eaddr, pte_addr, &nls, psize,
+                                     fault_cause);
+    } while ((pde & R_PTE_VALID) && !(pde & R_PTE_LEAF));
 
-    /* Check if Leaf Entry -> Page Table Entry -> Stop the Search */
-    if (pde & R_PTE_LEAF) {
+    /* Did we find a valid leaf? */
+    if ((pde & R_PTE_VALID) && (pde & R_PTE_LEAF)) {
         uint64_t rpn = pde & R_PTE_RPN;
         uint64_t mask = (1UL << *psize) - 1;
 
         /* Or high bits of rpn and low bits to ea to form whole real addr */
         *raddr = (rpn & ~mask) | (eaddr & mask);
-        *pte_addr = base_addr + (index * sizeof(pde));
-        return pde;
     }
 
-    /* Next Level of Radix Tree */
-    return ppc_radix64_walk_tree(cpu, eaddr, pde & R_PDE_NLB, pde & R_PDE_NLS,
-                                 raddr, psize, fault_cause, pte_addr);
+    return pde;
+}
+
+static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
+                                              vaddr eaddr, hwaddr g_raddr,
+                                              ppc_v3_pate_t pate,
+                                              hwaddr *h_raddr, int *h_prot,
+                                              int *h_page_size, bool pde_addr,
+                                              bool cause_excp)
+{
+    CPUPPCState *env = &cpu->env;
+    int fault_cause = 0;
+    hwaddr pte_addr;
+    uint64_t pte;
+
+restart:
+    *h_page_size = PRTBE_R_GET_RTS(pate.dw0);
+    pte = ppc_radix64_walk_tree(cpu, g_raddr, pate.dw0 & PRTBE_R_RPDB,
+                                pate.dw0 & PRTBE_R_RPDS, h_raddr, h_page_size,
+                                &fault_cause, &pte_addr);
+    /* No valid pte or access denied due to protection */
+    if (!(pte & R_PTE_VALID) ||
+            ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, h_prot, 1)) {
+        if (pde_addr) /* address being translated was that of a guest pde */
+            fault_cause |= DSISR_PRTABLE_FAULT;
+        if (cause_excp)
+            ppc_radix64_raise_hsi(cpu, rwx, eaddr, g_raddr, fault_cause);
+        return 1;
+    }
+
+    /* Update Reference and Change Bits */
+    if (ppc_radix64_hw_rc_updates(env)) {
+        pte = ppc_radix64_set_rc(cpu, rwx, pte, pte_addr);
+        if (!pte) {
+            goto restart;
+        }
+    }
+
+    /* If the page doesn't have C, treat it as read only */
+    if (!(pte & R_PTE_C))
+        *h_prot &= ~PAGE_WRITE;
+
+    return 0;
+}
+
+static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
+                                            vaddr eaddr, uint64_t lpid, uint64_t pid,
+                                            ppc_v3_pate_t pate, hwaddr *g_raddr,
+                                            int *g_prot, int *g_page_size,
+                                            bool cause_excp)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    uint64_t offset, size, prtbe_addr, prtbe0, base_addr, nls, index, pte;
+    int fault_cause = 0, h_page_size, h_prot, ret;
+    hwaddr h_raddr, pte_addr;
+
+    /* Index Process Table by PID to Find Corresponding Process Table Entry */
+    offset = pid * sizeof(struct prtb_entry);
+    size = 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
+    if (offset >= size) {
+        /* offset exceeds size of the process table */
+        if (cause_excp)
+            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
+        return 1;
+    }
+    prtbe_addr = (pate.dw1 & PATE1_R_PRTB) + offset;
+    /* address subject to partition scoped translation */
+    if (cpu->vhyp && (lpid == 0)) {
+        prtbe0 = ldq_phys(cs->as, prtbe_addr);
+    } else {
+        ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_addr,
+                                                 pate, &h_raddr, &h_prot,
+                                                 &h_page_size, 1, 1);
+        if (ret)
+            return ret;
+        prtbe0 = ldq_phys(cs->as, h_raddr);
+    }
+
+    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
+restart:
+    *g_page_size = PRTBE_R_GET_RTS(prtbe0);
+    base_addr = prtbe0 & PRTBE_R_RPDB;
+    nls = prtbe0 & PRTBE_R_RPDS;
+    if (msr_hv || (cpu->vhyp && (lpid == 0))) {
+        /* Can treat process tree addresses as real addresses */
+        pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK, base_addr, nls,
+                                    g_raddr, g_page_size, &fault_cause,
+                                    &pte_addr);
+    } else {
+        index = (eaddr & R_EADDR_MASK) >> (*g_page_size - nls); /* Shift */
+        index &= ((1UL << nls) - 1);                            /* Mask */
+        pte_addr = base_addr + (index * sizeof(pte));
+
+        /* Each process tree address subject to partition scoped translation */
+        do {
+            ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pte_addr,
+                                                     pate, &h_raddr, &h_prot,
+                                                     &h_page_size, 1, 1);
+            if (ret)
+                return ret;
+
+            pte = ppc_radix64_next_level(cpu, eaddr & R_EADDR_MASK, &h_raddr,
+                                         &nls, g_page_size, &fault_cause);
+            pte_addr = h_raddr;
+        } while ((pte & R_PTE_VALID) && !(pte & R_PTE_LEAF));
+
+        /* Did we find a valid leaf? */
+        if ((pte & R_PTE_VALID) && (pte & R_PTE_LEAF)) {
+            uint64_t rpn = pte & R_PTE_RPN;
+            uint64_t mask = (1UL << *g_page_size) - 1;
+
+            /* Or high bits of rpn and low bits to ea to form whole real addr */
+            *g_raddr = (rpn & ~mask) | (eaddr & mask);
+        }
+    }
+
+    if (!(pte & R_PTE_VALID) ||
+            ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, 0)) {
+        /* No valid pte or access denied due to protection */
+        if (cause_excp)
+            ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
+        return 1;
+    }
+
+    /* Update Reference and Change Bits */
+    if (ppc_radix64_hw_rc_updates(env)) {
+        pte = ppc_radix64_set_rc(cpu, rwx, pte, pte_addr);
+        if (!pte)
+            goto restart;
+    }
+
+    /* If the page doesn't have C, treat it as read only */
+    if (!(pte & R_PTE_C))
+        *g_prot &= ~PAGE_WRITE;
+
+    return 0;
 }
 
 static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t *pate)
@@ -255,22 +429,99 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t *pate)
     return true;
 }
 
+static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
+                             uint64_t lpid, uint64_t pid, bool relocation,
+                             hwaddr *raddr, int *psizep, int *protp,
+                             bool cause_excp)
+{
+    CPUPPCState *env = &cpu->env;
+    ppc_v3_pate_t pate;
+    int psize, prot;
+    hwaddr g_raddr;
+
+    *psizep = INT_MAX;
+    *protp = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+
+    /* Get Process Table */
+    if (cpu->vhyp && (lpid == 0)) {
+        PPCVirtualHypervisorClass *vhc;
+        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->get_pate(cpu->vhyp, &pate);
+    } else {
+        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
+            if (cause_excp)
+                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
+            return 1;
+        }
+        if (!validate_pate(cpu, lpid, &pate)) {
+            if (cause_excp)
+                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
+            return 1;
+        }
+    }
+
+    /*
+     * Radix tree translation is a 2 step translation process:
+     * 1. Process Scoped translation - Guest Eff Addr -> Guest Real Addr
+     * 2. Partition Scoped translation - Guest Real Addr -> Host Real Addr
+     *
+     *                                       MSR[HV]
+     *            -----------------------------------------------
+     *            |             |     HV = 0    |     HV = 1    |
+     *            -----------------------------------------------
+     *            | Relocation  |   Partition   |      No       |
+     *            | = Off       |    Scoped     |  Translation  |
+     * Relocation -----------------------------------------------
+     *            | Relocation  |  Partition &  |    Process    |
+     *            | = On        |Process Scoped |    Scoped     |
+     *            -----------------------------------------------
+     */
+
+    /* Perform process scoped translation if relocation enabled */
+    if (relocation) {
+        int ret = ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, lpid, pid,
+                                                   pate, &g_raddr, &prot,
+                                                   &psize, cause_excp);
+        if (ret)
+            return ret;
+        *psizep = MIN(*psizep, psize);
+        *protp &= prot;
+    } else {
+        g_raddr = eaddr & R_EADDR_MASK;
+    }
+
+    /* Perform partition scoped xlate if !HV or HV access to quadrants 1 or 2 */
+    if ((lpid != 0) || (!cpu->vhyp && !msr_hv)) {
+        int ret = ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, g_raddr,
+                                                     pate, raddr, &prot, &psize,
+                                                     0, cause_excp);
+        if (ret)
+            return ret;
+        *psizep = MIN(*psizep, psize);
+        *protp &= prot;
+    } else {
+        *raddr = g_raddr;
+    }
+
+    return 0;
+}
+
 int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                                  int mmu_idx)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    PPCVirtualHypervisorClass *vhc;
-    hwaddr raddr, pte_addr;
-    uint64_t lpid = 0, pid = 0, offset, size, prtbe0, pte;
-    int page_size, prot, fault_cause = 0;
-    ppc_v3_pate_t pate;
+    uint64_t pid, lpid = env->spr[SPR_LPIDR];
+    int psize, prot;
+    bool relocation;
+    hwaddr raddr;
 
+    assert(!(msr_hv && cpu->vhyp));
     assert((rwx == 0) || (rwx == 1) || (rwx == 2));
 
+    relocation = ((rwx == 2) && (msr_ir == 1)) || ((rwx != 2) && (msr_dr == 1));
     /* HV or virtual hypervisor Real Mode Access */
-    if ((msr_hv || cpu->vhyp) &&
-        (((rwx == 2) && (msr_ir == 0)) || ((rwx != 2) && (msr_dr == 0)))) {
+    if (!relocation && (msr_hv || (cpu->vhyp && (lpid == 0)))) {
         /* In real mode top 4 effective addr bits (mostly) ignored */
         raddr = eaddr & 0x0FFFFFFFFFFFFFFFULL;
 
@@ -294,75 +545,26 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
         return 1;
     }
 
-    /* Get Process Table */
-    if (cpu->vhyp) {
-        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->get_pate(cpu->vhyp, &pate);
-    } else {
-        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
-            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
-            return 1;
-        }
-        if (!validate_pate(cpu, lpid, &pate)) {
-            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
-        }
-        /* We don't support guest mode yet */
-        if (lpid != 0) {
-            error_report("PowerNV guest support Unimplemented");
-            exit(1);
-       }
-    }
-
-    /* Index Process Table by PID to Find Corresponding Process Table Entry */
-    offset = pid * sizeof(struct prtb_entry);
-    size = 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
-    if (offset >= size) {
-        /* offset exceeds size of the process table */
-        ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
-        return 1;
-    }
-    prtbe0 = ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
-
-    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
-    page_size = PRTBE_R_GET_RTS(prtbe0);
- restart:
-    pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
-                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
-                                &raddr, &page_size, &fault_cause, &pte_addr);
-    if (!pte || ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, &prot)) {
-        /* Couldn't get pte or access denied due to protection */
-        ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
+    /* Translate eaddr to raddr (where raddr is addr qemu needs for access) */
+    if (ppc_radix64_xlate(cpu, eaddr, rwx, lpid, pid, relocation, &raddr,
+                          &psize, &prot, 1)) {
         return 1;
     }
 
-    /* Update Reference and Change Bits */
-    if (ppc_radix64_hw_rc_updates(env)) {
-        pte = ppc_radix64_set_rc(cpu, rwx, pte, pte_addr);
-        if (!pte) {
-            goto restart;
-        }
-    }
-    /* If the page doesn't have C, treat it as read only */
-    if (!(pte & R_PTE_C)) {
-        prot &= ~PAGE_WRITE;
-    }
     tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
-                 prot, mmu_idx, 1UL << page_size);
+                 prot, mmu_idx, 1UL << psize);
     return 0;
 }
 
 hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong eaddr)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    PPCVirtualHypervisorClass *vhc;
-    hwaddr raddr, pte_addr;
-    uint64_t lpid = 0, pid = 0, offset, size, prtbe0, pte;
-    int page_size, fault_cause = 0;
-    ppc_v3_pate_t pate;
+    uint64_t lpid = 0, pid = 0;
+    int psize, prot;
+    hwaddr raddr;
 
     /* Handle Real Mode */
-    if (msr_dr == 0) {
+    if ((msr_dr == 0) && (msr_hv || (cpu->vhyp && (lpid == 0)))) {
         /* In real mode top 4 effective addr bits (mostly) ignored */
         return eaddr & 0x0FFFFFFFFFFFFFFFULL;
     }
@@ -372,39 +574,8 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong eaddr)
         return -1;
     }
 
-    /* Get Process Table */
-    if (cpu->vhyp) {
-        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->get_pate(cpu->vhyp, &pate);
-    } else {
-        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
-            return -1;
-        }
-        if (!validate_pate(cpu, lpid, &pate)) {
-            return -1;
-        }
-        /* We don't support guest mode yet */
-        if (lpid != 0) {
-            error_report("PowerNV guest support Unimplemented");
-            exit(1);
-       }
-    }
-
-    /* Index Process Table by PID to Find Corresponding Process Table Entry */
-    offset = pid * sizeof(struct prtb_entry);
-    size = 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
-    if (offset >= size) {
-        /* offset exceeds size of the process table */
-        return -1;
-    }
-    prtbe0 = ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
-
-    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
-    page_size = PRTBE_R_GET_RTS(prtbe0);
-    pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
-                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
-                                &raddr, &page_size, &fault_cause, &pte_addr);
-    if (!pte) {
+    if (ppc_radix64_xlate(cpu, eaddr, 0, lpid, pid, msr_dr, &raddr, &psize,
+                          &prot, 0)) {
         return -1;
     }
 
-- 
2.13.6
