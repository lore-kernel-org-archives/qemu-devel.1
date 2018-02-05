Received: from eggs.gnu.org ([2001:4830:134:3::10]:50887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eih0t-00057s-Cv
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eih0r-0005ex-Tk
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:40:51 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Feb 2018 14:39:20 +0100
Message-Id: <1517837972-1904-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1517837972-1904-1-git-send-email-eric.auger@redhat.com>
References: <1517837972-1904-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v8 02/14] hw/arm/smmu-common: IOMMU memory
 region and address space setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: tn@semihalf.com, mst@redhat.com, christoffer.dall@linaro.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, edgar.iglesias@gmail.com, linuc.decode@gmail.com, peterx@redhat.com

We enumerate all the PCI devices attached to the SMMU and
initialize an associated IOMMU memory region and address space.
This happens on SMMU base instance init.

Those info are stored in SMMUDevice objects. The devices are
grouped according to the PCIBus they belong to. A hash table
indexed by the PCIBus poinet is used. Also an array indexed by
the bus number allows to find the list of SMMUDevices.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v7 -> v8:
- introduce SMMU_MAX_VA_BITS
- use PCI bus handle as a key
- do not clear s->smmu_as_by_bus_num
- use g_new0 instead of g_malloc0
- use primary_bus field
---
 hw/arm/smmu-common.c         | 61 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/smmu-common.h |  6 +++++
 2 files changed, 67 insertions(+)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index c2f6b15..7bf8e57 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -32,8 +32,69 @@
 #include "qemu/error-report.h"
 #include "hw/arm/smmu-common.h"
 
+SMMUPciBus *smmu_find_as_from_bus_num(SMMUState *s, uint8_t bus_num)
+{
+    SMMUPciBus *smmu_pci_bus = s->smmu_as_by_bus_num[bus_num];
+
+    if (!smmu_pci_bus) {
+        GHashTableIter iter;
+
+        g_hash_table_iter_init(&iter, s->smmu_as_by_busptr);
+        while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
+            if (pci_bus_num(smmu_pci_bus->bus) == bus_num) {
+                s->smmu_as_by_bus_num[bus_num] = smmu_pci_bus;
+                return smmu_pci_bus;
+            }
+        }
+    }
+    return smmu_pci_bus;
+}
+
+static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *s = opaque;
+    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_as_by_busptr, &bus);
+    SMMUDevice *sdev;
+
+    if (!sbus) {
+        sbus = g_malloc0(sizeof(SMMUPciBus) +
+                         sizeof(SMMUDevice *) * SMMU_PCI_DEVFN_MAX);
+        sbus->bus = bus;
+        g_hash_table_insert(s->smmu_as_by_busptr, bus, sbus);
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        char *name = g_strdup_printf("%s-%d-%d",
+                                     s->mrtypename,
+                                     pci_bus_num(bus), devfn);
+        sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
+
+        sdev->smmu = s;
+        sdev->bus = bus;
+        sdev->devfn = devfn;
+
+        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
+                                 s->mrtypename,
+                                 OBJECT(s), name, 1ULL << SMMU_MAX_VA_BITS);
+        address_space_init(&sdev->as,
+                           MEMORY_REGION(&sdev->iommu), name);
+    }
+
+    return &sdev->as;
+}
+
 static void smmu_base_realize(DeviceState *dev, Error **errp)
 {
+    SMMUState *s = ARM_SMMU(dev);
+
+    s->smmu_as_by_busptr = g_hash_table_new(NULL, NULL);
+
+    if (s->primary_bus) {
+        pci_setup_iommu(s->primary_bus, smmu_find_add_as, s);
+    } else {
+        error_setg(errp, "SMMU is not attached to any PCI bus!");
+    }
 }
 
 static Property smmu_dev_properties[] = {
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 0f9af40..1495bce 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -123,4 +123,10 @@ typedef struct {
 #define ARM_SMMU_GET_CLASS(obj)                              \
     OBJECT_GET_CLASS(SMMUBaseClass, (obj), TYPE_ARm_SMMU)
 
+SMMUPciBus *smmu_find_as_from_bus_num(SMMUState *s, uint8_t bus_num);
+
+static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
+{
+    return  ((pci_bus_num(sdev->bus) & 0xff) << 8) | sdev->devfn;
+}
 #endif  /* HW_ARM_SMMU_COMMON */
-- 
2.5.5
