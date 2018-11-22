Received: from eggs.gnu.org ([2001:4830:134:3::10]:49901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gPsbK-0005dJ-5s
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gPsbH-0006wn-AB
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:17:14 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 22 Nov 2018 18:15:37 +0100
Message-Id: <20181122171538.12359-17-eric.auger@redhat.com>
In-Reply-To: <20181122171538.12359-1-eric.auger@redhat.com>
References: <20181122171538.12359-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v9 16/17] hw/arm/virt-acpi-build: Introduce
 fill_iort_idmap helper
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

To avoid code duplication, let's introduce an helper that
fills one IORT ID mappings array index.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v8: new
---
 hw/arm/virt-acpi-build.c | 43 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5785fb697c..ec7c4835fe 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -396,6 +396,17 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
     return rsdp_table;
 }
 
+static inline void
+fill_iort_idmap(AcpiIortIdMapping *idmap, int i,
+                uint32_t input_base, uint32_t id_count,
+                uint32_t output_base, uint32_t output_reference)
+{
+    idmap[i].input_base = cpu_to_le32(input_base);
+    idmap[i].id_count = cpu_to_le32(id_count);
+    idmap[i].output_base = cpu_to_le32(output_base);
+    idmap[i].output_reference = cpu_to_le32(output_reference);
+}
+
 static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
@@ -453,13 +464,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         smmu->gerr_gsiv = cpu_to_le32(irq + 2);
         smmu->sync_gsiv = cpu_to_le32(irq + 3);
 
-        /* Identity RID mapping covering the whole input RID range */
-        idmap = &smmu->id_mapping_array[0];
-        idmap->input_base = 0;
-        idmap->id_count = cpu_to_le32(0xFFFF);
-        idmap->output_base = 0;
-        /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference = cpu_to_le32(iort_node_offset);
+        /*
+         * Identity RID mapping covering the whole input RID range.
+         * The output IORT node is the ITS group node (the first node).
+         */
+        fill_iort_idmap(smmu->id_mapping_array, 0, 0, 0xffff, 0,
+                        iort_node_offset);
     }
 
     /* Root Complex Node */
@@ -477,18 +487,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     rc->memory_properties.memory_flags = 0x3; /* CCA = CPM = DCAS = 1 */
     rc->pci_segment_number = 0; /* MCFG pci_segment */
 
-    /* Identity RID mapping covering the whole input RID range */
-    idmap = &rc->id_mapping_array[0];
-    idmap->input_base = 0;
-    idmap->id_count = cpu_to_le32(0xFFFF);
-    idmap->output_base = 0;
-
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        /* output IORT node is the smmuv3 node */
-        idmap->output_reference = cpu_to_le32(smmu_offset);
+        /* Identity RID mapping and output IORT node is the iommu node */
+        fill_iort_idmap(rc->id_mapping_array, 0, 0, 0xFFFF, 0,
+                        smmu_offset);
     } else {
-        /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference = cpu_to_le32(iort_node_offset);
+        /*
+         * Identity RID mapping and the output IORT node is the ITS group
+         * node (the first node).
+         */
+        fill_iort_idmap(rc->id_mapping_array, 0, 0, 0xFFFF, 0,
+                        iort_node_offset);
     }
 
     /*
-- 
2.17.2
