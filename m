Received: from eggs.gnu.org ([2001:4830:134:3::10]:45271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cRFM9-0000my-L9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cRFM4-0000ru-OI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:38:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cRFM4-0000rO-Eb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:38:04 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0B9XgrL050080
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 04:38:03 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27wfccfbe5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 04:38:03 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 11 Jan 2017 09:38:00 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Wed, 11 Jan 2017 10:37:41 +0100
In-Reply-To: <20170111093742.21946-1-cornelia.huck@de.ibm.com>
References: <20170111093742.21946-1-cornelia.huck@de.ibm.com>
Message-Id: <20170111093742.21946-11-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 10/11] s390x/pci: handle PCIBridge bus number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

The PCI bus number is usually set by the host during the enumeration.

In the s390 architecture we neither get a Device Tree nor have an
enumeration understanding bridge devices.

Let's fake the enumeration on reset and set the PCI_PRIMARY_BUS,
PCI_SECONDARY_BUS and PCI_SUBORDINATE_BUS config entries for the
bridges.

Let's add the configuration of these three config entries on bridge hot
plug.

The bus number is calculated based on a new entry, bus_num of the
S390pciState device.

This commit is inspired by what spapr pci does.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-pci-bus.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 458ea2bdd7..736c0fcce5 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -576,6 +576,7 @@ static int s390_pcihost_init(SysBusDevice *dev)
     s->iommu_table = g_hash_table_new_full(g_int64_hash, g_int64_equal,
                                            NULL, g_free);
     s->zpci_table = g_hash_table_new_full(g_int_hash, g_int_equal, NULL, NULL);
+    s->bus_no = 0;
     QTAILQ_INIT(&s->pending_sei);
     QTAILQ_INIT(&s->zpci_devs);
     return 0;
@@ -673,12 +674,24 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
         BusState *bus;
         PCIBridge *pb = PCI_BRIDGE(dev);
+        PCIDevice *pdev = PCI_DEVICE(dev);
 
         pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
         pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
 
         bus = BUS(&pb->sec_bus);
         qbus_set_hotplug_handler(bus, DEVICE(s), errp);
+
+        if (dev->hotplugged) {
+            pci_default_write_config(pdev, PCI_PRIMARY_BUS, s->bus_no, 1);
+            s->bus_no += 1;
+            pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus_no, 1);
+            do {
+                pdev = pdev->bus->parent_dev;
+                pci_default_write_config(pdev, PCI_SUBORDINATE_BUS,
+                                         s->bus_no, 1);
+            } while (pdev->bus && pci_bus_num(pdev->bus));
+        }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pdev = PCI_DEVICE(dev);
 
@@ -812,6 +825,44 @@ out:
     object_unparent(OBJECT(pbdev));
 }
 
+static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
+                                      void *opaque)
+{
+    S390pciState *s = opaque;
+    unsigned int primary = s->bus_no;
+    unsigned int subordinate = 0xff;
+    PCIBus *sec_bus = NULL;
+
+    if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=
+         PCI_HEADER_TYPE_BRIDGE)) {
+        return;
+    }
+
+    (s->bus_no)++;
+    pci_default_write_config(pdev, PCI_PRIMARY_BUS, primary, 1);
+    pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus_no, 1);
+    pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
+
+    sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+    if (!sec_bus) {
+        return;
+    }
+
+    pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, subordinate, 1);
+    pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
+                        s390_pci_enumerate_bridge, s);
+    pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
+}
+
+static void s390_pcihost_reset(DeviceState *dev)
+{
+    S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
+    PCIBus *bus = s->parent_obj.bus;
+
+    s->bus_no = 0;
+    pci_for_each_device(bus, pci_bus_num(bus), s390_pci_enumerate_bridge, s);
+}
+
 static void s390_pcihost_class_init(ObjectClass *klass, void *data)
 {
     SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
@@ -819,6 +870,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
     dc->cannot_instantiate_with_device_add_yet = true;
+    dc->reset = s390_pcihost_reset;
     k->init = s390_pcihost_init;
     hc->plug = s390_pcihost_hot_plug;
     hc->unplug = s390_pcihost_hot_unplug;
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index b82b18eb07..b0adefa788 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -310,6 +310,7 @@ typedef struct S390PCIBus {
 typedef struct S390pciState {
     PCIHostState parent_obj;
     uint32_t next_idx;
+    int bus_no;
     S390PCIBus *bus;
     GHashTable *iommu_table;
     GHashTable *zpci_table;
-- 
2.11.0
