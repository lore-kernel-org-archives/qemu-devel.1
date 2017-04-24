Received: from eggs.gnu.org ([2001:4830:134:3::10]:56656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TII-0001di-L8
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIG-0003Vh-Vu
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:02 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:22 +1000
Message-Id: <20170424015927.8933-43-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 42/47] ppc/pnv: add initial IPMI sensors for the
 BMC simulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Skiboot, the firmware for the PowerNV platform, expects the BMC to
provide some specific IPMI sensors. These sensors are exposed in the
device tree and their values are updated by the firmware at boot time.

Sensors of interest are :

	"FW Boot Progress"
	"Boot Count"

As such a device is defined on the command line, we can only detect
its presence at reset time.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/Makefile.objs |  2 +-
 hw/ppc/pnv.c         | 21 ++++++++++++++
 hw/ppc/pnv_bmc.c     | 81 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/pnv.h |  9 ++++++
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/pnv_bmc.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index ef67ea8..7efc686 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -6,7 +6,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o sp=
apr_rtas.o
 obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng=
.o
 obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
 # IBM PowerNV
-obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o
+obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
 obj-y +=3D spapr_pci_vfio.o
 endif
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 977e126..685eb12 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -35,6 +35,7 @@
 #include "qapi/visitor.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
+#include "hw/ipmi/ipmi.h"
=20
 #include "hw/ppc/xics.h"
 #include "hw/ppc/pnv_xscom.h"
@@ -476,16 +477,36 @@ static void *powernv_create_fdt(MachineState *machi=
ne)
     /* Populate ISA devices on chip 0 */
     lpc_offset =3D pnv_chip_lpc_offset(pnv->chips[0], fdt);
     powernv_populate_isa(pnv->isa_bus, fdt, lpc_offset);
+
+    if (pnv->bmc) {
+        pnv_bmc_populate_sensors(pnv->bmc, fdt);
+    }
+
     return fdt;
 }
=20
 static void ppc_powernv_reset(void)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
+    PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
     void *fdt;
+    Object *obj;
=20
     qemu_devices_reset();
=20
+    /* OpenPOWER systems have a BMC, which can be defined on the
+     * command line with:
+     *
+     *   -device ipmi-bmc-sim,id=3Dbmc0
+     *
+     * This is the internal simulator but it could also be an external
+     * BMC.
+     */
+    obj =3D object_resolve_path_type("", TYPE_IPMI_BMC, NULL);
+    if (obj) {
+        pnv->bmc =3D IPMI_BMC(obj);
+    }
+
     fdt =3D powernv_create_fdt(machine);
=20
     /* Pack resulting tree */
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
new file mode 100644
index 0000000..a0820dc
--- /dev/null
+++ b/hw/ppc/pnv_bmc.c
@@ -0,0 +1,81 @@
+/*
+ * QEMU PowerNV, BMC related functions
+ *
+ * Copyright (c) 2016-2017, IBM Corporation.
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
+#include "hw/ipmi/ipmi.h"
+#include "hw/ppc/fdt.h"
+
+#include "hw/ppc/pnv.h"
+
+#include <libfdt.h>
+
+/* TODO: include definition in ipmi.h */
+#define IPMI_SDR_FULL_TYPE 1
+
+void pnv_bmc_populate_sensors(IPMIBmc *bmc, void *fdt)
+{
+    int offset;
+    int i;
+    const struct ipmi_sdr_compact *sdr;
+    uint16_t nextrec;
+
+    offset =3D fdt_add_subnode(fdt, 0, "/bmc");
+    _FDT(offset);
+
+    _FDT((fdt_setprop_string(fdt, offset, "name", "bmc")));
+    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
+    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
+
+    offset =3D fdt_add_subnode(fdt, offset, "sensors");
+    _FDT(offset);
+
+    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
+    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
+
+    for (i =3D 0; !ipmi_bmc_sdr_find(bmc, i, &sdr, &nextrec); i++) {
+        int off;
+        char *name;
+
+        if (sdr->header.rec_type !=3D IPMI_SDR_COMPACT_TYPE &&
+            sdr->header.rec_type !=3D IPMI_SDR_FULL_TYPE) {
+            continue;
+        }
+
+        name =3D g_strdup_printf("sensor@%x", sdr->sensor_owner_number);
+        off =3D fdt_add_subnode(fdt, offset, name);
+        _FDT(off);
+        g_free(name);
+
+        _FDT((fdt_setprop_cell(fdt, off, "reg", sdr->sensor_owner_number=
)));
+        _FDT((fdt_setprop_string(fdt, off, "name", "sensor")));
+        _FDT((fdt_setprop_string(fdt, off, "compatible", "ibm,ipmi-senso=
r")));
+        _FDT((fdt_setprop_cell(fdt, off, "ipmi-sensor-reading-type",
+                               sdr->reading_type)));
+        _FDT((fdt_setprop_cell(fdt, off, "ipmi-entity-id",
+                               sdr->entity_id)));
+        _FDT((fdt_setprop_cell(fdt, off, "ipmi-entity-instance",
+                               sdr->entity_instance)));
+        _FDT((fdt_setprop_cell(fdt, off, "ipmi-sensor-type",
+                               sdr->sensor_type)));
+    }
+}
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index b45a0d9..02f6cf5 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -118,6 +118,8 @@ typedef struct PnvChipClass {
 #define POWERNV_MACHINE(obj) \
     OBJECT_CHECK(PnvMachineState, (obj), TYPE_POWERNV_MACHINE)
=20
+typedef struct IPMIBmc IPMIBmc;
+
 typedef struct PnvMachineState {
     /*< private >*/
     MachineState parent_obj;
@@ -130,12 +132,19 @@ typedef struct PnvMachineState {
=20
     ISABus       *isa_bus;
     uint32_t     cpld_irqstate;
+
+    IPMIBmc      *bmc;
 } PnvMachineState;
=20
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
=20
 /*
+ * BMC helpers
+ */
+void pnv_bmc_populate_sensors(IPMIBmc *bmc, void *fdt);
+
+/*
  * POWER8 MMIO base addresses
  */
 #define PNV_XSCOM_SIZE        0x800000000ull
--=20
2.9.3
