Received: from eggs.gnu.org ([2001:4830:134:3::10]:38269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjh-0003z4-DE
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjd-00080X-Ch
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsjd-00080G-2G
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:17 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A4ACC05493C
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:05:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:32 +0400
Message-Id: <20170118160332.13390-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 25/25] qmp: move json-message-parser and
 check to QmpClient
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Clean up qmp_dispatch usage to have consistant checks between qga &
qemu, and simplify QmpClient/parser_feed usage.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  13 +++-
 monitor.c                   | 140 ++++++++------------------------------=
------
 qapi/qmp-dispatch.c         | 124 ++++++++++++++++++++++++++++++++++++++=
-
 qga/main.c                  |  61 +------------------
 qobject/json-lexer.c        |   4 +-
 tests/test-qmp-commands.c   |  12 ++--
 6 files changed, 172 insertions(+), 182 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 4dd6de5ab2..0a545935d5 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -16,9 +16,12 @@
=20
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/json-streamer.h"
=20
 typedef struct QmpClient QmpClient;
=20
+typedef bool (QmpPreDispatch) (QmpClient *client, QObject *rsp, Error **=
err);
+typedef bool (QmpPostDispatch) (QmpClient *client, QObject *rsp, Error *=
*err);
 typedef void (QmpDispatchReturn) (QmpClient *client, QObject *rsp);
=20
 typedef struct QmpReturn {
@@ -29,6 +32,9 @@ typedef struct QmpReturn {
 } QmpReturn;
=20
 struct QmpClient {
+    JSONMessageParser parser;
+    QmpPreDispatch *pre_dispatch_cb;
+    QmpPostDispatch *post_dispatch_cb;
     QmpDispatchReturn *return_cb;
=20
     QLIST_HEAD(, QmpReturn) pending;
@@ -68,8 +74,13 @@ void qmp_register_async_command(const char *name, QmpC=
ommandFuncAsync *fn,
                                 QmpCommandOptions options);
 void qmp_unregister_command(const char *name);
 QmpCommand *qmp_find_command(const char *name);
-void qmp_client_init(QmpClient *client, QmpDispatchReturn *return_cb);
+void qmp_client_init(QmpClient *client,
+                     QmpPreDispatch *pre_dispatch_cb,
+                     QmpPostDispatch *post_dispatch_cb,
+                     QmpDispatchReturn *return_cb);
 void qmp_client_destroy(QmpClient *client);
+void qmp_client_feed(QmpClient *client, const char *buffer, size_t size)=
;
+
 void qmp_dispatch(QmpClient *client, QObject *request, QDict *rsp);
 void qmp_disable_command(const char *name);
 void qmp_enable_command(const char *name);
diff --git a/monitor.c b/monitor.c
index 3ff32c000c..f763da462d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -56,7 +56,6 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
@@ -158,7 +157,6 @@ struct MonFdset {
 };
=20
 typedef struct {
-    JSONMessageParser parser;
     /*
      * When a client connects, we're in capabilities negotiation mode.
      * When command qmp_capabilities succeeds, we go into command
@@ -600,9 +598,6 @@ static void monitor_data_init(Monitor *mon)
 static void monitor_data_destroy(Monitor *mon)
 {
     qemu_chr_fe_deinit(&mon->chr);
-    if (monitor_is_qmp(mon)) {
-        json_message_parser_destroy(&mon->qmp.parser);
-    }
     qmp_client_destroy(&mon->qmp.client);
     g_free(mon->rs);
     QDECREF(mon->outbuf);
@@ -3700,62 +3695,6 @@ static bool invalid_qmp_mode(const Monitor *mon, c=
onst char *cmd,
     return false;
 }
=20
-/*
- * Input object checking rules
- *
- * 1. Input object must be a dict
- * 2. The "execute" key must exist
- * 3. The "execute" key must be a string
- * 4. If the "arguments" key exists, it must be a dict
- * 5. If the "id" key exists, it can be anything (ie. json-value)
- * 6. Any argument not listed above is considered invalid
- */
-static QDict *qmp_check_input_obj(QObject *input_obj, Error **errp)
-{
-    const QDictEntry *ent;
-    int has_exec_key =3D 0;
-    QDict *input_dict;
-
-    if (qobject_type(input_obj) !=3D QTYPE_QDICT) {
-        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "object");
-        return NULL;
-    }
-
-    input_dict =3D qobject_to_qdict(input_obj);
-
-    for (ent =3D qdict_first(input_dict); ent; ent =3D qdict_next(input_=
dict, ent)){
-        const char *arg_name =3D qdict_entry_key(ent);
-        const QObject *arg_obj =3D qdict_entry_value(ent);
-
-        if (!strcmp(arg_name, "execute")) {
-            if (qobject_type(arg_obj) !=3D QTYPE_QSTRING) {
-                error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT_MEMBER,
-                           "execute", "string");
-                return NULL;
-            }
-            has_exec_key =3D 1;
-        } else if (!strcmp(arg_name, "arguments")) {
-            if (qobject_type(arg_obj) !=3D QTYPE_QDICT) {
-                error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT_MEMBER,
-                           "arguments", "object");
-                return NULL;
-            }
-        } else if (!strcmp(arg_name, "id")) {
-            /* Any string is acceptable as "id", so nothing to check */
-        } else {
-            error_setg(errp, QERR_QMP_EXTRA_MEMBER, arg_name);
-            return NULL;
-        }
-    }
-
-    if (!has_exec_key) {
-        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "execute");
-        return NULL;
-    }
-
-    return input_dict;
-}
-
 static void monitor_qmp_suspend(Monitor *mon, QObject *req)
 {
     assert(monitor_is_qmp(mon));
@@ -3774,71 +3713,42 @@ static void monitor_qmp_resume(Monitor *mon)
     mon->qmp.suspended =3D NULL;
 }
=20
-static void qmp_dispatch_return(QmpClient *client, QObject *rsp)
+static bool qmp_pre_dispatch(QmpClient *client, QObject *req, Error **er=
rp)
 {
     Monitor *mon =3D container_of(client, Monitor, qmp.client);
+    QDict *qdict =3D qobject_to_qdict(req);
+    const char *cmd_name =3D qdict_get_str(qdict, "execute");
=20
-    monitor_json_emitter(mon, rsp);
+    trace_handle_qmp_command(mon, cmd_name);
=20
-    if (mon->qmp.suspended) {
-        monitor_qmp_resume(mon);
+    if (invalid_qmp_mode(mon, cmd_name, errp)) {
+        return false;
     }
+
+    return true;
 }
=20
-static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens=
)
+static bool qmp_post_dispatch(QmpClient *client, QObject *req, Error **e=
rrp)
 {
-    QObject *req, *id =3D NULL;
-    QDict *qdict, *rqdict =3D qdict_new();
-    const char *cmd_name;
-    Monitor *mon =3D cur_mon;
-    Error *err =3D NULL;
-
-    req =3D json_parser_parse_err(tokens, NULL, &err);
-    if (err || !req || qobject_type(req) !=3D QTYPE_QDICT) {
-        if (!err) {
-            error_setg(&err, QERR_JSON_PARSING);
-        }
-        goto err_out;
-    }
-
-    qdict =3D qmp_check_input_obj(req, &err);
-    if (!qdict) {
-        goto err_out;
-    }
-
-    id =3D qdict_get(qdict, "id");
-    if (id) {
-        qobject_incref(id);
-        qdict_del(qdict, "id");
-        qdict_put_obj(rqdict, "id", id);
-    }
-
-    cmd_name =3D qdict_get_str(qdict, "execute");
-    trace_handle_qmp_command(mon, cmd_name);
-
-    if (invalid_qmp_mode(mon, cmd_name, &err)) {
-        goto err_out;
-    }
-
-    qmp_dispatch(&mon->qmp.client, req, rqdict);
+    Monitor *mon =3D container_of(client, Monitor, qmp.client);
=20
     /* suspend if the command is on-going and client doesn't support asy=
nc */
     if (!QLIST_EMPTY(&mon->qmp.client.pending) && !mon->qmp.client.has_a=
sync) {
         monitor_qmp_suspend(mon, req);
     }
=20
-    qobject_decref(req);
-    return;
+    return true;
+}
=20
-err_out:
-    if (err) {
-        qdict_put_obj(rqdict, "error", qmp_build_error_object(err));
-        error_free(err);
-        monitor_json_emitter(mon, QOBJECT(rqdict));
-    }
+static void qmp_dispatch_return(QmpClient *client, QObject *rsp)
+{
+    Monitor *mon =3D container_of(client, Monitor, qmp.client);
+
+    monitor_json_emitter(mon, rsp);
=20
-    QDECREF(rqdict);
-    qobject_decref(req);
+    if (mon->qmp.suspended) {
+        monitor_qmp_resume(mon);
+    }
 }
=20
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
@@ -3849,7 +3759,7 @@ static void monitor_qmp_read(void *opaque, const ui=
nt8_t *buf, int size)
=20
     assert(monitor_is_qmp(cur_mon));
=20
-    json_message_parser_feed(&cur_mon->qmp.parser, (const char *) buf, s=
ize);
+    qmp_client_feed(&cur_mon->qmp.client, (const char *)buf, size);
=20
     cur_mon =3D old_mon;
 }
@@ -3926,7 +3836,10 @@ static void monitor_qmp_event(void *opaque, int ev=
ent)
=20
     switch (event) {
     case CHR_EVENT_OPENED:
-        qmp_client_init(&mon->qmp.client, qmp_dispatch_return);
+        qmp_client_init(&mon->qmp.client,
+                        qmp_pre_dispatch,
+                        qmp_post_dispatch,
+                        qmp_dispatch_return);
         mon->qmp.in_command_mode =3D false;
         data =3D get_qmp_greeting();
         monitor_json_emitter(mon, data);
@@ -3934,8 +3847,6 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
         mon_refcount++;
         break;
     case CHR_EVENT_CLOSED:
-        json_message_parser_destroy(&mon->qmp.parser);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
         qmp_client_destroy(&mon->qmp.client);
         mon_refcount--;
         monitor_fdsets_cleanup();
@@ -4094,7 +4005,6 @@ void monitor_init(CharDriverState *chr, int flags)
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qm=
p_read,
                                  monitor_qmp_event, mon, NULL, true);
         qemu_chr_fe_set_echo(&mon->chr, true);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
     } else {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_re=
ad,
                                  monitor_event, mon, NULL, true);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 5bf4b1b520..9c5cfc6b5a 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -20,6 +20,12 @@
 #include "qapi-types.h"
 #include "qapi/qmp/qerror.h"
=20
+void qmp_client_feed(QmpClient *client,
+                     const char *buffer, size_t size)
+{
+    json_message_parser_feed(&client->parser, buffer, size);
+}
+
 static QDict *qmp_dispatch_check_obj(const QObject *request, Error **err=
p)
 {
     const QDictEntry *ent;
@@ -180,10 +186,125 @@ bool qmp_return_is_cancelled(QmpReturn *qret)
     return false;
 }
=20
-void qmp_client_init(QmpClient *client, QmpDispatchReturn *return_cb)
+/*
+ * Input object checking rules
+ *
+ * 1. Input object must be a dict
+ * 2. The "execute" key must exist
+ * 3. The "execute" key must be a string
+ * 4. If the "arguments" key exists, it must be a dict
+ * 5. If the "id" key exists, it can be anything (ie. json-value)
+ * 6. Any argument not listed above is considered invalid
+ */
+static QDict *qmp_check_input_obj(QObject *input_obj, Error **errp)
+{
+    const QDictEntry *ent;
+    int has_exec_key =3D 0;
+    QDict *dict;
+
+    if (qobject_type(input_obj) !=3D QTYPE_QDICT) {
+        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "object");
+        return NULL;
+    }
+
+    dict =3D qobject_to_qdict(input_obj);
+
+    for (ent =3D qdict_first(dict); ent; ent =3D qdict_next(dict, ent)) =
{
+        const char *arg_name =3D qdict_entry_key(ent);
+        const QObject *arg_obj =3D qdict_entry_value(ent);
+
+        if (!strcmp(arg_name, "execute")) {
+            if (qobject_type(arg_obj) !=3D QTYPE_QSTRING) {
+                error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT_MEMBER,
+                           "execute", "string");
+                return NULL;
+            }
+            has_exec_key =3D 1;
+        } else if (!strcmp(arg_name, "arguments")) {
+            if (qobject_type(arg_obj) !=3D QTYPE_QDICT) {
+                error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT_MEMBER,
+                           "arguments", "object");
+                return NULL;
+            }
+        } else if (!strcmp(arg_name, "id")) {
+            /* Any string is acceptable as "id", so nothing to check */
+        } else {
+            error_setg(errp, QERR_QMP_EXTRA_MEMBER, arg_name);
+            return NULL;
+        }
+    }
+
+    if (!has_exec_key) {
+        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "execute");
+        return NULL;
+    }
+
+    return dict;
+}
+
+static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens=
)
+{
+    QmpClient *client =3D container_of(parser, QmpClient, parser);
+    QObject *req, *id =3D NULL;
+    QDict *qdict, *rqdict =3D qdict_new();
+    Error *err =3D NULL;
+
+    req =3D json_parser_parse_err(tokens, NULL, &err);
+    if (err || !req || qobject_type(req) !=3D QTYPE_QDICT) {
+        if (!err) {
+            error_setg(&err, QERR_JSON_PARSING);
+        }
+        goto err_out;
+    }
+
+    qdict =3D qmp_check_input_obj(req, &err);
+    if (!qdict) {
+        goto err_out;
+    }
+
+    id =3D qdict_get(qdict, "id");
+    if (id) {
+        qobject_incref(id);
+        qdict_del(qdict, "id");
+        qdict_put_obj(rqdict, "id", id);
+    }
+
+    if (client->pre_dispatch_cb &&
+        !client->pre_dispatch_cb(client, QOBJECT(qdict), &err)) {
+        goto err_out;
+    }
+
+    qmp_dispatch(client, req, rqdict);
+
+    if (client->post_dispatch_cb &&
+        !client->post_dispatch_cb(client, QOBJECT(qdict), &err)) {
+        goto err_out;
+    }
+
+    qobject_decref(req);
+    return;
+
+err_out:
+    if (err) {
+        qdict_put_obj(rqdict, "error", qmp_build_error_object(err));
+        error_free(err);
+        client->return_cb(client, QOBJECT(rqdict));
+    }
+
+    QDECREF(rqdict);
+    qobject_decref(req);
+}
+
+void qmp_client_init(QmpClient *client,
+                     QmpPreDispatch *pre_dispatch_cb,
+                     QmpPostDispatch *post_dispatch_cb,
+                     QmpDispatchReturn *return_cb)
 {
     assert(!client->return_cb);
=20
+    json_message_parser_init(&client->parser, handle_qmp_command);
+    client->pre_dispatch_cb =3D pre_dispatch_cb;
+    client->post_dispatch_cb =3D post_dispatch_cb;
     client->return_cb =3D return_cb;
     QLIST_INIT(&client->pending);
 }
@@ -193,6 +314,7 @@ void qmp_client_destroy(QmpClient *client)
     QmpReturn *ret, *next;
=20
     client->return_cb =3D NULL;
+    json_message_parser_destroy(&client->parser);
     /* Remove the weak references to the pending returns. The
      * dispatched function is the owner of QmpReturn, and will have to
      * qmp_return(). (it might be interesting to have a way to notify
diff --git a/qga/main.c b/qga/main.c
index a75544ed7a..d42b532cf4 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -65,7 +65,6 @@ typedef struct GAPersistentState {
 } GAPersistentState;
=20
 struct GAState {
-    JSONMessageParser parser;
     GMainLoop *main_loop;
     GAChannel *channel;
     bool virtio; /* fastpath to check for virtio to deal with poll() qui=
rks */
@@ -559,59 +558,7 @@ static void dispatch_return_cb(QmpClient *client, QO=
bject *rsp)
     }
 }
=20
-static void process_command(GAState *s, QDict *req)
-{
-    g_assert(req);
-    g_debug("processing command");
-    qmp_dispatch(&ga_state->client, QOBJECT(req), NULL);
-}
-
 /* handle requests/control events coming in over the channel */
-static void process_event(JSONMessageParser *parser, GQueue *tokens)
-{
-    GAState *s =3D container_of(parser, GAState, parser);
-    QDict *qdict;
-    Error *err =3D NULL;
-    int ret;
-
-    g_assert(s && parser);
-
-    g_debug("process_event: called");
-    qdict =3D qobject_to_qdict(json_parser_parse_err(tokens, NULL, &err)=
);
-    if (err || !qdict) {
-        QDECREF(qdict);
-        qdict =3D qdict_new();
-        if (!err) {
-            g_warning("failed to parse event: unknown error");
-            error_setg(&err, QERR_JSON_PARSING);
-        } else {
-            g_warning("failed to parse event: %s", error_get_pretty(err)=
);
-        }
-        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
-        error_free(err);
-    }
-
-    /* handle host->guest commands */
-    if (qdict_haskey(qdict, "execute")) {
-        process_command(s, qdict);
-    } else {
-        if (!qdict_haskey(qdict, "error")) {
-            QDECREF(qdict);
-            qdict =3D qdict_new();
-            g_warning("unrecognized payload format");
-            error_setg(&err, QERR_UNSUPPORTED);
-            qdict_put_obj(qdict, "error", qmp_build_error_object(err));
-            error_free(err);
-        }
-        ret =3D send_response(s, QOBJECT(qdict));
-        if (ret < 0) {
-            g_warning("error sending error response: %s", strerror(-ret)=
);
-        }
-    }
-
-    QDECREF(qdict);
-}
-
 /* false return signals GAChannel to close the current client connection=
 */
 static gboolean channel_event_cb(GIOCondition condition, gpointer data)
 {
@@ -625,8 +572,8 @@ static gboolean channel_event_cb(GIOCondition conditi=
on, gpointer data)
         return false;
     case G_IO_STATUS_NORMAL:
         buf[count] =3D 0;
-        g_debug("read data, count: %d, data: %s", (int)count, buf);
-        json_message_parser_feed(&s->parser, (char *)buf, (int)count);
+        g_debug("read data, count: %" G_GSIZE_FORMAT ", data: %s", count=
, buf);
+        qmp_client_feed(&s->client, buf, count);
         break;
     case G_IO_STATUS_EOF:
         g_debug("received EOF");
@@ -1285,9 +1232,8 @@ static int run_agent(GAState *s, GAConfig *config)
     s->command_state =3D ga_command_state_new();
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
-    json_message_parser_init(&s->parser, process_event);
     ga_state =3D s;
-    qmp_client_init(&s->client, dispatch_return_cb);
+    qmp_client_init(&s->client, NULL, NULL, dispatch_return_cb);
 #ifndef _WIN32
     if (!register_signal_handlers()) {
         g_critical("failed to register signal handlers");
@@ -1376,7 +1322,6 @@ end:
     if (s->command_state) {
         ga_command_state_cleanup_all(s->command_state);
         ga_command_state_free(s->command_state);
-        json_message_parser_destroy(&s->parser);
     }
     if (s->channel) {
         ga_channel_free(s->channel);
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index af4a75e05b..94f0db30df 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -382,5 +382,7 @@ int json_lexer_flush(JSONLexer *lexer)
=20
 void json_lexer_destroy(JSONLexer *lexer)
 {
-    g_string_free(lexer->token, true);
+    if (lexer->token) {
+        g_string_free(lexer->token, true);
+    }
 }
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index 4613a9a4c8..9656fbb529 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -127,7 +127,7 @@ static void test_dispatch_cmd(void)
     QmpClient client =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qmp_client_init(&client, dispatch_cmd_return);
+    qmp_client_init(&client, NULL, NULL, dispatch_cmd_return);
=20
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
")));
=20
@@ -150,7 +150,7 @@ static void test_dispatch_cmd_failure(void)
     QDict *req =3D qdict_new();
     QDict *args =3D qdict_new();
=20
-    qmp_client_init(&client, dispatch_cmd_error_return);
+    qmp_client_init(&client, NULL, NULL, dispatch_cmd_error_return);
=20
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
2")));
=20
@@ -192,7 +192,7 @@ static QObject *test_qmp_dispatch(QDict *req)
     QObject *ret;
     QmpClient client =3D { 0, };
=20
-    qmp_client_init(&client, qmp_dispatch_return);
+    qmp_client_init(&client, NULL, NULL, qmp_dispatch_return);
     qmp_dispatch(&client, QOBJECT(req), NULL);
     qmp_client_destroy(&client);
=20
@@ -258,7 +258,7 @@ static void test_dispatch_cmd_async(void)
     QDict *args =3D qdict_new();
=20
     loop =3D g_main_loop_new(NULL, FALSE);
-    qmp_client_init(&client, qmp_dispatch_return);
+    qmp_client_init(&client, NULL, NULL, qmp_dispatch_return);
=20
     qdict_put(args, "a", qint_from_int(99));
     qdict_put(req, "arguments", args);
@@ -287,7 +287,7 @@ static void test_dispatch_cmd_async_no_id(void)
     QDict *req =3D qdict_new();
     QDict *args =3D qdict_new();
=20
-    qmp_client_init(&client, dispatch_cmd_error_return);
+    qmp_client_init(&client, NULL, NULL, dispatch_cmd_error_return);
=20
     qdict_put(args, "a", qint_from_int(99));
     qdict_put(req, "arguments", args);
@@ -311,7 +311,7 @@ static void test_destroy_pending_async(void)
     int npending =3D 0;
=20
     loop =3D g_main_loop_new(NULL, FALSE);
-    qmp_client_init(&client, qmp_dispatch_return);
+    qmp_client_init(&client, NULL, NULL, qmp_dispatch_return);
=20
     qdict_put(args, "a", qint_from_int(99));
     qdict_put(req, "arguments", args);
--=20
2.11.0.295.gd7dffce1c
