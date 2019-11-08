Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74276FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B233215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8P6mAMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B233215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5rp-0000WB-TZ
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5mV-00036Y-6F
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5mT-0003jd-8p
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42287
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5mS-0003in-PL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8Z5y8d3WkdwB1zLwwtTktsfJb3xTBuj4vDuH+BQs3M=;
 b=J8P6mAMQlZzICfoRrxIu3skZiXRoRpazJ49moWwo3gmIjtEy17jVyNEFR0hGNDfQcFJ1pw
 tfYCIrlH3XQw8C35zeBj3xscxGFtbGr6KcOnoaemmjOS02/da0oOapu5WprEjR6bMSFWmP
 YW9MI85WbD2h5a4vbF04LsWPDw2w5AA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-Q7UhsJ4SNl24DoQYGMwVnw-1; Fri, 08 Nov 2019 10:02:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D4C3800C72
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:02:29 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54F7A600C9;
 Fri,  8 Nov 2019 15:02:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/25] QmpSession: add a return callback
Date: Fri,  8 Nov 2019 19:01:02 +0400
Message-Id: <20191108150123.12213-5-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Q7UhsJ4SNl24DoQYGMwVnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Introduce a return_cb to allow delaying finishing the dispatch
and sending the response asynchronously. For now, this is just
modifying qmp_dispatch() to call the callback synchronously.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 10 ++++--
 monitor/qmp.c               | 47 ++++++++++---------------
 qapi/qmp-dispatch.c         | 22 +++++++++---
 qga/main.c                  | 34 +++++++++++-------
 tests/test-qmp-cmds.c       | 69 ++++++++++++++++++-------------------
 5 files changed, 98 insertions(+), 84 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 3b53cfd788..d1ce631a93 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -38,16 +38,20 @@ typedef struct QmpCommand
 typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpCommandList;
=20
 typedef struct QmpSession QmpSession;
+typedef void (QmpDispatchReturn) (QmpSession *session, QDict *rsp);
=20
 struct QmpSession {
     const QmpCommandList *cmds;
+    QmpDispatchReturn *return_cb;
 };
=20
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options);
 const QmpCommand *qmp_find_command(const QmpCommandList *cmds,
                                    const char *name);
-void qmp_session_init(QmpSession *session, const QmpCommandList *cmds);
+void qmp_session_init(QmpSession *session,
+                      const QmpCommandList *cmds,
+                      QmpDispatchReturn *return_cb);
 void qmp_session_destroy(QmpSession *session);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
@@ -56,8 +60,8 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QDict *qmp_error_response(Error *err);
-QDict *qmp_dispatch(QmpSession *session, QObject *request,
-                    bool allow_oob);
+void qmp_dispatch(QmpSession *session, QObject *request,
+                  bool allow_oob);
 bool qmp_is_oob(const QDict *dict);
=20
 typedef void (*qmp_cmd_callback_fn)(const QmpCommand *cmd, void *opaque);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 24ccdeb4a4..b215cb70f3 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -96,45 +96,35 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rs=
p)
     qobject_unref(json);
 }
=20
-/*
- * Emit QMP response @rsp to @mon.
- * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
- * Nothing is emitted then.
- */
-static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
+static void dispatch_return_cb(QmpSession *session, QDict *rsp)
 {
-    if (rsp) {
-        qmp_send_response(mon, rsp);
+    MonitorQMP *mon =3D container_of(session, MonitorQMP, session);
+
+    if (mon->session.cmds =3D=3D &qmp_cap_negotiation_commands) {
+        QDict *error =3D qdict_get_qdict(rsp, "error");
+        if (error
+            && !g_strcmp0(qdict_get_try_str(error, "class"),
+                          QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND=
))) {
+            /* Provide a more useful error message */
+            qdict_del(error, "desc");
+            qdict_put_str(error, "desc", "Expecting capabilities negotiati=
on"
+                          " with 'qmp_capabilities'");
+        }
     }
+
+    qmp_send_response(mon, rsp);
 }
=20
 static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
 {
     Monitor *old_mon;
-    QDict *rsp;
-    QDict *error;
=20
     old_mon =3D cur_mon;
     cur_mon =3D &mon->common;
=20
-    rsp =3D qmp_dispatch(&mon->session, req, qmp_oob_enabled(mon));
+    qmp_dispatch(&mon->session, req, qmp_oob_enabled(mon));
=20
     cur_mon =3D old_mon;
-
-    if (mon->session.cmds =3D=3D &qmp_cap_negotiation_commands) {
-        error =3D qdict_get_qdict(rsp, "error");
-        if (error
-            && !g_strcmp0(qdict_get_try_str(error, "class"),
-                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) {
-            /* Provide a more useful error message */
-            qdict_del(error, "desc");
-            qdict_put_str(error, "desc", "Expecting capabilities negotiati=
on"
-                          " with 'qmp_capabilities'");
-        }
-    }
-
-    monitor_qmp_respond(mon, rsp);
-    qobject_unref(rsp);
 }
=20
 /*
@@ -211,7 +201,7 @@ void monitor_qmp_bh_dispatcher(void *data)
         assert(req_obj->err);
         rsp =3D qmp_error_response(req_obj->err);
         req_obj->err =3D NULL;
-        monitor_qmp_respond(mon, rsp);
+        qmp_send_response(req_obj->mon, rsp);
         qobject_unref(rsp);
     }
=20
@@ -318,7 +308,8 @@ static void monitor_qmp_event(void *opaque, int event)
=20
     switch (event) {
     case CHR_EVENT_OPENED:
-        qmp_session_init(&mon->session, &qmp_cap_negotiation_commands);
+        qmp_session_init(&mon->session,
+                         &qmp_cap_negotiation_commands, dispatch_return_cb=
);
         monitor_qmp_caps_reset(mon);
         data =3D qmp_greeting(mon);
         qmp_send_response(mon, data);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 0e6b003dd8..1314f4929f 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -164,17 +164,28 @@ bool qmp_is_oob(const QDict *dict)
         && !qdict_haskey(dict, "execute");
 }
=20
-void qmp_session_init(QmpSession *session, const QmpCommandList *cmds)
+void qmp_session_init(QmpSession *session,
+                      const QmpCommandList *cmds,
+                      QmpDispatchReturn *return_cb)
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
-QDict *qmp_dispatch(QmpSession *session, QObject *request, bool allow_oob)
+void qmp_dispatch(QmpSession *session, QObject *request, bool allow_oob)
 {
     Error *err =3D NULL;
     QDict *dict =3D qobject_to(QDict, request);
@@ -189,12 +200,13 @@ QDict *qmp_dispatch(QmpSession *session, QObject *req=
uest, bool allow_oob)
         qdict_put_obj(rsp, "return", ret);
     } else {
         /* Can only happen for commands with QCO_NO_SUCCESS_RESP */
-        rsp =3D NULL;
+        return;
     }
=20
-    if (rsp && id) {
+    if (id) {
         qdict_put_obj(rsp, "id", qobject_ref(id));
     }
=20
-    return rsp;
+    session->return_cb(session, rsp);
+    qobject_unref(rsp);
 }
diff --git a/qga/main.c b/qga/main.c
index 61190db5f3..c291d06491 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -558,29 +558,37 @@ static int send_response(GAState *s, const QDict *rsp=
)
     return 0;
 }
=20
+static void dispatch_return_cb(QmpSession *session, QDict *rsp)
+{
+    GAState *s =3D container_of(session, GAState, session);
+    int ret =3D send_response(s, rsp);
+    if (ret < 0) {
+        g_warning("error sending response: %s", strerror(-ret));
+    }
+}
+
 /* handle requests/control events coming in over the channel */
 static void process_event(void *opaque, QObject *obj, Error *err)
 {
     GAState *s =3D opaque;
-    QDict *rsp;
     int ret;
=20
     g_debug("process_event: called");
     assert(!obj !=3D !err);
-    if (err) {
-        rsp =3D qmp_error_response(err);
-        goto end;
-    }
=20
-    g_debug("processing command");
-    rsp =3D qmp_dispatch(&s->session, obj, false);
+    if (err) {
+        QDict *rsp =3D qmp_error_response(err);
=20
-end:
-    ret =3D send_response(s, rsp);
-    if (ret < 0) {
-        g_warning("error sending error response: %s", strerror(-ret));
+        ret =3D send_response(s, rsp);
+        if (ret < 0) {
+            g_warning("error sending error response: %s", strerror(-ret));
+        }
+        qobject_unref(rsp);
+    } else {
+        g_debug("processing command");
+        qmp_dispatch(&s->session, obj, false);
     }
-    qobject_unref(rsp);
+
     qobject_unref(obj);
 }
=20
@@ -1339,7 +1347,7 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
     json_message_parser_init(&s->parser, process_event, s, NULL);
-    qmp_session_init(&s->session, &ga_commands);
+    qmp_session_init(&s->session, &ga_commands, dispatch_return_cb);
=20
 #ifndef _WIN32
     if (!register_signal_handlers()) {
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 962c2cb2e1..cca15e79ba 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -143,22 +143,23 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_q=
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
     QDict *req =3D qdict_new();
-    QDict *resp;
=20
-    qmp_session_init(&session, &qmp_commands);
+    qmp_session_init(&session, &qmp_commands, dispatch_cmd_return);
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    resp =3D qmp_dispatch(&session, QOBJECT(req), false);
-    assert(resp !=3D NULL);
-    assert(!qdict_haskey(resp, "error"));
+    qmp_dispatch(&session, QOBJECT(req), false);
=20
-    qobject_unref(resp);
     qobject_unref(req);
     qmp_session_destroy(&session);
 }
@@ -167,82 +168,80 @@ static void test_dispatch_cmd_oob(void)
 {
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
-    QDict *resp;
=20
-    qmp_session_init(&session, &qmp_commands);
+    qmp_session_init(&session, &qmp_commands, dispatch_cmd_return);
     qdict_put_str(req, "exec-oob", "test-flags-command");
=20
-    resp =3D qmp_dispatch(&session, QOBJECT(req), true);
-    assert(resp !=3D NULL);
-    assert(!qdict_haskey(resp, "error"));
+    qmp_dispatch(&session, QOBJECT(req), true);
=20
-    qobject_unref(resp);
     qobject_unref(req);
     qmp_session_destroy(&session);
 }
=20
+static void dispatch_cmd_failure_return(QmpSession *session, QDict *resp)
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
     QDict *args =3D qdict_new();
-    QDict *resp;
=20
-    qmp_session_init(&session, &qmp_commands);
+    qmp_session_init(&session, &qmp_commands, dispatch_cmd_failure_return)=
;
     qdict_put_str(req, "execute", "user_def_cmd2");
=20
-    resp =3D qmp_dispatch(&session, QOBJECT(req), false);
-    assert(resp !=3D NULL);
-    assert(qdict_haskey(resp, "error"));
+    qmp_dispatch(&session, QOBJECT(req), false);
=20
-    qobject_unref(resp);
     qobject_unref(req);
=20
     /* check that with extra arguments it throws an error */
     req =3D qdict_new();
     qdict_put_int(args, "a", 66);
     qdict_put(req, "arguments", args);
-
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    resp =3D qmp_dispatch(&session, QOBJECT(req), false);
-    assert(resp !=3D NULL);
-    assert(qdict_haskey(resp, "error"));
+    qmp_dispatch(&session, QOBJECT(req), false);
=20
-    qobject_unref(resp);
     qobject_unref(req);
     qmp_session_destroy(&session);
 }
=20
+static QObject *dispatch_ret;
+
 static void test_dispatch_cmd_success_response(void)
 {
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
-    QDict *resp;
=20
-    qmp_session_init(&session, &qmp_commands);
+    qmp_session_init(&session, &qmp_commands, (QmpDispatchReturn *)abort);
     qdict_put_str(req, "execute", "cmd-success-response");
-    resp =3D qmp_dispatch(&session, QOBJECT(req), false);
-    g_assert_null(resp);
+
+    qmp_dispatch(&session, QOBJECT(req), false);
+
     qobject_unref(req);
     qmp_session_destroy(&session);
 }
=20
+static void dispatch_return(QmpSession *session, QDict *resp)
+{
+    assert(resp && !qdict_haskey(resp, "error"));
+    dispatch_ret =3D qdict_get(resp, "return");
+    qobject_ref(dispatch_ret);
+}
=20
 static QObject *test_qmp_dispatch(QDict *req)
 {
     QmpSession session =3D { 0, };
-    QDict *resp;
     QObject *ret;
=20
-    qmp_session_init(&session, &qmp_commands);
-    resp =3D qmp_dispatch(&session, QOBJECT(req), false);
-    assert(resp && !qdict_haskey(resp, "error"));
-    ret =3D qdict_get(resp, "return");
-    assert(ret);
-    qobject_ref(ret);
-    qobject_unref(resp);
+    qmp_session_init(&session, &qmp_commands, dispatch_return);
+    qmp_dispatch(&session, QOBJECT(req), false);
+    ret =3D dispatch_ret;
+    dispatch_ret =3D NULL;
     qmp_session_destroy(&session);
     return ret;
 }
--=20
2.24.0


