Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C10BC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D921B205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ADUWhF+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D921B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40983 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtkZ-0005om-0j
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:38:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVq-0000sS-TA
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVn-0002k7-7u
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:38 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVl-0002eE-9i; Tue, 07 May 2019 02:23:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL31g6Kz9sNs; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210203;
	bh=2v7gcAXnr/JMTY471KXC7AVq3EN89FTOMlWJ929smXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADUWhF+iHbyoZ/KoCaPWSBNLIFRq2Y5lJRgjjCCRq27FSsyHLpbdMrZVL2O8QPzoT
	MLxvtZEXtDQE9xr49S66p1uqXjqrNZAIBSQA/HXP+omTlt/XA1CHqRvYQMP0fIoDn+
	Or7yXBBmnntiHfNeU2T/+CjEEOIbctSwHxjCA9bg=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Date: Tue,  7 May 2019 16:23:14 +1000
Message-Id: <20190507062316.20916-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507062316.20916-1-david@gibson.dropbear.id.au>
References: <20190507062316.20916-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH v3 3/5] pcie: Simplify pci_adjust_config_limit()
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
	Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since c2077e2c "pci: Adjust PCI config limit based on bus topology",
pci_adjust_config_limit() has been used in the config space read and writ=
e
paths to only permit access to extended config space on buses which permi=
t
it.  Specifically it prevents access on devices below a vanilla-PCI bus v=
ia
some combination of bridges, even if both the host bridge and the device
itself are PCI-E.

It accomplishes this with a somewhat complex call up the chain of bridges
to see if any of them prohibit extended config space access.  This is
overly complex, since we can always know if the bus will support such
access at the point it is constructed.

This patch simplifies the test by using a flag in the PCIBus instance
indicating whether extended configuration space is accessible.  It is
false for vanilla PCI buses.  For PCI-E buses, it is true for root
buses and equal to the parent bus's's capability otherwise.

For the special case of sPAPR's paravirtualized PCI root bus, which
acts mostly like vanilla PCI, but does allow extended config space
access, we override the default value of the flag from the host bridge
code.

This should cause no behavioural change.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/pci/pci.c             | 41 ++++++++++++++++++++++------------------
 hw/pci/pci_host.c        | 13 +++----------
 hw/ppc/spapr_pci.c       | 34 ++++++++++-----------------------
 include/hw/pci/pci.h     |  1 -
 include/hw/pci/pci_bus.h |  8 +++++++-
 5 files changed, 43 insertions(+), 54 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b386777045..7e5f8d001b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -120,6 +120,27 @@ static void pci_bus_realize(BusState *qbus, Error **=
errp)
     vmstate_register(NULL, -1, &vmstate_pcibus, bus);
 }
=20
+static void pcie_bus_realize(BusState *qbus, Error **errp)
+{
+    PCIBus *bus =3D PCI_BUS(qbus);
+
+    pci_bus_realize(qbus, errp);
+
+    /*
+     * A PCI-E bus can support extended config space if it's the root
+     * bus, or if the bus/bridge above it does as well
+     */
+    if (pci_bus_is_root(bus)) {
+        bus->flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
+    } else {
+        PCIBus *parent_bus =3D pci_get_bus(bus->parent_dev);
+
+        if (pci_bus_allows_extended_config_space(parent_bus)) {
+            bus->flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
+        }
+    }
+}
+
 static void pci_bus_unrealize(BusState *qbus, Error **errp)
 {
     PCIBus *bus =3D PCI_BUS(qbus);
@@ -142,11 +163,6 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
     return NUMA_NODE_UNASSIGNED;
 }
=20
-static bool pcibus_allows_extended_config_space(PCIBus *bus)
-{
-    return false;
-}
-
 static void pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k =3D BUS_CLASS(klass);
@@ -161,7 +177,6 @@ static void pci_bus_class_init(ObjectClass *klass, vo=
id *data)
=20
     pbc->bus_num =3D pcibus_num;
     pbc->numa_node =3D pcibus_numa_node;
-    pbc->allows_extended_config_space =3D pcibus_allows_extended_config_=
space;
 }
=20
 static const TypeInfo pci_bus_info =3D {
@@ -182,16 +197,11 @@ static const TypeInfo conventional_pci_interface_in=
fo =3D {
     .parent        =3D TYPE_INTERFACE,
 };
=20
-static bool pciebus_allows_extended_config_space(PCIBus *bus)
-{
-    return true;
-}
-
 static void pcie_bus_class_init(ObjectClass *klass, void *data)
 {
-    PCIBusClass *pbc =3D PCI_BUS_CLASS(klass);
+    BusClass *k =3D BUS_CLASS(klass);
=20
-    pbc->allows_extended_config_space =3D pciebus_allows_extended_config=
_space;
+    k->realize =3D pcie_bus_realize;
 }
=20
 static const TypeInfo pcie_bus_info =3D {
@@ -410,11 +420,6 @@ bool pci_bus_is_express(PCIBus *bus)
     return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
 }
=20
-bool pci_bus_allows_extended_config_space(PCIBus *bus)
-{
-    return PCI_BUS_GET_CLASS(bus)->allows_extended_config_space(bus);
-}
-
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState =
*parent,
                               const char *name,
                               MemoryRegion *address_space_mem,
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 9d64b2e12f..5f3497256c 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -53,16 +53,9 @@ static inline PCIDevice *pci_dev_find_by_addr(PCIBus *=
bus, uint32_t addr)
=20
 static void pci_adjust_config_limit(PCIBus *bus, uint32_t *limit)
 {
-    if (*limit > PCI_CONFIG_SPACE_SIZE) {
-        if (!pci_bus_allows_extended_config_space(bus)) {
-            *limit =3D PCI_CONFIG_SPACE_SIZE;
-            return;
-        }
-
-        if (!pci_bus_is_root(bus)) {
-            PCIDevice *bridge =3D pci_bridge_get_device(bus);
-            pci_adjust_config_limit(pci_get_bus(bridge), limit);
-        }
+    if ((*limit > PCI_CONFIG_SPACE_SIZE) &&
+        !pci_bus_allows_extended_config_space(bus)) {
+        *limit =3D PCI_CONFIG_SPACE_SIZE;
     }
 }
=20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 97961b0128..9cf2c41b8c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1626,28 +1626,6 @@ static void spapr_phb_unrealize(DeviceState *dev, =
Error **errp)
     memory_region_del_subregion(get_system_memory(), &sphb->mem32window)=
;
 }
=20
-static bool spapr_phb_allows_extended_config_space(PCIBus *bus)
-{
-    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(BUS(bus)->parent);
-
-    return sphb->pcie_ecs;
-}
-
-static void spapr_phb_root_bus_class_init(ObjectClass *klass, void *data=
)
-{
-    PCIBusClass *pbc =3D PCI_BUS_CLASS(klass);
-
-    pbc->allows_extended_config_space =3D spapr_phb_allows_extended_conf=
ig_space;
-}
-
-#define TYPE_SPAPR_PHB_ROOT_BUS "pci"
-
-static const TypeInfo spapr_phb_root_bus_info =3D {
-    .name =3D TYPE_SPAPR_PHB_ROOT_BUS,
-    .parent =3D TYPE_PCI_BUS,
-    .class_init =3D spapr_phb_root_bus_class_init,
-};
-
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
@@ -1753,7 +1731,16 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
                                 pci_spapr_set_irq, pci_swizzle_map_irq_f=
n, sphb,
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS,
-                                TYPE_SPAPR_PHB_ROOT_BUS);
+                                TYPE_PCI_BUS);
+
+    /*
+     * Despite resembling a vanilla PCI bus in most ways, the PAPR
+     * para-virtualized PCI bus *does* permit PCI-E extended config
+     * space access
+     */
+    if (sphb->pcie_ecs) {
+        bus->flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
+    }
     phb->bus =3D bus;
     qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
=20
@@ -2348,7 +2335,6 @@ void spapr_pci_rtas_init(void)
 static void spapr_pci_register_types(void)
 {
     type_register_static(&spapr_phb_info);
-    type_register_static(&spapr_phb_root_bus_info);
 }
=20
 type_init(spapr_pci_register_types)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index edf44de21d..da20c915ef 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -395,7 +395,6 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque=
, int pin);
 #define TYPE_PCIE_BUS "PCIE"
=20
 bool pci_bus_is_express(PCIBus *bus);
-bool pci_bus_allows_extended_config_space(PCIBus *bus);
=20
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState =
*parent,
                               const char *name,
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index aea98d5040..0714f578af 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -17,12 +17,13 @@ typedef struct PCIBusClass {
=20
     int (*bus_num)(PCIBus *bus);
     uint16_t (*numa_node)(PCIBus *bus);
-    bool (*allows_extended_config_space)(PCIBus *bus);
 } PCIBusClass;
=20
 enum PCIBusFlags {
     /* This bus is the root of a PCI domain */
     PCI_BUS_IS_ROOT                                         =3D 0x0001,
+    /* PCIe extended configuration space is accessible on this bus */
+    PCI_BUS_EXTENDED_CONFIG_SPACE                           =3D 0x0002,
 };
=20
 struct PCIBus {
@@ -57,4 +58,9 @@ static inline bool pci_bus_is_root(PCIBus *bus)
     return !!(bus->flags & PCI_BUS_IS_ROOT);
 }
=20
+static inline bool pci_bus_allows_extended_config_space(PCIBus *bus)
+{
+    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
+}
+
 #endif /* QEMU_PCI_BUS_H */
--=20
2.21.0


