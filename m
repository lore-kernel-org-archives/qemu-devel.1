Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543ECFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F811215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQY/xJ+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F811215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5t4-0002VN-Il
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5mG-0002wP-IV
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5mE-0003Za-ID
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39309
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5mE-0003ZJ-DS
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDyzyp9lszBVzhOgIQ8TOZ58QA1kDkQfY7FbGxmBrS0=;
 b=HQY/xJ+26apn4ZTKVIW6xCijrCS8cg78HN16RagXo1By7hF+d48290COPNidOw6NdVPDdY
 k5Hot2k6yz1drcNoasz1br4PnTmqhUMbFA+SLedm41PfhNYNWl5TV9MUVB4uemYyGVOoTW
 kdFOkTiPT+PD7EGg/5+VIXShDwHsHMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-u12A6TUTMCqvp7LGicK1aQ-1; Fri, 08 Nov 2019 10:02:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0056180496F
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:02:15 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F5296084E;
 Fri,  8 Nov 2019 15:02:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/25] qmp: add QmpSession
Date: Fri,  8 Nov 2019 19:01:01 +0400
Message-Id: <20191108150123.12213-4-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: u12A6TUTMCqvp7LGicK1aQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This structure will hold various data related to a QMP client session:
the list of commands, the parser, the callbacks, the pending
operations...

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 10 +++++++++-
 monitor/misc.c              |  6 +++---
 monitor/monitor-internal.h  |  2 +-
 monitor/monitor.c           |  2 +-
 monitor/qmp.c               |  8 +++++---
 qapi/qmp-dispatch.c         | 15 ++++++++++++---
 qga/main.c                  |  5 ++++-
 tests/test-qmp-cmds.c       | 28 ++++++++++++++++++++++------
 8 files changed, 57 insertions(+), 19 deletions(-)

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
                           QmpCommandFunc *fn, QmpCommandOptions options);
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
diff --git a/monitor/misc.c b/monitor/misc.c
index 3052bfe8f1..bb33ca73cf 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -253,7 +253,7 @@ CommandInfoList *qmp_query_commands(Error **errp)
     assert(monitor_is_qmp(cur_mon));
     mon =3D container_of(cur_mon, MonitorQMP, common);
=20
-    qmp_for_each_command(mon->commands, query_commands_cb, &list);
+    qmp_for_each_command(mon->session.cmds, query_commands_cb, &list);
=20
     return list;
 }
@@ -363,7 +363,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilit=
yList *enable,
     assert(monitor_is_qmp(cur_mon));
     mon =3D container_of(cur_mon, MonitorQMP, common);
=20
-    if (mon->commands =3D=3D &qmp_commands) {
+    if (mon->session.cmds =3D=3D &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "Capabilities negotiation is already complete, command "
                   "ignored");
@@ -374,7 +374,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilit=
yList *enable,
         return;
     }
=20
-    mon->commands =3D &qmp_commands;
+    mon->session.cmds =3D &qmp_commands;
 }
=20
 /* Set the current CPU defined by the user. Callers must hold BQL. */
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 3e7dac5910..b15266e77b 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -132,7 +132,7 @@ typedef struct {
      * qmp_capabilities succeeds, we go into command mode, and
      * @command becomes &qmp_commands.
      */
-    const QmpCommandList *commands;
+    QmpSession session;
     bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
     bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
     /*
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 12898b6448..ecf21d9786 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -263,7 +263,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, QD=
ict *qdict)
         }
=20
         qmp_mon =3D container_of(mon, MonitorQMP, common);
-        if (qmp_mon->commands !=3D &qmp_cap_negotiation_commands) {
+        if (qmp_mon->session.cmds !=3D &qmp_cap_negotiation_commands) {
             qmp_send_response(qmp_mon, qdict);
         }
     }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 9d9e5d8b27..24ccdeb4a4 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -117,11 +117,11 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QOb=
ject *req)
     old_mon =3D cur_mon;
     cur_mon =3D &mon->common;
=20
-    rsp =3D qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
+    rsp =3D qmp_dispatch(&mon->session, req, qmp_oob_enabled(mon));
=20
     cur_mon =3D old_mon;
=20
-    if (mon->commands =3D=3D &qmp_cap_negotiation_commands) {
+    if (mon->session.cmds =3D=3D &qmp_cap_negotiation_commands) {
         error =3D qdict_get_qdict(rsp, "error");
         if (error
             && !g_strcmp0(qdict_get_try_str(error, "class"),
@@ -318,7 +318,7 @@ static void monitor_qmp_event(void *opaque, int event)
=20
     switch (event) {
     case CHR_EVENT_OPENED:
-        mon->commands =3D &qmp_cap_negotiation_commands;
+        qmp_session_init(&mon->session, &qmp_cap_negotiation_commands);
         monitor_qmp_caps_reset(mon);
         data =3D qmp_greeting(mon);
         qmp_send_response(mon, data);
@@ -333,6 +333,7 @@ static void monitor_qmp_event(void *opaque, int event)
          * is closed.
          */
         monitor_qmp_cleanup_queues(mon);
+        qmp_session_destroy(&mon->session);
         json_message_parser_destroy(&mon->parser);
         json_message_parser_init(&mon->parser, handle_qmp_command,
                                  mon, NULL);
@@ -344,6 +345,7 @@ static void monitor_qmp_event(void *opaque, int event)
=20
 void monitor_data_destroy_qmp(MonitorQMP *mon)
 {
+    qmp_session_destroy(&mon->session);
     json_message_parser_destroy(&mon->parser);
     qemu_mutex_destroy(&mon->qmp_queue_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 857399c5fe..0e6b003dd8 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -164,15 +164,24 @@ bool qmp_is_oob(const QDict *dict)
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
+QDict *qmp_dispatch(QmpSession *session, QObject *request, bool allow_oob)
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
index f23614528e..61190db5f3 100644
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
@@ -572,7 +573,7 @@ static void process_event(void *opaque, QObject *obj, E=
rror *err)
     }
=20
     g_debug("processing command");
-    rsp =3D qmp_dispatch(&ga_commands, obj, false);
+    rsp =3D qmp_dispatch(&s->session, obj, false);
=20
 end:
     ret =3D send_response(s, rsp);
@@ -1338,6 +1339,7 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)
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
index 27b0afe55a..962c2cb2e1 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -147,44 +147,52 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_q=
emu_x_EnumList *a,
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
@@ -198,36 +206,44 @@ static void test_dispatch_cmd_failure(void)
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
2.24.0


