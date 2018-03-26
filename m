Received: from eggs.gnu.org ([2001:4830:134:3::10]:54968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tl2-0005Uw-Bg
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tl0-0002v3-UT
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tl0-0002uf-OZ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:58 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:53 +0200
Message-Id: <20180326150916.9602-16-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 15/38] qmp: pass and return a QDict to
 qmp_dispatch()
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

qmp_dispatch_check_obj() now must be called before calling
qmp_dispatch() and returns a dict.

Change qmp_dispatch() arguments, clarifying the expected qobject
types, and simplifying a bit the rest of the code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  2 +-
 monitor.c                   | 24 +++++++++++++-----------
 qapi/qmp-dispatch.c         | 15 +++++----------
 qga/main.c                  | 18 +++++++++---------
 tests/test-qmp-cmds.c       | 36 +++++++++++++++---------------------
 5 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index ffb4652f71..8e0ac29300 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -40,7 +40,7 @@ void qmp_register_command(QmpCommandList *cmds, const c=
har *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
 void qmp_unregister_command(QmpCommandList *cmds, const char *name);
 QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
-QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request);
+QDict *qmp_dispatch(QmpCommandList *cmds, QDict *request);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
=20
diff --git a/monitor.c b/monitor.c
index 0d01e17398..471c57e88c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3900,17 +3900,17 @@ static int monitor_can_read(void *opaque)
 }
=20
 /* take the ownership of rsp & id */
-static void monitor_qmp_respond(Monitor *mon, QObject *rsp, QObject *id)
+static void monitor_qmp_respond(Monitor *mon, QDict *rsp, QObject *id)
 {
     if (!rsp) {
         return;
     }
=20
     if (id) {
-        qdict_put_obj(qobject_to(QDict, rsp), "id", id);
+        qdict_put_obj(rsp, "id", id);
     }
     if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
-        QDict *qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error"=
);
+        QDict *qdict =3D qdict_get_qdict(rsp, "error");
         if (qdict
             && !g_strcmp0(qdict_get_try_str(qdict, "class"),
                           QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOU=
ND))) {
@@ -3919,8 +3919,8 @@ static void monitor_qmp_respond(Monitor *mon, QObje=
ct *rsp, QObject *id)
                           " negotiation with 'qmp_capabilities'");
         }
     }
-    monitor_json_emitter(mon, rsp);
-    qobject_decref(rsp);
+    monitor_json_emitter(mon, QOBJECT(rsp));
+    QDECREF(rsp);
 }
=20
 struct QMPRequest {
@@ -3929,7 +3929,7 @@ struct QMPRequest {
     /* "id" field of the request */
     QObject *id;
     /* Request object to be handled */
-    QObject *req;
+    QDict *req;
 };
 typedef struct QMPRequest QMPRequest;
=20
@@ -3940,7 +3940,8 @@ typedef struct QMPRequest QMPRequest;
 static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
 {
     Monitor *mon, *old_mon;
-    QObject *req, *rsp =3D NULL, *id;
+    QDict *req, *rsp =3D NULL;
+    QObject *id;
=20
     req =3D req_obj->req;
     mon =3D req_obj->mon;
@@ -3949,7 +3950,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
     g_free(req_obj);
=20
     if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
-        QString *req_json =3D qobject_to_json(req);
+        QString *req_json =3D qobject_to_json(QOBJECT(req));
         trace_handle_qmp_command(mon, qstring_get_str(req_json));
         QDECREF(req_json);
     }
@@ -3964,7 +3965,8 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
     /* Respond if necessary */
     monitor_qmp_respond(mon, rsp, id);
=20
-    qobject_decref(req);
+
+    QDECREF(req);
 }
=20
 /*
@@ -4064,7 +4066,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
     req_obj =3D g_new0(QMPRequest, 1);
     req_obj->mon =3D mon;
     req_obj->id =3D id;
-    req_obj->req =3D req;
+    req_obj->req =3D qdict;
=20
     if (qmp_is_oob(qdict)) {
         /* Out-Of-Band (OOB) requests are executed directly in parser. *=
/
@@ -4115,7 +4117,7 @@ err:
     qdict =3D qdict_new();
     qdict_put_obj(qdict, "error", qmp_build_error_object(err));
     error_free(err);
-    monitor_qmp_respond(mon, QOBJECT(qdict), id);
+    monitor_qmp_respond(mon, qdict, id);
     qobject_decref(req);
 }
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index dd05907265..66596b66a0 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -74,20 +74,15 @@ QDict *qmp_dispatch_check_obj(const QObject *request,=
 Error **errp)
     return dict;
 }
=20
-static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
+static QObject *do_qmp_dispatch(QmpCommandList *cmds, QDict *dict,
                                 Error **errp)
 {
     Error *local_err =3D NULL;
     const char *command;
-    QDict *args, *dict;
+    QDict *args;
     QmpCommand *cmd;
     QObject *ret =3D NULL;
=20
-    dict =3D qmp_dispatch_check_obj(request, errp);
-    if (!dict) {
-        return NULL;
-    }
-
     command =3D qdict_get_str(dict, "execute");
     cmd =3D qmp_find_command(cmds, command);
     if (cmd =3D=3D NULL) {
@@ -151,13 +146,13 @@ bool qmp_is_oob(QDict *dict)
     return qbool_get_bool(bool_obj);
 }
=20
-QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request)
+QDict *qmp_dispatch(QmpCommandList *cmds, QDict *req)
 {
     Error *err =3D NULL;
     QObject *ret;
     QDict *rsp;
=20
-    ret =3D do_qmp_dispatch(cmds, request, &err);
+    ret =3D do_qmp_dispatch(cmds, req, &err);
=20
     rsp =3D qdict_new();
     if (err) {
@@ -170,5 +165,5 @@ QObject *qmp_dispatch(QmpCommandList *cmds, QObject *=
request)
         return NULL;
     }
=20
-    return QOBJECT(rsp);
+    return rsp;
 }
diff --git a/qga/main.c b/qga/main.c
index 71468e68c2..04f7dad0b3 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -583,7 +583,8 @@ static int send_response(GAState *s, QObject *payload=
)
 static void process_event(JSONMessageParser *parser, GQueue *tokens)
 {
     GAState *s =3D container_of(parser, GAState, parser);
-    QObject *req, *rsp =3D NULL;
+    QObject *obj;
+    QDict *req, *rsp =3D NULL;
     Error *err =3D NULL;
     int ret;
=20
@@ -591,12 +592,12 @@ static void process_event(JSONMessageParser *parser=
, GQueue *tokens)
=20
     g_debug("process_event: called");
=20
-    req =3D json_parser_parse_err(tokens, NULL, &err);
+    obj =3D json_parser_parse_err(tokens, NULL, &err);
     if (err) {
         goto end;
     }
=20
-    qmp_dispatch_check_obj(req, &err);
+    req =3D qmp_dispatch_check_obj(obj, &err);
     if (err) {
         goto end;
     }
@@ -606,19 +607,18 @@ static void process_event(JSONMessageParser *parser=
, GQueue *tokens)
=20
 end:
     if (err) {
-        QDict *qdict =3D qdict_new();
-        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
+        rsp =3D qdict_new();
+        qdict_put_obj(rsp, "error", qmp_build_error_object(err));
         error_free(err);
-        rsp =3D QOBJECT(qdict);
     }
     if (rsp) {
-        ret =3D send_response(s, rsp);
+        ret =3D send_response(s, QOBJECT(rsp));
         if (ret < 0) {
             g_warning("error sending error response: %s", strerror(-ret)=
);
         }
-        qobject_decref(rsp);
+        QDECREF(rsp);
     }
-    qobject_decref(req);
+    qobject_decref(obj);
 }
=20
 /* false return signals GAChannel to close the current client connection=
 */
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 02cbaf41a2..52e2738a93 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -97,16 +97,15 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_q=
emu_x_EnumList *a,
 /* test commands with no input and no return value */
 static void test_dispatch_cmd(void)
 {
-    QDict *req =3D qdict_new();
-    QObject *resp;
+    QDict *resp, *req =3D qdict_new();
=20
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req));
+    resp =3D qmp_dispatch(&qmp_commands, req);
     assert(resp !=3D NULL);
-    assert(!qdict_haskey(qobject_to(QDict, resp), "error"));
+    assert(!qdict_haskey(resp, "error"));
=20
-    qobject_decref(resp);
+    QDECREF(resp);
     QDECREF(req);
 }
=20
@@ -114,16 +113,15 @@ static void test_dispatch_cmd(void)
 static void test_dispatch_cmd_failure(void)
 {
     QDict *req =3D qdict_new();
-    QDict *args =3D qdict_new();
-    QObject *resp;
+    QDict *resp, *args =3D qdict_new();
=20
     qdict_put_str(req, "execute", "user_def_cmd2");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req));
+    resp =3D qmp_dispatch(&qmp_commands, req);
     assert(resp !=3D NULL);
-    assert(qdict_haskey(qobject_to(QDict, resp), "error"));
+    assert(qdict_haskey(resp, "error"));
=20
-    qobject_decref(resp);
+    QDECREF(resp);
     QDECREF(req);
=20
     /* check that with extra arguments it throws an error */
@@ -133,39 +131,35 @@ static void test_dispatch_cmd_failure(void)
=20
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req));
+    resp =3D qmp_dispatch(&qmp_commands, req);
     assert(resp !=3D NULL);
-    assert(qdict_haskey(qobject_to(QDict, resp), "error"));
+    assert(qdict_haskey(resp, "error"));
=20
-    qobject_decref(resp);
+    QDECREF(resp);
     QDECREF(req);
 }
=20
 static void test_dispatch_cmd_success_response(void)
 {
-    QDict *req =3D qdict_new();
-    QObject *resp;
+    QDict *resp, *req =3D qdict_new();
=20
     qdict_put_str(req, "execute", "cmd-success-response");
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req));
+    resp =3D qmp_dispatch(&qmp_commands, req);
     assert(resp =3D=3D NULL);
     QDECREF(req);
 }
=20
 static QObject *test_qmp_dispatch(QDict *req)
 {
-    QObject *resp_obj;
     QDict *resp;
     QObject *ret;
=20
-    resp_obj =3D qmp_dispatch(&qmp_commands, QOBJECT(req));
-    assert(resp_obj);
-    resp =3D qobject_to(QDict, resp_obj);
+    resp =3D qmp_dispatch(&qmp_commands, req);
     assert(resp && !qdict_haskey(resp, "error"));
     ret =3D qdict_get(resp, "return");
     assert(ret);
     qobject_incref(ret);
-    qobject_decref(resp_obj);
+    QDECREF(resp);
     return ret;
 }
=20
--=20
2.17.0.rc1.1.g4c4f2b46a3
