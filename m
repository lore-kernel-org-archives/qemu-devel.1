Received: from eggs.gnu.org ([2001:4830:134:3::10]:39116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxR-0003Mn-8Q
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxN-0001B8-1T
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHxM-0001AA-MJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F5D940216F1
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E0892156889
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:53 +0200
Message-Id: <20180824193206.25475-46-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 45/58] json: Fix streamer not to ignore trailing
 unterminated structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Message-Id: <20180823164025.12553-46-armbru@redhat.com>
---
 include/qapi/qmp/json-lexer.h | 1 +
 qobject/json-lexer.c          | 2 ++
 qobject/json-streamer.c       | 8 ++++++++
 tests/check-qjson.c           | 8 ++++----
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/qapi/qmp/json-lexer.h b/include/qapi/qmp/json-lexer.h
index afa84cb910..508fc7bdaf 100644
--- a/include/qapi/qmp/json-lexer.h
+++ b/include/qapi/qmp/json-lexer.h
@@ -30,6 +30,7 @@ typedef enum json_token_type {
     JSON_INTERP,
     JSON_SKIP,
     JSON_ERROR,
+    JSON_END_OF_INPUT,
 } JSONTokenType;
 
 typedef struct JSONLexer {
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 01417dca9d..a728c32faa 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -347,6 +347,8 @@ void json_lexer_flush(JSONLexer *lexer)
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
index f9438370d9..0ca4b3c823 100644
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
