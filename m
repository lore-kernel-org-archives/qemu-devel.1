Received: from eggs.gnu.org ([2001:4830:134:3::10]:34855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch1CX-0007lT-GM
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch1CU-0004bz-Kw
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ch1CU-0004bF-Dq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:22 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 828273A76B3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 21:45:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 217E92D654
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 21:45:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Feb 2017 22:45:03 +0100
Message-Id: <1487886317-27400-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-1-git-send-email-armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/21] qmp: Eliminate silly QERR_QMP_* macros
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
index 4fc1122..377ebb5 100644
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
