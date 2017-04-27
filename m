Received: from eggs.gnu.org ([2001:4830:134:3::10]:35445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3ezV-0000Mt-4m
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3ezS-0004wZ-6D
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3ezS-0004vv-0b
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:30 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 27 Apr 2017 10:41:23 +0200
Message-Id: <1493282486-28338-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1493282486-28338-1-git-send-email-armbru@redhat.com>
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] qmp: Improve QMP dispatch error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/qmp-dispatch.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index dc50212..5ad36f8 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 
     dict = qobject_to_qdict(request);
     if (!dict) {
-        error_setg(errp, "Expected '%s' in QMP input", "object");
+        error_setg(errp, "QMP input must be a JSON object");
         return NULL;
     }
 
@@ -41,26 +41,26 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 
         if (!strcmp(arg_name, "execute")) {
             if (qobject_type(arg_obj) != QTYPE_QSTRING) {
-                error_setg(errp, "QMP input object member '%s' expects '%s'",
-                           "execute", "string");
+                error_setg(errp,
+                           "QMP input member 'execute' must be a string");
                 return NULL;
             }
             has_exec_key = true;
         } else if (!strcmp(arg_name, "arguments")) {
             if (qobject_type(arg_obj) != QTYPE_QDICT) {
-                error_setg(errp, "QMP input object member '%s' expects '%s'",
-                           "arguments", "object");
+                error_setg(errp,
+                           "QMP input member 'arguments' must be an object");
                 return NULL;
             }
         } else {
-            error_setg(errp, "QMP input object member '%s' is unexpected",
+            error_setg(errp, "QMP input member '%s' is unexpected",
                        arg_name);
             return NULL;
         }
     }
 
     if (!has_exec_key) {
-        error_setg(errp, "Expected '%s' in QMP input", "execute");
+        error_setg(errp, "QMP input lacks member 'execute'");
         return NULL;
     }
 
-- 
2.7.4
