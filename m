Received: from eggs.gnu.org ([2001:4830:134:3::10]:46045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FAY-0003TU-9v
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FAT-0004Tn-Ao
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6FAT-0004TU-2o
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:33 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:19 +0400
Message-Id: <20170504114232.20318-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/21] char: remove qemu_chardev_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

qemu_chardev_new() now uses object_new_with_props() with /chardevs
parent container. It will fail to insert the object if the same "id"
already exists. "chardevs" list usage has been removed in previous
commits.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 1859680bea..276d27f403 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -805,26 +805,6 @@ static const ChardevClass *char_get_class(const char=
 *driver, Error **errp)
     return cc;
 }
=20
-static Chardev *qemu_chardev_add(const char *id, const char *typename,
-                                 ChardevBackend *backend, Error **errp)
-{
-    Chardev *chr;
-
-    chr =3D qemu_chr_find(id);
-    if (chr) {
-        error_setg(errp, "Chardev '%s' already exists", id);
-        return NULL;
-    }
-
-    chr =3D qemu_chardev_new(id, typename, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-
-    QTAILQ_INSERT_TAIL(&chardevs, chr, next);
-    return chr;
-}
-
 static const struct ChardevAlias {
     const char *typename;
     const char *alias;
@@ -941,9 +921,10 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         backend->u.null.data =3D ccom; /* Any ChardevCommon member would=
 work */
     }
=20
-    chr =3D qemu_chardev_add(bid ? bid : id,
+    chr =3D qemu_chardev_new(bid ? bid : id,
                            object_class_get_name(OBJECT_CLASS(cc)),
                            backend, errp);
+
     if (chr =3D=3D NULL) {
         goto out;
     }
@@ -955,7 +936,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         backend->type =3D CHARDEV_BACKEND_KIND_MUX;
         backend->u.mux.data =3D g_new0(ChardevMux, 1);
         backend->u.mux.data->chardev =3D g_strdup(bid);
-        mux =3D qemu_chardev_add(id, TYPE_CHARDEV_MUX, backend, errp);
+        mux =3D qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, errp);
         if (mux =3D=3D NULL) {
             object_unparent(OBJECT(chr));
             chr =3D NULL;
@@ -1289,7 +1270,7 @@ ChardevReturn *qmp_chardev_add(const char *id, Char=
devBackend *backend,
         return NULL;
     }
=20
-    chr =3D qemu_chardev_add(id, object_class_get_name(OBJECT_CLASS(cc))=
,
+    chr =3D qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc))=
,
                            backend, errp);
     if (!chr) {
         return NULL;
--=20
2.12.0.191.gc5d8de91d
