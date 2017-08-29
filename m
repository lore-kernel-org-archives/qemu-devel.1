Received: from eggs.gnu.org ([2001:4830:134:3::10]:46735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dmiTU-0001g1-Sl
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dmiTS-0003ls-Te
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:30:44 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dmiTS-0003jo-6C
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:30:42 -0400
Received: by mail-wm0-x22e.google.com with SMTP id f13so20764685wme.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:30:42 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Tue, 29 Aug 2017 17:30:21 +0200
Message-Id: <20170829153022.27004-3-vadim.galitsyn@profitbricks.com>
In-Reply-To: <20170829153022.27004-1-vadim.galitsyn@profitbricks.com>
References: <20170829153022.27004-1-vadim.galitsyn@profitbricks.com>
Subject: [Qemu-devel] [PATCH v7 2/3] qmp: introduce
 query-memory-size-summary command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

Add a new query-memory-size-summary command which provides the
following memory information in bytes:

  * base-memory - size of "base" memory specified with command line option -m.

  * plugged-memory - amount of memory that was hot-plugged.
    If target does not have CONFIG_MEM_HOTPLUG enabled, no
    value is reported.

Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Signed-off-by: Mohammed Gamal <mohammed.gamal@profitbricks.com>
Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Reviewed-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qapi-schema.json                                   | 32 ++++++++++++++++++++++
 include/hw/mem/pc-dimm.h                           |  1 +
 hw/mem/pc-dimm.c                                   |  5 ++++
 qmp.c                                              | 13 +++++++++
 stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} |  5 ++++
 stubs/Makefile.objs                                |  2 +-
 6 files changed, 57 insertions(+), 1 deletion(-)
 rename stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} (68%)

diff --git a/qapi-schema.json b/qapi-schema.json
index 802ea53d00..9402ac3b3a 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4407,6 +4407,38 @@
   'data': { 'name': 'str', '*migration-safe': 'bool', 'static': 'bool',
             '*unavailable-features': [ 'str' ], 'typename': 'str' } }
 
+##
+# @MemoryInfo:
+#
+# Actual memory information in bytes.
+#
+# @base-memory: size of "base" memory specified with command line
+#               option -m.
+#
+# @plugged-memory: size memory that can be hot-unplugged. This field
+#                  is omitted if target does support memory hotplug
+#                  (i.e. CONFIG_MEM_HOTPLUG not defined on build time).
+#
+# Since: 2.11.0
+##
+{ 'struct': 'MemoryInfo',
+  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size' } }
+
+##
+# @query-memory-size-summary:
+#
+# Return the amount of initially allocated and hot-plugged (if
+# enabled) memory in bytes.
+#
+# Example:
+#
+# -> { "execute": "query-memory-size-summary" }
+# <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
+#
+# Since: 2.11.0
+##
+{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
+
 ##
 # @query-cpu-definitions:
 #
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 6f8c3eb1b3..d83b957829 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -95,6 +95,7 @@ int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
 int qmp_pc_dimm_device_list(Object *obj, void *opaque);
 uint64_t pc_existing_dimms_capacity(Error **errp);
+uint64_t get_plugged_memory_size(void);
 void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
                          MemoryRegion *mr, uint64_t align, Error **errp);
 void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index bdf6649083..66eace5a5c 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -159,6 +159,11 @@ uint64_t pc_existing_dimms_capacity(Error **errp)
     return cap.size;
 }
 
+uint64_t get_plugged_memory_size(void)
+{
+    return pc_existing_dimms_capacity(&error_abort);
+}
+
 int qmp_pc_dimm_device_list(Object *obj, void *opaque)
 {
     MemoryDeviceInfoList ***prev = opaque;
diff --git a/qmp.c b/qmp.c
index b86201e349..e8c303116a 100644
--- a/qmp.c
+++ b/qmp.c
@@ -709,3 +709,16 @@ ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error **errp)
 
     return head;
 }
+
+MemoryInfo *qmp_query_memory_size_summary(Error **errp)
+{
+    MemoryInfo *mem_info = g_malloc0(sizeof(MemoryInfo));
+
+    mem_info->base_memory = ram_size;
+
+    mem_info->plugged_memory = get_plugged_memory_size();
+    mem_info->has_plugged_memory =
+        mem_info->plugged_memory != (uint64_t)-1;
+
+    return mem_info;
+}
diff --git a/stubs/qmp_pc_dimm_device_list.c b/stubs/qmp_pc_dimm.c
similarity index 68%
rename from stubs/qmp_pc_dimm_device_list.c
rename to stubs/qmp_pc_dimm.c
index def211564d..9ddc4f619a 100644
--- a/stubs/qmp_pc_dimm_device_list.c
+++ b/stubs/qmp_pc_dimm.c
@@ -6,3 +6,8 @@ int qmp_pc_dimm_device_list(Object *obj, void *opaque)
 {
    return 0;
 }
+
+uint64_t get_plugged_memory_size(void)
+{
+    return (uint64_t)-1;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index e69c217aff..f5f139f310 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -33,7 +33,7 @@ stub-obj-y += uuid.o
 stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
 stub-obj-$(CONFIG_WIN32) += fd-register.o
-stub-obj-y += qmp_pc_dimm_device_list.o
+stub-obj-y += qmp_pc_dimm.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
-- 
2.13.1.394.g41dd433
