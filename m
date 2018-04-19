Received: from eggs.gnu.org ([2001:4830:134:3::10]:56591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vD-0007lP-FI
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98v9-0007xm-J6
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:19 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:54705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98v9-0007wX-9C
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:15 -0400
Received: from player792.ha.ovh.net (unknown [10.109.122.78])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7BC03EE5B7
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:44:13 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:01 +0200
Message-Id: <20180419124331.3915-6-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/35] spapr/xive: add a single source block
 to the sPAPR XIVE model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Bare-metal systems (PowerNV) have multiples interrupt sources. The
XIVE interrupt controller has an internal source for IPIs and generic
IPIs, the PSIHB has one and also the PHBs. But, for simplicity on the
sPAPR machine, we use a unique XiveSource object for all IPIs and
virtual device interrupts of the VM.

The ESB MMIO region used to control the sources is mapped at the
address of chip 0 of a real system and only the provisioned IRQ
numbers are covered.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 34 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_xive.h |  3 +++
 include/hw/ppc/xive.h       |  6 ++++++
 3 files changed, 43 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 020444e2665a..90cde8a4082d 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -14,12 +14,15 @@
 #include "sysemu/cpus.h"
 #include "monitor/monitor.h"
 #include "hw/ppc/spapr_xive.h"
+#include "hw/ppc/xive.h"
 #include "hw/ppc/xive_regs.h"
=20
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
 {
     int i;
=20
+    xive_source_pic_print_info(&xive->source, mon);
+
     monitor_printf(mon, "IVE Table\n");
     for (i =3D 0; i < xive->nr_irqs; i++) {
         XiveIVE *ive =3D &xive->ivt[i];
@@ -40,6 +43,9 @@ static void spapr_xive_reset(DeviceState *dev)
     sPAPRXive *xive =3D SPAPR_XIVE(dev);
     int i;
=20
+    /* Xive Source reset is done through SysBus, it should put all
+     * IRQs to OFF (!P|Q) */
+
     /* Mask all valid IVEs in the IRQ number space. */
     for (i =3D 0; i < xive->nr_irqs; i++) {
         XiveIVE *ive =3D &xive->ivt[i];
@@ -51,18 +57,42 @@ static void spapr_xive_reset(DeviceState *dev)
=20
 static void spapr_xive_init(Object *obj)
 {
+    sPAPRXive *xive =3D SPAPR_XIVE(obj);
=20
+    object_initialize(&xive->source, sizeof(xive->source), TYPE_XIVE_SOU=
RCE);
+    object_property_add_child(obj, "source", OBJECT(&xive->source), NULL=
);
 }
=20
 static void spapr_xive_realize(DeviceState *dev, Error **errp)
 {
     sPAPRXive *xive =3D SPAPR_XIVE(dev);
+    XiveSource *xsrc =3D &xive->source;
+    Error *local_err =3D NULL;
=20
     if (!xive->nr_irqs) {
         error_setg(errp, "Number of interrupt needs to be greater 0");
         return;
     }
=20
+    /* The XIVE interrupt controller has an internal source for IPIs
+     * and generic IPIs, the PSIHB has one and also the PHBs. For
+     * simplicity, we use a unique XIVE source object for *all*
+     * interrupts on sPAPR. The ESBs pages are mapped at the address
+     * of chip 0 of a real system.
+     */
+    object_property_set_int(OBJECT(xsrc), XIVE_VC_BASE, "bar",
+                            &error_fatal);
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
     /* Allocate the Interrupt Virtualization Table */
     xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
 }
@@ -137,23 +167,27 @@ type_init(spapr_xive_register_types)
 bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi)
 {
     XiveIVE *ive =3D spapr_xive_get_ive(XIVE_FABRIC(xive), lisn);
+    XiveSource *xsrc =3D &xive->source;
=20
     if (!ive) {
         return false;
     }
=20
     ive->w |=3D IVE_VALID;
+    xive_source_irq_set(xsrc, lisn - xsrc->offset, lsi);
     return true;
 }
=20
 bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn)
 {
     XiveIVE *ive =3D spapr_xive_get_ive(XIVE_FABRIC(xive), lisn);
+    XiveSource *xsrc =3D &xive->source;
=20
     if (!ive) {
         return false;
     }
=20
     ive->w &=3D ~IVE_VALID;
+    xive_source_irq_set(xsrc, lisn - xsrc->offset, false);
     return true;
 }
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 1d966b5d3a96..4538c622b60a 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -19,6 +19,9 @@
 typedef struct sPAPRXive {
     SysBusDevice parent;
=20
+    /* Internal interrupt source for IPIs and virtual devices */
+    XiveSource   source;
+
     /* Routing table */
     XiveIVE      *ivt;
     uint32_t     nr_irqs;
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 5b145816acdc..57295715a4a5 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -16,6 +16,12 @@
 typedef struct XiveFabric XiveFabric;
=20
 /*
+ * XIVE MMIO regions
+ */
+
+#define XIVE_VC_BASE   0x0006010000000000ull
+
+/*
  * XIVE Interrupt Source
  */
=20
--=20
2.13.6
