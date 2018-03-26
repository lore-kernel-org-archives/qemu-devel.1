Received: from eggs.gnu.org ([2001:4830:134:3::10]:55039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlC-0005er-J9
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlB-0002zY-1Y
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TlA-0002zK-Rj
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:08 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:56 +0200
Message-Id: <20180326150916.9602-19-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 18/38] qmp: add QmpSession
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

This structure will hold various data related to a QMP session: the
list of commands, the parser, the callbacks, the pending operations
etc...

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 10 +++++++++-
 monitor.c                   | 20 +++++++++++---------
 qapi/qmp-dispatch.c         | 14 ++++++++++++--
 qga/main.c                  |  6 ++++--
 tests/test-qmp-cmds.c       | 28 ++++++++++++++++++++++------
 5 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 79fe7f18e0..10ba0745c7 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -36,11 +36,19 @@ typedef struct QmpCommand
=20
 typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpCommandList;
=20
+typedef struct QmpSession QmpSession;
+
+struct QmpSession {
+    QmpCommandList *cmds;
+};
+
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
 void qmp_unregister_command(QmpCommandList *cmds, const char *name);
 QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
-QDict *qmp_dispatch(QmpCommandList *cmds, QDict *request);
+void qmp_session_init(QmpSession *session, QmpCommandList *cmds);
+void qmp_session_destroy(QmpSession *session);
+QDict *qmp_dispatch(QmpSession *session, QDict *request);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
=20
diff --git a/monitor.c b/monitor.c
index ddcc3a5748..b90f8566c8 100644
--- a/monitor.c
+++ b/monitor.c
@@ -171,7 +171,7 @@ typedef struct {
      * When command qmp_capabilities succeeds, we go into command
      * mode.
      */
-    QmpCommandList *commands;
+    QmpSession session;
     bool qmp_caps[QMP_CAPABILITY__MAX];
     /*
      * Protects qmp request/response queue.  Please take monitor_lock
@@ -454,7 +454,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, =
QDict *qdict)
     trace_monitor_protocol_event_emit(event, qdict);
     QTAILQ_FOREACH(mon, &mon_list, entry) {
         if (monitor_is_qmp(mon)
-            && mon->qmp.commands !=3D &qmp_cap_negotiation_commands) {
+            && mon->qmp.session.cmds !=3D &qmp_cap_negotiation_commands)=
 {
             monitor_json_emitter(mon, QOBJECT(qdict));
         }
     }
@@ -624,6 +624,7 @@ static void monitor_data_destroy(Monitor *mon)
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
+        qmp_session_destroy(&mon->qmp.session);
         json_message_parser_destroy(&mon->qmp.parser);
     }
     readline_free(mon->rs);
@@ -961,7 +962,7 @@ CommandInfoList *qmp_query_commands(Error **errp)
 {
     CommandInfoList *list =3D NULL;
=20
-    qmp_for_each_command(cur_mon->qmp.commands, query_commands_cb, &list=
);
+    qmp_for_each_command(cur_mon->qmp.session.cmds, query_commands_cb, &=
list);
=20
     return list;
 }
@@ -1129,7 +1130,7 @@ static bool qmp_cmd_oob_check(Monitor *mon, QDict *=
req, Error **errp)
         return false;
     }
=20
-    cmd =3D qmp_find_command(mon->qmp.commands, command);
+    cmd =3D qmp_find_command(mon->qmp.session.cmds, command);
     if (!cmd) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "The command %s has not been found", command);
@@ -1157,7 +1158,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapab=
ilityList *enable,
 {
     Error *local_err =3D NULL;
=20
-    if (cur_mon->qmp.commands =3D=3D &qmp_commands) {
+    if (cur_mon->qmp.session.cmds =3D=3D &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "Capabilities negotiation is already complete, command=
 "
                   "ignored");
@@ -1179,7 +1180,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapab=
ilityList *enable,
         qmp_caps_apply(cur_mon, enable);
     }
=20
-    cur_mon->qmp.commands =3D &qmp_commands;
+    cur_mon->qmp.session.cmds =3D &qmp_commands;
 }
=20
 /* set the current CPU defined by the user */
@@ -3902,7 +3903,7 @@ static int monitor_can_read(void *opaque)
 /* take the ownership of rsp */
 static void monitor_qmp_respond(Monitor *mon, QDict *rsp)
 {
-    if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
+    if (mon->qmp.session.cmds =3D=3D &qmp_cap_negotiation_commands) {
         QDict *qdict =3D qdict_get_qdict(rsp, "error");
         if (qdict
             && !g_strcmp0(qdict_get_try_str(qdict, "class"),
@@ -3949,7 +3950,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
     old_mon =3D cur_mon;
     cur_mon =3D mon;
=20
-    rsp =3D qmp_dispatch(mon->qmp.commands, req);
+    rsp =3D qmp_dispatch(&mon->qmp.session, req);
=20
     cur_mon =3D old_mon;
=20
@@ -4222,7 +4223,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
=20
     switch (event) {
     case CHR_EVENT_OPENED:
-        mon->qmp.commands =3D &qmp_cap_negotiation_commands;
+        qmp_session_init(&mon->qmp.session, &qmp_cap_negotiation_command=
s);
         monitor_qmp_caps_reset(mon);
         data =3D get_qmp_greeting(mon);
         monitor_json_emitter(mon, data);
@@ -4230,6 +4231,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
         mon_refcount++;
         break;
     case CHR_EVENT_CLOSED:
+        qmp_session_destroy(&mon->qmp.session);
         json_message_parser_destroy(&mon->qmp.parser);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
         mon_refcount--;
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index e8a14eb845..7fd4e41b26 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -146,14 +146,24 @@ bool qmp_is_oob(const QDict *dict)
     return qbool_get_bool(bool_obj);
 }
=20
-QDict *qmp_dispatch(QmpCommandList *cmds, QDict *req)
+void qmp_session_init(QmpSession *session, QmpCommandList *cmds)
+{
+    session->cmds =3D cmds;
+}
+
+void qmp_session_destroy(QmpSession *session)
+{
+    session->cmds =3D NULL;
+}
+
+QDict *qmp_dispatch(QmpSession *session, QDict *req)
 {
     Error *err =3D NULL;
     QObject *ret;
     QDict *rsp;
     QObject *id =3D qdict_get(req, "id");
=20
-    ret =3D do_qmp_dispatch(cmds, req, &err);
+    ret =3D do_qmp_dispatch(session->cmds, req, &err);
=20
     rsp =3D qdict_new();
     if (id) {
diff --git a/qga/main.c b/qga/main.c
index 04f7dad0b3..b5d7cc9e8f 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -71,6 +71,7 @@ typedef struct GAPersistentState {
 } GAPersistentState;
=20
 struct GAState {
+    QmpSession session;
     JSONMessageParser parser;
     GMainLoop *main_loop;
     GAChannel *channel;
@@ -603,7 +604,7 @@ static void process_event(JSONMessageParser *parser, =
GQueue *tokens)
     }
=20
     g_debug("processing command");
-    rsp =3D qmp_dispatch(&ga_commands, req);
+    rsp =3D qmp_dispatch(&s->session, req);
=20
 end:
     if (err) {
@@ -1304,7 +1305,7 @@ static int run_agent(GAState *s, GAConfig *config, =
int socket_activation)
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
     json_message_parser_init(&s->parser, process_event);
-
+    qmp_session_init(&s->session, &ga_commands);
 #ifndef _WIN32
     if (!register_signal_handlers()) {
         g_critical("failed to register signal handlers");
@@ -1424,6 +1425,7 @@ int main(int argc, char **argv)
=20
 end:
     if (s->command_state) {
+        qmp_session_destroy(&s->session);
         ga_command_state_cleanup_all(s->command_state);
         ga_command_state_free(s->command_state);
         json_message_parser_destroy(&s->parser);
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 58d948b01f..0c1fecb281 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -97,27 +97,32 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_q=
emu_x_EnumList *a,
 /* test commands with no input and no return value */
 static void test_dispatch_cmd(void)
 {
+    QmpSession session =3D { 0, };
     QDict *resp, *req =3D qdict_new();
=20
+    qmp_session_init(&session, &qmp_commands);
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    resp =3D qmp_dispatch(&qmp_commands, req);
+    resp =3D qmp_dispatch(&session, req);
     assert(resp !=3D NULL);
     assert(!qdict_haskey(resp, "error"));
=20
     QDECREF(resp);
     QDECREF(req);
+    qmp_session_destroy(&session);
 }
=20
 /* test commands that return an error due to invalid parameters */
 static void test_dispatch_cmd_failure(void)
 {
+    QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
     QDict *resp, *args =3D qdict_new();
=20
+    qmp_session_init(&session, &qmp_commands);
     qdict_put_str(req, "execute", "user_def_cmd2");
=20
-    resp =3D qmp_dispatch(&qmp_commands, req);
+    resp =3D qmp_dispatch(&session, req);
     assert(resp !=3D NULL);
     assert(qdict_haskey(resp, "error"));
=20
@@ -131,35 +136,43 @@ static void test_dispatch_cmd_failure(void)
=20
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    resp =3D qmp_dispatch(&qmp_commands, req);
+    resp =3D qmp_dispatch(&session, req);
     assert(resp !=3D NULL);
     assert(qdict_haskey(resp, "error"));
=20
     QDECREF(resp);
     QDECREF(req);
+    qmp_session_destroy(&session);
 }
=20
 static void test_dispatch_cmd_success_response(void)
 {
+    QmpSession session =3D { 0, };
     QDict *resp, *req =3D qdict_new();
=20
+    qmp_session_init(&session, &qmp_commands);
     qdict_put_str(req, "execute", "cmd-success-response");
-    resp =3D qmp_dispatch(&qmp_commands, req);
+    resp =3D qmp_dispatch(&session, req);
     assert(resp =3D=3D NULL);
     QDECREF(req);
+    qmp_session_destroy(&session);
 }
=20
+
 static QObject *test_qmp_dispatch(QDict *req)
 {
+    QmpSession session =3D { 0, };
     QDict *resp;
     QObject *ret;
=20
-    resp =3D qmp_dispatch(&qmp_commands, req);
+    qmp_session_init(&session, &qmp_commands);
+    resp =3D qmp_dispatch(&session, req);
     assert(resp && !qdict_haskey(resp, "error"));
     ret =3D qdict_get(resp, "return");
     assert(ret);
     qobject_incref(ret);
     QDECREF(resp);
+    qmp_session_destroy(&session);
     return ret;
 }
=20
@@ -279,18 +292,21 @@ static void test_dealloc_partial(void)
=20
 static void test_dispatch_cmd_id(void)
 {
+    QmpSession session =3D { 0, };
     QDict *resp, *req =3D qdict_new();
=20
+    qmp_session_init(&session, &qmp_commands);
     qdict_put_str(req, "execute", "user_def_cmd");
     qdict_put_str(req, "id", "ID42");
=20
-    resp =3D qmp_dispatch(&qmp_commands, req);
+    resp =3D qmp_dispatch(&session, req);
     assert(resp !=3D NULL);
     assert(!qdict_haskey(resp, "error"));
     assert(!strcmp(qdict_get_str(resp, "id"), "ID42"));
=20
     QDECREF(resp);
     QDECREF(req);
+    qmp_session_destroy(&session);
 }
=20
=20
--=20
2.17.0.rc1.1.g4c4f2b46a3
