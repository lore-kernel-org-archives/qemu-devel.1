Received: from eggs.gnu.org ([2001:4830:134:3::10]:41531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWJA9-0000Oi-Te
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWJA6-0005dJ-OA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:19:29 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 22 Jun 2018 12:19:09 +0200
Message-Id: <1529662749-32069-6-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529662749-32069-1-git-send-email-eric.auger@redhat.com>
References: <1529662749-32069-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 5/5] hw/arm/virt-acpi-build: Add PC-DIMM in SRAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Generate Memory Affinity Structures for PC-DIMM ranges.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 74f5744..38a6886 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -43,6 +43,7 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
+#include "hw/mem/memory-device.h"
 #include "sysemu/numa.h"
 #include "kvm_arm.h"
 
@@ -532,6 +533,35 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                  "SPCR", table_data->len - spcr_start, 2, NULL, NULL);
 }
 
+static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
+                                          uint64_t len, int default_node)
+{
+    MemoryDeviceInfoList *info_list = qmp_memory_device_list();
+    AcpiSratMemoryAffinity *numamem;
+    MemoryDeviceInfoList *info;
+    MemoryDeviceInfo *mi;
+    PCDIMMDeviceInfo *di;
+    uint64_t end = base + len, cur, size;
+
+    for (cur = base, info = info_list; cur < end;
+         cur += size, info = info->next) {
+        bool is_nvdimm;
+
+        if (!info) {
+            break;
+        }
+        numamem = acpi_data_push(table_data, sizeof(*numamem));
+
+        mi = info->value;
+        is_nvdimm = (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM);
+        di = !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
+
+        build_srat_memory(numamem, di->addr, di->size,
+                          0, MEM_AFFINITY_ENABLED);
+        size = di->size;
+    }
+}
+
 static void
 build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
@@ -564,6 +594,10 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         mem_base += numa_info[i].node_mem;
     }
 
+    build_srat_hotpluggable_memory(table_data,
+                                   vms->bootinfo.device_memory_start,
+                                   vms->bootinfo.device_memory_size , 0);
+
     build_header(linker, table_data, (void *)(table_data->data + srat_start),
                  "SRAT", table_data->len - srat_start, 3, NULL, NULL);
 }
-- 
2.5.5
