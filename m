Received: from eggs.gnu.org ([2001:4830:134:3::10]:45670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckReB-0000Oo-Fz
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe9-0002zS-A0
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe9-0002yq-2p
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:05 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40862C05678D
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v258a3vH022907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 5 Mar 2017 03:36:04 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:57 +0100
Message-Id: <1488702958-24336-27-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-1-git-send-email-armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 26/27] qapi: Fix object input visit beyond
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
Message-Id: <1488544368-30622-28-git-send-email-armbru@redhat.com>
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
