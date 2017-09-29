Received: from eggs.gnu.org ([2001:4830:134:3::10]:35989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm9f-0005wl-RG
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm9e-0006uw-UJ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxm9e-0006rM-GV
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:58 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:33 +0800
Message-Id: <20170929033844.26935-12-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 11/22] monitor: introduce monitor_qmp_respond()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

A tiny refactoring, preparing to split the QMP dispatcher away.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/monitor.c b/monitor.c
index 1d782afafb..0caf2019c1 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3831,6 +3831,36 @@ static int monitor_can_read(void *opaque)
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
@@ -3881,24 +3911,8 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
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
2.13.5
