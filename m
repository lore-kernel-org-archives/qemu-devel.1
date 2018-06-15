Received: from eggs.gnu.org ([2001:4830:134:3::10]:52733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTnIi-0007wc-Ht
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTnIf-0000l7-EY
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:53:56 -0400
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:51403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTnIf-0000kk-4d
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:53:53 -0400
Received: from player734.ha.ovh.net (unknown [10.109.120.106])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6A706164762
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 13:53:51 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Jun 2018 13:53:03 +0200
Message-Id: <20180615115303.31125-4-clg@kaod.org>
In-Reply-To: <20180615115303.31125-1-clg@kaod.org>
References: <20180615115303.31125-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] spapr: introduce a fixed IRQ number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This proposal introduces a new IRQ number space layout using static
numbers for all devices and a bitmap allocator for the MSI numbers
which are negotiated by the guest at runtime.

The previous layout is kept in machines raising the 'xics_legacy'
flag.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h     |  4 ++++
 include/hw/ppc/spapr_irq.h | 30 ++++++++++++++++++++++++
 hw/ppc/spapr.c             | 31 +++++++++++++++++++++++++
 hw/ppc/spapr_events.c      | 12 ++++++++--
 hw/ppc/spapr_irq.c         | 57 ++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_pci.c         | 28 ++++++++++++++++++-----
 hw/ppc/spapr_vio.c         | 15 ++++++++----
 hw/ppc/Makefile.objs       |  2 +-
 8 files changed, 166 insertions(+), 13 deletions(-)
 create mode 100644 include/hw/ppc/spapr_irq.h
 create mode 100644 hw/ppc/spapr_irq.c

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 49cda04b1493..094c7780130e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -7,6 +7,7 @@
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
+#include "hw/ppc/spapr_irq.h"
=20
 struct VIOsPAPRBus;
 struct sPAPRPHBState;
@@ -164,6 +165,9 @@ struct sPAPRMachineState {
     char *kvm_type;
=20
     const char *icp_type;
+    bool xics_legacy;
+    int32_t irq_map_nr;
+    unsigned long *irq_map;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     sPAPRCapabilities def, eff, mig;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
new file mode 100644
index 000000000000..07e36d1c7e74
--- /dev/null
+++ b/include/hw/ppc/spapr_irq.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU PowerPC sPAPR IRQ backend definitions
+ *
+ * Copyright (c) 2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+#ifndef HW_SPAPR_IRQ_H
+#define HW_SPAPR_IRQ_H
+
+/*
+ * IRQ ranges per type
+ */
+#define SPAPR_IRQ_EPOW       0x1000  /* XICS_IRQ_BASE offset */
+#define SPAPR_IRQ_HOTPLUG    0x1001
+#define SPAPR_IRQ_VIO        0x1040
+#define SPAPR_IRQ_PCI_LSI    0x1080
+
+#define SPAPR_IRQ_MSI        0x1100  /* Offset of the dynamic range cove=
red
+                                      * by the bitmap allocator */
+
+void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_irqs,
+                       Error **errp);
+int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uint32_t num, bool ali=
gn,
+                        Error **errp);
+void spapr_irq_msi_free(sPAPRMachineState *spapr, int irq, uint32_t num)=
;
+void spapr_irq_msi_reset(sPAPRMachineState *spapr);
+
+#endif
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c464951747e3..32aa5d869d9c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -187,6 +187,11 @@ static void xics_system_init(MachineState *machine, =
int nr_irqs, Error **errp)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
=20
+    /* Initialize the MSI IRQ allocator. */
+    if (!spapr->xics_legacy) {
+        spapr_irq_msi_init(spapr, nr_irqs, &error_fatal);
+    }
+
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
             !xics_kvm_init(spapr, errp)) {
@@ -1629,6 +1634,10 @@ static void spapr_machine_reset(void)
         ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fata=
l);
     }
=20
+    if (!spapr->xics_legacy) {
+        spapr_irq_msi_reset(spapr);
+    }
+
     qemu_devices_reset();
=20
     /* DRC reset may cause a device to be unplugged. This will cause tro=
ubles
@@ -1903,6 +1912,24 @@ static const VMStateDescription vmstate_spapr_patb=
_entry =3D {
     },
 };
=20
+static bool spapr_irq_map_needed(void *opaque)
+{
+    sPAPRMachineState *spapr =3D opaque;
+
+    return spapr->irq_map && !bitmap_empty(spapr->irq_map, spapr->irq_ma=
p_nr);
+}
+
+static const VMStateDescription vmstate_spapr_irq_map =3D {
+    .name =3D "spapr_irq_map",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D spapr_irq_map_needed,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_BITMAP(irq_map, sPAPRMachineState, 0, irq_map_nr),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr =3D {
     .name =3D "spapr",
     .version_id =3D 3,
@@ -1930,6 +1957,7 @@ static const VMStateDescription vmstate_spapr =3D {
         &vmstate_spapr_cap_cfpc,
         &vmstate_spapr_cap_sbbc,
         &vmstate_spapr_cap_ibs,
+        &vmstate_spapr_irq_map,
         NULL
     }
 };
@@ -4101,7 +4129,10 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
=20
 static void spapr_machine_2_12_instance_options(MachineState *machine)
 {
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
+
     spapr_machine_3_0_instance_options(machine);
+    spapr->xics_legacy =3D true;
 }
=20
 static void spapr_machine_2_12_class_options(MachineClass *mc)
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 3b6ae7272092..1ef7ce7f1509 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -709,7 +709,11 @@ void spapr_events_init(sPAPRMachineState *spapr)
 {
     int epow_irq;
=20
-    epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
+    if (spapr->xics_legacy) {
+        epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
+    } else {
+        epow_irq =3D SPAPR_IRQ_EPOW;
+    }
=20
     spapr_irq_claim(spapr, epow_irq, 1, false, &error_fatal);
=20
@@ -731,7 +735,11 @@ void spapr_events_init(sPAPRMachineState *spapr)
     if (spapr->use_hotplug_event_source) {
         int hp_irq;
=20
-        hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
+        if (spapr->xics_legacy) {
+            hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
+        } else {
+            hp_irq =3D SPAPR_IRQ_HOTPLUG;
+        }
=20
         spapr_irq_claim(spapr, hp_irq, 1, false, &error_fatal);
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
new file mode 100644
index 000000000000..55fa764c85d1
--- /dev/null
+++ b/hw/ppc/spapr_irq.c
@@ -0,0 +1,57 @@
+/*
+ * QEMU PowerPC sPAPR IRQ interface
+ *
+ * Copyright (c) 2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/xics.h"
+
+void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_irqs,
+                        Error **errp)
+{
+    spapr->irq_map_nr =3D XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ_MSI;
+    spapr->irq_map =3D bitmap_new(spapr->irq_map_nr);
+}
+
+int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uint32_t num, bool ali=
gn,
+                        Error **errp)
+{
+    int irq;
+
+    /*
+     * The 'align_mask' parameter of bitmap_find_next_zero_area()
+     * should be one less than a power of 2; 0 means no
+     * alignment. Adapt the 'align' value of the former allocator
+     * to fit the requirements of bitmap_find_next_zero_area()
+     */
+    align -=3D 1;
+
+    irq =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->irq_map_nr=
, 0, num,
+                                     align);
+    if (irq =3D=3D spapr->irq_map_nr) {
+        error_setg(errp, "can't find a free %d-IRQ block", num);
+        return -1;
+    }
+
+    bitmap_set(spapr->irq_map, irq, num);
+
+    return irq + SPAPR_IRQ_MSI;
+}
+
+void spapr_irq_msi_free(sPAPRMachineState *spapr, int irq, uint32_t num)
+{
+    bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
+}
+
+void spapr_irq_msi_reset(sPAPRMachineState *spapr)
+{
+    bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
+}
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7394c62b4a8b..f3c4a25fb482 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -333,6 +333,9 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
             return;
         }
=20
+        if (!spapr->xics_legacy) {
+            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
+        }
         spapr_irq_free(spapr, msi->first_irq, msi->num);
         if (msi_present(pdev)) {
             spapr_msi_setmsg(pdev, 0, false, 0, 0);
@@ -371,7 +374,13 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
     }
=20
     /* Allocate MSIs */
-    irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D RTAS_TYP=
E_MSI, &err);
+    if (spapr->xics_legacy) {
+        irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D RTAS=
_TYPE_MSI,
+                             &err);
+    } else {
+        irq =3D spapr_irq_msi_alloc(spapr, req_num,
+                                  ret_intr_type =3D=3D RTAS_TYPE_MSI, &e=
rr);
+    }
     if (err) {
         error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                           config_addr);
@@ -388,6 +397,9 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
=20
     /* Release previous MSIs */
     if (msi) {
+        if (!spapr->xics_legacy) {
+            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
+        }
         spapr_irq_free(spapr, msi->first_irq, msi->num);
         g_hash_table_remove(phb->msi, &config_addr);
     }
@@ -1704,11 +1716,15 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
         uint32_t irq;
         Error *local_err =3D NULL;
=20
-        irq =3D spapr_irq_findone(spapr, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            error_prepend(errp, "can't allocate LSIs: ");
-            return;
+        if (spapr->xics_legacy) {
+            irq =3D spapr_irq_findone(spapr, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                error_prepend(errp, "can't allocate LSIs: ");
+                return;
+            }
+        } else {
+            irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
         }
=20
         spapr_irq_claim(spapr, irq, 1, true, &local_err);
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index ad9b56e28447..7707bda6a38d 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -436,6 +436,9 @@ static void spapr_vio_busdev_reset(DeviceState *qdev)
     }
 }
=20
+/* TODO : poor VIO device indexing ... */
+static uint32_t vio_index;
+
 static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
@@ -476,10 +479,14 @@ static void spapr_vio_busdev_realize(DeviceState *q=
dev, Error **errp)
     }
=20
     if (!dev->irq) {
-        dev->irq =3D spapr_irq_findone(spapr, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
+        if (spapr->xics_legacy) {
+            dev->irq =3D spapr_irq_findone(spapr, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+        } else {
+            dev->irq =3D SPAPR_IRQ_VIO + vio_index++;
         }
     }
=20
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 86d82a6ec3ac..4fe3b7804d43 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -4,7 +4,7 @@ obj-y +=3D ppc.o ppc_booke.o fdt.o
 obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events=
.o
 obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
 obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng=
.o
-obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
+obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
--=20
2.13.6
