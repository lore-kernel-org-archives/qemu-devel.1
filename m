Received: from eggs.gnu.org ([2001:4830:134:3::10]:42498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjmOH-0007vV-G2
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjmOF-00081F-KM
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:32:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjmOF-0007zl-9L
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:32:55 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6320F64369
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 12:32:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  3 Mar 2017 13:32:44 +0100
Message-Id: <1488544368-30622-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1488544368-30622-1-git-send-email-armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 24/28] test-qobject-input-visitor: Cover
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
