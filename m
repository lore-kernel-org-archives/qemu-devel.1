Received: from eggs.gnu.org ([2001:4830:134:3::10]:45612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6n-0001bC-Nu
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6g-0006vh-UZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cin6g-0006uO-K3
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:42 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D57CC81127
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SJ6fVj020656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:06:42 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 20:06:28 +0100
Message-Id: <1488308796-28832-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1488308796-28832-1-git-send-email-armbru@redhat.com>
References: <1488308796-28832-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 18/26] tests-qobject-input-strict: Merge into
 test-qobject-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Much of test-qobject-input-strict.c duplicates
test-qobject-input-strict.c, but with less assertions on expected
output:

* test_validate_struct() duplicates test_visitor_in_struct()

* test_validate_struct_nested() duplicates
  test_visitor_in_struct_nested()

* test_validate_list() duplicates the first half of
  test_visitor_in_list()

* test_validate_union_native_list() duplicates
  test_visitor_in_native_list_int()

* test_validate_union_flat() duplicates test_visitor_in_union_flat()

* test_validate_alternate() duplicates the first part of
  test_visitor_in_alternate()

Merge the remaining test cases into test-qobject-input-visitor.c, and
drop the now redundant test-qobject-input-strict.c.

Test case "/visitor/input-strict/fail/list" isn't really about lists,
it's about a bad struct nested in a list.  Rename accordingly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488303560-18803-19-git-send-email-armbru@redhat.com>
---
 tests/Makefile.include             |   4 +-
 tests/test-qobject-input-strict.c  | 381 -------------------------------------
 tests/test-qobject-input-visitor.c | 187 ++++++++++++++++++
 3 files changed, 188 insertions(+), 384 deletions(-)
 delete mode 100644 tests/test-qobject-input-strict.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4f52239..8b3e2bd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -28,7 +28,6 @@ check-unit-y += tests/test-clone-visitor$(EXESUF)
 gcov-files-test-clone-visitor-y = qapi/qapi-clone-visitor.c
 check-unit-y += tests/test-qobject-input-visitor$(EXESUF)
 gcov-files-test-qobject-input-visitor-y = qapi/qobject-input-visitor.c
-check-unit-y += tests/test-qobject-input-strict$(EXESUF)
 check-unit-y += tests/test-qmp-commands$(EXESUF)
 gcov-files-test-qmp-commands-y = qapi/qmp-dispatch.c
 check-unit-y += tests/test-string-input-visitor$(EXESUF)
@@ -489,7 +488,7 @@ test-obj-y = tests/check-qint.o tests/check-qstring.o tests/check-qdict.o \
 	tests/test-coroutine.o tests/test-string-output-visitor.o \
 	tests/test-string-input-visitor.o tests/test-qobject-output-visitor.o \
 	tests/test-clone-visitor.o \
-	tests/test-qobject-input-visitor.o tests/test-qobject-input-strict.o \
+	tests/test-qobject-input-visitor.o \
 	tests/test-qmp-commands.o tests/test-visitor-serialization.o \
 	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
 	tests/test-opts-visitor.o tests/test-qmp-event.o \
@@ -598,7 +597,6 @@ tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)
 tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visitor.o $(test-qapi-obj-y)
 tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-obj-y)
 tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visitor.o $(test-qapi-obj-y)
-tests/test-qobject-input-strict$(EXESUF): tests/test-qobject-input-strict.o $(test-qapi-obj-y)
 tests/test-qmp-commands$(EXESUF): tests/test-qmp-commands.o tests/test-qmp-marshal.o $(test-qapi-obj-y)
 tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serialization.o $(test-qapi-obj-y)
 tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
diff --git a/tests/test-qobject-input-strict.c b/tests/test-qobject-input-strict.c
deleted file mode 100644
index 7d26113..0000000
--- a/tests/test-qobject-input-strict.c
+++ /dev/null
@@ -1,381 +0,0 @@
-/*
- * QObject Input Visitor unit-tests (strict mode).
- *
- * Copyright (C) 2011-2012, 2015 Red Hat Inc.
- *
- * Authors:
- *  Luiz Capitulino <lcapitulino@redhat.com>
- *  Paolo Bonzini <pbonzini@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-
-#include "qemu-common.h"
-#include "qapi/error.h"
-#include "qapi/qobject-input-visitor.h"
-#include "test-qapi-types.h"
-#include "test-qapi-visit.h"
-#include "qapi/qmp/types.h"
-#include "qapi/qmp/qjson.h"
-#include "test-qmp-introspect.h"
-#include "qmp-introspect.h"
-#include "qapi-visit.h"
-
-typedef struct TestInputVisitorData {
-    QObject *obj;
-    Visitor *qiv;
-} TestInputVisitorData;
-
-static void validate_teardown(TestInputVisitorData *data,
-                               const void *unused)
-{
-    qobject_decref(data->obj);
-    data->obj = NULL;
-
-    if (data->qiv) {
-        visit_free(data->qiv);
-        data->qiv = NULL;
-    }
-}
-
-/* The various test_init functions are provided instead of a test setup
-   function so that the JSON string used by the tests are kept in the test
-   functions (and not in main()). */
-static Visitor *validate_test_init_internal(TestInputVisitorData *data,
-                                            const char *json_string,
-                                            va_list *ap)
-{
-    validate_teardown(data, NULL);
-
-    data->obj = qobject_from_jsonv(json_string, ap);
-    g_assert(data->obj);
-
-    data->qiv = qobject_input_visitor_new(data->obj);
-    g_assert(data->qiv);
-    return data->qiv;
-}
-
-static GCC_FMT_ATTR(2, 3)
-Visitor *validate_test_init(TestInputVisitorData *data,
-                             const char *json_string, ...)
-{
-    Visitor *v;
-    va_list ap;
-
-    va_start(ap, json_string);
-    v = validate_test_init_internal(data, json_string, &ap);
-    va_end(ap);
-    return v;
-}
-
-/* similar to validate_test_init(), but does not expect a string
- * literal/format json_string argument and so can be used for
- * programatically generated strings (and we can't pass in programatically
- * generated strings via %s format parameters since qobject_from_jsonv()
- * will wrap those in double-quotes and treat the entire object as a
- * string)
- */
-static Visitor *validate_test_init_raw(TestInputVisitorData *data,
-                                       const char *json_string)
-{
-    return validate_test_init_internal(data, json_string, NULL);
-}
-
-
-static void test_validate_struct(TestInputVisitorData *data,
-                                  const void *unused)
-{
-    TestStruct *p = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data, "{ 'integer': -42, 'boolean': true, 'string': 'foo' }");
-
-    visit_type_TestStruct(v, NULL, &p, &error_abort);
-    g_free(p->string);
-    g_free(p);
-}
-
-static void test_validate_struct_nested(TestInputVisitorData *data,
-                                         const void *unused)
-{
-    UserDefTwo *udp = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data, "{ 'string0': 'string0', "
-                           "'dict1': { 'string1': 'string1', "
-                           "'dict2': { 'userdef': { 'integer': 42, "
-                           "'string': 'string' }, 'string': 'string2'}}}");
-
-    visit_type_UserDefTwo(v, NULL, &udp, &error_abort);
-    qapi_free_UserDefTwo(udp);
-}
-
-static void test_validate_list(TestInputVisitorData *data,
-                                const void *unused)
-{
-    UserDefOneList *head = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data, "[ { 'string': 'string0', 'integer': 42 }, { 'string': 'string1', 'integer': 43 }, { 'string': 'string2', 'integer': 44 } ]");
-
-    visit_type_UserDefOneList(v, NULL, &head, &error_abort);
-    qapi_free_UserDefOneList(head);
-}
-
-static void test_validate_union_native_list(TestInputVisitorData *data,
-                                            const void *unused)
-{
-    UserDefNativeListUnion *tmp = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data, "{ 'type': 'integer', 'data' : [ 1, 2 ] }");
-
-    visit_type_UserDefNativeListUnion(v, NULL, &tmp, &error_abort);
-    qapi_free_UserDefNativeListUnion(tmp);
-}
-
-static void test_validate_union_flat(TestInputVisitorData *data,
-                                     const void *unused)
-{
-    UserDefFlatUnion *tmp = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data,
-                           "{ 'enum1': 'value1', "
-                           "'integer': 41, "
-                           "'string': 'str', "
-                           "'boolean': true }");
-
-    visit_type_UserDefFlatUnion(v, NULL, &tmp, &error_abort);
-    qapi_free_UserDefFlatUnion(tmp);
-}
-
-static void test_validate_alternate(TestInputVisitorData *data,
-                                    const void *unused)
-{
-    UserDefAlternate *tmp = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data, "42");
-
-    visit_type_UserDefAlternate(v, NULL, &tmp, &error_abort);
-    qapi_free_UserDefAlternate(tmp);
-}
-
-static void test_validate_fail_struct(TestInputVisitorData *data,
-                                       const void *unused)
-{
-    TestStruct *p = NULL;
-    Error *err = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data, "{ 'integer': -42, 'boolean': true, 'string': 'foo', 'extra': 42 }");
-
-    visit_type_TestStruct(v, NULL, &p, &err);
-    error_free_or_abort(&err);
-    g_assert(!p);
-}
-
-static void test_validate_fail_struct_nested(TestInputVisitorData *data,
-                                              const void *unused)
-{
-    UserDefTwo *udp = NULL;
-    Error *err = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data, "{ 'string0': 'string0', 'dict1': { 'string1': 'string1', 'dict2': { 'userdef1': { 'integer': 42, 'string': 'string', 'extra': [42, 23, {'foo':'bar'}] }, 'string2': 'string2'}}}");
-
-    visit_type_UserDefTwo(v, NULL, &udp, &err);
-    error_free_or_abort(&err);
-    g_assert(!udp);
-}
-
-static void test_validate_fail_struct_missing(TestInputVisitorData *data,
-                                              const void *unused)
-{
-    Error *err = NULL;
-    Visitor *v;
-    QObject *any;
-    GenericAlternate *alt;
-    bool present;
-    int en;
-    int64_t i64;
-    uint32_t u32;
-    int8_t i8;
-    char *str;
-    double dbl;
-
-    v = validate_test_init(data, "{}");
-    visit_start_struct(v, NULL, NULL, 0, &error_abort);
-    visit_start_struct(v, "struct", NULL, 0, &err);
-    error_free_or_abort(&err);
-    visit_start_list(v, "list", NULL, 0, &err);
-    error_free_or_abort(&err);
-    visit_start_alternate(v, "alternate", &alt, sizeof(*alt), false, &err);
-    error_free_or_abort(&err);
-    visit_optional(v, "optional", &present);
-    g_assert(!present);
-    visit_type_enum(v, "enum", &en, EnumOne_lookup, &err);
-    error_free_or_abort(&err);
-    visit_type_int(v, "i64", &i64, &err);
-    error_free_or_abort(&err);
-    visit_type_uint32(v, "u32", &u32, &err);
-    error_free_or_abort(&err);
-    visit_type_int8(v, "i8", &i8, &err);
-    error_free_or_abort(&err);
-    visit_type_str(v, "i8", &str, &err);
-    error_free_or_abort(&err);
-    visit_type_number(v, "dbl", &dbl, &err);
-    error_free_or_abort(&err);
-    visit_type_any(v, "any", &any, &err);
-    error_free_or_abort(&err);
-    visit_type_null(v, "null", &err);
-    error_free_or_abort(&err);
-    visit_end_struct(v, NULL);
-}
-
-static void test_validate_fail_list(TestInputVisitorData *data,
-                                     const void *unused)
-{
-    UserDefOneList *head = NULL;
-    Error *err = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data, "[ { 'string': 'string0', 'integer': 42 }, { 'string': 'string1', 'integer': 43 }, { 'string': 'string2', 'integer': 44, 'extra': 'ggg' } ]");
-
-    visit_type_UserDefOneList(v, NULL, &head, &err);
-    error_free_or_abort(&err);
-    g_assert(!head);
-}
-
-static void test_validate_fail_union_native_list(TestInputVisitorData *data,
-                                                 const void *unused)
-{
-    UserDefNativeListUnion *tmp = NULL;
-    Error *err = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data,
-                           "{ 'type': 'integer', 'data' : [ 'string' ] }");
-
-    visit_type_UserDefNativeListUnion(v, NULL, &tmp, &err);
-    error_free_or_abort(&err);
-    g_assert(!tmp);
-}
-
-static void test_validate_fail_union_flat(TestInputVisitorData *data,
-                                          const void *unused)
-{
-    UserDefFlatUnion *tmp = NULL;
-    Error *err = NULL;
-    Visitor *v;
-
-    v = validate_test_init(data, "{ 'string': 'c', 'integer': 41, 'boolean': true }");
-
-    visit_type_UserDefFlatUnion(v, NULL, &tmp, &err);
-    error_free_or_abort(&err);
-    g_assert(!tmp);
-}
-
-static void test_validate_fail_union_flat_no_discrim(TestInputVisitorData *data,
-                                                     const void *unused)
-{
-    UserDefFlatUnion2 *tmp = NULL;
-    Error *err = NULL;
-    Visitor *v;
-
-    /* test situation where discriminator field ('enum1' here) is missing */
-    v = validate_test_init(data, "{ 'integer': 42, 'string': 'c', 'string1': 'd', 'string2': 'e' }");
-
-    visit_type_UserDefFlatUnion2(v, NULL, &tmp, &err);
-    error_free_or_abort(&err);
-    g_assert(!tmp);
-}
-
-static void test_validate_fail_alternate(TestInputVisitorData *data,
-                                         const void *unused)
-{
-    UserDefAlternate *tmp;
-    Visitor *v;
-    Error *err = NULL;
-
-    v = validate_test_init(data, "3.14");
-
-    visit_type_UserDefAlternate(v, NULL, &tmp, &err);
-    error_free_or_abort(&err);
-    g_assert(!tmp);
-}
-
-static void do_test_validate_qmp_introspect(TestInputVisitorData *data,
-                                            const char *schema_json)
-{
-    SchemaInfoList *schema = NULL;
-    Visitor *v;
-
-    v = validate_test_init_raw(data, schema_json);
-
-    visit_type_SchemaInfoList(v, NULL, &schema, &error_abort);
-    g_assert(schema);
-
-    qapi_free_SchemaInfoList(schema);
-}
-
-static void test_validate_qmp_introspect(TestInputVisitorData *data,
-                                           const void *unused)
-{
-    do_test_validate_qmp_introspect(data, test_qmp_schema_json);
-    do_test_validate_qmp_introspect(data, qmp_schema_json);
-}
-
-static void validate_test_add(const char *testpath,
-                               TestInputVisitorData *data,
-                               void (*test_func)(TestInputVisitorData *data, const void *user_data))
-{
-    g_test_add(testpath, TestInputVisitorData, data, NULL, test_func,
-               validate_teardown);
-}
-
-int main(int argc, char **argv)
-{
-    TestInputVisitorData testdata;
-
-    g_test_init(&argc, &argv, NULL);
-
-    validate_test_add("/visitor/input-strict/pass/struct",
-                      &testdata, test_validate_struct);
-    validate_test_add("/visitor/input-strict/pass/struct-nested",
-                      &testdata, test_validate_struct_nested);
-    validate_test_add("/visitor/input-strict/pass/list",
-                      &testdata, test_validate_list);
-    validate_test_add("/visitor/input-strict/pass/union-flat",
-                      &testdata, test_validate_union_flat);
-    validate_test_add("/visitor/input-strict/pass/alternate",
-                      &testdata, test_validate_alternate);
-    validate_test_add("/visitor/input-strict/pass/union-native-list",
-                      &testdata, test_validate_union_native_list);
-    validate_test_add("/visitor/input-strict/fail/struct",
-                      &testdata, test_validate_fail_struct);
-    validate_test_add("/visitor/input-strict/fail/struct-nested",
-                      &testdata, test_validate_fail_struct_nested);
-    validate_test_add("/visitor/input-strict/fail/struct-missing",
-                      &testdata, test_validate_fail_struct_missing);
-    validate_test_add("/visitor/input-strict/fail/list",
-                      &testdata, test_validate_fail_list);
-    validate_test_add("/visitor/input-strict/fail/union-flat",
-                      &testdata, test_validate_fail_union_flat);
-    validate_test_add("/visitor/input-strict/fail/union-flat-no-discriminator",
-                      &testdata, test_validate_fail_union_flat_no_discrim);
-    validate_test_add("/visitor/input-strict/fail/alternate",
-                      &testdata, test_validate_fail_alternate);
-    validate_test_add("/visitor/input-strict/fail/union-native-list",
-                      &testdata, test_validate_fail_union_native_list);
-    validate_test_add("/visitor/input-strict/pass/qmp-introspect",
-                      &testdata, test_validate_qmp_introspect);
-
-    g_test_run();
-
-    return 0;
-}
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 658fa2c..32c6b3d 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -5,6 +5,7 @@
  *
  * Authors:
  *  Luiz Capitulino <lcapitulino@redhat.com>
+ *  Paolo Bonzini <pbonzini@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -19,6 +20,9 @@
 #include "test-qapi-visit.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qjson.h"
+#include "test-qmp-introspect.h"
+#include "qmp-introspect.h"
+#include "qapi-visit.h"
 
 typedef struct TestInputVisitorData {
     QObject *obj;
@@ -833,6 +837,171 @@ static void test_visitor_in_wrong_type(TestInputVisitorData *data,
     error_free_or_abort(&err);
 }
 
+static void test_visitor_in_fail_struct(TestInputVisitorData *data,
+                                        const void *unused)
+{
+    TestStruct *p = NULL;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init(data, "{ 'integer': -42, 'boolean': true, 'string': 'foo', 'extra': 42 }");
+
+    visit_type_TestStruct(v, NULL, &p, &err);
+    error_free_or_abort(&err);
+    g_assert(!p);
+}
+
+static void test_visitor_in_fail_struct_nested(TestInputVisitorData *data,
+                                               const void *unused)
+{
+    UserDefTwo *udp = NULL;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init(data, "{ 'string0': 'string0', 'dict1': { 'string1': 'string1', 'dict2': { 'userdef1': { 'integer': 42, 'string': 'string', 'extra': [42, 23, {'foo':'bar'}] }, 'string2': 'string2'}}}");
+
+    visit_type_UserDefTwo(v, NULL, &udp, &err);
+    error_free_or_abort(&err);
+    g_assert(!udp);
+}
+
+static void test_visitor_in_fail_struct_in_list(TestInputVisitorData *data,
+                                                const void *unused)
+{
+    UserDefOneList *head = NULL;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init(data, "[ { 'string': 'string0', 'integer': 42 }, { 'string': 'string1', 'integer': 43 }, { 'string': 'string2', 'integer': 44, 'extra': 'ggg' } ]");
+
+    visit_type_UserDefOneList(v, NULL, &head, &err);
+    error_free_or_abort(&err);
+    g_assert(!head);
+}
+
+static void test_visitor_in_fail_struct_missing(TestInputVisitorData *data,
+                                                const void *unused)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QObject *any;
+    GenericAlternate *alt;
+    bool present;
+    int en;
+    int64_t i64;
+    uint32_t u32;
+    int8_t i8;
+    char *str;
+    double dbl;
+
+    v = visitor_input_test_init(data, "{}");
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_start_struct(v, "struct", NULL, 0, &err);
+    error_free_or_abort(&err);
+    visit_start_list(v, "list", NULL, 0, &err);
+    error_free_or_abort(&err);
+    visit_start_alternate(v, "alternate", &alt, sizeof(*alt), false, &err);
+    error_free_or_abort(&err);
+    visit_optional(v, "optional", &present);
+    g_assert(!present);
+    visit_type_enum(v, "enum", &en, EnumOne_lookup, &err);
+    error_free_or_abort(&err);
+    visit_type_int(v, "i64", &i64, &err);
+    error_free_or_abort(&err);
+    visit_type_uint32(v, "u32", &u32, &err);
+    error_free_or_abort(&err);
+    visit_type_int8(v, "i8", &i8, &err);
+    error_free_or_abort(&err);
+    visit_type_str(v, "i8", &str, &err);
+    error_free_or_abort(&err);
+    visit_type_number(v, "dbl", &dbl, &err);
+    error_free_or_abort(&err);
+    visit_type_any(v, "any", &any, &err);
+    error_free_or_abort(&err);
+    visit_type_null(v, "null", &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+}
+
+static void test_visitor_in_fail_union_native_list(TestInputVisitorData *data,
+                                                   const void *unused)
+{
+    UserDefNativeListUnion *tmp = NULL;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init(data,
+                                "{ 'type': 'integer', 'data' : [ 'string' ] }");
+
+    visit_type_UserDefNativeListUnion(v, NULL, &tmp, &err);
+    error_free_or_abort(&err);
+    g_assert(!tmp);
+}
+
+static void test_visitor_in_fail_union_flat(TestInputVisitorData *data,
+                                            const void *unused)
+{
+    UserDefFlatUnion *tmp = NULL;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init(data, "{ 'string': 'c', 'integer': 41, 'boolean': true }");
+
+    visit_type_UserDefFlatUnion(v, NULL, &tmp, &err);
+    error_free_or_abort(&err);
+    g_assert(!tmp);
+}
+
+static void test_visitor_in_fail_union_flat_no_discrim(TestInputVisitorData *data,
+                                                       const void *unused)
+{
+    UserDefFlatUnion2 *tmp = NULL;
+    Error *err = NULL;
+    Visitor *v;
+
+    /* test situation where discriminator field ('enum1' here) is missing */
+    v = visitor_input_test_init(data, "{ 'integer': 42, 'string': 'c', 'string1': 'd', 'string2': 'e' }");
+
+    visit_type_UserDefFlatUnion2(v, NULL, &tmp, &err);
+    error_free_or_abort(&err);
+    g_assert(!tmp);
+}
+
+static void test_visitor_in_fail_alternate(TestInputVisitorData *data,
+                                           const void *unused)
+{
+    UserDefAlternate *tmp;
+    Visitor *v;
+    Error *err = NULL;
+
+    v = visitor_input_test_init(data, "3.14");
+
+    visit_type_UserDefAlternate(v, NULL, &tmp, &err);
+    error_free_or_abort(&err);
+    g_assert(!tmp);
+}
+
+static void do_test_visitor_in_qmp_introspect(TestInputVisitorData *data,
+                                              const char *schema_json)
+{
+    SchemaInfoList *schema = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init_raw(data, schema_json);
+
+    visit_type_SchemaInfoList(v, NULL, &schema, &error_abort);
+    g_assert(schema);
+
+    qapi_free_SchemaInfoList(schema);
+}
+
+static void test_visitor_in_qmp_introspect(TestInputVisitorData *data,
+                                           const void *unused)
+{
+    do_test_visitor_in_qmp_introspect(data, test_qmp_schema_json);
+    do_test_visitor_in_qmp_introspect(data, qmp_schema_json);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -893,6 +1062,24 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_native_list_string);
     input_visitor_test_add("/visitor/input/native_list/number",
                            NULL, test_visitor_in_native_list_number);
+    input_visitor_test_add("/visitor/input/fail/struct",
+                           NULL, test_visitor_in_fail_struct);
+    input_visitor_test_add("/visitor/input/fail/struct-nested",
+                           NULL, test_visitor_in_fail_struct_nested);
+    input_visitor_test_add("/visitor/input/fail/struct-in-list",
+                           NULL, test_visitor_in_fail_struct_in_list);
+    input_visitor_test_add("/visitor/input/fail/struct-missing",
+                           NULL, test_visitor_in_fail_struct_missing);
+    input_visitor_test_add("/visitor/input/fail/union-flat",
+                           NULL, test_visitor_in_fail_union_flat);
+    input_visitor_test_add("/visitor/input/fail/union-flat-no-discriminator",
+                           NULL, test_visitor_in_fail_union_flat_no_discrim);
+    input_visitor_test_add("/visitor/input/fail/alternate",
+                           NULL, test_visitor_in_fail_alternate);
+    input_visitor_test_add("/visitor/input/fail/union-native-list",
+                           NULL, test_visitor_in_fail_union_native_list);
+    input_visitor_test_add("/visitor/input/qmp-introspect",
+                           NULL, test_visitor_in_qmp_introspect);
 
     g_test_run();
 
-- 
2.7.4
