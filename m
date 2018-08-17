Received: from eggs.gnu.org ([2001:4830:134:3::10]:50256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgSG-00051R-Pa
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgSF-0008Pw-LH
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgSF-0008Nq-7C
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:23 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:50 +0200
Message-Id: <20180817150559.16243-52-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 51/60] json: Eliminate lexer state IN_ERROR
 and pseudo-token JSON_MIN
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/json-lexer.h | 10 ++++------
 qobject/json-lexer.c          | 15 +++++++--------
 2 files changed, 11 insertions(+), 14 deletions(-)

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
index ef29e2782d..49e075a51e 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -101,8 +101,9 @@
  * - Decoding and validating is left to the parser.
  */
 
-enum json_lexer_state {
-    IN_ERROR = 0,               /* must really be 0, see json_lexer[] */
+enum {
+    IN_START = JSON_END_OF_INPUT + 1,
+    IN_START_INTERPOL,          /* must be IN_START + 1 */
     IN_DQ_STRING_ESCAPE,
     IN_DQ_STRING,
     IN_SQ_STRING_ESCAPE,
@@ -119,11 +120,9 @@ enum json_lexer_state {
     IN_KEYWORD,
     IN_INTERPOL,
     IN_WHITESPACE,
-    IN_START,
-    IN_START_INTERPOL,          /* must be IN_START + 1 */
 };
 
-QEMU_BUILD_BUG_ON((int)JSON_MIN <= (int)IN_START_INTERPOL);
+QEMU_BUILD_BUG_ON(JSON_ERROR != 0); /* json_lexer[] relies on this */
 QEMU_BUILD_BUG_ON(IN_START_INTERPOL != IN_START + 1);
 
 #define TERMINAL(state) [0 ... 0x7F] = (state)
@@ -132,10 +131,10 @@ QEMU_BUILD_BUG_ON(IN_START_INTERPOL != IN_START + 1);
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
@@ -303,7 +302,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
             g_string_truncate(lexer->token, 0);
             new_state = lexer->start_state;
             break;
-        case IN_ERROR:
+        case JSON_ERROR:
             /* XXX: To avoid having previous bad input leaving the parser in an
              * unresponsive state where we consume unpredictable amounts of
              * subsequent "good" input, percolate this error state up to the
-- 
2.17.1
