Received: from eggs.gnu.org ([2001:4830:134:3::10]:33115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHog-0002GL-Ji
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001fI-GJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoc-0001ZO-4a
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20E324023475
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE330215670B
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:25 +0200
Message-Id: <20180824193206.25475-18-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 17/58] json: Fix lexer to include the bad
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
Message-Id: <20180823164025.12553-18-armbru@redhat.com>
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
