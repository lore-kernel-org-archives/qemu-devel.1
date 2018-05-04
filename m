Received: from eggs.gnu.org ([2001:4830:134:3::10]:49596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViI-00053q-Fb
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViC-0001Wf-Fg
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fEViC-0001Uq-2D
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 292254040856
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:04:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  4 May 2018 10:04:46 +0200
Message-Id: <20180504080454.11014-3-armbru@redhat.com>
In-Reply-To: <20180504080454.11014-1-armbru@redhat.com>
References: <20180504080454.11014-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/10] qobject: Ensure base is at offset 0
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

All QObject types have the base QObject as their first field. This
allows the simplification of qobject_to().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180419150145.24795-2-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message paragraph on type casts dropped, to avoid giving the
impression type casting would be okay]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.13.6
