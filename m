Received: from eggs.gnu.org ([2001:4830:134:3::10]:35413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhuyijun@huawei.com>) id 1eEPqC-0002ly-OM
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 20:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhuyijun@huawei.com>) id 1eEPq9-0003pa-Ga
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 20:16:40 -0500
From: <zhuyijun@huawei.com>
Date: Tue, 14 Nov 2017 09:15:54 +0800
Message-ID: <1510622154-17224-6-git-send-email-zhuyijun@huawei.com>
In-Reply-To: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 5/5] hw/arm/virt-acpi-build: Build srat table
 according to mem_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com
Cc: peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, zhaoshenglong@huawei.com

From: Zhu Yijun <zhuyijun@huawei.com>

In case of accessing memory holes, we build srat table by
traversing mem_list.

Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
---
 hw/arm/virt-acpi-build.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3d78ff6..e8dd7c9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -487,7 +487,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiSratProcessorGiccAffinity *core;
     AcpiSratMemoryAffinity *numamem;
     int i, srat_start;
-    uint64_t mem_base;
+    hwaddr region_offset = 0;       /* region base addr offset */
+    hwaddr region_eat_size = 0;     /* region consumed size */
+    hwaddr node_mem_size = 0;
+    RAMRegion *begin_search_region = QLIST_FIRST(&vms->bootinfo.mem_list);
+    RAMRegion *reg;
+
     MachineClass *mc = MACHINE_GET_CLASS(vms);
     const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
 
@@ -504,12 +509,37 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         core->flags = cpu_to_le32(1);
     }
 
-    mem_base = vms->memmap[VIRT_MEM].base;
     for (i = 0; i < nb_numa_nodes; ++i) {
         numamem = acpi_data_push(table_data, sizeof(*numamem));
-        build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
-                          MEM_AFFINITY_ENABLED);
-        mem_base += numa_info[i].node_mem;
+        node_mem_size = numa_info[i].node_mem;
+        QLIST_FOREACH(reg, &vms->bootinfo.mem_list, next) {
+            if (reg->base != begin_search_region->base) {
+                continue;
+            }
+
+            if (node_mem_size >= (reg->size - region_offset)) {
+                region_eat_size = reg->size - region_offset;
+            } else {
+                region_eat_size = node_mem_size;
+            }
+
+            build_srat_memory(numamem, reg->base + region_offset,
+                              region_eat_size, i, MEM_AFFINITY_ENABLED);
+
+            node_mem_size -= region_eat_size;
+            region_offset += region_eat_size;
+            begin_search_region = reg;
+
+            /* The region is depleted */
+            if (reg->size == region_offset) {
+                region_offset = 0;
+                begin_search_region = QLIST_NEXT(reg, next);
+            }
+
+            if (node_mem_size == 0) {
+                break;
+            }
+        }
     }
 
     build_header(linker, table_data, (void *)srat, "SRAT",
-- 
1.8.3.1
