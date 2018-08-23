Received: from eggs.gnu.org ([2001:4830:134:3::10]:35587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskU-0000Y1-E5
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskL-0006M8-Kf
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsskL-0006Ki-Ar
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:40:20 +0200
Message-Id: <20180823164025.12553-54-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 53/58] json: Clean up headers
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

The JSON parser has three public headers, json-lexer.h, json-parser.h,
json-streamer.h.  They all contain stuff that is of no interest
outside qobject/json-*.c.

Collect the public interface in include/qapi/qmp/json-parser.h, and
everything else in qobject/json-parser-int.h.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/json-parser.h                | 36 ++++++++++++---
 include/qapi/qmp/json-streamer.h              | 46 -------------------
 monitor.c                                     |  2 +-
 qga/main.c                                    |  2 +-
 qobject/json-lexer.c                          |  3 +-
 .../json-lexer.h => qobject/json-parser-int.h | 26 ++++++-----
 qobject/json-parser.c                         |  4 +-
 qobject/json-streamer.c                       |  4 +-
 qobject/qjson.c                               |  2 +-
 tests/libqtest.c                              |  2 +-
 10 files changed, 51 insertions(+), 76 deletions(-)
 delete mode 100644 include/qapi/qmp/json-streamer.h
 rename include/qapi/qmp/json-lexer.h => qobject/json-parser-int.h (62%)

diff --git a/include/qapi/qmp/json-parser.h b/include/qapi/qmp/json-parser.h
index 55f75954c3..7345a9bd5c 100644
--- a/include/qapi/qmp/json-parser.h
+++ b/include/qapi/qmp/json-parser.h
@@ -1,5 +1,5 @@
 /*
- * JSON Parser 
+ * JSON Parser
  *
  * Copyright IBM, Corp. 2009
  *
@@ -11,14 +11,36 @@
  *
  */
 
-#ifndef QEMU_JSON_PARSER_H
-#define QEMU_JSON_PARSER_H
+#ifndef QAPI_QMP_JSON_PARSER_H
+#define QAPI_QMP_JSON_PARSER_H
 
-#include "qapi/qmp/json-lexer.h"
+typedef struct JSONLexer {
+    int start_state, state;
+    GString *token;
+    int x, y;
+} JSONLexer;
 
-typedef struct JSONToken JSONToken;
+typedef struct JSONMessageParser {
+    void (*emit)(void *opaque, QObject *json, Error *err);
+    void *opaque;
+    va_list *ap;
+    JSONLexer lexer;
+    int brace_count;
+    int bracket_count;
+    GQueue tokens;
+    uint64_t token_size;
+} JSONMessageParser;
 
-JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
-QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
+void json_message_parser_init(JSONMessageParser *parser,
+                              void (*emit)(void *opaque, QObject *json,
+                                           Error *err),
+                              void *opaque, va_list *ap);
+
+void json_message_parser_feed(JSONMessageParser *parser,
+                             const char *buffer, size_t size);
+
+void json_message_parser_flush(JSONMessageParser *parser);
+
+void json_message_parser_destroy(JSONMessageParser *parser);
 
 #endif
diff --git a/include/qapi/qmp/json-streamer.h b/include/qapi/qmp/json-streamer.h
deleted file mode 100644
index 29950ac37c..0000000000
--- a/include/qapi/qmp/json-streamer.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * JSON streaming support
- *
- * Copyright IBM, Corp. 2009
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-
-#ifndef QEMU_JSON_STREAMER_H
-#define QEMU_JSON_STREAMER_H
-
-#include "qapi/qmp/json-lexer.h"
-
-typedef struct JSONMessageParser
-{
-    void (*emit)(void *opaque, QObject *json, Error *err);
-    void *opaque;
-    va_list *ap;
-    JSONLexer lexer;
-    int brace_count;
-    int bracket_count;
-    GQueue tokens;
-    uint64_t token_size;
-} JSONMessageParser;
-
-void json_message_process_token(JSONLexer *lexer, GString *input,
-                                JSONTokenType type, int x, int y);
-
-void json_message_parser_init(JSONMessageParser *parser,
-                              void (*emit)(void *opaque, QObject *json,
-                                           Error *err),
-                              void *opaque, va_list *ap);
-
-void json_message_parser_feed(JSONMessageParser *parser,
-                             const char *buffer, size_t size);
-
-void json_message_parser_flush(JSONMessageParser *parser);
-
-void json_message_parser_destroy(JSONMessageParser *parser);
-
-#endif
diff --git a/monitor.c b/monitor.c
index c99dc4737d..9423b4f5e5 100644
--- a/monitor.c
+++ b/monitor.c
@@ -58,7 +58,7 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/json-streamer.h"
+#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qlist.h"
 #include "qom/object_interfaces.h"
 #include "trace-root.h"
diff --git a/qga/main.c b/qga/main.c
index b74e1241ef..6d70242d05 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -18,7 +18,7 @@
 #include <syslog.h>
 #include <sys/wait.h>
 #endif
-#include "qapi/qmp/json-streamer.h"
+#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 06ec67dc45..e1745a3d95 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -12,8 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/json-lexer.h"
-#include "qapi/qmp/json-streamer.h"
+#include "json-parser-int.h"
 
 #define MAX_TOKEN_SIZE (64ULL << 20)
 
diff --git a/include/qapi/qmp/json-lexer.h b/qobject/json-parser-int.h
similarity index 62%
rename from include/qapi/qmp/json-lexer.h
rename to qobject/json-parser-int.h
index 508fc7bdaf..ceaa890ec6 100644
--- a/include/qapi/qmp/json-lexer.h
+++ b/qobject/json-parser-int.h
@@ -1,5 +1,5 @@
 /*
- * JSON lexer
+ * JSON Parser
  *
  * Copyright IBM, Corp. 2009
  *
@@ -11,8 +11,10 @@
  *
  */
 
-#ifndef QEMU_JSON_LEXER_H
-#define QEMU_JSON_LEXER_H
+#ifndef JSON_PARSER_INT_H
+#define JSON_PARSER_INT_H
+
+#include "qapi/qmp/json-parser.h"
 
 
 typedef enum json_token_type {
@@ -33,18 +35,20 @@ typedef enum json_token_type {
     JSON_END_OF_INPUT,
 } JSONTokenType;
 
-typedef struct JSONLexer {
-    int start_state, state;
-    GString *token;
-    int x, y;
-} JSONLexer;
+typedef struct JSONToken JSONToken;
 
+/* json-lexer.c */
 void json_lexer_init(JSONLexer *lexer, bool enable_interpolation);
-
 void json_lexer_feed(JSONLexer *lexer, const char *buffer, size_t size);
-
 void json_lexer_flush(JSONLexer *lexer);
-
 void json_lexer_destroy(JSONLexer *lexer);
 
+/* json-streamer.c */
+void json_message_process_token(JSONLexer *lexer, GString *input,
+                                JSONTokenType type, int x, int y);
+
+/* json-parser.c */
+JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
+QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
+
 #endif
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index a247875f14..7449684f1c 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -22,9 +22,7 @@
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/json-lexer.h"
-#include "qapi/qmp/json-streamer.h"
+#include "json-parser-int.h"
 
 struct JSONToken {
     JSONTokenType type;
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index da53e770e9..47dd7ea576 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -13,9 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-lexer.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/json-streamer.h"
+#include "json-parser-int.h"
 
 #define MAX_TOKEN_SIZE (64ULL << 20)
 #define MAX_TOKEN_COUNT (2ULL << 20)
diff --git a/qobject/qjson.c b/qobject/qjson.c
index b9ccae2c2a..db36101f3b 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-streamer.h"
+#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 6a9151eebd..8aac609dec 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -24,7 +24,7 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-streamer.h"
+#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
-- 
2.17.1
