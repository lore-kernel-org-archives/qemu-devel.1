Received: from eggs.gnu.org ([2001:4830:134:3::10]:58770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmlut-0006nS-67
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmluo-00078F-W2
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:47 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  6 Aug 2018 22:14:43 +0200
Message-Id: <1533586484-5737-16-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
References: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v7 15/16] hw/arm/virt-acpi-build: Add
 virtio-iommu node in IORT table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

This patch builds the virtio-iommu node in the ACPI IORT table.

The RID space of the root complex, which spans 0x0-0x10000
maps to streamid space 0x0-0x10000 in smmuv3, which in turn
maps to deviceid space 0x0-0x10000 in the ITS group.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt-acpi-build.c    | 39 ++++++++++++++++++++++++++++++++-------
 include/hw/acpi/acpi-defs.h | 21 ++++++++++++++++++++-
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6ea47e2..a856a31 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -403,14 +403,13 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiIortIdMapping *idmap;
     AcpiIortItsGroup *its;
     AcpiIortTable *iort;
-    AcpiIortSmmu3 *smmu;
-    size_t node_size, iort_node_offset, iort_length, smmu_offset = 0;
+    size_t node_size, iort_node_offset, iort_length, iommu_offset = 0;
     AcpiIortRC *rc;
 
     iort = acpi_data_push(table_data, sizeof(*iort));
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        nb_nodes = 3; /* RC, ITS, SMMUv3 */
+    if (vms->iommu) {
+        nb_nodes = 3; /* RC, ITS, IOMMU */
     } else {
         nb_nodes = 2; /* RC, ITS */
     }
@@ -435,10 +434,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     its->identifiers[0] = 0; /* MADT translation_id */
 
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+        AcpiIortSmmu3 *smmu;
         int irq =  vms->irqmap[VIRT_SMMU];
 
         /* SMMUv3 node */
-        smmu_offset = iort_node_offset + node_size;
+        iommu_offset = iort_node_offset + node_size;
         node_size = sizeof(*smmu) + sizeof(*idmap);
         iort_length += node_size;
         smmu = acpi_data_push(table_data, node_size);
@@ -460,6 +460,31 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         idmap->output_base = 0;
         /* output IORT node is the ITS group node (the first node) */
         idmap->output_reference = cpu_to_le32(iort_node_offset);
+    } else if (vms->iommu == VIRT_IOMMU_VIRTIO) {
+        AcpiIortPVIommu *iommu;
+        int irq = vms->irqmap[VIRT_VIRTIO_IOMMU];
+
+        /* Para-virtualized IOMMU node */
+        iommu_offset = iort_node_offset + node_size;
+        node_size = sizeof(*iommu) + sizeof(*idmap);
+        iort_length += node_size;
+        iommu = acpi_data_push(table_data, node_size);
+
+        iommu->type = ACPI_IORT_NODE_PARAVIRT;
+        iommu->length = cpu_to_le16(node_size);
+        iommu->base_address = cpu_to_le64(vms->memmap[VIRT_VIRTIO_IOMMU].base);
+        iommu->span = cpu_to_le64(vms->memmap[VIRT_VIRTIO_IOMMU].size);
+        iommu->model = ACPI_IORT_NODE_PV_VIRTIO_IOMMU;
+        iommu->flags = ACPI_IORT_NODE_PV_CACHE_COHERENT;
+        iommu->gsiv = cpu_to_le64(irq);
+
+        /* Identity RID mapping covering the whole input RID range */
+        idmap = &iommu->id_mapping_array[0];
+        idmap->input_base = 0;
+        idmap->id_count = cpu_to_le32(0xFFFF);
+        idmap->output_base = 0;
+        /* output IORT node is the ITS group node (the first node) */
+        idmap->output_reference = cpu_to_le32(iort_node_offset);
     }
 
     /* Root Complex Node */
@@ -483,9 +508,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     idmap->id_count = cpu_to_le32(0xFFFF);
     idmap->output_base = 0;
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+    if (vms->iommu) {
         /* output IORT node is the smmuv3 node */
-        idmap->output_reference = cpu_to_le32(smmu_offset);
+        idmap->output_reference = cpu_to_le32(iommu_offset);
     } else {
         /* output IORT node is the ITS group node (the first node) */
         idmap->output_reference = cpu_to_le32(iort_node_offset);
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index af8e023..1046409 100644
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
 
+struct AcpiIortPVIommu {
+    ACPI_IORT_NODE_HEADER_DEF
+    uint64_t base_address;
+    uint64_t span;
+    uint32_t model;
+    uint32_t flags;
+    uint64_t gsiv;
+    uint64_t reserved2;
+    AcpiIortIdMapping id_mapping_array[0];
+} QEMU_PACKED;
+typedef struct AcpiIortPVIommu AcpiIortPVIommu;
+
+enum {
+    ACPI_IORT_NODE_PV_VIRTIO_IOMMU = 0x00,
+};
+
+#define ACPI_IORT_NODE_PV_CACHE_COHERENT    (1 << 0)
+
 struct AcpiIortSmmu3 {
     ACPI_IORT_NODE_HEADER_DEF
     uint64_t base_address;
-- 
2.5.5
