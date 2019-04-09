Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE40C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1336F2133D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1336F2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45651 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtMU-0003l2-6d
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:12:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtKa-000250-J9
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtKZ-0004V6-1l
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtKY-0004UY-Mg
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9E8130D8DA2;
	Tue,  9 Apr 2019 16:10:37 +0000 (UTC)
Received: from localhost (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 74C8C1A917;
	Tue,  9 Apr 2019 16:10:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:09:52 +0200
Message-Id: <20190409161009.6322-4-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 09 Apr 2019 16:10:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 03/20] qmp: add QmpSession
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409160952.v_Hjw8kKtSE8mGUH35SZg13gCZOR0EBj13oLCX5k1Pk@z>

This structure will hold various data related to a QMP client session:
the list of commands, the parser, the callbacks, the pending
operations...

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 10 +++++++++-
 monitor.c                   | 18 ++++++++++--------
 qapi/qmp-dispatch.c         | 15 ++++++++++++---
 qga/main.c                  |  5 ++++-
 tests/test-qmp-cmds.c       | 28 ++++++++++++++++++++++------
 5 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 5a9cf82472..3b53cfd788 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -37,10 +37,18 @@ typedef struct QmpCommand
=20
 typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpCommandList;
=20
+typedef struct QmpSession QmpSession;
+
+struct QmpSession {
+    const QmpCommandList *cmds;
+};
+
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
 const QmpCommand *qmp_find_command(const QmpCommandList *cmds,
                                    const char *name);
+void qmp_session_init(QmpSession *session, const QmpCommandList *cmds);
+void qmp_session_destroy(QmpSession *session);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
=20
@@ -48,7 +56,7 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QDict *qmp_error_response(Error *err);
-QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
+QDict *qmp_dispatch(QmpSession *session, QObject *request,
                     bool allow_oob);
 bool qmp_is_oob(const QDict *dict);
=20
diff --git a/monitor.c b/monitor.c
index abc5bdc4ba..a07175b4f8 100644
--- a/monitor.c
+++ b/monitor.c
@@ -174,7 +174,7 @@ typedef struct {
      * qmp_capabilities succeeds, we go into command mode, and
      * @command becomes &qmp_commands.
      */
-    const QmpCommandList *commands;
+    QmpSession session;
     bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
     bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
     /*
@@ -520,7 +520,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, =
QDict *qdict)
     trace_monitor_protocol_event_emit(event, qdict);
     QTAILQ_FOREACH(mon, &mon_list, entry) {
         if (monitor_is_qmp(mon)
-            && mon->qmp.commands !=3D &qmp_cap_negotiation_commands) {
+            && mon->qmp.session.cmds !=3D &qmp_cap_negotiation_commands)=
 {
             qmp_send_response(mon, qdict);
         }
     }
@@ -729,6 +729,7 @@ static void monitor_data_destroy(Monitor *mon)
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
+        qmp_session_destroy(&mon->qmp.session);
         json_message_parser_destroy(&mon->qmp.parser);
     }
     readline_free(mon->rs);
@@ -1090,7 +1091,7 @@ CommandInfoList *qmp_query_commands(Error **errp)
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
@@ -1207,7 +1208,7 @@ static bool qmp_caps_accept(Monitor *mon, QMPCapabi=
lityList *list,
 void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
                           Error **errp)
 {
-    if (cur_mon->qmp.commands =3D=3D &qmp_commands) {
+    if (cur_mon->qmp.session.cmds =3D=3D &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "Capabilities negotiation is already complete, command=
 "
                   "ignored");
@@ -1218,7 +1219,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapab=
ilityList *enable,
         return;
     }
=20
-    cur_mon->qmp.commands =3D &qmp_commands;
+    cur_mon->qmp.session.cmds =3D &qmp_commands;
 }
=20
 /* Set the current CPU defined by the user. Callers must hold BQL. */
@@ -4121,11 +4122,11 @@ static void monitor_qmp_dispatch(Monitor *mon, QO=
bject *req)
     old_mon =3D cur_mon;
     cur_mon =3D mon;
=20
-    rsp =3D qmp_dispatch(mon->qmp.commands, req, qmp_oob_enabled(mon));
+    rsp =3D qmp_dispatch(&mon->qmp.session, req, qmp_oob_enabled(mon));
=20
     cur_mon =3D old_mon;
=20
-    if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
+    if (mon->qmp.session.cmds =3D=3D &qmp_cap_negotiation_commands) {
         error =3D qdict_get_qdict(rsp, "error");
         if (error
             && !g_strcmp0(qdict_get_try_str(error, "class"),
@@ -4399,7 +4400,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
=20
     switch (event) {
     case CHR_EVENT_OPENED:
-        mon->qmp.commands =3D &qmp_cap_negotiation_commands;
+        qmp_session_init(&mon->qmp.session, &qmp_cap_negotiation_command=
s);
         monitor_qmp_caps_reset(mon);
         data =3D qmp_greeting(mon);
         qmp_send_response(mon, data);
@@ -4414,6 +4415,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
          * is closed.
          */
         monitor_qmp_cleanup_queues(mon);
+        qmp_session_destroy(&mon->qmp.session);
         json_message_parser_destroy(&mon->qmp.parser);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
                                  mon, NULL);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index f9d43046aa..98a82ac33c 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -163,15 +163,24 @@ bool qmp_is_oob(const QDict *dict)
         && !qdict_haskey(dict, "execute");
 }
=20
-QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
-                    bool allow_oob)
+void qmp_session_init(QmpSession *session, const QmpCommandList *cmds)
+{
+    session->cmds =3D cmds;
+}
+
+void qmp_session_destroy(QmpSession *session)
+{
+    session->cmds =3D NULL;
+}
+
+QDict *qmp_dispatch(QmpSession *session, QObject *request, bool allow_oo=
b)
 {
     Error *err =3D NULL;
     QDict *dict =3D qobject_to(QDict, request);
     QObject *ret, *id =3D dict ? qdict_get(dict, "id") : NULL;
     QDict *rsp;
=20
-    ret =3D do_qmp_dispatch(cmds, request, allow_oob, &err);
+    ret =3D do_qmp_dispatch(session->cmds, request, allow_oob, &err);
     if (err) {
         rsp =3D qmp_error_response(err);
     } else if (ret) {
diff --git a/qga/main.c b/qga/main.c
index 5b144b9250..bf0082df90 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -74,6 +74,7 @@ typedef struct GAPersistentState {
 typedef struct GAConfig GAConfig;
=20
 struct GAState {
+    QmpSession session;
     JSONMessageParser parser;
     GMainLoop *main_loop;
     GAChannel *channel;
@@ -572,7 +573,7 @@ static void process_event(void *opaque, QObject *obj,=
 Error *err)
     }
=20
     g_debug("processing command");
-    rsp =3D qmp_dispatch(&ga_commands, obj, false);
+    rsp =3D qmp_dispatch(&s->session, obj, false);
=20
 end:
     ret =3D send_response(s, rsp);
@@ -1338,6 +1339,7 @@ static GAState *initialize_agent(GAConfig *config, =
int socket_activation)
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
     json_message_parser_init(&s->parser, process_event, s, NULL);
+    qmp_session_init(&s->session, &ga_commands);
=20
 #ifndef _WIN32
     if (!register_signal_handlers()) {
@@ -1369,6 +1371,7 @@ static void cleanup_agent(GAState *s)
     CloseHandle(s->wakeup_event);
 #endif
     if (s->command_state) {
+        qmp_session_destroy(&s->session);
         ga_command_state_cleanup_all(s->command_state);
         ga_command_state_free(s->command_state);
         json_message_parser_destroy(&s->parser);
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 630b1b9bac..7c39ec1657 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -113,44 +113,52 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org=
_qemu_x_EnumList *a,
 /* test commands with no input and no return value */
 static void test_dispatch_cmd(void)
 {
+    QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
     QDict *resp;
=20
+    qmp_session_init(&session, &qmp_commands);
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
+    resp =3D qmp_dispatch(&session, QOBJECT(req), false);
     assert(resp !=3D NULL);
     assert(!qdict_haskey(resp, "error"));
=20
     qobject_unref(resp);
     qobject_unref(req);
+    qmp_session_destroy(&session);
 }
=20
 static void test_dispatch_cmd_oob(void)
 {
+    QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
     QDict *resp;
=20
+    qmp_session_init(&session, &qmp_commands);
     qdict_put_str(req, "exec-oob", "test-flags-command");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), true);
+    resp =3D qmp_dispatch(&session, QOBJECT(req), true);
     assert(resp !=3D NULL);
     assert(!qdict_haskey(resp, "error"));
=20
     qobject_unref(resp);
     qobject_unref(req);
+    qmp_session_destroy(&session);
 }
=20
 /* test commands that return an error due to invalid parameters */
 static void test_dispatch_cmd_failure(void)
 {
+    QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
     QDict *args =3D qdict_new();
     QDict *resp;
=20
+    qmp_session_init(&session, &qmp_commands);
     qdict_put_str(req, "execute", "user_def_cmd2");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
+    resp =3D qmp_dispatch(&session, QOBJECT(req), false);
     assert(resp !=3D NULL);
     assert(qdict_haskey(resp, "error"));
=20
@@ -164,36 +172,44 @@ static void test_dispatch_cmd_failure(void)
=20
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
+    resp =3D qmp_dispatch(&session, QOBJECT(req), false);
     assert(resp !=3D NULL);
     assert(qdict_haskey(resp, "error"));
=20
     qobject_unref(resp);
     qobject_unref(req);
+    qmp_session_destroy(&session);
 }
=20
 static void test_dispatch_cmd_success_response(void)
 {
+    QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
     QDict *resp;
=20
+    qmp_session_init(&session, &qmp_commands);
     qdict_put_str(req, "execute", "cmd-success-response");
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
+    resp =3D qmp_dispatch(&session, QOBJECT(req), false);
     g_assert_null(resp);
     qobject_unref(req);
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
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
+    qmp_session_init(&session, &qmp_commands);
+    resp =3D qmp_dispatch(&session, QOBJECT(req), false);
     assert(resp && !qdict_haskey(resp, "error"));
     ret =3D qdict_get(resp, "return");
     assert(ret);
     qobject_ref(ret);
     qobject_unref(resp);
+    qmp_session_destroy(&session);
     return ret;
 }
=20
--=20
2.21.0.196.g041f5ea1cf


