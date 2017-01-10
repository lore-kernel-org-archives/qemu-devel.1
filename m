Received: from eggs.gnu.org ([2001:4830:134:3::10]:47218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0X4-00055r-Em
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0X3-0007lK-DX
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cR0X3-0007km-5b
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CAE081227
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:48:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 18:47:56 +0100
Message-Id: <20170110174810.17748-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-1-marcandre.lureau@redhat.com>
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/20] char: use a static array for backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Number and kinds of backends is known at compile-time, use a fixed-sized
static array to simplify iterations & lookups. Add an alias field to the
CharDriver structure to cover the cases where we previously registered a
driver twice under two names.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c | 68 ++++++++++++++++++++++++++++++-------------------------=
------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index e00559f31b..f3756a373f 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -4099,21 +4099,20 @@ static void qemu_chr_parse_udp(QemuOpts *opts, Ch=
ardevBackend *backend,
     }
 }
=20
-static GSList *backends;
+static const CharDriver *backends[CHARDEV_BACKEND_KIND__MAX];
=20
 void register_char_driver(const CharDriver *driver)
 {
-    /* casting away const */
-    backends =3D g_slist_append(backends, (void *)driver);
+    backends[driver->kind] =3D driver;
 }
=20
 CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
                                         Error **errp)
 {
     Error *local_err =3D NULL;
-    CharDriver *cd;
+    const CharDriver *cd =3D NULL;
     CharDriverState *chr;
-    GSList *i;
+    int i;
     ChardevReturn *ret =3D NULL;
     ChardevBackend *backend;
     const char *name =3D qemu_opt_get(opts, "backend");
@@ -4128,11 +4127,13 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts =
*opts,
=20
     if (is_help_option(name)) {
         fprintf(stderr, "Available chardev backend types:\n");
-        for (i =3D backends; i; i =3D i->next) {
-            cd =3D i->data;
-            fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind])=
;
-            if (cd->alias) {
-                fprintf(stderr, "%s\n", cd->alias);
+        for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
+            cd =3D backends[i];
+            if (cd) {
+                fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->ki=
nd]);
+                if (cd->alias) {
+                    fprintf(stderr, "%s\n", cd->alias);
+                }
             }
         }
         exit(0);
@@ -4143,15 +4144,17 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts =
*opts,
         goto err;
     }
=20
-    for (i =3D backends; i; i =3D i->next) {
-        cd =3D i->data;
-
+    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
+        cd =3D backends[i];
+        if (!cd) {
+            continue;
+        }
         if (g_strcmp0(ChardevBackendKind_lookup[cd->kind], name) =3D=3D =
0 ||
             g_strcmp0(cd->alias, name) =3D=3D 0) {
             break;
         }
     }
-    if (i =3D=3D NULL) {
+    if (i =3D=3D ARRAY_SIZE(backends)) {
         error_setg(errp, "chardev: backend \"%s\" not found", name);
         goto err;
     }
@@ -4368,11 +4371,15 @@ qmp_prepend_backend(ChardevBackendInfoList *list,=
 const char *name)
 ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
 {
     ChardevBackendInfoList *backend_list =3D NULL;
-    CharDriver *c;
-    GSList *i;
+    const CharDriver *c;
+    int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
+        c =3D backends[i];
+        if (!c) {
+            continue;
+        }
=20
-    for (i =3D backends; i; i =3D i->next) {
-        c =3D i->data;
         backend_list =3D qmp_prepend_backend(backend_list,
                                            ChardevBackendKind_lookup[c->=
kind]);
         if (c->alias) {
@@ -4833,9 +4840,8 @@ ChardevReturn *qmp_chardev_add(const char *id, Char=
devBackend *backend,
 {
     ChardevReturn *ret =3D g_new0(ChardevReturn, 1);
     CharDriverState *chr =3D NULL;
+    const CharDriver *cd;
     Error *local_err =3D NULL;
-    GSList *i;
-    CharDriver *cd;
     bool be_opened =3D true;
=20
     chr =3D qemu_chr_find(id);
@@ -4844,22 +4850,16 @@ ChardevReturn *qmp_chardev_add(const char *id, Ch=
ardevBackend *backend,
         goto out_error;
     }
=20
-    for (i =3D backends; i; i =3D i->next) {
-        cd =3D i->data;
-
-        if (cd->kind =3D=3D backend->type) {
-            chr =3D cd->create(id, backend, ret, &be_opened, &local_err)=
;
-            if (local_err) {
-                error_propagate(errp, local_err);
-                goto out_error;
-            }
-            break;
-        }
+    cd =3D (int)backend->type >=3D 0 && backend->type < ARRAY_SIZE(backe=
nds) ?
+        backends[backend->type] : NULL;
+    if (cd =3D=3D NULL) {
+        error_setg(errp, "chardev backend not available");
+        goto out_error;
     }
=20
-    if (chr =3D=3D NULL) {
-        assert(!i);
-        error_setg(errp, "chardev backend not available");
+    chr =3D cd->create(id, backend, ret, &be_opened, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         goto out_error;
     }
=20
--=20
2.11.0
