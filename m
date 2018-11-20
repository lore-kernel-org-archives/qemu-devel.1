Received: from eggs.gnu.org ([2001:4830:134:3::10]:46613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gP2IF-0004uK-T0
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gP2IF-0002V8-5h
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:26:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gP2IF-0002Ud-10
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:26:03 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 20 Nov 2018 10:25:40 +0100
Message-Id: <20181120092542.13102-8-david@redhat.com>
In-Reply-To: <20181120092542.13102-1-david@redhat.com>
References: <20181120092542.13102-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/9] test-string-input-visitor: Use virtual
 walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>

We now support virtual walks, so use that instead.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/test-string-input-visitor.c | 36 +++++++++++--------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index c5379365a6..718d9a03c3 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -115,7 +115,6 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     uint64_t expect5[] = { UINT64_MAX };
     Error *err = NULL;
     int64List *res = NULL;
-    int64List *tail;
     Visitor *v;
     int64_t val;
 
@@ -188,39 +187,28 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
 
     v = visitor_input_test_init(data, "0,2-3");
 
-    /* Would be simpler if the visitor genuinely supported virtual walks */
-    visit_start_list(v, NULL, (GenericList **)&res, sizeof(*res),
-                     &error_abort);
-    tail = res;
-    visit_type_int64(v, NULL, &tail->value, &error_abort);
-    g_assert_cmpint(tail->value, ==, 0);
-    tail = (int64List *)visit_next_list(v, (GenericList *)tail, sizeof(*res));
-    g_assert(tail);
-    visit_type_int64(v, NULL, &tail->value, &error_abort);
-    g_assert_cmpint(tail->value, ==, 2);
-    tail = (int64List *)visit_next_list(v, (GenericList *)tail, sizeof(*res));
-    g_assert(tail);
+    visit_start_list(v, NULL, NULL, 0, &error_abort);
+    visit_type_int64(v, NULL, &val, &error_abort);
+    g_assert_cmpint(val, ==, 0);
+    visit_type_int64(v, NULL, &val, &error_abort);
+    g_assert_cmpint(val, ==, 2);
 
     visit_check_list(v, &err);
     error_free_or_abort(&err);
-    visit_end_list(v, (void **)&res);
-
-    qapi_free_int64List(res);
+    visit_end_list(v, NULL);
 
     /* Visit beyond end of list */
+
     v = visitor_input_test_init(data, "0");
 
-    visit_start_list(v, NULL, (GenericList **)&res, sizeof(*res),
-                     &error_abort);
-    tail = res;
-    visit_type_int64(v, NULL, &tail->value, &err);
-    g_assert_cmpint(tail->value, ==, 0);
+    visit_start_list(v, NULL, NULL, 0, &error_abort);
+    visit_type_int64(v, NULL, &val, &err);
+    g_assert_cmpint(val, ==, 0);
     visit_type_int64(v, NULL, &val, &err);
     error_free_or_abort(&err);
-    visit_check_list(v, &error_abort);
-    visit_end_list(v, (void **)&res);
 
-    qapi_free_int64List(res);
+    visit_check_list(v, &error_abort);
+    visit_end_list(v, NULL);
 }
 
 static void test_visitor_in_bool(TestInputVisitorData *data,
-- 
2.17.2
