Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F6FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B828D215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W48h9ZUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B828D215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5pU-0005WW-H0
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5mt-0003PX-Ul
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5ms-0003rS-Ap
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5ms-0003rK-7F
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1Q4UMSoZSlz6+5iKyAOerNgelL9ZOigeHM/bJLClc4=;
 b=W48h9ZUh1RlALPZ1Ss8B8Xu0QKMuWL3zmhRJuwxTo22tUgxipMSXMF39wg700fOGvLUV9T
 g3QO8Acbq/qpPC+x5zMGdkmBl+jWozTwpb6rBfeDZ0HrarHCaqrE9kyrlZHXK9MHPlY/6L
 4xV4q8hcHNtF356f72B/9FgbIvVTZTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-vJUwHQDvMV6MZxD6_cHMtw-1; Fri, 08 Nov 2019 10:02:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8138180496F
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:02:55 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0F05DA7F;
 Fri,  8 Nov 2019 15:02:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/25] monitor: use qmp session to parse json feed
Date: Fri,  8 Nov 2019 19:01:04 +0400
Message-Id: <20191108150123.12213-7-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: vJUwHQDvMV6MZxD6_cHMtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Use the QmpSession json parser introduced in previous patch to
generalize the handling in both qemu & qemu-ga. Unfortunately, since
the introduction of OOB, it's not as common as it was before that. We
may want to move some of OOB logic in common qmp-dispatch.c/QmpSession
though.

The QEMU monitor has peculiar handling of the stream of commands, for
OOB command processing, which can be solved by overriding the json
emit callback.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h    |  1 +
 include/qapi/qmp/json-parser.h |  7 ++++---
 monitor/monitor-internal.h     |  1 -
 monitor/qmp.c                  | 13 +++++--------
 qapi/qmp-dispatch.c            |  4 +++-
 qga/main.c                     |  2 +-
 qobject/json-streamer.c        |  3 +--
 tests/test-qmp-cmds.c          | 11 ++++++-----
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index c84edff7d2..b3ca6c9ff2 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -53,6 +53,7 @@ const QmpCommand *qmp_find_command(const QmpCommandList *=
cmds,
                                    const char *name);
 void qmp_session_init(QmpSession *session,
                       const QmpCommandList *cmds,
+                      JSONMessageEmit *emit,
                       QmpDispatchReturn *return_cb);
 static inline void
 qmp_session_feed(QmpSession *session, const char *buf, size_t count)
diff --git a/include/qapi/qmp/json-parser.h b/include/qapi/qmp/json-parser.=
h
index 7345a9bd5c..6f168e8007 100644
--- a/include/qapi/qmp/json-parser.h
+++ b/include/qapi/qmp/json-parser.h
@@ -14,6 +14,8 @@
 #ifndef QAPI_QMP_JSON_PARSER_H
 #define QAPI_QMP_JSON_PARSER_H
=20
+typedef void (JSONMessageEmit)(void *opaque, QObject *json, Error *err);
+
 typedef struct JSONLexer {
     int start_state, state;
     GString *token;
@@ -21,7 +23,7 @@ typedef struct JSONLexer {
 } JSONLexer;
=20
 typedef struct JSONMessageParser {
-    void (*emit)(void *opaque, QObject *json, Error *err);
+    JSONMessageEmit *emit;
     void *opaque;
     va_list *ap;
     JSONLexer lexer;
@@ -32,8 +34,7 @@ typedef struct JSONMessageParser {
 } JSONMessageParser;
=20
 void json_message_parser_init(JSONMessageParser *parser,
-                              void (*emit)(void *opaque, QObject *json,
-                                           Error *err),
+                              JSONMessageEmit *emit,
                               void *opaque, va_list *ap);
=20
 void json_message_parser_feed(JSONMessageParser *parser,
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index b15266e77b..b8994f896a 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -124,7 +124,6 @@ struct MonitorHMP {
=20
 typedef struct {
     Monitor common;
-    JSONMessageParser parser;
     bool pretty;
     /*
      * When a client connects, we're in capabilities negotiation mode.
diff --git a/monitor/qmp.c b/monitor/qmp.c
index b215cb70f3..cd29494e28 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -217,7 +217,7 @@ void monitor_qmp_bh_dispatcher(void *data)
=20
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
-    MonitorQMP *mon =3D opaque;
+    MonitorQMP *mon =3D container_of(opaque, MonitorQMP, session);
     QObject *id =3D NULL;
     QDict *qdict;
     QMPRequest *req_obj;
@@ -279,7 +279,7 @@ static void monitor_qmp_read(void *opaque, const uint8_=
t *buf, int size)
 {
     MonitorQMP *mon =3D opaque;
=20
-    json_message_parser_feed(&mon->parser, (const char *) buf, size);
+    qmp_session_feed(&mon->session, (const char *) buf, size);
 }
=20
 static QDict *qmp_greeting(MonitorQMP *mon)
@@ -309,7 +309,9 @@ static void monitor_qmp_event(void *opaque, int event)
     switch (event) {
     case CHR_EVENT_OPENED:
         qmp_session_init(&mon->session,
-                         &qmp_cap_negotiation_commands, dispatch_return_cb=
);
+                         &qmp_cap_negotiation_commands,
+                         handle_qmp_command,
+                         dispatch_return_cb);
         monitor_qmp_caps_reset(mon);
         data =3D qmp_greeting(mon);
         qmp_send_response(mon, data);
@@ -325,9 +327,6 @@ static void monitor_qmp_event(void *opaque, int event)
          */
         monitor_qmp_cleanup_queues(mon);
         qmp_session_destroy(&mon->session);
-        json_message_parser_destroy(&mon->parser);
-        json_message_parser_init(&mon->parser, handle_qmp_command,
-                                 mon, NULL);
         mon_refcount--;
         monitor_fdsets_cleanup();
         break;
@@ -337,7 +336,6 @@ static void monitor_qmp_event(void *opaque, int event)
 void monitor_data_destroy_qmp(MonitorQMP *mon)
 {
     qmp_session_destroy(&mon->session);
-    json_message_parser_destroy(&mon->parser);
     qemu_mutex_destroy(&mon->qmp_queue_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
     g_queue_free(mon->qmp_requests);
@@ -373,7 +371,6 @@ void monitor_init_qmp(Chardev *chr, bool pretty)
     qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
     qemu_chr_fe_set_echo(&mon->common.chr, true);
=20
-    json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
     if (mon->common.use_io_thread) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index f8c491924d..b004d7506f 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -183,12 +183,14 @@ static void qmp_json_emit(void *opaque, QObject *obj,=
 Error *err)
=20
 void qmp_session_init(QmpSession *session,
                       const QmpCommandList *cmds,
+                      JSONMessageEmit *emit,
                       QmpDispatchReturn *return_cb)
 {
     assert(return_cb);
     assert(!session->return_cb);
=20
-    json_message_parser_init(&session->parser, qmp_json_emit, session, NUL=
L);
+    json_message_parser_init(&session->parser, emit ?: qmp_json_emit,
+                             session, NULL);
     session->cmds =3D cmds;
     session->return_cb =3D return_cb;
 }
diff --git a/qga/main.c b/qga/main.c
index 057368eb16..b005550c70 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1319,7 +1319,7 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)
     s->command_state =3D ga_command_state_new();
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
-    qmp_session_init(&s->session, &ga_commands, dispatch_return_cb);
+    qmp_session_init(&s->session, &ga_commands, NULL, dispatch_return_cb);
=20
 #ifndef _WIN32
     if (!register_signal_handlers()) {
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 47dd7ea576..2a440f2a9e 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -100,8 +100,7 @@ out_emit:
 }
=20
 void json_message_parser_init(JSONMessageParser *parser,
-                              void (*emit)(void *opaque, QObject *json,
-                                           Error *err),
+                              JSONMessageEmit *emit,
                               void *opaque, va_list *ap)
 {
     parser->emit =3D emit;
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index cca15e79ba..d9623d10b6 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -155,7 +155,7 @@ static void test_dispatch_cmd(void)
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_cmd_return);
+    qmp_session_init(&session, &qmp_commands, NULL, dispatch_cmd_return);
     qdict_put_str(req, "execute", "user_def_cmd");
=20
     qmp_dispatch(&session, QOBJECT(req), false);
@@ -169,7 +169,7 @@ static void test_dispatch_cmd_oob(void)
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_cmd_return);
+    qmp_session_init(&session, &qmp_commands, NULL, dispatch_cmd_return);
     qdict_put_str(req, "exec-oob", "test-flags-command");
=20
     qmp_dispatch(&session, QOBJECT(req), true);
@@ -191,7 +191,8 @@ static void test_dispatch_cmd_failure(void)
     QDict *req =3D qdict_new();
     QDict *args =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_cmd_failure_return)=
;
+    qmp_session_init(&session, &qmp_commands, NULL,
+                     dispatch_cmd_failure_return);
     qdict_put_str(req, "execute", "user_def_cmd2");
=20
     qmp_dispatch(&session, QOBJECT(req), false);
@@ -217,7 +218,7 @@ static void test_dispatch_cmd_success_response(void)
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, (QmpDispatchReturn *)abort);
+    qmp_session_init(&session, &qmp_commands, NULL, (QmpDispatchReturn *)a=
bort);
     qdict_put_str(req, "execute", "cmd-success-response");
=20
     qmp_dispatch(&session, QOBJECT(req), false);
@@ -238,7 +239,7 @@ static QObject *test_qmp_dispatch(QDict *req)
     QmpSession session =3D { 0, };
     QObject *ret;
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_return);
+    qmp_session_init(&session, &qmp_commands, NULL, dispatch_return);
     qmp_dispatch(&session, QOBJECT(req), false);
     ret =3D dispatch_ret;
     dispatch_ret =3D NULL;
--=20
2.24.0


