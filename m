Received: from eggs.gnu.org ([2001:4830:134:3::10]:42554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cdssv-00023M-T3
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cdssu-0007Dv-8w
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:16:13 -0500
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:35337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cdssu-0007Dn-3C
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:16:12 -0500
Received: by mail-pf0-x230.google.com with SMTP id 202so25897290pfx.2
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 22:16:12 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 14 Feb 2017 22:15:47 -0800
Message-Id: <fe5a0d87343f282cab0bedf0cca4d0bb2ad8b29c.1487139038.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487139038.git.ben@skyportsystems.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487139038.git.ben@skyportsystems.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v6 5/7] qmp/hmp: add query-vm-generation-id and
 'info vm-generation-id' commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Igor Mammedov <imammedo@redhat.com>

Add commands to query Virtual Machine Generation ID counter.

QMP command example:
    { "execute": "query-vm-generation-id" }

HMP command example:
    info vm-generation-id

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hmp-commands-info.hx | 13 +++++++++++++
 hmp.c                |  9 +++++++++
 hmp.h                |  1 +
 hw/acpi/vmgenid.c    | 16 ++++++++++++++++
 qapi-schema.json     | 20 ++++++++++++++++++++
 stubs/Makefile.objs  |  1 +
 stubs/vmgenid.c      |  8 ++++++++
 7 files changed, 68 insertions(+)
 create mode 100644 stubs/vmgenid.c

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index b0f35e6..f3df793 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -802,6 +802,19 @@ Show information about hotpluggable CPUs
 ETEXI
 
 STEXI
+@item info vm-generation-id
+Show Virtual Machine Generation ID
+ETEXI
+
+    {
+        .name       = "vm-generation-id",
+        .args_type  = "",
+        .params     = "",
+        .help       = "Show Virtual Machine Generation ID",
+        .cmd = hmp_info_vm_generation_id,
+    },
+
+STEXI
 @end table
 ETEXI
 
diff --git a/hmp.c b/hmp.c
index 2bc4f06..535613d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2565,3 +2565,12 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
 
     qapi_free_HotpluggableCPUList(saved);
 }
+
+void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
+{
+    GuidInfo *info = qmp_query_vm_generation_id(NULL);
+    if (info) {
+        monitor_printf(mon, "%s\n", info->guid);
+    }
+    qapi_free_GuidInfo(info);
+}
diff --git a/hmp.h b/hmp.h
index 05daf7c..799fd37 100644
--- a/hmp.h
+++ b/hmp.h
@@ -137,5 +137,6 @@ void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict);
 void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
 void hmp_info_dump(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
+void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index b1b7b32..c159c76 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -235,3 +235,19 @@ static void vmgenid_register_types(void)
 }
 
 type_init(vmgenid_register_types)
+
+GuidInfo *qmp_query_vm_generation_id(Error **errp)
+{
+    GuidInfo *info;
+    VmGenIdState *vms;
+    Object *obj = find_vmgenid_dev();
+
+    if (!obj) {
+        return NULL;
+    }
+    vms = VMGENID(obj);
+
+    info = g_malloc0(sizeof(*info));
+    info->guid = qemu_uuid_unparse_strdup(&vms->guid);
+    return info;
+}
diff --git a/qapi-schema.json b/qapi-schema.json
index 61151f3..5e2a47f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6051,3 +6051,23 @@
 #
 ##
 { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
+
+##
+# @GuidInfo:
+#
+# GUID information.
+#
+# @guid: the globally unique identifier
+#
+# Since: 2.9
+##
+{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
+
+##
+# @query-vm-generation-id:
+#
+# Show Virtual Machine Generation ID
+#
+# Since 2.9
+##
+{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index a187295..0bffca6 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -35,3 +35,4 @@ stub-obj-y += qmp_pc_dimm_device_list.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
+stub-obj-y += vmgenid.o
diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
new file mode 100644
index 0000000..8c448ac
--- /dev/null
+++ b/stubs/vmgenid.c
@@ -0,0 +1,8 @@
+#include "qemu/osdep.h"
+#include "qmp-commands.h"
+
+GuidInfo *qmp_query_vm_generation_id(Error **errp)
+{
+    error_setg(errp, "this command is not currently supported");
+    return NULL;
+}
-- 
2.7.4
