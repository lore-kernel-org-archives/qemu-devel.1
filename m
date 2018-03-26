Received: from eggs.gnu.org ([2001:4830:134:3::10]:55063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlF-0005hg-Mx
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlE-00031O-6v
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TlE-000312-1P
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:12 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:58 +0200
Message-Id: <20180326150916.9602-21-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 20/38] QmpSession: add json parser and use
 it in qga
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

Move JSON parser to QmpSession, and implement a simple handler to check
the parsed tokens and call qmp_dispatch(). This is enough for a simple
QMP client, like QGA.

The QEMU monitor has more complicated handling of dispatching which
will be adressed in following patch to benefit more common code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  9 ++++++++
 monitor.c                   |  7 ++-----
 qapi/qmp-dispatch.c         | 32 +++++++++++++++++++++++++++++
 qga/main.c                  | 41 +------------------------------------
 4 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 7bf0b6a437..cd425b8574 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -15,6 +15,7 @@
 #define QAPI_QMP_DISPATCH_H
=20
 #include "qemu/queue.h"
+#include "qapi/qmp/json-streamer.h"
=20
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
=20
@@ -40,6 +41,7 @@ typedef struct QmpSession QmpSession;
 typedef void (QmpDispatchReturn) (QmpSession *session, QDict *rsp);
=20
 struct QmpSession {
+    JSONMessageParser parser;
     QmpDispatchReturn *return_cb;
     QmpCommandList *cmds;
 };
@@ -48,9 +50,16 @@ void qmp_register_command(QmpCommandList *cmds, const =
char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
 void qmp_unregister_command(QmpCommandList *cmds, const char *name);
 QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
+
 void qmp_session_init(QmpSession *session,
                       QmpCommandList *cmds, QmpDispatchReturn *return_cb=
);
=20
+static inline void
+qmp_session_feed(QmpSession *session, const char *buf, size_t count)
+{
+    json_message_parser_feed(&session->parser, buf, count);
+}
+
 void qmp_session_destroy(QmpSession *session);
 void qmp_dispatch(QmpSession *session, QDict *request);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
diff --git a/monitor.c b/monitor.c
index 93ecb03d04..66046d4854 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3934,11 +3934,8 @@ static void dispatch_return_cb(QmpSession *session=
, QDict *rsp)
  */
 static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
 {
-    Monitor *mon, *old_mon;
-    QDict *req;
-
-    req =3D req_obj->req;
-    mon =3D req_obj->mon;
+    Monitor *old_mon, *mon =3D req_obj->mon;
+    QDict *req =3D req_obj->req;
=20
     g_free(req_obj);
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 5274aa59cc..5352b25e90 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -146,12 +146,43 @@ bool qmp_is_oob(const QDict *dict)
     return qbool_get_bool(bool_obj);
 }
=20
+static void qmp_json_parser_emit(JSONMessageParser *parser, GQueue *toke=
ns)
+{
+    QmpSession *session =3D container_of(parser, QmpSession, parser);
+    QObject *obj;
+    QDict *req;
+    Error *err =3D NULL;
+
+    obj =3D json_parser_parse_err(tokens, NULL, &err);
+    if (err) {
+        goto end;
+    }
+
+    req =3D qmp_dispatch_check_obj(obj, &err);
+    if (err) {
+        goto end;
+    }
+
+    qmp_dispatch(session, req);
+
+end:
+    if (err) {
+        QDict *rsp =3D qdict_new();
+        qdict_put_obj(rsp, "error", qmp_build_error_object(err));
+        error_free(err);
+        session->return_cb(session, rsp);
+        QDECREF(rsp);
+    }
+    qobject_decref(obj);
+}
+
 void qmp_session_init(QmpSession *session,
                       QmpCommandList *cmds, QmpDispatchReturn *return_cb=
)
 {
     assert(return_cb);
     assert(!session->return_cb);
=20
+    json_message_parser_init(&session->parser, qmp_json_parser_emit);
     session->cmds =3D cmds;
     session->return_cb =3D return_cb;
 }
@@ -164,6 +195,7 @@ void qmp_session_destroy(QmpSession *session)
=20
     session->cmds =3D NULL;
     session->return_cb =3D NULL;
+    json_message_parser_destroy(&session->parser);
 }
=20
 void qmp_dispatch(QmpSession *session, QDict *req)
diff --git a/qga/main.c b/qga/main.c
index 46349395ba..ce7efff3b4 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -72,7 +72,6 @@ typedef struct GAPersistentState {
=20
 struct GAState {
     QmpSession session;
-    JSONMessageParser parser;
     GMainLoop *main_loop;
     GAChannel *channel;
     bool virtio; /* fastpath to check for virtio to deal with poll() qui=
rks */
@@ -589,42 +588,6 @@ static void dispatch_return_cb(QmpSession *session, =
QDict *rsp)
     }
 }
=20
-/* handle requests/control events coming in over the channel */
-static void process_event(JSONMessageParser *parser, GQueue *tokens)
-{
-    GAState *s =3D container_of(parser, GAState, parser);
-    QObject *obj;
-    QDict *req;
-    Error *err =3D NULL;
-
-    g_assert(s && parser);
-
-    g_debug("process_event: called");
-
-    obj =3D json_parser_parse_err(tokens, NULL, &err);
-    if (err) {
-        goto end;
-    }
-
-    req =3D qmp_dispatch_check_obj(obj, &err);
-    if (err) {
-        goto end;
-    }
-
-    g_debug("processing command");
-    qmp_dispatch(&s->session, req);
-
-end:
-    if (err) {
-        QDict *rsp =3D qdict_new();
-        qdict_put_obj(rsp, "error", qmp_build_error_object(err));
-        error_free(err);
-        dispatch_return_cb(&s->session, rsp);
-        QDECREF(rsp);
-    }
-    qobject_decref(obj);
-}
-
 /* false return signals GAChannel to close the current client connection=
 */
 static gboolean channel_event_cb(GIOCondition condition, gpointer data)
 {
@@ -639,7 +602,7 @@ static gboolean channel_event_cb(GIOCondition conditi=
on, gpointer data)
     case G_IO_STATUS_NORMAL:
         buf[count] =3D 0;
         g_debug("read data, count: %d, data: %s", (int)count, buf);
-        json_message_parser_feed(&s->parser, (char *)buf, (int)count);
+        qmp_session_feed(&s->session, buf, count);
         break;
     case G_IO_STATUS_EOF:
         g_debug("received EOF");
@@ -1307,7 +1270,6 @@ static int run_agent(GAState *s, GAConfig *config, =
int socket_activation)
     s->command_state =3D ga_command_state_new();
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
-    json_message_parser_init(&s->parser, process_event);
     qmp_session_init(&s->session, &ga_commands, dispatch_return_cb);
 #ifndef _WIN32
     if (!register_signal_handlers()) {
@@ -1431,7 +1393,6 @@ end:
         qmp_session_destroy(&s->session);
         ga_command_state_cleanup_all(s->command_state);
         ga_command_state_free(s->command_state);
-        json_message_parser_destroy(&s->parser);
     }
     if (s->channel) {
         ga_channel_free(s->channel);
--=20
2.17.0.rc1.1.g4c4f2b46a3
