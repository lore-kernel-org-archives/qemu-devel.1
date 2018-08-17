Received: from eggs.gnu.org ([2001:4830:134:3::10]:50297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgSH-000522-Qs
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgSF-0008Qm-RX
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57430 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgSF-0008Ns-Ak
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:23 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:47 +0200
Message-Id: <20180817150559.16243-49-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 48/60] json: Enforce token count and size
 limits more tightly
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

Token count and size limits exist to guard against excessive heap
usage.  We check them only after we created the token on the heap.
That's assigning a cowboy to the barn to lasso the horse after it has
bolted.  Close the barn door instead: check before we create the
token.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-streamer.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 674dfe6e85..810aae521f 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -20,7 +20,7 @@
 
 #define MAX_TOKEN_SIZE (64ULL << 20)
 #define MAX_TOKEN_COUNT (2ULL << 20)
-#define MAX_NESTING (1ULL << 10)
+#define MAX_NESTING (1 << 10)
 
 static void json_message_free_token(void *token, void *opaque)
 {
@@ -71,6 +71,23 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         break;
     }
 
+    /*
+     * Security consideration, we limit total memory allocated per object
+     * and the maximum recursion depth that a message can force.
+     */
+    if (parser->token_size + input->len + 1 > MAX_TOKEN_SIZE) {
+        error_setg(&err, "JSON token size limit exceeded");
+        goto out_emit;
+    }
+    if (g_queue_get_length(parser->tokens) + 1 > MAX_TOKEN_COUNT) {
+        error_setg(&err, "JSON token count limit exceeded");
+        goto out_emit;
+    }
+    if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
+        error_setg(&err, "JSON nesting depth limit exceeded");
+        goto out_emit;
+    }
+
     token = g_malloc(sizeof(JSONToken) + input->len + 1);
     token->type = type;
     memcpy(token->str, input->str, input->len);
@@ -91,23 +108,6 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         goto out_emit;
     }
 
-    /*
-     * Security consideration, we limit total memory allocated per object
-     * and the maximum recursion depth that a message can force.
-     */
-    if (parser->token_size > MAX_TOKEN_SIZE) {
-        error_setg(&err, "JSON token size limit exceeded");
-        goto out_emit;
-    }
-    if (g_queue_get_length(parser->tokens) > MAX_TOKEN_COUNT) {
-        error_setg(&err, "JSON token count limit exceeded");
-        goto out_emit;
-    }
-    if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
-        error_setg(&err, "JSON nesting depth limit exceeded");
-        goto out_emit;
-    }
-
     return;
 
 out_emit:
-- 
2.17.1
