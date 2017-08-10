Received: from eggs.gnu.org ([2001:4830:134:3::10]:42089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfsDw-0007rb-IP
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfsDs-0000LK-BJ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfsDs-0000JP-2A
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:30:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 114CC7DD05
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 18:30:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 10 Aug 2017 20:30:16 +0200
Message-Id: <1502389816-29772-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/qmp-test: Add generic,
 basic test of query commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: crosa@redhat.com

A command is a query if it has no side effect and yields a result.
Such commands are typically named query-FOO, but there are exceptions.

The basic idea is to find candidates with query-qmp-schema, filter out
the ones that aren't queries with an explicit blacklist, and test the
remaining ones against a QEMU with no special arguments.

The current blacklist is just add-fd.

query-qmp-schema reports a few commands that aren't actually
available.  See qmp_unregister_commands_hack() for details.  Work
around this flaw by accepting CommandNotFound errors, but add a TODO
to drop this when the flaw is fixed.

The test can't do queries with arguments, because it knows nothing
about the arguments.  No coverage for query-cpu-model-baseline,
query-cpu-model-comparison and query-cpu-model-expansion, because
query-rocker, query-rocker-ports, query-rocker-of-dpa-flows and
query-rocker-of-dpa-groups.

We get basic test coverage for the following commands:

    qom-list-types
    query-acpi-ospm-status
    query-balloon               (expected to fail)
    query-block
    query-block-jobs
    query-blockstats
    query-chardev
    query-chardev-backends
    query-command-line-options
    query-commands
    query-cpu-definitions
    query-cpus
    query-dump
    query-dump-guest-memory-capability
    query-events
    query-fdsets
    query-gic-capabilities
    query-hotpluggable-cpus
    query-iothreads
    query-kvm
    query-machines
    query-memdev
    query-memory-devices
    query-mice
    query-migrate
    query-migrate-cache-size
    query-migrate-capabilities
    query-migrate-parameters
    query-name
    query-named-block-nodes
    query-pci
    query-qmp-schema
    query-rx-filter
    query-spice
    query-status
    query-target
    query-tpm
    query-tpm-models
    query-tpm-types
    query-uuid
    query-version
    query-vm-generation-id      (expected to fail)
    query-vnc
    query-vnc-servers
    query-xen-replication-status

Most tested commands are expected to succeed.  The test does not check
the return value then.  A few commands are expected to fail because
they need special arguments to succeed, and this test is too dumb to
supply them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qmp-test.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 1 deletion(-)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5d0260b..f62d34c 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -15,6 +15,7 @@
 #include "qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
+#include "qapi/util.h"
 #include "qapi/visitor.h"
 
 const char common_args[] = "-nodefaults -machine none";
@@ -129,11 +130,181 @@ static void test_qmp_protocol(void)
     qtest_end();
 }
 
+static int query_error_class(const char *cmd)
+{
+    static struct {
+        const char *cmd;
+        int err_class;
+    } fails[] = {
+        { "query-balloon", ERROR_CLASS_DEVICE_NOT_ACTIVE },
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
+    qtest_start("-nodefaults");
+
+    resp = qmp("{ 'execute': %s }", cmd);
+    error = qdict_get_qdict(resp, "error");
+    error_class = error ? qdict_get_str(error, "class") : NULL;
+
+    if (expected_error_class < 0) {
+        /*
+         * query-qmp-schema reports a few commands that aren't
+         * actually available.  See qmp_unregister_commands_hack() for
+         * details.  Work around this flaw:
+         * TODO drop when the flaw is fixed
+         */
+        if (error) {
+            g_assert_cmpstr(error_class, ==,
+                    QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND]);
+        } else {
+            g_assert(qdict_haskey(resp, "return"));
+        }
+    } else {
+        g_assert(error);
+        g_assert_cmpint(qapi_enum_parse(QapiErrorClass_lookup, error_class,
+                                        QAPI_ERROR_CLASS__MAX, -1,
+                                        &error_abort),
+                        ==, expected_error_class);
+    }
+    QDECREF(resp);
+
+    qtest_end();
+}
+
+static bool query_is_blacklisted(const char *cmd)
+{
+    const char *blacklist[] = {
+        "add-fd",
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
+    qtest_start("-nodefaults");
+    resp = qmp("{ 'execute': 'query-qmp-schema' }");
+
+    qiv = qobject_input_visitor_new(qdict_get(resp, "return"));
+    visit_type_SchemaInfoList(qiv, NULL, &schema->list, &error_abort);
+    visit_free(qiv);
+
+    QDECREF(resp);
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
+    const char *test_name;
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
+    }
+}
+
 int main(int argc, char *argv[])
 {
+    QmpSchema schema;
+    int ret;
+
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qmp_schema_init(&schema);
+    add_query_tests(&schema);
 
-    return g_test_run();
+    ret = g_test_run();
+
+    qmp_schema_cleanup(&schema);
+    return ret;
 }
-- 
2.7.5
