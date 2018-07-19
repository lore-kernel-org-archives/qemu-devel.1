Received: from eggs.gnu.org ([2001:4830:134:3::10]:48872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrs-0001ic-Ig
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrq-0007sW-NV
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40744 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgDrq-0007rv-FW
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E89507263A
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 18:41:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Jul 2018 20:41:03 +0200
Message-Id: <20180719184111.5129-11-marcandre.lureau@redhat.com>
In-Reply-To: <20180719184111.5129-1-marcandre.lureau@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/18] qjson: report an error if there are
 multiple results
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

qobject_from_jsonv() returns a single object. Let's make sure that
during parsing we don't leak an intermediary object. Instead of
returning the last object, set a parsing error.

Also, the lexer/parser keeps consuming all the data. There might be an
error set earlier. Let's keep it and not call json_parser_parse() with
the remaining data. Eventually, we may teach the message parser to
stop consuming the data.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/qjson.c     | 16 +++++++++++++++-
 tests/check-qjson.c | 11 +++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/qobject/qjson.c b/qobject/qjson.c
index ee04e61096..8a9d116150 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -22,6 +22,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qerror.h"
 #include "qemu/unicode.h"
=20
 typedef struct JSONParsingState
@@ -36,7 +37,20 @@ static void parse_json(JSONMessageParser *parser, GQue=
ue *tokens)
 {
     JSONParsingState *s =3D container_of(parser, JSONParsingState, parse=
r);
=20
-    s->result =3D json_parser_parse(tokens, s->ap, &s->err);
+    if (s->result || s->err) {
+        if (s->result) {
+            qobject_unref(s->result);
+            s->result =3D NULL;
+            if (!s->err) {
+                error_setg(&s->err, QERR_JSON_PARSING);
+            }
+        }
+        if (tokens) {
+            g_queue_free_full(tokens, g_free);
+        }
+    } else {
+        s->result =3D json_parser_parse(tokens, s->ap, &s->err);
+    }
 }
=20
 QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **err=
p)
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index da582df3e9..7d3547e0cc 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1417,6 +1417,16 @@ static void limits_nesting(void)
     g_assert(obj =3D=3D NULL);
 }
=20
+static void multiple_objects(void)
+{
+    Error *err =3D NULL;
+    QObject *obj;
+
+    obj =3D qobject_from_json("{} {}", &err);
+    g_assert(obj =3D=3D NULL);
+    error_free_or_abort(&err);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -1454,6 +1464,7 @@ int main(int argc, char **argv)
     g_test_add_func("/errors/invalid_dict_comma", invalid_dict_comma);
     g_test_add_func("/errors/unterminated/literal", unterminated_literal=
);
     g_test_add_func("/errors/limits/nesting", limits_nesting);
+    g_test_add_func("/errors/multiple_objects", multiple_objects);
=20
     return g_test_run();
 }
--=20
2.18.0.129.ge3331758f1
