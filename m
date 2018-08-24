Received: from eggs.gnu.org ([2001:4830:134:3::10]:33280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHok-0002Ii-2h
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHof-0001hy-6x
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoe-0001eG-Hx
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0850401D780
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:40 +0200
Message-Id: <20180824193206.25475-33-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/58] json-parser: simplify and avoid
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

parser_context_new/free() are only used from json_parser_parse(). We
can fold the code there and avoid an allocation altogether.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180719184111.5129-9-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180823164025.12553-33-armbru@redhat.com>
---
 qobject/json-parser.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 73e6ad7458..7bfa08200c 100644
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
