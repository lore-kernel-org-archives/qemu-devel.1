Received: from eggs.gnu.org ([2001:4830:134:3::10]:51279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICe-0004E3-Ov
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICa-0002qI-Hb
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:02:22 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:25 +1100
Message-Id: <20181213040126.6768-27-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/27] spapr/xive: introduce a XIVE interrupt
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

sPAPRXive models the XIVE interrupt controller of the sPAPR machine.
It inherits from the XiveRouter and provisions storage for the routing
tables :

  - Event Assignment Structure (EAS)
  - Event Notification Descriptor (END)

The sPAPRXive model incorporates an internal XiveSource for the IPIs
and for the interrupts of the virtual devices of the guest. This model
is consistent with XIVE architecture which also incorporates an
internal IVSE for IPIs and accelerator interrupts in the IVRE
sub-engine.

The sPAPRXive model exports two memory regions, one for the ESB
trigger and management pages used to control the sources and one for
the TIMA pages. They are mapped by default at the addresses found on
chip 0 of a baremetal system. This is also consistent with the XIVE
architecture which defines a Virtualization Controller BAR for the
internal IVSE ESB pages and a Thread Managment BAR for the TIMA.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc64-softmmu.mak |   1 +
 hw/intc/Makefile.objs             |   1 +
 hw/intc/spapr_xive.c              | 366 ++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_xive.h       |  45 ++++
 4 files changed, 413 insertions(+)
 create mode 100644 hw/intc/spapr_xive.c
 create mode 100644 include/hw/ppc/spapr_xive.h

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index 2d1e7c5c46..7f34ad0528 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -17,6 +17,7 @@ CONFIG_XICS=3D$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
 CONFIG_XIVE=3D$(CONFIG_PSERIES)
+CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
 CONFIG_MEM_DEVICE=3Dy
 CONFIG_DIMM=3Dy
 CONFIG_SPAPR_RNG=3Dy
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 72a46ed91c..301a8e972d 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -38,6 +38,7 @@ obj-$(CONFIG_XICS) +=3D xics.o
 obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
 obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
 obj-$(CONFIG_XIVE) +=3D xive.o
+obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
 obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
new file mode 100644
index 0000000000..eef5830d45
--- /dev/null
+++ b/hw/intc/spapr_xive.c
@@ -0,0 +1,366 @@
+/*
+ * QEMU PowerPC sPAPR XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "target/ppc/cpu.h"
+#include "sysemu/cpus.h"
+#include "monitor/monitor.h"
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_xive.h"
+#include "hw/ppc/xive.h"
+#include "hw/ppc/xive_regs.h"
+
+/*
+ * XIVE Virtualization Controller BAR and Thread Managment BAR that we
+ * use for the ESB pages and the TIMA pages
+ */
+#define SPAPR_XIVE_VC_BASE   0x0006010000000000ull
+#define SPAPR_XIVE_TM_BASE   0x0006030203180000ull
+
+/*
+ * On sPAPR machines, use a simplified output for the XIVE END
+ * structure dumping only the information related to the OS EQ.
+ */
+static void spapr_xive_end_pic_print_info(sPAPRXive *xive, XiveEND *end,
+                                          Monitor *mon)
+{
+    uint32_t qindex =3D GETFIELD_BE32(END_W1_PAGE_OFF, end->w1);
+    uint32_t qgen =3D GETFIELD_BE32(END_W1_GENERATION, end->w1);
+    uint32_t qsize =3D GETFIELD_BE32(END_W0_QSIZE, end->w0);
+    uint32_t qentries =3D 1 << (qsize + 10);
+    uint32_t nvt =3D GETFIELD_BE32(END_W6_NVT_INDEX, end->w6);
+    uint8_t priority =3D GETFIELD_BE32(END_W7_F0_PRIORITY, end->w7);
+
+    monitor_printf(mon, "%3d/%d % 6d/%5d ^%d", nvt,
+                   priority, qindex, qentries, qgen);
+
+    xive_end_queue_pic_print_info(end, 6, mon);
+    monitor_printf(mon, "]");
+}
+
+void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
+{
+    XiveSource *xsrc =3D &xive->source;
+    int i;
+
+    monitor_printf(mon, "  LSIN         PQ    EISN     CPU/PRIO EQ\n");
+
+    for (i =3D 0; i < xive->nr_irqs; i++) {
+        uint8_t pq =3D xive_source_esb_get(xsrc, i);
+        XiveEAS *eas =3D &xive->eat[i];
+
+        if (!xive_eas_is_valid(eas)) {
+            continue;
+        }
+
+        monitor_printf(mon, "  %08x %s %c%c%c %s %08x ", i,
+                       xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "MSI",
+                       pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
+                       xsrc->status[i] & XIVE_STATUS_ASSERTED ? 'A' : ' =
',
+                       xive_eas_is_masked(eas) ? "M" : " ",
+                       (int) GETFIELD_BE64(EAS_END_DATA, eas->w));
+
+        if (!xive_eas_is_masked(eas)) {
+            uint32_t end_idx =3D GETFIELD_BE64(EAS_END_INDEX, eas->w);
+            XiveEND *end;
+
+            assert(end_idx < xive->nr_ends);
+            end =3D &xive->endt[end_idx];
+
+            if (xive_end_is_valid(end)) {
+                spapr_xive_end_pic_print_info(xive, end, mon);
+            }
+        }
+        monitor_printf(mon, "\n");
+    }
+}
+
+static void spapr_xive_map_mmio(sPAPRXive *xive)
+{
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
+}
+
+static void spapr_xive_end_reset(XiveEND *end)
+{
+    memset(end, 0, sizeof(*end));
+
+    /* switch off the escalation and notification ESBs */
+    end->w1 =3D cpu_to_be32(END_W1_ESe_Q | END_W1_ESn_Q);
+}
+
+static void spapr_xive_reset(void *dev)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(dev);
+    int i;
+
+    /*
+     * The XiveSource has its own reset handler, which mask off all
+     * IRQs (!P|Q)
+     */
+
+    /* Mask all valid EASs in the IRQ number space. */
+    for (i =3D 0; i < xive->nr_irqs; i++) {
+        XiveEAS *eas =3D &xive->eat[i];
+        if (xive_eas_is_valid(eas)) {
+            eas->w =3D cpu_to_be64(EAS_VALID | EAS_MASKED);
+        } else {
+            eas->w =3D 0;
+        }
+    }
+
+    /* Clear all ENDs */
+    for (i =3D 0; i < xive->nr_ends; i++) {
+        spapr_xive_end_reset(&xive->endt[i]);
+    }
+}
+
+static void spapr_xive_instance_init(Object *obj)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(obj);
+
+    object_initialize(&xive->source, sizeof(xive->source), TYPE_XIVE_SOU=
RCE);
+    object_property_add_child(obj, "source", OBJECT(&xive->source), NULL=
);
+
+    object_initialize(&xive->end_source, sizeof(xive->end_source),
+                      TYPE_XIVE_END_SOURCE);
+    object_property_add_child(obj, "end_source", OBJECT(&xive->end_sourc=
e),
+                              NULL);
+}
+
+static void spapr_xive_realize(DeviceState *dev, Error **errp)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(dev);
+    XiveSource *xsrc =3D &xive->source;
+    XiveENDSource *end_xsrc =3D &xive->end_source;
+    Error *local_err =3D NULL;
+
+    if (!xive->nr_irqs) {
+        error_setg(errp, "Number of interrupt needs to be greater 0");
+        return;
+    }
+
+    if (!xive->nr_ends) {
+        error_setg(errp, "Number of interrupt needs to be greater 0");
+        return;
+    }
+
+    /*
+     * Initialize the internal sources, for IPIs and virtual devices.
+     */
+    object_property_set_int(OBJECT(xsrc), xive->nr_irqs, "nr-irqs",
+                            &error_fatal);
+    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
+                                   &error_fatal);
+    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err)=
;
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /*
+     * Initialize the END ESB source
+     */
+    object_property_set_int(OBJECT(end_xsrc), xive->nr_irqs, "nr-ends",
+                            &error_fatal);
+    object_property_add_const_link(OBJECT(end_xsrc), "xive", OBJECT(xive=
),
+                                   &error_fatal);
+    object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_=
err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* Set the mapping address of the END ESB pages after the source ESB=
s */
+    xive->end_base =3D xive->vc_base + (1ull << xsrc->esb_shift) * xsrc-=
>nr_irqs;
+
+    /*
+     * Allocate the routing tables
+     */
+    xive->eat =3D g_new0(XiveEAS, xive->nr_irqs);
+    xive->endt =3D g_new0(XiveEND, xive->nr_ends);
+
+    /* TIMA initialization */
+    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
+                          "xive.tima", 4ull << TM_SHIFT);
+
+    /* Define all XIVE MMIO regions on SysBus */
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
+
+    /* Map all regions */
+    spapr_xive_map_mmio(xive);
+
+    qemu_register_reset(spapr_xive_reset, dev);
+}
+
+static int spapr_xive_get_eas(XiveRouter *xrtr, uint8_t eas_blk,
+                              uint32_t eas_idx, XiveEAS *eas)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+
+    if (eas_idx >=3D xive->nr_irqs) {
+        return -1;
+    }
+
+    *eas =3D xive->eat[eas_idx];
+    return 0;
+}
+
+static int spapr_xive_get_end(XiveRouter *xrtr,
+                              uint8_t end_blk, uint32_t end_idx, XiveEND=
 *end)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+
+    if (end_idx >=3D xive->nr_ends) {
+        return -1;
+    }
+
+    memcpy(end, &xive->endt[end_idx], sizeof(XiveEND));
+    return 0;
+}
+
+static int spapr_xive_write_end(XiveRouter *xrtr, uint8_t end_blk,
+                                uint32_t end_idx, XiveEND *end,
+                                uint8_t word_number)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+
+    if (end_idx >=3D xive->nr_ends) {
+        return -1;
+    }
+
+    memcpy(&xive->endt[end_idx], end, sizeof(XiveEND));
+    return 0;
+}
+
+static const VMStateDescription vmstate_spapr_xive_end =3D {
+    .name =3D TYPE_SPAPR_XIVE "/end",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField []) {
+        VMSTATE_UINT32(w0, XiveEND),
+        VMSTATE_UINT32(w1, XiveEND),
+        VMSTATE_UINT32(w2, XiveEND),
+        VMSTATE_UINT32(w3, XiveEND),
+        VMSTATE_UINT32(w4, XiveEND),
+        VMSTATE_UINT32(w5, XiveEND),
+        VMSTATE_UINT32(w6, XiveEND),
+        VMSTATE_UINT32(w7, XiveEND),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_spapr_xive_eas =3D {
+    .name =3D TYPE_SPAPR_XIVE "/eas",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField []) {
+        VMSTATE_UINT64(w, XiveEAS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_spapr_xive =3D {
+    .name =3D TYPE_SPAPR_XIVE,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eat, sPAPRXive, nr_irqs,
+                                     vmstate_spapr_xive_eas, XiveEAS),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(endt, sPAPRXive, nr_ends,
+                                             vmstate_spapr_xive_end, Xiv=
eEND),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property spapr_xive_properties[] =3D {
+    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
+    DEFINE_PROP_UINT32("nr-ends", sPAPRXive, nr_ends, 0),
+    DEFINE_PROP_UINT64("vc-base", sPAPRXive, vc_base, SPAPR_XIVE_VC_BASE=
),
+    DEFINE_PROP_UINT64("tm-base", sPAPRXive, tm_base, SPAPR_XIVE_TM_BASE=
),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void spapr_xive_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
+
+    dc->desc    =3D "sPAPR XIVE Interrupt Controller";
+    dc->props   =3D spapr_xive_properties;
+    dc->realize =3D spapr_xive_realize;
+    dc->vmsd    =3D &vmstate_spapr_xive;
+
+    xrc->get_eas =3D spapr_xive_get_eas;
+    xrc->get_end =3D spapr_xive_get_end;
+    xrc->write_end =3D spapr_xive_write_end;
+}
+
+static const TypeInfo spapr_xive_info =3D {
+    .name =3D TYPE_SPAPR_XIVE,
+    .parent =3D TYPE_XIVE_ROUTER,
+    .instance_init =3D spapr_xive_instance_init,
+    .instance_size =3D sizeof(sPAPRXive),
+    .class_init =3D spapr_xive_class_init,
+};
+
+static void spapr_xive_register_types(void)
+{
+    type_register_static(&spapr_xive_info);
+}
+
+type_init(spapr_xive_register_types)
+
+bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi)
+{
+    XiveSource *xsrc =3D &xive->source;
+
+    if (lisn >=3D xive->nr_irqs) {
+        return false;
+    }
+
+    xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID);
+    xive_source_irq_set(xsrc, lisn, lsi);
+    return true;
+}
+
+bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn)
+{
+    XiveSource *xsrc =3D &xive->source;
+
+    if (lisn >=3D xive->nr_irqs) {
+        return false;
+    }
+
+    xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
+    xive_source_irq_set(xsrc, lisn, false);
+    return true;
+}
+
+qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn)
+{
+    XiveSource *xsrc =3D &xive->source;
+
+    if (lisn >=3D xive->nr_irqs) {
+        return NULL;
+    }
+
+    /* The sPAPR machine/device should have claimed the IRQ before */
+    assert(xive_eas_is_valid(&xive->eat[lisn]));
+
+    return xive_source_qirq(xsrc, lisn);
+}
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
new file mode 100644
index 0000000000..f087959b99
--- /dev/null
+++ b/include/hw/ppc/spapr_xive.h
@@ -0,0 +1,45 @@
+/*
+ * QEMU PowerPC sPAPR XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_SPAPR_XIVE_H
+#define PPC_SPAPR_XIVE_H
+
+#include "hw/ppc/xive.h"
+
+#define TYPE_SPAPR_XIVE "spapr-xive"
+#define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
+
+typedef struct sPAPRXive {
+    XiveRouter    parent;
+
+    /* Internal interrupt source for IPIs and virtual devices */
+    XiveSource    source;
+    hwaddr        vc_base;
+
+    /* END ESB MMIOs */
+    XiveENDSource end_source;
+    hwaddr        end_base;
+
+    /* Routing table */
+    XiveEAS       *eat;
+    uint32_t      nr_irqs;
+    XiveEND       *endt;
+    uint32_t      nr_ends;
+
+    /* TIMA mapping address */
+    hwaddr        tm_base;
+    MemoryRegion  tm_mmio;
+} sPAPRXive;
+
+bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
+bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
+void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
+qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
+
+#endif /* PPC_SPAPR_XIVE_H */
--=20
2.19.2
