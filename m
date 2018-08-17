Received: from eggs.gnu.org ([2001:4830:134:3::10]:46626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKc-0003O7-7l
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-0001oQ-H7
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46172 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKF-0001jk-Pa
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:32 +0200
Message-Id: <20180817150559.16243-34-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 33/60] json: Redesign the callback to
 consume JSON values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

The classical way to structure parser and lexer is to have the client
call the parser to get an abstract syntax tree, the parser call the
lexer to get the next token, and the lexer call some function to get
input characters.

Another way to structure them would be to have the client feed
characters to the lexer, the lexer feed tokens to the parser, and the
parser feed abstract syntax trees to some callback provided by the
client.  This way is more easily integrated into an event loop that
dispatches input characters as they arrive.

Our JSON parser is kind of between the two.  The lexer feeds tokens to
a "streamer" instead of a real parser.  The streamer accumulates
tokens until it got the sequence of tokens that comprise a single JSON
value (it counts curly braces and square brackets to decide).  It
feeds those token sequences to a callback provided by the client.  The
callback passes each token sequence to the parser, and gets back an
abstract syntax tree.

I figure it was done that way to make a straightforward recursive
descent parser possible.  "Get next token" becomes "pop the first
token off the token sequence".  Drawback: we need to store a complete
token sequence.  Each token eats 13 + input characters + malloc
overhead bytes.

Observations:

1. This is not the only way to use recursive descent.  If we replaced
   "get next token" by a coroutine yield, we could do without a
   streamer.

2. The lexer reports errors by passing a JSON_ERROR token to the
   streamer.  This communicates the offending input characters and
   their location, but no more.

3. The streamer reports errors by passing a null token sequence to the
   callback.  The (already poor) lexical error information is thrown
   away.

4. Having the callback receive a token sequence duplicates the code to
   convert token sequence to abstract syntax tree in every callback.

5. Known bug: the streamer silently drops incomplete token sequences.

This commit rectifies 4. by lifting the call of the parser from the
callbacks into the streamer.  Later commits will address 3. and 5.

The lifting removes a bug from qjson.c's parse_json(): it passed a
pointer to a non-null Error * in certain cases, as demonstrated by
check-qjson.c.

json_parser_parse() is now unused.  It's a stupid wrapper around
json_parser_parse_err().  Drop it, and rename json_parser_parse_err()
to json_parser_parse().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/json-parser.h   |  3 +--
 include/qapi/qmp/json-streamer.h |  8 ++++++--
 monitor.c                        | 18 ++++++++----------
 qapi/qmp-dispatch.c              |  1 -
 qga/main.c                       | 12 +++---------
 qobject/json-parser.c            |  7 +------
 qobject/json-streamer.c          | 19 +++++++++++--------
 qobject/qjson.c                  | 14 +++++---------
 tests/check-qjson.c              |  1 -
 tests/libqtest.c                 | 10 ++++------
 10 files changed, 39 insertions(+), 54 deletions(-)

diff --git a/include/qapi/qmp/json-parser.h b/include/qapi/qmp/json-parser.h
index 102f5c0068..a34209db7a 100644
--- a/include/qapi/qmp/json-parser.h
+++ b/include/qapi/qmp/json-parser.h
@@ -16,7 +16,6 @@
 
 #include "qemu-common.h"
 
-QObject *json_parser_parse(GQueue *tokens, va_list *ap);
-QObject *json_parser_parse_err(GQueue *tokens, va_list *ap, Error **errp);
+QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
 
 #endif
diff --git a/include/qapi/qmp/json-streamer.h b/include/qapi/qmp/json-streamer.h
index 7922e185a5..e162fd01da 100644
--- a/include/qapi/qmp/json-streamer.h
+++ b/include/qapi/qmp/json-streamer.h
@@ -25,7 +25,9 @@ typedef struct JSONToken {
 
 typedef struct JSONMessageParser
 {
-    void (*emit)(struct JSONMessageParser *parser, GQueue *tokens);
+    void (*emit)(void *opaque, QObject *json, Error *err);
+    void *opaque;
+    va_list *ap;
     JSONLexer lexer;
     int brace_count;
     int bracket_count;
@@ -37,7 +39,9 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
                                 JSONTokenType type, int x, int y);
 
 void json_message_parser_init(JSONMessageParser *parser,
-                              void (*func)(JSONMessageParser *, GQueue *));
+                              void (*emit)(void *opaque, QObject *json,
+                                           Error *err),
+                              void *opaque, va_list *ap);
 
 void json_message_parser_feed(JSONMessageParser *parser,
                              const char *buffer, size_t size);
diff --git a/monitor.c b/monitor.c
index a1999e396c..392659324f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -59,7 +59,6 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/json-streamer.h"
-#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qlist.h"
 #include "qom/object_interfaces.h"
 #include "trace-root.h"
@@ -4245,18 +4244,15 @@ static void monitor_qmp_bh_dispatcher(void *data)
 
 #define  QMP_REQ_QUEUE_LEN_MAX  (8)
 
-static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
+static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
-    QObject *req, *id = NULL;
+    Monitor *mon = opaque;
+    QObject *id = NULL;
     QDict *qdict;
-    MonitorQMP *mon_qmp = container_of(parser, MonitorQMP, parser);
-    Monitor *mon = container_of(mon_qmp, Monitor, qmp);
-    Error *err = NULL;
     QMPRequest *req_obj;
 
-    req = json_parser_parse_err(tokens, NULL, &err);
     if (!req && !err) {
-        /* json_parser_parse_err() sucks: can fail without setting @err */
+        /* json_parser_parse() sucks: can fail without setting @err */
         error_setg(&err, QERR_JSON_PARSING);
     }
 
@@ -4454,7 +4450,8 @@ static void monitor_qmp_event(void *opaque, int event)
         monitor_qmp_response_flush(mon);
         monitor_qmp_cleanup_queues(mon);
         json_message_parser_destroy(&mon->qmp.parser);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
+        json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
+                                 mon, NULL);
         mon_refcount--;
         monitor_fdsets_cleanup();
         break;
@@ -4672,7 +4669,8 @@ void monitor_init(Chardev *chr, int flags)
 
     if (monitor_is_qmp(mon)) {
         qemu_chr_fe_set_echo(&mon->chr, true);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
+        json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
+                                 mon, NULL);
         if (mon->use_io_thread) {
             /*
              * Make sure the old iowatch is gone.  It's possible when
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 6f2d466596..d8da1a62de 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
-#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
diff --git a/qga/main.c b/qga/main.c
index 87372d40ef..2fc49d00d8 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -19,7 +19,6 @@
 #include <sys/wait.h>
 #endif
 #include "qapi/qmp/json-streamer.h"
-#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
@@ -597,18 +596,13 @@ static void process_command(GAState *s, QDict *req)
 }
 
 /* handle requests/control events coming in over the channel */
-static void process_event(JSONMessageParser *parser, GQueue *tokens)
+static void process_event(void *opaque, QObject *obj, Error *err)
 {
-    GAState *s = container_of(parser, GAState, parser);
-    QObject *obj;
+    GAState *s = opaque;
     QDict *req, *rsp;
-    Error *err = NULL;
     int ret;
 
-    g_assert(s && parser);
-
     g_debug("process_event: called");
-    obj = json_parser_parse_err(tokens, NULL, &err);
     if (err) {
         goto err;
     }
@@ -1320,7 +1314,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
     s->command_state = ga_command_state_new();
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
-    json_message_parser_init(&s->parser, process_event);
+    json_message_parser_init(&s->parser, process_event, s, NULL);
 
 #ifndef _WIN32
     if (!register_signal_handlers()) {
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index a25f2bfca2..f2646dce84 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -541,12 +541,7 @@ static QObject *parse_value(JSONParserContext *ctxt, va_list *ap)
     }
 }
 
-QObject *json_parser_parse(GQueue *tokens, va_list *ap)
-{
-    return json_parser_parse_err(tokens, ap, NULL);
-}
-
-QObject *json_parser_parse_err(GQueue *tokens, va_list *ap, Error **errp)
+QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
 {
     JSONParserContext ctxt = { .buf = tokens };
     QObject *result;
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 9f57ebf2bd..7fd0ff8756 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/qmp/json-lexer.h"
+#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
 
 #define MAX_TOKEN_SIZE (64ULL << 20)
@@ -38,8 +39,9 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
                                 JSONTokenType type, int x, int y)
 {
     JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
+    Error *err = NULL;
     JSONToken *token;
-    GQueue *tokens;
+    QObject *json;
 
     switch (type) {
     case JSON_LCURLY:
@@ -97,19 +99,20 @@ out_emit:
     /* send current list of tokens to parser and reset tokenizer */
     parser->brace_count = 0;
     parser->bracket_count = 0;
-    /* parser->emit takes ownership of parser->tokens.  Remove our own
-     * reference to parser->tokens before handing it out to parser->emit.
-     */
-    tokens = parser->tokens;
+    json = json_parser_parse(parser->tokens, parser->ap, &err);
     parser->tokens = g_queue_new();
-    parser->emit(parser, tokens);
     parser->token_size = 0;
+    parser->emit(parser->opaque, json, err);
 }
 
 void json_message_parser_init(JSONMessageParser *parser,
-                              void (*func)(JSONMessageParser *, GQueue *))
+                              void (*emit)(void *opaque, QObject *json,
+                                           Error *err),
+                              void *opaque, va_list *ap)
 {
-    parser->emit = func;
+    parser->emit = emit;
+    parser->opaque = opaque;
+    parser->ap = ap;
     parser->brace_count = 0;
     parser->bracket_count = 0;
     parser->tokens = g_queue_new();
diff --git a/qobject/qjson.c b/qobject/qjson.c
index ab4040f235..7395556069 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -13,8 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-lexer.h"
-#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
@@ -27,16 +25,16 @@
 typedef struct JSONParsingState
 {
     JSONMessageParser parser;
-    va_list *ap;
     QObject *result;
     Error *err;
 } JSONParsingState;
 
-static void parse_json(JSONMessageParser *parser, GQueue *tokens)
+static void consume_json(void *opaque, QObject *json, Error *err)
 {
-    JSONParsingState *s = container_of(parser, JSONParsingState, parser);
+    JSONParsingState *s = opaque;
 
-    s->result = json_parser_parse_err(tokens, s->ap, &s->err);
+    s->result = json;
+    error_propagate(&s->err, err);
 }
 
 /*
@@ -54,9 +52,7 @@ static QObject *qobject_from_jsonv(const char *string, va_list *ap,
 {
     JSONParsingState state = {};
 
-    state.ap = ap;
-
-    json_message_parser_init(&state.parser, parse_json);
+    json_message_parser_init(&state.parser, consume_json, &state, ap);
     json_message_parser_feed(&state.parser, string, strlen(string));
     json_message_parser_flush(&state.parser);
     json_message_parser_destroy(&state.parser);
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index b0efddebd2..8cccac838b 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1438,7 +1438,6 @@ static void multiple_values(void)
     qobject_unref(obj);
 
     /* BUG simultaneously succeeds and fails */
-    /* BUG calls json_parser_parse() with errp pointing to non-null */
     obj = qobject_from_json("} true", &err);
     g_assert(qbool_get_bool(qobject_to(QBool, obj)));
     error_free_or_abort(&err);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index a7ad09fc86..e17fe4fbd2 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -21,9 +21,9 @@
 #include <sys/un.h>
 
 #include "libqtest.h"
+#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
@@ -446,12 +446,10 @@ typedef struct {
     QDict *response;
 } QMPResponseParser;
 
-static void qmp_response(JSONMessageParser *parser, GQueue *tokens)
+static void qmp_response(void *opaque, QObject *obj, Error *err)
 {
-    QMPResponseParser *qmp = container_of(parser, QMPResponseParser, parser);
-    QObject *obj;
+    QMPResponseParser *qmp = opaque;
 
-    obj = json_parser_parse(tokens, NULL);
     if (!obj) {
         fprintf(stderr, "QMP JSON response parsing failed\n");
         abort();
@@ -468,7 +466,7 @@ QDict *qmp_fd_receive(int fd)
     bool log = getenv("QTEST_LOG") != NULL;
 
     qmp.response = NULL;
-    json_message_parser_init(&qmp.parser, qmp_response);
+    json_message_parser_init(&qmp.parser, qmp_response, &qmp, NULL);
     while (!qmp.response) {
         ssize_t len;
         char c;
-- 
2.17.1
