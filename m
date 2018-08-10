Received: from eggs.gnu.org ([2001:4830:134:3::10]:41661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fo2Lx-0004hN-CT
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fo2Lt-0007at-G9
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:00:57 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:57481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fo2Lt-0007Zl-84
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:00:53 -0400
Received: from player728.ha.ovh.net (unknown [10.109.159.222])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id F1C7BC3ED2
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 10:00:50 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 10 Aug 2018 10:00:26 +0200
Message-Id: <20180810080026.19398-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr_pci: factorize the use of
 SPAPR_MACHINE_GET_CLASS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

It should save us some CPU cycles as these routines perform a lot of
checks.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 3791ced6c536..5cd676e4430d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -267,6 +267,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
                                 target_ulong args, uint32_t nret,
                                 target_ulong rets)
 {
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     uint32_t config_addr =3D rtas_ld(args, 0);
     uint64_t buid =3D rtas_ldq(args, 1);
     unsigned int func =3D rtas_ld(args, 3);
@@ -334,7 +335,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
             return;
         }
=20
-        if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+        if (!smc->legacy_irq_allocation) {
             spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
         }
         spapr_irq_free(spapr, msi->first_irq, msi->num);
@@ -375,7 +376,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
     }
=20
     /* Allocate MSIs */
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+    if (smc->legacy_irq_allocation) {
         irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D RTAS=
_TYPE_MSI,
                              &err);
     } else {
@@ -401,7 +402,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
=20
     /* Release previous MSIs */
     if (msi) {
-        if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+        if (!smc->legacy_irq_allocation) {
             spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
         }
         spapr_irq_free(spapr, msi->first_irq, msi->num);
@@ -1558,6 +1559,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     sPAPRMachineState *spapr =3D
         (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
     sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
@@ -1575,7 +1577,6 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     }
=20
     if (sphb->index !=3D (uint32_t)-1) {
-        sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
         Error *local_err =3D NULL;
=20
         smc->phb_placement(spapr, sphb->index,
@@ -1720,7 +1721,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
         uint32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS =
+ i;
         Error *local_err =3D NULL;
=20
-        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+        if (smc->legacy_irq_allocation) {
             irq =3D spapr_irq_findone(spapr, &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
--=20
2.17.1
