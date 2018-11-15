Received: from eggs.gnu.org ([2001:4830:134:3::10]:52821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIHH-0005r8-B0
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIH2-0004Tq-W8
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNIGx-0004Mc-3P
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:33 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 15 Nov 2018 15:04:57 +0100
Message-Id: <20181115140501.7872-6-david@redhat.com>
In-Reply-To: <20181115140501.7872-1-david@redhat.com>
References: <20181115140501.7872-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 5/9] test-string-input-visitor: add more
 tests
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

Test that very big/small values are not accepted and that ranges with
only one element work.

Rename expect4 to expect5, as we will be moving that to a separate ulist
test after the rework.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/test-string-input-visitor.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 88e0e1aa9a..f55e0696c0 100644
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
@@ -140,8 +141,25 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
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
 
     /* Empty list */
 
-- 
2.17.2
