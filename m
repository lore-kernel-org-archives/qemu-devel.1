Received: from eggs.gnu.org ([209.51.188.92]:58427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlo-0005w6-8D
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUln-0003EY-7a
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:46 +1100
Message-Id: <20190226045304.25618-33-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/50] spapr/pci: Generate FDT fragment at
 configure connector time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059667346.1466090.326696113231137772.stgit@bahia.lab.toul=
ouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c          |  1 +
 hw/ppc/spapr_pci.c          | 19 ++++++++++++-------
 include/hw/pci-host/spapr.h |  4 +++-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index aa26aa40be..248eb8a93d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -691,6 +691,7 @@ static void spapr_drc_pci_class_init(ObjectClass *k, =
void *data)
     drck->typename =3D "28";
     drck->drc_name_prefix =3D "C";
     drck->release =3D spapr_phb_remove_pci_device_cb;
+    drck->dt_populate =3D spapr_pci_dt_populate;
 }
=20
 static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 60777b2355..b22c9f57b2 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1408,6 +1408,17 @@ static uint32_t spapr_phb_get_pci_drc_index(sPAPRP=
HBState *phb,
     return spapr_drc_index(drc);
 }
=20
+int spapr_pci_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+                          void *fdt, int *fdt_start_offset, Error **errp=
)
+{
+    HotplugHandler *plug_handler =3D qdev_get_hotplug_handler(drc->dev);
+    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(plug_handler);
+    PCIDevice *pdev =3D PCI_DEVICE(drc->dev);
+
+    *fdt_start_offset =3D spapr_create_pci_child_dt(sphb, pdev, fdt, 0);
+    return 0;
+}
+
 static void spapr_pci_plug(HotplugHandler *plug_handler,
                            DeviceState *plugged_dev, Error **errp)
 {
@@ -1417,8 +1428,6 @@ static void spapr_pci_plug(HotplugHandler *plug_han=
dler,
     Error *local_err =3D NULL;
     PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
     uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
-    void *fdt =3D NULL;
-    int fdt_start_offset, fdt_size;
=20
     /* if DR is disabled we don't need to do anything in the case of
      * hotplug or coldplug callbacks
@@ -1448,10 +1457,7 @@ static void spapr_pci_plug(HotplugHandler *plug_ha=
ndler,
         goto out;
     }
=20
-    fdt =3D create_device_tree(&fdt_size);
-    fdt_start_offset =3D spapr_create_pci_child_dt(phb, pdev, fdt, 0);
-
-    spapr_drc_attach(drc, DEVICE(pdev), fdt, fdt_start_offset, &local_er=
r);
+    spapr_drc_attach(drc, DEVICE(pdev), NULL, 0, &local_err);
     if (local_err) {
         goto out;
     }
@@ -1483,7 +1489,6 @@ static void spapr_pci_plug(HotplugHandler *plug_han=
dler,
 out:
     if (local_err) {
         error_propagate(errp, local_err);
-        g_free(fdt);
     }
 }
=20
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 51d81c4b7c..f6e43f48fe 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -121,8 +121,10 @@ sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState =
*spapr, uint64_t buid);
 PCIDevice *spapr_pci_find_dev(sPAPRMachineState *spapr, uint64_t buid,
                               uint32_t config_addr);
=20
-/* PCI release callback. */
+/* DRC callbacks */
 void spapr_phb_remove_pci_device_cb(DeviceState *dev);
+int spapr_pci_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+                          void *fdt, int *fdt_start_offset, Error **errp=
);
=20
 /* VFIO EEH hooks */
 #ifdef CONFIG_LINUX
--=20
2.20.1
