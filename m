Received: from eggs.gnu.org ([2001:4830:134:3::10]:55107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlM-0005ps-7w
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlF-000329-Qe
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TlF-00031t-Lj
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:13 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:59 +0200
Message-Id: <20180326150916.9602-22-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 21/38] QmpSession: add a dispatch callback
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

In order to accomodate for QEMU monitor needs, allow to customize
dispatching after JSON parsing. The default (for QGA and tests) can be
simply qmp_dispatch().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  6 +++++-
 monitor.c                   |  4 +++-
 qapi/qmp-dispatch.c         |  8 ++++++--
 qga/main.c                  |  2 +-
 tests/test-qmp-cmds.c       | 12 +++++++-----
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index cd425b8574..5329d0052a 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -38,10 +38,12 @@ typedef struct QmpCommand
 typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpCommandList;
=20
 typedef struct QmpSession QmpSession;
+typedef void (QmpDispatch) (QmpSession *session, QDict *request);
 typedef void (QmpDispatchReturn) (QmpSession *session, QDict *rsp);
=20
 struct QmpSession {
     JSONMessageParser parser;
+    QmpDispatch *dispatch_cb;
     QmpDispatchReturn *return_cb;
     QmpCommandList *cmds;
 };
@@ -52,7 +54,9 @@ void qmp_unregister_command(QmpCommandList *cmds, const=
 char *name);
 QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
=20
 void qmp_session_init(QmpSession *session,
-                      QmpCommandList *cmds, QmpDispatchReturn *return_cb=
);
+                     QmpCommandList *cmds,
+                     QmpDispatch *dispatch_cb,
+                     QmpDispatchReturn *return_cb);
=20
 static inline void
 qmp_session_feed(QmpSession *session, const char *buf, size_t count)
diff --git a/monitor.c b/monitor.c
index 66046d4854..ae8c055df0 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4216,7 +4216,9 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
     switch (event) {
     case CHR_EVENT_OPENED:
         qmp_session_init(&mon->qmp.session,
-                         &qmp_cap_negotiation_commands, dispatch_return_=
cb);
+                         &qmp_cap_negotiation_commands,
+                         NULL, /* XXX: not in use yet, but in following =
patch */
+                         dispatch_return_cb);
         monitor_qmp_caps_reset(mon);
         data =3D get_qmp_greeting(mon);
         monitor_json_emitter(mon, data);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 5352b25e90..53d099d303 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -163,7 +163,7 @@ static void qmp_json_parser_emit(JSONMessageParser *p=
arser, GQueue *tokens)
         goto end;
     }
=20
-    qmp_dispatch(session, req);
+    session->dispatch_cb(session, req);
=20
 end:
     if (err) {
@@ -177,13 +177,16 @@ end:
 }
=20
 void qmp_session_init(QmpSession *session,
-                      QmpCommandList *cmds, QmpDispatchReturn *return_cb=
)
+                      QmpCommandList *cmds,
+                      QmpDispatch *dispatch_cb,
+                      QmpDispatchReturn *return_cb)
 {
     assert(return_cb);
     assert(!session->return_cb);
=20
     json_message_parser_init(&session->parser, qmp_json_parser_emit);
     session->cmds =3D cmds;
+    session->dispatch_cb =3D dispatch_cb;
     session->return_cb =3D return_cb;
 }
=20
@@ -194,6 +197,7 @@ void qmp_session_destroy(QmpSession *session)
     }
=20
     session->cmds =3D NULL;
+    session->dispatch_cb =3D NULL;
     session->return_cb =3D NULL;
     json_message_parser_destroy(&session->parser);
 }
diff --git a/qga/main.c b/qga/main.c
index ce7efff3b4..dbb8f2cbbe 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1270,7 +1270,7 @@ static int run_agent(GAState *s, GAConfig *config, =
int socket_activation)
     s->command_state =3D ga_command_state_new();
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
-    qmp_session_init(&s->session, &ga_commands, dispatch_return_cb);
+    qmp_session_init(&s->session, &ga_commands, qmp_dispatch, dispatch_r=
eturn_cb);
 #ifndef _WIN32
     if (!register_signal_handlers()) {
         g_critical("failed to register signal handlers");
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 5e6e75b133..5246650f71 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -105,7 +105,7 @@ static void test_dispatch_cmd(void)
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_cmd_return);
+    qmp_session_init(&session, &qmp_commands, qmp_dispatch, dispatch_cmd=
_return);
     qdict_put_str(req, "execute", "user_def_cmd");
     qmp_dispatch(&session, req);
     QDECREF(req);
@@ -125,7 +125,8 @@ static void test_dispatch_cmd_failure(void)
     QDict *req =3D qdict_new();
     QDict *args =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_cmd_failure_retur=
n);
+    qmp_session_init(&session, &qmp_commands, qmp_dispatch,
+                     dispatch_cmd_failure_return);
     qdict_put_str(req, "execute", "user_def_cmd2");
     qmp_dispatch(&session, req);
     QDECREF(req);
@@ -147,7 +148,8 @@ static void test_dispatch_cmd_success_response(void)
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, (QmpDispatchReturn *)abort=
);
+    qmp_session_init(&session, &qmp_commands, qmp_dispatch,
+                     (QmpDispatchReturn *)abort);
     qdict_put_str(req, "execute", "cmd-success-response");
     qmp_dispatch(&session, req);
     QDECREF(req);
@@ -166,7 +168,7 @@ static QObject *test_qmp_dispatch(QDict *req)
     QmpSession session =3D { 0, };
     QObject *ret;
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_return);
+    qmp_session_init(&session, &qmp_commands, qmp_dispatch, dispatch_ret=
urn);
     qmp_dispatch(&session, req);
     ret =3D dispatch_ret;
     dispatch_ret =3D NULL;
@@ -299,7 +301,7 @@ static void test_dispatch_cmd_id(void)
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_return_id42);
+    qmp_session_init(&session, &qmp_commands, qmp_dispatch, dispatch_ret=
urn_id42);
     qdict_put_str(req, "execute", "user_def_cmd");
     qdict_put_str(req, "id", "ID42");
     qmp_dispatch(&session, req);
--=20
2.17.0.rc1.1.g4c4f2b46a3
