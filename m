Received: from eggs.gnu.org ([2001:4830:134:3::10]:52476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBn-0006h7-Kp
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBk-0008W2-Ad
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBj-0008US-T6
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:13 +0200
Message-Id: <20180808120334.10970-36-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 35/56] json: Don't create JSON_ERROR tokens
 that won't be used
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
 qobject/json-streamer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 0c33186e8e..fa595a8761 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -56,6 +56,8 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
     case JSON_RSQUARE:
         parser->bracket_count--;
         break;
+    case JSON_ERROR:
+        goto out_emit;
     default:
         break;
     }
@@ -71,10 +73,6 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
 
     g_queue_push_tail(parser->tokens, token);
 
-    if (type == JSON_ERROR) {
-        goto out_emit;
-    }
-
     if (parser->brace_count < 0 ||
         parser->bracket_count < 0 ||
         (parser->brace_count == 0 &&
-- 
2.17.1
