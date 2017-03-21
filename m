Received: from eggs.gnu.org ([2001:4830:134:3::10]:54075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqNq8-0004BC-01
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqNq4-0000j0-Pj
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:45:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqNq4-0000ib-Jn
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:44:56 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Mar 2017 18:44:50 +0100
Message-Id: <1490118290-6133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] test-qobject-input-visitor: Cover
 visit_type_uint64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

The new test demonstrates known bugs: integers between INT64_MAX+1 and
UINT64_MAX rejected, and integers between INT64_MIN and -1 are
accepted modulo 2^64.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qobject-input-visitor.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 6eb48fe..f965743 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -116,6 +116,34 @@ static void test_visitor_in_int(TestInputVisitorData *data,
     g_assert_cmpint(res, ==, value);
 }
 
+static void test_visitor_in_uint(TestInputVisitorData *data,
+                                const void *unused)
+{
+    Error *err = NULL;
+    uint64_t res = 0;
+    int value = 42;
+    Visitor *v;
+
+    v = visitor_input_test_init(data, "%d", value);
+
+    visit_type_uint64(v, NULL, &res, &error_abort);
+    g_assert_cmpuint(res, ==, (uint64_t)value);
+
+    /* BUG: value between INT64_MIN and -1 accepted modulo 2^64 */
+
+    v = visitor_input_test_init(data, "%d", -value);
+
+    visit_type_uint64(v, NULL, &res, &error_abort);
+    g_assert_cmpuint(res, ==, (uint64_t)-value);
+
+    /* BUG: value between INT64_MAX+1 and UINT64_MAX rejected */
+
+    v = visitor_input_test_init(data, "18446744073709551574");
+
+    visit_type_uint64(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
 static void test_visitor_in_int_overflow(TestInputVisitorData *data,
                                          const void *unused)
 {
@@ -1225,6 +1253,8 @@ int main(int argc, char **argv)
 
     input_visitor_test_add("/visitor/input/int",
                            NULL, test_visitor_in_int);
+    input_visitor_test_add("/visitor/input/uint",
+                           NULL, test_visitor_in_uint);
     input_visitor_test_add("/visitor/input/int_overflow",
                            NULL, test_visitor_in_int_overflow);
     input_visitor_test_add("/visitor/input/int_keyval",
-- 
2.7.4
