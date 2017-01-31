Received: from eggs.gnu.org ([2001:4830:134:3::10]:46336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDb-0001US-Hn
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDZ-0001L5-Ec
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbDY-0001Kq-Tb
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:41 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:14 +0400
Message-Id: <20170131162122.29408-34-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/41] char: move udp chardev in its own file
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
 chardev/char-udp.c    | 233 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 198 ------------------------------------------
 chardev/Makefile.objs |   1 +
 3 files changed, 234 insertions(+), 198 deletions(-)
 create mode 100644 chardev/char-udp.c

diff --git a/chardev/char-udp.c b/chardev/char-udp.c
new file mode 100644
index 0000000000..2c6c7ddd73
--- /dev/null
+++ b/chardev/char-udp.c
@@ -0,0 +1,233 @@
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
+#include "io/channel-socket.h"
+#include "qapi/error.h"
+
+#include "char-io.h"
+
+/***********************************************************/
+/* UDP Net console */
+
+typedef struct {
+    Chardev parent;
+    QIOChannel *ioc;
+    uint8_t buf[CHR_READ_BUF_LEN];
+    int bufcnt;
+    int bufptr;
+    int max_size;
+} UdpChardev;
+
+#define UDP_CHARDEV(obj) OBJECT_CHECK(UdpChardev, (obj), TYPE_CHARDEV_UD=
P)
+
+/* Called with chr_write_lock held.  */
+static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    UdpChardev *s =3D UDP_CHARDEV(chr);
+
+    return qio_channel_write(
+        s->ioc, (const char *)buf, len, NULL);
+}
+
+static int udp_chr_read_poll(void *opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    UdpChardev *s =3D UDP_CHARDEV(opaque);
+
+    s->max_size =3D qemu_chr_be_can_write(chr);
+
+    /* If there were any stray characters in the queue process them
+     * first
+     */
+    while (s->max_size > 0 && s->bufptr < s->bufcnt) {
+        qemu_chr_be_write(chr, &s->buf[s->bufptr], 1);
+        s->bufptr++;
+        s->max_size =3D qemu_chr_be_can_write(chr);
+    }
+    return s->max_size;
+}
+
+static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    UdpChardev *s =3D UDP_CHARDEV(opaque);
+    ssize_t ret;
+
+    if (s->max_size =3D=3D 0) {
+        return TRUE;
+    }
+    ret =3D qio_channel_read(
+        s->ioc, (char *)s->buf, sizeof(s->buf), NULL);
+    if (ret <=3D 0) {
+        remove_fd_in_watch(chr);
+        return FALSE;
+    }
+    s->bufcnt =3D ret;
+
+    s->bufptr =3D 0;
+    while (s->max_size > 0 && s->bufptr < s->bufcnt) {
+        qemu_chr_be_write(chr, &s->buf[s->bufptr], 1);
+        s->bufptr++;
+        s->max_size =3D qemu_chr_be_can_write(chr);
+    }
+
+    return TRUE;
+}
+
+static void udp_chr_update_read_handler(Chardev *chr,
+                                        GMainContext *context)
+{
+    UdpChardev *s =3D UDP_CHARDEV(chr);
+
+    remove_fd_in_watch(chr);
+    if (s->ioc) {
+        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
+                                           udp_chr_read_poll,
+                                           udp_chr_read, chr,
+                                           context);
+    }
+}
+
+static void char_udp_finalize(Object *obj)
+{
+    Chardev *chr =3D CHARDEV(obj);
+    UdpChardev *s =3D UDP_CHARDEV(obj);
+
+    remove_fd_in_watch(chr);
+    if (s->ioc) {
+        object_unref(OBJECT(s->ioc));
+    }
+    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+}
+
+static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
+                               Error **errp)
+{
+    const char *host =3D qemu_opt_get(opts, "host");
+    const char *port =3D qemu_opt_get(opts, "port");
+    const char *localaddr =3D qemu_opt_get(opts, "localaddr");
+    const char *localport =3D qemu_opt_get(opts, "localport");
+    bool has_local =3D false;
+    SocketAddress *addr;
+    ChardevUdp *udp;
+
+    backend->type =3D CHARDEV_BACKEND_KIND_UDP;
+    if (host =3D=3D NULL || strlen(host) =3D=3D 0) {
+        host =3D "localhost";
+    }
+    if (port =3D=3D NULL || strlen(port) =3D=3D 0) {
+        error_setg(errp, "chardev: udp: remote port not specified");
+        return;
+    }
+    if (localport =3D=3D NULL || strlen(localport) =3D=3D 0) {
+        localport =3D "0";
+    } else {
+        has_local =3D true;
+    }
+    if (localaddr =3D=3D NULL || strlen(localaddr) =3D=3D 0) {
+        localaddr =3D "";
+    } else {
+        has_local =3D true;
+    }
+
+    udp =3D backend->u.udp.data =3D g_new0(ChardevUdp, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevUdp_base(udp));
+
+    addr =3D g_new0(SocketAddress, 1);
+    addr->type =3D SOCKET_ADDRESS_KIND_INET;
+    addr->u.inet.data =3D g_new(InetSocketAddress, 1);
+    *addr->u.inet.data =3D (InetSocketAddress) {
+        .host =3D g_strdup(host),
+        .port =3D g_strdup(port),
+        .has_ipv4 =3D qemu_opt_get(opts, "ipv4"),
+        .ipv4 =3D qemu_opt_get_bool(opts, "ipv4", 0),
+        .has_ipv6 =3D qemu_opt_get(opts, "ipv6"),
+        .ipv6 =3D qemu_opt_get_bool(opts, "ipv6", 0),
+    };
+    udp->remote =3D addr;
+
+    if (has_local) {
+        udp->has_local =3D true;
+        addr =3D g_new0(SocketAddress, 1);
+        addr->type =3D SOCKET_ADDRESS_KIND_INET;
+        addr->u.inet.data =3D g_new(InetSocketAddress, 1);
+        *addr->u.inet.data =3D (InetSocketAddress) {
+            .host =3D g_strdup(localaddr),
+            .port =3D g_strdup(localport),
+        };
+        udp->local =3D addr;
+    }
+}
+
+static void qmp_chardev_open_udp(Chardev *chr,
+                                 ChardevBackend *backend,
+                                 bool *be_opened,
+                                 Error **errp)
+{
+    ChardevUdp *udp =3D backend->u.udp.data;
+    QIOChannelSocket *sioc =3D qio_channel_socket_new();
+    char *name;
+    UdpChardev *s =3D UDP_CHARDEV(chr);
+
+    if (qio_channel_socket_dgram_sync(sioc,
+                                      udp->local, udp->remote,
+                                      errp) < 0) {
+        object_unref(OBJECT(sioc));
+        return;
+    }
+
+    name =3D g_strdup_printf("chardev-udp-%s", chr->label);
+    qio_channel_set_name(QIO_CHANNEL(sioc), name);
+    g_free(name);
+
+    s->ioc =3D QIO_CHANNEL(sioc);
+    /* be isn't opened until we get a connection */
+    *be_opened =3D false;
+}
+
+static void char_udp_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_udp;
+    cc->open =3D qmp_chardev_open_udp;
+    cc->chr_write =3D udp_chr_write;
+    cc->chr_update_read_handler =3D udp_chr_update_read_handler;
+}
+
+static const TypeInfo char_udp_type_info =3D {
+    .name =3D TYPE_CHARDEV_UDP,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(UdpChardev),
+    .instance_finalize =3D char_udp_finalize,
+    .class_init =3D char_udp_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_udp_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index 73b6663aa4..05fceb0d73 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1513,100 +1513,6 @@ static const TypeInfo char_console_type_info =3D =
{
=20
 #endif /* !_WIN32 */
=20
-/***********************************************************/
-/* UDP Net console */
-
-typedef struct {
-    Chardev parent;
-    QIOChannel *ioc;
-    uint8_t buf[CHR_READ_BUF_LEN];
-    int bufcnt;
-    int bufptr;
-    int max_size;
-} UdpChardev;
-
-#define UDP_CHARDEV(obj) OBJECT_CHECK(UdpChardev, (obj), TYPE_CHARDEV_UD=
P)
-
-/* Called with chr_write_lock held.  */
-static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
-{
-    UdpChardev *s =3D UDP_CHARDEV(chr);
-
-    return qio_channel_write(
-        s->ioc, (const char *)buf, len, NULL);
-}
-
-static int udp_chr_read_poll(void *opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    UdpChardev *s =3D UDP_CHARDEV(opaque);
-
-    s->max_size =3D qemu_chr_be_can_write(chr);
-
-    /* If there were any stray characters in the queue process them
-     * first
-     */
-    while (s->max_size > 0 && s->bufptr < s->bufcnt) {
-        qemu_chr_be_write(chr, &s->buf[s->bufptr], 1);
-        s->bufptr++;
-        s->max_size =3D qemu_chr_be_can_write(chr);
-    }
-    return s->max_size;
-}
-
-static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    UdpChardev *s =3D UDP_CHARDEV(opaque);
-    ssize_t ret;
-
-    if (s->max_size =3D=3D 0) {
-        return TRUE;
-    }
-    ret =3D qio_channel_read(
-        s->ioc, (char *)s->buf, sizeof(s->buf), NULL);
-    if (ret <=3D 0) {
-        remove_fd_in_watch(chr);
-        return FALSE;
-    }
-    s->bufcnt =3D ret;
-
-    s->bufptr =3D 0;
-    while (s->max_size > 0 && s->bufptr < s->bufcnt) {
-        qemu_chr_be_write(chr, &s->buf[s->bufptr], 1);
-        s->bufptr++;
-        s->max_size =3D qemu_chr_be_can_write(chr);
-    }
-
-    return TRUE;
-}
-
-static void udp_chr_update_read_handler(Chardev *chr,
-                                        GMainContext *context)
-{
-    UdpChardev *s =3D UDP_CHARDEV(chr);
-
-    remove_fd_in_watch(chr);
-    if (s->ioc) {
-        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
-                                           udp_chr_read_poll,
-                                           udp_chr_read, chr,
-                                           context);
-    }
-}
-
-static void char_udp_finalize(Object *obj)
-{
-    Chardev *chr =3D CHARDEV(obj);
-    UdpChardev *s =3D UDP_CHARDEV(obj);
-
-    remove_fd_in_watch(chr);
-    if (s->ioc) {
-        object_unref(OBJECT(s->ioc));
-    }
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
-}
-
 int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
     ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
@@ -1905,65 +1811,6 @@ static const TypeInfo char_pipe_type_info =3D {
     .class_init =3D char_pipe_class_init,
 };
=20
-static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
-                               Error **errp)
-{
-    const char *host =3D qemu_opt_get(opts, "host");
-    const char *port =3D qemu_opt_get(opts, "port");
-    const char *localaddr =3D qemu_opt_get(opts, "localaddr");
-    const char *localport =3D qemu_opt_get(opts, "localport");
-    bool has_local =3D false;
-    SocketAddress *addr;
-    ChardevUdp *udp;
-
-    backend->type =3D CHARDEV_BACKEND_KIND_UDP;
-    if (host =3D=3D NULL || strlen(host) =3D=3D 0) {
-        host =3D "localhost";
-    }
-    if (port =3D=3D NULL || strlen(port) =3D=3D 0) {
-        error_setg(errp, "chardev: udp: remote port not specified");
-        return;
-    }
-    if (localport =3D=3D NULL || strlen(localport) =3D=3D 0) {
-        localport =3D "0";
-    } else {
-        has_local =3D true;
-    }
-    if (localaddr =3D=3D NULL || strlen(localaddr) =3D=3D 0) {
-        localaddr =3D "";
-    } else {
-        has_local =3D true;
-    }
-
-    udp =3D backend->u.udp.data =3D g_new0(ChardevUdp, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevUdp_base(udp));
-
-    addr =3D g_new0(SocketAddress, 1);
-    addr->type =3D SOCKET_ADDRESS_KIND_INET;
-    addr->u.inet.data =3D g_new(InetSocketAddress, 1);
-    *addr->u.inet.data =3D (InetSocketAddress) {
-        .host =3D g_strdup(host),
-        .port =3D g_strdup(port),
-        .has_ipv4 =3D qemu_opt_get(opts, "ipv4"),
-        .ipv4 =3D qemu_opt_get_bool(opts, "ipv4", 0),
-        .has_ipv6 =3D qemu_opt_get(opts, "ipv6"),
-        .ipv6 =3D qemu_opt_get_bool(opts, "ipv6", 0),
-    };
-    udp->remote =3D addr;
-
-    if (has_local) {
-        udp->has_local =3D true;
-        addr =3D g_new0(SocketAddress, 1);
-        addr->type =3D SOCKET_ADDRESS_KIND_INET;
-        addr->u.inet.data =3D g_new(InetSocketAddress, 1);
-        *addr->u.inet.data =3D (InetSocketAddress) {
-            .host =3D g_strdup(localaddr),
-            .port =3D g_strdup(localport),
-        };
-        udp->local =3D addr;
-    }
-}
-
 static const ChardevClass *char_get_class(const char *driver, Error **er=
rp)
 {
     ObjectClass *oc;
@@ -2610,50 +2457,6 @@ static const TypeInfo char_serial_type_info =3D {
 };
 #endif
=20
-static void qmp_chardev_open_udp(Chardev *chr,
-                                 ChardevBackend *backend,
-                                 bool *be_opened,
-                                 Error **errp)
-{
-    ChardevUdp *udp =3D backend->u.udp.data;
-    QIOChannelSocket *sioc =3D qio_channel_socket_new();
-    char *name;
-    UdpChardev *s =3D UDP_CHARDEV(chr);
-
-    if (qio_channel_socket_dgram_sync(sioc,
-                                      udp->local, udp->remote,
-                                      errp) < 0) {
-        object_unref(OBJECT(sioc));
-        return;
-    }
-
-    name =3D g_strdup_printf("chardev-udp-%s", chr->label);
-    qio_channel_set_name(QIO_CHANNEL(sioc), name);
-    g_free(name);
-
-    s->ioc =3D QIO_CHANNEL(sioc);
-    /* be isn't opened until we get a connection */
-    *be_opened =3D false;
-}
-
-static void char_udp_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->parse =3D qemu_chr_parse_udp;
-    cc->open =3D qmp_chardev_open_udp;
-    cc->chr_write =3D udp_chr_write;
-    cc->chr_update_read_handler =3D udp_chr_update_read_handler;
-}
-
-static const TypeInfo char_udp_type_info =3D {
-    .name =3D TYPE_CHARDEV_UDP,
-    .parent =3D TYPE_CHARDEV,
-    .instance_size =3D sizeof(UdpChardev),
-    .instance_finalize =3D char_udp_finalize,
-    .class_init =3D char_udp_class_init,
-};
-
 bool qemu_chr_has_feature(Chardev *chr,
                           ChardevFeature feature)
 {
@@ -2755,7 +2558,6 @@ void qemu_chr_cleanup(void)
 static void register_types(void)
 {
     type_register_static(&char_type_info);
-    type_register_static(&char_udp_type_info);
     type_register_static(&char_file_type_info);
     type_register_static(&char_stdio_type_info);
 #ifdef HAVE_CHARDEV_SERIAL
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index c57c375d5b..dddef029e7 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -5,5 +5,6 @@ chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
 chardev-obj-y +=3D char-ringbuf.o
 chardev-obj-y +=3D char-socket.o
+chardev-obj-y +=3D char-udp.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
--=20
2.11.0.295.gd7dffce1c.dirty
