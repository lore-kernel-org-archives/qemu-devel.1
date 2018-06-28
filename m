Received: from eggs.gnu.org ([2001:4830:134:3::10]:37505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYSQW-0004H5-4d
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYSQS-0003r3-5w
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:37:16 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:33692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fYSQR-0003q6-Si
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:37:12 -0400
Received: from player158.ha.ovh.net (unknown [10.109.120.49])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 0424E130D3
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 10:37:09 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 28 Jun 2018 10:36:33 +0200
Message-Id: <20180628083633.12413-3-clg@kaod.org>
In-Reply-To: <20180628083633.12413-1-clg@kaod.org>
References: <20180628083633.12413-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] ppc/pnv: make the PHB3 devices user
 creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Extra PHB3 devices and PCI devices can now be added to the powernv
machine using such a command:

  -device pnv-phb3,chip-id=3D0,index=3D1,id=3Dphb-0.1 \
  -device nec-usb-xhci,bus=3Dpci.1,addr=3D0x7

The 'index' property identifies the PHB3 in the chip and 'chip-id' the
chip it belongs to. The PHB3 identifier property name is changed to
'index' to match the attribute name of the pci-root device used by
libvirt for sPAPR machines.

One problem we have to solve when devices are created on the command
line is the object parenthood. The powernv machine uses the object
hierarchy to populate the device tree and each device should be
parented to the chip it belongs to. This is not the case for user
created device which are parented to the container "/unattached". The
changes below make sure PHB3 device is parented to its chip by
reparenting the object if necessary.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/pci-host/pnv_phb3.h |  2 ++
 hw/pci-host/pnv_phb3.c         | 25 ++++++++++++++++++++++++-
 hw/pci-host/pnv_phb3_pbcq.c    | 11 +++++++++++
 hw/ppc/pnv.c                   | 17 +++--------------
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/include/hw/pci-host/pnv_phb3.h b/include/hw/pci-host/pnv_phb=
3.h
index 459994b751ca..6e328183f9e0 100644
--- a/include/hw/pci-host/pnv_phb3.h
+++ b/include/hw/pci-host/pnv_phb3.h
@@ -146,6 +146,8 @@ struct PnvPHB3 {
     PnvPBCQState pbcq;
=20
     QLIST_HEAD(, PnvPhb3DMASpace) dma_spaces;
+
+    PnvChip *chip;
 };
=20
 #define TYPE_PNV_PHB3_RC "pnv-phb3-rc"
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index e11993e0e1fb..c5e9bd8a23af 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -970,6 +970,16 @@ static void pnv_phb3_pci_create(PnvPHB3 *phb, Error =
**errp)
     qdev_init_nofail(DEVICE(brdev));
 }
=20
+static void pnv_phb3_parent_fixup(Object *obj, Object *parent, Error **e=
rrp)
+{
+    if (obj->parent !=3D parent) {
+        object_ref(obj);
+        object_unparent(obj);
+        object_property_add_child(parent, DEVICE(obj)->id, obj, errp);
+        object_unref(obj);
+    }
+}
+
 static void pnv_phb3_realize(DeviceState *dev, Error **errp)
 {
     PnvPHB3 *phb =3D PNV_PHB3(dev);
@@ -978,6 +988,17 @@ static void pnv_phb3_realize(DeviceState *dev, Error=
 **errp)
     Error *local_err =3D NULL;
     int i;
=20
+    /*
+     * PHB3 devices created on the command line are not parented to
+     * the chip. Make sure they are because this is necessary to build
+     * correctly the device tree.
+     */
+    pnv_phb3_parent_fixup(OBJECT(phb), OBJECT(phb->chip), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     memory_region_init(&phb->pci_mmio, OBJECT(phb), "pci-mmio",
                        PCI_MMIO_TOTAL_SIZE);
=20
@@ -1138,6 +1159,7 @@ static void pnv_phb3_set_chip_id(Object *obj, Visit=
or *v, const char *name,
         return;
     }
=20
+    phb->chip =3D chip;
     phb->chip_id =3D chip_id;
 }
=20
@@ -1148,7 +1170,7 @@ static const PropertyInfo pnv_phb3_chip_id_propinfo=
 =3D {
 };
=20
 static Property pnv_phb3_properties[] =3D {
-    DEFINE_PROP("phb-id", PnvPHB3, phb_id, pnv_phb3_phb_id_propinfo,
+    DEFINE_PROP("index", PnvPHB3, phb_id, pnv_phb3_phb_id_propinfo,
                 uint32_t),
     DEFINE_PROP("chip-id", PnvPHB3, chip_id, pnv_phb3_chip_id_propinfo,
                 uint32_t),
@@ -1164,6 +1186,7 @@ static void pnv_phb3_class_init(ObjectClass *klass,=
 void *data)
     dc->realize =3D pnv_phb3_realize;
     dc->props =3D pnv_phb3_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->user_creatable =3D true;
 }
=20
 static const TypeInfo pnv_phb3_type_info =3D {
diff --git a/hw/pci-host/pnv_phb3_pbcq.c b/hw/pci-host/pnv_phb3_pbcq.c
index 34df3ac684e4..403c228a2380 100644
--- a/hw/pci-host/pnv_phb3_pbcq.c
+++ b/hw/pci-host/pnv_phb3_pbcq.c
@@ -285,6 +285,17 @@ static void pnv_pbcq_realize(DeviceState *dev, Error=
 **errp)
     pnv_xscom_region_init(&pbcq->xscom_spci_regs, OBJECT(dev),
                           &pnv_pbcq_spci_xscom_ops, pbcq, name,
                           PNV_XSCOM_PBCQ_SPCI_SIZE);
+
+    /* Populate the XSCOM address space. */
+    pnv_xscom_add_subregion(phb->chip,
+                            PNV_XSCOM_PBCQ_NEST_BASE + 0x400 * phb->phb_=
id,
+                            &pbcq->xscom_nest_regs);
+    pnv_xscom_add_subregion(phb->chip,
+                            PNV_XSCOM_PBCQ_PCI_BASE + 0x400 * phb->phb_i=
d,
+                            &pbcq->xscom_pci_regs);
+    pnv_xscom_add_subregion(phb->chip,
+                            PNV_XSCOM_PBCQ_SPCI_BASE + 0x040 * phb->phb_=
id,
+                            &pbcq->xscom_spci_regs);
 }
=20
 static int pnv_pbcq_dt_xscom(PnvXScomInterface *dev, void *fdt,
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 77e92d5e2e66..83e81b9ae470 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -834,9 +834,8 @@ static void pnv_chip_power8_realize(DeviceState *dev,=
 Error **errp)
     /* Create the PHB3 controllers */
     for (i =3D 0; i < pcc->num_phbs; i++) {
         PnvPHB3 *phb =3D &chip8->phbs[i];
-        PnvPBCQState *pbcq =3D &phb->pbcq;
=20
-        object_property_set_int(OBJECT(phb), i, "phb-id", &error_fatal);
+        object_property_set_int(OBJECT(phb), i, "index", &error_fatal);
         object_property_set_int(OBJECT(phb), chip->chip_id, "chip-id",
                                 &error_fatal);
         object_property_set_bool(OBJECT(phb), true, "realized", &local_e=
rr);
@@ -845,17 +844,6 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
             return;
         }
         qdev_set_parent_bus(DEVICE(phb), sysbus_get_default());
-
-        /* Populate the XSCOM address space. */
-        pnv_xscom_add_subregion(chip,
-                                PNV_XSCOM_PBCQ_NEST_BASE + 0x400 * phb->=
phb_id,
-                                &pbcq->xscom_nest_regs);
-        pnv_xscom_add_subregion(chip,
-                                PNV_XSCOM_PBCQ_PCI_BASE + 0x400 * phb->p=
hb_id,
-                                &pbcq->xscom_pci_regs);
-        pnv_xscom_add_subregion(chip,
-                                PNV_XSCOM_PBCQ_SPCI_BASE + 0x040 * phb->=
phb_id,
-                                &pbcq->xscom_spci_regs);
     }
 }
=20
@@ -886,7 +874,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
     k->chip_type =3D PNV_CHIP_POWER8;
     k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
     k->cores_mask =3D POWER8_CORE_MASK;
-    k->num_phbs =3D 3;
+    k->num_phbs =3D 1;
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->isa_create =3D pnv_chip_power8_isa_create;
@@ -1248,6 +1236,7 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
     xic->ics_get =3D pnv_ics_get;
     xic->ics_resend =3D pnv_ics_resend;
     ispc->print_info =3D pnv_pic_print_info;
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB3);
=20
     pnv_machine_class_props_init(oc);
 }
--=20
2.13.6
