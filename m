Received: from eggs.gnu.org ([2001:4830:134:3::10]:53320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxv-0005pl-I9
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxr-0002i5-Kt
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxo-0001OY-H2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A40B881129
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:17 +0100
Message-Id: <20181213184340.24037-10-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 09/32] test-string-input-visitor: Add range
 overflow tests
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

Let's make sure that the range handling code can properly deal with
ranges that end at the biggest possible number.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181121164421.20780-10-david@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
