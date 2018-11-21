Received: from eggs.gnu.org ([2001:4830:134:3::10]:51707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVcH-0007XC-C5
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVcG-0006mJ-Cq
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gPVcG-0006lU-5p
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:40 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 21 Nov 2018 17:44:20 +0100
Message-Id: <20181121164421.20780-9-david@redhat.com>
In-Reply-To: <20181121164421.20780-1-david@redhat.com>
References: <20181121164421.20780-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-4.0 8/9] test-string-input-visitor:
 Split off uint64 list tests
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/test-string-input-visitor.c | 113 ++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 4 deletions(-)

diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 718d9a03c3..9b1dd44b2d 100644
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
@@ -211,6 +207,113 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
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
+    /* Range not ascending */
+
+    v = visitor_input_test_init(data, "3-1");
+    visit_type_uint64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+    g_assert(!res);
+
+    v = visitor_input_test_init(data, "18446744073709551615-0");
+    visit_type_uint64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+    g_assert(!res);
+
+    /* Range too big (65536 is the limit against DOS attacks) */
+
+    v = visitor_input_test_init(data, "0-65536");
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
@@ -384,6 +487,8 @@ int main(int argc, char **argv)
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
