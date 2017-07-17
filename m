Received: from eggs.gnu.org ([2001:4830:134:3::10]:34562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB75-0003UN-HI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB74-0003vM-EA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB74-0003uG-5w
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:50 -0300
Message-Id: <20170717185051.18740-15-ehabkost@redhat.com>
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] qmp: Include 'abstract' field on
 'qom-list-types' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

A client may be interested in getting the list of both abstract and
non-abstract types.  Instead of requiring them to make multiple queries
with different filter arguments, just return an 'abstract' field in
'qom-list-types'.

In addition to the new test code for validating this field, update the
abstract-interfaces test case to query for all 'interface' subtypes
(including abstract ones), and to look at the 'abstract' field directly.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170707122215.8819-3-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi-schema.json               |  5 +++-
 qmp.c                          |  1 +
 tests/device-introspect-test.c | 53 +++++++++++++++++++++++++++++++-----------
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index ab438ea..6486690 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3051,10 +3051,13 @@
 #
 # @name: the type name found in the search
 #
+# @abstract: the type is abstract and can't be directly instantiated.
+#            Omitted if false. (since 2.10)
+#
 # Since: 1.1
 ##
 { 'struct': 'ObjectTypeInfo',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', '*abstract': 'bool' } }
 
 ##
 # @qom-list-types:
diff --git a/qmp.c b/qmp.c
index 2cd40c3..7a9de06 100644
--- a/qmp.c
+++ b/qmp.c
@@ -433,6 +433,7 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
 
     info = g_malloc0(sizeof(*info));
     info->name = g_strdup(object_class_get_name(klass));
+    info->has_abstract = info->abstract = object_class_is_abstract(klass);
 
     e = g_malloc0(sizeof(*e));
     e->value = info;
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index f1e6ddd..78d4811 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -103,6 +103,33 @@ static void test_device_intro_list(void)
     qtest_end();
 }
 
+static void test_qom_list_fields(void)
+{
+    QList *all_types;
+    QList *non_abstract;
+    QListEntry *e;
+
+    qtest_start(common_args);
+
+    all_types = qom_list_types(NULL, true);
+    non_abstract = qom_list_types(NULL, false);
+
+    QLIST_FOREACH_ENTRY(all_types, e) {
+        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+        const char *name = qdict_get_str(d, "name");
+        bool abstract = qdict_haskey(d, "abstract") ?
+                        qdict_get_bool(d, "abstract") :
+                        false;
+        bool expected_abstract = !type_list_find(non_abstract, name);
+
+        g_assert(abstract == expected_abstract);
+    }
+
+    QDECREF(all_types);
+    QDECREF(non_abstract);
+    qtest_end();
+}
+
 static void test_device_intro_none(void)
 {
     qtest_start(common_args);
@@ -144,25 +171,24 @@ static void test_abstract_interfaces(void)
     QListEntry *e;
 
     qtest_start(common_args);
-    /* qom-list-types implements=interface would return any type
-     * that implements _any_ interface (not just interface types),
-     * so use a trick to find the interface type names:
-     * - list all object types
-     * - list all types, and look for items that are not
-     *   on the first list
+    /*
+     * qom-list-types implements=interface returns all types that
+     * implement _any_ interface (not just interface types), but
+     * we can filter them out because interfaces don't implement
+     * the "object" type.
      */
-    all_types = qom_list_types(NULL, false);
-    obj_types = qom_list_types("object", false);
+    all_types = qom_list_types("interface", true);
+    obj_types = qom_list_types("object", true);
 
     QLIST_FOREACH_ENTRY(all_types, e) {
         QDict *d = qobject_to_qdict(qlist_entry_obj(e));
 
-        /*
-         * An interface (incorrectly) marked as non-abstract would
-         * appear on all_types, but not on obj_types:
-         */
-        g_assert(type_list_find(obj_types, qdict_get_str(d, "name")));
+        if (type_list_find(obj_types, qdict_get_str(d, "name"))) {
+            /* Not an interface type */
+            continue;
+        }
 
+        g_assert(qdict_haskey(d, "abstract") && qdict_get_bool(d, "abstract"));
     }
 
     QDECREF(all_types);
@@ -175,6 +201,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("device/introspect/list", test_device_intro_list);
+    qtest_add_func("device/introspect/list-fields", test_qom_list_fields);
     qtest_add_func("device/introspect/none", test_device_intro_none);
     qtest_add_func("device/introspect/abstract", test_device_intro_abstract);
     qtest_add_func("device/introspect/concrete", test_device_intro_concrete);
-- 
2.9.4
