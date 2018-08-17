Received: from eggs.gnu.org ([2001:4830:134:3::10]:46631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKc-0003OA-7n
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-0001ox-N4
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKG-0001kj-3M
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:34 +0200
Message-Id: <20180817150559.16243-36-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 35/60] json: Don't create JSON_ERROR tokens
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
Reviewed-by: Eric Blake <eblake@redhat.com>
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
