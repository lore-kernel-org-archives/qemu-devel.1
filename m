Received: from eggs.gnu.org ([2001:4830:134:3::10]:50220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgSF-00051H-Om
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgSE-0008NE-Ar
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgSE-0008MS-0B
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:22 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:44 +0200
Message-Id: <20180817150559.16243-46-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 45/60] json: Fix streamer not to ignore
 trailing unterminated structures
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

json_message_process_token() accumulates tokens until it got the
sequence of tokens that comprise a single JSON value (it counts curly
braces and square brackets to decide).  It feeds those token sequences
to json_parser_parse().  If a non-empty sequence of tokens remains at
the end of the parse, it's silently ignored.  check-qjson.c cases
unterminated_array(), unterminated_array_comma(), unterminated_dict(),
unterminated_dict_comma() demonstrate this bug.

Fix as follows.  Introduce a JSON_END_OF_INPUT token.  When the
streamer receives it, it feeds the accumulated tokens to
json_parser_parse().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/json-lexer.h | 1 +
 qobject/json-lexer.c          | 2 ++
 qobject/json-streamer.c       | 8 ++++++++
 tests/check-qjson.c           | 8 ++++----
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/qapi/qmp/json-lexer.h b/include/qapi/qmp/json-lexer.h
index 5586d12f26..8058695e40 100644
--- a/include/qapi/qmp/json-lexer.h
+++ b/include/qapi/qmp/json-lexer.h
@@ -30,6 +30,7 @@ typedef enum json_token_type {
     JSON_INTERPOL,
     JSON_SKIP,
     JSON_ERROR,
+    JSON_END_OF_INPUT
 } JSONTokenType;
 
 typedef struct JSONLexer {
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 6a3b89c855..ef29e2782d 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -353,6 +353,8 @@ void json_lexer_flush(JSONLexer *lexer)
     if (lexer->state != lexer->start_state) {
         json_lexer_feed_char(lexer, 0, true);
     }
+    json_message_process_token(lexer, lexer->token, JSON_END_OF_INPUT,
+                               lexer->x, lexer->y);
 }
 
 void json_lexer_destroy(JSONLexer *lexer)
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index e372ecc895..674dfe6e85 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -60,6 +60,13 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
     case JSON_ERROR:
         error_setg(&err, "JSON parse error, stray '%s'", input->str);
         goto out_emit;
+    case JSON_END_OF_INPUT:
+        if (g_queue_is_empty(parser->tokens)) {
+            return;
+        }
+        json = json_parser_parse(parser->tokens, parser->ap, &err);
+        parser->tokens = NULL;
+        goto out_emit;
     default:
         break;
     }
@@ -137,6 +144,7 @@ void json_message_parser_feed(JSONMessageParser *parser,
 void json_message_parser_flush(JSONMessageParser *parser)
 {
     json_lexer_flush(&parser->lexer);
+    assert(g_queue_is_empty(parser->tokens));
 }
 
 void json_message_parser_destroy(JSONMessageParser *parser)
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 22a3225358..a670746ca7 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1360,7 +1360,7 @@ static void unterminated_array(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("[32", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
@@ -1368,7 +1368,7 @@ static void unterminated_array_comma(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("[32,", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
@@ -1384,7 +1384,7 @@ static void unterminated_dict(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("{'abc':32", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
@@ -1392,7 +1392,7 @@ static void unterminated_dict_comma(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("{'abc':32,", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
-- 
2.17.1
