Received: from eggs.gnu.org ([2001:4830:134:3::10]:44942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dhw9v-0000lI-Q5
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dhw9r-0008EQ-Vx
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:06:47 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dhw9r-0008Cf-Mk
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:06:43 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 49so3778212wrw.2
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 04:06:43 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Wed, 16 Aug 2017 13:06:25 +0200
Message-Id: <1502881586-25044-2-git-send-email-vadim.galitsyn@profitbricks.com>
In-Reply-To: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
References: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
Subject: [Qemu-devel] [PATCH v6 2/3] qmp: introduce
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

Command above provides the following memory information in bytes:

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
 hw/mem/pc-dimm.c                |  5 +++++
 include/hw/mem/pc-dimm.h        |  1 +
 qapi-schema.json                | 25 +++++++++++++++++++++++++
 qmp.c                           | 13 +++++++++++++
 stubs/Makefile.objs             |  2 +-
 stubs/qmp_pc_dimm.c             | 13 +++++++++++++
 stubs/qmp_pc_dimm_device_list.c |  8 --------
 7 files changed, 58 insertions(+), 9 deletions(-)
 create mode 100644 stubs/qmp_pc_dimm.c
 delete mode 100644 stubs/qmp_pc_dimm_device_list.c

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index ea67b46..6ef2ccd 100644
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
index 1e483f2..a56f901 100644
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
index 802ea53..23916b7 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4408,6 +4408,31 @@
             '*unavailable-features': [ 'str' ], 'typename': 'str' } }
 
 ##
+# @MemoryInfo:
+#
+# Actual memory information in bytes.
+#
+# @base-memory: size of "base" memory specified with command line
+#               option -m.
+#
+# @plugged-memory: size memory that can be hot-unplugged.
+#
+# Since: 2.10.0
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
+# Since: 2.10.0
+##
+{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
+
+##
 # @query-cpu-definitions:
 #
 # Return a list of supported virtual CPU definitions
diff --git a/qmp.c b/qmp.c
index b86201e..e8c3031 100644
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
index f5b47bf..f7cab5b 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -32,7 +32,7 @@ stub-obj-y += uuid.o
 stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
 stub-obj-$(CONFIG_WIN32) += fd-register.o
-stub-obj-y += qmp_pc_dimm_device_list.o
+stub-obj-y += qmp_pc_dimm.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
diff --git a/stubs/qmp_pc_dimm.c b/stubs/qmp_pc_dimm.c
new file mode 100644
index 0000000..9ddc4f6
--- /dev/null
+++ b/stubs/qmp_pc_dimm.c
@@ -0,0 +1,13 @@
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/mem/pc-dimm.h"
+
+int qmp_pc_dimm_device_list(Object *obj, void *opaque)
+{
+   return 0;
+}
+
+uint64_t get_plugged_memory_size(void)
+{
+    return (uint64_t)-1;
+}
diff --git a/stubs/qmp_pc_dimm_device_list.c b/stubs/qmp_pc_dimm_device_list.c
deleted file mode 100644
index def2115..0000000
--- a/stubs/qmp_pc_dimm_device_list.c
+++ /dev/null
@@ -1,8 +0,0 @@
-#include "qemu/osdep.h"
-#include "qom/object.h"
-#include "hw/mem/pc-dimm.h"
-
-int qmp_pc_dimm_device_list(Object *obj, void *opaque)
-{
-   return 0;
-}
-- 
2.1.4
