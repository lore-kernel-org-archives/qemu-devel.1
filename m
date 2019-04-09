Received: from eggs.gnu.org ([209.51.188.92]:47826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo26-0006Fx-QS
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo25-0007MC-S3
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:14 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Tue, 9 Apr 2019 11:29:33 +0100
Message-ID: <20190409102935.28292-7-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 6/8] hw/arm/virt-acpi-build: Add PC-DIMM in
 SRAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com, imammedo@redhat.com
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com, xuwei5@hisilicon.com, lersek@redhat.com, ard.biesheuvel@linaro.org, linuxarm@huawei.com

Generate Memory Affinity Structures for PC-DIMM ranges.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/virt-acpi-build.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1ad394b..1b9a9b9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -518,6 +518,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     int i, srat_start;
     uint64_t mem_base;
     MachineClass *mc = MACHINE_GET_CLASS(vms);
+    MachineState *ms = MACHINE(vms);
     const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
 
     srat_start = table_data->len;
@@ -543,6 +544,14 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
