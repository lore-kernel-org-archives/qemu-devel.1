Received: from eggs.gnu.org ([2001:4830:134:3::10]:53189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxo-0005hU-GY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxl-0002FX-4W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxj-0001P8-IR
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B54CA307CDE5
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:13 +0100
Message-Id: <20181213184340.24037-6-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 05/32] test-string-input-visitor: Add more tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Test that very big/small values are not accepted and that ranges with
only one element work. Also test that ranges are ascending and cannot
have more than 65536 elements.

Rename expect4 to expect5, as we will be moving that to a separate ulist
test after the rework.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181121164421.20780-6-david@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-string-input-visitor.c | 41 +++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 1efba06948..8ee0d1b284 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -121,7 +121,8 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     int64_t expect1[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20 };
     int64_t expect2[] = { 32767, -32768, -32767 };
     int64_t expect3[] = { INT64_MAX, INT64_MIN };
-    uint64_t expect4[] = { UINT64_MAX };
+    int64_t expect4[] = { 1 };
+    uint64_t expect5[] = { UINT64_MAX };
     Error *err = NULL;
     int64List *res = NULL;
     int64List *tail;
@@ -140,8 +141,44 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
                                 "-9223372036854775808,9223372036854775807");
     check_ilist(v, expect3, ARRAY_SIZE(expect3));
 
+    v = visitor_input_test_init(data, "1-1");
+    check_ilist(v, expect4, ARRAY_SIZE(expect4));
+
     v = visitor_input_test_init(data, "18446744073709551615");
-    check_ulist(v, expect4, ARRAY_SIZE(expect4));
+    check_ulist(v, expect5, ARRAY_SIZE(expect5));
+
+    /* Value too large */
+
+    v = visitor_input_test_init(data, "9223372036854775808");
+    visit_type_int64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+    g_assert(!res);
+
+    /* Value too small */
+
+    v = visitor_input_test_init(data, "-9223372036854775809");
+    visit_type_int64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+    g_assert(!res);
+
+    /* Range not ascending */
+
+    v = visitor_input_test_init(data, "3-1");
+    visit_type_int64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+    g_assert(!res);
+
+    v = visitor_input_test_init(data, "9223372036854775807-0");
+    visit_type_int64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+    g_assert(!res);
+
+    /* Range too big (65536 is the limit against DOS attacks) */
+
+    v = visitor_input_test_init(data, "0-65536");
+    visit_type_int64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+    g_assert(!res);
 
     /* Empty list */
 
-- 
2.17.2
