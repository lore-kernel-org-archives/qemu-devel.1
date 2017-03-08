Received: from eggs.gnu.org ([2001:4830:134:3::10]:37142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDp-0007t5-CR
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDm-0003Bg-57
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:33 -0500
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:58745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1clZDl-0003BK-Rw
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:30 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id B6D7C33BF9
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 11:53:28 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  8 Mar 2017 11:52:50 +0100
Message-Id: <1488970371-8865-8-git-send-email-clg@kaod.org>
In-Reply-To: <1488970371-8865-1-git-send-email-clg@kaod.org>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.10 7/8] ppc/pnv: Add OCC model stub with
 interrupt support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The OCC is an on-chip microcontroller based on a ppc405 core used
for various power management tasks. It comes with a pile of additional
hardware sitting on the PIB (aka XSCOM bus). At this point we don't
emulate it (nor plan to do so). However there is one facility which
is provided by the surrounding hardware that we do need, which is the
interrupt generation facility. OPAL uses it to send itself interrupts
under some circumstances and there are other uses around the corner.

So this implement just enough to support this.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[clg: - updated for qemu-2.9
      - changed the XSCOM interface to fit new model
      - QOMified the model ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/Makefile.objs       |   2 +-
 hw/ppc/pnv.c               |  10 ++++
 hw/ppc/pnv_occ.c           | 136 +++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/pnv.h       |   2 +
 include/hw/ppc/pnv_occ.h   |  38 +++++++++++++
 include/hw/ppc/pnv_xscom.h |   3 +
 6 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/pnv_occ.c
 create mode 100644 include/hw/ppc/pnv_occ.h

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index dc19ee17fa57..ef67ea820158 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -6,7 +6,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o sp=
apr_rtas.o
 obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng=
.o
 obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
 # IBM PowerNV
-obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o
+obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
 obj-y +=3D spapr_pci_vfio.o
 endif
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 85b00bf235c6..ca5a078bc6c6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -714,6 +714,11 @@ static void pnv_chip_init(Object *obj)
     object_property_add_child(obj, "psi", OBJECT(&chip->psi), NULL);
     object_property_add_const_link(OBJECT(&chip->psi), "xics",
                                    OBJECT(qdev_get_machine()), &error_ab=
ort);
+
+    object_initialize(&chip->occ, sizeof(chip->occ), TYPE_PNV_OCC);
+    object_property_add_child(obj, "occ", OBJECT(&chip->occ), NULL);
+    object_property_add_const_link(OBJECT(&chip->occ), "psi",
+                                   OBJECT(&chip->psi), &error_abort);
 }
=20
 static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
@@ -824,6 +829,11 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
     object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
                              &error_fatal);
     pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xscom_r=
egs);
+
+    /* Create the simplified OCC model */
+    object_property_set_bool(OBJECT(&chip->occ), true, "realized",
+                             &error_fatal);
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip->occ.xscom_r=
egs);
 }
=20
 static Property pnv_chip_properties[] =3D {
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
new file mode 100644
index 000000000000..32f167b77ea3
--- /dev/null
+++ b/hw/ppc/pnv_occ.c
@@ -0,0 +1,136 @@
+/*
+ * QEMU PowerNV Emulation of a few OCC related registers
+ *
+ * Copyright (c) 2016, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "sysemu/sysemu.h"
+#include "target/ppc/cpu.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_occ.h"
+
+#define OCB_OCI_OCCMISC         0x4020
+#define OCB_OCI_OCCMISC_AND     0x4021
+#define OCB_OCI_OCCMISC_OR      0x4022
+
+static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
+{
+    bool irq_state;
+
+    val &=3D 0xffff000000000000ull;
+
+    occ->occmisc =3D val;
+    irq_state =3D !!(val >> 63);
+    pnv_psi_irq_set(occ->psi, PSIHB_IRQ_OCC, irq_state);
+}
+
+static uint64_t pnv_occ_xscom_read(void *opaque, hwaddr addr, unsigned s=
ize)
+{
+    PnvOCC *occ =3D PNV_OCC(opaque);
+    uint32_t offset =3D addr >> 3;
+    uint64_t val =3D 0;
+
+    switch (offset) {
+    case OCB_OCI_OCCMISC:
+        val =3D occ->occmisc;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
+                      HWADDR_PRIx "\n", addr);
+    }
+    return val;
+}
+
+static void pnv_occ_xscom_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
+{
+    PnvOCC *occ =3D PNV_OCC(opaque);
+    uint32_t offset =3D addr >> 3;
+
+    switch (offset) {
+    case OCB_OCI_OCCMISC_AND:
+        pnv_occ_set_misc(occ, occ->occmisc & val);
+        break;
+    case OCB_OCI_OCCMISC_OR:
+        pnv_occ_set_misc(occ, occ->occmisc | val);
+        break;
+    case OCB_OCI_OCCMISC:
+        pnv_occ_set_misc(occ, val);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
+                      HWADDR_PRIx "\n", addr);
+    }
+}
+
+static const MemoryRegionOps pnv_occ_xscom_ops =3D {
+    .read =3D pnv_occ_xscom_read,
+    .write =3D pnv_occ_xscom_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+
+static void pnv_occ_realize(DeviceState *dev, Error **errp)
+{
+    PnvOCC *occ =3D PNV_OCC(dev);
+    Object *obj;
+    Error *error =3D NULL;
+
+    occ->occmisc =3D 0;
+
+    /* get PSI object from chip */
+    obj =3D object_property_get_link(OBJECT(dev), "psi", &error);
+    if (!obj) {
+        error_setg(errp, "%s: required link 'psi' not found: %s",
+                   __func__, error_get_pretty(error));
+        return;
+    }
+    occ->psi =3D PNV_PSI(obj);
+
+    /* XScom region for OCC registers */
+    pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), &pnv_occ_xscom_=
ops,
+                  occ, "xscom-occ", PNV_XSCOM_OCC_SIZE);
+}
+
+static void pnv_occ_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D pnv_occ_realize;
+}
+
+static const TypeInfo pnv_occ_type_info =3D {
+    .name          =3D TYPE_PNV_OCC,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(PnvOCC),
+    .class_init    =3D pnv_occ_class_init,
+};
+
+static void pnv_occ_register_types(void)
+{
+    type_register_static(&pnv_occ_type_info);
+}
+
+type_init(pnv_occ_register_types)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f93ec32603b7..481f276699fa 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -24,6 +24,7 @@
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/xics.h"
 #include "hw/ppc/pnv_psi.h"
+#include "hw/ppc/pnv_occ.h"
=20
 #define TYPE_PNV_CHIP "powernv-chip"
 #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
@@ -60,6 +61,7 @@ typedef struct PnvChip {
=20
     PnvLpcController lpc;
     PnvPsi       psi;
+    PnvOCC       occ;
 } PnvChip;
=20
 typedef struct PnvChipClass {
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
new file mode 100644
index 000000000000..94c9b6fe1384
--- /dev/null
+++ b/include/hw/ppc/pnv_occ.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU PowerNV Emulation of a few OCC related registers
+ *
+ * Copyright (c) 2016, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ */
+#ifndef _PPC_PNV_OCC_H
+#define _PPC_PNV_OCC_H
+
+#define TYPE_PNV_OCC "pnv-occ"
+#define PNV_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV_OCC)
+
+typedef struct PnvPsi PnvPsi;
+
+typedef struct PnvOCC {
+    DeviceState xd;
+
+    /* OCC Misc interrupt */
+    uint64_t occmisc;
+
+    PnvPsi *psi;
+
+    MemoryRegion xscom_regs;
+} PnvOCC;
+
+#endif /* _PPC_PNV_OCC_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 2938abd74955..226ff61900de 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -63,6 +63,9 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_PSI_BASE        0x2010900
 #define PNV_XSCOM_PSI_SIZE        0x20
=20
+#define PNV_XSCOM_OCC_BASE        0x0066000
+#define PNV_XSCOM_OCC_SIZE        0x6000
+
 extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
 extern int pnv_xscom_populate(PnvChip *chip, void *fdt, int offset);
=20
--=20
2.7.4
