Received: from eggs.gnu.org ([2001:4830:134:3::10]:50611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmf-0000yo-I6
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmV-0005HJ-Cx
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmM-00059H-Ek
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 774D2406C77F
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 532C920180F5
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:46 +0200
Message-Id: <20180816083701.3932-11-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/25] qobject: qobject_from_jsonv() is
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

qobject_from_jsonv() takes ownership of %p arguments.  On failure, we
can't generally know whether we failed before or after %p, so
ownership becomes indeterminate.  To avoid leaks, callers passing %p
must terminate on error, e.g. by passing &error_abort.  Trap for the
unwary; document and give the function internal linkage.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180806065344.7103-11-armbru@redhat.com>
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
