Received: from eggs.gnu.org ([2001:4830:134:3::10]:48595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f1Anp-00061W-DJ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f1Anf-0003iS-OX
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:07:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f1Anf-0003hu-JO
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:07:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CB738182D1D
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 13:07:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Mar 2018 15:07:21 +0200
Message-Id: <20180328130723.20831-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180328130723.20831-1-marcandre.lureau@redhat.com>
References: <20180328130723.20831-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/3] qobject: ensure base is at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

All QObject types have the base QObject as first field. This allows to
simplify qobject_to() and will allow further simplification in
following patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qobject.h | 5 ++---
 qobject/qobject.c          | 9 +++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index e022707578..5206ff9ee1 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -61,9 +61,8 @@ struct QObject {
 QEMU_BUILD_BUG_MSG(QTYPE__MAX !=3D 7,
                    "The QTYPE_CAST_TO_* list needs to be extended");
=20
-#define qobject_to(type, obj) ({ \
-    QObject *_tmp =3D qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)=
); \
-    _tmp ? container_of(_tmp, type, base) : (type *)NULL; })
+#define qobject_to(type, obj)                                       \
+    ((type *)qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)))
=20
 /* Initialize an object to default values */
 static inline void qobject_init(QObject *obj, QType type)
diff --git a/qobject/qobject.c b/qobject/qobject.c
index 23600aa1c1..87649c5be5 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -16,6 +16,15 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
=20
+QEMU_BUILD_BUG_MSG(
+    offsetof(QNull, base) !=3D 0 ||
+    offsetof(QNum, base) !=3D 0 ||
+    offsetof(QString, base) !=3D 0 ||
+    offsetof(QDict, base) !=3D 0 ||
+    offsetof(QList, base) !=3D 0 ||
+    offsetof(QBool, base) !=3D 0,
+    "base qobject must be at offset 0");
+
 static void (*qdestroy[QTYPE__MAX])(QObject *) =3D {
     [QTYPE_NONE] =3D NULL,               /* No such object exists */
     [QTYPE_QNULL] =3D NULL,              /* qnull_ is indestructible */
--=20
2.17.0.rc1.1.g4c4f2b46a3
