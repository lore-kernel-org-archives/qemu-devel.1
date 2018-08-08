Received: from eggs.gnu.org ([2001:4830:134:3::10]:52672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBt-0006or-Up
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBl-00008O-Ql
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBl-00006C-CN
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:29 +0200
Message-Id: <20180808120334.10970-52-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 51/56] json: Eliminate lexer state IN_ERROR and
 pseudo-token JSON_MIN
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
 include/qapi/qmp/json-lexer.h | 10 ++++------
 qobject/json-lexer.c          | 18 ++++++++----------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/qapi/qmp/json-lexer.h b/include/qapi/qmp/json-lexer.h
index 8058695e40..f3524de07a 100644
--- a/include/qapi/qmp/json-lexer.h
+++ b/include/qapi/qmp/json-lexer.h
@@ -14,10 +14,9 @@
 #ifndef QEMU_JSON_LEXER_H
 #define QEMU_JSON_LEXER_H
 
-
-typedef enum json_token_type {
-    JSON_MIN = 100,
-    JSON_LCURLY = JSON_MIN,
+typedef enum {
+    JSON_ERROR = 0,             /* must be zero */
+    JSON_LCURLY,
     JSON_RCURLY,
     JSON_LSQUARE,
     JSON_RSQUARE,
@@ -29,8 +28,7 @@ typedef enum json_token_type {
     JSON_STRING,
     JSON_INTERPOL,
     JSON_SKIP,
-    JSON_ERROR,
-    JSON_END_OF_INPUT
+    JSON_END_OF_INPUT           /* must be last */
 } JSONTokenType;
 
 typedef struct JSONLexer {
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 823db3aef8..0332f9dbe1 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -101,8 +101,9 @@
  * - Decoding and validating is left to the parser.
  */
 
-enum json_lexer_state {
-    IN_ERROR = 0,               /* must really be 0, see json_lexer[] */
+enum {
+    IN_START = JSON_END_OF_INPUT + 1,
+    IN_START_INTERPOL,
     IN_DQ_STRING_ESCAPE,
     IN_DQ_STRING,
     IN_SQ_STRING_ESCAPE,
@@ -119,11 +120,9 @@ enum json_lexer_state {
     IN_KEYWORD,
     IN_INTERPOL,
     IN_WHITESPACE,
-    IN_START_INTERPOL,
-    IN_START,
 };
 
-QEMU_BUILD_BUG_ON((int)JSON_MIN <= (int)IN_START);
+QEMU_BUILD_BUG_ON(JSON_ERROR != 0); /* json_lexer[] relies on this */
 
 #define TERMINAL(state) [0 ... 0x7F] = (state)
 
@@ -131,10 +130,10 @@ QEMU_BUILD_BUG_ON((int)JSON_MIN <= (int)IN_START);
    from OLD_STATE required lookahead.  This happens whenever the table
    below uses the TERMINAL macro.  */
 #define TERMINAL_NEEDED_LOOKAHEAD(old_state, terminal) \
-    (terminal != IN_ERROR && json_lexer[(old_state)][0] == (terminal))
+    (terminal != JSON_ERROR && json_lexer[(old_state)][0] == (terminal))
 
 static const uint8_t json_lexer[][256] =  {
-    /* Relies on default initialization to IN_ERROR! */
+    /* Relies on default initialization to JSON_ERROR */
 
     /* double quote string */
     [IN_DQ_STRING_ESCAPE] = {
@@ -318,7 +317,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
             g_string_truncate(lexer->token, 0);
             new_state = lexer->start_state;
             break;
-        case IN_ERROR:
+        case JSON_ERROR:
             /* XXX: To avoid having previous bad input leaving the parser in an
              * unresponsive state where we consume unpredictable amounts of
              * subsequent "good" input, percolate this error state up to the
@@ -335,8 +334,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
             json_message_process_token(lexer, lexer->token, JSON_ERROR,
                                        lexer->x, lexer->y);
             g_string_truncate(lexer->token, 0);
-            new_state = lexer->start_state;
-            lexer->state = new_state;
+            lexer->state = lexer->start_state;
             return;
         default:
             break;
-- 
2.17.1
