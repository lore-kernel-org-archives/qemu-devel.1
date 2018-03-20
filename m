Received: from eggs.gnu.org ([2001:4830:134:3::10]:42652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGWn-0007DN-Rj
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGWm-0003C2-Ff
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:09 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 20 Mar 2018 13:37:24 +0100
Message-Id: <1521549456-14072-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
References: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v10 02/14] hw/arm/smmu-common: IOMMU memory
 region and address space setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, prem.mallappa@gmail.com
Cc: alex.williamson@redhat.com, tn@semihalf.com, mst@redhat.com, cdall@kernel.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, linuc.decode@gmail.com, peterx@redhat.com, jintack@cs.columbia.edu

We set up the infrastructure to enumerate all the PCI devices
attached to the SMMU and create an associated IOMMU memory
region and address space.

Those info are stored in SMMUDevice objects. The devices are
grouped according to the PCIBus they belong to. A hash table
indexed by the PCIBus pointer is used. Also an array indexed by
the bus number allows to find the list of SMMUDevices.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>

---
v9 -> v10:
- comment functions added to the header
- g_free(name)
- renamed smmu_find_as_from_bus_num into smmu_find_smmu_pcibus
- add a comment about lazy init in smmu_find_smmu_pcibus
- add a trace event when creating the smmu iommu mr

v8 -> v9:
- fix key value for lookup

v7 -> v8:
- introduce SMMU_MAX_VA_BITS
- use PCI bus handle as a key
- do not clear s->smmu_as_by_bus_num
- use g_new0 instead of g_malloc0
- use primary_bus field
---
 hw/arm/smmu-common.c         | 67 ++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events          |  3 ++
 include/hw/arm/smmu-common.h |  8 ++++++
 3 files changed, 78 insertions(+)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index f4cda1f..fe0cd70 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -28,6 +28,66 @@
 #include "qemu/error-report.h"
 #include "hw/arm/smmu-common.h"
 
+/**
+ * The bus number is used for lookup when SID based invalidatation occurs.
+ * In that case we lazily populate the SMMUPciBus array from the bus hash
+ * table. At the time the SMMUPciBus is created (smmu_find_add_as), the bus
+ * numbers may not be always initialized yet.
+ */
+SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
+{
+    SMMUPciBus *smmu_pci_bus = s->smmu_pcibus_by_bus_num[bus_num];
+
+    if (!smmu_pci_bus) {
+        GHashTableIter iter;
+
+        g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
+        while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
+            if (pci_bus_num(smmu_pci_bus->bus) == bus_num) {
+                s->smmu_pcibus_by_bus_num[bus_num] = smmu_pci_bus;
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
+    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
+    SMMUDevice *sdev;
+
+    if (!sbus) {
+        sbus = g_malloc0(sizeof(SMMUPciBus) +
+                         sizeof(SMMUDevice *) * SMMU_PCI_DEVFN_MAX);
+        sbus->bus = bus;
+        g_hash_table_insert(s->smmu_pcibus_by_busptr, bus, sbus);
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
+        trace_smmu_add_mr(name);
+        g_free(name);
+    }
+
+    return &sdev->as;
+}
+
 static void smmu_base_realize(DeviceState *dev, Error **errp)
 {
     SMMUState *s = ARM_SMMU(dev);
@@ -42,6 +102,13 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
 
     s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
     s->iotlb = g_hash_table_new_full(NULL, NULL, NULL, g_free);
+    s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
+
+    if (s->primary_bus) {
+        pci_setup_iommu(s->primary_bus, smmu_find_add_as, s);
+    } else {
+        error_setg(errp, "SMMU is not attached to any PCI bus!");
+    }
 }
 
 static void smmu_base_reset(DeviceState *dev)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 193063e..8e8b53c 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -2,3 +2,6 @@
 
 # hw/arm/virt-acpi-build.c
 virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
+
+# hw/arm/smmu-common.c
+smmu_add_mr(const char *name) "%s"
\ No newline at end of file
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5910692..76cf4aa 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -121,4 +121,12 @@ typedef struct {
 #define ARM_SMMU_GET_CLASS(obj)                              \
     OBJECT_GET_CLASS(SMMUBaseClass, (obj), TYPE_ARM_SMMU)
 
+/* Return the SMMUPciBus handle associated to a PCI bus number */
+SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
+
+/* Return the stream ID of an SMMU device */
+static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
+{
+    return  ((pci_bus_num(sdev->bus) & 0xff) << 8) | sdev->devfn;
+}
 #endif  /* HW_ARM_SMMU_COMMON */
-- 
2.5.5
