Received: from eggs.gnu.org ([2001:4830:134:3::10]:36989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTSHI-0000Bz-EX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTSHH-000637-39
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTSHG-00062U-QX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3ABCC04D2E9
	for <qemu-devel@nongnu.org>; Fri,  7 Jul 2017 12:22:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  7 Jul 2017 09:22:15 -0300
Message-Id: <20170707122215.8819-4-ehabkost@redhat.com>
In-Reply-To: <20170707122215.8819-1-ehabkost@redhat.com>
References: <20170707122215.8819-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/3] qmp: Include parent type on
 'qom-list-types' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

Include name of parent type of each type on 'qom-list-types' output.

Without this, there's no way to figure out the parents of a given type
without making additional 'qom-list-types' queries.

In addition to the test case for the new feature, update the
abstract-interface test case to use the new field and avoid the
"qom-list-types implements=object" trick.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3:
* None, rebase only.

Changes v1 -> v2:
* Include only immediate parent type, rename new field to 'parent'
---
 qapi-schema.json               |  4 +-
 qmp.c                          |  5 +++
 tests/device-introspect-test.c | 84 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 48d613f..0432827 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3062,10 +3062,12 @@
 # @abstract: the type is abstract and can't be directly instantiated.
 #            Omitted if false. (since 2.10)
 #
+# @parent: Name of parent type, if any (since 2.10)
+#
 # Since: 1.1
 ##
 { 'struct': 'ObjectTypeInfo',
-  'data': { 'name': 'str', '*abstract': 'bool' } }
+  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
 
 ##
 # @qom-list-types:
diff --git a/qmp.c b/qmp.c
index 5e9b563..ca5f446 100644
--- a/qmp.c
+++ b/qmp.c
@@ -440,10 +440,15 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
 {
     ObjectTypeInfoList *e, **pret = data;
     ObjectTypeInfo *info;
+    ObjectClass *parent = object_class_get_parent(klass);
 
     info = g_malloc0(sizeof(*info));
     info->name = g_strdup(object_class_get_name(klass));
     info->has_abstract = info->abstract = object_class_is_abstract(klass);
+    if (parent) {
+        info->has_parent = true;
+        info->parent = g_strdup(object_class_get_name(parent));
+    }
 
     e = g_malloc0(sizeof(*e));
     e->value = info;
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index 78d4811..f7162c0 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -45,6 +45,40 @@ static QList *qom_list_types(const char *implements, bool abstract)
     return ret;
 }
 
+/* Build a name -> ObjectTypeInfo index from a ObjectTypeInfo list */
+static QDict *qom_type_index(QList *types)
+{
+    QDict *index = qdict_new();
+    QListEntry *e;
+
+    QLIST_FOREACH_ENTRY(types, e) {
+        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+        const char *name = qdict_get_str(d, "name");
+        QINCREF(d);
+        qdict_put(index, name, d);
+    }
+    return index;
+}
+
+/* Check if @parent is present in the parent chain of @type */
+static bool qom_has_parent(QDict *index, const char *type, const char *parent)
+{
+    while (type) {
+        QDict *d = qdict_get_qdict(index, type);
+        const char *p = d && qdict_haskey(d, "parent") ?
+                        qdict_get_str(d, "parent") :
+                        NULL;
+
+        if (!strcmp(type, parent)) {
+            return true;
+        }
+
+        type = p;
+    }
+
+    return false;
+}
+
 /* Find an entry on a list returned by qom-list-types */
 static QDict *type_list_find(QList *types, const char *name)
 {
@@ -103,6 +137,30 @@ static void test_device_intro_list(void)
     qtest_end();
 }
 
+/*
+ * Ensure all entries returned by qom-list-types implements=<parent>
+ * have <parent> as a parent.
+ */
+static void test_qom_list_parents(const char *parent)
+{
+    QList *types;
+    QListEntry *e;
+    QDict *index;
+
+    types = qom_list_types(parent, true);
+    index = qom_type_index(types);
+
+    QLIST_FOREACH_ENTRY(types, e) {
+        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+        const char *name = qdict_get_str(d, "name");
+
+        g_assert(qom_has_parent(index, name, parent));
+    }
+
+    QDECREF(types);
+    QDECREF(index);
+}
+
 static void test_qom_list_fields(void)
 {
     QList *all_types;
@@ -125,6 +183,10 @@ static void test_qom_list_fields(void)
         g_assert(abstract == expected_abstract);
     }
 
+    test_qom_list_parents("object");
+    test_qom_list_parents("device");
+    test_qom_list_parents("sys-bus-device");
+
     QDECREF(all_types);
     QDECREF(non_abstract);
     qtest_end();
@@ -167,23 +229,25 @@ static void test_device_intro_concrete(void)
 static void test_abstract_interfaces(void)
 {
     QList *all_types;
-    QList *obj_types;
     QListEntry *e;
+    QDict *index;
 
     qtest_start(common_args);
-    /*
-     * qom-list-types implements=interface returns all types that
-     * implement _any_ interface (not just interface types), but
-     * we can filter them out because interfaces don't implement
-     * the "object" type.
-     */
+
     all_types = qom_list_types("interface", true);
-    obj_types = qom_list_types("object", true);
+    index = qom_type_index(all_types);
 
     QLIST_FOREACH_ENTRY(all_types, e) {
         QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+        const char *name = qdict_get_str(d, "name");
 
-        if (type_list_find(obj_types, qdict_get_str(d, "name"))) {
+        /*
+         * qom-list-types implements=interface returns all types
+         * that implement _any_ interface (not just interface
+         * types), so skip the ones that don't have "interface"
+         * on the parent type chain.
+         */
+        if (!qom_has_parent(index, name, "interface")) {
             /* Not an interface type */
             continue;
         }
@@ -192,7 +256,7 @@ static void test_abstract_interfaces(void)
     }
 
     QDECREF(all_types);
-    QDECREF(obj_types);
+    QDECREF(index);
     qtest_end();
 }
 
-- 
2.9.4
