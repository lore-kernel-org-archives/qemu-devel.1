Received: from eggs.gnu.org ([2001:4830:134:3::10]:46371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKL-00038a-2K
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-0001np-AA
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKF-0001l8-F8
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:51 +0200
Message-Id: <20180817150559.16243-53-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 52/60] json: Eliminate lexer state
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/json-lexer.h |  1 -
 qobject/json-lexer.c          | 26 +++++++++-----------------
 2 files changed, 9 insertions(+), 18 deletions(-)

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
index 49e075a51e..431a1ede61 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -119,7 +119,6 @@ enum {
     IN_SIGN,
     IN_KEYWORD,
     IN_INTERPOL,
-    IN_WHITESPACE,
 };
 
 QEMU_BUILD_BUG_ON(JSON_ERROR != 0); /* json_lexer[] relies on this */
@@ -214,15 +213,6 @@ static const uint8_t json_lexer[][256] =  {
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
     [IN_INTERPOL] = {
         TERMINAL(JSON_INTERPOL),
@@ -249,12 +239,16 @@ static const uint8_t json_lexer[][256] =  {
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
     [IN_START_INTERPOL]['%'] = IN_INTERPOL,
+    [IN_START_INTERPOL][' '] = IN_START_INTERPOL,
+    [IN_START_INTERPOL]['\t'] = IN_START_INTERPOL,
+    [IN_START_INTERPOL]['\r'] = IN_START_INTERPOL,
+    [IN_START_INTERPOL]['\n'] = IN_START_INTERPOL,
 };
 
 void json_lexer_init(JSONLexer *lexer, bool enable_interpolation)
@@ -279,7 +273,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         assert(lexer->state <= ARRAY_SIZE(json_lexer));
         new_state = json_lexer[lexer->state][(uint8_t)ch];
         char_consumed = !TERMINAL_NEEDED_LOOKAHEAD(lexer->state, new_state);
-        if (char_consumed && !flush) {
+        if (char_consumed && new_state != lexer->start_state && !flush) {
             g_string_append_c(lexer->token, ch);
         }
 
@@ -297,8 +291,6 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
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
