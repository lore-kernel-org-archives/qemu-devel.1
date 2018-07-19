Received: from eggs.gnu.org ([2001:4830:134:3::10]:48962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDs0-0001of-Ms
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDry-0007vD-26
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgDrv-0007ud-7b
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C81887263A
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 18:41:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Jul 2018 20:41:05 +0200
Message-Id: <20180719184111.5129-13-marcandre.lureau@redhat.com>
In-Reply-To: <20180719184111.5129-1-marcandre.lureau@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/18] qjson: return parsing error if
 unterminated input
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/json-streamer.c | 4 +++-
 qobject/qjson.c         | 5 ++++-
 tests/check-qjson.c     | 8 ++++----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index c51c2021f9..065c551332 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -126,7 +126,9 @@ int json_message_parser_feed(JSONMessageParser *parse=
r,
=20
 int json_message_parser_flush(JSONMessageParser *parser)
 {
-    return json_lexer_flush(&parser->lexer);
+    int ret =3D json_lexer_flush(&parser->lexer);
+
+    return ret ?: g_queue_get_length(parser->tokens);
 }
=20
 void json_message_parser_destroy(JSONMessageParser *parser)
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 01218c9ad6..8afdc1e06a 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -64,7 +64,10 @@ QObject *qobject_from_jsonv(const char *string, va_lis=
t *ap, Error **errp)
=20
     json_message_parser_init(&state.parser, parse_json);
     json_message_parser_feed(&state.parser, string, strlen(string));
-    json_message_parser_flush(&state.parser);
+    if (json_message_parser_flush(&state.parser) !=3D 0 &&
+        !state.err) {
+        error_setg(&state.err, QERR_JSON_PARSING);
+    }
     json_message_parser_destroy(&state.parser);
=20
     error_propagate(errp, state.err);
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index e602abda11..d0144ba93c 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1339,7 +1339,7 @@ static void unterminated_array(void)
 {
     Error *err =3D NULL;
     QObject *obj =3D qobject_from_json("[32", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj =3D=3D NULL);
 }
=20
@@ -1347,7 +1347,7 @@ static void unterminated_array_comma(void)
 {
     Error *err =3D NULL;
     QObject *obj =3D qobject_from_json("[32,", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj =3D=3D NULL);
 }
=20
@@ -1363,7 +1363,7 @@ static void unterminated_dict(void)
 {
     Error *err =3D NULL;
     QObject *obj =3D qobject_from_json("{'abc':32", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj =3D=3D NULL);
 }
=20
@@ -1371,7 +1371,7 @@ static void unterminated_dict_comma(void)
 {
     Error *err =3D NULL;
     QObject *obj =3D qobject_from_json("{'abc':32,", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj =3D=3D NULL);
 }
=20
--=20
2.18.0.129.ge3331758f1
