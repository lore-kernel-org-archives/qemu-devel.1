Received: from eggs.gnu.org ([2001:4830:134:3::10]:48901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrt-0001jI-In
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrs-0007tC-52
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54320 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgDrs-0007t7-0S
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83D2D401C090
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 18:41:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Jul 2018 20:41:04 +0200
Message-Id: <20180719184111.5129-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180719184111.5129-1-marcandre.lureau@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/18] qjson: report error on unterminated
 string
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

An unterminated string will make parser emit an error (tokens =3D=3D
NULL). Let's report it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/qjson.c     | 3 +++
 tests/check-qjson.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/qobject/qjson.c b/qobject/qjson.c
index 8a9d116150..01218c9ad6 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -37,6 +37,9 @@ static void parse_json(JSONMessageParser *parser, GQueu=
e *tokens)
 {
     JSONParsingState *s =3D container_of(parser, JSONParsingState, parse=
r);
=20
+    if (!tokens && !s->err) {
+        error_setg(&s->err, QERR_JSON_PARSING);
+    }
     if (s->result || s->err) {
         if (s->result) {
             qobject_unref(s->result);
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 7d3547e0cc..e602abda11 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1315,7 +1315,7 @@ static void unterminated_string(void)
 {
     Error *err =3D NULL;
     QObject *obj =3D qobject_from_json("\"abc", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj =3D=3D NULL);
 }
=20
@@ -1323,7 +1323,7 @@ static void unterminated_sq_string(void)
 {
     Error *err =3D NULL;
     QObject *obj =3D qobject_from_json("'abc", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj =3D=3D NULL);
 }
=20
@@ -1331,7 +1331,7 @@ static void unterminated_escape(void)
 {
     Error *err =3D NULL;
     QObject *obj =3D qobject_from_json("\"abc\\\"", &err);
-    g_assert(!err);             /* BUG */
+    error_free_or_abort(&err);
     g_assert(obj =3D=3D NULL);
 }
=20
--=20
2.18.0.129.ge3331758f1
