Received: from eggs.gnu.org ([2001:4830:134:3::10]:33838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXSku-0000B6-W2
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXSkt-0007Ss-4u
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Jul 2017 15:41:19 +0200
Message-Id: <1500385286-21142-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-1-git-send-email-armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first class
 'null' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

I expect the 'null' type to be useful mostly for members of alternate
types.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qobject.h              |  4 ++--
 include/qemu/typedefs.h                 |  1 +
 scripts/qapi.py                         |  5 ++++-
 tests/qapi-schema/qapi-schema-test.json |  3 ++-
 tests/qapi-schema/qapi-schema-test.out  |  1 +
 tests/test-qobject-input-visitor.c      |  5 +++++
 tests/test-qobject-output-visitor.c     | 10 ++++++++++
 7 files changed, 25 insertions(+), 4 deletions(-)

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
index 2706aab..ba69bd8 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -87,6 +87,7 @@ typedef struct QEMUSGList QEMUSGList;
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
