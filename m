Received: from eggs.gnu.org ([2001:4830:134:3::10]:53582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIT-0007Mh-HC
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIS-0002lP-Fw
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cPBIS-0002l5-7a
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:48 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58171C0467D1
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:53:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jan 2017 17:53:18 +0100
Message-Id: <20170105165329.17227-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-1-marcandre.lureau@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/20] char: introduce generic
 qemu_chr_get_kind()
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

This allows to remove the "is_mux" field from CharDriverState.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/char.h | 15 +++++++++++++--
 monitor.c             |  2 +-
 qemu-char.c           | 21 ++++++++++-----------
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 450d979c92..38a98621f3 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -96,7 +96,6 @@ struct CharDriverState {
     char *filename;
     int logfd;
     int be_open;
-    int is_mux;
     guint fd_in_tag;
     bool replay;
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
@@ -455,7 +454,19 @@ void qemu_chr_be_generic_open(CharDriverState *s);
 void qemu_chr_fe_accept_input(CharBackend *be);
 int qemu_chr_add_client(CharDriverState *s, int fd);
 CharDriverState *qemu_chr_find(const char *name);
-bool chr_is_ringbuf(const CharDriverState *chr);
+
+/**
+ * @qemu_chr_get_kind:
+ *
+ * Returns the kind of char backend, or -1 if unspecified.
+ */
+ChardevBackendKind qemu_chr_get_kind(const CharDriverState *chr);
+
+static inline bool qemu_chr_is_ringbuf(const CharDriverState *chr)
+{
+    return qemu_chr_get_kind(chr) =3D=3D CHARDEV_BACKEND_KIND_RINGBUF ||
+        qemu_chr_get_kind(chr) =3D=3D CHARDEV_BACKEND_KIND_MEMORY;
+}
=20
 bool qemu_chr_has_feature(CharDriverState *chr,
                           CharDriverFeature feature);
diff --git a/monitor.c b/monitor.c
index 0841d436b0..17948f5289 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3194,7 +3194,7 @@ static void ringbuf_completion(ReadLineState *rs, c=
onst char *str)
=20
         if (!strncmp(chr_info->label, str, len)) {
             CharDriverState *chr =3D qemu_chr_find(chr_info->label);
-            if (chr && chr_is_ringbuf(chr)) {
+            if (chr && qemu_chr_is_ringbuf(chr)) {
                 readline_add_completion(rs, chr_info->label);
             }
         }
diff --git a/qemu-char.c b/qemu-char.c
index 3dd692a55f..575873391e 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -781,7 +781,7 @@ static void muxes_realize_done(Notifier *notifier, vo=
id *unused)
     CharDriverState *chr;
=20
     QTAILQ_FOREACH(chr, &chardevs, next) {
-        if (chr->is_mux) {
+        if (qemu_chr_get_kind(chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
             MuxDriver *d =3D chr->opaque;
             int i;
=20
@@ -885,7 +885,6 @@ static CharDriverState *qemu_chr_open_mux(const CharD=
river *driver,
      * set of muxes
      */
     *be_opened =3D muxes_realized;
-    chr->is_mux =3D 1;
     if (!qemu_chr_fe_init(&d->chr, drv, errp)) {
         qemu_chr_free(chr);
         return NULL;
@@ -903,7 +902,7 @@ bool qemu_chr_fe_init(CharBackend *b, CharDriverState=
 *s, Error **errp)
 {
     int tag =3D 0;
=20
-    if (s->is_mux) {
+    if (qemu_chr_get_kind(s) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
         MuxDriver *d =3D s->opaque;
=20
         if (d->mux_cnt >=3D MAX_MUX) {
@@ -930,7 +929,7 @@ unavailable:
=20
 static bool qemu_chr_is_busy(CharDriverState *s)
 {
-    if (s->is_mux) {
+    if (qemu_chr_get_kind(s) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
         MuxDriver *d =3D s->opaque;
         return d->mux_cnt >=3D 0;
     } else {
@@ -945,7 +944,7 @@ void qemu_chr_fe_deinit(CharBackend *b)
     if (b->chr) {
         qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, true);
         b->chr->be =3D NULL;
-        if (b->chr->is_mux) {
+        if (qemu_chr_get_kind(b->chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
             MuxDriver *d =3D b->chr->opaque;
             d->backends[b->tag] =3D NULL;
         }
@@ -996,7 +995,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
         }
     }
=20
-    if (s->is_mux) {
+    if (qemu_chr_get_kind(s) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
         mux_chr_set_handlers(s, context);
     }
 }
@@ -1007,7 +1006,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
         return;
     }
=20
-    if (b->chr->is_mux) {
+    if (qemu_chr_get_kind(b->chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
         mux_set_focus(b->chr->opaque, b->tag);
     }
 }
@@ -3552,9 +3551,9 @@ fail:
     return NULL;
 }
=20
-bool chr_is_ringbuf(const CharDriverState *chr)
+ChardevBackendKind qemu_chr_get_kind(const CharDriverState *chr)
 {
-    return chr->driver->chr_write =3D=3D ringbuf_chr_write;
+    return chr->driver->kind;
 }
=20
 void qmp_ringbuf_write(const char *device, const char *data,
@@ -3572,7 +3571,7 @@ void qmp_ringbuf_write(const char *device, const ch=
ar *data,
         return;
     }
=20
-    if (!chr_is_ringbuf(chr)) {
+    if (!qemu_chr_is_ringbuf(chr)) {
         error_setg(errp,"%s is not a ringbuf device", device);
         return;
     }
@@ -3616,7 +3615,7 @@ char *qmp_ringbuf_read(const char *device, int64_t =
size,
         return NULL;
     }
=20
-    if (!chr_is_ringbuf(chr)) {
+    if (!qemu_chr_is_ringbuf(chr)) {
         error_setg(errp,"%s is not a ringbuf device", device);
         return NULL;
     }
--=20
2.11.0
