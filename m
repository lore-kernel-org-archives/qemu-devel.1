Received: from eggs.gnu.org ([2001:4830:134:3::10]:45698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckReC-0000Ov-3t
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe9-00030A-Gf
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe8-0002yc-TN
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:05 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D548C04B920
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v258a3Gc024266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 5 Mar 2017 03:36:04 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:51 +0100
Message-Id: <1488702958-24336-21-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-1-git-send-email-armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 20/27] test-string-input-visitor: Tear down
 existing test automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Call visitor_input_teardown() from visitor_input_test_init(), so you
don't have to call it from the actual tests.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488544368-30622-22-git-send-email-armbru@redhat.com>
---
 tests/test-string-input-visitor.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 7f10e25..a32828c 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -39,6 +39,8 @@ static
 Visitor *visitor_input_test_init(TestInputVisitorData *data,
                                  const char *string)
 {
+    visitor_input_teardown(data, NULL);
+
     data->v = string_input_visitor_new(string);
     g_assert(data->v);
     return data->v;
@@ -57,8 +59,6 @@ static void test_visitor_in_int(TestInputVisitorData *data,
     g_assert(!err);
     g_assert_cmpint(res, ==, value);
 
-    visitor_input_teardown(data, unused);
-
     v = visitor_input_test_init(data, "not an int");
 
     visit_type_int(v, NULL, &res, &err);
@@ -87,8 +87,6 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
 
     qapi_free_int16List(res);
 
-    visitor_input_teardown(data, unused);
-
     v = visitor_input_test_init(data, "not an int list");
 
     visit_type_int16List(v, NULL, &res, &err);
@@ -108,35 +106,30 @@ static void test_visitor_in_bool(TestInputVisitorData *data,
     visit_type_bool(v, NULL, &res, &err);
     g_assert(!err);
     g_assert_cmpint(res, ==, true);
-    visitor_input_teardown(data, unused);
 
     v = visitor_input_test_init(data, "yes");
 
     visit_type_bool(v, NULL, &res, &err);
     g_assert(!err);
     g_assert_cmpint(res, ==, true);
-    visitor_input_teardown(data, unused);
 
     v = visitor_input_test_init(data, "on");
 
     visit_type_bool(v, NULL, &res, &err);
     g_assert(!err);
     g_assert_cmpint(res, ==, true);
-    visitor_input_teardown(data, unused);
 
     v = visitor_input_test_init(data, "false");
 
     visit_type_bool(v, NULL, &res, &err);
     g_assert(!err);
     g_assert_cmpint(res, ==, false);
-    visitor_input_teardown(data, unused);
 
     v = visitor_input_test_init(data, "no");
 
     visit_type_bool(v, NULL, &res, &err);
     g_assert(!err);
     g_assert_cmpint(res, ==, false);
-    visitor_input_teardown(data, unused);
 
     v = visitor_input_test_init(data, "off");
 
@@ -190,8 +183,6 @@ static void test_visitor_in_enum(TestInputVisitorData *data,
         visit_type_EnumOne(v, NULL, &res, &err);
         g_assert(!err);
         g_assert_cmpint(i, ==, res);
-
-        visitor_input_teardown(data, NULL);
     }
 }
 
@@ -224,30 +215,24 @@ static void test_visitor_in_fuzz(TestInputVisitorData *data,
 
         v = visitor_input_test_init(data, buf);
         visit_type_int(v, NULL, &ires, NULL);
-        visitor_input_teardown(data, NULL);
 
         v = visitor_input_test_init(data, buf);
         visit_type_intList(v, NULL, &ilres, NULL);
         qapi_free_intList(ilres);
-        visitor_input_teardown(data, NULL);
 
         v = visitor_input_test_init(data, buf);
         visit_type_bool(v, NULL, &bres, NULL);
-        visitor_input_teardown(data, NULL);
 
         v = visitor_input_test_init(data, buf);
         visit_type_number(v, NULL, &nres, NULL);
-        visitor_input_teardown(data, NULL);
 
         v = visitor_input_test_init(data, buf);
         sres = NULL;
         visit_type_str(v, NULL, &sres, NULL);
         g_free(sres);
-        visitor_input_teardown(data, NULL);
 
         v = visitor_input_test_init(data, buf);
         visit_type_EnumOne(v, NULL, &eres, NULL);
-        visitor_input_teardown(data, NULL);
     }
 }
 
-- 
2.7.4
