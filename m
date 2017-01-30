Received: from eggs.gnu.org ([2001:4830:134:3::10]:38424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCDf-0005hE-96
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCDd-00070R-Ec
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCDd-00070L-5L
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:05 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BCEB80F63
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:42:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:38 +0400
Message-Id: <20170130133954.31353-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 25/41] char: move ringbuf/memory to its own
 file
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-ringbuf.c | 249 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c         | 218 -------------------------------------------
 chardev/Makefile.objs  |   1 +
 3 files changed, 250 insertions(+), 218 deletions(-)
 create mode 100644 chardev/char-ringbuf.c

diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
new file mode 100644
index 0000000000..d130069e88
--- /dev/null
+++ b/chardev/char-ringbuf.c
@@ -0,0 +1,249 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "sysemu/char.h"
+#include "qmp-commands.h"
+#include "qemu/base64.h"
+
+/* Ring buffer chardev */
+
+typedef struct {
+    Chardev parent;
+    size_t size;
+    size_t prod;
+    size_t cons;
+    uint8_t *cbuf;
+} RingBufChardev;
+
+#define RINGBUF_CHARDEV(obj)                                    \
+    OBJECT_CHECK(RingBufChardev, (obj), TYPE_CHARDEV_RINGBUF)
+
+static size_t ringbuf_count(const Chardev *chr)
+{
+    const RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
+
+    return d->prod - d->cons;
+}
+
+static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
+    int i;
+
+    if (!buf || (len < 0)) {
+        return -1;
+    }
+
+    for (i =3D 0; i < len; i++) {
+        d->cbuf[d->prod++ & (d->size - 1)] =3D buf[i];
+        if (d->prod - d->cons > d->size) {
+            d->cons =3D d->prod - d->size;
+        }
+    }
+
+    return len;
+}
+
+static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
+{
+    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
+    int i;
+
+    qemu_mutex_lock(&chr->chr_write_lock);
+    for (i =3D 0; i < len && d->cons !=3D d->prod; i++) {
+        buf[i] =3D d->cbuf[d->cons++ & (d->size - 1)];
+    }
+    qemu_mutex_unlock(&chr->chr_write_lock);
+
+    return i;
+}
+
+static void char_ringbuf_finalize(Object *obj)
+{
+    RingBufChardev *d =3D RINGBUF_CHARDEV(obj);
+
+    g_free(d->cbuf);
+}
+
+static void qemu_chr_open_ringbuf(Chardev *chr,
+                                  ChardevBackend *backend,
+                                  bool *be_opened,
+                                  Error **errp)
+{
+    ChardevRingbuf *opts =3D backend->u.ringbuf.data;
+    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
+
+    d->size =3D opts->has_size ? opts->size : 65536;
+
+    /* The size must be power of 2 */
+    if (d->size & (d->size - 1)) {
+        error_setg(errp, "size of ringbuf chardev must be power of two")=
;
+        return;
+    }
+
+    d->prod =3D 0;
+    d->cons =3D 0;
+    d->cbuf =3D g_malloc0(d->size);
+}
+
+void qmp_ringbuf_write(const char *device, const char *data,
+                       bool has_format, enum DataFormat format,
+                       Error **errp)
+{
+    Chardev *chr;
+    const uint8_t *write_data;
+    int ret;
+    gsize write_count;
+
+    chr =3D qemu_chr_find(device);
+    if (!chr) {
+        error_setg(errp, "Device '%s' not found", device);
+        return;
+    }
+
+    if (!CHARDEV_IS_RINGBUF(chr)) {
+        error_setg(errp, "%s is not a ringbuf device", device);
+        return;
+    }
+
+    if (has_format && (format =3D=3D DATA_FORMAT_BASE64)) {
+        write_data =3D qbase64_decode(data, -1,
+                                    &write_count,
+                                    errp);
+        if (!write_data) {
+            return;
+        }
+    } else {
+        write_data =3D (uint8_t *)data;
+        write_count =3D strlen(data);
+    }
+
+    ret =3D ringbuf_chr_write(chr, write_data, write_count);
+
+    if (write_data !=3D (uint8_t *)data) {
+        g_free((void *)write_data);
+    }
+
+    if (ret < 0) {
+        error_setg(errp, "Failed to write to device %s", device);
+        return;
+    }
+}
+
+char *qmp_ringbuf_read(const char *device, int64_t size,
+                       bool has_format, enum DataFormat format,
+                       Error **errp)
+{
+    Chardev *chr;
+    uint8_t *read_data;
+    size_t count;
+    char *data;
+
+    chr =3D qemu_chr_find(device);
+    if (!chr) {
+        error_setg(errp, "Device '%s' not found", device);
+        return NULL;
+    }
+
+    if (!CHARDEV_IS_RINGBUF(chr)) {
+        error_setg(errp, "%s is not a ringbuf device", device);
+        return NULL;
+    }
+
+    if (size <=3D 0) {
+        error_setg(errp, "size must be greater than zero");
+        return NULL;
+    }
+
+    count =3D ringbuf_count(chr);
+    size =3D size > count ? count : size;
+    read_data =3D g_malloc(size + 1);
+
+    ringbuf_chr_read(chr, read_data, size);
+
+    if (has_format && (format =3D=3D DATA_FORMAT_BASE64)) {
+        data =3D g_base64_encode(read_data, size);
+        g_free(read_data);
+    } else {
+        /*
+         * FIXME should read only complete, valid UTF-8 characters up
+         * to @size bytes.  Invalid sequences should be replaced by a
+         * suitable replacement character.  Except when (and only
+         * when) ring buffer lost characters since last read, initial
+         * continuation characters should be dropped.
+         */
+        read_data[size] =3D 0;
+        data =3D (char *)read_data;
+    }
+
+    return data;
+}
+
+static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backe=
nd,
+                                   Error **errp)
+{
+    int val;
+    ChardevRingbuf *ringbuf;
+
+    backend->type =3D CHARDEV_BACKEND_KIND_RINGBUF;
+    ringbuf =3D backend->u.ringbuf.data =3D g_new0(ChardevRingbuf, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevRingbuf_base(ringbuf));
+
+    val =3D qemu_opt_get_size(opts, "size", 0);
+    if (val !=3D 0) {
+        ringbuf->has_size =3D true;
+        ringbuf->size =3D val;
+    }
+}
+
+static void char_ringbuf_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_ringbuf;
+    cc->open =3D qemu_chr_open_ringbuf;
+    cc->chr_write =3D ringbuf_chr_write;
+}
+
+static const TypeInfo char_ringbuf_type_info =3D {
+    .name =3D TYPE_CHARDEV_RINGBUF,
+    .parent =3D TYPE_CHARDEV,
+    .class_init =3D char_ringbuf_class_init,
+    .instance_size =3D sizeof(RingBufChardev),
+    .instance_finalize =3D char_ringbuf_finalize,
+};
+
+/* Bug-compatibility: */
+static const TypeInfo char_memory_type_info =3D {
+    .name =3D TYPE_CHARDEV_MEMORY,
+    .parent =3D TYPE_CHARDEV_RINGBUF,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_ringbuf_type_info);
+    type_register_static(&char_memory_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index c8d03776b1..6b505c6f7d 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -3144,182 +3144,6 @@ static void qemu_chr_socket_connected(QIOTask *ta=
sk, void *opaque)
 }
=20
=20
-/*********************************************************/
-/* Ring buffer chardev */
-
-typedef struct {
-    Chardev parent;
-    size_t size;
-    size_t prod;
-    size_t cons;
-    uint8_t *cbuf;
-} RingBufChardev;
-
-#define RINGBUF_CHARDEV(obj)                                    \
-    OBJECT_CHECK(RingBufChardev, (obj), TYPE_CHARDEV_RINGBUF)
-
-static size_t ringbuf_count(const Chardev *chr)
-{
-    const RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
-
-    return d->prod - d->cons;
-}
-
-/* Called with chr_write_lock held.  */
-static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
-{
-    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
-    int i;
-
-    if (!buf || (len < 0)) {
-        return -1;
-    }
-
-    for (i =3D 0; i < len; i++ ) {
-        d->cbuf[d->prod++ & (d->size - 1)] =3D buf[i];
-        if (d->prod - d->cons > d->size) {
-            d->cons =3D d->prod - d->size;
-        }
-    }
-
-    return len;
-}
-
-static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
-{
-    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
-    int i;
-
-    qemu_mutex_lock(&chr->chr_write_lock);
-    for (i =3D 0; i < len && d->cons !=3D d->prod; i++) {
-        buf[i] =3D d->cbuf[d->cons++ & (d->size - 1)];
-    }
-    qemu_mutex_unlock(&chr->chr_write_lock);
-
-    return i;
-}
-
-static void char_ringbuf_finalize(Object *obj)
-{
-    RingBufChardev *d =3D RINGBUF_CHARDEV(obj);
-
-    g_free(d->cbuf);
-}
-
-static void qemu_chr_open_ringbuf(Chardev *chr,
-                                  ChardevBackend *backend,
-                                  bool *be_opened,
-                                  Error **errp)
-{
-    ChardevRingbuf *opts =3D backend->u.ringbuf.data;
-    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
-
-    d->size =3D opts->has_size ? opts->size : 65536;
-
-    /* The size must be power of 2 */
-    if (d->size & (d->size - 1)) {
-        error_setg(errp, "size of ringbuf chardev must be power of two")=
;
-        return;
-    }
-
-    d->prod =3D 0;
-    d->cons =3D 0;
-    d->cbuf =3D g_malloc0(d->size);
-}
-
-void qmp_ringbuf_write(const char *device, const char *data,
-                       bool has_format, enum DataFormat format,
-                       Error **errp)
-{
-    Chardev *chr;
-    const uint8_t *write_data;
-    int ret;
-    gsize write_count;
-
-    chr =3D qemu_chr_find(device);
-    if (!chr) {
-        error_setg(errp, "Device '%s' not found", device);
-        return;
-    }
-
-    if (!CHARDEV_IS_RINGBUF(chr)) {
-        error_setg(errp,"%s is not a ringbuf device", device);
-        return;
-    }
-
-    if (has_format && (format =3D=3D DATA_FORMAT_BASE64)) {
-        write_data =3D qbase64_decode(data, -1,
-                                    &write_count,
-                                    errp);
-        if (!write_data) {
-            return;
-        }
-    } else {
-        write_data =3D (uint8_t *)data;
-        write_count =3D strlen(data);
-    }
-
-    ret =3D ringbuf_chr_write(chr, write_data, write_count);
-
-    if (write_data !=3D (uint8_t *)data) {
-        g_free((void *)write_data);
-    }
-
-    if (ret < 0) {
-        error_setg(errp, "Failed to write to device %s", device);
-        return;
-    }
-}
-
-char *qmp_ringbuf_read(const char *device, int64_t size,
-                       bool has_format, enum DataFormat format,
-                       Error **errp)
-{
-    Chardev *chr;
-    uint8_t *read_data;
-    size_t count;
-    char *data;
-
-    chr =3D qemu_chr_find(device);
-    if (!chr) {
-        error_setg(errp, "Device '%s' not found", device);
-        return NULL;
-    }
-
-    if (!CHARDEV_IS_RINGBUF(chr)) {
-        error_setg(errp,"%s is not a ringbuf device", device);
-        return NULL;
-    }
-
-    if (size <=3D 0) {
-        error_setg(errp, "size must be greater than zero");
-        return NULL;
-    }
-
-    count =3D ringbuf_count(chr);
-    size =3D size > count ? count : size;
-    read_data =3D g_malloc(size + 1);
-
-    ringbuf_chr_read(chr, read_data, size);
-
-    if (has_format && (format =3D=3D DATA_FORMAT_BASE64)) {
-        data =3D g_base64_encode(read_data, size);
-        g_free(read_data);
-    } else {
-        /*
-         * FIXME should read only complete, valid UTF-8 characters up
-         * to @size bytes.  Invalid sequences should be replaced by a
-         * suitable replacement character.  Except when (and only
-         * when) ring buffer lost characters since last read, initial
-         * continuation characters should be dropped.
-         */
-        read_data[size] =3D 0;
-        data =3D (char *)read_data;
-    }
-
-    return data;
-}
-
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
 {
     char host[65], port[33], width[8], height[8];
@@ -3600,46 +3424,6 @@ static const TypeInfo char_pipe_type_info =3D {
     .class_init =3D char_pipe_class_init,
 };
=20
-static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backe=
nd,
-                                   Error **errp)
-{
-    int val;
-    ChardevRingbuf *ringbuf;
-
-    backend->type =3D CHARDEV_BACKEND_KIND_RINGBUF;
-    ringbuf =3D backend->u.ringbuf.data =3D g_new0(ChardevRingbuf, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevRingbuf_base(ringbuf));
-
-    val =3D qemu_opt_get_size(opts, "size", 0);
-    if (val !=3D 0) {
-        ringbuf->has_size =3D true;
-        ringbuf->size =3D val;
-    }
-}
-
-static void char_ringbuf_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->parse =3D qemu_chr_parse_ringbuf;
-    cc->open =3D qemu_chr_open_ringbuf;
-    cc->chr_write =3D ringbuf_chr_write;
-}
-
-static const TypeInfo char_ringbuf_type_info =3D {
-    .name =3D TYPE_CHARDEV_RINGBUF,
-    .parent =3D TYPE_CHARDEV,
-    .class_init =3D char_ringbuf_class_init,
-    .instance_size =3D sizeof(RingBufChardev),
-    .instance_finalize =3D char_ringbuf_finalize,
-};
-
-/* Bug-compatibility: */
-static const TypeInfo char_memory_type_info =3D {
-    .name =3D TYPE_CHARDEV_MEMORY,
-    .parent =3D TYPE_CHARDEV_RINGBUF,
-};
-
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
                                   Error **errp)
 {
@@ -4740,7 +4524,6 @@ static void register_types(void)
 #endif
     type_register_static(&char_socket_type_info);
     type_register_static(&char_udp_type_info);
-    type_register_static(&char_ringbuf_type_info);
     type_register_static(&char_file_type_info);
     type_register_static(&char_stdio_type_info);
 #ifdef HAVE_CHARDEV_SERIAL
@@ -4756,7 +4539,6 @@ static void register_types(void)
     type_register_static(&char_console_type_info);
 #endif
     type_register_static(&char_pipe_type_info);
-    type_register_static(&char_memory_type_info);
=20
     /* this must be done after machine init, since we register FEs with =
muxes
      * as part of realize functions like serial_isa_realizefn when -nogr=
aphic
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index f1ccc40ae1..d4ffb8d70e 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,3 +1,4 @@
 chardev-obj-y +=3D char.o
 chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
+chardev-obj-y +=3D char-ringbuf.o
--=20
2.11.0.295.gd7dffce1c.dirty
