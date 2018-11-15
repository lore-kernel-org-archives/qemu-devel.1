Received: from eggs.gnu.org ([2001:4830:134:3::10]:52876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIHN-0005w1-BQ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIHM-0004er-9B
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNIHI-0004QP-7k
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:54 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 15 Nov 2018 15:05:00 +0100
Message-Id: <20181115140501.7872-9-david@redhat.com>
In-Reply-To: <20181115140501.7872-1-david@redhat.com>
References: <20181115140501.7872-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 8/9] test-string-input-visitor: split off
 uint64 list tests
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

Basically copy all int64 list tests but adapt them to work on uint64
instead. The values for very big/very small values have to be adapted.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/test-string-input-visitor.c | 94 +++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 4 deletions(-)

diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 4ad4cc0b56..d2ec453252 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -112,7 +112,6 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     int64_t expect2[] = { 32767, -32768, -32767 };
     int64_t expect3[] = { INT64_MIN, INT64_MAX };
     int64_t expect4[] = { 1 };
-    uint64_t expect5[] = { UINT64_MAX };
     Error *err = NULL;
     int64List *res = NULL;
     Visitor *v;
@@ -133,9 +132,6 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     v = visitor_input_test_init(data, "1-1");
     check_ilist(v, expect4, ARRAY_SIZE(expect4));
 
-    v = visitor_input_test_init(data, "18446744073709551615");
-    check_ulist(v, expect5, ARRAY_SIZE(expect5));
-
     /* Value too large */
 
     v = visitor_input_test_init(data, "9223372036854775808");
@@ -192,6 +188,94 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     visit_end_list(v, NULL);
 }
 
+static void test_visitor_in_uintList(TestInputVisitorData *data,
+                                     const void *unused)
+{
+    uint64_t expect1[] = { 1, 2, 0, 2, 3, 4, 20, 5, 6, 7,
+                           8, 9, 1, 2, 3, 4, 5, 6, 7, 8 };
+    uint64_t expect2[] = { 32767, -32768, -32767 };
+    uint64_t expect3[] = { INT64_MIN, INT64_MAX };
+    uint64_t expect4[] = { 1 };
+    uint64_t expect5[] = { UINT64_MAX };
+    Error *err = NULL;
+    uint64List *res = NULL;
+    Visitor *v;
+    uint64_t val;
+
+    /* Valid lists */
+
+    v = visitor_input_test_init(data, "1,2,0,2-4,20,5-9,1-8");
+    check_ulist(v, expect1, ARRAY_SIZE(expect1));
+
+    v = visitor_input_test_init(data, "32767,-32768--32767");
+    check_ulist(v, expect2, ARRAY_SIZE(expect2));
+
+    v = visitor_input_test_init(data,
+                                "-9223372036854775808,9223372036854775807");
+    check_ulist(v, expect3, ARRAY_SIZE(expect3));
+
+    v = visitor_input_test_init(data, "1-1");
+    check_ulist(v, expect4, ARRAY_SIZE(expect4));
+
+    v = visitor_input_test_init(data, "18446744073709551615");
+    check_ulist(v, expect5, ARRAY_SIZE(expect5));
+
+    /* Value too large */
+
+    v = visitor_input_test_init(data, "18446744073709551616");
+    visit_type_uint64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+    g_assert(!res);
+
+    /* Value too small */
+
+    v = visitor_input_test_init(data, "-18446744073709551616");
+    visit_type_uint64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+    g_assert(!res);
+
+    /* Empty list */
+
+    v = visitor_input_test_init(data, "");
+    visit_type_uint64List(v, NULL, &res, &error_abort);
+    g_assert(!res);
+
+    /* Not a list */
+
+    v = visitor_input_test_init(data, "not an uint list");
+
+    visit_type_uint64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+    g_assert(!res);
+
+    /* Unvisited list tail */
+
+    v = visitor_input_test_init(data, "0,2-3");
+
+    visit_start_list(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, NULL, &val, &error_abort);
+    g_assert_cmpuint(val, ==, 0);
+    visit_type_uint64(v, NULL, &val, &error_abort);
+    g_assert_cmpuint(val, ==, 2);
+
+    visit_check_list(v, &err);
+    error_free_or_abort(&err);
+    visit_end_list(v, NULL);
+
+    /* Visit beyond end of list */
+
+    v = visitor_input_test_init(data, "0");
+
+    visit_start_list(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, NULL, &val, &err);
+    g_assert_cmpuint(val, ==, 0);
+    visit_type_uint64(v, NULL, &val, &err);
+    error_free_or_abort(&err);
+
+    visit_check_list(v, &error_abort);
+    visit_end_list(v, NULL);
+}
+
 static void test_visitor_in_bool(TestInputVisitorData *data,
                                  const void *unused)
 {
@@ -352,6 +436,8 @@ int main(int argc, char **argv)
                            &in_visitor_data, test_visitor_in_int);
     input_visitor_test_add("/string-visitor/input/intList",
                            &in_visitor_data, test_visitor_in_intList);
+    input_visitor_test_add("/string-visitor/input/uintList",
+                           &in_visitor_data, test_visitor_in_uintList);
     input_visitor_test_add("/string-visitor/input/bool",
                            &in_visitor_data, test_visitor_in_bool);
     input_visitor_test_add("/string-visitor/input/number",
-- 
2.17.2
