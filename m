Received: from eggs.gnu.org ([2001:4830:134:3::10]:57860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuBVx-0005uc-Os
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuBVw-0006Cd-QJ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuBVw-0006BJ-FC
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Aug 2018 09:00:21 +0200
Message-Id: <20180827070021.11931-7-armbru@redhat.com>
In-Reply-To: <20180827070021.11931-1-armbru@redhat.com>
References: <20180827070021.11931-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] json: Eliminate lexer state IN_WHITESPACE,
 pseudo-token JSON_SKIP
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

The lexer ignores whitespace like this:

         on whitespace      on non-ws   spontaneously
    IN_START --> IN_WHITESPACE --> JSON_SKIP --> IN_START
                    ^    |
                     \__/  on whitespace

This accumulates a whitespace token in state IN_WHITESPACE, only to
throw it away on the transition via JSON_SKIP to the start state.
Wasteful.  Go from IN_START to IN_START on whitspace directly,
dropping the whitespace character.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-lexer.c      | 22 +++++-----------------
 qobject/json-parser-int.h |  1 -
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 2a5561c917..a7df2093aa 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -115,7 +115,6 @@ enum json_lexer_state {
     IN_SIGN,
     IN_KEYWORD,
     IN_INTERP,
-    IN_WHITESPACE,
     IN_START,
     IN_START_INTERP,            /* must be IN_START + 1 */
 };
@@ -228,15 +227,6 @@ static const uint8_t json_lexer[][256] =  {
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
     /* interpolation */
     [IN_INTERP] = {
         TERMINAL(JSON_INTERP),
@@ -263,10 +253,10 @@ static const uint8_t json_lexer[][256] =  {
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
     [IN_START_INTERP]['%'] = IN_INTERP,
 };
@@ -323,10 +313,8 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
             json_message_process_token(lexer, lexer->token, new_state,
                                        lexer->x, lexer->y);
             /* fall through */
-        case JSON_SKIP:
-            g_string_truncate(lexer->token, 0);
-            /* fall through */
         case IN_START:
+            g_string_truncate(lexer->token, 0);
             new_state = lexer->start_state;
             break;
         case JSON_ERROR:
diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
index 57cb8e79d3..16a25d00bb 100644
--- a/qobject/json-parser-int.h
+++ b/qobject/json-parser-int.h
@@ -31,7 +31,6 @@ typedef enum json_token_type {
     JSON_KEYWORD,
     JSON_STRING,
     JSON_INTERP,
-    JSON_SKIP,
     JSON_END_OF_INPUT,
     JSON_MAX = JSON_END_OF_INPUT
 } JSONTokenType;
-- 
2.17.1
