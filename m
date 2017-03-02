Received: from eggs.gnu.org ([2001:4830:134:3::10]:44249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6Q-0001Zh-CM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6N-0003N1-FD
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:38 -0500
Received: from mail.kernel.org ([198.145.29.136]:51154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6N-0003KR-65
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:35 -0500
Date: Thu, 2 Mar 2017 08:20:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-6-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] qmp/hmp: add query-vm-generation-id and
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Warren <ben@skyportsystems.com>, Laszlo Ersek <lersek@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Add commands to query Virtual Machine Generation ID counter.

QMP command example:
    { "execute": "query-vm-generation-id" }

HMP command example:
    info vm-generation-id

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Ben Warren <ben@skyportsystems.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi-schema.json     | 20 ++++++++++++++++++++
 hmp.h                |  1 +
 hmp.c                |  9 +++++++++
 hw/acpi/vmgenid.c    | 16 ++++++++++++++++
 stubs/vmgenid.c      |  9 +++++++++
 hmp-commands-info.hx | 14 ++++++++++++++
 stubs/Makefile.objs  |  1 +
 7 files changed, 70 insertions(+)
 create mode 100644 stubs/vmgenid.c

diff --git a/qapi-schema.json b/qapi-schema.json
index d6186d4..84692da 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6188,3 +6188,23 @@
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
diff --git a/hmp.c b/hmp.c
index 83e287e..aadbcf5 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2576,3 +2576,12 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
 
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
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index c8465df..744f284 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -240,3 +240,19 @@ static void vmgenid_register_types(void)
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
diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
new file mode 100644
index 0000000..c64eb7a
--- /dev/null
+++ b/stubs/vmgenid.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "qmp-commands.h"
+#include "qapi/qmp/qerror.h"
+
+GuidInfo *qmp_query_vm_generation_id(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index b0f35e6..a53f105 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -802,6 +802,20 @@ Show information about hotpluggable CPUs
 ETEXI
 
 STEXI
+@item info vm-generation-id
+@findex vm-generation-id
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
 
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index aa6050f..224f04b 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -36,3 +36,4 @@ stub-obj-y += qmp_pc_dimm_device_list.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
+stub-obj-y += vmgenid.o
-- 
MST
