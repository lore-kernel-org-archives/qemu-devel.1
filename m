Received: from eggs.gnu.org ([2001:4830:134:3::10]:33084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZbyy-00014u-5r
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZbyw-0006rr-MC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZbyw-0006rE-D6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41DB27DCF0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:57:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-94.ams2.redhat.com
	[10.36.116.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D70BB67CF4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:57:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Jul 2017 13:56:52 +0200
Message-Id: <1500897419-15539-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1500897419-15539-1-git-send-email-armbru@redhat.com>
References: <1500897419-15539-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 03/10] qapi: Introduce a first class 'null'
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I expect the 'null' type to be useful mostly for members of alternate
types.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt            | 10 ++++++----
 include/qapi/qmp/qobject.h              |  4 ++--
 include/qemu/typedefs.h                 |  1 +
 scripts/qapi.py                         |  5 ++++-
 tests/qapi-schema/qapi-schema-test.json |  3 ++-
 tests/qapi-schema/qapi-schema-test.out  |  1 +
 tests/test-qobject-input-visitor.c      |  5 +++++
 tests/test-qobject-output-visitor.c     | 10 ++++++++++
 8 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 52e3874..9903ac4 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -282,6 +282,7 @@ The following types are predefined, and map to C as follows:
   size      uint64_t   like uint64_t, except StringInputVisitor
                        accepts size suffixes
   bool      bool       JSON true or false
+  null      QNull *    JSON null
   any       QObject *  any JSON value
   QType     QType      JSON string matching enum QType values
 
@@ -536,10 +537,11 @@ can only express a choice between types represented differently in
 JSON.  If a branch is typed as the 'bool' built-in, the alternate
 accepts true and false; if it is typed as any of the various numeric
 built-ins, it accepts a JSON number; if it is typed as a 'str'
-built-in or named enum type, it accepts a JSON string; and if it is
-typed as a complex type (struct or union), it accepts a JSON object.
-Two different complex types, for instance, aren't permitted, because
-both are represented as a JSON object.
+built-in or named enum type, it accepts a JSON string; if it is typed
+as the 'null' built-in, it accepts JSON null; and if it is typed as a
+complex type (struct or union), it accepts a JSON object.  Two
+different complex types, for instance, aren't permitted, because both
+are represented as a JSON object.
 
 The example alternate declaration above allows using both of the
 following example objects:
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 3543b55..eab29ed 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -93,9 +93,9 @@ static inline QType qobject_type(const QObject *obj)
     return obj->type;
 }
 
-typedef struct QNull {
+struct QNull {
     QObject base;
-} QNull;
+};
 
 extern QNull qnull_;
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 7b0d4e7..39bc835 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -89,6 +89,7 @@ typedef struct QEMUSGList QEMUSGList;
 typedef struct QEMUTimer QEMUTimer;
 typedef struct QEMUTimerListGroup QEMUTimerListGroup;
 typedef struct QObject QObject;
+typedef struct QNull QNull;
 typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
 typedef struct SerialState SerialState;
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 84e2eb4..8aa2775 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -20,6 +20,7 @@ import sys
 from ordereddict import OrderedDict
 
 builtin_types = {
+    'null':     'QTYPE_QNULL',
     'str':      'QTYPE_QSTRING',
     'int':      'QTYPE_QNUM',
     'number':   'QTYPE_QNUM',
@@ -1056,6 +1057,7 @@ class QAPISchemaType(QAPISchemaEntity):
 
     def alternate_qtype(self):
         json2qtype = {
+            'null':    'QTYPE_QNULL',
             'string':  'QTYPE_QSTRING',
             'number':  'QTYPE_QNUM',
             'int':     'QTYPE_QNUM',
@@ -1515,7 +1517,8 @@ class QAPISchema(object):
                   ('uint64', 'int',     'uint64_t'),
                   ('size',   'int',     'uint64_t'),
                   ('bool',   'boolean', 'bool'),
-                  ('any',    'value',   'QObject' + pointer_suffix)]:
+                  ('any',    'value',   'QObject' + pointer_suffix),
+                  ('null',   'null',    'QNull' + pointer_suffix)]:
             self._def_builtin_type(*t)
         self.the_empty_object_type = QAPISchemaObjectType(
             'q_empty', None, None, None, [], None)
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 91ffb26..c72dbd8 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -93,7 +93,8 @@
 { 'struct': 'WrapAlternate',
   'data': { 'alt': 'UserDefAlternate' } }
 { 'alternate': 'UserDefAlternate',
-  'data': { 'udfu': 'UserDefFlatUnion', 'e': 'EnumOne', 'i': 'int' } }
+  'data': { 'udfu': 'UserDefFlatUnion', 'e': 'EnumOne', 'i': 'int',
+            'n': 'null' } }
 
 { 'struct': 'UserDefC',
   'data': { 'string1': 'str', 'string2': 'str' } }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index b88b8aa..3b1e908 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -64,6 +64,7 @@ alternate UserDefAlternate
     case udfu: UserDefFlatUnion
     case e: EnumOne
     case i: int
+    case n: null
 object UserDefB
     member intb: int optional=False
     member a-b: bool optional=True
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index f98caf9..f451844 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -583,6 +583,11 @@ static void test_visitor_in_alternate(TestInputVisitorData *data,
     g_assert_cmpint(tmp->u.e, ==, ENUM_ONE_VALUE1);
     qapi_free_UserDefAlternate(tmp);
 
+    v = visitor_input_test_init(data, "null");
+    visit_type_UserDefAlternate(v, NULL, &tmp, &error_abort);
+    g_assert_cmpint(tmp->type, ==, QTYPE_QNULL);
+    qapi_free_UserDefAlternate(tmp);
+
     v = visitor_input_test_init(data, "{'integer':1, 'string':'str', "
                                 "'enum1':'value1', 'boolean':true}");
     visit_type_UserDefAlternate(v, NULL, &tmp, &error_abort);
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 8f1fcd4..7eb1620 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -424,6 +424,16 @@ static void test_visitor_out_alternate(TestOutputVisitorData *data,
 
     visitor_reset(data);
     tmp = g_new0(UserDefAlternate, 1);
+    tmp->type = QTYPE_QNULL;
+    tmp->u.n = qnull();
+
+    visit_type_UserDefAlternate(data->ov, NULL, &tmp, &error_abort);
+    g_assert_cmpint(qobject_type(visitor_get(data)), ==, QTYPE_QNULL);
+
+    qapi_free_UserDefAlternate(tmp);
+
+    visitor_reset(data);
+    tmp = g_new0(UserDefAlternate, 1);
     tmp->type = QTYPE_QDICT;
     tmp->u.udfu.integer = 1;
     tmp->u.udfu.string = g_strdup("str");
-- 
2.7.5
