Received: from eggs.gnu.org ([209.51.188.92]:50912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkNE-0004vr-Ai
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkHv-0006TZ-NA
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:41:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gzkHv-0006SF-B8
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:41:27 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Mar 2019 16:40:49 +0100
Message-Id: <20190301154051.23317-6-armbru@redhat.com>
In-Reply-To: <20190301154051.23317-1-armbru@redhat.com>
References: <20190301154051.23317-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] tests: Rename UserDefNativeListUnion to
 UserDefListUnion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com, quintela@redhat.com

The lists in UserDefNativeListUnion aren't "native", they're lists of
built-in types.  The next commit will add a list of a user-defined
type.  Drop "Native", and adjust the tests using the type.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json |   6 +-
 tests/qapi-schema/qapi-schema-test.out  |   8 +-
 tests/test-clone-visitor.c              |  16 +-
 tests/test-qmp-cmds.c                   |   2 +-
 tests/test-qobject-input-visitor.c      | 196 ++++++++++++------------
 tests/test-qobject-output-visitor.c     | 190 +++++++++++------------
 6 files changed, 209 insertions(+), 209 deletions(-)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 1f130a0491..908f718027 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -113,8 +113,8 @@
 # for testing use of 'str' within alternates
 { 'alternate': 'AltStrObj', 'data': { 's': 'str', 'o': 'TestStruct' } }
 
-# for testing native lists
-{ 'union': 'UserDefNativeListUnion',
+# for testing lists
+{ 'union': 'UserDefListUnion',
   'data': { 'integer': ['int'],
             's8': ['int8'],
             's16': ['int16'],
@@ -147,7 +147,7 @@
   'returns': 'int' }
 { 'command': 'guest-sync', 'data': { 'arg': 'any' }, 'returns': 'any' }
 { 'command': 'boxed-struct', 'boxed': true, 'data': 'UserDefZero' }
-{ 'command': 'boxed-union', 'data': 'UserDefNativeListUnion', 'boxed': true }
+{ 'command': 'boxed-union', 'data': 'UserDefListUnion', 'boxed': true }
 
 # Smoke test on out-of-band and allow-preconfig-test
 { 'command': 'test-flags-command', 'allow-oob': true, 'allow-preconfig': true }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index baba4c8384..cecf270ec3 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -144,7 +144,7 @@ object q_obj_sizeList-wrapper
     member data: sizeList optional=False
 object q_obj_anyList-wrapper
     member data: anyList optional=False
-enum UserDefNativeListUnionKind
+enum UserDefListUnionKind
     member integer
     member s8
     member s16
@@ -159,8 +159,8 @@ enum UserDefNativeListUnionKind
     member string
     member sizes
     member any
-object UserDefNativeListUnion
-    member type: UserDefNativeListUnionKind optional=False
+object UserDefListUnion
+    member type: UserDefListUnionKind optional=False
     tag type
     case integer: q_obj_intList-wrapper
     case s8: q_obj_int8List-wrapper
@@ -209,7 +209,7 @@ command guest-sync q_obj_guest-sync-arg -> any
    gen=True success_response=True boxed=False oob=False preconfig=False
 command boxed-struct UserDefZero -> None
    gen=True success_response=True boxed=True oob=False preconfig=False
-command boxed-union UserDefNativeListUnion -> None
+command boxed-union UserDefListUnion -> None
    gen=True success_response=True boxed=True oob=False preconfig=False
 command test-flags-command None -> None
    gen=True success_response=True boxed=False oob=True preconfig=True
diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c
index 9aeaf86a07..5e1e8b2f5e 100644
--- a/tests/test-clone-visitor.c
+++ b/tests/test-clone-visitor.c
@@ -63,7 +63,7 @@ static void test_clone_alternate(void)
     qapi_free_AltEnumBool(s_dst);
 }
 
-static void test_clone_native_list(void)
+static void test_clone_list_union(void)
 {
     uint8List *src, *dst;
     uint8List *tmp = NULL;
@@ -102,18 +102,18 @@ static void test_clone_empty(void)
 
 static void test_clone_complex1(void)
 {
-    UserDefNativeListUnion *src, *dst;
+    UserDefListUnion *src, *dst;
 
-    src = g_new0(UserDefNativeListUnion, 1);
-    src->type = USER_DEF_NATIVE_LIST_UNION_KIND_STRING;
+    src = g_new0(UserDefListUnion, 1);
+    src->type = USER_DEF_LIST_UNION_KIND_STRING;
 
-    dst = QAPI_CLONE(UserDefNativeListUnion, src);
+    dst = QAPI_CLONE(UserDefListUnion, src);
     g_assert(dst);
     g_assert_cmpint(dst->type, ==, src->type);
     g_assert(!dst->u.string.data);
 
-    qapi_free_UserDefNativeListUnion(src);
-    qapi_free_UserDefNativeListUnion(dst);
+    qapi_free_UserDefListUnion(src);
+    qapi_free_UserDefListUnion(dst);
 }
 
 static void test_clone_complex2(void)
@@ -192,7 +192,7 @@ int main(int argc, char **argv)
 
     g_test_add_func("/visitor/clone/struct", test_clone_struct);
     g_test_add_func("/visitor/clone/alternate", test_clone_alternate);
-    g_test_add_func("/visitor/clone/native_list", test_clone_native_list);
+    g_test_add_func("/visitor/clone/list_union", test_clone_list_union);
     g_test_add_func("/visitor/clone/empty", test_clone_empty);
     g_test_add_func("/visitor/clone/complex1", test_clone_complex1);
     g_test_add_func("/visitor/clone/complex2", test_clone_complex2);
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 481cb069ca..630b1b9bac 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -87,7 +87,7 @@ void qmp_boxed_struct(UserDefZero *arg, Error **errp)
 {
 }
 
-void qmp_boxed_union(UserDefNativeListUnion *arg, Error **errp)
+void qmp_boxed_union(UserDefListUnion *arg, Error **errp)
 {
 }
 
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 609334adf6..6bacabf063 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -686,11 +686,11 @@ static void test_visitor_in_alternate_number(TestInputVisitorData *data,
     qapi_free_AltEnumInt(asi);
 }
 
-static void test_native_list_integer_helper(TestInputVisitorData *data,
-                                            const void *unused,
-                                            UserDefNativeListUnionKind kind)
+static void test_list_union_integer_helper(TestInputVisitorData *data,
+                                           const void *unused,
+                                           UserDefListUnionKind kind)
 {
-    UserDefNativeListUnion *cvalue = NULL;
+    UserDefListUnion *cvalue = NULL;
     Visitor *v;
     GString *gstr_list = g_string_new("");
     GString *gstr_union = g_string_new("");
@@ -703,16 +703,16 @@ static void test_native_list_integer_helper(TestInputVisitorData *data,
         }
     }
     g_string_append_printf(gstr_union,  "{ 'type': '%s', 'data': [ %s ] }",
-                           UserDefNativeListUnionKind_str(kind),
+                           UserDefListUnionKind_str(kind),
                            gstr_list->str);
     v = visitor_input_test_init_raw(data,  gstr_union->str);
 
-    visit_type_UserDefNativeListUnion(v, NULL, &cvalue, &error_abort);
+    visit_type_UserDefListUnion(v, NULL, &cvalue, &error_abort);
     g_assert(cvalue != NULL);
     g_assert_cmpint(cvalue->type, ==, kind);
 
     switch (kind) {
-    case USER_DEF_NATIVE_LIST_UNION_KIND_INTEGER: {
+    case USER_DEF_LIST_UNION_KIND_INTEGER: {
         intList *elem = NULL;
         for (i = 0, elem = cvalue->u.integer.data;
              elem; elem = elem->next, i++) {
@@ -720,56 +720,56 @@ static void test_native_list_integer_helper(TestInputVisitorData *data,
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S8: {
+    case USER_DEF_LIST_UNION_KIND_S8: {
         int8List *elem = NULL;
         for (i = 0, elem = cvalue->u.s8.data; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S16: {
+    case USER_DEF_LIST_UNION_KIND_S16: {
         int16List *elem = NULL;
         for (i = 0, elem = cvalue->u.s16.data; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S32: {
+    case USER_DEF_LIST_UNION_KIND_S32: {
         int32List *elem = NULL;
         for (i = 0, elem = cvalue->u.s32.data; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S64: {
+    case USER_DEF_LIST_UNION_KIND_S64: {
         int64List *elem = NULL;
         for (i = 0, elem = cvalue->u.s64.data; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U8: {
+    case USER_DEF_LIST_UNION_KIND_U8: {
         uint8List *elem = NULL;
         for (i = 0, elem = cvalue->u.u8.data; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U16: {
+    case USER_DEF_LIST_UNION_KIND_U16: {
         uint16List *elem = NULL;
         for (i = 0, elem = cvalue->u.u16.data; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U32: {
+    case USER_DEF_LIST_UNION_KIND_U32: {
         uint32List *elem = NULL;
         for (i = 0, elem = cvalue->u.u32.data; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U64: {
+    case USER_DEF_LIST_UNION_KIND_U64: {
         uint64List *elem = NULL;
         for (i = 0, elem = cvalue->u.u64.data; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
@@ -782,76 +782,76 @@ static void test_native_list_integer_helper(TestInputVisitorData *data,
 
     g_string_free(gstr_union, true);
     g_string_free(gstr_list, true);
-    qapi_free_UserDefNativeListUnion(cvalue);
+    qapi_free_UserDefListUnion(cvalue);
 }
 
-static void test_visitor_in_native_list_int(TestInputVisitorData *data,
-                                            const void *unused)
+static void test_visitor_in_list_union_int(TestInputVisitorData *data,
+                                           const void *unused)
 {
-    test_native_list_integer_helper(data, unused,
-                                    USER_DEF_NATIVE_LIST_UNION_KIND_INTEGER);
+    test_list_union_integer_helper(data, unused,
+                                   USER_DEF_LIST_UNION_KIND_INTEGER);
 }
 
-static void test_visitor_in_native_list_int8(TestInputVisitorData *data,
-                                             const void *unused)
+static void test_visitor_in_list_union_int8(TestInputVisitorData *data,
+                                            const void *unused)
 {
-    test_native_list_integer_helper(data, unused,
-                                    USER_DEF_NATIVE_LIST_UNION_KIND_S8);
+    test_list_union_integer_helper(data, unused,
+                                   USER_DEF_LIST_UNION_KIND_S8);
 }
 
-static void test_visitor_in_native_list_int16(TestInputVisitorData *data,
-                                              const void *unused)
+static void test_visitor_in_list_union_int16(TestInputVisitorData *data,
+                                             const void *unused)
 {
-    test_native_list_integer_helper(data, unused,
-                                    USER_DEF_NATIVE_LIST_UNION_KIND_S16);
+    test_list_union_integer_helper(data, unused,
+                                   USER_DEF_LIST_UNION_KIND_S16);
 }
 
-static void test_visitor_in_native_list_int32(TestInputVisitorData *data,
-                                              const void *unused)
+static void test_visitor_in_list_union_int32(TestInputVisitorData *data,
+                                             const void *unused)
 {
-    test_native_list_integer_helper(data, unused,
-                                    USER_DEF_NATIVE_LIST_UNION_KIND_S32);
+    test_list_union_integer_helper(data, unused,
+                                   USER_DEF_LIST_UNION_KIND_S32);
 }
 
-static void test_visitor_in_native_list_int64(TestInputVisitorData *data,
-                                              const void *unused)
+static void test_visitor_in_list_union_int64(TestInputVisitorData *data,
+                                             const void *unused)
 {
-    test_native_list_integer_helper(data, unused,
-                                    USER_DEF_NATIVE_LIST_UNION_KIND_S64);
+    test_list_union_integer_helper(data, unused,
+                                   USER_DEF_LIST_UNION_KIND_S64);
 }
 
-static void test_visitor_in_native_list_uint8(TestInputVisitorData *data,
+static void test_visitor_in_list_union_uint8(TestInputVisitorData *data,
                                              const void *unused)
 {
-    test_native_list_integer_helper(data, unused,
-                                    USER_DEF_NATIVE_LIST_UNION_KIND_U8);
+    test_list_union_integer_helper(data, unused,
+                                   USER_DEF_LIST_UNION_KIND_U8);
 }
 
-static void test_visitor_in_native_list_uint16(TestInputVisitorData *data,
-                                               const void *unused)
+static void test_visitor_in_list_union_uint16(TestInputVisitorData *data,
+                                              const void *unused)
 {
-    test_native_list_integer_helper(data, unused,
-                                    USER_DEF_NATIVE_LIST_UNION_KIND_U16);
+    test_list_union_integer_helper(data, unused,
+                                   USER_DEF_LIST_UNION_KIND_U16);
 }
 
-static void test_visitor_in_native_list_uint32(TestInputVisitorData *data,
-                                               const void *unused)
+static void test_visitor_in_list_union_uint32(TestInputVisitorData *data,
+                                              const void *unused)
 {
-    test_native_list_integer_helper(data, unused,
-                                    USER_DEF_NATIVE_LIST_UNION_KIND_U32);
+    test_list_union_integer_helper(data, unused,
+                                   USER_DEF_LIST_UNION_KIND_U32);
 }
 
-static void test_visitor_in_native_list_uint64(TestInputVisitorData *data,
-                                               const void *unused)
+static void test_visitor_in_list_union_uint64(TestInputVisitorData *data,
+                                              const void *unused)
 {
-    test_native_list_integer_helper(data, unused,
-                                    USER_DEF_NATIVE_LIST_UNION_KIND_U64);
+    test_list_union_integer_helper(data, unused,
+                                   USER_DEF_LIST_UNION_KIND_U64);
 }
 
-static void test_visitor_in_native_list_bool(TestInputVisitorData *data,
+static void test_visitor_in_list_union_bool(TestInputVisitorData *data,
                                             const void *unused)
 {
-    UserDefNativeListUnion *cvalue = NULL;
+    UserDefListUnion *cvalue = NULL;
     boolList *elem = NULL;
     Visitor *v;
     GString *gstr_list = g_string_new("");
@@ -869,9 +869,9 @@ static void test_visitor_in_native_list_bool(TestInputVisitorData *data,
                            gstr_list->str);
     v = visitor_input_test_init_raw(data,  gstr_union->str);
 
-    visit_type_UserDefNativeListUnion(v, NULL, &cvalue, &error_abort);
+    visit_type_UserDefListUnion(v, NULL, &cvalue, &error_abort);
     g_assert(cvalue != NULL);
-    g_assert_cmpint(cvalue->type, ==, USER_DEF_NATIVE_LIST_UNION_KIND_BOOLEAN);
+    g_assert_cmpint(cvalue->type, ==, USER_DEF_LIST_UNION_KIND_BOOLEAN);
 
     for (i = 0, elem = cvalue->u.boolean.data; elem; elem = elem->next, i++) {
         g_assert_cmpint(elem->value, ==, (i % 3 == 0) ? 1 : 0);
@@ -879,13 +879,13 @@ static void test_visitor_in_native_list_bool(TestInputVisitorData *data,
 
     g_string_free(gstr_union, true);
     g_string_free(gstr_list, true);
-    qapi_free_UserDefNativeListUnion(cvalue);
+    qapi_free_UserDefListUnion(cvalue);
 }
 
-static void test_visitor_in_native_list_string(TestInputVisitorData *data,
-                                               const void *unused)
+static void test_visitor_in_list_union_string(TestInputVisitorData *data,
+                                              const void *unused)
 {
-    UserDefNativeListUnion *cvalue = NULL;
+    UserDefListUnion *cvalue = NULL;
     strList *elem = NULL;
     Visitor *v;
     GString *gstr_list = g_string_new("");
@@ -902,9 +902,9 @@ static void test_visitor_in_native_list_string(TestInputVisitorData *data,
                            gstr_list->str);
     v = visitor_input_test_init_raw(data,  gstr_union->str);
 
-    visit_type_UserDefNativeListUnion(v, NULL, &cvalue, &error_abort);
+    visit_type_UserDefListUnion(v, NULL, &cvalue, &error_abort);
     g_assert(cvalue != NULL);
-    g_assert_cmpint(cvalue->type, ==, USER_DEF_NATIVE_LIST_UNION_KIND_STRING);
+    g_assert_cmpint(cvalue->type, ==, USER_DEF_LIST_UNION_KIND_STRING);
 
     for (i = 0, elem = cvalue->u.string.data; elem; elem = elem->next, i++) {
         gchar str[8];
@@ -914,15 +914,15 @@ static void test_visitor_in_native_list_string(TestInputVisitorData *data,
 
     g_string_free(gstr_union, true);
     g_string_free(gstr_list, true);
-    qapi_free_UserDefNativeListUnion(cvalue);
+    qapi_free_UserDefListUnion(cvalue);
 }
 
 #define DOUBLE_STR_MAX 16
 
-static void test_visitor_in_native_list_number(TestInputVisitorData *data,
-                                               const void *unused)
+static void test_visitor_in_list_union_number(TestInputVisitorData *data,
+                                              const void *unused)
 {
-    UserDefNativeListUnion *cvalue = NULL;
+    UserDefListUnion *cvalue = NULL;
     numberList *elem = NULL;
     Visitor *v;
     GString *gstr_list = g_string_new("");
@@ -939,9 +939,9 @@ static void test_visitor_in_native_list_number(TestInputVisitorData *data,
                            gstr_list->str);
     v = visitor_input_test_init_raw(data,  gstr_union->str);
 
-    visit_type_UserDefNativeListUnion(v, NULL, &cvalue, &error_abort);
+    visit_type_UserDefListUnion(v, NULL, &cvalue, &error_abort);
     g_assert(cvalue != NULL);
-    g_assert_cmpint(cvalue->type, ==, USER_DEF_NATIVE_LIST_UNION_KIND_NUMBER);
+    g_assert_cmpint(cvalue->type, ==, USER_DEF_LIST_UNION_KIND_NUMBER);
 
     for (i = 0, elem = cvalue->u.number.data; elem; elem = elem->next, i++) {
         GString *double_expected = g_string_new("");
@@ -957,7 +957,7 @@ static void test_visitor_in_native_list_number(TestInputVisitorData *data,
 
     g_string_free(gstr_union, true);
     g_string_free(gstr_list, true);
-    qapi_free_UserDefNativeListUnion(cvalue);
+    qapi_free_UserDefListUnion(cvalue);
 }
 
 static void input_visitor_test_add(const char *testpath,
@@ -1192,17 +1192,17 @@ static void test_visitor_in_fail_list_nested(TestInputVisitorData *data,
     visit_end_list(v, NULL);
 }
 
-static void test_visitor_in_fail_union_native_list(TestInputVisitorData *data,
-                                                   const void *unused)
+static void test_visitor_in_fail_union_list(TestInputVisitorData *data,
+                                            const void *unused)
 {
-    UserDefNativeListUnion *tmp = NULL;
+    UserDefListUnion *tmp = NULL;
     Error *err = NULL;
     Visitor *v;
 
     v = visitor_input_test_init(data,
                                 "{ 'type': 'integer', 'data' : [ 'string' ] }");
 
-    visit_type_UserDefNativeListUnion(v, NULL, &tmp, &err);
+    visit_type_UserDefListUnion(v, NULL, &tmp, &err);
     error_free_or_abort(&err);
     g_assert(!tmp);
 }
@@ -1335,30 +1335,30 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_wrong_type);
     input_visitor_test_add("/visitor/input/alternate-number",
                            NULL, test_visitor_in_alternate_number);
-    input_visitor_test_add("/visitor/input/native_list/int",
-                           NULL, test_visitor_in_native_list_int);
-    input_visitor_test_add("/visitor/input/native_list/int8",
-                           NULL, test_visitor_in_native_list_int8);
-    input_visitor_test_add("/visitor/input/native_list/int16",
-                           NULL, test_visitor_in_native_list_int16);
-    input_visitor_test_add("/visitor/input/native_list/int32",
-                           NULL, test_visitor_in_native_list_int32);
-    input_visitor_test_add("/visitor/input/native_list/int64",
-                           NULL, test_visitor_in_native_list_int64);
-    input_visitor_test_add("/visitor/input/native_list/uint8",
-                           NULL, test_visitor_in_native_list_uint8);
-    input_visitor_test_add("/visitor/input/native_list/uint16",
-                           NULL, test_visitor_in_native_list_uint16);
-    input_visitor_test_add("/visitor/input/native_list/uint32",
-                           NULL, test_visitor_in_native_list_uint32);
-    input_visitor_test_add("/visitor/input/native_list/uint64",
-                           NULL, test_visitor_in_native_list_uint64);
-    input_visitor_test_add("/visitor/input/native_list/bool",
-                           NULL, test_visitor_in_native_list_bool);
-    input_visitor_test_add("/visitor/input/native_list/str",
-                           NULL, test_visitor_in_native_list_string);
-    input_visitor_test_add("/visitor/input/native_list/number",
-                           NULL, test_visitor_in_native_list_number);
+    input_visitor_test_add("/visitor/input/list_union/int",
+                           NULL, test_visitor_in_list_union_int);
+    input_visitor_test_add("/visitor/input/list_union/int8",
+                           NULL, test_visitor_in_list_union_int8);
+    input_visitor_test_add("/visitor/input/list_union/int16",
+                           NULL, test_visitor_in_list_union_int16);
+    input_visitor_test_add("/visitor/input/list_union/int32",
+                           NULL, test_visitor_in_list_union_int32);
+    input_visitor_test_add("/visitor/input/list_union/int64",
+                           NULL, test_visitor_in_list_union_int64);
+    input_visitor_test_add("/visitor/input/list_union/uint8",
+                           NULL, test_visitor_in_list_union_uint8);
+    input_visitor_test_add("/visitor/input/list_union/uint16",
+                           NULL, test_visitor_in_list_union_uint16);
+    input_visitor_test_add("/visitor/input/list_union/uint32",
+                           NULL, test_visitor_in_list_union_uint32);
+    input_visitor_test_add("/visitor/input/list_union/uint64",
+                           NULL, test_visitor_in_list_union_uint64);
+    input_visitor_test_add("/visitor/input/list_union/bool",
+                           NULL, test_visitor_in_list_union_bool);
+    input_visitor_test_add("/visitor/input/list_union/str",
+                           NULL, test_visitor_in_list_union_string);
+    input_visitor_test_add("/visitor/input/list_union/number",
+                           NULL, test_visitor_in_list_union_number);
     input_visitor_test_add("/visitor/input/fail/struct",
                            NULL, test_visitor_in_fail_struct);
     input_visitor_test_add("/visitor/input/fail/struct-nested",
@@ -1377,8 +1377,8 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_fail_union_flat_no_discrim);
     input_visitor_test_add("/visitor/input/fail/alternate",
                            NULL, test_visitor_in_fail_alternate);
-    input_visitor_test_add("/visitor/input/fail/union-native-list",
-                           NULL, test_visitor_in_fail_union_native_list);
+    input_visitor_test_add("/visitor/input/fail/union-list",
+                           NULL, test_visitor_in_fail_union_list);
     input_visitor_test_add("/visitor/input/qapi-introspect",
                            NULL, test_visitor_in_qmp_introspect);
 
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index be635854b4..3e993e5ba8 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -474,11 +474,11 @@ static void test_visitor_out_null(TestOutputVisitorData *data,
     g_assert(qobject_type(nil) == QTYPE_QNULL);
 }
 
-static void init_native_list(UserDefNativeListUnion *cvalue)
+static void init_list_union(UserDefListUnion *cvalue)
 {
     int i;
     switch (cvalue->type) {
-    case USER_DEF_NATIVE_LIST_UNION_KIND_INTEGER: {
+    case USER_DEF_LIST_UNION_KIND_INTEGER: {
         intList **list = &cvalue->u.integer.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(intList, 1);
@@ -488,7 +488,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S8: {
+    case USER_DEF_LIST_UNION_KIND_S8: {
         int8List **list = &cvalue->u.s8.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(int8List, 1);
@@ -498,7 +498,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S16: {
+    case USER_DEF_LIST_UNION_KIND_S16: {
         int16List **list = &cvalue->u.s16.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(int16List, 1);
@@ -508,7 +508,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S32: {
+    case USER_DEF_LIST_UNION_KIND_S32: {
         int32List **list = &cvalue->u.s32.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(int32List, 1);
@@ -518,7 +518,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S64: {
+    case USER_DEF_LIST_UNION_KIND_S64: {
         int64List **list = &cvalue->u.s64.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(int64List, 1);
@@ -528,7 +528,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U8: {
+    case USER_DEF_LIST_UNION_KIND_U8: {
         uint8List **list = &cvalue->u.u8.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(uint8List, 1);
@@ -538,7 +538,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U16: {
+    case USER_DEF_LIST_UNION_KIND_U16: {
         uint16List **list = &cvalue->u.u16.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(uint16List, 1);
@@ -548,7 +548,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U32: {
+    case USER_DEF_LIST_UNION_KIND_U32: {
         uint32List **list = &cvalue->u.u32.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(uint32List, 1);
@@ -558,7 +558,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U64: {
+    case USER_DEF_LIST_UNION_KIND_U64: {
         uint64List **list = &cvalue->u.u64.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(uint64List, 1);
@@ -568,7 +568,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_BOOLEAN: {
+    case USER_DEF_LIST_UNION_KIND_BOOLEAN: {
         boolList **list = &cvalue->u.boolean.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(boolList, 1);
@@ -578,7 +578,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_STRING: {
+    case USER_DEF_LIST_UNION_KIND_STRING: {
         strList **list = &cvalue->u.string.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(strList, 1);
@@ -588,7 +588,7 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
         }
         break;
     }
-    case USER_DEF_NATIVE_LIST_UNION_KIND_NUMBER: {
+    case USER_DEF_LIST_UNION_KIND_NUMBER: {
         numberList **list = &cvalue->u.number.data;
         for (i = 0; i < 32; i++) {
             *list = g_new0(numberList, 1);
@@ -603,8 +603,8 @@ static void init_native_list(UserDefNativeListUnion *cvalue)
     }
 }
 
-static void check_native_list(QObject *qobj,
-                              UserDefNativeListUnionKind kind)
+static void check_list_union(QObject *qobj,
+                             UserDefListUnionKind kind)
 {
     QDict *qdict;
     QList *qlist;
@@ -616,10 +616,10 @@ static void check_native_list(QObject *qobj,
     qlist = qlist_copy(qobject_to(QList, qdict_get(qdict, "data")));
 
     switch (kind) {
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U8:
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U16:
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U32:
-    case USER_DEF_NATIVE_LIST_UNION_KIND_U64:
+    case USER_DEF_LIST_UNION_KIND_U8:
+    case USER_DEF_LIST_UNION_KIND_U16:
+    case USER_DEF_LIST_UNION_KIND_U32:
+    case USER_DEF_LIST_UNION_KIND_U64:
         for (i = 0; i < 32; i++) {
             QObject *tmp;
             QNum *qvalue;
@@ -634,16 +634,16 @@ static void check_native_list(QObject *qobj,
         }
         break;
 
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S8:
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S16:
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S32:
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S64:
+    case USER_DEF_LIST_UNION_KIND_S8:
+    case USER_DEF_LIST_UNION_KIND_S16:
+    case USER_DEF_LIST_UNION_KIND_S32:
+    case USER_DEF_LIST_UNION_KIND_S64:
         /*
          * All integer elements in JSON arrays get stored into QNums
          * when we convert to QObjects, so we can check them all in
          * the same fashion, so simply fall through here.
          */
-    case USER_DEF_NATIVE_LIST_UNION_KIND_INTEGER:
+    case USER_DEF_LIST_UNION_KIND_INTEGER:
         for (i = 0; i < 32; i++) {
             QObject *tmp;
             QNum *qvalue;
@@ -657,7 +657,7 @@ static void check_native_list(QObject *qobj,
             qobject_unref(qlist_pop(qlist));
         }
         break;
-    case USER_DEF_NATIVE_LIST_UNION_KIND_BOOLEAN:
+    case USER_DEF_LIST_UNION_KIND_BOOLEAN:
         for (i = 0; i < 32; i++) {
             QObject *tmp;
             QBool *qvalue;
@@ -668,7 +668,7 @@ static void check_native_list(QObject *qobj,
             qobject_unref(qlist_pop(qlist));
         }
         break;
-    case USER_DEF_NATIVE_LIST_UNION_KIND_STRING:
+    case USER_DEF_LIST_UNION_KIND_STRING:
         for (i = 0; i < 32; i++) {
             QObject *tmp;
             QString *qvalue;
@@ -681,7 +681,7 @@ static void check_native_list(QObject *qobj,
             qobject_unref(qlist_pop(qlist));
         }
         break;
-    case USER_DEF_NATIVE_LIST_UNION_KIND_NUMBER:
+    case USER_DEF_LIST_UNION_KIND_NUMBER:
         for (i = 0; i < 32; i++) {
             QObject *tmp;
             QNum *qvalue;
@@ -706,93 +706,93 @@ static void check_native_list(QObject *qobj,
     qobject_unref(qlist);
 }
 
-static void test_native_list(TestOutputVisitorData *data,
-                             const void *unused,
-                             UserDefNativeListUnionKind kind)
+static void test_list_union(TestOutputVisitorData *data,
+                            const void *unused,
+                            UserDefListUnionKind kind)
 {
-    UserDefNativeListUnion *cvalue = g_new0(UserDefNativeListUnion, 1);
+    UserDefListUnion *cvalue = g_new0(UserDefListUnion, 1);
     QObject *obj;
 
     cvalue->type = kind;
-    init_native_list(cvalue);
+    init_list_union(cvalue);
 
-    visit_type_UserDefNativeListUnion(data->ov, NULL, &cvalue, &error_abort);
+    visit_type_UserDefListUnion(data->ov, NULL, &cvalue, &error_abort);
 
     obj = visitor_get(data);
-    check_native_list(obj, cvalue->type);
-    qapi_free_UserDefNativeListUnion(cvalue);
+    check_list_union(obj, cvalue->type);
+    qapi_free_UserDefListUnion(cvalue);
 }
 
-static void test_visitor_out_native_list_int(TestOutputVisitorData *data,
-                                             const void *unused)
+static void test_visitor_out_list_union_int(TestOutputVisitorData *data,
+                                            const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_INTEGER);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_INTEGER);
 }
 
-static void test_visitor_out_native_list_int8(TestOutputVisitorData *data,
-                                              const void *unused)
+static void test_visitor_out_list_union_int8(TestOutputVisitorData *data,
+                                             const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_S8);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_S8);
 }
 
-static void test_visitor_out_native_list_int16(TestOutputVisitorData *data,
-                                               const void *unused)
+static void test_visitor_out_list_union_int16(TestOutputVisitorData *data,
+                                              const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_S16);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_S16);
 }
 
-static void test_visitor_out_native_list_int32(TestOutputVisitorData *data,
-                                               const void *unused)
+static void test_visitor_out_list_union_int32(TestOutputVisitorData *data,
+                                              const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_S32);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_S32);
 }
 
-static void test_visitor_out_native_list_int64(TestOutputVisitorData *data,
-                                               const void *unused)
+static void test_visitor_out_list_union_int64(TestOutputVisitorData *data,
+                                              const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_S64);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_S64);
 }
 
-static void test_visitor_out_native_list_uint8(TestOutputVisitorData *data,
-                                               const void *unused)
+static void test_visitor_out_list_union_uint8(TestOutputVisitorData *data,
+                                              const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_U8);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_U8);
 }
 
-static void test_visitor_out_native_list_uint16(TestOutputVisitorData *data,
-                                                const void *unused)
+static void test_visitor_out_list_union_uint16(TestOutputVisitorData *data,
+                                               const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_U16);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_U16);
 }
 
-static void test_visitor_out_native_list_uint32(TestOutputVisitorData *data,
-                                                const void *unused)
+static void test_visitor_out_list_union_uint32(TestOutputVisitorData *data,
+                                               const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_U32);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_U32);
 }
 
-static void test_visitor_out_native_list_uint64(TestOutputVisitorData *data,
-                                                const void *unused)
+static void test_visitor_out_list_union_uint64(TestOutputVisitorData *data,
+                                               const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_U64);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_U64);
 }
 
-static void test_visitor_out_native_list_bool(TestOutputVisitorData *data,
-                                              const void *unused)
+static void test_visitor_out_list_union_bool(TestOutputVisitorData *data,
+                                             const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_BOOLEAN);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_BOOLEAN);
 }
 
-static void test_visitor_out_native_list_str(TestOutputVisitorData *data,
-                                              const void *unused)
+static void test_visitor_out_list_union_str(TestOutputVisitorData *data,
+                                            const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_STRING);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_STRING);
 }
 
-static void test_visitor_out_native_list_number(TestOutputVisitorData *data,
-                                                const void *unused)
+static void test_visitor_out_list_union_number(TestOutputVisitorData *data,
+                                               const void *unused)
 {
-    test_native_list(data, unused, USER_DEF_NATIVE_LIST_UNION_KIND_NUMBER);
+    test_list_union(data, unused, USER_DEF_LIST_UNION_KIND_NUMBER);
 }
 
 static void output_visitor_test_add(const char *testpath,
@@ -841,42 +841,42 @@ int main(int argc, char **argv)
                             &out_visitor_data, test_visitor_out_alternate);
     output_visitor_test_add("/visitor/output/null",
                             &out_visitor_data, test_visitor_out_null);
-    output_visitor_test_add("/visitor/output/native_list/int",
+    output_visitor_test_add("/visitor/output/list_union/int",
                             &out_visitor_data,
-                            test_visitor_out_native_list_int);
-    output_visitor_test_add("/visitor/output/native_list/int8",
+                            test_visitor_out_list_union_int);
+    output_visitor_test_add("/visitor/output/list_union/int8",
                             &out_visitor_data,
-                            test_visitor_out_native_list_int8);
-    output_visitor_test_add("/visitor/output/native_list/int16",
+                            test_visitor_out_list_union_int8);
+    output_visitor_test_add("/visitor/output/list_union/int16",
                             &out_visitor_data,
-                            test_visitor_out_native_list_int16);
-    output_visitor_test_add("/visitor/output/native_list/int32",
+                            test_visitor_out_list_union_int16);
+    output_visitor_test_add("/visitor/output/list_union/int32",
                             &out_visitor_data,
-                            test_visitor_out_native_list_int32);
-    output_visitor_test_add("/visitor/output/native_list/int64",
+                            test_visitor_out_list_union_int32);
+    output_visitor_test_add("/visitor/output/list_union/int64",
                             &out_visitor_data,
-                            test_visitor_out_native_list_int64);
-    output_visitor_test_add("/visitor/output/native_list/uint8",
+                            test_visitor_out_list_union_int64);
+    output_visitor_test_add("/visitor/output/list_union/uint8",
                             &out_visitor_data,
-                            test_visitor_out_native_list_uint8);
-    output_visitor_test_add("/visitor/output/native_list/uint16",
+                            test_visitor_out_list_union_uint8);
+    output_visitor_test_add("/visitor/output/list_union/uint16",
                             &out_visitor_data,
-                            test_visitor_out_native_list_uint16);
-    output_visitor_test_add("/visitor/output/native_list/uint32",
+                            test_visitor_out_list_union_uint16);
+    output_visitor_test_add("/visitor/output/list_union/uint32",
                             &out_visitor_data,
-                            test_visitor_out_native_list_uint32);
-    output_visitor_test_add("/visitor/output/native_list/uint64",
+                            test_visitor_out_list_union_uint32);
+    output_visitor_test_add("/visitor/output/list_union/uint64",
                             &out_visitor_data,
-                            test_visitor_out_native_list_uint64);
-    output_visitor_test_add("/visitor/output/native_list/bool",
+                            test_visitor_out_list_union_uint64);
+    output_visitor_test_add("/visitor/output/list_union/bool",
                             &out_visitor_data,
-                            test_visitor_out_native_list_bool);
-    output_visitor_test_add("/visitor/output/native_list/string",
+                            test_visitor_out_list_union_bool);
+    output_visitor_test_add("/visitor/output/list_union/string",
                             &out_visitor_data,
-                            test_visitor_out_native_list_str);
-    output_visitor_test_add("/visitor/output/native_list/number",
+                            test_visitor_out_list_union_str);
+    output_visitor_test_add("/visitor/output/list_union/number",
                             &out_visitor_data,
-                            test_visitor_out_native_list_number);
+                            test_visitor_out_list_union_number);
 
     g_test_run();
 
-- 
2.17.2
