Received: from eggs.gnu.org ([2001:4830:134:3::10]:48905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZe-0002A7-KU
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZb-00084m-G3
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52085
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cTPZb-00084W-Bj
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:56:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0H8tntr138200
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:56:58 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 281eucb1f5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:56:58 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 17 Jan 2017 08:56:56 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 17 Jan 2017 09:56:38 +0100
In-Reply-To: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
Message-Id: <20170117085645.4267-6-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 05/12] s390x/pci: dynamically allocate iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

When initializing a PCI device, an address space is required during PCI
core initialization and before the call to the embedding object hotplug
callback. To provide this AS, we allocate a S390PCIIOMMU object
containing this AS. Initialization of S390PCIIOMMU object is done
before the PCI device is completely created. So that we cannot
associate the IOMMU with the device at the moment. To track the IOMMU
object, we use g_hash functions with the PCI device's bus address as a
key to provide an array of pointers indexed by the PCI device's devfn
to the allocated IOMMU.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 73 +++++++++++++++++++++++++++++++++++++++----------
 hw/s390x/s390-pci-bus.h |  7 ++++-
 2 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 11244fc93c..04a4c3508e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -432,11 +432,48 @@ static const MemoryRegionIOMMUOps s390_iommu_ops = {
     .translate = s390_translate_iommu,
 };
 
+static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
+                                        int devfn)
+{
+    uint64_t key = (unsigned long)bus;
+    S390PCIIOMMUTable *table = g_hash_table_lookup(s->iommu_table, &key);
+    S390PCIIOMMU *iommu;
+
+    if (!table) {
+        table = g_malloc0(sizeof(S390PCIIOMMUTable));
+        table->key = key;
+        g_hash_table_insert(s->iommu_table, &table->key, table);
+    }
+
+    iommu = table->iommu[PCI_SLOT(devfn)];
+    if (!iommu) {
+        iommu = S390_PCI_IOMMU(object_new(TYPE_S390_PCI_IOMMU));
+
+        char *mr_name = g_strdup_printf("iommu-root-%02x:%02x.%01x",
+                                        pci_bus_num(bus),
+                                        PCI_SLOT(devfn),
+                                        PCI_FUNC(devfn));
+        char *as_name = g_strdup_printf("iommu-pci-%02x:%02x.%01x",
+                                        pci_bus_num(bus),
+                                        PCI_SLOT(devfn),
+                                        PCI_FUNC(devfn));
+        memory_region_init(&iommu->mr, OBJECT(iommu), mr_name, UINT64_MAX);
+        address_space_init(&iommu->as, &iommu->mr, as_name);
+        table->iommu[PCI_SLOT(devfn)] = iommu;
+
+        g_free(mr_name);
+        g_free(as_name);
+    }
+
+    return iommu;
+}
+
 static AddressSpace *s390_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
     S390pciState *s = opaque;
+    S390PCIIOMMU *iommu = s390_pci_get_iommu(s, bus, devfn);
 
-    return &s->iommu[PCI_SLOT(devfn)]->as;
+    return &iommu->as;
 }
 
 static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
@@ -520,19 +557,22 @@ void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
     object_unparent(OBJECT(&iommu->iommu_mr));
 }
 
-static void s390_pcihost_init_as(S390pciState *s)
+static void s390_pci_iommu_free(PCIBus *bus, int32_t devfn)
 {
-    int i;
-    S390PCIIOMMU *iommu;
-
-    for (i = 0; i < PCI_SLOT_MAX; i++) {
-        iommu = g_malloc0(sizeof(S390PCIIOMMU));
-        memory_region_init(&iommu->mr, OBJECT(s),
-                           "iommu-root-s390", UINT64_MAX);
-        address_space_init(&iommu->as, &iommu->mr, "iommu-pci");
+    uint64_t key = (unsigned long)bus;
+    S390pciState *s = s390_get_phb();
+    S390PCIIOMMUTable *table = g_hash_table_lookup(s->iommu_table, &key);
+    S390PCIIOMMU *iommu = table ? table->iommu[PCI_SLOT(devfn)] : NULL;
 
-        s->iommu[i] = iommu;
+    if (!table || !iommu) {
+        return;
     }
+
+    table->iommu[PCI_SLOT(devfn)] = NULL;
+    address_space_destroy(&iommu->as);
+    object_unparent(OBJECT(&iommu->mr));
+    object_unparent(OBJECT(iommu));
+    object_unref(OBJECT(iommu));
 }
 
 static int s390_pcihost_init(SysBusDevice *dev)
@@ -548,7 +588,6 @@ static int s390_pcihost_init(SysBusDevice *dev)
                          s390_pci_set_irq, s390_pci_map_irq, NULL,
                          get_system_memory(), get_system_io(), 0, 64,
                          TYPE_PCI_BUS);
-    s390_pcihost_init_as(s);
     pci_setup_iommu(b, s390_pci_dma_iommu, s);
 
     bus = BUS(b);
@@ -558,6 +597,8 @@ static int s390_pcihost_init(SysBusDevice *dev)
     s->bus = S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, DEVICE(s), NULL));
     qbus_set_hotplug_handler(BUS(s->bus), DEVICE(s), NULL);
 
+    s->iommu_table = g_hash_table_new_full(g_int64_hash, g_int64_equal,
+                                           NULL, g_free);
     QTAILQ_INIT(&s->pending_sei);
     return 0;
 }
@@ -661,7 +702,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
         }
 
         pbdev->pdev = pdev;
-        pbdev->iommu = s->iommu[PCI_SLOT(pdev->devfn)];
+        pbdev->iommu = s390_pci_get_iommu(s, pdev->bus, pdev->devfn);
         pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_STANDBY;
 
@@ -708,8 +749,9 @@ static void s390_pcihost_timer_cb(void *opaque)
 static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
-    int i;
     PCIDevice *pci_dev = NULL;
+    PCIBus *bus;
+    int32_t devfn, i;
     S390PCIBusDevice *pbdev = NULL;
     S390pciState *s = s390_get_phb();
 
@@ -752,8 +794,11 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
 
     s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                  pbdev->fh, pbdev->fid);
+    bus = pci_dev->bus;
+    devfn = pci_dev->devfn;
     object_unparent(OBJECT(pci_dev));
     s390_pci_msix_free(pbdev);
+    s390_pci_iommu_free(bus, devfn);
     pbdev->pdev = NULL;
     pbdev->state = ZPCI_FS_RESERVED;
 out:
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 1d05c1a92e..fe108e9330 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -274,6 +274,11 @@ typedef struct S390PCIIOMMU {
     uint64_t pal;
 } S390PCIIOMMU;
 
+typedef struct S390PCIIOMMUTable {
+    uint64_t key;
+    S390PCIIOMMU *iommu[PCI_SLOT_MAX];
+} S390PCIIOMMUTable;
+
 typedef struct S390PCIBusDevice {
     DeviceState qdev;
     PCIDevice *pdev;
@@ -304,7 +309,7 @@ typedef struct S390pciState {
     PCIHostState parent_obj;
     S390PCIBus *bus;
     S390PCIBusDevice *pbdev[PCI_SLOT_MAX];
-    S390PCIIOMMU *iommu[PCI_SLOT_MAX];
+    GHashTable *iommu_table;
     QTAILQ_HEAD(, SeiContainer) pending_sei;
 } S390pciState;
 
-- 
2.11.0
