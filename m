Received: from eggs.gnu.org ([2001:4830:134:3::10]:37099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqilo-0006Wn-7K
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqill-0001ju-2Z
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqilk-0001iX-Mf
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B372367ECF
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 817CD60BF1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 17:05:45 +0100
Message-Id: <1490198748-4753-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1490198748-4753-1-git-send-email-armbru@redhat.com>
References: <1490198748-4753-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 14/17] test-qobject-input-visitor: Cover
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

The new test demonstrates known bugs: integers between INT64_MAX+1 and
UINT64_MAX rejected, and integers between INT64_MIN and -1 are
accepted modulo 2^64.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490118290-6133-1-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
