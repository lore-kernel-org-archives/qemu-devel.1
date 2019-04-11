Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11802C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 08:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8ACC2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 08:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ACC2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43602 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEUiA-0002m0-UC
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 04:05:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUdu-0007q5-Jr
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUds-0008Ez-LC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:06 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:42532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEUdq-0008DT-MK
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:03 -0400
Received: from player779.ha.ovh.net (unknown [10.109.143.72])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 70B04FD94A
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 10:01:00 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
	[86.201.133.22]) (Authenticated sender: clg@kaod.org)
	by player779.ha.ovh.net (Postfix) with ESMTPSA id 871A648B8CEF;
	Thu, 11 Apr 2019 08:00:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 Apr 2019 10:00:01 +0200
Message-Id: <20190411080004.8690-4-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411080004.8690-1-clg@kaod.org>
References: <20190411080004.8690-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 17598941447023725542
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.44
Subject: [Qemu-devel] [PATCH 3/6] ppc/hash64: Rework R and C bit updates
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411080001.qwUxqrWBTamXmywSiW8MEQDiIyb2pOxDFDQ9jItXpw8@z>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

With MT-TCG, we are now running translation in a racy way, thus
we need to mimic hardware when it comes to updating the R and
C bits, by doing byte stores.

The current "store_hpte" abstraction is ill suited for this, we
replace it with two separate callbacks for setting R and C.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h  |  2 ++
 target/ppc/cpu.h        |  4 +--
 target/ppc/mmu-hash64.h |  2 --
 hw/ppc/spapr.c          | 41 +++++++++++++++++++---
 hw/ppc/spapr_hcall.c    | 13 +++----
 target/ppc/mmu-hash64.c | 76 ++++++++++++++++++++++++-----------------
 6 files changed, 93 insertions(+), 45 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9331f5e0b955..7e32f309c2be 100644
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
index 07cea7268c0c..a4420636dde0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1268,8 +1268,8 @@ struct PPCVirtualHypervisorClass {
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
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 6b555b72200f..bc362964122d 100644
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
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b81e237635cd..c56939a43b64 100644
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
index 7761d4a841af..a27c9a01aa97 100644
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
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 8956ad55d96f..b4a27d46e382 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -724,6 +724,39 @@ static void ppc_hash64_set_dsi(CPUState *cs, uint64_=
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
@@ -734,7 +767,6 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
     hwaddr ptex;
     ppc_hash_pte64_t pte;
     int exec_prot, pp_prot, amr_prot, prot;
-    uint64_t new_pte1;
     const int need_prot[] =3D {PAGE_READ, PAGE_WRITE, PAGE_EXEC};
     hwaddr raddr;
=20
@@ -882,19 +914,19 @@ skip_slb_search:
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
@@ -953,24 +985,6 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cp=
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
--=20
2.20.1


