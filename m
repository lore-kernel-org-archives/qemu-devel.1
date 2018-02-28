Received: from eggs.gnu.org ([2001:4830:134:3::10]:54600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqsxc-0004W9-MO
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqsxZ-0002Le-CV
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:03:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:46587)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqsxZ-0002Kn-41
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:03:17 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 28 Feb 2018 12:02:58 +0800
Message-Id: <20180228040300.8914-2-haozhong.zhang@intel.com>
In-Reply-To: <20180228040300.8914-1-haozhong.zhang@intel.com>
References: <20180228040300.8914-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 1/3] hw/acpi-build: build SRAT memory
 affinity structures for DIMM devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

ACPI 6.2A Table 5-129 "SPA Range Structure" requires the proximity
domain of a NVDIMM SPA range must match with corresponding entry in
SRAT table.

The address ranges of vNVDIMM in QEMU are allocated from the
hot-pluggable address space, which is entirely covered by one SRAT
memory affinity structure. However, users can set the vNVDIMM
proximity domain in NFIT SPA range structure by the 'node' property of
'-device nvdimm' to a value different than the one in the above SRAT
memory affinity structure.

In order to solve such proximity domain mismatch, this patch builds
one SRAT memory affinity structure for each static-plugged DIMM device,
including both PC-DIMM and NVDIMM, with the proximity domain specified
in '-device pc-dimm' or '-device nvdimm'.

The remaining hot-pluggable address space is covered by one or multiple
SRAT memory affinity structures with the proximity domain of the last
node as before.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hw/i386/acpi-build.c     | 50 ++++++++++++++++++++++++++++++++++++++++++++----
 hw/mem/pc-dimm.c         |  8 ++++++++
 include/hw/mem/pc-dimm.h | 10 ++++++++++
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index deb440f286..a88de06d8f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2323,6 +2323,49 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 #define HOLE_640K_START  (640 * 1024)
 #define HOLE_640K_END   (1024 * 1024)
 
+static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
+                                           uint64_t len, int default_node)
+{
+    GSList *dimms = pc_dimm_get_device_list();
+    GSList *ent = dimms;
+    PCDIMMDevice *dev;
+    Object *obj;
+    uint64_t end = base + len, addr, size;
+    int node;
+    AcpiSratMemoryAffinity *numamem;
+
+    while (base < end) {
+        numamem = acpi_data_push(table_data, sizeof *numamem);
+
+        if (!ent) {
+            build_srat_memory(numamem, base, end - base, default_node,
+                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+            break;
+        }
+
+        dev = PC_DIMM(ent->data);
+        obj = OBJECT(dev);
+        addr = object_property_get_uint(obj, PC_DIMM_ADDR_PROP, NULL);
+        size = object_property_get_uint(obj, PC_DIMM_SIZE_PROP, NULL);
+        node = object_property_get_uint(obj, PC_DIMM_NODE_PROP, NULL);
+
+        if (base < addr) {
+            build_srat_memory(numamem, base, addr - base, default_node,
+                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+            numamem = acpi_data_push(table_data, sizeof *numamem);
+        }
+        build_srat_memory(numamem, addr, size, node,
+                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED |
+                          (object_dynamic_cast(obj, TYPE_NVDIMM) ?
+                           MEM_AFFINITY_NON_VOLATILE : 0));
+
+        base = addr + size;
+        ent = g_slist_next(ent);
+    }
+
+    g_slist_free(dimms);
+}
+
 static void
 build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
@@ -2434,10 +2477,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
      * providing _PXM method if necessary.
      */
     if (hotplugabble_address_space_size) {
-        numamem = acpi_data_push(table_data, sizeof *numamem);
-        build_srat_memory(numamem, pcms->hotplug_memory.base,
-                          hotplugabble_address_space_size, pcms->numa_nodes - 1,
-                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+        build_srat_hotpluggable_memory(table_data, pcms->hotplug_memory.base,
+                                       hotplugabble_address_space_size,
+                                       pcms->numa_nodes - 1);
     }
 
     build_header(linker, table_data,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 6e74b61cb6..9fd901e87a 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -276,6 +276,14 @@ static int pc_dimm_built_list(Object *obj, void *opaque)
     return 0;
 }
 
+GSList *pc_dimm_get_device_list(void)
+{
+    GSList *list = NULL;
+
+    object_child_foreach(qdev_get_machine(), pc_dimm_built_list, &list);
+    return list;
+}
+
 uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
                                uint64_t address_space_size,
                                uint64_t *hint, uint64_t align, uint64_t size,
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index d83b957829..4cf5cc49e9 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -100,4 +100,14 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
                          MemoryRegion *mr, uint64_t align, Error **errp);
 void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
                            MemoryRegion *mr);
+
+/*
+ * Return a list of DeviceState of pc-dimm and nvdimm devices. The
+ * list is sorted in the ascendant order of the base address of
+ * devices.
+ *
+ * Note: callers are responsible to free the list.
+ */
+GSList *pc_dimm_get_device_list(void);
+
 #endif
-- 
2.14.1
