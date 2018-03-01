Received: from eggs.gnu.org ([2001:4830:134:3::10]:60951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1erNy7-00023F-LQ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1erNy3-0002DG-8f
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:09:55 -0500
Received: from ozlabs.ru ([107.173.13.209]:41608)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1erNy2-0002Ba-VM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:09:51 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri,  2 Mar 2018 00:09:39 +1100
Message-Id: <20180301130939.15875-3-aik@ozlabs.ru>
In-Reply-To: <20180301130939.15875-1-aik@ozlabs.ru>
References: <20180301130939.15875-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3 2/2] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

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
---
Changes:
v3:
* Used ObjectPropertyInfo instead of QOMPropertyInfo

v2:
* added abstract classes support, now things like "pci-device" or
"spapr-machine" show properties, previously these would produce
an "abstract class" error

# Conflicts:
#	qapi-schema.json
---
 qapi-schema.json     | 15 +++++++++++++++
 include/qom/object.h | 16 ++++++++++++++++
 qmp.c                | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         |  7 +++++++
 4 files changed, 87 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 87327e5..32e836f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1442,6 +1442,21 @@
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
diff --git a/include/qom/object.h b/include/qom/object.h
index dc73d59..ef07d78 100644
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
diff --git a/qmp.c b/qmp.c
index 8a74038..1f15f68 100644
--- a/qmp.c
+++ b/qmp.c
@@ -576,6 +576,55 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
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
index 5dcee46..e7978bd 100644
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
2.11.0
