Received: from eggs.gnu.org ([2001:4830:134:3::10]:33161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoh-0002HO-Js
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001dw-14
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHob-0001a6-Ua
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9CFC804BCF4
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 77FE52156714
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:41 +0200
Message-Id: <20180824193206.25475-34-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 33/58] json: Have lexer call streamer directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

json_lexer_init() takes the function to process a token as an
argument.  It's always json_message_process_token().  Makes the code
harder to understand for no actual gain.  Drop the indirection.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-34-armbru@redhat.com>
---
 include/qapi/qmp/json-lexer.h    | 13 +++----------
 include/qapi/qmp/json-streamer.h |  3 +++
 qobject/json-lexer.c             | 13 ++++++++-----
 qobject/json-streamer.c          |  6 +++---
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/qapi/qmp/json-lexer.h b/include/qapi/qmp/json-lexer.h
index 66ccf0357c..44bcf2ca64 100644
--- a/include/qapi/qmp/json-lexer.h
+++ b/include/qapi/qmp/json-lexer.h
@@ -32,20 +32,13 @@ typedef enum json_token_type {
     JSON_ERROR,
 } JSONTokenType;
 
-typedef struct JSONLexer JSONLexer;
-
-typedef void (JSONLexerEmitter)(JSONLexer *, GString *,
-                                JSONTokenType, int x, int y);
-
-struct JSONLexer
-{
-    JSONLexerEmitter *emit;
+typedef struct JSONLexer {
     int state;
     GString *token;
     int x, y;
-};
+} JSONLexer;
 
-void json_lexer_init(JSONLexer *lexer, JSONLexerEmitter func);
+void json_lexer_init(JSONLexer *lexer);
 
 void json_lexer_feed(JSONLexer *lexer, const char *buffer, size_t size);
 
diff --git a/include/qapi/qmp/json-streamer.h b/include/qapi/qmp/json-streamer.h
index cb808cf27d..7922e185a5 100644
--- a/include/qapi/qmp/json-streamer.h
+++ b/include/qapi/qmp/json-streamer.h
@@ -33,6 +33,9 @@ typedef struct JSONMessageParser
     uint64_t token_size;
 } JSONMessageParser;
 
+void json_message_process_token(JSONLexer *lexer, GString *input,
+                                JSONTokenType type, int x, int y);
+
 void json_message_parser_init(JSONMessageParser *parser,
                               void (*func)(JSONMessageParser *, GQueue *));
 
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index d9701f857b..17272a3874 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/qmp/json-lexer.h"
+#include "qapi/qmp/json-streamer.h"
 
 #define MAX_TOKEN_SIZE (64ULL << 20)
 
@@ -278,9 +279,8 @@ static const uint8_t json_lexer[][256] =  {
     },
 };
 
-void json_lexer_init(JSONLexer *lexer, JSONLexerEmitter func)
+void json_lexer_init(JSONLexer *lexer)
 {
-    lexer->emit = func;
     lexer->state = IN_START;
     lexer->token = g_string_sized_new(3);
     lexer->x = lexer->y = 0;
@@ -316,7 +316,8 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         case JSON_FLOAT:
         case JSON_KEYWORD:
         case JSON_STRING:
-            lexer->emit(lexer, lexer->token, new_state, lexer->x, lexer->y);
+            json_message_process_token(lexer, lexer->token, new_state,
+                                       lexer->x, lexer->y);
             /* fall through */
         case JSON_SKIP:
             g_string_truncate(lexer->token, 0);
@@ -336,7 +337,8 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
              * never a valid ASCII/UTF-8 sequence, so this should reliably
              * induce an error/flush state.
              */
-            lexer->emit(lexer, lexer->token, JSON_ERROR, lexer->x, lexer->y);
+            json_message_process_token(lexer, lexer->token, JSON_ERROR,
+                                       lexer->x, lexer->y);
             g_string_truncate(lexer->token, 0);
             new_state = IN_START;
             lexer->state = new_state;
@@ -351,7 +353,8 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
      * this is a security consideration.
      */
     if (lexer->token->len > MAX_TOKEN_SIZE) {
-        lexer->emit(lexer, lexer->token, lexer->state, lexer->x, lexer->y);
+        json_message_process_token(lexer, lexer->token, lexer->state,
+                                   lexer->x, lexer->y);
         g_string_truncate(lexer->token, 0);
         lexer->state = IN_START;
     }
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 78dfff2aa0..9f57ebf2bd 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -34,8 +34,8 @@ static void json_message_free_tokens(JSONMessageParser *parser)
     }
 }
 
-static void json_message_process_token(JSONLexer *lexer, GString *input,
-                                       JSONTokenType type, int x, int y)
+void json_message_process_token(JSONLexer *lexer, GString *input,
+                                JSONTokenType type, int x, int y)
 {
     JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
     JSONToken *token;
@@ -115,7 +115,7 @@ void json_message_parser_init(JSONMessageParser *parser,
     parser->tokens = g_queue_new();
     parser->token_size = 0;
 
-    json_lexer_init(&parser->lexer, json_message_process_token);
+    json_lexer_init(&parser->lexer);
 }
 
 void json_message_parser_feed(JSONMessageParser *parser,
-- 
2.17.1
