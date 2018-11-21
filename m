Received: from eggs.gnu.org ([2001:4830:134:3::10]:51720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVcI-0007Ya-Ln
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVcH-0006of-VB
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gPVcH-0006na-Q4
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:41 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 21 Nov 2018 17:44:21 +0100
Message-Id: <20181121164421.20780-10-david@redhat.com>
In-Reply-To: <20181121164421.20780-1-david@redhat.com>
References: <20181121164421.20780-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-4.0 9/9] test-string-input-visitor: Add
 range overflow tests
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

Let's make sure that the range handling code can properly deal with
ranges that end at the biggest possible number.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/test-string-input-visitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 9b1dd44b2d..34b54dfc89 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -112,6 +112,7 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     int64_t expect2[] = { 32767, -32768, -32767 };
     int64_t expect3[] = { INT64_MIN, INT64_MAX };
     int64_t expect4[] = { 1 };
+    int64_t expect5[] = { INT64_MAX - 2,  INT64_MAX - 1, INT64_MAX };
     Error *err = NULL;
     int64List *res = NULL;
     Visitor *v;
@@ -132,6 +133,10 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     v = visitor_input_test_init(data, "1-1");
     check_ilist(v, expect4, ARRAY_SIZE(expect4));
 
+    v = visitor_input_test_init(data,
+                                "9223372036854775805-9223372036854775807");
+    check_ilist(v, expect5, ARRAY_SIZE(expect5));
+
     /* Value too large */
 
     v = visitor_input_test_init(data, "9223372036854775808");
@@ -216,6 +221,7 @@ static void test_visitor_in_uintList(TestInputVisitorData *data,
     uint64_t expect3[] = { INT64_MIN, INT64_MAX };
     uint64_t expect4[] = { 1 };
     uint64_t expect5[] = { UINT64_MAX };
+    uint64_t expect6[] = { UINT64_MAX - 2,  UINT64_MAX - 1, UINT64_MAX };
     Error *err = NULL;
     uint64List *res = NULL;
     Visitor *v;
@@ -239,6 +245,10 @@ static void test_visitor_in_uintList(TestInputVisitorData *data,
     v = visitor_input_test_init(data, "18446744073709551615");
     check_ulist(v, expect5, ARRAY_SIZE(expect5));
 
+    v = visitor_input_test_init(data,
+                                "18446744073709551613-18446744073709551615");
+    check_ulist(v, expect6, ARRAY_SIZE(expect6));
+
     /* Value too large */
 
     v = visitor_input_test_init(data, "18446744073709551616");
-- 
2.17.2
