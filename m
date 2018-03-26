Received: from eggs.gnu.org ([2001:4830:134:3::10]:55098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlL-0005o7-81
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlC-00030T-La
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TlC-00030D-Gm
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:10 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:57 +0200
Message-Id: <20180326150916.9602-20-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 19/38] QmpSession: add a return_cb
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

The introduced return_cb will allow to delay finishing the dispatch
and sending the response asynchronously. For now, this is just
modifying qmp_dispatch() to call the callback synchronously, and
return void.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  8 +++-
 monitor.c                   | 52 +++++++++++-----------
 qapi/qmp-dispatch.c         | 19 ++++++--
 qga/main.c                  | 25 ++++++-----
 tests/test-qmp-cmds.c       | 86 ++++++++++++++++++-------------------
 5 files changed, 101 insertions(+), 89 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 10ba0745c7..7bf0b6a437 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -37,8 +37,10 @@ typedef struct QmpCommand
 typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpCommandList;
=20
 typedef struct QmpSession QmpSession;
+typedef void (QmpDispatchReturn) (QmpSession *session, QDict *rsp);
=20
 struct QmpSession {
+    QmpDispatchReturn *return_cb;
     QmpCommandList *cmds;
 };
=20
@@ -46,9 +48,11 @@ void qmp_register_command(QmpCommandList *cmds, const =
char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
 void qmp_unregister_command(QmpCommandList *cmds, const char *name);
 QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
-void qmp_session_init(QmpSession *session, QmpCommandList *cmds);
+void qmp_session_init(QmpSession *session,
+                      QmpCommandList *cmds, QmpDispatchReturn *return_cb=
);
+
 void qmp_session_destroy(QmpSession *session);
-QDict *qmp_dispatch(QmpSession *session, QDict *request);
+void qmp_dispatch(QmpSession *session, QDict *request);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
=20
diff --git a/monitor.c b/monitor.c
index b90f8566c8..93ecb03d04 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3900,23 +3900,6 @@ static int monitor_can_read(void *opaque)
     return !atomic_mb_read(&mon->suspend_cnt);
 }
=20
-/* take the ownership of rsp */
-static void monitor_qmp_respond(Monitor *mon, QDict *rsp)
-{
-    if (mon->qmp.session.cmds =3D=3D &qmp_cap_negotiation_commands) {
-        QDict *qdict =3D qdict_get_qdict(rsp, "error");
-        if (qdict
-            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
-                          QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOU=
ND))) {
-            /* Provide a more useful error message */
-            qdict_put_str(qdict, "desc", "Expecting capabilities"
-                          " negotiation with 'qmp_capabilities'");
-        }
-    }
-    monitor_json_emitter(mon, QOBJECT(rsp));
-    QDECREF(rsp);
-}
-
 struct QMPRequest {
     /* Owner of the request */
     Monitor *mon;
@@ -3927,6 +3910,24 @@ struct QMPRequest {
 };
 typedef struct QMPRequest QMPRequest;
=20
+static void dispatch_return_cb(QmpSession *session, QDict *rsp)
+{
+    Monitor *mon =3D container_of(session, Monitor, qmp.session);
+
+    if (mon->qmp.session.cmds =3D=3D &qmp_cap_negotiation_commands) {
+        QDict *qdict =3D qdict =3D qdict_get_qdict(rsp, "error");
+        if (qdict
+            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
+                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) =
{
+            /* Provide a more useful error message */
+            qdict_put_str(qdict, "desc", "Expecting capabilities negotia=
tion"
+                          " with 'qmp_capabilities'");
+        }
+    }
+
+    monitor_json_emitter(mon, QOBJECT(rsp));
+}
+
 /*
  * Dispatch one single QMP request. The function will free the req_obj
  * and objects inside it before return.
@@ -3934,7 +3935,7 @@ typedef struct QMPRequest QMPRequest;
 static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
 {
     Monitor *mon, *old_mon;
-    QDict *req, *rsp =3D NULL;
+    QDict *req;
=20
     req =3D req_obj->req;
     mon =3D req_obj->mon;
@@ -3950,16 +3951,9 @@ static void monitor_qmp_dispatch_one(QMPRequest *r=
eq_obj)
     old_mon =3D cur_mon;
     cur_mon =3D mon;
=20
-    rsp =3D qmp_dispatch(&mon->qmp.session, req);
+    qmp_dispatch(&mon->qmp.session, req);
=20
     cur_mon =3D old_mon;
-
-    /* Respond if necessary */
-    if (rsp) {
-        monitor_qmp_respond(mon, rsp);
-    }
-
-
     QDECREF(req);
 }
=20
@@ -4107,7 +4101,8 @@ err:
     qdict =3D qdict_new();
     qdict_put_obj(qdict, "error", qmp_build_error_object(err));
     error_free(err);
-    monitor_qmp_respond(mon, qdict);
+    monitor_json_emitter(mon, QOBJECT(qdict));
+    QDECREF(qdict);
     qobject_decref(req);
 }
=20
@@ -4223,7 +4218,8 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
=20
     switch (event) {
     case CHR_EVENT_OPENED:
-        qmp_session_init(&mon->qmp.session, &qmp_cap_negotiation_command=
s);
+        qmp_session_init(&mon->qmp.session,
+                         &qmp_cap_negotiation_commands, dispatch_return_=
cb);
         monitor_qmp_caps_reset(mon);
         data =3D get_qmp_greeting(mon);
         monitor_json_emitter(mon, data);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 7fd4e41b26..5274aa59cc 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -146,17 +146,27 @@ bool qmp_is_oob(const QDict *dict)
     return qbool_get_bool(bool_obj);
 }
=20
-void qmp_session_init(QmpSession *session, QmpCommandList *cmds)
+void qmp_session_init(QmpSession *session,
+                      QmpCommandList *cmds, QmpDispatchReturn *return_cb=
)
 {
+    assert(return_cb);
+    assert(!session->return_cb);
+
     session->cmds =3D cmds;
+    session->return_cb =3D return_cb;
 }
=20
 void qmp_session_destroy(QmpSession *session)
 {
+    if (!session->return_cb) {
+        return;
+    }
+
     session->cmds =3D NULL;
+    session->return_cb =3D NULL;
 }
=20
-QDict *qmp_dispatch(QmpSession *session, QDict *req)
+void qmp_dispatch(QmpSession *session, QDict *req)
 {
     Error *err =3D NULL;
     QObject *ret;
@@ -177,8 +187,9 @@ QDict *qmp_dispatch(QmpSession *session, QDict *req)
         qdict_put_obj(rsp, "return", ret);
     } else {
         QDECREF(rsp);
-        return NULL;
+        return;
     }
=20
-    return rsp;
+    session->return_cb(session, rsp);
+    QDECREF(rsp);
 }
diff --git a/qga/main.c b/qga/main.c
index b5d7cc9e8f..46349395ba 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -580,14 +580,22 @@ static int send_response(GAState *s, QObject *paylo=
ad)
     return 0;
 }
=20
+static void dispatch_return_cb(QmpSession *session, QDict *rsp)
+{
+    GAState *s =3D container_of(session, GAState, session);
+    int ret =3D send_response(s, QOBJECT(rsp));
+    if (ret < 0) {
+        g_warning("error sending response: %s", strerror(-ret));
+    }
+}
+
 /* handle requests/control events coming in over the channel */
 static void process_event(JSONMessageParser *parser, GQueue *tokens)
 {
     GAState *s =3D container_of(parser, GAState, parser);
     QObject *obj;
-    QDict *req, *rsp =3D NULL;
+    QDict *req;
     Error *err =3D NULL;
-    int ret;
=20
     g_assert(s && parser);
=20
@@ -604,19 +612,14 @@ static void process_event(JSONMessageParser *parser=
, GQueue *tokens)
     }
=20
     g_debug("processing command");
-    rsp =3D qmp_dispatch(&s->session, req);
+    qmp_dispatch(&s->session, req);
=20
 end:
     if (err) {
-        rsp =3D qdict_new();
+        QDict *rsp =3D qdict_new();
         qdict_put_obj(rsp, "error", qmp_build_error_object(err));
         error_free(err);
-    }
-    if (rsp) {
-        ret =3D send_response(s, QOBJECT(rsp));
-        if (ret < 0) {
-            g_warning("error sending error response: %s", strerror(-ret)=
);
-        }
+        dispatch_return_cb(&s->session, rsp);
         QDECREF(rsp);
     }
     qobject_decref(obj);
@@ -1305,7 +1308,7 @@ static int run_agent(GAState *s, GAConfig *config, =
int socket_activation)
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
     json_message_parser_init(&s->parser, process_event);
-    qmp_session_init(&s->session, &ga_commands);
+    qmp_session_init(&s->session, &ga_commands, dispatch_return_cb);
 #ifndef _WIN32
     if (!register_signal_handlers()) {
         g_critical("failed to register signal handlers");
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 0c1fecb281..5e6e75b133 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -93,85 +93,83 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_q=
emu_x_EnumList *a,
     return ret;
 }
=20
+static void dispatch_cmd_return(QmpSession *session, QDict *resp)
+{
+    assert(resp !=3D NULL);
+    assert(!qdict_haskey(resp, "error"));
+}
=20
 /* test commands with no input and no return value */
 static void test_dispatch_cmd(void)
 {
     QmpSession session =3D { 0, };
-    QDict *resp, *req =3D qdict_new();
+    QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands);
+    qmp_session_init(&session, &qmp_commands, dispatch_cmd_return);
     qdict_put_str(req, "execute", "user_def_cmd");
-
-    resp =3D qmp_dispatch(&session, req);
-    assert(resp !=3D NULL);
-    assert(!qdict_haskey(resp, "error"));
-
-    QDECREF(resp);
+    qmp_dispatch(&session, req);
     QDECREF(req);
     qmp_session_destroy(&session);
 }
=20
+static void dispatch_cmd_failure_return(QmpSession *session, QDict *resp=
)
+{
+    assert(resp !=3D NULL);
+    assert(qdict_haskey(resp, "error"));
+}
+
 /* test commands that return an error due to invalid parameters */
 static void test_dispatch_cmd_failure(void)
 {
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
-    QDict *resp, *args =3D qdict_new();
+    QDict *args =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands);
+    qmp_session_init(&session, &qmp_commands, dispatch_cmd_failure_retur=
n);
     qdict_put_str(req, "execute", "user_def_cmd2");
-
-    resp =3D qmp_dispatch(&session, req);
-    assert(resp !=3D NULL);
-    assert(qdict_haskey(resp, "error"));
-
-    QDECREF(resp);
+    qmp_dispatch(&session, req);
     QDECREF(req);
=20
     /* check that with extra arguments it throws an error */
     req =3D qdict_new();
     qdict_put_int(args, "a", 66);
     qdict_put(req, "arguments", args);
-
     qdict_put_str(req, "execute", "user_def_cmd");
-
-    resp =3D qmp_dispatch(&session, req);
-    assert(resp !=3D NULL);
-    assert(qdict_haskey(resp, "error"));
-
-    QDECREF(resp);
+    qmp_dispatch(&session, req);
     QDECREF(req);
     qmp_session_destroy(&session);
 }
=20
+static QObject *dispatch_ret;
+
 static void test_dispatch_cmd_success_response(void)
 {
     QmpSession session =3D { 0, };
-    QDict *resp, *req =3D qdict_new();
+    QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands);
+    qmp_session_init(&session, &qmp_commands, (QmpDispatchReturn *)abort=
);
     qdict_put_str(req, "execute", "cmd-success-response");
-    resp =3D qmp_dispatch(&session, req);
-    assert(resp =3D=3D NULL);
+    qmp_dispatch(&session, req);
     QDECREF(req);
     qmp_session_destroy(&session);
 }
=20
+static void dispatch_return(QmpSession *session, QDict *resp)
+{
+    assert(resp && !qdict_haskey(resp, "error"));
+    dispatch_ret =3D qdict_get(resp, "return");
+    qobject_incref(dispatch_ret);
+}
=20
 static QObject *test_qmp_dispatch(QDict *req)
 {
     QmpSession session =3D { 0, };
-    QDict *resp;
     QObject *ret;
=20
-    qmp_session_init(&session, &qmp_commands);
-    resp =3D qmp_dispatch(&session, req);
-    assert(resp && !qdict_haskey(resp, "error"));
-    ret =3D qdict_get(resp, "return");
-    assert(ret);
-    qobject_incref(ret);
-    QDECREF(resp);
+    qmp_session_init(&session, &qmp_commands, dispatch_return);
+    qmp_dispatch(&session, req);
+    ret =3D dispatch_ret;
+    dispatch_ret =3D NULL;
     qmp_session_destroy(&session);
     return ret;
 }
@@ -290,21 +288,21 @@ static void test_dealloc_partial(void)
     qapi_free_UserDefTwo(ud2);
 }
=20
+static void dispatch_return_id42(QmpSession *session, QDict *resp)
+{
+    assert(!qdict_haskey(resp, "error"));
+    assert(!strcmp(qdict_get_str(resp, "id"), "ID42"));
+}
+
 static void test_dispatch_cmd_id(void)
 {
     QmpSession session =3D { 0, };
-    QDict *resp, *req =3D qdict_new();
+    QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands);
+    qmp_session_init(&session, &qmp_commands, dispatch_return_id42);
     qdict_put_str(req, "execute", "user_def_cmd");
     qdict_put_str(req, "id", "ID42");
-
-    resp =3D qmp_dispatch(&session, req);
-    assert(resp !=3D NULL);
-    assert(!qdict_haskey(resp, "error"));
-    assert(!strcmp(qdict_get_str(resp, "id"), "ID42"));
-
-    QDECREF(resp);
+    qmp_dispatch(&session, req);
     QDECREF(req);
     qmp_session_destroy(&session);
 }
--=20
2.17.0.rc1.1.g4c4f2b46a3
