Received: from eggs.gnu.org ([2001:4830:134:3::10]:36200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpds-0004rO-Pt
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpdn-00024r-Pe
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:22:04 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:05 +0200
Message-Id: <1504286483-23327-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 02/20] hw/arm/smmu-common: IOMMU memory
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
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com, wtownsen@redhat.com

We enumerate all the PCI devices attached to the SMMU and
initialize an associated IOMMU memory region and address space.
This happens on SMMU base instance init.

Those info are stored in SMMUDevice objects. The devices are
grouped according to the PCIBus they belong to. A hash table
indexed by the PCIBus poinet is used. Also an array indexed by
the bus number allows to find the list of SMMUDevices.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-common.c         | 89 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/smmu-common.h |  6 +++
 2 files changed, 95 insertions(+)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 56608f1..3e67992 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -30,8 +30,97 @@
 #include "qemu/error-report.h"
 #include "hw/arm/smmu-common.h"
 
+/******************/
+/* Infrastructure */
+/******************/
+
+static inline gboolean smmu_uint64_equal(gconstpointer v1, gconstpointer v2)
+{
+    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
+}
+
+static inline guint smmu_uint64_hash(gconstpointer v)
+{
+    return (guint)*(const uint64_t *)v;
+}
+
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
+    uintptr_t key = (uintptr_t)bus;
+    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_as_by_busptr, &key);
+    SMMUDevice *sdev;
+
+    if (!sbus) {
+        uintptr_t *new_key = g_malloc(sizeof(*new_key));
+
+        *new_key = (uintptr_t)bus;
+        sbus = g_malloc0(sizeof(SMMUPciBus) +
+                         sizeof(SMMUDevice *) * SMMU_PCI_DEVFN_MAX);
+        sbus->bus = bus;
+        g_hash_table_insert(s->smmu_as_by_busptr, new_key, sbus);
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        char *name = g_strdup_printf("%s-%d-%d",
+                                     s->mrtypename,
+                                     pci_bus_num(bus), devfn);
+        sdev = sbus->pbdev[devfn] = g_malloc0(sizeof(SMMUDevice));
+
+        sdev->smmu = s;
+        sdev->bus = bus;
+        sdev->devfn = devfn;
+
+        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
+                                 s->mrtypename,
+                                 OBJECT(s), name, 1ULL << 48);
+        address_space_init(&sdev->as,
+                           MEMORY_REGION(&sdev->iommu), name);
+    }
+
+    return &sdev->as;
+}
+
+static void smmu_init_iommu_as(SMMUState *s)
+{
+    PCIBus *pcibus = pci_find_primary_bus();
+
+    if (pcibus) {
+        pci_setup_iommu(pcibus, smmu_find_add_as, s);
+    } else {
+        error_report("No PCI bus, SMMU is not registered");
+    }
+}
+
 static void smmu_base_instance_init(Object *obj)
 {
+    SMMUState *s = SMMU_SYS_DEV(obj);
+
+    memset(s->smmu_as_by_bus_num, 0, sizeof(s->smmu_as_by_bus_num));
+
+    s->smmu_as_by_busptr = g_hash_table_new_full(smmu_uint64_hash,
+                                                 smmu_uint64_equal,
+                                                 g_free, g_free);
+    smmu_init_iommu_as(s);
 }
 
 static void smmu_base_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 38cd18f..20f3fe6 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -105,4 +105,10 @@ typedef struct {
 #define SMMU_DEVICE_CLASS(klass)                                    \
     OBJECT_CLASS_CHECK(SMMUBaseClass, (klass), TYPE_SMMU_DEV_BASE)
 
+SMMUPciBus *smmu_find_as_from_bus_num(SMMUState *s, uint8_t bus_num);
+
+static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
+{
+    return  ((pci_bus_num(sdev->bus) & 0xff) << 8) | sdev->devfn;
+}
 #endif  /* HW_ARM_SMMU_COMMON */
-- 
2.5.5
