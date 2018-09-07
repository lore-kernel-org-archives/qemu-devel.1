Received: from eggs.gnu.org ([2001:4830:134:3::10]:45679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFW-0007cz-Hj
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFQ-00053H-JG
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:14 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  7 Sep 2018 17:31:44 +1000
Message-Id: <20180907073155.26200-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180907073155.26200-1-david@gibson.dropbear.id.au>
References: <20180907073155.26200-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/14] spapr_pci: fix potential NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, mark.cave-ayland@ilande.co.uk, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Commit 2c88b098e76fd added a call to SPAPR_MACHINE_GET_CLASS(spapr) in
spapr_phb_realize() before we check spapr isn't NULL. This causes QEMU
to crash when starting a non-pseries machine with a sPAPR PHB.

This could be fixed by setting the smc variable after the null check,
but it seems more explicit to use a ternary operator to skip the call
to SPAPR_MACHINE_GET_CLASS() if spapr is NULL, since spapr_phb_realize()
will return immediately in this case.

This was reported by Coverity (CID 1395170 and 1395183).

Fixes: 2c88b098e76fde0c7fcc0476dd3f80ce58409505
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5cd676e443..6bcb4f419b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1559,7 +1559,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     sPAPRMachineState *spapr =3D
         (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    sPAPRMachineClass *smc =3D spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : =
NULL;
     SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
     sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
--=20
2.17.1
