Received: from eggs.gnu.org ([2001:4830:134:3::10]:55164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlT-0005zm-Mf
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlO-0003Ak-V9
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36656 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TlO-0003AW-Pg
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:22 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:01 +0200
Message-Id: <20180326150916.9602-24-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 23/38] QmpSession: introduce QmpReturn
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

QmpReturn and associated functions are used internally for synchronous
dispatch return for now. They will be used for returning in an
asynchronous way, by holding the pre-prepared response, and having
some bookkeeping in QmpSession.

They also help to factor out a bit of code preparing the json reply
and calling the return_cb.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 33 +++++++++++++++++++
 monitor.c                   |  7 +---
 qapi/qmp-dispatch.c         | 65 ++++++++++++++++++++++++-------------
 3 files changed, 76 insertions(+), 29 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 5329d0052a..7ca8ab17d9 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -17,6 +17,8 @@
 #include "qemu/queue.h"
 #include "qapi/qmp/json-streamer.h"
=20
+typedef struct QmpReturn QmpReturn;
+
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
=20
 typedef enum QmpCommandOptions
@@ -48,6 +50,37 @@ struct QmpSession {
     QmpCommandList *cmds;
 };
=20
+struct QmpReturn {
+    QmpSession *session;
+    QDict *rsp;
+};
+
+/*
+ * @qmp_return_new:
+ *
+ * Allocates and initializes a QmpReturn.
+ */
+QmpReturn *qmp_return_new(QmpSession *session, const QDict *req);
+
+/*
+ * @qmp_return_free:
+ *
+ * Free a QmpReturn. This shouldn't be needed if you actually return
+ * with qmp_return{_error}.
+ */
+void qmp_return_free(QmpReturn *qret);
+
+/*
+ * @qmp_return{_error}:
+ *
+ * Construct the command reply, and call the
+ * return_cb() associated with the session.
+ *
+ * Finally, free the QmpReturn.
+ */
+void qmp_return(QmpReturn *qret, QObject *rsp);
+void qmp_return_error(QmpReturn *qret, Error *err);
+
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
 void qmp_unregister_command(QmpCommandList *cmds, const char *name);
diff --git a/monitor.c b/monitor.c
index 94ad366c2d..73a06d4156 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4010,7 +4010,6 @@ static void monitor_qmp_bh_dispatcher(void *data)
=20
 static void qmp_dispatch_cb(QmpSession *session, QDict *req)
 {
-    QDict *rsp;
     QObject *id;
     Monitor *mon =3D container_of(session, Monitor, qmp.session);
     Error *err =3D NULL;
@@ -4081,11 +4080,7 @@ static void qmp_dispatch_cb(QmpSession *session, Q=
Dict *req)
     return;
=20
 err:
-    rsp =3D qdict_new();
-    qdict_put_obj(rsp, "error", qmp_build_error_object(err));
-    error_free(err);
-    monitor_json_emitter(mon, QOBJECT(rsp));
-    QDECREF(rsp);
+    qmp_return_error(qmp_return_new(session, req), err);
 }
=20
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 53d099d303..7b57fa7987 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -19,6 +19,42 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
=20
+QmpReturn *qmp_return_new(QmpSession *session, const QDict *req)
+{
+    QmpReturn *qret =3D g_new0(QmpReturn, 1);
+    QObject *id =3D req ? qdict_get(req, "id") : NULL;
+
+    qret->session =3D session;
+    qret->rsp =3D qdict_new();
+    if (id) {
+        qobject_incref(id);
+        qdict_put_obj(qret->rsp, "id", id);
+    }
+
+    return qret;
+}
+
+void qmp_return_free(QmpReturn *qret)
+{
+    QDECREF(qret->rsp);
+    g_free(qret);
+}
+
+void qmp_return(QmpReturn *qret, QObject *rsp)
+{
+    qdict_put_obj(qret->rsp, "return", rsp ?: QOBJECT(qdict_new()));
+    qret->session->return_cb(qret->session, qret->rsp);
+    qmp_return_free(qret);
+}
+
+void qmp_return_error(QmpReturn *qret, Error *err)
+{
+    qdict_put_obj(qret->rsp, "error", qmp_build_error_object(err));
+    error_free(err);
+    qret->session->return_cb(qret->session, qret->rsp);
+    qmp_return_free(qret);
+}
+
 QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 {
     const QDictEntry *ent;
@@ -150,7 +186,7 @@ static void qmp_json_parser_emit(JSONMessageParser *p=
arser, GQueue *tokens)
 {
     QmpSession *session =3D container_of(parser, QmpSession, parser);
     QObject *obj;
-    QDict *req;
+    QDict *req =3D NULL;
     Error *err =3D NULL;
=20
     obj =3D json_parser_parse_err(tokens, NULL, &err);
@@ -167,11 +203,7 @@ static void qmp_json_parser_emit(JSONMessageParser *=
parser, GQueue *tokens)
=20
 end:
     if (err) {
-        QDict *rsp =3D qdict_new();
-        qdict_put_obj(rsp, "error", qmp_build_error_object(err));
-        error_free(err);
-        session->return_cb(session, rsp);
-        QDECREF(rsp);
+        qmp_return_error(qmp_return_new(session, req), err);
     }
     qobject_decref(obj);
 }
@@ -204,28 +236,15 @@ void qmp_session_destroy(QmpSession *session)
=20
 void qmp_dispatch(QmpSession *session, QDict *req)
 {
+    QmpReturn *qret =3D qmp_return_new(session, req);
     Error *err =3D NULL;
     QObject *ret;
-    QDict *rsp;
-    QObject *id =3D qdict_get(req, "id");
=20
     ret =3D do_qmp_dispatch(session->cmds, req, &err);
-
-    rsp =3D qdict_new();
-    if (id) {
-        qobject_incref(id);
-        qdict_put_obj(rsp, "id", id);
-    }
     if (err) {
-        qdict_put_obj(rsp, "error", qmp_build_error_object(err));
-        error_free(err);
+        assert(!ret);
+        qmp_return_error(qret, err);
     } else if (ret) {
-        qdict_put_obj(rsp, "return", ret);
-    } else {
-        QDECREF(rsp);
-        return;
+        qmp_return(qret, ret);
     }
-
-    session->return_cb(session, rsp);
-    QDECREF(rsp);
 }
--=20
2.17.0.rc1.1.g4c4f2b46a3
