Received: from eggs.gnu.org ([2001:4830:134:3::10]:37530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ci6bi-0004UP-U9
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ci6bf-0004Oa-HM
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ci6bf-0004Nb-8Q
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:51 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D7E461BAA
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 21:43:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1QLhn2B001827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 16:43:50 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 26 Feb 2017 22:43:38 +0100
Message-Id: <1488145424-14974-21-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-1-git-send-email-armbru@redhat.com>
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 20/26] test-string-input-visitor: Improve
 list coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Lists with elements above INT64_MAX don't work (known bug).  Empty
lists don't work (weird).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-string-input-visitor.c | 85 +++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 13 deletions(-)

diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index a32828c..72f8732 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -65,31 +65,90 @@ static void test_visitor_in_int(TestInputVisitorData *data,
     error_free_or_abort(&err);
 }
 
+static void check_ilist(Visitor *v, int64_t *expected, size_t n)
+{
+    int64List *res = NULL;
+    int64List *tail;
+    int i;
+
+    visit_type_int64List(v, NULL, &res, &error_abort);
+    tail = res;
+    for (i = 0; i < n; i++) {
+        g_assert(tail);
+        g_assert_cmpint(tail->value, ==, expected[i]);
+        tail = tail->next;
+    }
+    g_assert(!tail);
+
+    qapi_free_int64List(res);
+}
+
+static void check_ulist(Visitor *v, uint64_t *expected, size_t n)
+{
+    uint64List *res = NULL;
+    uint64List *tail;
+    int i;
+
+    /* BUG: unsigned numbers above INT64_MAX don't work */
+    for (i = 0; i < n; i++) {
+        if (expected[i] > INT64_MAX) {
+            Error *err = NULL;
+            visit_type_uint64List(v, NULL, &res, &err);
+            error_free_or_abort(&err);
+            return;
+        }
+    }
+
+    visit_type_uint64List(v, NULL, &res, &error_abort);
+    tail = res;
+    for (i = 0; i < n; i++) {
+        g_assert(tail);
+        g_assert_cmpuint(tail->value, ==, expected[i]);
+        tail = tail->next;
+    }
+    g_assert(!tail);
+
+    qapi_free_uint64List(res);
+}
+
 static void test_visitor_in_intList(TestInputVisitorData *data,
                                     const void *unused)
 {
-    int64_t value[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20};
-    int16List *res = NULL, *tmp;
+    /* Note: the visitor *sorts* ranges *unsigned* */
+    int64_t expect1[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20 };
+    int64_t expect2[] = { 32767, -32768, -32767 };
+    int64_t expect3[] = { INT64_MAX, INT64_MIN };
+    uint64_t expect4[] = { UINT64_MAX };
     Error *err = NULL;
+    int64List *res = NULL;
     Visitor *v;
-    int i = 0;
+
+    /* Valid lists */
 
     v = visitor_input_test_init(data, "1,2,0,2-4,20,5-9,1-8");
+    check_ilist(v, expect1, ARRAY_SIZE(expect1));
 
-    visit_type_int16List(v, NULL, &res, &error_abort);
-    tmp = res;
-    while (i < sizeof(value) / sizeof(value[0])) {
-        g_assert(tmp);
-        g_assert_cmpint(tmp->value, ==, value[i++]);
-        tmp = tmp->next;
-    }
-    g_assert(!tmp);
+    v = visitor_input_test_init(data, "32767,-32768--32767");
+    check_ilist(v, expect2, ARRAY_SIZE(expect2));
 
-    qapi_free_int16List(res);
+    v = visitor_input_test_init(data,
+                                "-9223372036854775808,9223372036854775807");
+    check_ilist(v, expect3, ARRAY_SIZE(expect3));
+
+    v = visitor_input_test_init(data, "18446744073709551615");
+    check_ulist(v, expect4, ARRAY_SIZE(expect4));
+
+    /* Empty list is invalid (weird) */
+
+    v = visitor_input_test_init(data, "");
+    visit_type_int64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+
+    /* Not a list */
 
     v = visitor_input_test_init(data, "not an int list");
 
-    visit_type_int16List(v, NULL, &res, &err);
+    visit_type_int64List(v, NULL, &res, &err);
     error_free_or_abort(&err);
     g_assert(!res);
 }
-- 
2.7.4
