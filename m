Received: from eggs.gnu.org ([2001:4830:134:3::10]:33282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHok-0002Ij-2y
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHof-0001i3-8N
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40744 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoe-0001cF-HY
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 526EF40241EA
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 144B82026E18
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:45 +0200
Message-Id: <20180824193206.25475-38-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 37/58] json: Rename token JSON_ESCAPE & friends
 to JSON_INTERP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The JSON parser optionally supports interpolation.  The code calls it
"escape".  Awkward, because it uses the same term for escape sequences
within strings.  The latter usage is consistent with RFC 8259 "The
JavaScript Object Notation (JSON) Data Interchange Format" and ISO C.
Call the former "interpolation" instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-38-armbru@redhat.com>
---
 include/qapi/qmp/json-lexer.h |  2 +-
 qobject/json-lexer.c          | 64 +++++++++++++++++------------------
 qobject/json-parser.c         |  8 ++---
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/include/qapi/qmp/json-lexer.h b/include/qapi/qmp/json-lexer.h
index 44bcf2ca64..8bce6ef676 100644
--- a/include/qapi/qmp/json-lexer.h
+++ b/include/qapi/qmp/json-lexer.h
@@ -27,7 +27,7 @@ typedef enum json_token_type {
     JSON_FLOAT,
     JSON_KEYWORD,
     JSON_STRING,
-    JSON_ESCAPE,
+    JSON_INTERP,
     JSON_SKIP,
     JSON_ERROR,
 } JSONTokenType;
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 17272a3874..5436809be6 100644
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
+    IN_INTERP,
+    IN_INTERP_L,
+    IN_INTERP_LL,
+    IN_INTERP_I,
+    IN_INTERP_I6,
+    IN_INTERP_I64,
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
+    [IN_INTERP_LL] = {
+        ['d'] = JSON_INTERP,
+        ['u'] = JSON_INTERP,
     },
 
-    [IN_ESCAPE_L] = {
-        ['d'] = JSON_ESCAPE,
-        ['l'] = IN_ESCAPE_LL,
-        ['u'] = JSON_ESCAPE,
+    [IN_INTERP_L] = {
+        ['d'] = JSON_INTERP,
+        ['l'] = IN_INTERP_LL,
+        ['u'] = JSON_INTERP,
     },
 
-    [IN_ESCAPE_I64] = {
-        ['d'] = JSON_ESCAPE,
-        ['u'] = JSON_ESCAPE,
+    [IN_INTERP_I64] = {
+        ['d'] = JSON_INTERP,
+        ['u'] = JSON_INTERP,
     },
 
-    [IN_ESCAPE_I6] = {
-        ['4'] = IN_ESCAPE_I64,
+    [IN_INTERP_I6] = {
+        ['4'] = IN_INTERP_I64,
     },
 
-    [IN_ESCAPE_I] = {
-        ['6'] = IN_ESCAPE_I6,
+    [IN_INTERP_I] = {
+        ['6'] = IN_INTERP_I6,
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
+    [IN_INTERP] = {
+        ['d'] = JSON_INTERP,
+        ['i'] = JSON_INTERP,
+        ['p'] = JSON_INTERP,
+        ['s'] = JSON_INTERP,
+        ['u'] = JSON_INTERP,
+        ['f'] = JSON_INTERP,
+        ['l'] = IN_INTERP_L,
+        ['I'] = IN_INTERP_I,
     },
 
     /* top level rule */
@@ -271,7 +271,7 @@ static const uint8_t json_lexer[][256] =  {
         [','] = JSON_COMMA,
         [':'] = JSON_COLON,
         ['a' ... 'z'] = IN_KEYWORD,
-        ['%'] = IN_ESCAPE,
+        ['%'] = IN_INTERP,
         [' '] = IN_WHITESPACE,
         ['\t'] = IN_WHITESPACE,
         ['\r'] = IN_WHITESPACE,
@@ -311,7 +311,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         case JSON_RSQUARE:
         case JSON_COLON:
         case JSON_COMMA:
-        case JSON_ESCAPE:
+        case JSON_INTERP:
         case JSON_INTEGER:
         case JSON_FLOAT:
         case JSON_KEYWORD:
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 06aff19a5d..864cb578d8 100644
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
+    assert(token && token->type == JSON_INTERP);
 
     if (!strcmp(token->str, "%p")) {
         return va_arg(*ap, QObject *);
@@ -527,8 +527,8 @@ static QObject *parse_value(JSONParserContext *ctxt, va_list *ap)
         return parse_object(ctxt, ap);
     case JSON_LSQUARE:
         return parse_array(ctxt, ap);
-    case JSON_ESCAPE:
-        return parse_escape(ctxt, ap);
+    case JSON_INTERP:
+        return parse_interpolation(ctxt, ap);
     case JSON_INTEGER:
     case JSON_FLOAT:
     case JSON_STRING:
-- 
2.17.1
