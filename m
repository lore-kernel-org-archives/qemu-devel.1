Received: from eggs.gnu.org ([2001:4830:134:3::10]:46624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKc-0003O5-7e
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-0001oW-GM
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46184 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKF-0001kk-RX
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:36 +0200
Message-Id: <20180817150559.16243-38-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 37/60] json: Treat unwanted interpolation as
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/json-lexer.h |  4 ++--
 qobject/json-lexer.c          | 30 ++++++++++++++++++------------
 qobject/json-parser.c         |  4 ----
 qobject/json-streamer.c       |  2 +-
 tests/qmp-test.c              |  4 ++++
 5 files changed, 25 insertions(+), 19 deletions(-)

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
index 5b1f720331..cf15266cbe 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -92,7 +92,7 @@
  *   Like double-quoted strings, except they're delimited by %x27
  *   (apostrophe) instead of %x22 (quotation mark), and can't contain
  *   unescaped apostrophe, but can contain unescaped quotation mark.
- * - Interpolation:
+ * - Interpolation, if enabled:
  *   interpolation = %((l|ll|I64)[du]|[ipsf])
  *
  * Note:
@@ -123,9 +123,11 @@ enum json_lexer_state {
     IN_INTERPOL_I64,
     IN_WHITESPACE,
     IN_START,
+    IN_START_INTERPOL,          /* must be IN_START + 1 */
 };
 
-QEMU_BUILD_BUG_ON((int)JSON_MIN <= (int)IN_START);
+QEMU_BUILD_BUG_ON((int)JSON_MIN <= (int)IN_START_INTERPOL);
+QEMU_BUILD_BUG_ON(IN_START_INTERPOL != IN_START + 1);
 
 #define TERMINAL(state) [0 ... 0x7F] = (state)
 
@@ -257,8 +259,12 @@ static const uint8_t json_lexer[][256] =  {
         ['I'] = IN_INTERPOL_I,
     },
 
-    /* top level rule */
-    [IN_START] = {
+    /*
+     * Two start states:
+     * - IN_START recognizes JSON tokens with our string extensions
+     * - IN_START_INTERPOL additionally recognizes interpolation.
+     */
+    [IN_START ... IN_START_INTERPOL] = {
         ['"'] = IN_DQ_STRING,
         ['\''] = IN_SQ_STRING,
         ['0'] = IN_ZERO,
@@ -271,17 +277,18 @@ static const uint8_t json_lexer[][256] =  {
         [','] = JSON_COMMA,
         [':'] = JSON_COLON,
         ['a' ... 'z'] = IN_KEYWORD,
-        ['%'] = IN_INTERPOL,
         [' '] = IN_WHITESPACE,
         ['\t'] = IN_WHITESPACE,
         ['\r'] = IN_WHITESPACE,
         ['\n'] = IN_WHITESPACE,
     },
+    [IN_START_INTERPOL]['%'] = IN_INTERPOL,
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
@@ -321,7 +328,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
             /* fall through */
         case JSON_SKIP:
             g_string_truncate(lexer->token, 0);
-            new_state = IN_START;
+            new_state = lexer->start_state;
             break;
         case IN_ERROR:
             /* XXX: To avoid having previous bad input leaving the parser in an
@@ -340,8 +347,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
             json_message_process_token(lexer, lexer->token, JSON_ERROR,
                                        lexer->x, lexer->y);
             g_string_truncate(lexer->token, 0);
-            new_state = IN_START;
-            lexer->state = new_state;
+            lexer->state = lexer->start_state;
             return;
         default:
             break;
@@ -356,7 +362,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         json_message_process_token(lexer, lexer->token, lexer->state,
                                    lexer->x, lexer->y);
         g_string_truncate(lexer->token, 0);
-        lexer->state = IN_START;
+        lexer->state = lexer->start_state;
     }
 }
 
@@ -371,7 +377,7 @@ void json_lexer_feed(JSONLexer *lexer, const char *buffer, size_t size)
 
 void json_lexer_flush(JSONLexer *lexer)
 {
-    if (lexer->state != IN_START) {
+    if (lexer->state != lexer->start_state) {
         json_lexer_feed_char(lexer, 0, true);
     }
 }
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 1af1c1210c..56bbfe6810 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -427,10 +427,6 @@ static QObject *parse_interpolation(JSONParserContext *ctxt, va_list *ap)
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
index 7b3ba17c4a..4ae2245484 100644
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
