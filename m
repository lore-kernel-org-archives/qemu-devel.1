Received: from eggs.gnu.org ([2001:4830:134:3::10]:57859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuBVx-0005uS-O6
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuBVw-0006CU-PF
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuBVw-0006BK-FR
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Aug 2018 09:00:20 +0200
Message-Id: <20180827070021.11931-6-armbru@redhat.com>
In-Reply-To: <20180827070021.11931-1-armbru@redhat.com>
References: <20180827070021.11931-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] json: Eliminate lexer state IN_ERROR
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
 qobject/json-lexer.c      | 9 +++++----
 qobject/json-parser-int.h | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 39c7ce7adc..2a5561c917 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -100,8 +100,7 @@
  */
 
 enum json_lexer_state {
-    IN_ERROR = 0,               /* must really be 0, see json_lexer[] */
-    IN_RECOVERY,
+    IN_RECOVERY = 1,
     IN_DQ_STRING_ESCAPE,
     IN_DQ_STRING,
     IN_SQ_STRING_ESCAPE,
@@ -121,6 +120,8 @@ enum json_lexer_state {
     IN_START_INTERP,            /* must be IN_START + 1 */
 };
 
+QEMU_BUILD_BUG_ON(JSON_ERROR != 0);
+QEMU_BUILD_BUG_ON(IN_RECOVERY != JSON_ERROR + 1);
 QEMU_BUILD_BUG_ON((int)JSON_MIN <= (int)IN_START_INTERP);
 QEMU_BUILD_BUG_ON(JSON_MAX >= 0x80);
 QEMU_BUILD_BUG_ON(IN_START_INTERP != IN_START + 1);
@@ -176,7 +177,7 @@ static const uint8_t json_lexer[][256] =  {
     /* Zero */
     [IN_ZERO] = {
         TERMINAL(JSON_INTEGER),
-        ['0' ... '9'] = IN_ERROR,
+        ['0' ... '9'] = JSON_ERROR,
         ['.'] = IN_MANTISSA,
     },
 
@@ -328,7 +329,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         case IN_START:
             new_state = lexer->start_state;
             break;
-        case IN_ERROR:
+        case JSON_ERROR:
             json_message_process_token(lexer, lexer->token, JSON_ERROR,
                                        lexer->x, lexer->y);
             new_state = IN_RECOVERY;
diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
index abeec63af5..57cb8e79d3 100644
--- a/qobject/json-parser-int.h
+++ b/qobject/json-parser-int.h
@@ -16,10 +16,11 @@
 
 #include "qapi/qmp/json-parser.h"
 
-
 typedef enum json_token_type {
-    JSON_MIN = 100,
-    JSON_LCURLY = JSON_MIN,
+    JSON_ERROR = 0,             /* must be zero, see json_lexer[] */
+    /* Gap for lexer states */
+    JSON_LCURLY = 100,
+    JSON_MIN = JSON_LCURLY,
     JSON_RCURLY,
     JSON_LSQUARE,
     JSON_RSQUARE,
@@ -31,7 +32,6 @@ typedef enum json_token_type {
     JSON_STRING,
     JSON_INTERP,
     JSON_SKIP,
-    JSON_ERROR,
     JSON_END_OF_INPUT,
     JSON_MAX = JSON_END_OF_INPUT
 } JSONTokenType;
-- 
2.17.1
