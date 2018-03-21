Received: from eggs.gnu.org ([2001:4830:134:3::10]:50767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eydyR-0007pz-K2
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eydyQ-0000Jn-Dd
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:40:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eydyQ-0000JO-8f
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:40:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDFC8A27E3
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 13:40:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 14:40:04 +0100
Message-Id: <20180321134005.8822-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180321134005.8822-1-marcandre.lureau@redhat.com>
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] qobject: assume base of a qobject is at
 offset 0
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

Simplify casting to QObject by not requiring the definition of the
type and assuming base QObject is at offset 0. Add a static check for
this.

Use the QEMU_GENERIC macro for keeping type safety check and error
when given an unknown type.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qobject.h | 36 ++++++++++++++++++++++++++++++++++--
 qobject/qobject.c          |  9 +++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index e022707578..d0aead35ec 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -39,8 +39,40 @@ struct QObject {
     size_t refcnt;
 };
=20
-/* Get the 'base' part of an object */
-#define QOBJECT(obj) (&(obj)->base)
+/* This function gives an error if an invalid pointer type is passed
+ * to QOBJECT.  For optimized builds, we can rely on dead-code
+ * elimination from the compiler, and give the errors already at link
+ * time.
+ */
+#if defined(__OPTIMIZE__) && !defined(__SANITIZE_ADDRESS__)
+const void * qobject_unknown_type(const void *);
+#else
+static inline const void *
+qobject_unknown_type(const void *unused)
+{
+    abort();
+    return NULL;
+}
+#endif
+
+/* A typecast, checking for the type of arguments */
+/* QObject is at offset 0, for all QObject-derived types */
+#define QOBJECT(x) QEMU_GENERIC(x,              \
+    (QNull *, (QObject *) x),                   \
+    (const QNull *, (const QObject *) x),       \
+    (QNum *, (QObject *) x),                    \
+    (const QNum *, (const QObject *) x),        \
+    (QString *, (QObject *) x),                 \
+    (const QString *, (const QObject *) x),     \
+    (QDict *, (QObject *) x),                   \
+    (const QDict *, (const QObject *) x),       \
+    (QList *, (QObject *) x),                   \
+    (const QList *, (const QObject *) x),       \
+    (QBool *, (QObject *) x),                   \
+    (const QBool *, (const QObject *) x),       \
+    (QObject *, x),                             \
+    (const QObject *, x),                       \
+    qobject_unknown_type(x))
=20
 /* High-level interface for qobject_incref() */
 #define QINCREF(obj)      \
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
2.16.2.521.g9aa15f885a
