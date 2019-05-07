Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E284FC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F08D2087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Hr1QXqRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F08D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40895 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtfw-00020h-UH
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:34:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVq-0000sO-Rw
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVl-0002hy-By
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:36 -0400
Received: from ozlabs.org ([203.11.71.1]:35967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVi-0002ds-Uo; Tue, 07 May 2019 02:23:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL30P33z9sNC; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210203;
	bh=eXt6jbXbDf70/Q2NJBka7jj4BKphfb5wCwAJcdlJZis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hr1QXqRMBkILl0osSeEfydaSdiuzgtCXCbsloYB+9ovgJCSjnWPQhoE75zVxoKnpK
	5xR2H53DgLTI/hrjhrhnP0otKxPurT2M8zirckfWX6jkz3PxxqliW+RgU+6mPuh4Aw
	e8pOAGZN2hCxQRk9hosRBu5Pf3gdAUluhdH6IxLk=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Date: Tue,  7 May 2019 16:23:13 +1000
Message-Id: <20190507062316.20916-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507062316.20916-1-david@gibson.dropbear.id.au>
References: <20190507062316.20916-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH v3 2/5] pci: Simplify pci_bus_is_root()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pci_bus_is_root() currently relies on a method in the PCIBusClass.
But it's always known if a PCI bus is a root bus when we create it, so
using a dynamic method is overkill.

This replaces it with an IS_ROOT bit in a new flags field, which is set o=
n
root buses and otherwise clear.  As a bonus this removes the special
is_root logic from pci_expander_bridge, since it already creates its bus
as a root bus.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/pci-bridge/pci_expander_bridge.c |  6 ------
 hw/pci/pci.c                        | 14 ++------------
 hw/virtio/virtio-pci.c              |  1 +
 include/hw/pci/pci.h                |  1 -
 include/hw/pci/pci_bus.h            | 12 +++++++++++-
 5 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
index e62de4218f..ca66bc721a 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -66,11 +66,6 @@ static int pxb_bus_num(PCIBus *bus)
     return pxb->bus_nr;
 }
=20
-static bool pxb_is_root(PCIBus *bus)
-{
-    return true; /* by definition */
-}
-
 static uint16_t pxb_bus_numa_node(PCIBus *bus)
 {
     PXBDev *pxb =3D convert_to_pxb(bus->parent_dev);
@@ -83,7 +78,6 @@ static void pxb_bus_class_init(ObjectClass *class, void=
 *data)
     PCIBusClass *pbc =3D PCI_BUS_CLASS(class);
=20
     pbc->bus_num =3D pxb_bus_num;
-    pbc->is_root =3D pxb_is_root;
     pbc->numa_node =3D pxb_bus_numa_node;
 }
=20
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a78023f669..b386777045 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -129,14 +129,9 @@ static void pci_bus_unrealize(BusState *qbus, Error =
**errp)
     vmstate_unregister(NULL, &vmstate_pcibus, bus);
 }
=20
-static bool pcibus_is_root(PCIBus *bus)
-{
-    return !bus->parent_dev;
-}
-
 static int pcibus_num(PCIBus *bus)
 {
-    if (pcibus_is_root(bus)) {
+    if (pci_bus_is_root(bus)) {
         return 0; /* pci host bridge */
     }
     return bus->parent_dev->config[PCI_SECONDARY_BUS];
@@ -164,7 +159,6 @@ static void pci_bus_class_init(ObjectClass *klass, vo=
id *data)
     k->unrealize =3D pci_bus_unrealize;
     k->reset =3D pcibus_reset;
=20
-    pbc->is_root =3D pcibus_is_root;
     pbc->bus_num =3D pcibus_num;
     pbc->numa_node =3D pcibus_numa_node;
     pbc->allows_extended_config_space =3D pcibus_allows_extended_config_=
space;
@@ -398,6 +392,7 @@ static void pci_root_bus_init(PCIBus *bus, DeviceStat=
e *parent,
     bus->slot_reserved_mask =3D 0x0;
     bus->address_space_mem =3D address_space_mem;
     bus->address_space_io =3D address_space_io;
+    bus->flags |=3D PCI_BUS_IS_ROOT;
=20
     /* host bridge */
     QLIST_INIT(&bus->child);
@@ -415,11 +410,6 @@ bool pci_bus_is_express(PCIBus *bus)
     return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
 }
=20
-bool pci_bus_is_root(PCIBus *bus)
-{
-    return PCI_BUS_GET_CLASS(bus)->is_root(bus);
-}
-
 bool pci_bus_allows_extended_config_space(PCIBus *bus)
 {
     return PCI_BUS_GET_CLASS(bus)->allows_extended_config_space(bus);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cb44e19b67..942173d830 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -20,6 +20,7 @@
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/pci/msi.h"
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index fdd4c43d3a..edf44de21d 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -395,7 +395,6 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque=
, int pin);
 #define TYPE_PCIE_BUS "PCIE"
=20
 bool pci_bus_is_express(PCIBus *bus);
-bool pci_bus_is_root(PCIBus *bus);
 bool pci_bus_allows_extended_config_space(PCIBus *bus);
=20
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState =
*parent,
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index f6df834170..aea98d5040 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -15,14 +15,19 @@ typedef struct PCIBusClass {
     BusClass parent_class;
     /*< public >*/
=20
-    bool (*is_root)(PCIBus *bus);
     int (*bus_num)(PCIBus *bus);
     uint16_t (*numa_node)(PCIBus *bus);
     bool (*allows_extended_config_space)(PCIBus *bus);
 } PCIBusClass;
=20
+enum PCIBusFlags {
+    /* This bus is the root of a PCI domain */
+    PCI_BUS_IS_ROOT                                         =3D 0x0001,
+};
+
 struct PCIBus {
     BusState qbus;
+    enum PCIBusFlags flags;
     PCIIOMMUFunc iommu_fn;
     void *iommu_opaque;
     uint8_t devfn_min;
@@ -47,4 +52,9 @@ struct PCIBus {
     Notifier machine_done;
 };
=20
+static inline bool pci_bus_is_root(PCIBus *bus)
+{
+    return !!(bus->flags & PCI_BUS_IS_ROOT);
+}
+
 #endif /* QEMU_PCI_BUS_H */
--=20
2.21.0


