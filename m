Received: from eggs.gnu.org ([2001:4830:134:3::10]:50555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmV-0000rJ-Bm
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmM-0005Dz-Fu
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmE-00059K-Mj
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DA5F406C7A0
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B4E8112D197
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:43 +0200
Message-Id: <20180816083701.3932-8-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/25] qobject: New qobject_from_vjsonf_nofail(),
 qdict_from_vjsonf_nofail()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Every printf()-like function sooner or later needs its vprintf()-like
buddy.  The next commit will need qobject_from_jsonf_nofail()'s buddy,
and qdict_from_jsonf_nofail()'s buddy will be used later in this
series.  Add both.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180806065344.7103-8-armbru@redhat.com>
---
 include/qapi/qmp/qjson.h |  4 ++++
 qobject/qjson.c          | 44 +++++++++++++++++++++++++++++++++-------
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
index dc509d51ae..dce78583dc 100644
--- a/include/qapi/qmp/qjson.h
+++ b/include/qapi/qmp/qjson.h
@@ -18,8 +18,12 @@ QObject *qobject_from_json(const char *string, Error *=
*errp);
 QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **err=
p)
     GCC_FMT_ATTR(1, 0);
=20
+QObject *qobject_from_vjsonf_nofail(const char *string, va_list ap)
+    GCC_FMT_ATTR(1, 0);
 QObject *qobject_from_jsonf_nofail(const char *string, ...)
     GCC_FMT_ATTR(1, 2);
+QDict *qdict_from_vjsonf_nofail(const char *string, va_list ap)
+    GCC_FMT_ATTR(1, 0);
 QDict *qdict_from_jsonf_nofail(const char *string, ...)
     GCC_FMT_ATTR(1, 2);
=20
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 4a9dcff343..2e450231ff 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -59,6 +59,25 @@ QObject *qobject_from_json(const char *string, Error *=
*errp)
     return qobject_from_jsonv(string, NULL, errp);
 }
=20
+/*
+ * Parse @string as JSON value with %-escapes interpolated.
+ * Abort on error.  Do not use with untrusted @string.
+ * Return the resulting QObject.  It is never null.
+ */
+QObject *qobject_from_vjsonf_nofail(const char *string, va_list ap)
+{
+    va_list ap_copy;
+    QObject *obj;
+
+    /* va_copy() is needed when va_list is an array type */
+    va_copy(ap_copy, ap);
+    obj =3D qobject_from_jsonv(string, &ap_copy, &error_abort);
+    va_end(ap_copy);
+
+    assert(obj);
+    return obj;
+}
+
 /*
  * Parse @string as JSON value with %-escapes interpolated.
  * Abort on error.  Do not use with untrusted @string.
@@ -70,13 +89,26 @@ QObject *qobject_from_jsonf_nofail(const char *string=
, ...)
     va_list ap;
=20
     va_start(ap, string);
-    obj =3D qobject_from_jsonv(string, &ap, &error_abort);
+    obj =3D qobject_from_vjsonf_nofail(string, ap);
     va_end(ap);
=20
-    assert(obj);
     return obj;
 }
=20
+/*
+ * Parse @string as JSON object with %-escapes interpolated.
+ * Abort on error.  Do not use with untrusted @string.
+ * Return the resulting QDict.  It is never null.
+ */
+QDict *qdict_from_vjsonf_nofail(const char *string, va_list ap)
+{
+    QDict *qdict;
+
+    qdict =3D qobject_to(QDict, qobject_from_vjsonf_nofail(string, ap));
+    assert(qdict);
+    return qdict;
+}
+
 /*
  * Parse @string as JSON object with %-escapes interpolated.
  * Abort on error.  Do not use with untrusted @string.
@@ -84,15 +116,13 @@ QObject *qobject_from_jsonf_nofail(const char *strin=
g, ...)
  */
 QDict *qdict_from_jsonf_nofail(const char *string, ...)
 {
-    QDict *obj;
+    QDict *qdict;
     va_list ap;
=20
     va_start(ap, string);
-    obj =3D qobject_to(QDict, qobject_from_jsonv(string, &ap, &error_abo=
rt));
+    qdict =3D qdict_from_vjsonf_nofail(string, ap);
     va_end(ap);
-
-    assert(obj);
-    return obj;
+    return qdict;
 }
=20
 typedef struct ToJsonIterState
--=20
2.17.1
