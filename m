Received: from eggs.gnu.org ([2001:4830:134:3::10]:41763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUz-0000yS-Ow
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUy-0006bo-QU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUy-0006b8-Ij
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUx-0002yp-LJ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:56 +0100
Message-Id: <20180531142357.904-25-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 24/25] ARM: ACPI: Fix use-after-free due to
 memory realloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Shannon Zhao <zhaoshenglong@huawei.com>

acpi_data_push uses g_array_set_size to resize the memory size. If there
is no enough contiguous memory, the address will be changed. So previous
pointer could not be used any more. It must update the pointer and use
the new one.

Also, previous codes wrongly use le32 conversion of iort->node_offset
for subsequent computations that will result incorrect value if host is
not litlle endian. So use the non-converted one instead.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1527663951-14552-1-git-send-email-zhaoshenglong@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 92ceee9c0f..74f5744e87 100644
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
@@ -413,7 +413,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     iort_length = sizeof(*iort);
     iort->node_count = cpu_to_le32(nb_nodes);
-    iort->node_offset = cpu_to_le32(sizeof(*iort));
+    /*
+     * Use a copy in case table_data->data moves during acpi_data_push
+     * operations.
+     */
+    iort_node_offset = sizeof(*iort);
+    iort->node_offset = cpu_to_le32(iort_node_offset);
 
     /* ITS group node */
     node_size =  sizeof(*its) + sizeof(uint32_t);
@@ -429,7 +434,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int irq =  vms->irqmap[VIRT_SMMU];
 
         /* SMMUv3 node */
-        smmu_offset = iort->node_offset + node_size;
+        smmu_offset = iort_node_offset + node_size;
         node_size = sizeof(*smmu) + sizeof(*idmap);
         iort_length += node_size;
         smmu = acpi_data_push(table_data, node_size);
@@ -450,7 +455,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         idmap->id_count = cpu_to_le32(0xFFFF);
         idmap->output_base = 0;
         /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference = cpu_to_le32(iort->node_offset);
+        idmap->output_reference = cpu_to_le32(iort_node_offset);
     }
 
     /* Root Complex Node */
@@ -479,9 +484,14 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         idmap->output_reference = cpu_to_le32(smmu_offset);
     } else {
         /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference = cpu_to_le32(iort->node_offset);
+        idmap->output_reference = cpu_to_le32(iort_node_offset);
     }
 
+    /*
+     * Update the pointer address in case table_data->data moves during above
+     * acpi_data_push operations.
+     */
+    iort = (AcpiIortTable *)(table_data->data + iort_start);
     iort->length = cpu_to_le32(iort_length);
 
     build_header(linker, table_data, (void *)(table_data->data + iort_start),
-- 
2.17.1
