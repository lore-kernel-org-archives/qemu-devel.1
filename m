Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2067C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 04:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6797720878
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 04:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DcO2CBne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6797720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35455 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ9S7-0000iV-Ji
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 00:24:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ9OJ-0006Jv-1k
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ9OH-0008ME-Dg
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:20:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47939 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJ9OG-0007ue-Bc; Wed, 24 Apr 2019 00:20:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44pnCk1B19z9s55; Wed, 24 Apr 2019 14:20:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556079602;
	bh=i5wDM9n5BQU1nFXLcxEUJQtZIASMK/19+h0VivHGMgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcO2CBneuu4nPVP6bED0dJWG2XQWmUkg6B9az6vueZoRXN1JSblqt7TIRVp/ZQbiD
	9wqDjWelkUPVirtwr+fZOQhb/3hjZnDZjtuRxqNHd5AnZ7wxeVMYGd3t4Paqsf5Pzb
	PANn+m/SZGx3SaxI9HHnfo9QnVMYfhKkT+aiHFKY=
From: David Gibson <david@gibson.dropbear.id.au>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, Greg Kurz <groug@kaod.org>
Date: Wed, 24 Apr 2019 14:19:59 +1000
Message-Id: <20190424041959.4087-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424041959.4087-1-david@gibson.dropbear.id.au>
References: <20190424041959.4087-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH v2 3/3] pcie: Simplify pci_adjust_config_limit()
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
Cc: qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424041959.1E9uTIFVgmWBHIukyee0UuoamVm9ticEsSSTp9zIVLs@z>

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

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>cd
---
 hw/pci/pci.c             | 41 ++++++++++++++++++++++------------------
 hw/pci/pci_host.c        | 13 +++----------
 hw/ppc/spapr_pci.c       | 34 ++++++++++-----------------------
 include/hw/pci/pci.h     |  1 -
 include/hw/pci/pci_bus.h |  9 ++++++++-
 5 files changed, 44 insertions(+), 54 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index ea5941fb22..59ee034331 100644
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
index f62e6833b8..65a86be29c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1638,28 +1638,6 @@ static void spapr_phb_unrealize(DeviceState *dev, =
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
@@ -1765,7 +1743,16 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
                                 pci_spapr_set_irq, pci_spapr_map_irq, sp=
hb,
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
index 33ccce320c..0edfaabbb0 100644
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
index aea98d5040..2d5f74b7c1 100644
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
@@ -57,4 +58,10 @@ static inline bool pci_bus_is_root(PCIBus *bus)
     return !!(bus->flags & PCI_BUS_IS_ROOT);
 }
=20
+static inline bool pci_bus_allows_extended_config_space(PCIBus *bus)
+{
+    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
+}
+
+
 #endif /* QEMU_PCI_BUS_H */
--=20
2.20.1


