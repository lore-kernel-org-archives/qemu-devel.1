Received: from eggs.gnu.org ([2001:4830:134:3::10]:49941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gPsbM-0005fd-9h
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gPsbK-00072U-D8
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:17:16 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 22 Nov 2018 18:15:38 +0100
Message-Id: <20181122171538.12359-18-eric.auger@redhat.com>
In-Reply-To: <20181122171538.12359-1-eric.auger@redhat.com>
References: <20181122171538.12359-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v9 17/17] hw/arm/virt-acpi-build: Add
 virtio-iommu node in IORT table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: kevin.tian@intel.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com

This patch builds the virtio-iommu node in the ACPI IORT table.

The RID space of the root complex, which spans 0x0-0x10000
maps to streamid space 0x0-0x10000 in the virtio-iommu which in
turn maps to deviceid space 0x0-0x10000 in the ITS group.

The iommu RID is excluded as described in virtio-iommu
specification.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v8 -> v9:
- iommu RID is not fixed anymore

v7 -> v8:
- exclude the iommu RID (0x8) in the root complex ID mapping
---
 hw/arm/virt-acpi-build.c    | 50 ++++++++++++++++++++++++++++++-------
 include/hw/acpi/acpi-defs.h | 21 +++++++++++++++-
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ec7c4835fe..0e621f6551 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -414,14 +414,14 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiIortIdMapping *idmap;
     AcpiIortItsGroup *its;
     AcpiIortTable *iort;
-    AcpiIortSmmu3 *smmu;
-    size_t node_size, iort_node_offset, iort_length, smmu_offset = 0;
+    size_t node_size, iort_node_offset, iort_length, iommu_offset = 0;
     AcpiIortRC *rc;
+    int nb_rc_idmappings = 1;
 
     iort = acpi_data_push(table_data, sizeof(*iort));
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        nb_nodes = 3; /* RC, ITS, SMMUv3 */
+    if (vms->iommu) {
+        nb_nodes = 3; /* RC, ITS, IOMMU */
     } else {
         nb_nodes = 2; /* RC, ITS */
     }
@@ -446,10 +446,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     its->identifiers[0] = 0; /* MADT translation_id */
 
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+        AcpiIortSmmu3 *smmu;
         int irq =  vms->irqmap[VIRT_SMMU];
 
-        /* SMMUv3 node */
-        smmu_offset = iort_node_offset + node_size;
+        iommu_offset = iort_node_offset + node_size;
         node_size = sizeof(*smmu) + sizeof(*idmap);
         iort_length += node_size;
         smmu = acpi_data_push(table_data, node_size);
@@ -470,16 +470,38 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
          */
         fill_iort_idmap(smmu->id_mapping_array, 0, 0, 0xffff, 0,
                         iort_node_offset);
+    } else if (vms->iommu == VIRT_IOMMU_VIRTIO) {
+        AcpiIortPVIommuPCI *iommu;
+
+        nb_rc_idmappings = 2;
+        iommu_offset = iort_node_offset + node_size;
+        node_size = sizeof(*iommu) + sizeof(*idmap);
+        iort_length += node_size;
+        iommu = acpi_data_push(table_data, node_size);
+
+        iommu->type = ACPI_IORT_NODE_PARAVIRT;
+        iommu->length = cpu_to_le16(node_size);
+        iommu->mapping_count = cpu_to_le32(2);
+        iommu->mapping_offset = cpu_to_le32(sizeof(*iommu));
+        iommu->devid = cpu_to_le32(vms->virtio_iommu_bdf);
+        iommu->model = cpu_to_le32(ACPI_IORT_NODE_PV_VIRTIO_IOMMU_PCI);
+
+        /*
+         * Identity RID mapping covering the whole input RID range
+         * output IORT node is the ITS group node (the first node)
+         */
+        fill_iort_idmap(iommu->id_mapping_array, 0, 0, 0xffff, 0,
+                        iort_node_offset);
     }
 
     /* Root Complex Node */
-    node_size = sizeof(*rc) + sizeof(*idmap);
+    node_size = sizeof(*rc) + nb_rc_idmappings * sizeof(*idmap);
     iort_length += node_size;
     rc = acpi_data_push(table_data, node_size);
 
     rc->type = ACPI_IORT_NODE_PCI_ROOT_COMPLEX;
     rc->length = cpu_to_le16(node_size);
-    rc->mapping_count = cpu_to_le32(1);
+    rc->mapping_count = cpu_to_le32(nb_rc_idmappings);
     rc->mapping_offset = cpu_to_le32(sizeof(*rc));
 
     /* fully coherent device */
@@ -490,7 +512,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
         /* Identity RID mapping and output IORT node is the iommu node */
         fill_iort_idmap(rc->id_mapping_array, 0, 0, 0xFFFF, 0,
-                        smmu_offset);
+                        iommu_offset);
+    } else if (vms->iommu == VIRT_IOMMU_VIRTIO) {
+        /*
+         * Identity mapping with the IOMMU RID (0x8) excluded. The output
+         * IORT node is the iommu node.
+         */
+        fill_iort_idmap(rc->id_mapping_array, 0, 0, vms->virtio_iommu_bdf, 0,
+                        iommu_offset);
+        fill_iort_idmap(rc->id_mapping_array, 1, vms->virtio_iommu_bdf + 1,
+                        0xFFFF - vms->virtio_iommu_bdf,
+                        vms->virtio_iommu_bdf + 1, iommu_offset);
     } else {
         /*
          * Identity RID mapping and the output IORT node is the ITS group
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index af8e023968..b14aa95dc1 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -601,7 +601,8 @@ enum {
         ACPI_IORT_NODE_NAMED_COMPONENT = 0x01,
         ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
         ACPI_IORT_NODE_SMMU = 0x03,
-        ACPI_IORT_NODE_SMMU_V3 = 0x04
+        ACPI_IORT_NODE_SMMU_V3 = 0x04,
+        ACPI_IORT_NODE_PARAVIRT = 0x80
 };
 
 struct AcpiIortIdMapping {
@@ -628,6 +629,24 @@ struct AcpiIortItsGroup {
 } QEMU_PACKED;
 typedef struct AcpiIortItsGroup AcpiIortItsGroup;
 
+struct AcpiIortPVIommuPCI {
+    ACPI_IORT_NODE_HEADER_DEF
+    uint32_t devid;
+    uint8_t reserved2[12];
+    uint32_t model;
+    uint32_t flags;
+    uint8_t reserved3[16];
+    AcpiIortIdMapping id_mapping_array[0];
+} QEMU_PACKED;
+typedef struct AcpiIortPVIommuPCI AcpiIortPVIommuPCI;
+
+enum {
+    ACPI_IORT_NODE_PV_VIRTIO_IOMMU     = 0x0,
+    ACPI_IORT_NODE_PV_VIRTIO_IOMMU_PCI = 0x1,
+};
+
+#define ACPI_IORT_NODE_PV_CACHE_COHERENT    (1 << 0)
+
 struct AcpiIortSmmu3 {
     ACPI_IORT_NODE_HEADER_DEF
     uint64_t base_address;
-- 
2.17.2
