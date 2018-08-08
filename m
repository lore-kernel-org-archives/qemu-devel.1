Received: from eggs.gnu.org ([2001:4830:134:3::10]:52495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBo-0006hZ-4W
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBk-0008Vy-B2
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBj-0008UU-SG
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:12 +0200
Message-Id: <20180808120334.10970-35-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 34/56] json: Don't pass null @tokens to
 json_parser_parse()
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

json_parser_parse() normally returns the QObject on success.  Except
it returns null when its @tokens argument is null.

Its only caller json_message_process_token() passes null @tokens when
emitting a lexical error.  The call is a rather opaque way to say json
= NULL then.

Simplify matters by lifting the assignment to json out of the emit
path: initialize json to null, set it to the value of
json_parser_parse() when there's no lexical error.  Drop the special
case from json_parser_parse().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c   |  4 ----
 qobject/json-streamer.c | 25 ++++++++++++-------------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 0196d511c3..0e4ea564ab 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -541,10 +541,6 @@ QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
     JSONParserContext ctxt = { .buf = tokens };
     QObject *result;
 
-    if (!tokens) {
-        return NULL;
-    }
-
     result = parse_value(&ctxt, ap);
 
     error_propagate(errp, ctxt.err);
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 7fd0ff8756..0c33186e8e 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -39,9 +39,9 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
                                 JSONTokenType type, int x, int y)
 {
     JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
+    QObject *json = NULL;
     Error *err = NULL;
     JSONToken *token;
-    QObject *json;
 
     switch (type) {
     case JSON_LCURLY:
@@ -72,34 +72,33 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
     g_queue_push_tail(parser->tokens, token);
 
     if (type == JSON_ERROR) {
-        goto out_emit_bad;
-    } else if (parser->brace_count < 0 ||
+        goto out_emit;
+    }
+
+    if (parser->brace_count < 0 ||
         parser->bracket_count < 0 ||
         (parser->brace_count == 0 &&
          parser->bracket_count == 0)) {
+        json = json_parser_parse(parser->tokens, parser->ap, &err);
+        parser->tokens = NULL;
         goto out_emit;
-    } else if (parser->token_size > MAX_TOKEN_SIZE ||
+    }
+
+    if (parser->token_size > MAX_TOKEN_SIZE ||
                g_queue_get_length(parser->tokens) > MAX_TOKEN_COUNT ||
                parser->bracket_count + parser->brace_count > MAX_NESTING) {
         /* Security consideration, we limit total memory allocated per object
          * and the maximum recursion depth that a message can force.
          */
-        goto out_emit_bad;
+        goto out_emit;
     }
 
     return;
 
-out_emit_bad:
-    /*
-     * Clear out token list and tell the parser to emit an error
-     * indication by passing it a NULL list
-     */
-    json_message_free_tokens(parser);
 out_emit:
-    /* send current list of tokens to parser and reset tokenizer */
     parser->brace_count = 0;
     parser->bracket_count = 0;
-    json = json_parser_parse(parser->tokens, parser->ap, &err);
+    json_message_free_tokens(parser);
     parser->tokens = g_queue_new();
     parser->token_size = 0;
     parser->emit(parser->opaque, json, err);
-- 
2.17.1
