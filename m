Received: from eggs.gnu.org ([2001:4830:134:3::10]:34651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecOvx-00074w-3A
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecOvt-0000yE-1K
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:09:45 -0500
Received: from ozlabs.ru ([107.173.13.209]:34660)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecOvs-0000xz-PC
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:09:40 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 19 Jan 2018 16:09:06 +1100
Message-Id: <20180119050906.18930-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to list
 QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Andrea Bolognani <abologna@redhat.com>

There is already 'device-list-properties' which does most of the job,
however it does not handle everything returned by qom-list-types such
as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.

This adds a new qom-list-properties command which prints properties
of a specific class and its instance. It is pretty much a simplified copy
of the device-list-properties handler.

Since it creates an object instance, device properties should appear
in the output as they are copied to QOM properties at the instance_init
hook.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I am missing the point of make_device_property_info().
qmp_device_list_properties() creates the instance which copies everything
to QOM properties hashtable and commenting out the do{}while() in
make_device_property_info() does not seem to change a thing, what case
am I missing here?


---
 qapi-schema.json | 29 +++++++++++++++++++++++++++++
 qmp.c            | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 5c06745..9d73501 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1455,6 +1455,35 @@
   'returns': [ 'DevicePropertyInfo' ] }
 
 ##
+# @QOMPropertyInfo:
+#
+# Information about object properties.
+#
+# @name: the name of the property
+# @type: the typename of the property
+# @description: if specified, the description of the property.
+#
+# Since: 2.12
+##
+{ 'struct': 'QOMPropertyInfo',
+  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
+
+##
+# @qom-list-properties:
+#
+# List properties associated with a QOM object.
+#
+# @typename: the type name of an object
+#
+# Returns: a list of QOMPropertyInfo describing object properties
+#
+# Since: 2.12
+##
+{ 'command': 'qom-list-properties',
+  'data': { 'typename': 'str'},
+  'returns': [ 'QOMPropertyInfo' ] }
+
+##
 # @xen-set-global-dirty-log:
 #
 # Enable or disable the global dirty log mode.
diff --git a/qmp.c b/qmp.c
index 52cfd2d..20cb662 100644
--- a/qmp.c
+++ b/qmp.c
@@ -574,6 +574,58 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
     return prop_list;
 }
 
+QOMPropertyInfoList *qmp_qom_list_properties(const char *typename,
+                                             Error **errp)
+{
+    ObjectClass *klass;
+    Object *obj;
+    ObjectProperty *prop;
+    ObjectPropertyIterator iter;
+    QOMPropertyInfoList *prop_list = NULL;
+
+    klass = object_class_by_name(typename);
+    if (klass == NULL) {
+        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                  "Class '%s' not found", typename);
+        return NULL;
+    }
+
+    klass = object_class_dynamic_cast(klass, TYPE_OBJECT);
+    if (klass == NULL) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename", TYPE_OBJECT);
+        return NULL;
+    }
+
+    if (object_class_is_abstract(klass)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
+                   "non-abstract class");
+        return NULL;
+    }
+
+    obj = object_new(typename);
+
+    object_property_iter_init(&iter, obj);
+    while ((prop = object_property_iter_next(&iter))) {
+        QOMPropertyInfo *info;
+        QOMPropertyInfoList *entry;
+
+        info = g_malloc0(sizeof(*info));
+        info->name = g_strdup(prop->name);
+        info->type = g_strdup(prop->type);
+        info->has_description = !!prop->description;
+        info->description = g_strdup(prop->description);
+
+        entry = g_malloc0(sizeof(*entry));
+        entry->value = info;
+        entry->next = prop_list;
+        prop_list = entry;
+    }
+
+    object_unref(obj);
+
+    return prop_list;
+}
+
 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
     return arch_query_cpu_definitions(errp);
-- 
2.11.0
