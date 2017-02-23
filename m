Received: from eggs.gnu.org ([2001:4830:134:3::10]:34915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch1CZ-0007mD-2l
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch1CW-0004dd-6G
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ch1CV-0004cX-Sv
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:23 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02E8CC04B95D
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 21:45:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1NLjMce003318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 16:45:23 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Feb 2017 22:45:12 +0100
Message-Id: <1487886317-27400-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-1-git-send-email-armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 16/21] test-qobject-input-visitor: Use strict
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
