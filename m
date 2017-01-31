Received: from eggs.gnu.org ([2001:4830:134:3::10]:46159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDJ-0001E9-VQ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDH-0001GP-SO
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbDH-0001G1-IO
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:23 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:10 +0400
Message-Id: <20170131162122.29408-30-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/41] char: move fd chardev in its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-fd.h     |  44 +++++++++++++
 chardev/char-fd.c     | 170 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 147 +------------------------------------------
 chardev/Makefile.objs |   1 +
 4 files changed, 217 insertions(+), 145 deletions(-)
 create mode 100644 chardev/char-fd.h
 create mode 100644 chardev/char-fd.c

diff --git a/chardev/char-fd.h b/chardev/char-fd.h
new file mode 100644
index 0000000000..d8327982fb
--- /dev/null
+++ b/chardev/char-fd.h
@@ -0,0 +1,44 @@
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
+#ifndef CHAR_FD_H
+#define CHAR_FD_H
+
+#include "io/channel.h"
+#include "sysemu/char.h"
+
+typedef struct FDChardev {
+    Chardev parent;
+    Chardev *chr;
+    QIOChannel *ioc_in, *ioc_out;
+    int max_size;
+} FDChardev;
+
+#define TYPE_CHARDEV_FD "chardev-fd"
+
+#define FD_CHARDEV(obj) OBJECT_CHECK(FDChardev, (obj), TYPE_CHARDEV_FD)
+
+void qemu_chr_open_fd(Chardev *chr, int fd_in, int fd_out);
+int qmp_chardev_open_file_source(char *src, int flags, Error **errp);
+
+#endif /* CHAR_FD_H */
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
new file mode 100644
index 0000000000..fb51ab4234
--- /dev/null
+++ b/chardev/char-fd.c
@@ -0,0 +1,170 @@
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
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "sysemu/char.h"
+#include "io/channel-file.h"
+
+#include "char-fd.h"
+#include "char-io.h"
+
+/* Called with chr_write_lock held.  */
+static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    FDChardev *s =3D FD_CHARDEV(chr);
+
+    return io_channel_send(s->ioc_out, buf, len);
+}
+
+static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *o=
paque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    FDChardev *s =3D FD_CHARDEV(opaque);
+    int len;
+    uint8_t buf[CHR_READ_BUF_LEN];
+    ssize_t ret;
+
+    len =3D sizeof(buf);
+    if (len > s->max_size) {
+        len =3D s->max_size;
+    }
+    if (len =3D=3D 0) {
+        return TRUE;
+    }
+
+    ret =3D qio_channel_read(
+        chan, (gchar *)buf, len, NULL);
+    if (ret =3D=3D 0) {
+        remove_fd_in_watch(chr);
+        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+        return FALSE;
+    }
+    if (ret > 0) {
+        qemu_chr_be_write(chr, buf, ret);
+    }
+
+    return TRUE;
+}
+
+static int fd_chr_read_poll(void *opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    FDChardev *s =3D FD_CHARDEV(opaque);
+
+    s->max_size =3D qemu_chr_be_can_write(chr);
+    return s->max_size;
+}
+
+static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
+{
+    FDChardev *s =3D FD_CHARDEV(chr);
+    return qio_channel_create_watch(s->ioc_out, cond);
+}
+
+static void fd_chr_update_read_handler(Chardev *chr,
+                                       GMainContext *context)
+{
+    FDChardev *s =3D FD_CHARDEV(chr);
+
+    remove_fd_in_watch(chr);
+    if (s->ioc_in) {
+        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc_in,
+                                           fd_chr_read_poll,
+                                           fd_chr_read, chr,
+                                           context);
+    }
+}
+
+static void char_fd_finalize(Object *obj)
+{
+    Chardev *chr =3D CHARDEV(obj);
+    FDChardev *s =3D FD_CHARDEV(obj);
+
+    remove_fd_in_watch(chr);
+    if (s->ioc_in) {
+        object_unref(OBJECT(s->ioc_in));
+    }
+    if (s->ioc_out) {
+        object_unref(OBJECT(s->ioc_out));
+    }
+
+    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+}
+
+int qmp_chardev_open_file_source(char *src, int flags, Error **errp)
+{
+    int fd =3D -1;
+
+    TFR(fd =3D qemu_open(src, flags, 0666));
+    if (fd =3D=3D -1) {
+        error_setg_file_open(errp, errno, src);
+    }
+    return fd;
+}
+
+/* open a character device to a unix fd */
+void qemu_chr_open_fd(Chardev *chr,
+                      int fd_in, int fd_out)
+{
+    FDChardev *s =3D FD_CHARDEV(chr);
+    char *name;
+
+    s->ioc_in =3D QIO_CHANNEL(qio_channel_file_new_fd(fd_in));
+    name =3D g_strdup_printf("chardev-file-in-%s", chr->label);
+    qio_channel_set_name(QIO_CHANNEL(s->ioc_in), name);
+    g_free(name);
+    s->ioc_out =3D QIO_CHANNEL(qio_channel_file_new_fd(fd_out));
+    name =3D g_strdup_printf("chardev-file-out-%s", chr->label);
+    qio_channel_set_name(QIO_CHANNEL(s->ioc_out), name);
+    g_free(name);
+    qemu_set_nonblock(fd_out);
+    s->chr =3D chr;
+}
+
+static void char_fd_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->chr_add_watch =3D fd_chr_add_watch;
+    cc->chr_write =3D fd_chr_write;
+    cc->chr_update_read_handler =3D fd_chr_update_read_handler;
+}
+
+static const TypeInfo char_fd_type_info =3D {
+    .name =3D TYPE_CHARDEV_FD,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(FDChardev),
+    .instance_finalize =3D char_fd_finalize,
+    .class_init =3D char_fd_class_init,
+    .abstract =3D true,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_fd_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index 3cbe42a1a8..aad57ac17e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -86,6 +86,7 @@
 #include "ui/qemu-spice.h"
=20
 #include "char-mux.h"
+#include "char-fd.h"
 #include "char-io.h"
=20
 #define TCP_MAX_FDS 16
@@ -716,136 +717,6 @@ void qemu_chr_fe_take_focus(CharBackend *b)
 }
=20
 #ifndef _WIN32
-typedef struct FDChardev {
-    Chardev parent;
-    Chardev *chr;
-    QIOChannel *ioc_in, *ioc_out;
-    int max_size;
-} FDChardev;
-
-#define TYPE_CHARDEV_FD "chardev-fd"
-#define FD_CHARDEV(obj) OBJECT_CHECK(FDChardev, (obj), TYPE_CHARDEV_FD)
-
-/* Called with chr_write_lock held.  */
-static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
-{
-    FDChardev *s =3D FD_CHARDEV(chr);
-
-    return io_channel_send(s->ioc_out, buf, len);
-}
-
-static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *o=
paque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    FDChardev *s =3D FD_CHARDEV(opaque);
-    int len;
-    uint8_t buf[CHR_READ_BUF_LEN];
-    ssize_t ret;
-
-    len =3D sizeof(buf);
-    if (len > s->max_size) {
-        len =3D s->max_size;
-    }
-    if (len =3D=3D 0) {
-        return TRUE;
-    }
-
-    ret =3D qio_channel_read(
-        chan, (gchar *)buf, len, NULL);
-    if (ret =3D=3D 0) {
-        remove_fd_in_watch(chr);
-        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
-        return FALSE;
-    }
-    if (ret > 0) {
-        qemu_chr_be_write(chr, buf, ret);
-    }
-
-    return TRUE;
-}
-
-static int fd_chr_read_poll(void *opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    FDChardev *s =3D FD_CHARDEV(opaque);
-
-    s->max_size =3D qemu_chr_be_can_write(chr);
-    return s->max_size;
-}
-
-static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
-{
-    FDChardev *s =3D FD_CHARDEV(chr);
-    return qio_channel_create_watch(s->ioc_out, cond);
-}
-
-static void fd_chr_update_read_handler(Chardev *chr,
-                                       GMainContext *context)
-{
-    FDChardev *s =3D FD_CHARDEV(chr);
-
-    remove_fd_in_watch(chr);
-    if (s->ioc_in) {
-        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc_in,
-                                           fd_chr_read_poll,
-                                           fd_chr_read, chr,
-                                           context);
-    }
-}
-
-static void char_fd_finalize(Object *obj)
-{
-    Chardev *chr =3D CHARDEV(obj);
-    FDChardev *s =3D FD_CHARDEV(obj);
-
-    remove_fd_in_watch(chr);
-    if (s->ioc_in) {
-        object_unref(OBJECT(s->ioc_in));
-    }
-    if (s->ioc_out) {
-        object_unref(OBJECT(s->ioc_out));
-    }
-
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
-}
-
-/* open a character device to a unix fd */
-static void qemu_chr_open_fd(Chardev *chr,
-                             int fd_in, int fd_out)
-{
-    FDChardev *s =3D FD_CHARDEV(chr);
-    char *name;
-
-    s->ioc_in =3D QIO_CHANNEL(qio_channel_file_new_fd(fd_in));
-    name =3D g_strdup_printf("chardev-file-in-%s", chr->label);
-    qio_channel_set_name(QIO_CHANNEL(s->ioc_in), name);
-    g_free(name);
-    s->ioc_out =3D QIO_CHANNEL(qio_channel_file_new_fd(fd_out));
-    name =3D g_strdup_printf("chardev-file-out-%s", chr->label);
-    qio_channel_set_name(QIO_CHANNEL(s->ioc_out), name);
-    g_free(name);
-    qemu_set_nonblock(fd_out);
-    s->chr =3D chr;
-}
-
-static void char_fd_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->chr_add_watch =3D fd_chr_add_watch;
-    cc->chr_write =3D fd_chr_write;
-    cc->chr_update_read_handler =3D fd_chr_update_read_handler;
-}
-
-static const TypeInfo char_fd_type_info =3D {
-    .name =3D TYPE_CHARDEV_FD,
-    .parent =3D TYPE_CHARDEV,
-    .instance_size =3D sizeof(FDChardev),
-    .instance_finalize =3D char_fd_finalize,
-    .class_init =3D char_fd_class_init,
-    .abstract =3D true,
-};
-
 static void qemu_chr_open_pipe(Chardev *chr,
                                ChardevBackend *backend,
                                bool *be_opened,
@@ -3875,18 +3746,6 @@ static void qmp_chardev_open_serial(Chardev *chr,
=20
 #else /* WIN32 */
=20
-static int qmp_chardev_open_file_source(char *src, int flags,
-                                        Error **errp)
-{
-    int fd =3D -1;
-
-    TFR(fd =3D qemu_open(src, flags, 0666));
-    if (fd =3D=3D -1) {
-        error_setg_file_open(errp, errno, src);
-    }
-    return fd;
-}
-
 static void qmp_chardev_open_file(Chardev *chr,
                                   ChardevBackend *backend,
                                   bool *be_opened,
@@ -4342,9 +4201,7 @@ void qemu_chr_cleanup(void)
 static void register_types(void)
 {
     type_register_static(&char_type_info);
-#ifndef _WIN32
-    type_register_static(&char_fd_type_info);
-#else
+#ifdef _WIN32
     type_register_static(&char_win_type_info);
     type_register_static(&char_win_stdio_type_info);
 #endif
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 5f5d3716ac..d2f03dc5df 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,4 +1,5 @@
 chardev-obj-y +=3D char.o
+chardev-obj-$(CONFIG_POSIX) +=3D char-fd.o
 chardev-obj-y +=3D char-io.o
 chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
--=20
2.11.0.295.gd7dffce1c.dirty
