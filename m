Received: from eggs.gnu.org ([2001:4830:134:3::10]:35437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskN-0000SL-43
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskL-0006L0-Bs
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsskK-0006KJ-VU
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:40:18 +0200
Message-Id: <20180823164025.12553-52-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 51/58] json: Make JSONToken opaque outside
 json-parser.c
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
 include/qapi/qmp/json-parser.h   |  4 ++++
 include/qapi/qmp/json-streamer.h |  7 -------
 qobject/json-parser.c            | 19 +++++++++++++++++++
 qobject/json-streamer.c          |  8 +-------
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/qapi/qmp/json-parser.h b/include/qapi/qmp/json-parser.h
index a34209db7a..21b23d7bec 100644
--- a/include/qapi/qmp/json-parser.h
+++ b/include/qapi/qmp/json-parser.h
@@ -15,7 +15,11 @@
 #define QEMU_JSON_PARSER_H
 
 #include "qemu-common.h"
+#include "qapi/qmp/json-lexer.h"
 
+typedef struct JSONToken JSONToken;
+
+JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
 QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
 
 #endif
diff --git a/include/qapi/qmp/json-streamer.h b/include/qapi/qmp/json-streamer.h
index d1d7fe2595..29950ac37c 100644
--- a/include/qapi/qmp/json-streamer.h
+++ b/include/qapi/qmp/json-streamer.h
@@ -16,13 +16,6 @@
 
 #include "qapi/qmp/json-lexer.h"
 
-typedef struct JSONToken {
-    int type;
-    int x;
-    int y;
-    char str[];
-} JSONToken;
-
 typedef struct JSONMessageParser
 {
     void (*emit)(void *opaque, QObject *json, Error *err);
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index e9a9f937f3..a247875f14 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -26,6 +26,13 @@
 #include "qapi/qmp/json-lexer.h"
 #include "qapi/qmp/json-streamer.h"
 
+struct JSONToken {
+    JSONTokenType type;
+    int x;
+    int y;
+    char str[];
+};
+
 typedef struct JSONParserContext
 {
     Error *err;
@@ -538,6 +545,18 @@ static QObject *parse_value(JSONParserContext *ctxt, va_list *ap)
     }
 }
 
+JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
+{
+    JSONToken *token = g_malloc(sizeof(JSONToken) + tokstr->len + 1);
+
+    token->type = type;
+    memcpy(token->str, tokstr->str, tokstr->len);
+    token->str[tokstr->len] = 0;
+    token->x = x;
+    token->y = y;
+    return token;
+}
+
 QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
 {
     JSONParserContext ctxt = { .buf = tokens };
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 9210281a65..467bc29413 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -82,13 +82,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         goto out_emit;
     }
 
-    token = g_malloc(sizeof(JSONToken) + input->len + 1);
-    token->type = type;
-    memcpy(token->str, input->str, input->len);
-    token->str[input->len] = 0;
-    token->x = x;
-    token->y = y;
-
+    token = json_token(type, x, y, input);
     parser->token_size += input->len;
 
     g_queue_push_tail(&parser->tokens, token);
-- 
2.17.1
