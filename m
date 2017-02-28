Received: from eggs.gnu.org ([2001:4830:134:3::10]:50010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilkH-0003f2-Bh
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilkE-0005Se-Td
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cilkE-0005RW-N1
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D39F980477
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:39:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 18:39:16 +0100
Message-Id: <1488303560-18803-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1488303560-18803-1-git-send-email-armbru@redhat.com>
References: <1488303560-18803-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 22/26] test-qobject-input-visitor: Cover
 missing nested struct member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qobject-input-visitor.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 10c15c4..9f3a826 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -894,7 +894,7 @@ static void test_visitor_in_fail_struct_missing(TestInputVisitorData *data,
     char *str;
     double dbl;
 
-    v = visitor_input_test_init(data, "{}");
+    v = visitor_input_test_init(data, "{ 'sub': [ {} ] }");
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_start_struct(v, "struct", NULL, 0, &err);
     error_free_or_abort(&err);
@@ -920,6 +920,12 @@ static void test_visitor_in_fail_struct_missing(TestInputVisitorData *data,
     error_free_or_abort(&err);
     visit_type_null(v, "null", &err);
     error_free_or_abort(&err);
+    visit_start_list(v, "sub", NULL, 0, &error_abort);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_int(v, "i64", &i64, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_end_list(v, NULL);
     visit_end_struct(v, NULL);
 }
 
-- 
2.7.4
