Received: from eggs.gnu.org ([2001:4830:134:3::10]:40876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjO-0001As-Hj
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjM-0006V7-T6
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMjM-0006Uf-Kz
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:36 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C81BD5277D
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:44 +0100
Message-Id: <20170111172956.11255-29-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 28/40] char: move fd chardev in its own file
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
 chardev/char-fd.h     |  21 ++++++++
 chardev/char-fd.c     | 147 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 147 +-------------------------------------------=
------
 chardev/Makefile.objs |   1 +
 4 files changed, 171 insertions(+), 145 deletions(-)
 create mode 100644 chardev/char-fd.h
 create mode 100644 chardev/char-fd.c

diff --git a/chardev/char-fd.h b/chardev/char-fd.h
new file mode 100644
index 0000000000..beef7c111a
--- /dev/null
+++ b/chardev/char-fd.h
@@ -0,0 +1,21 @@
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
index 0000000000..0328c9335c
--- /dev/null
+++ b/chardev/char-fd.c
@@ -0,0 +1,147 @@
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
index c8448cf489..5391667f09 100644
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
@@ -3852,18 +3723,6 @@ static void qmp_chardev_open_serial(Chardev *chr,
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
@@ -4319,9 +4178,7 @@ void qemu_chr_cleanup(void)
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
2.11.0
