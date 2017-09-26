Received: from eggs.gnu.org ([2001:4830:134:3::10]:37794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwxx2-0004JG-KI
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwxx1-00037f-JT
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwxx1-00037G-BC
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 19:03:25 -0300
Message-Id: <20170926220326.12996-4-ehabkost@redhat.com>
In-Reply-To: <20170926220326.12996-1-ehabkost@redhat.com>
References: <20170926220326.12996-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] qmp: query-device-type command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Gibson <dgibson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>

Add a command that returns QOM type information that is specific
to device types and is not returned by qom-list-types.

The returned DeviceTypeInfo struct inherits from ObjectTypeInfo,
so fields returned by qom-list-types are also included.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi-schema.json | 35 +++++++++++++++++++++++++++++++++++
 qmp.c            | 25 +++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index a3ba1c9a1c..0955380a59 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1466,6 +1466,41 @@
   'returns': [ 'DevicePropertyInfo' ] }
 
 ##
+# @DeviceTypeInfo:
+#
+# Information about a device type.
+#
+# @user-creatable: If true, the device can be instantiated using the -device
+#                  command-line option.
+# @hotpluggable: If true, the device can be instantiated using @device_add,
+#                if the machine supports the device.
+#
+# @description: Human-readable description of the device type.
+#
+# Since: 2.11
+##
+{ 'struct': 'DeviceTypeInfo',
+  'base': 'ObjectTypeInfo',
+  'data': { 'hotpluggable': 'bool',
+            'user-creatable': 'bool',
+            '*description': 'str' } }
+
+##
+# @query-device-type:
+#
+# Query information about a device type.
+#
+# @typename: the name of the device type
+#
+# Returns: a DeviceTypeInfo struct
+#
+# Since: 2.11
+##
+{ 'command': 'query-device-type',
+  'data': { 'typename': 'str' },
+  'returns': 'DeviceTypeInfo' }
+
+##
 # @xen-set-global-dirty-log:
 #
 # Enable or disable the global dirty log mode.
diff --git a/qmp.c b/qmp.c
index 5ec829c09b..761fcf61c7 100644
--- a/qmp.c
+++ b/qmp.c
@@ -597,6 +597,31 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
     return prop_list;
 }
 
+DeviceTypeInfo *qmp_query_device_type(const char *typename, Error **errp)
+{
+    DeviceTypeInfo *info = g_new0(DeviceTypeInfo, 1);
+    DeviceClass *dc = get_device_class(typename, errp);
+
+    if (!dc) {
+        return NULL;
+    }
+
+    qom_type_get_info(OBJECT_CLASS(dc), qapi_DeviceTypeInfo_base(info));
+    info->user_creatable = dc->user_creatable;
+    /*
+     * We have non-user-creatable devices with hotpluggable=true (because they
+     * are instantiated internally by hotpluggable devices), but it doesn't make
+     * sense to tell the user that device_add is supported if the device is not
+     * user-creatable
+     */
+    info->hotpluggable = dc->user_creatable && dc->hotpluggable;
+    if (dc->desc) {
+        info->has_description = true;
+        info->description = g_strdup(dc->desc);
+    }
+    return info;
+}
+
 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
     return arch_query_cpu_definitions(errp);
-- 
2.13.5
