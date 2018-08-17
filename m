Received: from eggs.gnu.org ([2001:4830:134:3::10]:46284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKI-00035z-9h
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKF-0001mE-Lg
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKF-0001kC-0o
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:35 +0200
Message-Id: <20180817150559.16243-37-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 36/60] json: Rename token JSON_ESCAPE &
 friends to JSON_INTERPOL
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

The JSON parser optionally supports interpolation.  The code calls it
"escape".  Awkward, because it uses the same term for escape sequences
within strings.  The latter usage is consistent with RFC 7159 "The
JavaScript Object Notation (JSON) Data Interchange Format" and ISO C.
Call the former "interpolation" instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/json-lexer.h |  2 +-
 qobject/json-lexer.c          | 64 +++++++++++++++++------------------
 qobject/json-parser.c         |  8 ++---
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/include/qapi/qmp/json-lexer.h b/include/qapi/qmp/json-lexer.h
index 44bcf2ca64..ff3a6f80f0 100644
--- a/include/qapi/qmp/json-lexer.h
+++ b/include/qapi/qmp/json-lexer.h
@@ -27,7 +27,7 @@ typedef enum json_token_type {
     JSON_FLOAT,
     JSON_KEYWORD,
     JSON_STRING,
-    JSON_ESCAPE,
+    JSON_INTERPOL,
     JSON_SKIP,
     JSON_ERROR,
 } JSONTokenType;
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 0b54b1af56..5b1f720331 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -115,12 +115,12 @@ enum json_lexer_state {
     IN_NONZERO_NUMBER,
     IN_NEG_NONZERO_NUMBER,
     IN_KEYWORD,
-    IN_ESCAPE,
-    IN_ESCAPE_L,
-    IN_ESCAPE_LL,
-    IN_ESCAPE_I,
-    IN_ESCAPE_I6,
-    IN_ESCAPE_I64,
+    IN_INTERPOL,
+    IN_INTERPOL_L,
+    IN_INTERPOL_LL,
+    IN_INTERPOL_I,
+    IN_INTERPOL_I6,
+    IN_INTERPOL_I64,
     IN_WHITESPACE,
     IN_START,
 };
@@ -221,40 +221,40 @@ static const uint8_t json_lexer[][256] =  {
         ['\n'] = IN_WHITESPACE,
     },
 
-    /* escape */
-    [IN_ESCAPE_LL] = {
-        ['d'] = JSON_ESCAPE,
-        ['u'] = JSON_ESCAPE,
+    /* interpolation */
+    [IN_INTERPOL_LL] = {
+        ['d'] = JSON_INTERPOL,
+        ['u'] = JSON_INTERPOL,
     },
 
-    [IN_ESCAPE_L] = {
-        ['d'] = JSON_ESCAPE,
-        ['l'] = IN_ESCAPE_LL,
-        ['u'] = JSON_ESCAPE,
+    [IN_INTERPOL_L] = {
+        ['d'] = JSON_INTERPOL,
+        ['l'] = IN_INTERPOL_LL,
+        ['u'] = JSON_INTERPOL,
     },
 
-    [IN_ESCAPE_I64] = {
-        ['d'] = JSON_ESCAPE,
-        ['u'] = JSON_ESCAPE,
+    [IN_INTERPOL_I64] = {
+        ['d'] = JSON_INTERPOL,
+        ['u'] = JSON_INTERPOL,
     },
 
-    [IN_ESCAPE_I6] = {
-        ['4'] = IN_ESCAPE_I64,
+    [IN_INTERPOL_I6] = {
+        ['4'] = IN_INTERPOL_I64,
     },
 
-    [IN_ESCAPE_I] = {
-        ['6'] = IN_ESCAPE_I6,
+    [IN_INTERPOL_I] = {
+        ['6'] = IN_INTERPOL_I6,
     },
 
-    [IN_ESCAPE] = {
-        ['d'] = JSON_ESCAPE,
-        ['i'] = JSON_ESCAPE,
-        ['p'] = JSON_ESCAPE,
-        ['s'] = JSON_ESCAPE,
-        ['u'] = JSON_ESCAPE,
-        ['f'] = JSON_ESCAPE,
-        ['l'] = IN_ESCAPE_L,
-        ['I'] = IN_ESCAPE_I,
+    [IN_INTERPOL] = {
+        ['d'] = JSON_INTERPOL,
+        ['i'] = JSON_INTERPOL,
+        ['p'] = JSON_INTERPOL,
+        ['s'] = JSON_INTERPOL,
+        ['u'] = JSON_INTERPOL,
+        ['f'] = JSON_INTERPOL,
+        ['l'] = IN_INTERPOL_L,
+        ['I'] = IN_INTERPOL_I,
     },
 
     /* top level rule */
@@ -271,7 +271,7 @@ static const uint8_t json_lexer[][256] =  {
         [','] = JSON_COMMA,
         [':'] = JSON_COLON,
         ['a' ... 'z'] = IN_KEYWORD,
-        ['%'] = IN_ESCAPE,
+        ['%'] = IN_INTERPOL,
         [' '] = IN_WHITESPACE,
         ['\t'] = IN_WHITESPACE,
         ['\r'] = IN_WHITESPACE,
@@ -311,7 +311,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         case JSON_RSQUARE:
         case JSON_COLON:
         case JSON_COMMA:
-        case JSON_ESCAPE:
+        case JSON_INTERPOL:
         case JSON_INTEGER:
         case JSON_FLOAT:
         case JSON_KEYWORD:
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 866f7e3f14..1af1c1210c 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -423,7 +423,7 @@ static QObject *parse_keyword(JSONParserContext *ctxt)
     return NULL;
 }
 
-static QObject *parse_escape(JSONParserContext *ctxt, va_list *ap)
+static QObject *parse_interpolation(JSONParserContext *ctxt, va_list *ap)
 {
     JSONToken *token;
 
@@ -432,7 +432,7 @@ static QObject *parse_escape(JSONParserContext *ctxt, va_list *ap)
     }
 
     token = parser_context_pop_token(ctxt);
-    assert(token && token->type == JSON_ESCAPE);
+    assert(token && token->type == JSON_INTERPOL);
 
     if (!strcmp(token->str, "%p")) {
         return va_arg(*ap, QObject *);
@@ -527,8 +527,8 @@ static QObject *parse_value(JSONParserContext *ctxt, va_list *ap)
         return parse_object(ctxt, ap);
     case JSON_LSQUARE:
         return parse_array(ctxt, ap);
-    case JSON_ESCAPE:
-        return parse_escape(ctxt, ap);
+    case JSON_INTERPOL:
+        return parse_interpolation(ctxt, ap);
     case JSON_INTEGER:
     case JSON_FLOAT:
     case JSON_STRING:
-- 
2.17.1
