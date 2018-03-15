Received: from eggs.gnu.org ([2001:4830:134:3::10]:50128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ewT1V-0002y9-PG
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ewT1R-0001vP-SD
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:34:25 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:49685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ewT1R-0001uV-Ln
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:34:21 -0400
Received: from player734.ha.ovh.net (unknown [10.109.122.4])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 24EB3B3492
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 14:34:20 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 15 Mar 2018 13:33:59 +0000
Message-Id: <20180315133402.13470-2-clg@kaod.org>
In-Reply-To: <20180315133402.13470-1-clg@kaod.org>
References: <20180315133402.13470-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/4] target/ppc: export external HPT via
 virtual hypervisor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

commit e57ca75ce3b2 ("target/ppc: Manage external HPT via virtual
hypervisor") exported a set of methods to manipulate the HPT from the
core hash MMU but the base address of the HPT was not part of them and
SPR_SDR1 is still used under some circumstances, which is incorrect
for the sPAPR machines.

This is not a major change as only the logging should be impacted but
nevertheless, it will help to introduce support for the hash MMU on
POWER9 PowerNV machines.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c          | 8 ++++++++
 target/ppc/cpu.h        | 1 +
 target/ppc/mmu-hash64.h | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f1798457bc4d..2329664e0c2c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1327,6 +1327,13 @@ static hwaddr spapr_hpt_mask(PPCVirtualHypervisor =
*vhyp)
     return HTAB_SIZE(spapr) / HASH_PTEG_SIZE_64 - 1;
 }
=20
+static hwaddr spapr_hpt_base(PPCVirtualHypervisor *vhyp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
+
+    return (hwaddr) spapr->htab;
+}
+
 static target_ulong spapr_encode_hpt_for_kvm_pr(PPCVirtualHypervisor *vh=
yp)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
@@ -4073,6 +4080,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->phb_placement =3D spapr_phb_placement;
     vhc->hypercall =3D emulate_spapr_hypercall;
     vhc->hpt_mask =3D spapr_hpt_mask;
+    vhc->hpt_base =3D spapr_hpt_base;
     vhc->map_hptes =3D spapr_map_hptes;
     vhc->unmap_hptes =3D spapr_unmap_hptes;
     vhc->store_hpte =3D spapr_store_hpte;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7bde1884a142..4de0653a3984 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1258,6 +1258,7 @@ struct PPCVirtualHypervisorClass {
     InterfaceClass parent;
     void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
     hwaddr (*hpt_mask)(PPCVirtualHypervisor *vhyp);
+    hwaddr (*hpt_base)(PPCVirtualHypervisor *vhyp);
     const ppc_hash_pte64_t *(*map_hptes)(PPCVirtualHypervisor *vhyp,
                                          hwaddr ptex, int n);
     void (*unmap_hptes)(PPCVirtualHypervisor *vhyp,
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index d297b97d3773..0ade8d15d9e4 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -100,6 +100,11 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
=20
 static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
 {
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =3D
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        return vhc->hpt_base(cpu->vhyp);
+    }
     return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
 }
=20
--=20
2.13.6
