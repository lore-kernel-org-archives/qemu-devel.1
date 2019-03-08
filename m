Received: from eggs.gnu.org ([209.51.188.92]:40540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1h2Dvh-0008Id-Fy
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1h2Dvf-0006ID-LK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:44:44 -0500
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Fri, 8 Mar 2019 11:42:14 +0000
Message-ID: <20190308114218.26692-8-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
References: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 07/11] hw/arm/virt-acpi-build: Add PC-DIMM
 in SRAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com
Cc: linuxarm@huawei.com, xuwei5@hisilicon.com

Generate Memory Affinity Structures for PC-DIMM ranges.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/virt-acpi-build.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 87d66da..6cb7263 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -524,6 +524,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     int i, srat_start;
     uint64_t mem_base;
     MachineClass *mc = MACHINE_GET_CLASS(vms);
+    MachineState *ms = MACHINE(vms);
     const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
 
     srat_start = table_data->len;
@@ -549,6 +550,14 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
+    if (ms->device_memory) {
+        numamem = acpi_data_push(table_data, sizeof *numamem);
+        build_srat_memory(numamem, ms->device_memory->base,
+                          memory_region_size(&ms->device_memory->mr),
+                          nb_numa_nodes - 1,
+                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+    }
+
     build_header(linker, table_data, (void *)(table_data->data + srat_start),
                  "SRAT", table_data->len - srat_start, 3, NULL, NULL);
 }
-- 
2.7.4
