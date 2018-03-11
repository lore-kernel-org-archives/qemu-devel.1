Received: from eggs.gnu.org ([2001:4830:134:3::10]:48759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eupsp-0003w7-Ot
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eupso-0004ps-GX
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:34:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:17414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eupso-0004nm-4d
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:34:42 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Sun, 11 Mar 2018 09:34:24 +0800
Message-Id: <20180311013426.32610-4-haozhong.zhang@intel.com>
In-Reply-To: <20180311013426.32610-1-haozhong.zhang@intel.com>
References: <20180311013426.32610-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v5 3/5] hw/acpi-build: build SRAT memory
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
one SRAT memory affinity structure for each DIMM device present at
boot time, including both PC-DIMM and NVDIMM, with the proximity
domain specified in '-device pc-dimm' or '-device nvdimm'.

The remaining hot-pluggable address space is covered by one or multiple
SRAT memory affinity structures with the proximity domain of the last
node as before.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hw/i386/acpi-build.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index deb440f286..2c1f694da4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2323,6 +2323,55 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 #define HOLE_640K_START  (640 * 1024)
 #define HOLE_640K_END   (1024 * 1024)
 
+static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
+                                           uint64_t len, int default_node)
+{
+    MemoryDeviceInfoList *info_list = qmp_pc_dimm_device_list();
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
 static void
 build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
@@ -2434,10 +2483,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
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
-- 
2.14.1
