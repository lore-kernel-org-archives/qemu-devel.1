Received: from eggs.gnu.org ([2001:4830:134:3::10]:46092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDF-00019g-OK
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDD-0001EX-Qv
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbDD-0001EB-HF
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:19 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:09 +0400
Message-Id: <20170131162122.29408-29-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/41] char: move QIOChannel-related stuff to
 char-io.h
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-io.h     |  46 ++++++++++++
 chardev/char-io.c     | 192 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 174 +-------------------------------------------=
-
 chardev/Makefile.objs |   1 +
 4 files changed, 240 insertions(+), 173 deletions(-)
 create mode 100644 chardev/char-io.h
 create mode 100644 chardev/char-io.c

diff --git a/chardev/char-io.h b/chardev/char-io.h
new file mode 100644
index 0000000000..d7ae5f1585
--- /dev/null
+++ b/chardev/char-io.h
@@ -0,0 +1,46 @@
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
+#ifndef CHAR_IO_H
+#define CHAR_IO_H
+
+#include "qemu-common.h"
+#include "io/channel.h"
+#include "sysemu/char.h"
+
+/* Can only be used for read */
+guint io_add_watch_poll(Chardev *chr,
+                        QIOChannel *ioc,
+                        IOCanReadHandler *fd_can_read,
+                        QIOChannelFunc fd_read,
+                        gpointer user_data,
+                        GMainContext *context);
+
+void remove_fd_in_watch(Chardev *chr);
+
+int io_channel_send(QIOChannel *ioc, const void *buf, size_t len);
+
+int io_channel_send_full(QIOChannel *ioc, const void *buf, size_t len,
+                         int *fds, size_t nfds);
+
+#endif /* CHAR_IO_H */
diff --git a/chardev/char-io.c b/chardev/char-io.c
new file mode 100644
index 0000000000..7dfc3f22ba
--- /dev/null
+++ b/chardev/char-io.c
@@ -0,0 +1,192 @@
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
+#include "char-io.h"
+
+typedef struct IOWatchPoll {
+    GSource parent;
+
+    QIOChannel *ioc;
+    GSource *src;
+
+    IOCanReadHandler *fd_can_read;
+    GSourceFunc fd_read;
+    void *opaque;
+    GMainContext *context;
+} IOWatchPoll;
+
+static IOWatchPoll *io_watch_poll_from_source(GSource *source)
+{
+    return container_of(source, IOWatchPoll, parent);
+}
+
+static gboolean io_watch_poll_prepare(GSource *source,
+                                      gint *timeout)
+{
+    IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
+    bool now_active =3D iwp->fd_can_read(iwp->opaque) > 0;
+    bool was_active =3D iwp->src !=3D NULL;
+    if (was_active =3D=3D now_active) {
+        return FALSE;
+    }
+
+    if (now_active) {
+        iwp->src =3D qio_channel_create_watch(
+            iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
+        g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque, NULL)=
;
+        g_source_attach(iwp->src, iwp->context);
+    } else {
+        g_source_destroy(iwp->src);
+        g_source_unref(iwp->src);
+        iwp->src =3D NULL;
+    }
+    return FALSE;
+}
+
+static gboolean io_watch_poll_check(GSource *source)
+{
+    return FALSE;
+}
+
+static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc call=
back,
+                                       gpointer user_data)
+{
+    abort();
+}
+
+static void io_watch_poll_finalize(GSource *source)
+{
+    /* Due to a glib bug, removing the last reference to a source
+     * inside a finalize callback causes recursive locking (and a
+     * deadlock).  This is not a problem inside other callbacks,
+     * including dispatch callbacks, so we call io_remove_watch_poll
+     * to remove this source.  At this point, iwp->src must
+     * be NULL, or we would leak it.
+     *
+     * This would be solved much more elegantly by child sources,
+     * but we support older glib versions that do not have them.
+     */
+    IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
+    assert(iwp->src =3D=3D NULL);
+}
+
+static GSourceFuncs io_watch_poll_funcs =3D {
+    .prepare =3D io_watch_poll_prepare,
+    .check =3D io_watch_poll_check,
+    .dispatch =3D io_watch_poll_dispatch,
+    .finalize =3D io_watch_poll_finalize,
+};
+
+guint io_add_watch_poll(Chardev *chr,
+                        QIOChannel *ioc,
+                        IOCanReadHandler *fd_can_read,
+                        QIOChannelFunc fd_read,
+                        gpointer user_data,
+                        GMainContext *context)
+{
+    IOWatchPoll *iwp;
+    int tag;
+    char *name;
+
+    iwp =3D (IOWatchPoll *) g_source_new(&io_watch_poll_funcs,
+                                       sizeof(IOWatchPoll));
+    iwp->fd_can_read =3D fd_can_read;
+    iwp->opaque =3D user_data;
+    iwp->ioc =3D ioc;
+    iwp->fd_read =3D (GSourceFunc) fd_read;
+    iwp->src =3D NULL;
+    iwp->context =3D context;
+
+    name =3D g_strdup_printf("chardev-iowatch-%s", chr->label);
+    g_source_set_name((GSource *)iwp, name);
+    g_free(name);
+
+    tag =3D g_source_attach(&iwp->parent, context);
+    g_source_unref(&iwp->parent);
+    return tag;
+}
+
+static void io_remove_watch_poll(guint tag)
+{
+    GSource *source;
+    IOWatchPoll *iwp;
+
+    g_return_if_fail(tag > 0);
+
+    source =3D g_main_context_find_source_by_id(NULL, tag);
+    g_return_if_fail(source !=3D NULL);
+
+    iwp =3D io_watch_poll_from_source(source);
+    if (iwp->src) {
+        g_source_destroy(iwp->src);
+        g_source_unref(iwp->src);
+        iwp->src =3D NULL;
+    }
+    g_source_destroy(&iwp->parent);
+}
+
+void remove_fd_in_watch(Chardev *chr)
+{
+    if (chr->fd_in_tag) {
+        io_remove_watch_poll(chr->fd_in_tag);
+        chr->fd_in_tag =3D 0;
+    }
+}
+
+int io_channel_send_full(QIOChannel *ioc,
+                         const void *buf, size_t len,
+                         int *fds, size_t nfds)
+{
+    size_t offset =3D 0;
+
+    while (offset < len) {
+        ssize_t ret =3D 0;
+        struct iovec iov =3D { .iov_base =3D (char *)buf + offset,
+                             .iov_len =3D len - offset };
+
+        ret =3D qio_channel_writev_full(
+            ioc, &iov, 1,
+            fds, nfds, NULL);
+        if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
+            if (offset) {
+                return offset;
+            }
+
+            errno =3D EAGAIN;
+            return -1;
+        } else if (ret < 0) {
+            errno =3D EINVAL;
+            return -1;
+        }
+
+        offset +=3D ret;
+    }
+
+    return offset;
+}
+
+int io_channel_send(QIOChannel *ioc, const void *buf, size_t len)
+{
+    return io_channel_send_full(ioc, buf, len, NULL, 0);
+}
diff --git a/chardev/char.c b/chardev/char.c
index 722c98dc33..3cbe42a1a8 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -86,6 +86,7 @@
 #include "ui/qemu-spice.h"
=20
 #include "char-mux.h"
+#include "char-io.h"
=20
 #define TCP_MAX_FDS 16
=20
@@ -479,8 +480,6 @@ void qemu_chr_fe_printf(CharBackend *be, const char *=
fmt, ...)
     va_end(ap);
 }
=20
-static void remove_fd_in_watch(Chardev *chr);
-
 static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
                            bool *be_opened, Error **errp)
 {
@@ -716,178 +715,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
     }
 }
=20
-typedef struct IOWatchPoll
-{
-    GSource parent;
-
-    QIOChannel *ioc;
-    GSource *src;
-
-    IOCanReadHandler *fd_can_read;
-    GSourceFunc fd_read;
-    void *opaque;
-    GMainContext *context;
-} IOWatchPoll;
-
-static IOWatchPoll *io_watch_poll_from_source(GSource *source)
-{
-    return container_of(source, IOWatchPoll, parent);
-}
-
-static gboolean io_watch_poll_prepare(GSource *source,
-                                      gint *timeout_)
-{
-    IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
-    bool now_active =3D iwp->fd_can_read(iwp->opaque) > 0;
-    bool was_active =3D iwp->src !=3D NULL;
-    if (was_active =3D=3D now_active) {
-        return FALSE;
-    }
-
-    if (now_active) {
-        iwp->src =3D qio_channel_create_watch(
-            iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
-        g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque, NULL)=
;
-        g_source_attach(iwp->src, iwp->context);
-    } else {
-        g_source_destroy(iwp->src);
-        g_source_unref(iwp->src);
-        iwp->src =3D NULL;
-    }
-    return FALSE;
-}
-
-static gboolean io_watch_poll_check(GSource *source)
-{
-    return FALSE;
-}
-
-static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc call=
back,
-                                       gpointer user_data)
-{
-    abort();
-}
-
-static void io_watch_poll_finalize(GSource *source)
-{
-    /* Due to a glib bug, removing the last reference to a source
-     * inside a finalize callback causes recursive locking (and a
-     * deadlock).  This is not a problem inside other callbacks,
-     * including dispatch callbacks, so we call io_remove_watch_poll
-     * to remove this source.  At this point, iwp->src must
-     * be NULL, or we would leak it.
-     *
-     * This would be solved much more elegantly by child sources,
-     * but we support older glib versions that do not have them.
-     */
-    IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
-    assert(iwp->src =3D=3D NULL);
-}
-
-static GSourceFuncs io_watch_poll_funcs =3D {
-    .prepare =3D io_watch_poll_prepare,
-    .check =3D io_watch_poll_check,
-    .dispatch =3D io_watch_poll_dispatch,
-    .finalize =3D io_watch_poll_finalize,
-};
-
-/* Can only be used for read */
-static guint io_add_watch_poll(Chardev *chr,
-                               QIOChannel *ioc,
-                               IOCanReadHandler *fd_can_read,
-                               QIOChannelFunc fd_read,
-                               gpointer user_data,
-                               GMainContext *context)
-{
-    IOWatchPoll *iwp;
-    int tag;
-    char *name;
-
-    iwp =3D (IOWatchPoll *) g_source_new(&io_watch_poll_funcs,
-                                       sizeof(IOWatchPoll));
-    iwp->fd_can_read =3D fd_can_read;
-    iwp->opaque =3D user_data;
-    iwp->ioc =3D ioc;
-    iwp->fd_read =3D (GSourceFunc) fd_read;
-    iwp->src =3D NULL;
-    iwp->context =3D context;
-
-    name =3D g_strdup_printf("chardev-iowatch-%s", chr->label);
-    g_source_set_name((GSource *)iwp, name);
-    g_free(name);
-
-    tag =3D g_source_attach(&iwp->parent, context);
-    g_source_unref(&iwp->parent);
-    return tag;
-}
-
-static void io_remove_watch_poll(guint tag)
-{
-    GSource *source;
-    IOWatchPoll *iwp;
-
-    g_return_if_fail (tag > 0);
-
-    source =3D g_main_context_find_source_by_id(NULL, tag);
-    g_return_if_fail (source !=3D NULL);
-
-    iwp =3D io_watch_poll_from_source(source);
-    if (iwp->src) {
-        g_source_destroy(iwp->src);
-        g_source_unref(iwp->src);
-        iwp->src =3D NULL;
-    }
-    g_source_destroy(&iwp->parent);
-}
-
-static void remove_fd_in_watch(Chardev *chr)
-{
-    if (chr->fd_in_tag) {
-        io_remove_watch_poll(chr->fd_in_tag);
-        chr->fd_in_tag =3D 0;
-    }
-}
-
-
-static int io_channel_send_full(QIOChannel *ioc,
-                                const void *buf, size_t len,
-                                int *fds, size_t nfds)
-{
-    size_t offset =3D 0;
-
-    while (offset < len) {
-        ssize_t ret =3D 0;
-        struct iovec iov =3D { .iov_base =3D (char *)buf + offset,
-                             .iov_len =3D len - offset };
-
-        ret =3D qio_channel_writev_full(
-            ioc, &iov, 1,
-            fds, nfds, NULL);
-        if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
-            if (offset) {
-                return offset;
-            }
-
-            errno =3D EAGAIN;
-            return -1;
-        } else if (ret < 0) {
-            errno =3D EINVAL;
-            return -1;
-        }
-
-        offset +=3D ret;
-    }
-
-    return offset;
-}
-
-
 #ifndef _WIN32
-static int io_channel_send(QIOChannel *ioc, const void *buf, size_t len)
-{
-    return io_channel_send_full(ioc, buf, len, NULL, 0);
-}
-
 typedef struct FDChardev {
     Chardev parent;
     Chardev *chr;
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index d4ffb8d70e..5f5d3716ac 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,4 +1,5 @@
 chardev-obj-y +=3D char.o
+chardev-obj-y +=3D char-io.o
 chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
 chardev-obj-y +=3D char-ringbuf.o
--=20
2.11.0.295.gd7dffce1c.dirty
