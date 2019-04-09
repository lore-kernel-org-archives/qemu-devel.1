Received: from eggs.gnu.org ([209.51.188.92]:55619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLE-0002nN-KS
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLD-0004pJ-At
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtL5-0004jB-5w
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:14 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 18:09:57 +0200
Message-Id: <20190409161009.6322-9-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 08/20] QmpSession: introduce QmpReturn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

QmpReturn (and associated functions) is used during synchronous
dispatch return for now. It helps to factor out some code for
handling a reply context.

In the following patches, the QmpReturn will be the basis upon which
asynchronous reply will be handled: it will hold the context for a QMP
command reply.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 34 ++++++++++++++++-
 monitor.c                   |  6 +--
 qapi/qmp-dispatch.c         | 74 ++++++++++++++++++++++---------------
 3 files changed, 79 insertions(+), 35 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index b3ca6c9ff2..6c0d21968e 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -17,6 +17,8 @@
 #include "qemu/queue.h"
 #include "qapi/qmp/json-parser.h"
=20
+typedef struct QmpReturn QmpReturn;
+
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
=20
 typedef enum QmpCommandOptions
@@ -47,6 +49,37 @@ struct QmpSession {
     QmpDispatchReturn *return_cb;
 };
=20
+struct QmpReturn {
+    QmpSession *session;
+    QDict *rsp;
+};
+
+/**
+ * qmp_return_new:
+ *
+ * Allocates and initializes a QmpReturn.
+ */
+QmpReturn *qmp_return_new(QmpSession *session, const QObject *req);
+
+/**
+ * qmp_return_free:
+ *
+ * Free a QmpReturn. This shouldn't be needed if you actually return
+ * with qmp_return{_error}.
+ */
+void qmp_return_free(QmpReturn *qret);
+
+/**
+ * qmp_return{_error}:
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
 const QmpCommand *qmp_find_command(const QmpCommandList *cmds,
@@ -67,7 +100,6 @@ void qmp_enable_command(QmpCommandList *cmds, const ch=
ar *name);
 bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
-QDict *qmp_error_response(Error *err);
 void qmp_dispatch(QmpSession *session, QObject *request,
                   bool allow_oob);
 bool qmp_is_oob(const QDict *dict);
diff --git a/monitor.c b/monitor.c
index 71aad8d1ae..b1c4647a37 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4175,7 +4175,6 @@ static QMPRequest *monitor_qmp_requests_pop_any_wit=
h_lock(void)
 static void monitor_qmp_bh_dispatcher(void *data)
 {
     QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock();
-    QDict *rsp;
     bool need_resume;
     Monitor *mon;
=20
@@ -4194,11 +4193,10 @@ static void monitor_qmp_bh_dispatcher(void *data)
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
         monitor_qmp_dispatch(mon, req_obj->req);
     } else {
+        QmpSession *session =3D &req_obj->mon->qmp.session;
         assert(req_obj->err);
-        rsp =3D qmp_error_response(req_obj->err);
+        qmp_return_error(qmp_return_new(session, req_obj->req), req_obj-=
>err);
         req_obj->err =3D NULL;
-        qmp_send_response(req_obj->mon, rsp);
-        qobject_unref(rsp);
     }
=20
     if (need_resume) {
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index f2c376d005..405cb291b1 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -19,6 +19,46 @@
 #include "qapi/qmp/qbool.h"
 #include "sysemu/sysemu.h"
=20
+QmpReturn *qmp_return_new(QmpSession *session, const QObject *request)
+{
+    QmpReturn *qret =3D g_new0(QmpReturn, 1);
+    const QDict *req =3D qobject_to(QDict, request);
+    QObject *id =3D req ? qdict_get(req, "id") : NULL;
+
+    qret->session =3D session;
+    qret->rsp =3D qdict_new();
+    if (id) {
+        qobject_ref(id);
+        qdict_put_obj(qret->rsp, "id", id);
+    }
+
+    return qret;
+}
+
+void qmp_return_free(QmpReturn *qret)
+{
+    qobject_unref(qret->rsp);
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
+    qdict_put_obj(qret->rsp, "error",
+                  qobject_from_jsonf_nofail("{ 'class': %s, 'desc': %s }=
",
+                      QapiErrorClass_str(error_get_class(err)),
+                      error_get_pretty(err)));
+    error_free(err);
+    qret->session->return_cb(qret->session, qret->rsp);
+    qmp_return_free(qret);
+}
+
 static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_=
oob,
                                      Error **errp)
 {
@@ -143,17 +183,6 @@ static QObject *do_qmp_dispatch(const QmpCommandList=
 *cmds, QObject *request,
     return ret;
 }
=20
-QDict *qmp_error_response(Error *err)
-{
-    QDict *rsp;
-
-    rsp =3D qdict_from_jsonf_nofail("{ 'error': { 'class': %s, 'desc': %=
s } }",
-                                  QapiErrorClass_str(error_get_class(err=
)),
-                                  error_get_pretty(err));
-    error_free(err);
-    return rsp;
-}
-
 /*
  * Does @qdict look like a command to be run out-of-band?
  */
@@ -170,9 +199,7 @@ static void qmp_json_emit(void *opaque, QObject *obj,=
 Error *err)
     assert(!obj !=3D !err);
=20
     if (err) {
-        QDict *rsp =3D qmp_error_response(err);
-        session->return_cb(session, rsp);
-        qobject_unref(rsp);
+        qmp_return_error(qmp_return_new(session, obj), err);
     } else {
         qmp_dispatch(session, obj, false);
     }
@@ -208,25 +235,12 @@ void qmp_session_destroy(QmpSession *session)
 void qmp_dispatch(QmpSession *session, QObject *request, bool allow_oob)
 {
     Error *err =3D NULL;
-    QDict *dict =3D qobject_to(QDict, request);
-    QObject *ret, *id =3D dict ? qdict_get(dict, "id") : NULL;
-    QDict *rsp;
+    QObject *ret;
=20
     ret =3D do_qmp_dispatch(session->cmds, request, allow_oob, &err);
     if (err) {
-        rsp =3D qmp_error_response(err);
+        qmp_return_error(qmp_return_new(session, request), err);
     } else if (ret) {
-        rsp =3D qdict_new();
-        qdict_put_obj(rsp, "return", ret);
-    } else {
-        /* Can only happen for commands with QCO_NO_SUCCESS_RESP */
-        return;
+        qmp_return(qmp_return_new(session, request), ret);
     }
-
-    if (id) {
-        qdict_put_obj(rsp, "id", qobject_ref(id));
-    }
-
-    session->return_cb(session, rsp);
-    qobject_unref(rsp);
 }
--=20
2.21.0.196.g041f5ea1cf
