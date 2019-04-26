Received: from eggs.gnu.org ([209.51.188.92]:60557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu17-0006CB-K9
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu15-0005HY-OD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:25 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:25 +1000
Message-Id: <20190426060627.18153-35-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/36] ppc/hash64: Rework R and C bit updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

With MT-TCG, we are now running translation in a racy way, thus
we need to mimic hardware when it comes to updating the R and
C bits, by doing byte stores.

The current "store_hpte" abstraction is ill suited for this, we
replace it with two separate callbacks for setting R and C.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190411080004.8690-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c          | 41 +++++++++++++++++++---
 hw/ppc/spapr_hcall.c    | 13 +++----
 include/hw/ppc/spapr.h  |  2 ++
 target/ppc/cpu.h        |  4 +--
 target/ppc/mmu-hash64.c | 76 ++++++++++++++++++++++++-----------------
 target/ppc/mmu-hash64.h |  2 --
 6 files changed, 93 insertions(+), 45 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b81e237635..c56939a43b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1520,10 +1520,10 @@ static void spapr_unmap_hptes(PPCVirtualHyperviso=
r *vhyp,
     /* Nothing to do for qemu managed HPT */
 }
=20
-static void spapr_store_hpte(PPCVirtualHypervisor *vhyp, hwaddr ptex,
-                             uint64_t pte0, uint64_t pte1)
+void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
+                      uint64_t pte0, uint64_t pte1)
 {
-    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(cpu->vhyp);
     hwaddr offset =3D ptex * HASH_PTE_SIZE_64;
=20
     if (!spapr->htab) {
@@ -1551,6 +1551,38 @@ static void spapr_store_hpte(PPCVirtualHypervisor =
*vhyp, hwaddr ptex,
     }
 }
=20
+static void spapr_hpte_set_c(PPCVirtualHypervisor *vhyp, hwaddr ptex,
+                             uint64_t pte1)
+{
+    hwaddr offset =3D ptex * HASH_PTE_SIZE_64 + 15;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
+
+    if (!spapr->htab) {
+        /* There should always be a hash table when this is called */
+        error_report("spapr_hpte_set_c called with no hash table !");
+        return;
+    }
+
+    /* The HW performs a non-atomic byte update */
+    stb_p(spapr->htab + offset, (pte1 & 0xff) | 0x80);
+}
+
+static void spapr_hpte_set_r(PPCVirtualHypervisor *vhyp, hwaddr ptex,
+                             uint64_t pte1)
+{
+    hwaddr offset =3D ptex * HASH_PTE_SIZE_64 + 14;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
+
+    if (!spapr->htab) {
+        /* There should always be a hash table when this is called */
+        error_report("spapr_hpte_set_r called with no hash table !");
+        return;
+    }
+
+    /* The HW performs a non-atomic byte update */
+    stb_p(spapr->htab + offset, ((pte1 >> 8) & 0xff) | 0x01);
+}
+
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
 {
     int shift;
@@ -4291,7 +4323,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     vhc->hpt_mask =3D spapr_hpt_mask;
     vhc->map_hptes =3D spapr_map_hptes;
     vhc->unmap_hptes =3D spapr_unmap_hptes;
-    vhc->store_hpte =3D spapr_store_hpte;
+    vhc->hpte_set_c =3D spapr_hpte_set_c;
+    vhc->hpte_set_r =3D spapr_hpte_set_r;
     vhc->get_pate =3D spapr_get_pate;
     vhc->encode_hpt_for_kvm_pr =3D spapr_encode_hpt_for_kvm_pr;
     xic->ics_get =3D spapr_ics_get;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 3534079777..6c16d2b120 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -118,7 +118,7 @@ static target_ulong h_enter(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
         ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
     }
=20
-    ppc_hash64_store_hpte(cpu, ptex + slot, pteh | HPTE64_V_HPTE_DIRTY, =
ptel);
+    spapr_store_hpte(cpu, ptex + slot, pteh | HPTE64_V_HPTE_DIRTY, ptel)=
;
=20
     args[0] =3D ptex + slot;
     return H_SUCCESS;
@@ -131,7 +131,8 @@ typedef enum {
     REMOVE_HW =3D 3,
 } RemoveResult;
=20
-static RemoveResult remove_hpte(PowerPCCPU *cpu, target_ulong ptex,
+static RemoveResult remove_hpte(PowerPCCPU *cpu
+                                , target_ulong ptex,
                                 target_ulong avpn,
                                 target_ulong flags,
                                 target_ulong *vp, target_ulong *rp)
@@ -155,7 +156,7 @@ static RemoveResult remove_hpte(PowerPCCPU *cpu, targ=
et_ulong ptex,
     }
     *vp =3D v;
     *rp =3D r;
-    ppc_hash64_store_hpte(cpu, ptex, HPTE64_V_HPTE_DIRTY, 0);
+    spapr_store_hpte(cpu, ptex, HPTE64_V_HPTE_DIRTY, 0);
     ppc_hash64_tlb_flush_hpte(cpu, ptex, v, r);
     return REMOVE_SUCCESS;
 }
@@ -289,13 +290,13 @@ static target_ulong h_protect(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
     r |=3D (flags << 55) & HPTE64_R_PP0;
     r |=3D (flags << 48) & HPTE64_R_KEY_HI;
     r |=3D flags & (HPTE64_R_PP | HPTE64_R_N | HPTE64_R_KEY_LO);
-    ppc_hash64_store_hpte(cpu, ptex,
-                          (v & ~HPTE64_V_VALID) | HPTE64_V_HPTE_DIRTY, 0=
);
+    spapr_store_hpte(cpu, ptex,
+                     (v & ~HPTE64_V_VALID) | HPTE64_V_HPTE_DIRTY, 0);
     ppc_hash64_tlb_flush_hpte(cpu, ptex, v, r);
     /* Flush the tlb */
     check_tlb_flush(env, true);
     /* Don't need a memory barrier, due to qemu's global lock */
-    ppc_hash64_store_hpte(cpu, ptex, v | HPTE64_V_HPTE_DIRTY, r);
+    spapr_store_hpte(cpu, ptex, v | HPTE64_V_HPTE_DIRTY, r);
     return H_SUCCESS;
 }
=20
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9331f5e0b9..7e32f309c2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -784,6 +784,8 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, i=
nt shift,
                           Error **errp);
 void spapr_clear_pending_events(SpaprMachineState *spapr);
 int spapr_max_server_number(SpaprMachineState *spapr);
+void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
+                      uint64_t pte0, uint64_t pte1);
=20
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8a79db0c43..5e7cf54b2f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1265,8 +1265,8 @@ struct PPCVirtualHypervisorClass {
     void (*unmap_hptes)(PPCVirtualHypervisor *vhyp,
                         const ppc_hash_pte64_t *hptes,
                         hwaddr ptex, int n);
-    void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
-                       uint64_t pte0, uint64_t pte1);
+    void (*hpte_set_c)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t=
 pte1);
+    void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t=
 pte1);
     void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
     target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
 };
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index c74818b2e7..7899eb2918 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -725,6 +725,39 @@ static void ppc_hash64_set_dsi(CPUState *cs, uint64_=
t dar, uint64_t dsisr)
 }
=20
=20
+static void ppc_hash64_set_r(PowerPCCPU *cpu, hwaddr ptex, uint64_t pte1=
)
+{
+    hwaddr base, offset =3D ptex * HASH_PTE_SIZE_64 + 16;
+
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =3D
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->hpte_set_r(cpu->vhyp, ptex, pte1);
+        return;
+    }
+    base =3D ppc_hash64_hpt_base(cpu);
+
+
+    /* The HW performs a non-atomic byte update */
+    stb_phys(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01);
+}
+
+static void ppc_hash64_set_c(PowerPCCPU *cpu, hwaddr ptex, uint64_t pte1=
)
+{
+    hwaddr base, offset =3D ptex * HASH_PTE_SIZE_64 + 15;
+
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =3D
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->hpte_set_c(cpu->vhyp, ptex, pte1);
+        return;
+    }
+    base =3D ppc_hash64_hpt_base(cpu);
+
+    /* The HW performs a non-atomic byte update */
+    stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
+}
+
 int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
                                 int rwx, int mmu_idx)
 {
@@ -735,7 +768,6 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
     hwaddr ptex;
     ppc_hash_pte64_t pte;
     int exec_prot, pp_prot, amr_prot, prot;
-    uint64_t new_pte1;
     const int need_prot[] =3D {PAGE_READ, PAGE_WRITE, PAGE_EXEC};
     hwaddr raddr;
=20
@@ -883,19 +915,19 @@ skip_slb_search:
=20
     /* 6. Update PTE referenced and changed bits if necessary */
=20
-    new_pte1 =3D pte.pte1 | HPTE64_R_R; /* set referenced bit */
-    if (rwx =3D=3D 1) {
-        new_pte1 |=3D HPTE64_R_C; /* set changed (dirty) bit */
-    } else {
-        /*
-         * Treat the page as read-only for now, so that a later write
-         * will pass through this function again to set the C bit
-         */
-        prot &=3D ~PAGE_WRITE;
+    if (!(pte.pte1 & HPTE64_R_R)) {
+        ppc_hash64_set_r(cpu, ptex, pte.pte1);
     }
-
-    if (new_pte1 !=3D pte.pte1) {
-        ppc_hash64_store_hpte(cpu, ptex, pte.pte0, new_pte1);
+    if (!(pte.pte1 & HPTE64_R_C)) {
+        if (rwx =3D=3D 1) {
+            ppc_hash64_set_c(cpu, ptex, pte.pte1);
+        } else {
+            /*
+             * Treat the page as read-only for now, so that a later writ=
e
+             * will pass through this function again to set the C bit
+             */
+            prot &=3D ~PAGE_WRITE;
+        }
     }
=20
     /* 7. Determine the real address from the PTE */
@@ -954,24 +986,6 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cp=
u, target_ulong addr)
         & TARGET_PAGE_MASK;
 }
=20
-void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
-                           uint64_t pte0, uint64_t pte1)
-{
-    hwaddr base;
-    hwaddr offset =3D ptex * HASH_PTE_SIZE_64;
-
-    if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =3D
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->store_hpte(cpu->vhyp, ptex, pte0, pte1);
-        return;
-    }
-    base =3D ppc_hash64_hpt_base(cpu);
-
-    stq_phys(CPU(cpu)->as, base + offset, pte0);
-    stq_phys(CPU(cpu)->as, base + offset + HASH_PTE_SIZE_64 / 2, pte1);
-}
-
 void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
                                target_ulong pte0, target_ulong pte1)
 {
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 5be7ad86db..87729d48b3 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -10,8 +10,6 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
 hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr=
);
 int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr address, int rw,
                                 int mmu_idx);
-void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
-                           uint64_t pte0, uint64_t pte1);
 void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
                                target_ulong pte_index,
                                target_ulong pte0, target_ulong pte1);
--=20
2.20.1
