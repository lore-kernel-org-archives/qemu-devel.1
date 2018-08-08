Received: from eggs.gnu.org ([2001:4830:134:3::10]:52668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBt-0006oo-Ta
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBl-000086-Qt
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBl-000068-AA
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:30 +0200
Message-Id: <20180808120334.10970-53-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 52/56] json: Eliminate lexer state
 IN_WHITESPACE, pseudo-token JSON_SKIP
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

Bonus: static json_lexer[] loses its unused elements.  It shrinks from
8KiB to 4.75KiB for me.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/json-lexer.h |  1 -
 qobject/json-lexer.c          | 30 +++++++++---------------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/include/qapi/qmp/json-lexer.h b/include/qapi/qmp/json-lexer.h
index f3524de07a..1a2dbbb717 100644
--- a/include/qapi/qmp/json-lexer.h
+++ b/include/qapi/qmp/json-lexer.h
@@ -27,7 +27,6 @@ typedef enum {
     JSON_KEYWORD,
     JSON_STRING,
     JSON_INTERPOL,
-    JSON_SKIP,
     JSON_END_OF_INPUT           /* must be last */
 } JSONTokenType;
 
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 0332f9dbe1..26ba45956d 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -119,7 +119,6 @@ enum {
     IN_SIGN,
     IN_KEYWORD,
     IN_INTERPOL,
-    IN_WHITESPACE,
 };
 
 QEMU_BUILD_BUG_ON(JSON_ERROR != 0); /* json_lexer[] relies on this */
@@ -213,15 +212,6 @@ static const uint8_t json_lexer[][256] =  {
         ['a' ... 'z'] = IN_KEYWORD,
     },
 
-    /* whitespace */
-    [IN_WHITESPACE] = {
-        TERMINAL(JSON_SKIP),
-        [' '] = IN_WHITESPACE,
-        ['\t'] = IN_WHITESPACE,
-        ['\r'] = IN_WHITESPACE,
-        ['\n'] = IN_WHITESPACE,
-    },
-
     /* top level rule */
     [IN_START] = {
         ['"'] = IN_DQ_STRING,
@@ -236,10 +226,10 @@ static const uint8_t json_lexer[][256] =  {
         [','] = JSON_COMMA,
         [':'] = JSON_COLON,
         ['a' ... 'z'] = IN_KEYWORD,
-        [' '] = IN_WHITESPACE,
-        ['\t'] = IN_WHITESPACE,
-        ['\r'] = IN_WHITESPACE,
-        ['\n'] = IN_WHITESPACE,
+        [' '] = IN_START,
+        ['\t'] = IN_START,
+        ['\r'] = IN_START,
+        ['\n'] = IN_START,
     },
 
     /* interpolation */
@@ -263,11 +253,11 @@ static const uint8_t json_lexer[][256] =  {
         [','] = JSON_COMMA,
         [':'] = JSON_COLON,
         ['a' ... 'z'] = IN_KEYWORD,
-        [' '] = IN_WHITESPACE,
-        ['\t'] = IN_WHITESPACE,
-        ['\r'] = IN_WHITESPACE,
-        ['\n'] = IN_WHITESPACE,
         /* matches IN_START up to here */
+        [' '] = IN_START_INTERPOL,
+        ['\t'] = IN_START_INTERPOL,
+        ['\r'] = IN_START_INTERPOL,
+        ['\n'] = IN_START_INTERPOL,
         ['%'] = IN_INTERPOL,
     },
 };
@@ -294,7 +284,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         assert(lexer->state <= ARRAY_SIZE(json_lexer));
         new_state = json_lexer[lexer->state][(uint8_t)ch];
         char_consumed = !TERMINAL_NEEDED_LOOKAHEAD(lexer->state, new_state);
-        if (char_consumed && !flush) {
+        if (char_consumed && new_state != lexer->start_state && !flush) {
             g_string_append_c(lexer->token, ch);
         }
 
@@ -312,8 +302,6 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         case JSON_STRING:
             json_message_process_token(lexer, lexer->token, new_state,
                                        lexer->x, lexer->y);
-            /* fall through */
-        case JSON_SKIP:
             g_string_truncate(lexer->token, 0);
             new_state = lexer->start_state;
             break;
-- 
2.17.1
