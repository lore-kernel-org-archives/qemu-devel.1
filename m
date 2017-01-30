Received: from eggs.gnu.org ([2001:4830:134:3::10]:38826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCEe-0007Af-Ir
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCEc-0007aY-Gc
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:43:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCEc-0007a8-7A
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:43:06 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 584B15277F
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:43:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:51 +0400
Message-Id: <20170130133954.31353-39-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 38/41] char: move pty chardev in its own file
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
Acked-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-pty.c    | 300 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 258 -------------------------------------------
 chardev/Makefile.objs |   1 +
 3 files changed, 301 insertions(+), 258 deletions(-)
 create mode 100644 chardev/char-pty.c

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
new file mode 100644
index 0000000000..27eb85f505
--- /dev/null
+++ b/chardev/char-pty.c
@@ -0,0 +1,300 @@
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
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "sysemu/char.h"
+#include "io/channel-file.h"
+#include "qemu/sockets.h"
+#include "qemu/error-report.h"
+
+#include "char-io.h"
+
+#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      =
\
+    || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFl=
y__) \
+    || defined(__GLIBC__)
+
+typedef struct {
+    Chardev parent;
+    QIOChannel *ioc;
+    int read_bytes;
+
+    /* Protected by the Chardev chr_write_lock.  */
+    int connected;
+    guint timer_tag;
+    guint open_tag;
+} PtyChardev;
+
+#define PTY_CHARDEV(obj) OBJECT_CHECK(PtyChardev, (obj), TYPE_CHARDEV_PT=
Y)
+
+static void pty_chr_update_read_handler_locked(Chardev *chr);
+static void pty_chr_state(Chardev *chr, int connected);
+
+static gboolean pty_chr_timer(gpointer opaque)
+{
+    struct Chardev *chr =3D CHARDEV(opaque);
+    PtyChardev *s =3D PTY_CHARDEV(opaque);
+
+    qemu_mutex_lock(&chr->chr_write_lock);
+    s->timer_tag =3D 0;
+    s->open_tag =3D 0;
+    if (!s->connected) {
+        /* Next poll ... */
+        pty_chr_update_read_handler_locked(chr);
+    }
+    qemu_mutex_unlock(&chr->chr_write_lock);
+    return FALSE;
+}
+
+/* Called with chr_write_lock held.  */
+static void pty_chr_rearm_timer(Chardev *chr, int ms)
+{
+    PtyChardev *s =3D PTY_CHARDEV(chr);
+    char *name;
+
+    if (s->timer_tag) {
+        g_source_remove(s->timer_tag);
+        s->timer_tag =3D 0;
+    }
+
+    if (ms =3D=3D 1000) {
+        name =3D g_strdup_printf("pty-timer-secs-%s", chr->label);
+        s->timer_tag =3D g_timeout_add_seconds(1, pty_chr_timer, chr);
+    } else {
+        name =3D g_strdup_printf("pty-timer-ms-%s", chr->label);
+        s->timer_tag =3D g_timeout_add(ms, pty_chr_timer, chr);
+    }
+    g_source_set_name_by_id(s->timer_tag, name);
+    g_free(name);
+}
+
+/* Called with chr_write_lock held.  */
+static void pty_chr_update_read_handler_locked(Chardev *chr)
+{
+    PtyChardev *s =3D PTY_CHARDEV(chr);
+    GPollFD pfd;
+    int rc;
+    QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(s->ioc);
+
+    pfd.fd =3D fioc->fd;
+    pfd.events =3D G_IO_OUT;
+    pfd.revents =3D 0;
+    do {
+        rc =3D g_poll(&pfd, 1, 0);
+    } while (rc =3D=3D -1 && errno =3D=3D EINTR);
+    assert(rc >=3D 0);
+
+    if (pfd.revents & G_IO_HUP) {
+        pty_chr_state(chr, 0);
+    } else {
+        pty_chr_state(chr, 1);
+    }
+}
+
+static void pty_chr_update_read_handler(Chardev *chr,
+                                        GMainContext *context)
+{
+    qemu_mutex_lock(&chr->chr_write_lock);
+    pty_chr_update_read_handler_locked(chr);
+    qemu_mutex_unlock(&chr->chr_write_lock);
+}
+
+/* Called with chr_write_lock held.  */
+static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    PtyChardev *s =3D PTY_CHARDEV(chr);
+
+    if (!s->connected) {
+        /* guest sends data, check for (re-)connect */
+        pty_chr_update_read_handler_locked(chr);
+        if (!s->connected) {
+            return 0;
+        }
+    }
+    return io_channel_send(s->ioc, buf, len);
+}
+
+static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
+{
+    PtyChardev *s =3D PTY_CHARDEV(chr);
+    if (!s->connected) {
+        return NULL;
+    }
+    return qio_channel_create_watch(s->ioc, cond);
+}
+
+static int pty_chr_read_poll(void *opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    PtyChardev *s =3D PTY_CHARDEV(opaque);
+
+    s->read_bytes =3D qemu_chr_be_can_write(chr);
+    return s->read_bytes;
+}
+
+static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    PtyChardev *s =3D PTY_CHARDEV(opaque);
+    gsize len;
+    uint8_t buf[CHR_READ_BUF_LEN];
+    ssize_t ret;
+
+    len =3D sizeof(buf);
+    if (len > s->read_bytes) {
+        len =3D s->read_bytes;
+    }
+    if (len =3D=3D 0) {
+        return TRUE;
+    }
+    ret =3D qio_channel_read(s->ioc, (char *)buf, len, NULL);
+    if (ret <=3D 0) {
+        pty_chr_state(chr, 0);
+        return FALSE;
+    } else {
+        pty_chr_state(chr, 1);
+        qemu_chr_be_write(chr, buf, ret);
+    }
+    return TRUE;
+}
+
+static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    PtyChardev *s =3D PTY_CHARDEV(opaque);
+
+    s->open_tag =3D 0;
+    qemu_chr_be_generic_open(chr);
+    return FALSE;
+}
+
+/* Called with chr_write_lock held.  */
+static void pty_chr_state(Chardev *chr, int connected)
+{
+    PtyChardev *s =3D PTY_CHARDEV(chr);
+
+    if (!connected) {
+        if (s->open_tag) {
+            g_source_remove(s->open_tag);
+            s->open_tag =3D 0;
+        }
+        remove_fd_in_watch(chr);
+        s->connected =3D 0;
+        /* (re-)connect poll interval for idle guests: once per second.
+         * We check more frequently in case the guests sends data to
+         * the virtual device linked to our pty. */
+        pty_chr_rearm_timer(chr, 1000);
+    } else {
+        if (s->timer_tag) {
+            g_source_remove(s->timer_tag);
+            s->timer_tag =3D 0;
+        }
+        if (!s->connected) {
+            g_assert(s->open_tag =3D=3D 0);
+            s->connected =3D 1;
+            s->open_tag =3D g_idle_add(qemu_chr_be_generic_open_func, ch=
r);
+        }
+        if (!chr->fd_in_tag) {
+            chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
+                                               pty_chr_read_poll,
+                                               pty_chr_read,
+                                               chr, NULL);
+        }
+    }
+}
+
+static void char_pty_finalize(Object *obj)
+{
+    Chardev *chr =3D CHARDEV(obj);
+    PtyChardev *s =3D PTY_CHARDEV(obj);
+
+    qemu_mutex_lock(&chr->chr_write_lock);
+    pty_chr_state(chr, 0);
+    object_unref(OBJECT(s->ioc));
+    if (s->timer_tag) {
+        g_source_remove(s->timer_tag);
+        s->timer_tag =3D 0;
+    }
+    qemu_mutex_unlock(&chr->chr_write_lock);
+    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+}
+
+static void char_pty_open(Chardev *chr,
+                          ChardevBackend *backend,
+                          bool *be_opened,
+                          Error **errp)
+{
+    PtyChardev *s;
+    int master_fd, slave_fd;
+    char pty_name[PATH_MAX];
+    char *name;
+
+    master_fd =3D qemu_openpty_raw(&slave_fd, pty_name);
+    if (master_fd < 0) {
+        error_setg_errno(errp, errno, "Failed to create PTY");
+        return;
+    }
+
+    close(slave_fd);
+    qemu_set_nonblock(master_fd);
+
+    chr->filename =3D g_strdup_printf("pty:%s", pty_name);
+    error_report("char device redirected to %s (label %s)",
+                 pty_name, chr->label);
+
+    s =3D PTY_CHARDEV(chr);
+    s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
+    name =3D g_strdup_printf("chardev-pty-%s", chr->label);
+    qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
+    g_free(name);
+    s->timer_tag =3D 0;
+    *be_opened =3D false;
+}
+
+static void char_pty_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D char_pty_open;
+    cc->chr_write =3D char_pty_chr_write;
+    cc->chr_update_read_handler =3D pty_chr_update_read_handler;
+    cc->chr_add_watch =3D pty_chr_add_watch;
+}
+
+static const TypeInfo char_pty_type_info =3D {
+    .name =3D TYPE_CHARDEV_PTY,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(PtyChardev),
+    .instance_finalize =3D char_pty_finalize,
+    .class_init =3D char_pty_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_pty_type_info);
+}
+
+type_init(register_types);
+
+#endif
diff --git a/chardev/char.c b/chardev/char.c
index b542c25cec..6d4cb7c71e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -661,261 +661,6 @@ void qemu_chr_fe_take_focus(CharBackend *b)
     || defined(__GLIBC__)
=20
 #define HAVE_CHARDEV_SERIAL 1
-#define HAVE_CHARDEV_PTY 1
-
-typedef struct {
-    Chardev parent;
-    QIOChannel *ioc;
-    int read_bytes;
-
-    /* Protected by the Chardev chr_write_lock.  */
-    int connected;
-    guint timer_tag;
-    guint open_tag;
-} PtyChardev;
-
-#define PTY_CHARDEV(obj) OBJECT_CHECK(PtyChardev, (obj), TYPE_CHARDEV_PT=
Y)
-
-static void pty_chr_update_read_handler_locked(Chardev *chr);
-static void pty_chr_state(Chardev *chr, int connected);
-
-static gboolean pty_chr_timer(gpointer opaque)
-{
-    struct Chardev *chr =3D CHARDEV(opaque);
-    PtyChardev *s =3D PTY_CHARDEV(opaque);
-
-    qemu_mutex_lock(&chr->chr_write_lock);
-    s->timer_tag =3D 0;
-    s->open_tag =3D 0;
-    if (!s->connected) {
-        /* Next poll ... */
-        pty_chr_update_read_handler_locked(chr);
-    }
-    qemu_mutex_unlock(&chr->chr_write_lock);
-    return FALSE;
-}
-
-/* Called with chr_write_lock held.  */
-static void pty_chr_rearm_timer(Chardev *chr, int ms)
-{
-    PtyChardev *s =3D PTY_CHARDEV(chr);
-    char *name;
-
-    if (s->timer_tag) {
-        g_source_remove(s->timer_tag);
-        s->timer_tag =3D 0;
-    }
-
-    if (ms =3D=3D 1000) {
-        name =3D g_strdup_printf("pty-timer-secs-%s", chr->label);
-        s->timer_tag =3D g_timeout_add_seconds(1, pty_chr_timer, chr);
-    } else {
-        name =3D g_strdup_printf("pty-timer-ms-%s", chr->label);
-        s->timer_tag =3D g_timeout_add(ms, pty_chr_timer, chr);
-    }
-    g_source_set_name_by_id(s->timer_tag, name);
-    g_free(name);
-}
-
-/* Called with chr_write_lock held.  */
-static void pty_chr_update_read_handler_locked(Chardev *chr)
-{
-    PtyChardev *s =3D PTY_CHARDEV(chr);
-    GPollFD pfd;
-    int rc;
-    QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(s->ioc);
-
-    pfd.fd =3D fioc->fd;
-    pfd.events =3D G_IO_OUT;
-    pfd.revents =3D 0;
-    do {
-        rc =3D g_poll(&pfd, 1, 0);
-    } while (rc =3D=3D -1 && errno =3D=3D EINTR);
-    assert(rc >=3D 0);
-
-    if (pfd.revents & G_IO_HUP) {
-        pty_chr_state(chr, 0);
-    } else {
-        pty_chr_state(chr, 1);
-    }
-}
-
-static void pty_chr_update_read_handler(Chardev *chr,
-                                        GMainContext *context)
-{
-    qemu_mutex_lock(&chr->chr_write_lock);
-    pty_chr_update_read_handler_locked(chr);
-    qemu_mutex_unlock(&chr->chr_write_lock);
-}
-
-/* Called with chr_write_lock held.  */
-static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
-{
-    PtyChardev *s =3D PTY_CHARDEV(chr);
-
-    if (!s->connected) {
-        /* guest sends data, check for (re-)connect */
-        pty_chr_update_read_handler_locked(chr);
-        if (!s->connected) {
-            return 0;
-        }
-    }
-    return io_channel_send(s->ioc, buf, len);
-}
-
-static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
-{
-    PtyChardev *s =3D PTY_CHARDEV(chr);
-    if (!s->connected) {
-        return NULL;
-    }
-    return qio_channel_create_watch(s->ioc, cond);
-}
-
-static int pty_chr_read_poll(void *opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    PtyChardev *s =3D PTY_CHARDEV(opaque);
-
-    s->read_bytes =3D qemu_chr_be_can_write(chr);
-    return s->read_bytes;
-}
-
-static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    PtyChardev *s =3D PTY_CHARDEV(opaque);
-    gsize len;
-    uint8_t buf[CHR_READ_BUF_LEN];
-    ssize_t ret;
-
-    len =3D sizeof(buf);
-    if (len > s->read_bytes)
-        len =3D s->read_bytes;
-    if (len =3D=3D 0) {
-        return TRUE;
-    }
-    ret =3D qio_channel_read(s->ioc, (char *)buf, len, NULL);
-    if (ret <=3D 0) {
-        pty_chr_state(chr, 0);
-        return FALSE;
-    } else {
-        pty_chr_state(chr, 1);
-        qemu_chr_be_write(chr, buf, ret);
-    }
-    return TRUE;
-}
-
-static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    PtyChardev *s =3D PTY_CHARDEV(opaque);
-
-    s->open_tag =3D 0;
-    qemu_chr_be_generic_open(chr);
-    return FALSE;
-}
-
-/* Called with chr_write_lock held.  */
-static void pty_chr_state(Chardev *chr, int connected)
-{
-    PtyChardev *s =3D PTY_CHARDEV(chr);
-
-    if (!connected) {
-        if (s->open_tag) {
-            g_source_remove(s->open_tag);
-            s->open_tag =3D 0;
-        }
-        remove_fd_in_watch(chr);
-        s->connected =3D 0;
-        /* (re-)connect poll interval for idle guests: once per second.
-         * We check more frequently in case the guests sends data to
-         * the virtual device linked to our pty. */
-        pty_chr_rearm_timer(chr, 1000);
-    } else {
-        if (s->timer_tag) {
-            g_source_remove(s->timer_tag);
-            s->timer_tag =3D 0;
-        }
-        if (!s->connected) {
-            g_assert(s->open_tag =3D=3D 0);
-            s->connected =3D 1;
-            s->open_tag =3D g_idle_add(qemu_chr_be_generic_open_func, ch=
r);
-        }
-        if (!chr->fd_in_tag) {
-            chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
-                                               pty_chr_read_poll,
-                                               pty_chr_read,
-                                               chr, NULL);
-        }
-    }
-}
-
-static void char_pty_finalize(Object *obj)
-{
-    Chardev *chr =3D CHARDEV(obj);
-    PtyChardev *s =3D PTY_CHARDEV(obj);
-
-    qemu_mutex_lock(&chr->chr_write_lock);
-    pty_chr_state(chr, 0);
-    object_unref(OBJECT(s->ioc));
-    if (s->timer_tag) {
-        g_source_remove(s->timer_tag);
-        s->timer_tag =3D 0;
-    }
-    qemu_mutex_unlock(&chr->chr_write_lock);
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
-}
-
-static void char_pty_open(Chardev *chr,
-                          ChardevBackend *backend,
-                          bool *be_opened,
-                          Error **errp)
-{
-    PtyChardev *s;
-    int master_fd, slave_fd;
-    char pty_name[PATH_MAX];
-    char *name;
-
-    master_fd =3D qemu_openpty_raw(&slave_fd, pty_name);
-    if (master_fd < 0) {
-        error_setg_errno(errp, errno, "Failed to create PTY");
-        return;
-    }
-
-    close(slave_fd);
-    qemu_set_nonblock(master_fd);
-
-    chr->filename =3D g_strdup_printf("pty:%s", pty_name);
-    error_report("char device redirected to %s (label %s)",
-                 pty_name, chr->label);
-
-    s =3D PTY_CHARDEV(chr);
-    s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
-    name =3D g_strdup_printf("chardev-pty-%s", chr->label);
-    qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
-    g_free(name);
-    s->timer_tag =3D 0;
-    *be_opened =3D false;
-}
-
-static void char_pty_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->open =3D char_pty_open;
-    cc->chr_write =3D char_pty_chr_write;
-    cc->chr_update_read_handler =3D pty_chr_update_read_handler;
-    cc->chr_add_watch =3D pty_chr_add_watch;
-}
-
-static const TypeInfo char_pty_type_info =3D {
-    .name =3D TYPE_CHARDEV_PTY,
-    .parent =3D TYPE_CHARDEV,
-    .instance_size =3D sizeof(PtyChardev),
-    .instance_finalize =3D char_pty_finalize,
-    .class_init =3D char_pty_class_init,
-};
=20
 static void tty_serial_init(int fd, int speed,
                             int parity, int data_bits, int stop_bits)
@@ -2175,9 +1920,6 @@ static void register_types(void)
 #ifdef HAVE_CHARDEV_PARPORT
     type_register_static(&char_parallel_type_info);
 #endif
-#ifdef HAVE_CHARDEV_PTY
-    type_register_static(&char_pty_type_info);
-#endif
=20
     /* this must be done after machine init, since we register FEs with =
muxes
      * as part of realize functions like serial_isa_realizefn when -nogr=
aphic
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 778b312377..b2c14fe795 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -6,6 +6,7 @@ chardev-obj-y +=3D char-io.o
 chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
 chardev-obj-y +=3D char-pipe.o
+chardev-obj-$(CONFIG_POSIX) +=3D char-pty.o
 chardev-obj-y +=3D char-ringbuf.o
 chardev-obj-y +=3D char-socket.o
 chardev-obj-y +=3D char-stdio.o
--=20
2.11.0.295.gd7dffce1c.dirty
