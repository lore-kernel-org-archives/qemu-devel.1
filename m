Received: from eggs.gnu.org ([2001:4830:134:3::10]:46324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKJ-00037F-Ko
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKF-0001mQ-Mq
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKE-0001iz-UV
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:30 +0200
Message-Id: <20180817150559.16243-32-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 31/60] json-parser: simplify and avoid
 JSONParserContext allocation
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

parser_context_new/free() are only used from json_parser_parse(). We
can fold the code there and avoid an allocation altogether.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180719184111.5129-9-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 35c201c53f..a25f2bfca2 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -237,33 +237,6 @@ static JSONToken *parser_context_peek_token(JSONPars=
erContext *ctxt)
     return g_queue_peek_head(ctxt->buf);
 }
=20
-static JSONParserContext *parser_context_new(GQueue *tokens)
-{
-    JSONParserContext *ctxt;
-
-    if (!tokens) {
-        return NULL;
-    }
-
-    ctxt =3D g_malloc0(sizeof(JSONParserContext));
-    ctxt->buf =3D tokens;
-
-    return ctxt;
-}
-
-/* to support error propagation, ctxt->err must be freed separately */
-static void parser_context_free(JSONParserContext *ctxt)
-{
-    if (ctxt) {
-        while (!g_queue_is_empty(ctxt->buf)) {
-            parser_context_pop_token(ctxt);
-        }
-        g_free(ctxt->current);
-        g_queue_free(ctxt->buf);
-        g_free(ctxt);
-    }
-}
-
 /**
  * Parsing rules
  */
@@ -575,18 +548,22 @@ QObject *json_parser_parse(GQueue *tokens, va_list =
*ap)
=20
 QObject *json_parser_parse_err(GQueue *tokens, va_list *ap, Error **errp=
)
 {
-    JSONParserContext *ctxt =3D parser_context_new(tokens);
+    JSONParserContext ctxt =3D { .buf =3D tokens };
     QObject *result;
=20
-    if (!ctxt) {
+    if (!tokens) {
         return NULL;
     }
=20
-    result =3D parse_value(ctxt, ap);
+    result =3D parse_value(&ctxt, ap);
=20
-    error_propagate(errp, ctxt->err);
+    error_propagate(errp, ctxt.err);
=20
-    parser_context_free(ctxt);
+    while (!g_queue_is_empty(ctxt.buf)) {
+        parser_context_pop_token(&ctxt);
+    }
+    g_free(ctxt.current);
+    g_queue_free(ctxt.buf);
=20
     return result;
 }
--=20
2.17.1
