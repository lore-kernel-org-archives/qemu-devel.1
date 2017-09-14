Received: from eggs.gnu.org ([2001:4830:134:3::10]:60621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsViF-0007Nr-Ud
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsViC-0002xK-Gr
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsViB-0002wo-V3
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:52 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Sep 2017 16:04:46 +0100
Message-Id: <20170914150447.19352-7-dgilbert@redhat.com>
In-Reply-To: <20170914150447.19352-1-dgilbert@redhat.com>
References: <20170914150447.19352-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] qmp: introduce query-memory-size-summary
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com, cohuck@redhat.com, vadim.galitsyn@profitbricks.com
Cc: imammedo@redhat.com, thuth@redhat.com, peterx@redhat.com, groug@kaod.org

From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>

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
Message-Id: <20170829153022.27004-3-vadim.galitsyn@profitbricks.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Fixup comments as per Igor's review
  Added 'of' from Vadim's reply
---
 hw/mem/pc-dimm.c                                   |  5 ++++
 include/hw/mem/pc-dimm.h                           |  1 +
 qapi-schema.json                                   | 32 ++++++++++++++++++++++
 qmp.c                                              | 13 +++++++++
 stubs/Makefile.objs                                |  2 +-
 stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} |  5 ++++
 6 files changed, 57 insertions(+), 1 deletion(-)
 rename stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} (68%)

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
diff --git a/qapi-schema.json b/qapi-schema.json
index f3af2cb851..cdff39a456 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1966,6 +1966,38 @@
             '*unavailable-features': [ 'str' ], 'typename': 'str' } }
 
 ##
+# @MemoryInfo:
+#
+# Actual memory information in bytes.
+#
+# @base-memory: size of "base" memory specified with command line
+#               option -m.
+#
+# @plugged-memory: size of memory that can be hot-unplugged. This field
+#                  is omitted if target doesn't support memory hotplug
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
+# Return the amount of initially allocated and present hotpluggable (if
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
+##
 # @query-cpu-definitions:
 #
 # Return a list of supported virtual CPU definitions
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
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 4a33495911..c7594796c3 100644
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
-- 
2.13.5
