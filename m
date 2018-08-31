Received: from eggs.gnu.org ([2001:4830:134:3::10]:57996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fveKP-0001B2-Mk
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fveKM-0006cG-8R
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:58:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50528 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fveKL-0006bO-Ti
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:58:46 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 31 Aug 2018 09:58:38 +0200
Message-Id: <20180831075841.13363-4-armbru@redhat.com>
In-Reply-To: <20180831075841.13363-1-armbru@redhat.com>
References: <20180831075841.13363-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] json: Make lexer's "character consumed"
 logic less confusing
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

The lexer uses macro TERMINAL_NEEDED_LOOKAHEAD() to decide whether a
state transition consumes the input character.  It returns true when
the state transition is defined with the TERMINAL() macro.  To detect
that, it checks whether input '\0' would have resulted in the same
state transition, and the new state is not IN_ERROR.

Why does that even work?  For all states, the new state on input '\0'
is either IN_ERROR or defined with TERMINAL().  If the state
transition equals the one we'd get for input '\0', it goes to IN_ERROR
or to the argument of TERMINAL().  We never use TERMINAL(IN_ERROR),
because it makes no sense.  Thus, if it doesn't go to IN_ERROR, it
must be defined with TERMINAL().

Since this isn't quite confusing enough, we negate the result to get
@char_consumed, and ignore it when @flush is true.

Instead of deriving the lookahead bit from the state transition, make
it explicit.  This is easier to understand, and a bit more flexible,
too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-lexer.c      | 27 ++++++++++++++++-----------
 qobject/json-parser-int.h |  1 +
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index ec3aec726f..28582e17d9 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -121,15 +121,11 @@ enum json_lexer_state {
 };
 
 QEMU_BUILD_BUG_ON((int)JSON_MIN <= (int)IN_START_INTERP);
+QEMU_BUILD_BUG_ON(JSON_MAX >= 0x80);
 QEMU_BUILD_BUG_ON(IN_START_INTERP != IN_START + 1);
 
-#define TERMINAL(state) [0 ... 0xFF] = (state)
-
-/* Return whether TERMINAL is a terminal state and the transition to it
-   from OLD_STATE required lookahead.  This happens whenever the table
-   below uses the TERMINAL macro.  */
-#define TERMINAL_NEEDED_LOOKAHEAD(old_state, terminal) \
-    (terminal != IN_ERROR && json_lexer[(old_state)][0] == (terminal))
+#define LOOKAHEAD 0x80
+#define TERMINAL(state) [0 ... 0xFF] = ((state) | LOOKAHEAD)
 
 static const uint8_t json_lexer[][256] =  {
     /* Relies on default initialization to IN_ERROR! */
@@ -251,6 +247,17 @@ static const uint8_t json_lexer[][256] =  {
     [IN_START_INTERP]['%'] = IN_INTERP,
 };
 
+static inline uint8_t next_state(JSONLexer *lexer, char ch, bool flush,
+                                 bool *char_consumed)
+{
+    uint8_t next;
+
+    assert(lexer->state <= ARRAY_SIZE(json_lexer));
+    next = json_lexer[lexer->state][(uint8_t)ch];
+    *char_consumed = !flush && !(next & LOOKAHEAD);
+    return next & ~LOOKAHEAD;
+}
+
 void json_lexer_init(JSONLexer *lexer, bool enable_interpolation)
 {
     lexer->start_state = lexer->state = enable_interpolation
@@ -271,11 +278,9 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
     }
 
     while (flush ? lexer->state != lexer->start_state : !char_consumed) {
-        assert(lexer->state <= ARRAY_SIZE(json_lexer));
-        new_state = json_lexer[lexer->state][(uint8_t)ch];
-        char_consumed = !flush
-            && !TERMINAL_NEEDED_LOOKAHEAD(lexer->state, new_state);
+        new_state = next_state(lexer, ch, flush, &char_consumed);
         if (char_consumed) {
+            assert(!flush);
             g_string_append_c(lexer->token, ch);
         }
 
diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
index ceaa890ec6..abeec63af5 100644
--- a/qobject/json-parser-int.h
+++ b/qobject/json-parser-int.h
@@ -33,6 +33,7 @@ typedef enum json_token_type {
     JSON_SKIP,
     JSON_ERROR,
     JSON_END_OF_INPUT,
+    JSON_MAX = JSON_END_OF_INPUT
 } JSONTokenType;
 
 typedef struct JSONToken JSONToken;
-- 
2.17.1
