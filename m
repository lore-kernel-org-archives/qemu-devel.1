Received: from eggs.gnu.org ([2001:4830:134:3::10]:56828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gws-0005NX-W7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwi-00083X-Oa
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:15 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:14 +1000
Message-Id: <20170426070034.10727-29-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/48] ppc/pnv: Add OCC model stub with
 interrupt support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/Makefile.objs       |   2 +-
 hw/ppc/pnv.c               |  13 +++++
 hw/ppc/pnv_occ.c           | 136 +++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/pnv.h       |   2 +
 include/hw/ppc/pnv_occ.h   |  38 +++++++++++++
 include/hw/ppc/pnv_xscom.h |   3 +
 6 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/pnv_occ.c
 create mode 100644 include/hw/ppc/pnv_occ.h

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index dc19ee1..ef67ea8 100644
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
index a516acb..16f32c9 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -694,6 +694,11 @@ static void pnv_chip_init(Object *obj)
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
@@ -816,6 +821,14 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE, &chip->psi.xscom=
_regs);
+
+    /* Create the simplified OCC model */
+    object_property_set_bool(OBJECT(&chip->occ), true, "realized", &erro=
r);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip->occ.xscom_r=
egs);
 }
=20
 static Property pnv_chip_properties[] =3D {
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
new file mode 100644
index 0000000..04880f2
--- /dev/null
+++ b/hw/ppc/pnv_occ.c
@@ -0,0 +1,136 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of a few OCC related registers
+ *
+ * Copyright (c) 2015-2017, IBM Corporation.
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
index a3ed2ee..b45a0d9 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -23,6 +23,7 @@
 #include "hw/sysbus.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_psi.h"
+#include "hw/ppc/pnv_occ.h"
=20
 #define TYPE_PNV_CHIP "powernv-chip"
 #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
@@ -59,6 +60,7 @@ typedef struct PnvChip {
=20
     PnvLpcController lpc;
     PnvPsi       psi;
+    PnvOCC       occ;
 } PnvChip;
=20
 typedef struct PnvChipClass {
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
new file mode 100644
index 0000000..f8ec330
--- /dev/null
+++ b/include/hw/ppc/pnv_occ.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of a few OCC related registers
+ *
+ * Copyright (c) 2015-2017, IBM Corporation.
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
index 15f7fdb..3757b2c 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -63,6 +63,9 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_PSIHB_BASE      0x2010900
 #define PNV_XSCOM_PSIHB_SIZE      0x20
=20
+#define PNV_XSCOM_OCC_BASE        0x0066000
+#define PNV_XSCOM_OCC_SIZE        0x6000
+
 extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
 extern int pnv_xscom_populate(PnvChip *chip, void *fdt, int offset);
=20
--=20
2.9.3
