Received: from eggs.gnu.org ([2001:4830:134:3::10]:33228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoi-0002Ib-O2
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001gJ-Ls
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoc-0001aJ-4n
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DE3E8076892
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BBCE2026D6D
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:43 +0200
Message-Id: <20180824193206.25475-36-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 35/58] json: Don't pass null @tokens to
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-36-armbru@redhat.com>
---
 qobject/json-parser.c   |  4 ----
 qobject/json-streamer.c | 25 ++++++++++++-------------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 95fa348e21..06aff19a5d 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -546,10 +546,6 @@ QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
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
