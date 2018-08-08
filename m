Received: from eggs.gnu.org ([2001:4830:134:3::10]:52718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBv-0006oy-0o
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBk-00005u-Ph
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBk-0008VF-AP
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:15 +0200
Message-Id: <20180808120334.10970-38-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 37/56] json: Treat unwanted interpolation as
 lexical error
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

The JSON parser optionally supports interpolation.  The lexer
recognizes interpolation tokens unconditionally.  The parser rejects
them when interpolation is disabled, in parse_interpolation().
However, it neglects to set an error then, which can make
json_parser_parse() fail without setting an error.

Move the check for unwanted interpolation from the parser's
parse_interpolation() into the lexer's finite state machine.  When
interpolation is disabled, '%' is now handled like any other
unexpected character.

The next commit will improve how such lexical errors are handled.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/json-lexer.h |  4 ++--
 qobject/json-lexer.c          | 42 ++++++++++++++++++++++++++---------
 qobject/json-parser.c         |  4 ----
 qobject/json-streamer.c       |  2 +-
 tests/qmp-test.c              |  4 ++++
 5 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/include/qapi/qmp/json-lexer.h b/include/qapi/qmp/json-lexer.h
index ff3a6f80f0..5586d12f26 100644
--- a/include/qapi/qmp/json-lexer.h
+++ b/include/qapi/qmp/json-lexer.h
@@ -33,12 +33,12 @@ typedef enum json_token_type {
 } JSONTokenType;
 
 typedef struct JSONLexer {
-    int state;
+    int start_state, state;
     GString *token;
     int x, y;
 } JSONLexer;
 
-void json_lexer_init(JSONLexer *lexer);
+void json_lexer_init(JSONLexer *lexer, bool enable_interpolation);
 
 void json_lexer_feed(JSONLexer *lexer, const char *buffer, size_t size);
 
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 5b1f720331..0ea1eae4aa 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -122,6 +122,7 @@ enum json_lexer_state {
     IN_INTERPOL_I6,
     IN_INTERPOL_I64,
     IN_WHITESPACE,
+    IN_START_INTERPOL,
     IN_START,
 };
 
@@ -271,17 +272,38 @@ static const uint8_t json_lexer[][256] =  {
         [','] = JSON_COMMA,
         [':'] = JSON_COLON,
         ['a' ... 'z'] = IN_KEYWORD,
+        [' '] = IN_WHITESPACE,
+        ['\t'] = IN_WHITESPACE,
+        ['\r'] = IN_WHITESPACE,
+        ['\n'] = IN_WHITESPACE,
+    },
+
+    [IN_START_INTERPOL] = {
+        ['"'] = IN_DQ_STRING,
+        ['\''] = IN_SQ_STRING,
+        ['0'] = IN_ZERO,
+        ['1' ... '9'] = IN_NONZERO_NUMBER,
+        ['-'] = IN_NEG_NONZERO_NUMBER,
+        ['{'] = JSON_LCURLY,
+        ['}'] = JSON_RCURLY,
+        ['['] = JSON_LSQUARE,
+        [']'] = JSON_RSQUARE,
+        [','] = JSON_COMMA,
+        [':'] = JSON_COLON,
+        ['a' ... 'z'] = IN_KEYWORD,
+        [' '] = IN_WHITESPACE,
+        ['\t'] = IN_WHITESPACE,
+        ['\r'] = IN_WHITESPACE,
+        ['\n'] = IN_WHITESPACE,
+        /* matches IN_START up to here */
         ['%'] = IN_INTERPOL,
-        [' '] = IN_WHITESPACE,
-        ['\t'] = IN_WHITESPACE,
-        ['\r'] = IN_WHITESPACE,
-        ['\n'] = IN_WHITESPACE,
     },
 };
 
-void json_lexer_init(JSONLexer *lexer)
+void json_lexer_init(JSONLexer *lexer, bool enable_interpolation)
 {
-    lexer->state = IN_START;
+    lexer->start_state = lexer->state = enable_interpolation
+        ? IN_START_INTERPOL : IN_START;
     lexer->token = g_string_sized_new(3);
     lexer->x = lexer->y = 0;
 }
@@ -321,7 +343,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
             /* fall through */
         case JSON_SKIP:
             g_string_truncate(lexer->token, 0);
-            new_state = IN_START;
+            new_state = lexer->start_state;
             break;
         case IN_ERROR:
             /* XXX: To avoid having previous bad input leaving the parser in an
@@ -340,7 +362,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
             json_message_process_token(lexer, lexer->token, JSON_ERROR,
                                        lexer->x, lexer->y);
             g_string_truncate(lexer->token, 0);
-            new_state = IN_START;
+            new_state = lexer->start_state;
             lexer->state = new_state;
             return;
         default:
@@ -356,7 +378,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         json_message_process_token(lexer, lexer->token, lexer->state,
                                    lexer->x, lexer->y);
         g_string_truncate(lexer->token, 0);
-        lexer->state = IN_START;
+        lexer->state = lexer->start_state;
     }
 }
 
@@ -371,7 +393,7 @@ void json_lexer_feed(JSONLexer *lexer, const char *buffer, size_t size)
 
 void json_lexer_flush(JSONLexer *lexer)
 {
-    if (lexer->state != IN_START) {
+    if (lexer->state != lexer->start_state) {
         json_lexer_feed_char(lexer, 0, true);
     }
 }
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index f1806ce0dc..848d469b2a 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -422,10 +422,6 @@ static QObject *parse_interpolation(JSONParserContext *ctxt, va_list *ap)
 {
     JSONToken *token;
 
-    if (ap == NULL) {
-        return NULL;
-    }
-
     token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_INTERPOL);
 
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index fa595a8761..a373e0114a 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -115,7 +115,7 @@ void json_message_parser_init(JSONMessageParser *parser,
     parser->tokens = g_queue_new();
     parser->token_size = 0;
 
-    json_lexer_init(&parser->lexer);
+    json_lexer_init(&parser->lexer, !!ap);
 }
 
 void json_message_parser_feed(JSONMessageParser *parser,
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index b77987b644..3046567819 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -94,6 +94,10 @@ static void test_malformed(QTestState *qts)
 
     /* lexical error: interpolation */
     qtest_qmp_send_raw(qts, "%%p\n");
+    /* two errors, one for "%", one for "p" */
+    resp = qtest_qmp_receive(qts);
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    qobject_unref(resp);
     resp = qtest_qmp_receive(qts);
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     qobject_unref(resp);
-- 
2.17.1
