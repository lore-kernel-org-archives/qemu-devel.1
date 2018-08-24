Received: from eggs.gnu.org ([2001:4830:134:3::10]:33377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHom-0002Jo-Ml
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001fZ-Fi
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoc-0001Yq-44
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EBDD87A74
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4D802026E18
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:13 +0200
Message-Id: <20180824193206.25475-6-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 05/58] qmp-cmd-test: Split off qmp-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qmp-test is for QMP protocol tests.  Commit e4a426e75ef added generic,
basic tests of query commands to it.  Move them to their own test
program qmp-cmd-test, to keep qmp-test focused on the protocol.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-6-armbru@redhat.com>
---
 MAINTAINERS            |   1 +
 tests/Makefile.include |   3 +
 tests/qmp-cmd-test.c   | 213 +++++++++++++++++++++++++++++++++++++++++
 tests/qmp-test.c       | 193 +------------------------------------
 4 files changed, 219 insertions(+), 191 deletions(-)
 create mode 100644 tests/qmp-cmd-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 53a8b931bb..089b5af4d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1715,6 +1715,7 @@ F: monitor.c
 F: docs/devel/*qmp-*
 F: scripts/qmp/
 F: tests/qmp-test.c
+F: tests/qmp-cmd-test.c
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
 
 qtest
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 575a66f8b6..636b3d7ff8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -183,6 +183,8 @@ check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
 
 check-qtest-generic-y = tests/qmp-test$(EXESUF)
 gcov-files-generic-y = monitor.c qapi/qmp-dispatch.c
+check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
+
 check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
 gcov-files-generic-y = qdev-monitor.c qmp.c
 check-qtest-generic-y += tests/cdrom-test$(EXESUF)
@@ -779,6 +781,7 @@ libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
 
 tests/qmp-test$(EXESUF): tests/qmp-test.o
+tests/qmp-cmd-test$(EXESUF): tests/qmp-cmd-test.o
 tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
 tests/rtc-test$(EXESUF): tests/rtc-test.o
 tests/m48t59-test$(EXESUF): tests/m48t59-test.o
diff --git a/tests/qmp-cmd-test.c b/tests/qmp-cmd-test.c
new file mode 100644
index 0000000000..c5b70df974
--- /dev/null
+++ b/tests/qmp-cmd-test.c
@@ -0,0 +1,213 @@
+/*
+ * QMP command test cases
+ *
+ * Copyright (c) 2017 Red Hat Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qapi/error.h"
+#include "qapi/qapi-visit-introspect.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qobject-input-visitor.h"
+
+const char common_args[] = "-nodefaults -machine none";
+
+/* Query smoke tests */
+
+static int query_error_class(const char *cmd)
+{
+    static struct {
+        const char *cmd;
+        int err_class;
+    } fails[] = {
+        /* Success depends on build configuration: */
+#ifndef CONFIG_SPICE
+        { "query-spice", ERROR_CLASS_COMMAND_NOT_FOUND },
+#endif
+#ifndef CONFIG_VNC
+        { "query-vnc", ERROR_CLASS_GENERIC_ERROR },
+        { "query-vnc-servers", ERROR_CLASS_GENERIC_ERROR },
+#endif
+#ifndef CONFIG_REPLICATION
+        { "query-xen-replication-status", ERROR_CLASS_COMMAND_NOT_FOUND },
+#endif
+        /* Likewise, and require special QEMU command-line arguments: */
+        { "query-acpi-ospm-status", ERROR_CLASS_GENERIC_ERROR },
+        { "query-balloon", ERROR_CLASS_DEVICE_NOT_ACTIVE },
+        { "query-hotpluggable-cpus", ERROR_CLASS_GENERIC_ERROR },
+        { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
+        { NULL, -1 }
+    };
+    int i;
+
+    for (i = 0; fails[i].cmd; i++) {
+        if (!strcmp(cmd, fails[i].cmd)) {
+            return fails[i].err_class;
+        }
+    }
+    return -1;
+}
+
+static void test_query(const void *data)
+{
+    const char *cmd = data;
+    int expected_error_class = query_error_class(cmd);
+    QDict *resp, *error;
+    const char *error_class;
+
+    qtest_start(common_args);
+
+    resp = qmp("{ 'execute': %s }", cmd);
+    error = qdict_get_qdict(resp, "error");
+    error_class = error ? qdict_get_str(error, "class") : NULL;
+
+    if (expected_error_class < 0) {
+        g_assert(qdict_haskey(resp, "return"));
+    } else {
+        g_assert(error);
+        g_assert_cmpint(qapi_enum_parse(&QapiErrorClass_lookup, error_class,
+                                        -1, &error_abort),
+                        ==, expected_error_class);
+    }
+    qobject_unref(resp);
+
+    qtest_end();
+}
+
+static bool query_is_blacklisted(const char *cmd)
+{
+    const char *blacklist[] = {
+        /* Not actually queries: */
+        "add-fd",
+        /* Success depends on target arch: */
+        "query-cpu-definitions",  /* arm, i386, ppc, s390x */
+        "query-gic-capabilities", /* arm */
+        /* Success depends on target-specific build configuration: */
+        "query-pci",              /* CONFIG_PCI */
+        /* Success depends on launching SEV guest */
+        "query-sev-launch-measure",
+        /* Success depends on Host or Hypervisor SEV support */
+        "query-sev",
+        "query-sev-capabilities",
+        NULL
+    };
+    int i;
+
+    for (i = 0; blacklist[i]; i++) {
+        if (!strcmp(cmd, blacklist[i])) {
+            return true;
+        }
+    }
+    return false;
+}
+
+typedef struct {
+    SchemaInfoList *list;
+    GHashTable *hash;
+} QmpSchema;
+
+static void qmp_schema_init(QmpSchema *schema)
+{
+    QDict *resp;
+    Visitor *qiv;
+    SchemaInfoList *tail;
+
+    qtest_start(common_args);
+    resp = qmp("{ 'execute': 'query-qmp-schema' }");
+
+    qiv = qobject_input_visitor_new(qdict_get(resp, "return"));
+    visit_type_SchemaInfoList(qiv, NULL, &schema->list, &error_abort);
+    visit_free(qiv);
+
+    qobject_unref(resp);
+    qtest_end();
+
+    schema->hash = g_hash_table_new(g_str_hash, g_str_equal);
+
+    /* Build @schema: hash table mapping entity name to SchemaInfo */
+    for (tail = schema->list; tail; tail = tail->next) {
+        g_hash_table_insert(schema->hash, tail->value->name, tail->value);
+    }
+}
+
+static SchemaInfo *qmp_schema_lookup(QmpSchema *schema, const char *name)
+{
+    return g_hash_table_lookup(schema->hash, name);
+}
+
+static void qmp_schema_cleanup(QmpSchema *schema)
+{
+    qapi_free_SchemaInfoList(schema->list);
+    g_hash_table_destroy(schema->hash);
+}
+
+static bool object_type_has_mandatory_members(SchemaInfo *type)
+{
+    SchemaInfoObjectMemberList *tail;
+
+    g_assert(type->meta_type == SCHEMA_META_TYPE_OBJECT);
+
+    for (tail = type->u.object.members; tail; tail = tail->next) {
+        if (!tail->value->has_q_default) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static void add_query_tests(QmpSchema *schema)
+{
+    SchemaInfoList *tail;
+    SchemaInfo *si, *arg_type, *ret_type;
+    char *test_name;
+
+    /* Test the query-like commands */
+    for (tail = schema->list; tail; tail = tail->next) {
+        si = tail->value;
+        if (si->meta_type != SCHEMA_META_TYPE_COMMAND) {
+            continue;
+        }
+
+        if (query_is_blacklisted(si->name)) {
+            continue;
+        }
+
+        arg_type = qmp_schema_lookup(schema, si->u.command.arg_type);
+        if (object_type_has_mandatory_members(arg_type)) {
+            continue;
+        }
+
+        ret_type = qmp_schema_lookup(schema, si->u.command.ret_type);
+        if (ret_type->meta_type == SCHEMA_META_TYPE_OBJECT
+            && !ret_type->u.object.members) {
+            continue;
+        }
+
+        test_name = g_strdup_printf("qmp/%s", si->name);
+        qtest_add_data_func(test_name, si->name, test_query);
+        g_free(test_name);
+    }
+}
+
+int main(int argc, char *argv[])
+{
+    QmpSchema schema;
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qmp_schema_init(&schema);
+    add_query_tests(&schema);
+    ret = g_test_run();
+
+    qmp_schema_cleanup(&schema);
+    return ret;
+}
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 487ef946ed..dbc8f6c16e 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2017 Red Hat Inc.
  *
  * Authors:
- *  Markus Armbruster <armbru@redhat.com>,
+ *  Markus Armbruster <armbru@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -13,13 +13,10 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-introspect.h"
 #include "qapi/qapi-visit-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/util.h"
-#include "qapi/visitor.h"
 #include "qapi/qmp/qstring.h"
 
 const char common_args[] = "-nodefaults -machine none";
@@ -253,184 +250,6 @@ static void test_qmp_oob(void)
     qtest_quit(qts);
 }
 
-/* Query smoke tests */
-
-static int query_error_class(const char *cmd)
-{
-    static struct {
-        const char *cmd;
-        int err_class;
-    } fails[] = {
-        /* Success depends on build configuration: */
-#ifndef CONFIG_SPICE
-        { "query-spice", ERROR_CLASS_COMMAND_NOT_FOUND },
-#endif
-#ifndef CONFIG_VNC
-        { "query-vnc", ERROR_CLASS_GENERIC_ERROR },
-        { "query-vnc-servers", ERROR_CLASS_GENERIC_ERROR },
-#endif
-#ifndef CONFIG_REPLICATION
-        { "query-xen-replication-status", ERROR_CLASS_COMMAND_NOT_FOUND },
-#endif
-        /* Likewise, and require special QEMU command-line arguments: */
-        { "query-acpi-ospm-status", ERROR_CLASS_GENERIC_ERROR },
-        { "query-balloon", ERROR_CLASS_DEVICE_NOT_ACTIVE },
-        { "query-hotpluggable-cpus", ERROR_CLASS_GENERIC_ERROR },
-        { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
-        { NULL, -1 }
-    };
-    int i;
-
-    for (i = 0; fails[i].cmd; i++) {
-        if (!strcmp(cmd, fails[i].cmd)) {
-            return fails[i].err_class;
-        }
-    }
-    return -1;
-}
-
-static void test_query(const void *data)
-{
-    const char *cmd = data;
-    int expected_error_class = query_error_class(cmd);
-    QDict *resp, *error;
-    const char *error_class;
-
-    qtest_start(common_args);
-
-    resp = qmp("{ 'execute': %s }", cmd);
-    error = qdict_get_qdict(resp, "error");
-    error_class = error ? qdict_get_str(error, "class") : NULL;
-
-    if (expected_error_class < 0) {
-        g_assert(qdict_haskey(resp, "return"));
-    } else {
-        g_assert(error);
-        g_assert_cmpint(qapi_enum_parse(&QapiErrorClass_lookup, error_class,
-                                        -1, &error_abort),
-                        ==, expected_error_class);
-    }
-    qobject_unref(resp);
-
-    qtest_end();
-}
-
-static bool query_is_blacklisted(const char *cmd)
-{
-    const char *blacklist[] = {
-        /* Not actually queries: */
-        "add-fd",
-        /* Success depends on target arch: */
-        "query-cpu-definitions",  /* arm, i386, ppc, s390x */
-        "query-gic-capabilities", /* arm */
-        /* Success depends on target-specific build configuration: */
-        "query-pci",              /* CONFIG_PCI */
-        /* Success depends on launching SEV guest */
-        "query-sev-launch-measure",
-        /* Success depends on Host or Hypervisor SEV support */
-        "query-sev",
-        "query-sev-capabilities",
-        NULL
-    };
-    int i;
-
-    for (i = 0; blacklist[i]; i++) {
-        if (!strcmp(cmd, blacklist[i])) {
-            return true;
-        }
-    }
-    return false;
-}
-
-typedef struct {
-    SchemaInfoList *list;
-    GHashTable *hash;
-} QmpSchema;
-
-static void qmp_schema_init(QmpSchema *schema)
-{
-    QDict *resp;
-    Visitor *qiv;
-    SchemaInfoList *tail;
-
-    qtest_start(common_args);
-    resp = qmp("{ 'execute': 'query-qmp-schema' }");
-
-    qiv = qobject_input_visitor_new(qdict_get(resp, "return"));
-    visit_type_SchemaInfoList(qiv, NULL, &schema->list, &error_abort);
-    visit_free(qiv);
-
-    qobject_unref(resp);
-    qtest_end();
-
-    schema->hash = g_hash_table_new(g_str_hash, g_str_equal);
-
-    /* Build @schema: hash table mapping entity name to SchemaInfo */
-    for (tail = schema->list; tail; tail = tail->next) {
-        g_hash_table_insert(schema->hash, tail->value->name, tail->value);
-    }
-}
-
-static SchemaInfo *qmp_schema_lookup(QmpSchema *schema, const char *name)
-{
-    return g_hash_table_lookup(schema->hash, name);
-}
-
-static void qmp_schema_cleanup(QmpSchema *schema)
-{
-    qapi_free_SchemaInfoList(schema->list);
-    g_hash_table_destroy(schema->hash);
-}
-
-static bool object_type_has_mandatory_members(SchemaInfo *type)
-{
-    SchemaInfoObjectMemberList *tail;
-
-    g_assert(type->meta_type == SCHEMA_META_TYPE_OBJECT);
-
-    for (tail = type->u.object.members; tail; tail = tail->next) {
-        if (!tail->value->has_q_default) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static void add_query_tests(QmpSchema *schema)
-{
-    SchemaInfoList *tail;
-    SchemaInfo *si, *arg_type, *ret_type;
-    char *test_name;
-
-    /* Test the query-like commands */
-    for (tail = schema->list; tail; tail = tail->next) {
-        si = tail->value;
-        if (si->meta_type != SCHEMA_META_TYPE_COMMAND) {
-            continue;
-        }
-
-        if (query_is_blacklisted(si->name)) {
-            continue;
-        }
-
-        arg_type = qmp_schema_lookup(schema, si->u.command.arg_type);
-        if (object_type_has_mandatory_members(arg_type)) {
-            continue;
-        }
-
-        ret_type = qmp_schema_lookup(schema, si->u.command.ret_type);
-        if (ret_type->meta_type == SCHEMA_META_TYPE_OBJECT
-            && !ret_type->u.object.members) {
-            continue;
-        }
-
-        test_name = g_strdup_printf("qmp/%s", si->name);
-        qtest_add_data_func(test_name, si->name, test_query);
-        g_free(test_name);
-    }
-}
-
 /* Preconfig tests */
 
 static void test_qmp_preconfig(void)
@@ -474,19 +293,11 @@ static void test_qmp_preconfig(void)
 
 int main(int argc, char *argv[])
 {
-    QmpSchema schema;
-    int ret;
-
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("qmp/protocol", test_qmp_protocol);
     qtest_add_func("qmp/oob", test_qmp_oob);
-    qmp_schema_init(&schema);
-    add_query_tests(&schema);
     qtest_add_func("qmp/preconfig", test_qmp_preconfig);
 
-    ret = g_test_run();
-
-    qmp_schema_cleanup(&schema);
-    return ret;
+    return g_test_run();
 }
-- 
2.17.1
