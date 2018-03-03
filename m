Received: from eggs.gnu.org ([2001:4830:134:3::10]:58684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eruzj-0008TX-7l
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eruzg-0005mT-2M
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:25:47 -0500
Received: from ozlabs.ru ([107.173.13.209]:43788)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eruzf-0005lq-NN
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:25:43 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Sat,  3 Mar 2018 11:25:03 +1100
Message-Id: <20180303002504.25142-2-aik@ozlabs.ru>
In-Reply-To: <20180303002504.25142-1-aik@ozlabs.ru>
References: <20180303002504.25142-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 1/2] qmp: Merge ObjectPropertyInfo and
 DevicePropertyInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

ObjectPropertyInfo is more generic and only missing @description.
This adds a description to ObjectPropertyInfo and removes
DevicePropertyInfo so the resulting ObjectPropertyInfo can be used
elsewhere.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* added (since 2.12) to the new field
* removed wrong reindents
---
 qapi-schema.json | 23 +++++------------------
 qdev-monitor.c   |  6 +++---
 qmp.c            | 14 +++++++-------
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 0262b9f..5cdf89a 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1266,10 +1266,12 @@
 #        3) A link type in the form 'link<subtype>' where subtype is a qdev
 #           device type name.  Link properties form the device model graph.
 #
+# @description: if specified, the description of the property (since 2.12).
+#
 # Since: 1.2
 ##
 { 'struct': 'ObjectPropertyInfo',
-  'data': { 'name': 'str', 'type': 'str' } }
+  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
 
 ##
 # @qom-list:
@@ -1425,34 +1427,19 @@
   'returns': [ 'ObjectTypeInfo' ] }
 
 ##
-# @DevicePropertyInfo:
-#
-# Information about device properties.
-#
-# @name: the name of the property
-# @type: the typename of the property
-# @description: if specified, the description of the property.
-#               (since 2.2)
-#
-# Since: 1.2
-##
-{ 'struct': 'DevicePropertyInfo',
-  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
-
-##
 # @device-list-properties:
 #
 # List properties associated with a device.
 #
 # @typename: the type name of a device
 #
-# Returns: a list of DevicePropertyInfo describing a devices properties
+# Returns: a list of ObjectPropertyInfo describing a devices properties
 #
 # Since: 1.2
 ##
 { 'command': 'device-list-properties',
   'data': { 'typename': 'str'},
-  'returns': [ 'DevicePropertyInfo' ] }
+  'returns': [ 'ObjectPropertyInfo' ] }
 
 ##
 # @xen-set-global-dirty-log:
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 8462381..ab9c46c 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -258,8 +258,8 @@ int qdev_device_help(QemuOpts *opts)
 {
     Error *local_err = NULL;
     const char *driver;
-    DevicePropertyInfoList *prop_list;
-    DevicePropertyInfoList *prop;
+    ObjectPropertyInfoList *prop_list;
+    ObjectPropertyInfoList *prop;
 
     driver = qemu_opt_get(opts, "driver");
     if (driver && is_help_option(driver)) {
@@ -295,7 +295,7 @@ int qdev_device_help(QemuOpts *opts)
         }
     }
 
-    qapi_free_DevicePropertyInfoList(prop_list);
+    qapi_free_ObjectPropertyInfoList(prop_list);
     return 1;
 
 error:
diff --git a/qmp.c b/qmp.c
index 793f6f3..42b7862 100644
--- a/qmp.c
+++ b/qmp.c
@@ -456,19 +456,19 @@ ObjectTypeInfoList *qmp_qom_list_types(bool has_implements,
     return ret;
 }
 
-/* Return a DevicePropertyInfo for a qdev property.
+/* Return a ObjectPropertyInfo for a qdev property.
  *
  * If a qdev property with the given name does not exist, use the given default
  * type.  If the qdev property info should not be shown, return NULL.
  *
  * The caller must free the return value.
  */
-static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
+static ObjectPropertyInfo *make_device_property_info(ObjectClass *klass,
                                                      const char *name,
                                                      const char *default_type,
                                                      const char *description)
 {
-    DevicePropertyInfo *info;
+    ObjectPropertyInfo *info;
     Property *prop;
 
     do {
@@ -508,14 +508,14 @@ static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
     return info;
 }
 
-DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
+ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
                                                    Error **errp)
 {
     ObjectClass *klass;
     Object *obj;
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
-    DevicePropertyInfoList *prop_list = NULL;
+    ObjectPropertyInfoList *prop_list = NULL;
 
     klass = object_class_by_name(typename);
     if (klass == NULL) {
@@ -540,8 +540,8 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
-        DevicePropertyInfo *info;
-        DevicePropertyInfoList *entry;
+        ObjectPropertyInfo *info;
+        ObjectPropertyInfoList *entry;
 
         /* Skip Object and DeviceState properties */
         if (strcmp(prop->name, "type") == 0 ||
-- 
2.11.0
