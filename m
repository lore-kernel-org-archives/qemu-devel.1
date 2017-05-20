Received: from eggs.gnu.org ([2001:4830:134:3::10]:45023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dBtpc-0000k5-P7
	for qemu-devel@nongnu.org; Fri, 19 May 2017 22:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dBtpb-0005QU-GR
	for qemu-devel@nongnu.org; Fri, 19 May 2017 22:09:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dBtpb-0005Q6-7Y
	for qemu-devel@nongnu.org; Fri, 19 May 2017 22:09:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48B844E040
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 02:09:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 May 2017 23:09:14 -0300
Message-Id: <20170520020914.14562-4-ehabkost@redhat.com>
In-Reply-To: <20170520020914.14562-1-ehabkost@redhat.com>
References: <20170520020914.14562-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 3/3] qmp: Include parent types on
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

Include list of parent types of each type on 'qom-list-types' output.

Without this, there's no way to figure out the parents of a given type
without making additional 'qom-list-types' queries.

In addition to the test case for the new feature, update the
abstract-interface test case to use the new field and avoid the
"qom-list-types implements=object" trick.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
I would to include a "interfaces" field in the future, too, but
this would require extending the core QOM API to allow that.
---
 qapi-schema.json               |  6 ++++-
 qmp.c                          | 16 +++++++++++
 tests/device-introspect-test.c | 61 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index cbf1e2a837..169dfd2d7f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3037,12 +3037,16 @@
 # @abstract: the type is abstract and can't be directly instantiated
 #            (since 2.10)
 #
+# @parent-types: parent types.  Parent types implemented by the type.  Note that
+#           this doesn't include interface names also implemented by the type.
+#           (since 2.10)
+#
 # Since: 1.1
 #
 # Notes: This command is experimental and may change syntax in future releases.
 ##
 { 'struct': 'ObjectTypeInfo',
-  'data': { 'name': 'str', 'abstract': 'bool' } }
+  'data': { 'name': 'str', 'abstract': 'bool', 'parent-types': [ 'str' ] } }
 
 ##
 # @qom-list-types:
diff --git a/qmp.c b/qmp.c
index 8066705dbe..5b50f6f650 100644
--- a/qmp.c
+++ b/qmp.c
@@ -436,6 +436,21 @@ void qmp_change(const char *device, const char *target,
     }
 }
 
+static strList *qom_type_get_parents(ObjectClass *klass)
+{
+    ObjectClass *parent = object_class_get_parent(klass);
+    strList *r = NULL;
+
+    if (!parent) {
+        return NULL;
+    }
+
+    r = g_new0(strList, 1);
+    r->value = g_strdup(object_class_get_name(parent));
+    r->next = qom_type_get_parents(parent);
+    return r;
+}
+
 static void qom_list_types_tramp(ObjectClass *klass, void *data)
 {
     ObjectTypeInfoList *e, **pret = data;
@@ -444,6 +459,7 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
     info = g_malloc0(sizeof(*info));
     info->name = g_strdup(object_class_get_name(klass));
     info->abstract = object_class_is_abstract(klass);
+    info->parent_types = qom_type_get_parents(klass);
 
     e = g_malloc0(sizeof(*e));
     e->value = info;
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index d5aacb4ed1..350b862f3b 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -61,6 +61,20 @@ static QDict *type_list_find(QList *types, const char *name)
     return NULL;
 }
 
+static bool str_list_has(QList *strlist, const char *str)
+{
+    QListEntry *e;
+
+    QLIST_FOREACH_ENTRY(strlist, e) {
+        const char *s = qstring_get_str(qobject_to_qstring(qlist_entry_obj(e)));
+        if (!strcmp(s, str)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static QList *device_type_list(bool abstract)
 {
     return qom_list_types("device", abstract);
@@ -103,6 +117,31 @@ static void test_device_intro_list(void)
     qtest_end();
 }
 
+/*
+ * Ensure all entries returned by qom-list-types implements=<parent>
+ * have <parent> in parent-types.
+ */
+static void test_qom_list_parents(const char *parent)
+{
+    QList *types;
+    QListEntry *e;
+
+    types = qom_list_types(parent, true);
+
+    QLIST_FOREACH_ENTRY(types, e) {
+        QDict *d = qobject_to_qdict(qlist_entry_obj(e));
+
+        /* The parent type being queried is included in the list too, skip it */
+        if (!strcmp(qdict_get_str(d, "name"), parent)) {
+            continue;
+        }
+
+        g_assert(str_list_has(qdict_get_qlist(d, "parent-types"), parent));
+    }
+
+    QDECREF(types);
+}
+
 static void test_qom_list_fields(void)
 {
     QList *all_types;
@@ -123,6 +162,10 @@ static void test_qom_list_fields(void)
         g_assert(abstract == expected_abstract);
     }
 
+    test_qom_list_parents("object");
+    test_qom_list_parents("device");
+    test_qom_list_parents("sys-bus-device");
+
     QDECREF(all_types);
     QDECREF(non_abstract);
     qtest_end();
@@ -165,23 +208,22 @@ static void test_device_intro_concrete(void)
 static void test_abstract_interfaces(void)
 {
     QList *all_types;
-    QList *obj_types;
     QListEntry *e;
 
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
 
     QLIST_FOREACH_ENTRY(all_types, e) {
         QDict *d = qobject_to_qdict(qlist_entry_obj(e));
 
-        if (type_list_find(obj_types, qdict_get_str(d, "name"))) {
+        /*
+         * qom-list-types implements=interface returns all types
+         * that implement _any_ interface (not just interface
+         * types), so skip the ones that don't have "interface"
+         * on parent-types.
+         */
+        if (!str_list_has(qdict_get_qlist(d, "parent-types"), "interface")) {
             /* Not an interface type */
             continue;
         }
@@ -190,7 +232,6 @@ static void test_abstract_interfaces(void)
     }
 
     QDECREF(all_types);
-    QDECREF(obj_types);
     qtest_end();
 }
 
-- 
2.11.0.259.g40922b1
