Received: from eggs.gnu.org ([209.51.188.92]:55567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtKq-0002Qc-Ea
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtKo-0004eX-VL
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtKo-0004e9-Jx
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:54 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 18:09:55 +0200
Message-Id: <20190409161009.6322-7-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 06/20] monitor: use qmp session to parse
 json feed
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
 monitor.c                      | 16 +++++-----------
 qapi/qmp-dispatch.c            |  4 +++-
 qga/main.c                     |  2 +-
 qobject/json-streamer.c        |  3 +--
 tests/test-qmp-cmds.c          | 11 ++++++-----
 7 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index c84edff7d2..b3ca6c9ff2 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -53,6 +53,7 @@ const QmpCommand *qmp_find_command(const QmpCommandList=
 *cmds,
                                    const char *name);
 void qmp_session_init(QmpSession *session,
                       const QmpCommandList *cmds,
+                      JSONMessageEmit *emit,
                       QmpDispatchReturn *return_cb);
 static inline void
 qmp_session_feed(QmpSession *session, const char *buf, size_t count)
diff --git a/include/qapi/qmp/json-parser.h b/include/qapi/qmp/json-parse=
r.h
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
diff --git a/monitor.c b/monitor.c
index c23ba76f78..71aad8d1ae 100644
--- a/monitor.c
+++ b/monitor.c
@@ -59,7 +59,6 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qlist.h"
 #include "qom/object_interfaces.h"
 #include "trace-root.h"
@@ -167,7 +166,6 @@ struct MonFdset {
 };
=20
 typedef struct {
-    JSONMessageParser parser;
     /*
      * When a client connects, we're in capabilities negotiation mode.
      * @commands is &qmp_cap_negotiation_commands then.  When command
@@ -730,7 +728,6 @@ static void monitor_data_destroy(Monitor *mon)
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
         qmp_session_destroy(&mon->qmp.session);
-        json_message_parser_destroy(&mon->qmp.parser);
     }
     readline_free(mon->rs);
     qobject_unref(mon->outbuf);
@@ -4216,7 +4213,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
=20
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
-    Monitor *mon =3D opaque;
+    Monitor *mon =3D container_of(opaque, Monitor, qmp);
     QObject *id =3D NULL;
     QDict *qdict;
     QMPRequest *req_obj;
@@ -4278,7 +4275,7 @@ static void monitor_qmp_read(void *opaque, const ui=
nt8_t *buf, int size)
 {
     Monitor *mon =3D opaque;
=20
-    json_message_parser_feed(&mon->qmp.parser, (const char *) buf, size)=
;
+    qmp_session_feed(&mon->qmp.session, (const char *) buf, size);
 }
=20
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
@@ -4391,7 +4388,9 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
     switch (event) {
     case CHR_EVENT_OPENED:
         qmp_session_init(&mon->qmp.session,
-                         &qmp_cap_negotiation_commands, dispatch_return_=
cb);
+                         &qmp_cap_negotiation_commands,
+                         handle_qmp_command,
+                         dispatch_return_cb);
         monitor_qmp_caps_reset(mon);
         data =3D qmp_greeting(mon);
         qmp_send_response(mon, data);
@@ -4407,9 +4406,6 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
          */
         monitor_qmp_cleanup_queues(mon);
         qmp_session_destroy(&mon->qmp.session);
-        json_message_parser_destroy(&mon->qmp.parser);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
-                                 mon, NULL);
         mon_refcount--;
         monitor_fdsets_cleanup();
         break;
@@ -4615,8 +4611,6 @@ void monitor_init(Chardev *chr, int flags)
=20
     if (monitor_is_qmp(mon)) {
         qemu_chr_fe_set_echo(&mon->chr, true);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
-                                 mon, NULL);
         if (mon->use_io_thread) {
             /*
              * Make sure the old iowatch is gone.  It's possible when
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 803ec626cd..f2c376d005 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -182,12 +182,14 @@ static void qmp_json_emit(void *opaque, QObject *ob=
j, Error *err)
=20
 void qmp_session_init(QmpSession *session,
                       const QmpCommandList *cmds,
+                      JSONMessageEmit *emit,
                       QmpDispatchReturn *return_cb)
 {
     assert(return_cb);
     assert(!session->return_cb);
=20
-    json_message_parser_init(&session->parser, qmp_json_emit, session, N=
ULL);
+    json_message_parser_init(&session->parser, emit ?: qmp_json_emit,
+                             session, NULL);
     session->cmds =3D cmds;
     session->return_cb =3D return_cb;
 }
diff --git a/qga/main.c b/qga/main.c
index 9cd27fc4b8..14e418f9a5 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1319,7 +1319,7 @@ static GAState *initialize_agent(GAConfig *config, =
int socket_activation)
     s->command_state =3D ga_command_state_new();
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
-    qmp_session_init(&s->session, &ga_commands, dispatch_return_cb);
+    qmp_session_init(&s->session, &ga_commands, NULL, dispatch_return_cb=
);
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
index 3f41cc45bb..b4d0b0440a 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -121,7 +121,7 @@ static void test_dispatch_cmd(void)
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_cmd_return);
+    qmp_session_init(&session, &qmp_commands, NULL, dispatch_cmd_return)=
;
     qdict_put_str(req, "execute", "user_def_cmd");
=20
     qmp_dispatch(&session, QOBJECT(req), false);
@@ -135,7 +135,7 @@ static void test_dispatch_cmd_oob(void)
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_cmd_return);
+    qmp_session_init(&session, &qmp_commands, NULL, dispatch_cmd_return)=
;
     qdict_put_str(req, "exec-oob", "test-flags-command");
=20
     qmp_dispatch(&session, QOBJECT(req), true);
@@ -157,7 +157,8 @@ static void test_dispatch_cmd_failure(void)
     QDict *req =3D qdict_new();
     QDict *args =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_cmd_failure_retur=
n);
+    qmp_session_init(&session, &qmp_commands, NULL,
+                     dispatch_cmd_failure_return);
     qdict_put_str(req, "execute", "user_def_cmd2");
=20
     qmp_dispatch(&session, QOBJECT(req), false);
@@ -183,7 +184,7 @@ static void test_dispatch_cmd_success_response(void)
     QmpSession session =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qmp_session_init(&session, &qmp_commands, (QmpDispatchReturn *)abort=
);
+    qmp_session_init(&session, &qmp_commands, NULL, (QmpDispatchReturn *=
)abort);
     qdict_put_str(req, "execute", "cmd-success-response");
=20
     qmp_dispatch(&session, QOBJECT(req), false);
@@ -204,7 +205,7 @@ static QObject *test_qmp_dispatch(QDict *req)
     QmpSession session =3D { 0, };
     QObject *ret;
=20
-    qmp_session_init(&session, &qmp_commands, dispatch_return);
+    qmp_session_init(&session, &qmp_commands, NULL, dispatch_return);
     qmp_dispatch(&session, QOBJECT(req), false);
     ret =3D dispatch_ret;
     dispatch_ret =3D NULL;
--=20
2.21.0.196.g041f5ea1cf
