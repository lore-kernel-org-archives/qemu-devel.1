Received: from eggs.gnu.org ([2001:4830:134:3::10]:48004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVO-0004mQ-07
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVM-0006Ek-M4
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:45 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVM-0006Dy-Cw
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:44 -0500
Received: by mail-wr0-x242.google.com with SMTP id n7so20915594wrn.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:04 +0100
Message-Id: <1520342370-123606-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/34] qmp: Merge ObjectPropertyInfo and
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

ObjectPropertyInfo is more generic and only missing @description.
This adds a description to ObjectPropertyInfo and removes
DevicePropertyInfo so the resulting ObjectPropertyInfo can be used
elsewhere.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20180301130939.15875-2-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/misc.json | 23 +++++------------------
 qdev-monitor.c |  6 +++---
 qmp.c          | 20 ++++++++++----------
 3 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index a1702c9..fb9f41d 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1285,10 +1285,12 @@
 #        3) A link type in the form 'link<subtype>' where subtype is a qdev
 #           device type name.  Link properties form the device model graph.
 #
+# @description: if specified, the description of the property.
+#
 # Since: 1.2
 ##
 { 'struct': 'ObjectPropertyInfo',
-  'data': { 'name': 'str', 'type': 'str' } }
+  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
 
 ##
 # @qom-list:
@@ -1444,34 +1446,19 @@
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
index b8f6bc3..b7e3291 100644
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
index ba82e1d..66332c3 100644
--- a/qmp.c
+++ b/qmp.c
@@ -465,12 +465,12 @@ ObjectTypeInfoList *qmp_qom_list_types(bool has_implements,
  *
  * The caller must free the return value.
  */
-static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
-                                                     const char *name,
-                                                     const char *default_type,
-                                                     const char *description)
+static ObjectPropertyInfo *make_device_property_info(ObjectClass *klass,
+                                                  const char *name,
+                                                  const char *default_type,
+                                                  const char *description)
 {
-    DevicePropertyInfo *info;
+    ObjectPropertyInfo *info;
     Property *prop;
 
     do {
@@ -510,14 +510,14 @@ static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
     return info;
 }
 
-DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
-                                                   Error **errp)
+ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
+                                                Error **errp)
 {
     ObjectClass *klass;
     Object *obj;
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
-    DevicePropertyInfoList *prop_list = NULL;
+    ObjectPropertyInfoList *prop_list = NULL;
 
     klass = object_class_by_name(typename);
     if (klass == NULL) {
@@ -542,8 +542,8 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
-        DevicePropertyInfo *info;
-        DevicePropertyInfoList *entry;
+        ObjectPropertyInfo *info;
+        ObjectPropertyInfoList *entry;
 
         /* Skip Object and DeviceState properties */
         if (strcmp(prop->name, "type") == 0 ||
-- 
1.8.3.1
