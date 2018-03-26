Received: from eggs.gnu.org ([2001:4830:134:3::10]:54950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tl0-0005St-Me
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkz-0002u1-Ei
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tkz-0002tl-9E
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:57 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:52 +0200
Message-Id: <20180326150916.9602-15-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 14/38] monitor: simplify
 monitor_qmp_respond()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Since the error path is at a single location, we can create the
response object there, simplifying argument handling. While at it,
also simplify id ownership: no need for the extra reference count.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 58 ++++++++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/monitor.c b/monitor.c
index e9d0c4d172..0d01e17398 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3899,46 +3899,27 @@ static int monitor_can_read(void *opaque)
     return !atomic_mb_read(&mon->suspend_cnt);
 }
=20
-/*
- * 1. This function takes ownership of rsp, err, and id.
- * 2. rsp, err, and id may be NULL.
- * 3. If err !=3D NULL then rsp must be NULL.
- */
-static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
-                                Error *err, QObject *id)
+/* take the ownership of rsp & id */
+static void monitor_qmp_respond(Monitor *mon, QObject *rsp, QObject *id)
 {
-    QDict *qdict =3D NULL;
-
-    if (err) {
-        assert(!rsp);
-        qdict =3D qdict_new();
-        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
-        error_free(err);
-        rsp =3D QOBJECT(qdict);
-    }
-
-    if (rsp) {
-        if (id) {
-            /* This is for the qdict below. */
-            qobject_incref(id);
-            qdict_put_obj(qobject_to(QDict, rsp), "id", id);
-        }
+    if (!rsp) {
+        return;
+    }
=20
-        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
-            qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error");
-            if (qdict
-                && !g_strcmp0(qdict_get_try_str(qdict, "class"),
+    if (id) {
+        qdict_put_obj(qobject_to(QDict, rsp), "id", id);
+    }
+    if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
+        QDict *qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error"=
);
+        if (qdict
+            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
                           QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOU=
ND))) {
-                /* Provide a more useful error message */
-                qdict_put_str(qdict, "desc", "Expecting capabilities"
-                              " negotiation with 'qmp_capabilities'");
-            }
+            /* Provide a more useful error message */
+            qdict_put_str(qdict, "desc", "Expecting capabilities"
+                          " negotiation with 'qmp_capabilities'");
         }
-
-        monitor_json_emitter(mon, rsp);
     }
-
-    qobject_decref(id);
+    monitor_json_emitter(mon, rsp);
     qobject_decref(rsp);
 }
=20
@@ -3981,7 +3962,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
     cur_mon =3D old_mon;
=20
     /* Respond if necessary */
-    monitor_qmp_respond(mon, rsp, NULL, id);
+    monitor_qmp_respond(mon, rsp, id);
=20
     qobject_decref(req);
 }
@@ -4131,7 +4112,10 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
     return;
=20
 err:
-    monitor_qmp_respond(mon, NULL, err, NULL);
+    qdict =3D qdict_new();
+    qdict_put_obj(qdict, "error", qmp_build_error_object(err));
+    error_free(err);
+    monitor_qmp_respond(mon, QOBJECT(qdict), id);
     qobject_decref(req);
 }
=20
--=20
2.17.0.rc1.1.g4c4f2b46a3
