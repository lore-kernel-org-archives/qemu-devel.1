Received: from eggs.gnu.org ([2001:4830:134:3::10]:58509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzM-0001qq-MB
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzI-0002Mw-O8
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:38 +0400
Message-Id: <20170311132256.22951-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/21] object: fix potential leak in getters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org

If the property is not of the requested type, the getters will leak a
QObject.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Cc: qemu-trivial@nongnu.org
---
 qom/object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index eb4bc924ff..c7b8079df6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1122,7 +1122,7 @@ char *object_property_get_str(Object *obj, const ch=
ar *name,
         retval =3D g_strdup(qstring_get_str(qstring));
     }
=20
-    QDECREF(qstring);
+    qobject_decref(ret);
     return retval;
 }
=20
@@ -1183,7 +1183,7 @@ bool object_property_get_bool(Object *obj, const ch=
ar *name,
         retval =3D qbool_get_bool(qbool);
     }
=20
-    QDECREF(qbool);
+    qobject_decref(ret);
     return retval;
 }
=20
@@ -1214,7 +1214,7 @@ int64_t object_property_get_int(Object *obj, const =
char *name,
         retval =3D qint_get_int(qint);
     }
=20
-    QDECREF(qint);
+    qobject_decref(ret);
     return retval;
 }
=20
--=20
2.12.0.191.gc5d8de91d
