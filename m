Received: from eggs.gnu.org ([2001:4830:134:3::10]:45965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa2YA-0000Q4-6d
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa2Y8-0006rE-SU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:23:42 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  2 Jul 2018 19:22:37 +0200
Message-Id: <1530552162-15533-11-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1530552162-15533-1-git-send-email-eric.auger@redhat.com>
References: <1530552162-15533-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 10/15] acpi: move
 build_srat_hotpluggable_memory to generic ACPI source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

We plan to reuse build_srat_hotpluggable_memory() for ARM so
let's move the function to aml-build.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/acpi/aml-build.c         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 49 -------------------------------------------
 include/hw/acpi/aml-build.h |  3 +++
 3 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 1e43cd7..167fb6b 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include <glib/gprintf.h>
 #include "hw/acpi/aml-build.h"
+#include "hw/mem/memory-device.h"
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
 #include "sysemu/numa.h"
@@ -1802,3 +1803,53 @@ build_hdr:
     build_header(linker, tbl, (void *)(tbl->data + fadt_start),
                  "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
 }
+
+void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
+                                    uint64_t len, int default_node)
+{
+    MemoryDeviceInfoList *info_list = qmp_memory_device_list();
+    MemoryDeviceInfoList *info;
+    MemoryDeviceInfo *mi;
+    PCDIMMDeviceInfo *di;
+    uint64_t end = base + len, cur, size;
+    bool is_nvdimm;
+    AcpiSratMemoryAffinity *numamem;
+    MemoryAffinityFlags flags;
+
+    for (cur = base, info = info_list;
+         cur < end;
+         cur += size, info = info->next) {
+        numamem = acpi_data_push(table_data, sizeof *numamem);
+
+        if (!info) {
+            build_srat_memory(numamem, cur, end - cur, default_node,
+                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+            break;
+        }
+
+        mi = info->value;
+        is_nvdimm = (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM);
+        di = !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
+
+        if (cur < di->addr) {
+            build_srat_memory(numamem, cur, di->addr - cur, default_node,
+                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+            numamem = acpi_data_push(table_data, sizeof *numamem);
+        }
+
+        size = di->size;
+
+        flags = MEM_AFFINITY_ENABLED;
+        if (di->hotpluggable) {
+            flags |= MEM_AFFINITY_HOTPLUGGABLE;
+        }
+        if (is_nvdimm) {
+            flags |= MEM_AFFINITY_NON_VOLATILE;
+        }
+
+        build_srat_memory(numamem, di->addr, size, di->node, flags);
+    }
+
+    qapi_free_MemoryDeviceInfoList(info_list);
+}
+
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9bc6d97..fcebd02 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2251,55 +2251,6 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 #define HOLE_640K_START  (640 * 1024)
 #define HOLE_640K_END   (1024 * 1024)
 
-static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
-                                           uint64_t len, int default_node)
-{
-    MemoryDeviceInfoList *info_list = qmp_memory_device_list();
-    MemoryDeviceInfoList *info;
-    MemoryDeviceInfo *mi;
-    PCDIMMDeviceInfo *di;
-    uint64_t end = base + len, cur, size;
-    bool is_nvdimm;
-    AcpiSratMemoryAffinity *numamem;
-    MemoryAffinityFlags flags;
-
-    for (cur = base, info = info_list;
-         cur < end;
-         cur += size, info = info->next) {
-        numamem = acpi_data_push(table_data, sizeof *numamem);
-
-        if (!info) {
-            build_srat_memory(numamem, cur, end - cur, default_node,
-                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
-            break;
-        }
-
-        mi = info->value;
-        is_nvdimm = (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM);
-        di = !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
-
-        if (cur < di->addr) {
-            build_srat_memory(numamem, cur, di->addr - cur, default_node,
-                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
-            numamem = acpi_data_push(table_data, sizeof *numamem);
-        }
-
-        size = di->size;
-
-        flags = MEM_AFFINITY_ENABLED;
-        if (di->hotpluggable) {
-            flags |= MEM_AFFINITY_HOTPLUGGABLE;
-        }
-        if (is_nvdimm) {
-            flags |= MEM_AFFINITY_NON_VOLATILE;
-        }
-
-        build_srat_memory(numamem, di->addr, size, di->node, flags);
-    }
-
-    qapi_free_MemoryDeviceInfoList(info_list);
-}
-
 static void
 build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 6c36903..4c2ca13 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -416,4 +416,7 @@ void build_slit(GArray *table_data, BIOSLinker *linker);
 
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);
+
+void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
+                                    uint64_t len, int default_node);
 #endif
-- 
2.5.5
