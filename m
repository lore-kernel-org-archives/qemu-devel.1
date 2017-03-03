Received: from eggs.gnu.org ([2001:4830:134:3::10]:42377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjmOF-0007ud-3b
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjmOD-0007yo-PJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:32:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjmOD-0007y9-Jj
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:32:53 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C140F3D95D
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 12:32:53 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  3 Mar 2017 13:32:33 +0100
Message-Id: <1488544368-30622-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1488544368-30622-1-git-send-email-armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 13/28] qapi: Make QObject input visitor set
 *list reliably
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qobject_input_start_struct() sets *list, except when it fails because
qobject_input_get_object() fails, i.e. the input object doesn't exist.

All the other input visitor start_struct(), start_list(),
start_alternate() always set *obj / *list.

Change qobject_input_start_struct() to match.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/qobject-input-visitor.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 2c2f883..d58696c 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -196,25 +196,21 @@ static void qobject_input_start_list(Visitor *v, const char *name,
     QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
     const QListEntry *entry;
 
+    if (list) {
+        *list = NULL;
+    }
     if (!qobj) {
         return;
     }
     if (qobject_type(qobj) != QTYPE_QLIST) {
-        if (list) {
-            *list = NULL;
-        }
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
                    "list");
         return;
     }
 
     entry = qobject_input_push(qiv, qobj, list);
-    if (list) {
-        if (entry) {
-            *list = g_malloc0(size);
-        } else {
-            *list = NULL;
-        }
+    if (entry && list) {
+        *list = g_malloc0(size);
     }
 }
 
-- 
2.7.4
