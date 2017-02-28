Received: from eggs.gnu.org ([2001:4830:134:3::10]:45428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6j-0001Yy-3x
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6g-0006ua-DX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cin6g-0006u1-7F
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:42 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BE043D941
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 46C1B2D655
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 20:06:26 +0100
Message-Id: <1488308796-28832-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1488308796-28832-1-git-send-email-armbru@redhat.com>
References: <1488308796-28832-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 16/26] test-qobject-input-visitor: Use strict
 visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The qobject input visitor comes in a strict and a non-strict variant.
This test is the non-strict variant's last user.  Turns out it relies
on non-strict only in test_visitor_in_null(), and just out of
laziness.  We don't actually test the non-strict behavior.

Clean up test_visitor_in_null(), and switch to the strict variant.
The next commit will drop the non-strict variant.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488303560-18803-17-git-send-email-armbru@redhat.com>
---
 tests/test-qobject-input-visitor.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 945404a..125e34c 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -49,7 +49,7 @@ static Visitor *visitor_input_test_init_internal(TestInputVisitorData *data,
     data->obj = qobject_from_jsonv(json_string, ap);
     g_assert(data->obj);
 
-    data->qiv = qobject_input_visitor_new(data->obj, false);
+    data->qiv = qobject_input_visitor_new(data->obj, true);
     g_assert(data->qiv);
     return data->qiv;
 }
@@ -290,14 +290,14 @@ static void test_visitor_in_null(TestInputVisitorData *data,
      * when input is not null.
      */
 
-    v = visitor_input_test_init(data, "{ 'a': null, 'b': '' }");
+    v = visitor_input_test_init(data, "{ 'a': null, 'b': '', 'c': null }");
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_null(v, "a", &error_abort);
-    visit_type_str(v, "a", &tmp, &err);
-    g_assert(!tmp);
-    error_free_or_abort(&err);
     visit_type_null(v, "b", &err);
     error_free_or_abort(&err);
+    visit_type_str(v, "c", &tmp, &err);
+    g_assert(!tmp);
+    error_free_or_abort(&err);
     visit_check_struct(v, &error_abort);
     visit_end_struct(v, NULL);
 }
-- 
2.7.4
