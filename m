Received: from eggs.gnu.org ([2001:4830:134:3::10]:45335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJZ-0000nj-2g
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJY-00060v-1U
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJX-00060b-TZ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F0C476FB9
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:13 -0500
Message-Id: <20180312183628.394722-23-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 22/36] monitor: introduce monitor_qmp_respond()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Peter Xu <peterx@redhat.com>

A tiny refactoring, preparing to split the QMP dispatcher away.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-12-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: rebase to qobject_to() usage]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/monitor.c b/monitor.c
index 1a95fb372c6..a3412359ca8 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3819,6 +3819,38 @@ static int monitor_can_read(void *opaque)
     return (mon->suspend_cnt == 0) ? 1 : 0;
 }

+/*
+ * 1. This function takes ownership of rsp, err, and id.
+ * 2. rsp, err, and id may be NULL.
+ * 3. If err != NULL then rsp must be NULL.
+ */
+static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
+                                Error *err, QObject *id)
+{
+    QDict *qdict = NULL;
+
+    if (err) {
+        assert(!rsp);
+        qdict = qdict_new();
+        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
+        error_free(err);
+        rsp = QOBJECT(qdict);
+    }
+
+    if (rsp) {
+        if (id) {
+            /* This is for the qdict below. */
+            qobject_incref(id);
+            qdict_put_obj(qobject_to(QDict, rsp), "id", id);
+        }
+
+        monitor_json_emitter(mon, rsp);
+    }
+
+    qobject_decref(id);
+    qobject_decref(rsp);
+}
+
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 {
     QObject *req, *rsp = NULL, *id = NULL;
@@ -3870,24 +3902,8 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     }

 err_out:
-    if (err) {
-        qdict = qdict_new();
-        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
-        error_free(err);
-        rsp = QOBJECT(qdict);
-    }
+    monitor_qmp_respond(mon, rsp, err, id);

-    if (rsp) {
-        if (id) {
-            qdict_put_obj(qobject_to(QDict, rsp), "id", id);
-            id = NULL;
-        }
-
-        monitor_json_emitter(mon, rsp);
-    }
-
-    qobject_decref(id);
-    qobject_decref(rsp);
     qobject_decref(req);
 }

-- 
2.14.3
