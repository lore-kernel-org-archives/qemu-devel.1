Received: from eggs.gnu.org ([2001:4830:134:3::10]:50472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jZl-0003mm-9d
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jZj-0001m9-I7
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6jZj-0001lY-8N
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  5 May 2017 17:11:28 -0300
Message-Id: <20170505201128.12099-4-ehabkost@redhat.com>
In-Reply-To: <20170505201128.12099-1-ehabkost@redhat.com>
References: <20170505201128.12099-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] string-input-visitor: Support alternate
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

When parsing alternates from a string, there are some limitations in
what we can do, but it is a valid use case in some situations. We can
support booleans, integer types, and enums.

This will be used to support 'feature=force' in -cpu options, while
keeping 'feature=on|off|true|false' represented as boolean values.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Updated string_input_visitor_new() documentation
  to mention alternate support (Markus Armbruster)
* Detect ambiguous alternates at runtime. Test case included.
* Removed support for integers. We don't need it yet, and
  it would require sorting out the parse_str() mess.
* Change supported_qtypes to uint32_t (Eric Blake)
* Update tests/qapi-schema/qapi-schema-test.out to match
  qapi-schema-test.json updates
  (Eric Blake)
* Code indentation fix (Markus Armbruster)
* Use &error_abort on test cases instead of g_assert(!err)
  (Markus Armbruster)
---
 include/qapi/string-input-visitor.h     |  6 +-
 qapi/string-input-visitor.c             | 99 +++++++++++++++++++++++++++++----
 tests/test-string-input-visitor.c       | 76 +++++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.json |  8 +++
 tests/qapi-schema/qapi-schema-test.out  |  9 +++
 5 files changed, 187 insertions(+), 11 deletions(-)

diff --git a/include/qapi/string-input-visitor.h b/include/qapi/string-input-visitor.h
index 33551340e3..e7f359f225 100644
--- a/include/qapi/string-input-visitor.h
+++ b/include/qapi/string-input-visitor.h
@@ -19,8 +19,12 @@ typedef struct StringInputVisitor StringInputVisitor;
 
 /*
  * The string input visitor does not implement support for visiting
- * QAPI structs, alternates, null, or arbitrary QTypes.  It also
+ * QAPI structs, null, or arbitrary QTypes.  It also
  * requires a non-null list argument to visit_start_list().
+ *
+ * Support for alternates is very limited: only bool and enum
+ * members are supported, and only when the enum members'
+ * representations can't be confused with a bool value.
  */
 Visitor *string_input_visitor_new(const char *str);
 
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index c089491c24..e339b88192 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -19,6 +19,7 @@
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qemu/range.h"
+#include "qemu/host-utils.h"
 
 
 struct StringInputVisitor
@@ -278,21 +279,34 @@ static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
     *obj = val;
 }
 
+static int try_parse_bool(const char *s, bool *result)
+{
+    if (!strcasecmp(s, "on") ||
+        !strcasecmp(s, "yes") ||
+        !strcasecmp(s, "true")) {
+        if (result) {
+            *result = true;
+        }
+        return 0;
+    }
+    if (!strcasecmp(s, "off") ||
+        !strcasecmp(s, "no") ||
+        !strcasecmp(s, "false")) {
+        if (result) {
+            *result = false;
+        }
+        return 0;
+    }
+
+    return -1;
+}
+
 static void parse_type_bool(Visitor *v, const char *name, bool *obj,
                             Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
 
-    if (!strcasecmp(siv->string, "on") ||
-        !strcasecmp(siv->string, "yes") ||
-        !strcasecmp(siv->string, "true")) {
-        *obj = true;
-        return;
-    }
-    if (!strcasecmp(siv->string, "off") ||
-        !strcasecmp(siv->string, "no") ||
-        !strcasecmp(siv->string, "false")) {
-        *obj = false;
+    if (try_parse_bool(siv->string, obj) == 0) {
         return;
     }
 
@@ -326,6 +340,70 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
     *obj = val;
 }
 
+/*
+ * Check if alternate type string representation is ambiguous and
+ * can't be parsed by StringInputVisitor
+ */
+static bool ambiguous_alternate(uint32_t qtypes, const char *const enum_table[])
+{
+    uint32_t non_str_qtypes = qtypes & ~(1U << QTYPE_QSTRING);
+
+    if ((qtypes & (1U << QTYPE_QSTRING)) && !enum_table && non_str_qtypes) {
+        return true;
+    }
+
+    if (qtypes & (1U << QTYPE_QBOOL)) {
+        const char *const *e;
+        /*
+         * If the string representation of enum members can be parsed as
+         * booleans, the alternate string representation is ambiguous.
+         */
+        for (e = enum_table; e && *e; e++) {
+            if (try_parse_bool(*e, NULL) == 0) {
+                return true;
+            }
+        }
+    }
+
+    return false;
+}
+
+static void start_alternate(Visitor *v, const char *name,
+                            GenericAlternate **obj, size_t size,
+                            uint32_t qtypes, const char *const enum_table[],
+                            Error **errp)
+{
+    /*
+     * Enum types are represented as QTYPE_QSTRING, so this is
+     * the default. Actual parsing of the string as an enum is
+     * done by visit_type_<EnumType>(), which is called just
+     * after visit_start_alternate().
+     */
+    QType qtype = QTYPE_QSTRING;
+    uint32_t unsupported_qtypes = qtypes & ~((1U << QTYPE_QSTRING) |
+                                             (1U << QTYPE_QBOOL));
+    StringInputVisitor *siv = to_siv(v);
+
+    if (ambiguous_alternate(qtypes, enum_table)) {
+        error_setg(errp, "Can't parse ambiguous alternate type");
+        return;
+    }
+
+    if (unsupported_qtypes) {
+        error_setg(errp, "Can't parse %s' alternate member",
+                   QType_lookup[ctz32(unsupported_qtypes)]);
+        return;
+    }
+
+    if ((qtypes & (1U << QTYPE_QBOOL)) &&
+        try_parse_bool(siv->string, NULL) == 0) {
+        qtype = QTYPE_QBOOL;
+    }
+
+    *obj = g_malloc0(size);
+    (*obj)->type = qtype;
+}
+
 static void string_input_free(Visitor *v)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -353,6 +431,7 @@ Visitor *string_input_visitor_new(const char *str)
     v->visitor.next_list = next_list;
     v->visitor.check_list = check_list;
     v->visitor.end_list = end_list;
+    v->visitor.start_alternate = start_alternate;
     v->visitor.free = string_input_free;
 
     v->string = str;
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 79313a7f7a..263fcc2b8c 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -290,6 +290,76 @@ static void test_visitor_in_enum(TestInputVisitorData *data,
     }
 }
 
+static void test_visitor_in_alt_bool_enum(TestInputVisitorData *data,
+                                          const void *unused)
+{
+    Error *err = NULL;
+    Visitor *v;
+    AltBoolEnum *be = NULL;
+
+    v = visitor_input_test_init(data, "true");
+    visit_type_AltBoolEnum(v, NULL, &be, &error_abort);
+    g_assert_cmpint(be->type, ==, QTYPE_QBOOL);
+    g_assert(be->u.b);
+    qapi_free_AltBoolEnum(be);
+
+    v = visitor_input_test_init(data, "off");
+    visit_type_AltBoolEnum(v, NULL, &be, &error_abort);
+    g_assert_cmpint(be->type, ==, QTYPE_QBOOL);
+    g_assert(!be->u.b);
+    qapi_free_AltBoolEnum(be);
+
+    v = visitor_input_test_init(data, "value2");
+    visit_type_AltBoolEnum(v, NULL, &be, &error_abort);
+    g_assert_cmpint(be->type, ==, QTYPE_QSTRING);
+    g_assert_cmpint(be->u.e, ==, ENUM_ONE_VALUE2);
+    qapi_free_AltBoolEnum(be);
+
+    v = visitor_input_test_init(data, "value100");
+    visit_type_AltBoolEnum(v, NULL, &be, &err);
+    error_free_or_abort(&err);
+    qapi_free_AltBoolEnum(be);
+
+    v = visitor_input_test_init(data, "10");
+    visit_type_AltBoolEnum(v, NULL, &be, &err);
+    error_free_or_abort(&err);
+    qapi_free_AltBoolEnum(be);
+}
+
+static void test_visitor_in_alt_ambig_str(TestInputVisitorData *data,
+                                          const void *unused)
+{
+    Error *err = NULL;
+    Visitor *v;
+    AltStrBool *sb = NULL;
+
+    /*
+     * AltStrBool has an ambiguous string representation, and
+     * can't be handled by string-input-visitor:
+     */
+    v = visitor_input_test_init(data, "s");
+    visit_type_AltStrBool(v, NULL, &sb, &err);
+    error_free_or_abort(&err);
+    qapi_free_AltStrBool(sb);
+}
+
+static void test_visitor_in_alt_ambig_enum(TestInputVisitorData *data,
+                                          const void *unused)
+{
+    Error *err = NULL;
+    Visitor *v;
+    AltOnOffBool *ob = NULL;
+
+    /*
+     * AltOnOffBool has an ambiguous string representation, and
+     * can't be handled by string-input-visitor:
+     */
+    v = visitor_input_test_init(data, "on");
+    visit_type_AltOnOffBool(v, NULL, &ob, &err);
+    error_free_or_abort(&err);
+    qapi_free_AltOnOffBool(ob);
+}
+
 /* Try to crash the visitors */
 static void test_visitor_in_fuzz(TestInputVisitorData *data,
                                  const void *unused)
@@ -366,6 +436,12 @@ int main(int argc, char **argv)
                             &in_visitor_data, test_visitor_in_string);
     input_visitor_test_add("/string-visitor/input/enum",
                             &in_visitor_data, test_visitor_in_enum);
+    input_visitor_test_add("/string-visitor/input/alternate/bool_enum",
+                            &in_visitor_data, test_visitor_in_alt_bool_enum);
+    input_visitor_test_add("/string-visitor/input/alternate/ambig_enum",
+                            &in_visitor_data, test_visitor_in_alt_ambig_enum);
+    input_visitor_test_add("/string-visitor/input/alternate/ambig_str",
+                            &in_visitor_data, test_visitor_in_alt_ambig_str);
     input_visitor_test_add("/string-visitor/input/fuzz",
                             &in_visitor_data, test_visitor_in_fuzz);
 
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 842ea3c5e3..d602f3d40b 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -106,6 +106,14 @@
 { 'alternate': 'AltIntNum', 'data': { 'i': 'int', 'n': 'number' } }
 { 'alternate': 'AltNumInt', 'data': { 'n': 'number', 'i': 'int' } }
 
+# for testing string-input-visitor handling of alternates:
+{ 'alternate': 'AltBoolEnum', 'data': { 'b': 'bool', 'e': 'EnumOne' } }
+
+# this alternate type will be detected as ambiguous by string-input-visitor:
+{ 'enum': 'TestOnOffAuto',
+  'data': [ 'on', 'off', 'auto' ] }
+{ 'alternate': 'AltOnOffBool', 'data': { 'o': 'TestOnOffAuto', 'b': 'bool' } }
+
 # for testing native lists
 { 'union': 'UserDefNativeListUnion',
   'data': { 'integer': ['int'],
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 9d99c4eebb..17cd276295 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,3 +1,7 @@
+alternate AltBoolEnum
+    tag type
+    case b: bool
+    case e: EnumOne
 alternate AltIntNum
     tag type
     case i: int
@@ -10,6 +14,10 @@ alternate AltNumStr
     tag type
     case n: number
     case s: str
+alternate AltOnOffBool
+    tag type
+    case o: TestOnOffAuto
+    case b: bool
 alternate AltStrBool
     tag type
     case s: str
@@ -56,6 +64,7 @@ enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
 enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloat', 'qbool']
     prefix QTYPE
+enum TestOnOffAuto ['on', 'off', 'auto']
 object TestStruct
     member integer: int optional=False
     member boolean: bool optional=False
-- 
2.11.0.259.g40922b1
