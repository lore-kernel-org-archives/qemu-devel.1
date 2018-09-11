Received: from eggs.gnu.org ([2001:4830:134:3::10]:59502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1fzgoz-0006qi-4M
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1fzgoy-0000YB-BJ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:27:05 -0400
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Date: Tue, 11 Sep 2018 19:26:43 +0800
Message-Id: <20180911112643.19296-1-shenglong.zsl@alibaba-inc.com>
Subject: [Qemu-devel] [PATCH] hw/arm/virt-acpi-build: Add a check for
 memory-less NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

From: Shannon Zhao <shannon.zhaosl@gmail.com>

Like commit 16b4226(hw/acpi-build: Add a check for memory-less NUMA node
), it also needs to check memory length for NUMA nodes on ARM.

Signed-off-by: Shannon Zhao <shannon.zhaosl@gmail.com>
---
 hw/arm/virt-acpi-build.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ce31abd..5785fb6 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -562,10 +562,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     mem_base = vms->memmap[VIRT_MEM].base;
     for (i = 0; i < nb_numa_nodes; ++i) {
-        numamem = acpi_data_push(table_data, sizeof(*numamem));
-        build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
-                          MEM_AFFINITY_ENABLED);
-        mem_base += numa_info[i].node_mem;
+        if (numa_info[i].node_mem > 0) {
+            numamem = acpi_data_push(table_data, sizeof(*numamem));
+            build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
+                              MEM_AFFINITY_ENABLED);
+            mem_base += numa_info[i].node_mem;
+        }
     }
 
     build_header(linker, table_data, (void *)(table_data->data + srat_start),
-- 
2.9.3.windows.1
