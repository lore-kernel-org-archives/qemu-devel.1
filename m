Received: from eggs.gnu.org ([2001:4830:134:3::10]:35296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDcB-0000j4-KQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDc8-0006l9-W9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:12:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 27 Feb 2017 16:12:37 +1100
Message-Id: <20170227051239.2680-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170227051239.2680-1-david@gibson.dropbear.id.au>
References: <20170227051239.2680-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 7/9] target/ppc: Manage external HPT via
 virtual hypervisor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, aik@ozlabs.ru, sjitindarsingh@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The pseries machine type implements the behaviour of a PAPR compliant
hypervisor, without actually executing such a hypervisor on the virtual
CPU.  To do this we need some hooks in the CPU code to make hypervisor
facilities get redirected to the machine instead of emulated internally.

For hypercalls this is managed through the cpu->vhyp field, which points
to a QOM interface with a method implementing the hypercall.

For the hashed page table (HPT) - also a hypervisor resource - we use an
older hack.  CPUPPCState has an 'external_htab' field which when non-NULL
indicates that the HPT is stored in qemu memory, rather than within the
guest's address space.

For consistency - and to make some future extensions easier - this merges
the external HPT mechanism into the vhyp mechanism.  Methods are added
to vhyp for the basic operations the core hash MMU code needs: map_hptes()
and unmap_hptes() for reading the HPT, store_hpte() for updating it and
hpt_mask() to retrieve its size.

To match this, the pseries machine now sets these vhyp fields in its
existing vhyp class, rather than reaching into the cpu object to set the
external_htab field.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c          | 60 ++++++++++++++++++++++++++++++
 hw/ppc/spapr_cpu_core.c | 17 ++++++++-
 hw/ppc/spapr_hcall.c    |  3 +-
 target/ppc/cpu.h        | 10 ++++-
 target/ppc/kvm.c        |  2 +-
 target/ppc/machine.c    |  4 +-
 target/ppc/mmu-hash32.h |  8 ----
 target/ppc/mmu-hash64.c | 99 ++++++++++++++++---------------------------------
 target/ppc/mmu-hash64.h |  7 +++-
 target/ppc/mmu_helper.c |  3 +-
 10 files changed, 125 insertions(+), 88 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0b57aad..e0bb9bc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1053,6 +1053,62 @@ static void close_htab_fd(sPAPRMachineState *spapr)
     spapr->htab_fd = -1;
 }
 
+static hwaddr spapr_hpt_mask(PPCVirtualHypervisor *vhyp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(vhyp);
+
+    return HTAB_SIZE(spapr) / HASH_PTEG_SIZE_64 - 1;
+}
+
+static const ppc_hash_pte64_t *spapr_map_hptes(PPCVirtualHypervisor *vhyp,
+                                                hwaddr ptex, int n)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(vhyp);
+    hwaddr pte_offset = ptex * HASH_PTE_SIZE_64;
+
+    if (!spapr->htab) {
+        /*
+         * HTAB is controlled by KVM. Fetch into temporary buffer
+         */
+        ppc_hash_pte64_t *hptes = g_malloc(n * HASH_PTE_SIZE_64);
+        kvmppc_read_hptes(hptes, ptex, n);
+        return hptes;
+    }
+
+    /*
+     * HTAB is controlled by QEMU. Just point to the internally
+     * accessible PTEG.
+     */
+    return (const ppc_hash_pte64_t *)(spapr->htab + pte_offset);
+}
+
+static void spapr_unmap_hptes(PPCVirtualHypervisor *vhyp,
+                              const ppc_hash_pte64_t *hptes,
+                              hwaddr ptex, int n)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(vhyp);
+
+    if (!spapr->htab) {
+        g_free((void *)hptes);
+    }
+
+    /* Nothing to do for qemu managed HPT */
+}
+
+static void spapr_store_hpte(PPCVirtualHypervisor *vhyp, hwaddr ptex,
+                             uint64_t pte0, uint64_t pte1)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(vhyp);
+    hwaddr offset = ptex * HASH_PTE_SIZE_64;
+
+    if (!spapr->htab) {
+        kvmppc_write_hpte(ptex, pte0, pte1);
+    } else {
+        stq_p(spapr->htab + offset, pte0);
+        stq_p(spapr->htab + offset + HASH_PTE_SIZE_64 / 2, pte1);
+    }
+}
+
 static int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
 {
     int shift;
@@ -2913,6 +2969,10 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = spapr_nmi;
     smc->phb_placement = spapr_phb_placement;
     vhc->hypercall = emulate_spapr_hypercall;
+    vhc->hpt_mask = spapr_hpt_mask;
+    vhc->map_hptes = spapr_map_hptes;
+    vhc->unmap_hptes = spapr_unmap_hptes;
+    vhc->store_hpte = spapr_store_hpte;
 }
 
 static const TypeInfo spapr_machine_info = {
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 76563c4..ddb130f 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -13,10 +13,12 @@
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "sysemu/cpus.h"
+#include "sysemu/kvm.h"
 #include "target/ppc/kvm_ppc.h"
 #include "hw/ppc/ppc.h"
 #include "target/ppc/mmu-hash64.h"
 #include "sysemu/numa.h"
+#include "qemu/error-report.h"
 
 static void spapr_cpu_reset(void *opaque)
 {
@@ -34,8 +36,19 @@ static void spapr_cpu_reset(void *opaque)
 
     env->spr[SPR_HIOR] = 0;
 
-    ppc_hash64_set_external_hpt(cpu, spapr->htab, spapr->htab_shift,
-                                &error_fatal);
+    /*
+     * This is a hack for the benefit of KVM PR - it abuses the SDR1
+     * slot in kvm_sregs to communicate the userspace address of the
+     * HPT
+     */
+    if (kvm_enabled()) {
+        env->spr[SPR_SDR1] = (target_ulong)(uintptr_t)spapr->htab
+            | (spapr->htab_shift - 18);
+        if (kvmppc_put_books_sregs(cpu) < 0) {
+            error_report("Unable to update SDR1 in KVM");
+            exit(1);
+        }
+    }
 }
 
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 85d96f6..f05a90e 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -326,7 +326,6 @@ static target_ulong h_protect(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 static target_ulong h_read(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
-    CPUPPCState *env = &cpu->env;
     target_ulong flags = args[0];
     target_ulong ptex = args[1];
     uint8_t *hpte;
@@ -342,7 +341,7 @@ static target_ulong h_read(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         n_entries = 4;
     }
 
-    hpte = env->external_htab + (ptex * HASH_PTE_SIZE_64);
+    hpte = spapr->htab + (ptex * HASH_PTE_SIZE_64);
 
     for (i = 0, ridx = 0; i < n_entries; i++) {
         args[ridx++] = ldq_p(hpte);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index aaf79f5..4e7fc2c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -999,8 +999,6 @@ struct CPUPPCState {
 #endif
     /* segment registers */
     target_ulong sr[32];
-    /* externally stored hash table */
-    uint8_t *external_htab;
     /* BATs */
     uint32_t nb_BATs;
     target_ulong DBAT[2][8];
@@ -1208,6 +1206,14 @@ struct PPCVirtualHypervisor {
 struct PPCVirtualHypervisorClass {
     InterfaceClass parent;
     void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
+    hwaddr (*hpt_mask)(PPCVirtualHypervisor *vhyp);
+    const ppc_hash_pte64_t *(*map_hptes)(PPCVirtualHypervisor *vhyp,
+                                         hwaddr ptex, int n);
+    void (*unmap_hptes)(PPCVirtualHypervisor *vhyp,
+                        const ppc_hash_pte64_t *hptes,
+                        hwaddr ptex, int n);
+    void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
+                       uint64_t pte0, uint64_t pte1);
 };
 
 #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 79c1da6..acc40ec 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1251,7 +1251,7 @@ static int kvmppc_get_books_sregs(PowerPCCPU *cpu)
         return ret;
     }
 
-    if (!env->external_htab) {
+    if (!cpu->vhyp) {
         ppc_store_sdr1(env, sregs.u.s.sdr1);
     }
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 1ccbc8a..6cb3a48 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -76,7 +76,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
         qemu_get_betls(f, &env->pb[i]);
     for (i = 0; i < 1024; i++)
         qemu_get_betls(f, &env->spr[i]);
-    if (!env->external_htab) {
+    if (!cpu->vhyp) {
         ppc_store_sdr1(env, sdr1);
     }
     qemu_get_be32s(f, &env->vscr);
@@ -228,7 +228,7 @@ static int cpu_post_load(void *opaque, int version_id)
         env->IBAT[1][i+4] = env->spr[SPR_IBAT4U + 2*i + 1];
     }
 
-    if (!env->external_htab) {
+    if (!cpu->vhyp) {
         ppc_store_sdr1(env, env->spr[SPR_SDR1]);
     }
 
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 2ed4888..898021f 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -80,10 +80,8 @@ static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *cpu)
 static inline target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu,
                                                  hwaddr pte_offset)
 {
-    CPUPPCState *env = &cpu->env;
     target_ulong base = ppc_hash32_hpt_base(cpu);
 
-    assert(!env->external_htab); /* Not supported on 32-bit for now */
     return ldl_phys(CPU(cpu)->as, base + pte_offset);
 }
 
@@ -91,29 +89,23 @@ static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
                                                  hwaddr pte_offset)
 {
     target_ulong base = ppc_hash32_hpt_base(cpu);
-    CPUPPCState *env = &cpu->env;
 
-    assert(!env->external_htab); /* Not supported on 32-bit for now */
     return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
 }
 
 static inline void ppc_hash32_store_hpte0(PowerPCCPU *cpu,
                                           hwaddr pte_offset, target_ulong pte0)
 {
-    CPUPPCState *env = &cpu->env;
     target_ulong base = ppc_hash32_hpt_base(cpu);
 
-    assert(!env->external_htab); /* Not supported on 32-bit for now */
     stl_phys(CPU(cpu)->as, base + pte_offset, pte0);
 }
 
 static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
                                           hwaddr pte_offset, target_ulong pte1)
 {
-    CPUPPCState *env = &cpu->env;
     target_ulong base = ppc_hash32_hpt_base(cpu);
 
-    assert(!env->external_htab); /* Not supported on 32-bit for now */
     stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
 }
 
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 38a6912..8fe0e78 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -38,12 +38,6 @@
 #endif
 
 /*
- * Used to indicate that a CPU has its hash page table (HPT) managed
- * within the host kernel
- */
-#define MMU_HASH64_KVM_MANAGED_HPT      ((void *)-1)
-
-/*
  * SLB handling
  */
 
@@ -313,31 +307,6 @@ void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
     env->spr[SPR_SDR1] = value;
 }
 
-void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
-                                 Error **errp)
-{
-    CPUPPCState *env = &cpu->env;
-    Error *local_err = NULL;
-
-    if (hpt) {
-        env->external_htab = hpt;
-    } else {
-        env->external_htab = MMU_HASH64_KVM_MANAGED_HPT;
-    }
-    ppc_hash64_set_sdr1(cpu, (target_ulong)(uintptr_t)hpt | (shift - 18),
-                        &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    if (kvm_enabled()) {
-        if (kvmppc_put_books_sregs(cpu) < 0) {
-            error_setg(errp, "Unable to update SDR1 in KVM");
-        }
-    }
-}
-
 static int ppc_hash64_pte_prot(PowerPCCPU *cpu,
                                ppc_slb_t *slb, ppc_hash_pte64_t pte)
 {
@@ -429,29 +398,24 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc_hash_pte64_t pte)
 const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
                                              hwaddr ptex, int n)
 {
-    ppc_hash_pte64_t *hptes = NULL;
     hwaddr pte_offset = ptex * HASH_PTE_SIZE_64;
+    hwaddr base = ppc_hash64_hpt_base(cpu);
+    hwaddr plen = n * HASH_PTE_SIZE_64;
+    const ppc_hash_pte64_t *hptes;
+
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        return vhc->map_hptes(cpu->vhyp, ptex, n);
+    }
 
-    if (cpu->env.external_htab == MMU_HASH64_KVM_MANAGED_HPT) {
-        /*
-         * HTAB is controlled by KVM. Fetch into temporary buffer
-         */
-        hptes = g_malloc(HASH_PTEG_SIZE_64);
-        kvmppc_read_hptes(hptes, ptex, n);
-    } else if (cpu->env.external_htab) {
-        /*
-         * HTAB is controlled by QEMU. Just point to the internally
-         * accessible PTEG.
-         */
-        hptes = (ppc_hash_pte64_t *)(cpu->env.external_htab + pte_offset);
-    } else if (ppc_hash64_hpt_base(cpu)) {
-        hwaddr base = ppc_hash64_hpt_base(cpu);
-        hwaddr plen = n * HASH_PTE_SIZE_64;
-        hptes = address_space_map(CPU(cpu)->as, base + pte_offset,
-                                  &plen, false);
-        if (plen < (n * HASH_PTE_SIZE_64)) {
-            hw_error("%s: Unable to map all requested HPTEs\n", __func__);
-        }
+    if (!base) {
+        return NULL;
+    }
+
+    hptes = address_space_map(CPU(cpu)->as, base + pte_offset, &plen, false);
+    if (plen < (n * HASH_PTE_SIZE_64)) {
+        hw_error("%s: Unable to map all requested HPTEs\n", __func__);
     }
     return hptes;
 }
@@ -459,12 +423,15 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
 void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *hptes,
                             hwaddr ptex, int n)
 {
-    if (cpu->env.external_htab == MMU_HASH64_KVM_MANAGED_HPT) {
-        g_free((void *)hptes);
-    } else if (!cpu->env.external_htab) {
-        address_space_unmap(CPU(cpu)->as, (void *)hptes, n * HASH_PTE_SIZE_64,
-                            false, n * HASH_PTE_SIZE_64);
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->unmap_hptes(cpu->vhyp, hptes, ptex, n);
+        return;
     }
+
+    address_space_unmap(CPU(cpu)->as, (void *)hptes, n * HASH_PTE_SIZE_64,
+                        false, n * HASH_PTE_SIZE_64);
 }
 
 static unsigned hpte_page_shift(const struct ppc_one_seg_page_size *sps,
@@ -916,22 +883,18 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
 void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                            uint64_t pte0, uint64_t pte1)
 {
-    CPUPPCState *env = &cpu->env;
+    hwaddr base = ppc_hash64_hpt_base(cpu);
     hwaddr offset = ptex * HASH_PTE_SIZE_64;
 
-    if (env->external_htab == MMU_HASH64_KVM_MANAGED_HPT) {
-        kvmppc_write_hpte(ptex, pte0, pte1);
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->store_hpte(cpu->vhyp, ptex, pte0, pte1);
         return;
     }
 
-    if (env->external_htab) {
-        stq_p(env->external_htab + offset, pte0);
-        stq_p(env->external_htab + offset + HASH_PTE_SIZE_64 / 2, pte1);
-    } else {
-        hwaddr base = ppc_hash64_hpt_base(cpu);
-        stq_phys(CPU(cpu)->as, base + offset, pte0);
-        stq_phys(CPU(cpu)->as, base + offset + HASH_PTE_SIZE_64 / 2, pte1);
-    }
+    stq_phys(CPU(cpu)->as, base + offset, pte0);
+    stq_phys(CPU(cpu)->as, base + offset + HASH_PTE_SIZE_64 / 2, pte1);
 }
 
 void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 5914a08..c8d3458 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -101,13 +101,16 @@ static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
 
 static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
 {
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        return vhc->hpt_mask(cpu->vhyp);
+    }
     return (1ULL << ((cpu->env.spr[SPR_SDR1] & SDR_64_HTABSIZE) + 18 - 7)) - 1;
 }
 
 void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
                          Error **errp);
-void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
-                                 Error **errp);
 
 struct ppc_hash_pte64 {
     uint64_t pte0, pte1;
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 1381635..0176ab6 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -2001,8 +2001,9 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
 /* Special registers manipulation */
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 {
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
     qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, value);
-    assert(!env->external_htab);
+    assert(!cpu->vhyp);
 #if defined(TARGET_PPC64)
     if (env->mmu_model & POWERPC_MMU_64) {
         PowerPCCPU *cpu = ppc_env_get_cpu(env);
-- 
2.9.3
