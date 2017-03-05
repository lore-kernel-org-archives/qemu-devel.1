Received: from eggs.gnu.org ([2001:4830:134:3::10]:45665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckReB-0000Om-Es
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe7-0002y8-G2
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe7-0002wn-4i
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:03 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F85A883A6
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v258a1Cp024249
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 5 Mar 2017 03:36:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:40 +0100
Message-Id: <1488702958-24336-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-1-git-send-email-armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 09/27] qmp: Eliminate silly QERR_QMP_* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The QERR_ macros are leftovers from the days of "rich" error objects.

QERR_QMP_BAD_INPUT_OBJECT, QERR_QMP_BAD_INPUT_OBJECT_MEMBER,
QERR_QMP_EXTRA_MEMBER are used in just one place now, except for one
use that has crept into qobject-input-visitor.c.

Drop these macros, to make the (bad) error messages more visible.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488544368-30622-10-git-send-email-armbru@redhat.com>
---
 include/qapi/qmp/qerror.h    |  9 ---------
 qapi/qmp-dispatch.c          | 13 +++++++------
 qapi/qobject-input-visitor.c |  3 ++-
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 6586c9f..c82360f 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -82,15 +82,6 @@
 #define QERR_QGA_COMMAND_FAILED \
     "Guest agent command failed, error was '%s'"
 
-#define QERR_QMP_BAD_INPUT_OBJECT \
-    "Expected '%s' in QMP input"
-
-#define QERR_QMP_BAD_INPUT_OBJECT_MEMBER \
-    "QMP input object member '%s' expects '%s'"
-
-#define QERR_QMP_EXTRA_MEMBER \
-    "QMP input object member '%s' is unexpected"
-
 #define QERR_SET_PASSWD_FAILED \
     "Could not set password"
 
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 7fb8aef..dc50212 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 
     dict = qobject_to_qdict(request);
     if (!dict) {
-        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "object");
+        error_setg(errp, "Expected '%s' in QMP input", "object");
         return NULL;
     }
 
@@ -41,25 +41,26 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 
         if (!strcmp(arg_name, "execute")) {
             if (qobject_type(arg_obj) != QTYPE_QSTRING) {
-                error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT_MEMBER, "execute",
-                           "string");
+                error_setg(errp, "QMP input object member '%s' expects '%s'",
+                           "execute", "string");
                 return NULL;
             }
             has_exec_key = true;
         } else if (!strcmp(arg_name, "arguments")) {
             if (qobject_type(arg_obj) != QTYPE_QDICT) {
-                error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT_MEMBER,
+                error_setg(errp, "QMP input object member '%s' expects '%s'",
                            "arguments", "object");
                 return NULL;
             }
         } else {
-            error_setg(errp, QERR_QMP_EXTRA_MEMBER, arg_name);
+            error_setg(errp, "QMP input object member '%s' is unexpected",
+                       arg_name);
             return NULL;
         }
     }
 
     if (!has_exec_key) {
-        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "execute");
+        error_setg(errp, "Expected '%s' in QMP input", "execute");
         return NULL;
     }
 
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 0063327..ed6c24c 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -140,7 +140,8 @@ static void qobject_input_check_struct(Visitor *v, Error **errp)
 
             g_hash_table_iter_init(&iter, top_ht);
             if (g_hash_table_iter_next(&iter, (void **)&key, NULL)) {
-                error_setg(errp, QERR_QMP_EXTRA_MEMBER, key);
+                error_setg(errp, "QMP input object member '%s' is unexpected",
+                           key);
             }
         }
     }
-- 
2.7.4
