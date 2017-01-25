Received: from eggs.gnu.org ([2001:4830:134:3::10]:47481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcx-0003hG-Er
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcw-0005Ne-4e
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:59 -0500
Received: from mail-yw0-x22a.google.com ([2607:f8b0:4002:c05::22a]:36349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cWCcw-0005Na-0W
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:58 -0500
Received: by mail-yw0-x22a.google.com with SMTP id v200so3036398ywc.3
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:43:57 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 24 Jan 2017 17:43:24 -0800
Message-Id: <6efb01eaa278d8dd991001c29a79aaab490b83d2.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v4 5/9] qmp/hmp: add query-vm-generation-id and
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
Cc: Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>

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
 qapi-schema.json     | 20 ++++++++++++++++++++
 stubs/Makefile.objs  |  1 +
 stubs/vmgenid.c      |  8 ++++++++
 6 files changed, 52 insertions(+)
 create mode 100644 stubs/vmgenid.c

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 55d50c4..b0bb052 100644
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
index 8522efe..c2280e0 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2564,3 +2564,12 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
 
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
diff --git a/qapi-schema.json b/qapi-schema.json
index ac55f4a..413ac52 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6026,3 +6026,23 @@
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
