Received: from eggs.gnu.org ([2001:4830:134:3::10]:49984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5eSC-0004iK-5u
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5eSA-000526-PP
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d5eSA-00051N-G3
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  2 May 2017 17:31:13 -0300
Message-Id: <20170502203115.22233-3-ehabkost@redhat.com>
In-Reply-To: <20170502203115.22233-1-ehabkost@redhat.com>
References: <20170502203115.22233-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] string-input-visitor: Support alternate
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
Cc: Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

When parsing alternates from a string, there are some limitations in
what we can do, but it is a valid use case in some situations. We can
support booleans, integer types, and enums.

This will be used to support 'feature=force' in -cpu options, while
keeping 'feature=on|off|true|false' represented as boolean values.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/string-input-visitor.c             | 71 ++++++++++++++++++++++----
 tests/test-string-input-visitor.c       | 89 +++++++++++++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.json |  8 +++
 3 files changed, 158 insertions(+), 10 deletions(-)

diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index c089491c24..bf8f58748b 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -19,6 +19,7 @@
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qemu/range.h"
+#include "qemu/bitops.h"
 
 
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
 
@@ -326,6 +340,42 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
     *obj = val;
 }
 
+/* Support for alternates on string-input-visitor is limited, because
+ * the input string doesn't have any type information.
+ *
+ * Supported alternate member types:
+ * 1) enums
+ * 2) integer types
+ * 3) booleans (but only if the there's no enum variant
+ *    containing "on", "off", "true", or "false" as members)
+ *
+ * UNSUPPORTED alternate member types:
+ * 1) strings
+ * 2) complex types
+ */
+static void start_alternate(Visitor *v, const char *name,
+                            GenericAlternate **obj, size_t size,
+                            unsigned long supported_qtypes, Error **errp)
+{
+    StringInputVisitor *siv = to_siv(v);
+    QType t = QTYPE_QSTRING;
+
+    if (supported_qtypes & BIT(QTYPE_QBOOL)) {
+        if (try_parse_bool(siv->string, NULL) == 0) {
+            t = QTYPE_QBOOL;
+        }
+    }
+
+    if (supported_qtypes & BIT(QTYPE_QINT)) {
+        if (parse_str(siv, name, NULL) == 0) {
+            t = QTYPE_QINT;
+        }
+    }
+
+    *obj = g_malloc0(size);
+    (*obj)->type = t;
+}
+
 static void string_input_free(Visitor *v)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -353,6 +403,7 @@ Visitor *string_input_visitor_new(const char *str)
     v->visitor.next_list = next_list;
     v->visitor.check_list = check_list;
     v->visitor.end_list = end_list;
+    v->visitor.start_alternate = start_alternate;
     v->visitor.free = string_input_free;
 
     v->string = str;
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 79313a7f7a..1e867d62c9 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -290,6 +290,91 @@ static void test_visitor_in_enum(TestInputVisitorData *data,
     }
 }
 
+static void test_visitor_in_alt_bool_enum(TestInputVisitorData *data,
+                                 const void *unused)
+{
+    Error *err = NULL;
+    Visitor *v;
+    AltBoolEnum *be = NULL;
+
+    v = visitor_input_test_init(data, "true");
+    visit_type_AltBoolEnum(v, NULL, &be, &err);
+    g_assert(!err);
+    g_assert_cmpint(be->type, ==, QTYPE_QBOOL);
+    g_assert(be->u.b);
+    qapi_free_AltBoolEnum(be);
+
+    v = visitor_input_test_init(data, "off");
+    visit_type_AltBoolEnum(v, NULL, &be, &err);
+    g_assert(!err);
+    g_assert_cmpint(be->type, ==, QTYPE_QBOOL);
+    g_assert(!be->u.b);
+    qapi_free_AltBoolEnum(be);
+
+    v = visitor_input_test_init(data, "value2");
+    visit_type_AltBoolEnum(v, NULL, &be, &err);
+    g_assert(!err);
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
+static void test_visitor_in_alt_enum_int(TestInputVisitorData *data,
+                                 const void *unused)
+{
+    Error *err = NULL;
+    Visitor *v;
+    AltOnOffInt *be = NULL;
+
+    v = visitor_input_test_init(data, "on");
+    visit_type_AltOnOffInt(v, NULL, &be, &err);
+    g_assert(!err);
+    g_assert_cmpint(be->type, ==, QTYPE_QSTRING);
+    g_assert_cmpint(be->u.o, ==, TEST_ON_OFF_AUTO_ON);
+    qapi_free_AltOnOffInt(be);
+
+    v = visitor_input_test_init(data, "off");
+    visit_type_AltOnOffInt(v, NULL, &be, &err);
+    g_assert(!err);
+    g_assert_cmpint(be->type, ==, QTYPE_QSTRING);
+    g_assert_cmpint(be->u.o, ==, TEST_ON_OFF_AUTO_OFF);
+    qapi_free_AltOnOffInt(be);
+
+    v = visitor_input_test_init(data, "auto");
+    visit_type_AltOnOffInt(v, NULL, &be, &err);
+    g_assert(!err);
+    g_assert_cmpint(be->type, ==, QTYPE_QSTRING);
+    g_assert_cmpint(be->u.o, ==, TEST_ON_OFF_AUTO_AUTO);
+    qapi_free_AltOnOffInt(be);
+
+    v = visitor_input_test_init(data, "-12345");
+    visit_type_AltOnOffInt(v, NULL, &be, &err);
+    g_assert(!err);
+    g_assert_cmpint(be->type, ==, QTYPE_QINT);
+    g_assert_cmpint(be->u.i, ==, -12345);
+    qapi_free_AltOnOffInt(be);
+
+    v = visitor_input_test_init(data, "true");
+    visit_type_AltOnOffInt(v, NULL, &be, &err);
+    error_free_or_abort(&err);
+    qapi_free_AltOnOffInt(be);
+
+    v = visitor_input_test_init(data, "value2");
+    visit_type_AltOnOffInt(v, NULL, &be, &err);
+    error_free_or_abort(&err);
+    qapi_free_AltOnOffInt(be);
+}
+
 /* Try to crash the visitors */
 static void test_visitor_in_fuzz(TestInputVisitorData *data,
                                  const void *unused)
@@ -366,6 +451,10 @@ int main(int argc, char **argv)
                             &in_visitor_data, test_visitor_in_string);
     input_visitor_test_add("/string-visitor/input/enum",
                             &in_visitor_data, test_visitor_in_enum);
+    input_visitor_test_add("/string-visitor/input/alternate/bool_enum",
+                            &in_visitor_data, test_visitor_in_alt_bool_enum);
+    input_visitor_test_add("/string-visitor/input/alternate/enum_int",
+                            &in_visitor_data, test_visitor_in_alt_enum_int);
     input_visitor_test_add("/string-visitor/input/fuzz",
                             &in_visitor_data, test_visitor_in_fuzz);
 
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 842ea3c5e3..231c8952e8 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -106,6 +106,14 @@
 { 'alternate': 'AltIntNum', 'data': { 'i': 'int', 'n': 'number' } }
 { 'alternate': 'AltNumInt', 'data': { 'n': 'number', 'i': 'int' } }
 
+
+# for testing string-input-visitor handling of alternates:
+{ 'enum': 'TestOnOffAuto',
+  'data': [ 'on', 'off', 'auto' ] }
+
+{ 'alternate': 'AltBoolEnum', 'data': { 'b': 'bool', 'e': 'EnumOne' } }
+{ 'alternate': 'AltOnOffInt', 'data': { 'o': 'TestOnOffAuto', 'i': 'int' } }
+
 # for testing native lists
 { 'union': 'UserDefNativeListUnion',
   'data': { 'integer': ['int'],
-- 
2.11.0.259.g40922b1
