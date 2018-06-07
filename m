Received: from eggs.gnu.org ([2001:4830:134:3::10]:39019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCJ-0002R9-Ob
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCE-0003yC-U1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:35 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:33552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxCE-0003xR-KF
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:30 -0400
Received: from player169.ha.ovh.net (unknown [10.109.108.98])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 710EB1375CF
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:51:27 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:48 +0200
Message-Id: <20180607155003.1580-14-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 13/28] spapr/xive: introduce a XIVE
 interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

sPAPRXive models the XIVE interrupt controller of the sPAPR machine.
It inherits from the XiveRouter and provisions storage for the routing
tables :

  - Interrupt Virtualization Entries (IVE)
  - Event Queue Descriptor (EQD)

sPAPRXive incorporates an internal XiveSource for the IPIs and the
virtual device interrupts of the guest. This model is consistent with
XIVE architecture which also incorporates an internal IVSE for IPIs
and accelerator interrupts in the IVRE sub-engine.

sPAPRXive exports two memory regions, one for the ESB trigger and
management pages used to control the sources and one for the TIMA
pages. They are mapped by default at the addresses found on chip 0 of
a real system. This is consistent with the XIVE architecture which
defines a Virtualization Controller BAR for the internal IVSE ESB
pages and a Thread Managment BAR for the TIMA.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 default-configs/ppc64-softmmu.mak |   1 +
 include/hw/ppc/spapr_xive.h       |  46 ++++++
 hw/intc/spapr_xive.c              | 308 ++++++++++++++++++++++++++++++++=
++++++
 hw/intc/Makefile.objs             |   1 +
 4 files changed, 356 insertions(+)
 create mode 100644 include/hw/ppc/spapr_xive.h
 create mode 100644 hw/intc/spapr_xive.c

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index c6d13e757977..f8d34722931d 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -17,4 +17,5 @@ CONFIG_XICS=3D$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
 CONFIG_XIVE=3D$(CONFIG_PSERIES)
+CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
 CONFIG_MEM_HOTPLUG=3Dy
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
new file mode 100644
index 000000000000..32733270f734
--- /dev/null
+++ b/include/hw/ppc/spapr_xive.h
@@ -0,0 +1,46 @@
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
+#include "hw/sysbus.h"
+#include "hw/ppc/xive.h"
+
+#define TYPE_SPAPR_XIVE "spapr-xive"
+#define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
+
+typedef struct sPAPRXive {
+    XiveRouter   parent;
+
+    /* Internal interrupt source for IPIs and virtual devices */
+    XiveSource   source;
+    hwaddr       vc_base;
+
+    /* EQ ESB MMIOs */
+    XiveEQSource eq_source;
+    hwaddr       eq_base;
+
+    /* Routing table */
+    XiveIVE      *ivt;
+    uint32_t     nr_irqs;
+    XiveEQ       *eqdt;
+    uint32_t     nr_eqs;
+
+    /* TIMA mapping address */
+    hwaddr       tm_base;
+    MemoryRegion tm_mmio;
+} sPAPRXive;
+
+bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi);
+bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
+void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
+qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
+
+#endif /* PPC_SPAPR_XIVE_H */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
new file mode 100644
index 000000000000..e006c199ed11
--- /dev/null
+++ b/hw/intc/spapr_xive.c
@@ -0,0 +1,308 @@
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
+void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
+{
+    int i;
+
+    xive_source_pic_print_info(&xive->source, 0, mon);
+
+    monitor_printf(mon, "IVE Table\n");
+    for (i =3D 0; i < xive->nr_irqs; i++) {
+        xive_router_print_ive(XIVE_ROUTER(xive), i, &xive->ivt[i], mon);
+    }
+}
+
+static void spapr_xive_reset(DeviceState *dev)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(dev);
+    XiveSource *xsrc =3D &xive->source;
+    int i;
+
+    /* Xive Source reset is done through SysBus, it should put all
+     * IRQs to OFF (!P|Q) */
+
+    /* Mask all valid IVEs in the IRQ number space. */
+    for (i =3D 0; i < xive->nr_irqs; i++) {
+        XiveIVE *ive =3D &xive->ivt[i];
+        if (ive->w & IVE_VALID) {
+            ive->w |=3D IVE_MASKED;
+        }
+    }
+
+    for (i =3D 0; i < xive->nr_eqs; i++) {
+        xive_eq_reset(&xive->eqdt[i]);
+    }
+
+    /* Map the EQ ESB pages after the source ESBs */
+    xive->eq_base =3D xive->vc_base + (1ull << xsrc->esb_shift) * xsrc->=
nr_irqs;
+
+    /* Map ESB pages and TIMA pages */
+    sysbus_mmio_map(SYS_BUS_DEVICE(&xive->source), 0, xive->vc_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&xive->eq_source), 0, xive->eq_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->tm_base);
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
+    object_initialize(&xive->eq_source, sizeof(xive->eq_source),
+                      TYPE_XIVE_EQ_SOURCE);
+    object_property_add_child(obj, "eq_source", OBJECT(&xive->eq_source)=
, NULL);
+}
+
+static void spapr_xive_realize(DeviceState *dev, Error **errp)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(dev);
+    XiveSource *xsrc =3D &xive->source;
+    XiveEQSource *eq_xsrc =3D &xive->eq_source;
+    Error *local_err =3D NULL;
+
+    if (!xive->nr_irqs) {
+        error_setg(errp, "Number of interrupt needs to be greater 0");
+        return;
+    }
+
+    if (!xive->nr_eqs) {
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
+    qdev_set_parent_bus(DEVICE(xsrc), sysbus_get_default());
+
+    /*
+     * Initialize the EQ ESB source
+     */
+    object_property_set_int(OBJECT(eq_xsrc), xive->nr_irqs, "nr-eqs",
+                            &error_fatal);
+    object_property_add_const_link(OBJECT(eq_xsrc), "xive", OBJECT(xive)=
,
+                                   &error_fatal);
+    object_property_set_bool(OBJECT(eq_xsrc), true, "realized", &local_e=
rr);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    qdev_set_parent_bus(DEVICE(eq_xsrc), sysbus_get_default());
+
+    /* Allocate the routing tables */
+    xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
+    xive->eqdt =3D g_new0(XiveEQ, xive->nr_eqs);
+
+    /* TIMA */
+    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
+                          "xive.tima", 4ull << TM_SHIFT);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio);
+}
+
+static int spapr_xive_get_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *=
ive)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+
+    if (lisn >=3D xive->nr_irqs) {
+        return -1;
+    }
+
+    *ive =3D xive->ivt[lisn];
+    return 0;
+}
+
+static int spapr_xive_set_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *=
ive)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+
+    if (lisn >=3D xive->nr_irqs) {
+        return -1;
+    }
+
+    xive->ivt[lisn] =3D *ive;
+    return 0;
+}
+
+static int spapr_xive_get_eq(XiveRouter *xrtr,
+                             uint8_t eq_blk, uint32_t eq_idx, XiveEQ *eq=
)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+
+    if (eq_idx >=3D xive->nr_eqs) {
+        return -1;
+    }
+
+    memcpy(eq, &xive->eqdt[eq_idx], sizeof(XiveEQ));
+    return 0;
+}
+
+static int spapr_xive_set_eq(XiveRouter *xrtr,
+                             uint8_t eq_blk, uint32_t eq_idx, XiveEQ *eq=
)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+
+    if (eq_idx >=3D xive->nr_eqs) {
+        return -1;
+    }
+
+    memcpy(&xive->eqdt[eq_idx], eq, sizeof(XiveEQ));
+    return 0;
+}
+
+static const VMStateDescription vmstate_spapr_xive_eq =3D {
+    .name =3D TYPE_SPAPR_XIVE "/eq",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField []) {
+        VMSTATE_UINT32(w0, XiveEQ),
+        VMSTATE_UINT32(w1, XiveEQ),
+        VMSTATE_UINT32(w2, XiveEQ),
+        VMSTATE_UINT32(w3, XiveEQ),
+        VMSTATE_UINT32(w4, XiveEQ),
+        VMSTATE_UINT32(w5, XiveEQ),
+        VMSTATE_UINT32(w6, XiveEQ),
+        VMSTATE_UINT32(w7, XiveEQ),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_spapr_xive_ive =3D {
+    .name =3D TYPE_SPAPR_XIVE "/ive",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField []) {
+        VMSTATE_UINT64(w, XiveIVE),
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
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(ivt, sPAPRXive, nr_irqs,
+                                     vmstate_spapr_xive_ive, XiveIVE),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eqdt, sPAPRXive, nr_eqs,
+                                             vmstate_spapr_xive_eq, Xive=
EQ),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property spapr_xive_properties[] =3D {
+    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
+    DEFINE_PROP_UINT32("nr-eqs",  sPAPRXive, nr_eqs, 0),
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
+    dc->reset   =3D spapr_xive_reset;
+    dc->vmsd    =3D &vmstate_spapr_xive;
+
+    xrc->get_ive =3D spapr_xive_get_ive;
+    xrc->set_ive =3D spapr_xive_set_ive;
+    xrc->get_eq  =3D spapr_xive_get_eq;
+    xrc->set_eq  =3D spapr_xive_set_eq;
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
+bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi)
+{
+    XiveSource *xsrc =3D &xive->source;
+
+    if (lisn >=3D xive->nr_irqs) {
+        return false;
+    }
+
+    xive->ivt[lisn].w |=3D IVE_VALID;
+    xive_source_irq_set(xsrc, lisn, lsi);
+    return true;
+}
+
+bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn)
+{
+    XiveSource *xsrc =3D &xive->source;
+
+    if (lisn >=3D xive->nr_irqs) {
+        return false;
+    }
+
+    xive->ivt[lisn].w &=3D ~IVE_VALID;
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
+    if (!(xive->ivt[lisn].w & IVE_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", lisn);
+        return NULL;
+    }
+
+    return xive_source_qirq(xsrc, lisn);
+}
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 72a46ed91c31..301a8e972d91 100644
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
--=20
2.13.6
