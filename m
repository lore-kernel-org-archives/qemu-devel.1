Received: from eggs.gnu.org ([2001:4830:134:3::10]:37670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDZ7-0001HC-5F
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDZ2-00014R-9S
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:47:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRDZ2-000146-2d
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:47:52 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Dec 2017 16:45:43 +0800
Message-Id: <20171219084557.9801-14-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
References: <20171219084557.9801-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v6 13/27] monitor: introduce monitor_qmp_respond()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

A tiny refactoring, preparing to split the QMP dispatcher away.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/monitor.c b/monitor.c
index c88a11cd69..cf1e5d881c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3865,6 +3865,38 @@ static int monitor_can_read(void *opaque)
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
+            qdict_put_obj(qobject_to_qdict(rsp), "id", id);
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
@@ -3916,24 +3948,8 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
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
-            qdict_put_obj(qobject_to_qdict(rsp), "id", id);
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
