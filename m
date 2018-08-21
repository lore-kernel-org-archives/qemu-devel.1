Received: from eggs.gnu.org ([2001:4830:134:3::10]:56667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMx-0004GW-JL
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMu-0000Sg-Ju
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:15 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:42 +1000
Message-Id: <20180821043343.7514-26-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/26] spapr_pci: factorize the use of
 SPAPR_MACHINE_GET_CLASS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

It should save us some CPU cycles as these routines perform a lot of
checks.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 3791ced6c5..5cd676e443 100644
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
