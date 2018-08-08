Received: from eggs.gnu.org ([2001:4830:134:3::10]:52606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBq-0006lR-Ju
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBl-00006w-8N
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBk-0008Vn-N3
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:23 +0200
Message-Id: <20180808120334.10970-46-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 45/56] json: Fix streamer not to ignore
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
index 733ce3f5ba..823db3aef8 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -369,6 +369,8 @@ void json_lexer_flush(JSONLexer *lexer)
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
index 30b1b037d3..833d220654 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1305,7 +1305,7 @@ static void unterminated_array(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("[32", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
@@ -1313,7 +1313,7 @@ static void unterminated_array_comma(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("[32,", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
@@ -1329,7 +1329,7 @@ static void unterminated_dict(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("{'abc':32", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
@@ -1337,7 +1337,7 @@ static void unterminated_dict_comma(void)
 {
     Error *err = NULL;
     QObject *obj = qobject_from_json("{'abc':32,", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
-- 
2.17.1
