Received: from eggs.gnu.org ([2001:4830:134:3::10]:48871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrs-0001ib-Il
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrp-0007rR-Tc
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgDrl-0007pE-OI
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58F8E7263A
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 18:41:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Jul 2018 20:41:00 +0200
Message-Id: <20180719184111.5129-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180719184111.5129-1-marcandre.lureau@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/18] qmp: drop json_parser_parse() wrapper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Stupid wrapper that's used exactly once, in libqtest.c.  Let's use
json_parser_parse_err() there, and drop the wrapper.  Let's rename
json_parser_parse_err() to json_parser_parse() then.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/json-parser.h | 3 +--
 monitor.c                      | 4 ++--
 qga/main.c                     | 2 +-
 qobject/json-parser.c          | 7 +------
 qobject/qjson.c                | 2 +-
 tests/libqtest.c               | 2 +-
 6 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/qapi/qmp/json-parser.h b/include/qapi/qmp/json-parse=
r.h
index 102f5c0068..a34209db7a 100644
--- a/include/qapi/qmp/json-parser.h
+++ b/include/qapi/qmp/json-parser.h
@@ -16,7 +16,6 @@
=20
 #include "qemu-common.h"
=20
-QObject *json_parser_parse(GQueue *tokens, va_list *ap);
-QObject *json_parser_parse_err(GQueue *tokens, va_list *ap, Error **errp=
);
+QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
=20
 #endif
diff --git a/monitor.c b/monitor.c
index 961779032a..2abb3c2fc7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4113,9 +4113,9 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
     Error *err =3D NULL;
     QMPRequest *req_obj;
=20
-    req =3D json_parser_parse_err(tokens, NULL, &err);
+    req =3D json_parser_parse(tokens, NULL, &err);
     if (!req && !err) {
-        /* json_parser_parse_err() sucks: can fail without setting @err =
*/
+        /* json_parser_parse() sucks: can fail without setting @err */
         error_setg(&err, QERR_JSON_PARSING);
     }
=20
diff --git a/qga/main.c b/qga/main.c
index 87372d40ef..043f7c3ead 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -608,7 +608,7 @@ static void process_event(JSONMessageParser *parser, =
GQueue *tokens)
     g_assert(s && parser);
=20
     g_debug("process_event: called");
-    obj =3D json_parser_parse_err(tokens, NULL, &err);
+    obj =3D json_parser_parse(tokens, NULL, &err);
     if (err) {
         goto err;
     }
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index a5aa790d62..9a7004e680 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -575,12 +575,7 @@ static QObject *parse_value(JSONParserContext *ctxt,=
 va_list *ap)
     }
 }
=20
-QObject *json_parser_parse(GQueue *tokens, va_list *ap)
-{
-    return json_parser_parse_err(tokens, ap, NULL);
-}
-
-QObject *json_parser_parse_err(GQueue *tokens, va_list *ap, Error **errp=
)
+QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
 {
     JSONParserContext *ctxt =3D parser_context_new(tokens);
     QObject *result;
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 2f6a590e44..ee04e61096 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -36,7 +36,7 @@ static void parse_json(JSONMessageParser *parser, GQueu=
e *tokens)
 {
     JSONParsingState *s =3D container_of(parser, JSONParsingState, parse=
r);
=20
-    s->result =3D json_parser_parse_err(tokens, s->ap, &s->err);
+    s->result =3D json_parser_parse(tokens, s->ap, &s->err);
 }
=20
 QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **err=
p)
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 098af6aec4..3826b8baf3 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -432,7 +432,7 @@ static void qmp_response(JSONMessageParser *parser, G=
Queue *tokens)
     QMPResponseParser *qmp =3D container_of(parser, QMPResponseParser, p=
arser);
     QObject *obj;
=20
-    obj =3D json_parser_parse(tokens, NULL);
+    obj =3D json_parser_parse(tokens, NULL, NULL);
     if (!obj) {
         fprintf(stderr, "QMP JSON response parsing failed\n");
         exit(1);
--=20
2.18.0.129.ge3331758f1
