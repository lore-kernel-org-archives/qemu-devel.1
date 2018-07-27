Received: from eggs.gnu.org ([2001:4830:134:3::10]:42177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RW-00066f-BL
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RR-0000Ad-AL
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fj4RR-00009p-3m
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jul 2018 17:13:44 +0200
Message-Id: <20180727151359.29061-9-armbru@redhat.com>
In-Reply-To: <20180727151359.29061-1-armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/23] test-qobject-input-visitor: Avoid
 format string ambiguity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

When visitor_input_test_init_internal()'s argument @ap is null, then
@json_string is interpreted literally, else it's gets %-escapes
interpolated.  This is awkward.

One caller always passes null @ap, and the others never do.  Lift the
building of the QObject into the callers, where it can be done without
such ambiguity.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qobject-input-visitor.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 0f4d234c3f..caa90b3d7e 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -47,15 +47,13 @@ static void visitor_input_teardown(TestInputVisitorData *data,
 /* The various test_init functions are provided instead of a test setup
    function so that the JSON string used by the tests are kept in the test
    functions (and not in main()). */
-static Visitor *visitor_input_test_init_internal(TestInputVisitorData *data,
-                                                 bool keyval,
-                                                 const char *json_string,
-                                                 va_list *ap)
+
+static Visitor *test_init_internal(TestInputVisitorData *data, bool keyval,
+                                   QObject *obj)
 {
     visitor_input_teardown(data, NULL);
 
-    data->obj = qobject_from_jsonv(json_string, ap, &error_abort);
-    g_assert(data->obj);
+    data->obj = obj;
 
     if (keyval) {
         data->qiv = qobject_input_visitor_new_keyval(data->obj);
@@ -75,7 +73,8 @@ Visitor *visitor_input_test_init_full(TestInputVisitorData *data,
     va_list ap;
 
     va_start(ap, json_string);
-    v = visitor_input_test_init_internal(data, keyval, json_string, &ap);
+    v = test_init_internal(data, keyval,
+                           qobject_from_vjsonf_nofail(json_string, ap));
     va_end(ap);
     return v;
 }
@@ -88,7 +87,8 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
     va_list ap;
 
     va_start(ap, json_string);
-    v = visitor_input_test_init_internal(data, false, json_string, &ap);
+    v = test_init_internal(data, false,
+                           qobject_from_vjsonf_nofail(json_string, ap));
     va_end(ap);
     return v;
 }
@@ -103,7 +103,8 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
 static Visitor *visitor_input_test_init_raw(TestInputVisitorData *data,
                                             const char *json_string)
 {
-    return visitor_input_test_init_internal(data, false, json_string, NULL);
+    return test_init_internal(data, false,
+                              qobject_from_json(json_string, &error_abort));
 }
 
 static void test_visitor_in_int(TestInputVisitorData *data,
-- 
2.17.1
