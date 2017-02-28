Received: from eggs.gnu.org ([2001:4830:134:3::10]:50006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilkH-0003ev-4H
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilkE-0005Sg-TL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cilkE-0005RV-Mh
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D46F21555E
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:39:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 18:39:19 +0100
Message-Id: <1488303560-18803-26-git-send-email-armbru@redhat.com>
In-Reply-To: <1488303560-18803-1-git-send-email-armbru@redhat.com>
References: <1488303560-18803-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 25/26] qapi: Fix object input visit beyond
 end of list
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/qobject-input-visitor.c       | 11 ++++++++---
 tests/test-qobject-input-visitor.c |  2 --
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 34065ba..d192727 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -122,10 +122,15 @@ static QObject *qobject_input_try_get_object(QObjectInputVisitor *qiv,
     } else {
         assert(qobject_type(qobj) == QTYPE_QLIST);
         assert(!name);
-        ret = qlist_entry_obj(tos->entry);
-        assert(ret);
+        if (tos->entry) {
+            ret = qlist_entry_obj(tos->entry);
+            if (consume) {
+                tos->entry = qlist_next(tos->entry);
+            }
+        } else {
+            ret = NULL;
+        }
         if (consume) {
-            tos->entry = qlist_next(tos->entry);
             tos->index++;
         }
     }
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 8011baa..94305f5 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -953,10 +953,8 @@ static void test_visitor_in_fail_list(TestInputVisitorData *data,
     v = visitor_input_test_init(data, "[]");
 
     visit_start_list(v, NULL, NULL, 0, &error_abort);
-#if 0 /* FIXME crash */
     visit_type_int(v, NULL, &i64, &err);
     error_free_or_abort(&err);
-#endif
     visit_end_list(v, NULL);
 }
 
-- 
2.7.4
