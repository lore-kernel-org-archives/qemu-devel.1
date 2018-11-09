Received: from eggs.gnu.org ([2001:4830:134:3::10]:34226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gL4Yn-0003ws-IO
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gL4Yl-0004PD-Ct
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:02:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gL4Yk-0004KY-W3
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:02:43 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Nov 2018 12:02:21 +0100
Message-Id: <20181109110221.10553-7-david@redhat.com>
In-Reply-To: <20181109110221.10553-1-david@redhat.com>
References: <20181109110221.10553-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 6/6] test-string-input-visitor: add range
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>

Let's make sure that the range handling code can properly deal with
ranges that end at the biggest possible number.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/test-string-input-visitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 731094f789..809bd59fca 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -111,6 +111,7 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
                           6, 7, 8 };
     int64_t expect2[] = { 32767, -32768, -32767 };
     int64_t expect3[] = { INT64_MIN, INT64_MAX };
+    int64_t expect4[] = { INT64_MAX - 2,  INT64_MAX - 1, INT64_MAX };
     Error *err = NULL;
     int64List *res = NULL;
     Visitor *v;
@@ -128,6 +129,10 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
                                 "-9223372036854775808,9223372036854775807");
     check_ilist(v, expect3, ARRAY_SIZE(expect3));
 
+    v = visitor_input_test_init(data,
+                                "9223372036854775805-9223372036854775807");
+    check_ilist(v, expect4, ARRAY_SIZE(expect4));
+
     /* Empty list */
 
     v = visitor_input_test_init(data, "");
@@ -177,6 +182,7 @@ static void test_visitor_in_uintList(TestInputVisitorData *data,
                            6, 7, 8 };
     uint64_t expect2[] = { 32767, -32768, -32767 };
     uint64_t expect3[] = { UINT64_MAX };
+    uint64_t expect4[] = { UINT64_MAX - 2,  UINT64_MAX - 1, UINT64_MAX };
     Error *err = NULL;
     uint64List *res = NULL;
     Visitor *v;
@@ -193,6 +199,10 @@ static void test_visitor_in_uintList(TestInputVisitorData *data,
     v = visitor_input_test_init(data, "18446744073709551615");
     check_ulist(v, expect3, ARRAY_SIZE(expect3));
 
+    v = visitor_input_test_init(data,
+                                "18446744073709551613-18446744073709551615");
+    check_ulist(v, expect4, ARRAY_SIZE(expect4));
+
     /* Empty list */
 
     v = visitor_input_test_init(data, "");
-- 
2.17.2
