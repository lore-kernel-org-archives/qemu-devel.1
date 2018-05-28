Received: from eggs.gnu.org ([2001:4830:134:3::10]:50751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fNDlq-0008T7-Mm
	for qemu-devel@nongnu.org; Mon, 28 May 2018 04:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fNDlp-0003tB-Jd
	for qemu-devel@nongnu.org; Mon, 28 May 2018 04:44:50 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Mon, 28 May 2018 16:42:26 +0800
Message-ID: <1527496946-12036-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] ARM: ACPI: Fix use-after-free due to memory
 realloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, Shannon Zhao <zhaoshenglong@huawei.com>

acpi_data_push uses g_array_set_size to resize the memory size. If there
is no enough contiguous memory, the address will be changed. So previous
pointer could not be used any more. It must update the pointer and use
the new one.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
---
 hw/arm/virt-acpi-build.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 92ceee9..30584ee 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -400,7 +400,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiIortItsGroup *its;
     AcpiIortTable *iort;
     AcpiIortSmmu3 *smmu;
-    size_t node_size, iort_length, smmu_offset = 0;
+    size_t node_size, iort_node_offset, iort_length, smmu_offset = 0;
     AcpiIortRC *rc;
 
     iort = acpi_data_push(table_data, sizeof(*iort));
@@ -414,6 +414,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     iort_length = sizeof(*iort);
     iort->node_count = cpu_to_le32(nb_nodes);
     iort->node_offset = cpu_to_le32(sizeof(*iort));
+    iort_node_offset = iort->node_offset;
 
     /* ITS group node */
     node_size =  sizeof(*its) + sizeof(uint32_t);
@@ -429,7 +430,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int irq =  vms->irqmap[VIRT_SMMU];
 
         /* SMMUv3 node */
-        smmu_offset = iort->node_offset + node_size;
+        smmu_offset = iort_node_offset + node_size;
         node_size = sizeof(*smmu) + sizeof(*idmap);
         iort_length += node_size;
         smmu = acpi_data_push(table_data, node_size);
@@ -450,7 +451,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         idmap->id_count = cpu_to_le32(0xFFFF);
         idmap->output_base = 0;
         /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference = cpu_to_le32(iort->node_offset);
+        idmap->output_reference = cpu_to_le32(iort_node_offset);
     }
 
     /* Root Complex Node */
@@ -479,9 +480,14 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         idmap->output_reference = cpu_to_le32(smmu_offset);
     } else {
         /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference = cpu_to_le32(iort->node_offset);
+        idmap->output_reference = cpu_to_le32(iort_node_offset);
     }
 
+    /*
+     * Update the pointer address in case table_data->data moved during above
+     * acpi_data_push operations.
+     */
+    iort = (AcpiIortTable *)(table_data->data + iort_start);
     iort->length = cpu_to_le32(iort_length);
 
     build_header(linker, table_data, (void *)(table_data->data + iort_start),
-- 
2.0.4
