Received: from eggs.gnu.org ([2001:4830:134:3::10]:52492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOwL-0007BD-Nm
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOwJ-0007fC-UN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsOwJ-0007d8-LC
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:59 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 14 Sep 2017 15:50:31 +0800
Message-Id: <1505375436-28439-11-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-1-git-send-email-peterx@redhat.com>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 10/15] monitor: introduce monitor_qmp_respond()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

A tiny refactoring, preparing to split the QMP dispatcher away.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/monitor.c b/monitor.c
index 83f5e87..aa0c384 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3828,6 +3828,36 @@ static int monitor_can_read(void *opaque)
     return (mon->suspend_cnt == 0) ? 1 : 0;
 }
 
+/*
+ * When rsp/err/id is passed in, the function will be responsible for
+ * the cleanup.
+ */
+static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
+                                Error *err, QObject *id)
+{
+    QDict *qdict = NULL;
+
+    if (err) {
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
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
                                void *opaque)
 {
@@ -3878,24 +3908,8 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
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
2.7.4
