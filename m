Received: from eggs.gnu.org ([2001:4830:134:3::10]:35589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskU-0000Y4-EL
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskM-0006Me-6p
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsskL-0006Lf-S6
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:40:22 +0200
Message-Id: <20180823164025.12553-56-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 55/58] json: Keep interpolation state in
 JSONParserContext
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

The recursive descent parser passes along a pointer to
JSONParserContext.  It additionally passes a pointer to interpolation
state (a va_alist *) as needed to reach its consumer
parse_interpolation().

Stuffing the latter pointer into JSONParserContext saves us the
trouble of passing it along, so do that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-parser.c | 59 ++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7449684f1c..273f448a52 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -36,6 +36,7 @@ typedef struct JSONParserContext
     Error *err;
     JSONToken *current;
     GQueue *buf;
+    va_list *ap;
 } JSONParserContext;
 
 #define BUG_ON(cond) assert(!(cond))
@@ -49,7 +50,7 @@ typedef struct JSONParserContext
  * 4) deal with premature EOI
  */
 
-static QObject *parse_value(JSONParserContext *ctxt, va_list *ap);
+static QObject *parse_value(JSONParserContext *ctxt);
 
 /**
  * Error handler
@@ -243,7 +244,7 @@ static JSONToken *parser_context_peek_token(JSONParserContext *ctxt)
 /**
  * Parsing rules
  */
-static int parse_pair(JSONParserContext *ctxt, QDict *dict, va_list *ap)
+static int parse_pair(JSONParserContext *ctxt, QDict *dict)
 {
     QObject *value;
     QString *key = NULL;
@@ -255,7 +256,7 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict, va_list *ap)
         goto out;
     }
 
-    key = qobject_to(QString, parse_value(ctxt, ap));
+    key = qobject_to(QString, parse_value(ctxt));
     if (!key) {
         parse_error(ctxt, peek, "key is not a string in object");
         goto out;
@@ -272,7 +273,7 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict, va_list *ap)
         goto out;
     }
 
-    value = parse_value(ctxt, ap);
+    value = parse_value(ctxt);
     if (value == NULL) {
         parse_error(ctxt, token, "Missing value in dict");
         goto out;
@@ -290,7 +291,7 @@ out:
     return -1;
 }
 
-static QObject *parse_object(JSONParserContext *ctxt, va_list *ap)
+static QObject *parse_object(JSONParserContext *ctxt)
 {
     QDict *dict = NULL;
     JSONToken *token, *peek;
@@ -307,7 +308,7 @@ static QObject *parse_object(JSONParserContext *ctxt, va_list *ap)
     }
 
     if (peek->type != JSON_RCURLY) {
-        if (parse_pair(ctxt, dict, ap) == -1) {
+        if (parse_pair(ctxt, dict) == -1) {
             goto out;
         }
 
@@ -323,7 +324,7 @@ static QObject *parse_object(JSONParserContext *ctxt, va_list *ap)
                 goto out;
             }
 
-            if (parse_pair(ctxt, dict, ap) == -1) {
+            if (parse_pair(ctxt, dict) == -1) {
                 goto out;
             }
 
@@ -344,7 +345,7 @@ out:
     return NULL;
 }
 
-static QObject *parse_array(JSONParserContext *ctxt, va_list *ap)
+static QObject *parse_array(JSONParserContext *ctxt)
 {
     QList *list = NULL;
     JSONToken *token, *peek;
@@ -363,7 +364,7 @@ static QObject *parse_array(JSONParserContext *ctxt, va_list *ap)
     if (peek->type != JSON_RSQUARE) {
         QObject *obj;
 
-        obj = parse_value(ctxt, ap);
+        obj = parse_value(ctxt);
         if (obj == NULL) {
             parse_error(ctxt, token, "expecting value");
             goto out;
@@ -383,7 +384,7 @@ static QObject *parse_array(JSONParserContext *ctxt, va_list *ap)
                 goto out;
             }
 
-            obj = parse_value(ctxt, ap);
+            obj = parse_value(ctxt);
             if (obj == NULL) {
                 parse_error(ctxt, token, "expecting value");
                 goto out;
@@ -426,7 +427,7 @@ static QObject *parse_keyword(JSONParserContext *ctxt)
     return NULL;
 }
 
-static QObject *parse_interpolation(JSONParserContext *ctxt, va_list *ap)
+static QObject *parse_interpolation(JSONParserContext *ctxt)
 {
     JSONToken *token;
 
@@ -434,29 +435,29 @@ static QObject *parse_interpolation(JSONParserContext *ctxt, va_list *ap)
     assert(token && token->type == JSON_INTERP);
 
     if (!strcmp(token->str, "%p")) {
-        return va_arg(*ap, QObject *);
+        return va_arg(*ctxt->ap, QObject *);
     } else if (!strcmp(token->str, "%i")) {
-        return QOBJECT(qbool_from_bool(va_arg(*ap, int)));
+        return QOBJECT(qbool_from_bool(va_arg(*ctxt->ap, int)));
     } else if (!strcmp(token->str, "%d")) {
-        return QOBJECT(qnum_from_int(va_arg(*ap, int)));
+        return QOBJECT(qnum_from_int(va_arg(*ctxt->ap, int)));
     } else if (!strcmp(token->str, "%ld")) {
-        return QOBJECT(qnum_from_int(va_arg(*ap, long)));
+        return QOBJECT(qnum_from_int(va_arg(*ctxt->ap, long)));
     } else if (!strcmp(token->str, "%lld")) {
-        return QOBJECT(qnum_from_int(va_arg(*ap, long long)));
+        return QOBJECT(qnum_from_int(va_arg(*ctxt->ap, long long)));
     } else if (!strcmp(token->str, "%" PRId64)) {
-        return QOBJECT(qnum_from_int(va_arg(*ap, int64_t)));
+        return QOBJECT(qnum_from_int(va_arg(*ctxt->ap, int64_t)));
     } else if (!strcmp(token->str, "%u")) {
-        return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned int)));
+        return QOBJECT(qnum_from_uint(va_arg(*ctxt->ap, unsigned int)));
     } else if (!strcmp(token->str, "%lu")) {
-        return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned long)));
+        return QOBJECT(qnum_from_uint(va_arg(*ctxt->ap, unsigned long)));
     } else if (!strcmp(token->str, "%llu")) {
-        return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned long long)));
+        return QOBJECT(qnum_from_uint(va_arg(*ctxt->ap, unsigned long long)));
     } else if (!strcmp(token->str, "%" PRIu64)) {
-        return QOBJECT(qnum_from_uint(va_arg(*ap, uint64_t)));
+        return QOBJECT(qnum_from_uint(va_arg(*ctxt->ap, uint64_t)));
     } else if (!strcmp(token->str, "%s")) {
-        return QOBJECT(qstring_from_str(va_arg(*ap, const char *)));
+        return QOBJECT(qstring_from_str(va_arg(*ctxt->ap, const char *)));
     } else if (!strcmp(token->str, "%f")) {
-        return QOBJECT(qnum_from_double(va_arg(*ap, double)));
+        return QOBJECT(qnum_from_double(va_arg(*ctxt->ap, double)));
     }
     parse_error(ctxt, token, "invalid interpolation '%s'", token->str);
     return NULL;
@@ -514,7 +515,7 @@ static QObject *parse_literal(JSONParserContext *ctxt)
     }
 }
 
-static QObject *parse_value(JSONParserContext *ctxt, va_list *ap)
+static QObject *parse_value(JSONParserContext *ctxt)
 {
     JSONToken *token;
 
@@ -526,11 +527,11 @@ static QObject *parse_value(JSONParserContext *ctxt, va_list *ap)
 
     switch (token->type) {
     case JSON_LCURLY:
-        return parse_object(ctxt, ap);
+        return parse_object(ctxt);
     case JSON_LSQUARE:
-        return parse_array(ctxt, ap);
+        return parse_array(ctxt);
     case JSON_INTERP:
-        return parse_interpolation(ctxt, ap);
+        return parse_interpolation(ctxt);
     case JSON_INTEGER:
     case JSON_FLOAT:
     case JSON_STRING:
@@ -557,10 +558,10 @@ JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
 
 QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
 {
-    JSONParserContext ctxt = { .buf = tokens };
+    JSONParserContext ctxt = { .buf = tokens, .ap = ap };
     QObject *result;
 
-    result = parse_value(&ctxt, ap);
+    result = parse_value(&ctxt);
     assert(ctxt.err || g_queue_is_empty(ctxt.buf));
 
     error_propagate(errp, ctxt.err);
-- 
2.17.1
