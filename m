Received: from eggs.gnu.org ([2001:4830:134:3::10]:41535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWJA9-0000Ol-Ud
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWJA6-0005dT-Pf
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:19:29 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 22 Jun 2018 12:19:08 +0200
Message-Id: <1529662749-32069-5-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529662749-32069-1-git-send-email-eric.auger@redhat.com>
References: <1529662749-32069-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 4/5] hw/arm/boot: Expose the PC-DIMM nodes in the
 DT
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

This patch add memory nodes corresponding to PC-DIMM
regions.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/boot.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index cc425ce..81668bd 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -19,6 +19,7 @@
 #include "sysemu/numa.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
+#include "hw/mem/memory-device.h"
 #include "elf.h"
 #include "sysemu/device_tree.h"
 #include "qemu/config-file.h"
@@ -516,6 +517,37 @@ static void fdt_add_psci_node(void *fdt)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
+static int fdt_add_hotpluggable_memory_nodes(void *fdt,
+                                             uint64_t base, uint64_t len,
+                                             uint32_t acells, uint32_t scells) {
+    MemoryDeviceInfoList *info_list = qmp_memory_device_list();
+    MemoryDeviceInfoList *info;
+    uint64_t end, cur, size;
+    MemoryDeviceInfo *mi;
+    PCDIMMDeviceInfo *di;
+    bool is_nvdimm;
+    int ret;
+
+    end = base + len;
+    for (cur = base, info = info_list; cur < end;
+         cur += size, info = info->next) {
+        if (!info) {
+            break;
+        }
+        mi = info->value;
+        is_nvdimm = (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM);
+        di = !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
+
+        ret = fdt_add_memory_node(fdt, acells, di->addr,
+                                  scells, di->size, di->node);
+        if (ret < 0) {
+            return ret;
+        }
+        size = di->size;
+    }
+    return 0;
+}
+
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as)
 {
@@ -600,6 +632,14 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     }
 
+    rc = fdt_add_hotpluggable_memory_nodes(fdt, binfo->device_memory_start,
+                                           binfo->device_memory_size,
+                                           acells, scells);
+    if (rc < 0) {
+            fprintf(stderr, "couldn't add hotpluggable memory nodes\n");
+            goto fail;
+    }
+
     rc = fdt_path_offset(fdt, "/chosen");
     if (rc < 0) {
         qemu_fdt_add_subnode(fdt, "/chosen");
-- 
2.5.5
