Received: from eggs.gnu.org ([2001:4830:134:3::10]:34777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch1CV-0007l2-V0
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch1CU-0004bg-GP
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ch1CU-0004b9-AZ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:22 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D6A27E9D7
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 21:45:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1NLjLSs003304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 16:45:22 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Feb 2017 22:45:06 +0100
Message-Id: <1487886317-27400-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-1-git-send-email-armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 10/21] qapi: Clean up after commit 3d344c2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Drop unused QIV_STACK_SIZE and unused qobject_input_start_struct()
parameter errp.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qobject-input-visitor.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index f3b6713..2c2f883 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -21,8 +21,6 @@
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qerror.h"
 
-#define QIV_STACK_SIZE 1024
-
 typedef struct StackObject
 {
     QObject *obj; /* Object being visited */
@@ -103,8 +101,7 @@ static void qdict_add_key(const char *key, QObject *obj, void *opaque)
 }
 
 static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,
-                                            QObject *obj, void *qapi,
-                                            Error **errp)
+                                            QObject *obj, void *qapi)
 {
     GHashTable *h;
     StackObject *tos = g_new0(StackObject, 1);
@@ -170,7 +167,6 @@ static void qobject_input_start_struct(Visitor *v, const char *name, void **obj,
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
-    Error *err = NULL;
 
     if (obj) {
         *obj = NULL;
@@ -184,11 +180,7 @@ static void qobject_input_start_struct(Visitor *v, const char *name, void **obj,
         return;
     }
 
-    qobject_input_push(qiv, qobj, obj, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+    qobject_input_push(qiv, qobj, obj);
 
     if (obj) {
         *obj = g_malloc0(size);
@@ -216,7 +208,7 @@ static void qobject_input_start_list(Visitor *v, const char *name,
         return;
     }
 
-    entry = qobject_input_push(qiv, qobj, list, errp);
+    entry = qobject_input_push(qiv, qobj, list);
     if (list) {
         if (entry) {
             *list = g_malloc0(size);
-- 
2.7.4
