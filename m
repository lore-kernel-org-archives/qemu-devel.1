Received: from eggs.gnu.org ([2001:4830:134:3::10]:39369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cJ-0003Ox-RU
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cH-0004Wd-Kg
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk3cH-0004WR-G5
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:21 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 30 Jul 2018 10:33:03 +0200
Message-Id: <20180730083317.11765-10-armbru@redhat.com>
In-Reply-To: <20180730083317.11765-1-armbru@redhat.com>
References: <20180730083317.11765-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/23] qobject: qobject_from_jsonv() is
 dangerous, hide it away
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

qobject_from_jsonv() takes ownership of %p arguments.  On failure, we
can't generally know whether we failed before or after %p, so
ownership becomes indeterminate.  To avoid leaks, callers passing %p
must terminate on error, e.g. by passing &error_abort.  Trap for the
unwary; document and give the function internal linkage.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qjson.h |  2 --
 qobject/qjson.c          | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
index dce78583dc..5ebbe5a118 100644
--- a/include/qapi/qmp/qjson.h
+++ b/include/qapi/qmp/qjson.h
@@ -15,8 +15,6 @@
 #define QJSON_H
=20
 QObject *qobject_from_json(const char *string, Error **errp);
-QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **err=
p)
-    GCC_FMT_ATTR(1, 0);
=20
 QObject *qobject_from_vjsonf_nofail(const char *string, va_list ap)
     GCC_FMT_ATTR(1, 0);
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 2e450231ff..ab4040f235 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -39,7 +39,18 @@ static void parse_json(JSONMessageParser *parser, GQue=
ue *tokens)
     s->result =3D json_parser_parse_err(tokens, s->ap, &s->err);
 }
=20
-QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **err=
p)
+/*
+ * Parse @string as JSON value.
+ * If @ap is non-null, interpolate %-escapes.
+ * Takes ownership of %p arguments.
+ * On success, return the JSON value.
+ * On failure, store an error through @errp and return NULL.
+ * Ownership of %p arguments becomes indeterminate then.  To avoid
+ * leaks, callers passing %p must terminate on error, e.g. by passing
+ * &error_abort.
+ */
+static QObject *qobject_from_jsonv(const char *string, va_list *ap,
+                                   Error **errp)
 {
     JSONParsingState state =3D {};
=20
--=20
2.17.1
