Received: from eggs.gnu.org ([2001:4830:134:3::10]:42650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZJx-0003Cg-Ju
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZJw-0003Gp-2q
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZJv-0003GW-Q6
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:44 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB9224E4DE
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:43:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:34 +0300
Message-Id: <20161212224325.20790-4-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/54] char: use a static array for backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Number and kinds of backends is known at compile-time, use a fixed-sized
static array to simplify iterations & lookups.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c           | 101 ++++++++++++++++++++++++++++----------------=
------
 include/sysemu/char.h |   1 +
 2 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 309709cb6d..7934d9da7c 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -4094,20 +4094,20 @@ static void qemu_chr_parse_udp(QemuOpts *opts, Ch=
ardevBackend *backend,
     }
 }
=20
-static GSList *backends;
+static const CharDriver *backends[CHARDEV_BACKEND_KIND__MAX];
=20
 void register_char_driver(const CharDriver *driver)
 {
-    backends =3D g_slist_append(backends, (void *)driver);
+    backends[driver->kind] =3D driver;
 }
=20
 CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
                                         Error **errp)
 {
     Error *local_err =3D NULL;
-    CharDriver *cd;
+    const CharDriver *cd;
     CharDriverState *chr;
-    GSList *i;
+    int i;
     ChardevReturn *ret =3D NULL;
     ChardevBackend *backend;
     const char *id =3D qemu_opts_id(opts);
@@ -4121,9 +4121,14 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts *=
opts,
=20
     if (is_help_option(qemu_opt_get(opts, "backend"))) {
         fprintf(stderr, "Available chardev backend types:\n");
-        for (i =3D backends; i; i =3D i->next) {
-            cd =3D i->data;
-            fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind])=
;
+        for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
+            cd =3D backends[i];
+            if (cd) {
+                fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->ki=
nd]);
+                if (cd->alias) {
+                    fprintf(stderr, "%s\n", cd->alias);
+                }
+            }
         }
         exit(!is_help_option(qemu_opt_get(opts, "backend")));
     }
@@ -4133,15 +4138,20 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts =
*opts,
         goto err;
     }
=20
-    for (i =3D backends; i; i =3D i->next) {
-        cd =3D i->data;
+    cd =3D NULL;
+    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
+        const char *name =3D qemu_opt_get(opts, "backend");
+        cd =3D backends[i];
=20
-        if (strcmp(ChardevBackendKind_lookup[cd->kind],
-                   qemu_opt_get(opts, "backend")) =3D=3D 0) {
+        if (!cd) {
+            continue;
+        }
+        if (g_str_equal(ChardevBackendKind_lookup[cd->kind], name) ||
+            (cd->alias && g_str_equal(cd->alias, name))) {
             break;
         }
     }
-    if (i =3D=3D NULL) {
+    if (cd =3D=3D NULL) {
         error_setg(errp, "chardev: backend \"%s\" not found",
                    qemu_opt_get(opts, "backend"));
         goto err;
@@ -4346,20 +4356,35 @@ ChardevInfoList *qmp_query_chardev(Error **errp)
     return chr_list;
 }
=20
+static ChardevBackendInfoList *
+qmp_prepend_backend(ChardevBackendInfoList *list, const CharDriver *c,
+                    const char *name)
+{
+    ChardevBackendInfoList *info =3D g_malloc0(sizeof(*info));
+    info->value =3D g_malloc0(sizeof(*info->value));
+    info->value->name =3D g_strdup(name);
+    info->next =3D list;
+    return info;
+
+}
+
 ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
 {
     ChardevBackendInfoList *backend_list =3D NULL;
-    CharDriver *c =3D NULL;
-    GSList *i =3D NULL;
+    const CharDriver *c;
+    int i;
=20
-    for (i =3D backends; i; i =3D i->next) {
-        ChardevBackendInfoList *info =3D g_malloc0(sizeof(*info));
-        c =3D i->data;
-        info->value =3D g_malloc0(sizeof(*info->value));
-        info->value->name =3D g_strdup(ChardevBackendKind_lookup[c->kind=
]);
+    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
+        c =3D backends[i];
+        if (!c) {
+            continue;
+        }
=20
-        info->next =3D backend_list;
-        backend_list =3D info;
+        backend_list =3D qmp_prepend_backend(backend_list, c,
+                                           ChardevBackendKind_lookup[c->=
kind]);
+        if (c->alias) {
+            backend_list =3D qmp_prepend_backend(backend_list, c, c->ali=
as);
+        }
     }
=20
     return backend_list;
@@ -4815,9 +4840,8 @@ ChardevReturn *qmp_chardev_add(const char *id, Char=
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
@@ -4826,22 +4850,16 @@ ChardevReturn *qmp_chardev_add(const char *id, Ch=
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
@@ -4907,16 +4925,11 @@ static void register_types(void)
         { .kind =3D CHARDEV_BACKEND_KIND_STDIO,
           .parse =3D qemu_chr_parse_stdio, .create =3D qemu_chr_open_std=
io },
 #if defined HAVE_CHARDEV_SERIAL
-        { .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
-          .parse =3D qemu_chr_parse_serial, .create =3D qmp_chardev_open=
_serial },
-        { .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
+        { .kind =3D CHARDEV_BACKEND_KIND_SERIAL, .alias =3D "tty",
           .parse =3D qemu_chr_parse_serial, .create =3D qmp_chardev_open=
_serial },
 #endif
 #ifdef HAVE_CHARDEV_PARPORT
-        { .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
-          .parse =3D qemu_chr_parse_parallel,
-          .create =3D qmp_chardev_open_parallel },
-        { .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
+        { .kind =3D CHARDEV_BACKEND_KIND_PARALLEL, .alias =3D "parport",
           .parse =3D qemu_chr_parse_parallel,
           .create =3D qmp_chardev_open_parallel },
 #endif
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 144514c962..c8750ede21 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -474,6 +474,7 @@ void qemu_chr_set_feature(CharDriverState *chr,
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)=
;
=20
 typedef struct CharDriver {
+    const char *alias;
     ChardevBackendKind kind;
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
     CharDriverState *(*create)(const char *id,
--=20
2.11.0
