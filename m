Received: from eggs.gnu.org ([2001:4830:134:3::10]:32860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssgP-0003W0-AZ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsset-0003Z0-PC
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsset-0003YP-HZ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:31 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:39:44 +0200
Message-Id: <20180823164025.12553-18-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 17/58] json: Fix lexer to include the bad
 character in JSON_ERROR token
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

json_lexer[] maps (lexer state, input character) to the new lexer
state.  The input character is consumed unless the new state is
terminal and the input character doesn't belong to this token,
i.e. the state transition uses look-ahead.  When this is the case,
input character '\0' would result in the same state transition.
TERMINAL_NEEDED_LOOKAHEAD() exploits this.

Except this is wrong for transitions to IN_ERROR.  There, the
offending input character is in fact consumed: case IN_ERROR returns.
It isn't added to the JSON_ERROR token, though.

Fix that by making TERMINAL_NEEDED_LOOKAHEAD() return false for
transitions to IN_ERROR.

There's a slight complication.  json_lexer_flush() passes input
character '\0' to flush an incomplete token.  If this results in
JSON_ERROR, we'd now add the '\0' to the token.  Suppress that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-lexer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 980ba159d6..7c0875d225 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -76,7 +76,7 @@ QEMU_BUILD_BUG_ON((int)JSON_MIN <= (int)IN_START);
    from OLD_STATE required lookahead.  This happens whenever the table
    below uses the TERMINAL macro.  */
 #define TERMINAL_NEEDED_LOOKAHEAD(old_state, terminal) \
-            (json_lexer[(old_state)][0] == (terminal))
+    (terminal != IN_ERROR && json_lexer[(old_state)][0] == (terminal))
 
 static const uint8_t json_lexer[][256] =  {
     /* Relies on default initialization to IN_ERROR! */
@@ -304,7 +304,7 @@ static int json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         assert(lexer->state <= ARRAY_SIZE(json_lexer));
         new_state = json_lexer[lexer->state][(uint8_t)ch];
         char_consumed = !TERMINAL_NEEDED_LOOKAHEAD(lexer->state, new_state);
-        if (char_consumed) {
+        if (char_consumed && !flush) {
             g_string_append_c(lexer->token, ch);
         }
 
-- 
2.17.1
