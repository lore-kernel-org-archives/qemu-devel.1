Received: from eggs.gnu.org ([2001:4830:134:3::10]:48051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVR-0004qH-Ch
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVO-0006G3-00
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:49 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVN-0006FD-MB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:45 -0500
Received: by mail-wm0-x242.google.com with SMTP id e194so3744139wmd.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:45 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:05 +0100
Message-Id: <1520342370-123606-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/34] qmp: Add qom-list-properties to list QOM
 object properties
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

There is already 'device-list-properties' which does most of the job,
however it does not handle everything returned by qom-list-types such
as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.
It does not handle abstract classes either.

This adds a new qom-list-properties command which prints properties
of a specific class and its instance. It is pretty much a simplified copy
of the device-list-properties handler.

Since it creates an object instance, device properties should appear
in the output as they are copied to QOM properties at the instance_init
hook.

This adds a object_class_property_iter_init() helper to allow class
properties enumeration uses it in the new QMP command to allow properties
listing for abstract classes.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20180301130939.15875-3-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 16 ++++++++++++++++
 qapi/misc.json       | 15 +++++++++++++++
 qmp.c                | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         |  7 +++++++
 4 files changed, 87 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 30db296..4f07090 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1017,6 +1017,22 @@ void object_property_iter_init(ObjectPropertyIterator *iter,
                                Object *obj);
 
 /**
+ * object_class_property_iter_init:
+ * @klass: the class
+ *
+ * Initializes an iterator for traversing all properties
+ * registered against an object class and all parent classes.
+ *
+ * It is forbidden to modify the property list while iterating,
+ * whether removing or adding properties.
+ *
+ * This can be used on abstract classes as it does not create a temporary
+ * instance.
+ */
+void object_class_property_iter_init(ObjectPropertyIterator *iter,
+                                     ObjectClass *klass);
+
+/**
  * object_property_iter_next:
  * @iter: the iterator instance
  *
diff --git a/qapi/misc.json b/qapi/misc.json
index fb9f41d..bd04469 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1461,6 +1461,21 @@
   'returns': [ 'ObjectPropertyInfo' ] }
 
 ##
+# @qom-list-properties:
+#
+# List properties associated with a QOM object.
+#
+# @typename: the type name of an object
+#
+# Returns: a list of ObjectPropertyInfo describing object properties
+#
+# Since: 2.12
+##
+{ 'command': 'qom-list-properties',
+  'data': { 'typename': 'str'},
+  'returns': [ 'ObjectPropertyInfo' ] }
+
+##
 # @xen-set-global-dirty-log:
 #
 # Enable or disable the global dirty log mode.
diff --git a/qmp.c b/qmp.c
index 66332c3..8c7d1cc 100644
--- a/qmp.c
+++ b/qmp.c
@@ -578,6 +578,55 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
     return prop_list;
 }
 
+ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
+                                             Error **errp)
+{
+    ObjectClass *klass;
+    Object *obj = NULL;
+    ObjectProperty *prop;
+    ObjectPropertyIterator iter;
+    ObjectPropertyInfoList *prop_list = NULL;
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
+        object_class_property_iter_init(&iter, klass);
+    } else {
+        obj = object_new(typename);
+        object_property_iter_init(&iter, obj);
+    }
+    while ((prop = object_property_iter_next(&iter))) {
+        ObjectPropertyInfo *info;
+        ObjectPropertyInfoList *entry;
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
diff --git a/qom/object.c b/qom/object.c
index f70a75c..755ad03 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1037,6 +1037,13 @@ ObjectProperty *object_property_iter_next(ObjectPropertyIterator *iter)
     return val;
 }
 
+void object_class_property_iter_init(ObjectPropertyIterator *iter,
+                                     ObjectClass *klass)
+{
+    g_hash_table_iter_init(&iter->iter, klass->properties);
+    iter->nextclass = klass;
+}
+
 ObjectProperty *object_class_property_find(ObjectClass *klass, const char *name,
                                            Error **errp)
 {
-- 
1.8.3.1
