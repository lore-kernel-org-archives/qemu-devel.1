Received: from eggs.gnu.org ([2001:4830:134:3::10]:45094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d8942-0005Sw-0I
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d8941-0003TD-Ah
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d8941-0003St-4m
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25B3AC04B302
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:36:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:44 +0300
Message-Id: <20170509173559.31598-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/17] object: fix potential leak in getters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

If the property is not of the requested type, the getters will leak a
QObject.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.13.0.rc1.16.gd80b50c3f
