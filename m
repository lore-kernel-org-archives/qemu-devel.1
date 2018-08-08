Received: from eggs.gnu.org ([2001:4830:134:3::10]:52751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBw-0006pl-0N
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBm-00008v-0N
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37300 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBl-00006J-Es
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:28 +0200
Message-Id: <20180808120334.10970-51-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 50/56] json: Unbox tokens queue in
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/json-streamer.h |  2 +-
 qobject/json-parser.c            |  1 -
 qobject/json-streamer.c          | 30 +++++++++++-------------------
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/include/qapi/qmp/json-streamer.h b/include/qapi/qmp/json-streamer.h
index e162fd01da..d1d7fe2595 100644
--- a/include/qapi/qmp/json-streamer.h
+++ b/include/qapi/qmp/json-streamer.h
@@ -31,7 +31,7 @@ typedef struct JSONMessageParser
     JSONLexer lexer;
     int brace_count;
     int bracket_count;
-    GQueue *tokens;
+    GQueue tokens;
     uint64_t token_size;
 } JSONMessageParser;
 
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 208dffc96c..3623567160 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -547,7 +547,6 @@ QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
         parser_context_pop_token(&ctxt);
     }
     g_free(ctxt.current);
-    g_queue_free(ctxt.buf);
 
     return result;
 }
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 954bf9d468..9210281a65 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -22,17 +22,12 @@
 #define MAX_TOKEN_COUNT (2ULL << 20)
 #define MAX_NESTING (1 << 10)
 
-static void json_message_free_token(void *token, void *opaque)
-{
-    g_free(token);
-}
-
 static void json_message_free_tokens(JSONMessageParser *parser)
 {
-    if (parser->tokens) {
-        g_queue_foreach(parser->tokens, json_message_free_token, NULL);
-        g_queue_free(parser->tokens);
-        parser->tokens = NULL;
+    JSONToken *token;
+
+    while ((token = g_queue_pop_head(&parser->tokens))) {
+        g_free(token);
     }
 }
 
@@ -61,11 +56,10 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         error_setg(&err, "JSON parse error, stray '%s'", input->str);
         goto out_emit;
     case JSON_END_OF_INPUT:
-        if (g_queue_is_empty(parser->tokens)) {
+        if (g_queue_is_empty(&parser->tokens)) {
             return;
         }
-        json = json_parser_parse(parser->tokens, parser->ap, &err);
-        parser->tokens = NULL;
+        json = json_parser_parse(&parser->tokens, parser->ap, &err);
         goto out_emit;
     default:
         break;
@@ -79,7 +73,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         error_setg(&err, "JSON token size limit exceeded");
         goto out_emit;
     }
-    if (g_queue_get_length(parser->tokens) + 1 > MAX_TOKEN_COUNT) {
+    if (g_queue_get_length(&parser->tokens) + 1 > MAX_TOKEN_COUNT) {
         error_setg(&err, "JSON token count limit exceeded");
         goto out_emit;
     }
@@ -97,21 +91,19 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
 
     parser->token_size += input->len;
 
-    g_queue_push_tail(parser->tokens, token);
+    g_queue_push_tail(&parser->tokens, token);
 
     if ((parser->brace_count > 0 || parser->bracket_count > 0)
         && parser->bracket_count >= 0 && parser->bracket_count >= 0) {
         return;
     }
 
-    json = json_parser_parse(parser->tokens, parser->ap, &err);
-    parser->tokens = NULL;
+    json = json_parser_parse(&parser->tokens, parser->ap, &err);
 
 out_emit:
     parser->brace_count = 0;
     parser->bracket_count = 0;
     json_message_free_tokens(parser);
-    parser->tokens = g_queue_new();
     parser->token_size = 0;
     parser->emit(parser->opaque, json, err);
 }
@@ -126,7 +118,7 @@ void json_message_parser_init(JSONMessageParser *parser,
     parser->ap = ap;
     parser->brace_count = 0;
     parser->bracket_count = 0;
-    parser->tokens = g_queue_new();
+    g_queue_init(&parser->tokens);
     parser->token_size = 0;
 
     json_lexer_init(&parser->lexer, !!ap);
@@ -141,7 +133,7 @@ void json_message_parser_feed(JSONMessageParser *parser,
 void json_message_parser_flush(JSONMessageParser *parser)
 {
     json_lexer_flush(&parser->lexer);
-    assert(g_queue_is_empty(parser->tokens));
+    assert(g_queue_is_empty(&parser->tokens));
 }
 
 void json_message_parser_destroy(JSONMessageParser *parser)
-- 
2.17.1
