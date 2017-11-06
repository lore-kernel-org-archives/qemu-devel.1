Received: from eggs.gnu.org ([2001:4830:134:3::10]:48221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe18-0004UX-0P
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe13-00049P-0H
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:48:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eBe12-000495-Np
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:48:24 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon,  6 Nov 2017 17:46:22 +0800
Message-Id: <20171106094643.14881-7-peterx@redhat.com>
In-Reply-To: <20171106094643.14881-1-peterx@redhat.com>
References: <20171106094643.14881-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v3 06/27] qjson: add "opaque" field to
 JSONMessageParser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

It'll be passed to emit() as well when it happens.  Since at it, add a
typedef for the emitter function.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/qmp/json-streamer.h | 10 ++++++++--
 monitor.c                        |  7 ++++---
 qga/main.c                       |  5 +++--
 qobject/json-streamer.c          |  6 ++++--
 qobject/qjson.c                  |  5 +++--
 tests/libqtest.c                 |  5 +++--
 6 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/qapi/qmp/json-streamer.h b/include/qapi/qmp/json-streamer.h
index 00d8a23af8..9198b67342 100644
--- a/include/qapi/qmp/json-streamer.h
+++ b/include/qapi/qmp/json-streamer.h
@@ -23,9 +23,14 @@ typedef struct JSONToken {
     char str[];
 } JSONToken;
 
+struct JSONMessageParser;
+typedef void (*JSONMessageEmitFunc)(struct JSONMessageParser *parser,
+                                    GQueue *tokens, void *opaque);
+
 typedef struct JSONMessageParser
 {
-    void (*emit)(struct JSONMessageParser *parser, GQueue *tokens);
+    JSONMessageEmitFunc emit;
+    void *opaque;
     JSONLexer lexer;
     int brace_count;
     int bracket_count;
@@ -34,7 +39,8 @@ typedef struct JSONMessageParser
 } JSONMessageParser;
 
 void json_message_parser_init(JSONMessageParser *parser,
-                              void (*func)(JSONMessageParser *, GQueue *));
+                              JSONMessageEmitFunc func,
+                              void *opaque);
 
 int json_message_parser_feed(JSONMessageParser *parser,
                              const char *buffer, size_t size);
diff --git a/monitor.c b/monitor.c
index 3940737c1c..ab80d32c70 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3808,7 +3808,8 @@ static int monitor_can_read(void *opaque)
     return (mon->suspend_cnt == 0) ? 1 : 0;
 }
 
-static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
+static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
+                               void *opaque)
 {
     QObject *req, *rsp = NULL, *id = NULL;
     QDict *qdict = NULL;
@@ -3955,7 +3956,7 @@ static void monitor_qmp_event(void *opaque, int event)
         break;
     case CHR_EVENT_CLOSED:
         json_message_parser_destroy(&mon->qmp.parser);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
+        json_message_parser_init(&mon->qmp.parser, handle_qmp_command, NULL);
         mon_refcount--;
         monitor_fdsets_cleanup();
         break;
@@ -4105,7 +4106,7 @@ void monitor_init(Chardev *chr, int flags)
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
                                  monitor_qmp_event, NULL, mon, NULL, true);
         qemu_chr_fe_set_echo(&mon->chr, true);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
+        json_message_parser_init(&mon->qmp.parser, handle_qmp_command, NULL);
     } else {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
                                  monitor_event, NULL, mon, NULL, true);
diff --git a/qga/main.c b/qga/main.c
index 62a62755bd..3b5ebbc1ee 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -593,7 +593,8 @@ static void process_command(GAState *s, QDict *req)
 }
 
 /* handle requests/control events coming in over the channel */
-static void process_event(JSONMessageParser *parser, GQueue *tokens)
+static void process_event(JSONMessageParser *parser, GQueue *tokens,
+                          void *opaque)
 {
     GAState *s = container_of(parser, GAState, parser);
     QDict *qdict;
@@ -1320,7 +1321,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
     s->command_state = ga_command_state_new();
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
-    json_message_parser_init(&s->parser, process_event);
+    json_message_parser_init(&s->parser, process_event, NULL);
 
 #ifndef _WIN32
     if (!register_signal_handlers()) {
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index c51c2021f9..8fc1b15321 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -102,18 +102,20 @@ out_emit:
      */
     tokens = parser->tokens;
     parser->tokens = g_queue_new();
-    parser->emit(parser, tokens);
+    parser->emit(parser, tokens, parser->opaque);
     parser->token_size = 0;
 }
 
 void json_message_parser_init(JSONMessageParser *parser,
-                              void (*func)(JSONMessageParser *, GQueue *))
+                              JSONMessageEmitFunc func,
+                              void *opaque)
 {
     parser->emit = func;
     parser->brace_count = 0;
     parser->bracket_count = 0;
     parser->tokens = g_queue_new();
     parser->token_size = 0;
+    parser->opaque = opaque;
 
     json_lexer_init(&parser->lexer, json_message_process_token);
 }
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 2e0930884e..f9766febe3 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -28,7 +28,8 @@ typedef struct JSONParsingState
     Error *err;
 } JSONParsingState;
 
-static void parse_json(JSONMessageParser *parser, GQueue *tokens)
+static void parse_json(JSONMessageParser *parser, GQueue *tokens,
+                       void *opaque)
 {
     JSONParsingState *s = container_of(parser, JSONParsingState, parser);
 
@@ -41,7 +42,7 @@ QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
 
     state.ap = ap;
 
-    json_message_parser_init(&state.parser, parse_json);
+    json_message_parser_init(&state.parser, parse_json, NULL);
     json_message_parser_feed(&state.parser, string, strlen(string));
     json_message_parser_flush(&state.parser);
     json_message_parser_destroy(&state.parser);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 0ec8af2923..6e5ddc2ffd 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -412,7 +412,8 @@ typedef struct {
     QDict *response;
 } QMPResponseParser;
 
-static void qmp_response(JSONMessageParser *parser, GQueue *tokens)
+static void qmp_response(JSONMessageParser *parser, GQueue *tokens,
+                         void *opaque)
 {
     QMPResponseParser *qmp = container_of(parser, QMPResponseParser, parser);
     QObject *obj;
@@ -434,7 +435,7 @@ QDict *qmp_fd_receive(int fd)
     bool log = getenv("QTEST_LOG") != NULL;
 
     qmp.response = NULL;
-    json_message_parser_init(&qmp.parser, qmp_response);
+    json_message_parser_init(&qmp.parser, qmp_response, NULL);
     while (!qmp.response) {
         ssize_t len;
         char c;
-- 
2.13.5
