Received: from eggs.gnu.org ([2001:4830:134:3::10]:46330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDa-0001Tn-Q7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDV-0001Kd-IL
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbDU-0001K9-UX
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:37 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:13 +0400
Message-Id: <20170131162122.29408-33-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/41] char: move socket chardev to its own file
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
 include/sysemu/char.h |    1 +
 chardev/char-socket.c | 1017 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        |  979 +------------------------------------------=
----
 chardev/Makefile.objs |    1 +
 4 files changed, 1020 insertions(+), 978 deletions(-)
 create mode 100644 chardev/char-socket.c

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 1a65798e3e..b256e79c31 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -443,6 +443,7 @@ void qemu_chr_set_feature(Chardev *chr,
                           ChardevFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)=
;
 int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len);
+int qemu_chr_wait_connected(Chardev *chr, Error **errp);
=20
 #define TYPE_CHARDEV "chardev"
 #define CHARDEV(obj) OBJECT_CHECK(Chardev, (obj), TYPE_CHARDEV)
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
new file mode 100644
index 0000000000..4068dc5e52
--- /dev/null
+++ b/chardev/char-socket.c
@@ -0,0 +1,1017 @@
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
+#include "io/channel-tls.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/clone-visitor.h"
+
+#include "char-io.h"
+
+/***********************************************************/
+/* TCP Net console */
+
+#define TCP_MAX_FDS 16
+
+typedef struct {
+    Chardev parent;
+    QIOChannel *ioc; /* Client I/O channel */
+    QIOChannelSocket *sioc; /* Client master channel */
+    QIOChannelSocket *listen_ioc;
+    guint listen_tag;
+    QCryptoTLSCreds *tls_creds;
+    int connected;
+    int max_size;
+    int do_telnetopt;
+    int do_nodelay;
+    int is_unix;
+    int *read_msgfds;
+    size_t read_msgfds_num;
+    int *write_msgfds;
+    size_t write_msgfds_num;
+
+    SocketAddress *addr;
+    bool is_listen;
+    bool is_telnet;
+
+    guint reconnect_timer;
+    int64_t reconnect_time;
+    bool connect_err_reported;
+} SocketChardev;
+
+#define SOCKET_CHARDEV(obj)                                     \
+    OBJECT_CHECK(SocketChardev, (obj), TYPE_CHARDEV_SOCKET)
+
+static gboolean socket_reconnect_timeout(gpointer opaque);
+
+static void qemu_chr_socket_restart_timer(Chardev *chr)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    char *name;
+
+    assert(s->connected =3D=3D 0);
+    s->reconnect_timer =3D g_timeout_add_seconds(s->reconnect_time,
+                                               socket_reconnect_timeout,=
 chr);
+    name =3D g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
+    g_source_set_name_by_id(s->reconnect_timer, name);
+    g_free(name);
+}
+
+static void check_report_connect_error(Chardev *chr,
+                                       Error *err)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+
+    if (!s->connect_err_reported) {
+        error_report("Unable to connect character device %s: %s",
+                     chr->label, error_get_pretty(err));
+        s->connect_err_reported =3D true;
+    }
+    qemu_chr_socket_restart_timer(chr);
+}
+
+static gboolean tcp_chr_accept(QIOChannel *chan,
+                               GIOCondition cond,
+                               void *opaque);
+
+/* Called with chr_write_lock held.  */
+static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+
+    if (s->connected) {
+        int ret =3D  io_channel_send_full(s->ioc, buf, len,
+                                        s->write_msgfds,
+                                        s->write_msgfds_num);
+
+        /* free the written msgfds, no matter what */
+        if (s->write_msgfds_num) {
+            g_free(s->write_msgfds);
+            s->write_msgfds =3D 0;
+            s->write_msgfds_num =3D 0;
+        }
+
+        return ret;
+    } else {
+        /* XXX: indicate an error ? */
+        return len;
+    }
+}
+
+static int tcp_chr_read_poll(void *opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
+    if (!s->connected) {
+        return 0;
+    }
+    s->max_size =3D qemu_chr_be_can_write(chr);
+    return s->max_size;
+}
+
+#define IAC 255
+#define IAC_BREAK 243
+static void tcp_chr_process_IAC_bytes(Chardev *chr,
+                                      SocketChardev *s,
+                                      uint8_t *buf, int *size)
+{
+    /* Handle any telnet client's basic IAC options to satisfy char by
+     * char mode with no echo.  All IAC options will be removed from
+     * the buf and the do_telnetopt variable will be used to track the
+     * state of the width of the IAC information.
+     *
+     * IAC commands come in sets of 3 bytes with the exception of the
+     * "IAC BREAK" command and the double IAC.
+     */
+
+    int i;
+    int j =3D 0;
+
+    for (i =3D 0; i < *size; i++) {
+        if (s->do_telnetopt > 1) {
+            if ((unsigned char)buf[i] =3D=3D IAC && s->do_telnetopt =3D=3D=
 2) {
+                /* Double IAC means send an IAC */
+                if (j !=3D i) {
+                    buf[j] =3D buf[i];
+                }
+                j++;
+                s->do_telnetopt =3D 1;
+            } else {
+                if ((unsigned char)buf[i] =3D=3D IAC_BREAK
+                    && s->do_telnetopt =3D=3D 2) {
+                    /* Handle IAC break commands by sending a serial bre=
ak */
+                    qemu_chr_be_event(chr, CHR_EVENT_BREAK);
+                    s->do_telnetopt++;
+                }
+                s->do_telnetopt++;
+            }
+            if (s->do_telnetopt >=3D 4) {
+                s->do_telnetopt =3D 1;
+            }
+        } else {
+            if ((unsigned char)buf[i] =3D=3D IAC) {
+                s->do_telnetopt =3D 2;
+            } else {
+                if (j !=3D i) {
+                    buf[j] =3D buf[i];
+                }
+                j++;
+            }
+        }
+    }
+    *size =3D j;
+}
+
+static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+
+    int to_copy =3D (s->read_msgfds_num < num) ? s->read_msgfds_num : nu=
m;
+
+    assert(num <=3D TCP_MAX_FDS);
+
+    if (to_copy) {
+        int i;
+
+        memcpy(fds, s->read_msgfds, to_copy * sizeof(int));
+
+        /* Close unused fds */
+        for (i =3D to_copy; i < s->read_msgfds_num; i++) {
+            close(s->read_msgfds[i]);
+        }
+
+        g_free(s->read_msgfds);
+        s->read_msgfds =3D 0;
+        s->read_msgfds_num =3D 0;
+    }
+
+    return to_copy;
+}
+
+static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+
+    /* clear old pending fd array */
+    g_free(s->write_msgfds);
+    s->write_msgfds =3D NULL;
+    s->write_msgfds_num =3D 0;
+
+    if (!s->connected ||
+        !qio_channel_has_feature(s->ioc,
+                                 QIO_CHANNEL_FEATURE_FD_PASS)) {
+        return -1;
+    }
+
+    if (num) {
+        s->write_msgfds =3D g_new(int, num);
+        memcpy(s->write_msgfds, fds, num * sizeof(int));
+    }
+
+    s->write_msgfds_num =3D num;
+
+    return 0;
+}
+
+static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D len };
+    int ret;
+    size_t i;
+    int *msgfds =3D NULL;
+    size_t msgfds_num =3D 0;
+
+    if (qio_channel_has_feature(s->ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
+        ret =3D qio_channel_readv_full(s->ioc, &iov, 1,
+                                     &msgfds, &msgfds_num,
+                                     NULL);
+    } else {
+        ret =3D qio_channel_readv_full(s->ioc, &iov, 1,
+                                     NULL, NULL,
+                                     NULL);
+    }
+
+    if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
+        errno =3D EAGAIN;
+        ret =3D -1;
+    } else if (ret =3D=3D -1) {
+        errno =3D EIO;
+    }
+
+    if (msgfds_num) {
+        /* close and clean read_msgfds */
+        for (i =3D 0; i < s->read_msgfds_num; i++) {
+            close(s->read_msgfds[i]);
+        }
+
+        if (s->read_msgfds_num) {
+            g_free(s->read_msgfds);
+        }
+
+        s->read_msgfds =3D msgfds;
+        s->read_msgfds_num =3D msgfds_num;
+    }
+
+    for (i =3D 0; i < s->read_msgfds_num; i++) {
+        int fd =3D s->read_msgfds[i];
+        if (fd < 0) {
+            continue;
+        }
+
+        /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
+        qemu_set_block(fd);
+
+#ifndef MSG_CMSG_CLOEXEC
+        qemu_set_cloexec(fd);
+#endif
+    }
+
+    return ret;
+}
+
+static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    return qio_channel_create_watch(s->ioc, cond);
+}
+
+static void tcp_chr_free_connection(Chardev *chr)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    int i;
+
+    if (!s->connected) {
+        return;
+    }
+
+    if (s->read_msgfds_num) {
+        for (i =3D 0; i < s->read_msgfds_num; i++) {
+            close(s->read_msgfds[i]);
+        }
+        g_free(s->read_msgfds);
+        s->read_msgfds =3D NULL;
+        s->read_msgfds_num =3D 0;
+    }
+
+    tcp_set_msgfds(chr, NULL, 0);
+    remove_fd_in_watch(chr);
+    object_unref(OBJECT(s->sioc));
+    s->sioc =3D NULL;
+    object_unref(OBJECT(s->ioc));
+    s->ioc =3D NULL;
+    g_free(chr->filename);
+    chr->filename =3D NULL;
+    s->connected =3D 0;
+}
+
+static char *SocketAddress_to_str(const char *prefix, SocketAddress *add=
r,
+                                  bool is_listen, bool is_telnet)
+{
+    switch (addr->type) {
+    case SOCKET_ADDRESS_KIND_INET:
+        return g_strdup_printf("%s%s:%s:%s%s", prefix,
+                               is_telnet ? "telnet" : "tcp",
+                               addr->u.inet.data->host,
+                               addr->u.inet.data->port,
+                               is_listen ? ",server" : "");
+        break;
+    case SOCKET_ADDRESS_KIND_UNIX:
+        return g_strdup_printf("%sunix:%s%s", prefix,
+                               addr->u.q_unix.data->path,
+                               is_listen ? ",server" : "");
+        break;
+    case SOCKET_ADDRESS_KIND_FD:
+        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.data->str=
,
+                               is_listen ? ",server" : "");
+        break;
+    default:
+        abort();
+    }
+}
+
+static void tcp_chr_disconnect(Chardev *chr)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+
+    if (!s->connected) {
+        return;
+    }
+
+    tcp_chr_free_connection(chr);
+
+    if (s->listen_ioc) {
+        s->listen_tag =3D qio_channel_add_watch(
+            QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, NU=
LL);
+    }
+    chr->filename =3D SocketAddress_to_str("disconnected:", s->addr,
+                                         s->is_listen, s->is_telnet);
+    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+    if (s->reconnect_time) {
+        qemu_chr_socket_restart_timer(chr);
+    }
+}
+
+static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
+    uint8_t buf[CHR_READ_BUF_LEN];
+    int len, size;
+
+    if (!s->connected || s->max_size <=3D 0) {
+        return TRUE;
+    }
+    len =3D sizeof(buf);
+    if (len > s->max_size) {
+        len =3D s->max_size;
+    }
+    size =3D tcp_chr_recv(chr, (void *)buf, len);
+    if (size =3D=3D 0 || size =3D=3D -1) {
+        /* connection closed */
+        tcp_chr_disconnect(chr);
+    } else if (size > 0) {
+        if (s->do_telnetopt) {
+            tcp_chr_process_IAC_bytes(chr, s, buf, &size);
+        }
+        if (size > 0) {
+            qemu_chr_be_write(chr, buf, size);
+        }
+    }
+
+    return TRUE;
+}
+
+static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    int size;
+
+    if (!s->connected) {
+        return 0;
+    }
+
+    size =3D tcp_chr_recv(chr, (void *) buf, len);
+    if (size =3D=3D 0) {
+        /* connection closed */
+        tcp_chr_disconnect(chr);
+    }
+
+    return size;
+}
+
+static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_l=
en,
+                             struct sockaddr_storage *ps, socklen_t ps_l=
en,
+                             bool is_listen, bool is_telnet)
+{
+    char shost[NI_MAXHOST], sserv[NI_MAXSERV];
+    char phost[NI_MAXHOST], pserv[NI_MAXSERV];
+    const char *left =3D "", *right =3D "";
+
+    switch (ss->ss_family) {
+#ifndef _WIN32
+    case AF_UNIX:
+        return g_strdup_printf("unix:%s%s",
+                               ((struct sockaddr_un *)(ss))->sun_path,
+                               is_listen ? ",server" : "");
+#endif
+    case AF_INET6:
+        left  =3D "[";
+        right =3D "]";
+        /* fall through */
+    case AF_INET:
+        getnameinfo((struct sockaddr *) ss, ss_len, shost, sizeof(shost)=
,
+                    sserv, sizeof(sserv), NI_NUMERICHOST | NI_NUMERICSER=
V);
+        getnameinfo((struct sockaddr *) ps, ps_len, phost, sizeof(phost)=
,
+                    pserv, sizeof(pserv), NI_NUMERICHOST | NI_NUMERICSER=
V);
+        return g_strdup_printf("%s:%s%s%s:%s%s <-> %s%s%s:%s",
+                               is_telnet ? "telnet" : "tcp",
+                               left, shost, right, sserv,
+                               is_listen ? ",server" : "",
+                               left, phost, right, pserv);
+
+    default:
+        return g_strdup_printf("unknown");
+    }
+}
+
+static void tcp_chr_connect(void *opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
+
+    g_free(chr->filename);
+    chr->filename =3D sockaddr_to_str(
+        &s->sioc->localAddr, s->sioc->localAddrLen,
+        &s->sioc->remoteAddr, s->sioc->remoteAddrLen,
+        s->is_listen, s->is_telnet);
+
+    s->connected =3D 1;
+    if (s->ioc) {
+        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
+                                           tcp_chr_read_poll,
+                                           tcp_chr_read,
+                                           chr, NULL);
+    }
+    qemu_chr_be_generic_open(chr);
+}
+
+static void tcp_chr_update_read_handler(Chardev *chr,
+                                        GMainContext *context)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+
+    if (!s->connected) {
+        return;
+    }
+
+    remove_fd_in_watch(chr);
+    if (s->ioc) {
+        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
+                                           tcp_chr_read_poll,
+                                           tcp_chr_read, chr,
+                                           context);
+    }
+}
+
+typedef struct {
+    Chardev *chr;
+    char buf[12];
+    size_t buflen;
+} TCPChardevTelnetInit;
+
+static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
+                                       GIOCondition cond G_GNUC_UNUSED,
+                                       gpointer user_data)
+{
+    TCPChardevTelnetInit *init =3D user_data;
+    ssize_t ret;
+
+    ret =3D qio_channel_write(ioc, init->buf, init->buflen, NULL);
+    if (ret < 0) {
+        if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
+            ret =3D 0;
+        } else {
+            tcp_chr_disconnect(init->chr);
+            return FALSE;
+        }
+    }
+    init->buflen -=3D ret;
+
+    if (init->buflen =3D=3D 0) {
+        tcp_chr_connect(init->chr);
+        return FALSE;
+    }
+
+    memmove(init->buf, init->buf + ret, init->buflen);
+
+    return TRUE;
+}
+
+static void tcp_chr_telnet_init(Chardev *chr)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    TCPChardevTelnetInit *init =3D g_new0(TCPChardevTelnetInit, 1);
+    size_t n =3D 0;
+
+    init->chr =3D chr;
+    init->buflen =3D 12;
+
+#define IACSET(x, a, b, c)                      \
+    do {                                        \
+        x[n++] =3D a;                             \
+        x[n++] =3D b;                             \
+        x[n++] =3D c;                             \
+    } while (0)
+
+    /* Prep the telnet negotion to put telnet in binary,
+     * no echo, single char mode */
+    IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
+    IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ahead =
*/
+    IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL Binary */
+    IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
+
+#undef IACSET
+
+    qio_channel_add_watch(
+        s->ioc, G_IO_OUT,
+        tcp_chr_telnet_init_io,
+        init, NULL);
+}
+
+
+static void tcp_chr_tls_handshake(QIOTask *task,
+                                  gpointer user_data)
+{
+    Chardev *chr =3D user_data;
+    SocketChardev *s =3D user_data;
+
+    if (qio_task_propagate_error(task, NULL)) {
+        tcp_chr_disconnect(chr);
+    } else {
+        if (s->do_telnetopt) {
+            tcp_chr_telnet_init(chr);
+        } else {
+            tcp_chr_connect(chr);
+        }
+    }
+}
+
+
+static void tcp_chr_tls_init(Chardev *chr)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    QIOChannelTLS *tioc;
+    Error *err =3D NULL;
+    gchar *name;
+
+    if (s->is_listen) {
+        tioc =3D qio_channel_tls_new_server(
+            s->ioc, s->tls_creds,
+            NULL, /* XXX Use an ACL */
+            &err);
+    } else {
+        tioc =3D qio_channel_tls_new_client(
+            s->ioc, s->tls_creds,
+            s->addr->u.inet.data->host,
+            &err);
+    }
+    if (tioc =3D=3D NULL) {
+        error_free(err);
+        tcp_chr_disconnect(chr);
+        return;
+    }
+    name =3D g_strdup_printf("chardev-tls-%s-%s",
+                           s->is_listen ? "server" : "client",
+                           chr->label);
+    qio_channel_set_name(QIO_CHANNEL(tioc), name);
+    g_free(name);
+    object_unref(OBJECT(s->ioc));
+    s->ioc =3D QIO_CHANNEL(tioc);
+
+    qio_channel_tls_handshake(tioc,
+                              tcp_chr_tls_handshake,
+                              chr,
+                              NULL);
+}
+
+
+static void tcp_chr_set_client_ioc_name(Chardev *chr,
+                                        QIOChannelSocket *sioc)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    char *name;
+    name =3D g_strdup_printf("chardev-tcp-%s-%s",
+                           s->is_listen ? "server" : "client",
+                           chr->label);
+    qio_channel_set_name(QIO_CHANNEL(sioc), name);
+    g_free(name);
+
+}
+
+static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+
+    if (s->ioc !=3D NULL) {
+        return -1;
+    }
+
+    s->ioc =3D QIO_CHANNEL(sioc);
+    object_ref(OBJECT(sioc));
+    s->sioc =3D sioc;
+    object_ref(OBJECT(sioc));
+
+    qio_channel_set_blocking(s->ioc, false, NULL);
+
+    if (s->do_nodelay) {
+        qio_channel_set_delay(s->ioc, false);
+    }
+    if (s->listen_tag) {
+        g_source_remove(s->listen_tag);
+        s->listen_tag =3D 0;
+    }
+
+    if (s->tls_creds) {
+        tcp_chr_tls_init(chr);
+    } else {
+        if (s->do_telnetopt) {
+            tcp_chr_telnet_init(chr);
+        } else {
+            tcp_chr_connect(chr);
+        }
+    }
+
+    return 0;
+}
+
+
+static int tcp_chr_add_client(Chardev *chr, int fd)
+{
+    int ret;
+    QIOChannelSocket *sioc;
+
+    sioc =3D qio_channel_socket_new_fd(fd, NULL);
+    if (!sioc) {
+        return -1;
+    }
+    tcp_chr_set_client_ioc_name(chr, sioc);
+    ret =3D tcp_chr_new_client(chr, sioc);
+    object_unref(OBJECT(sioc));
+    return ret;
+}
+
+static gboolean tcp_chr_accept(QIOChannel *channel,
+                               GIOCondition cond,
+                               void *opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    QIOChannelSocket *sioc;
+
+    sioc =3D qio_channel_socket_accept(QIO_CHANNEL_SOCKET(channel),
+                                     NULL);
+    if (!sioc) {
+        return TRUE;
+    }
+
+    tcp_chr_new_client(chr, sioc);
+
+    object_unref(OBJECT(sioc));
+
+    return TRUE;
+}
+
+static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    QIOChannelSocket *sioc;
+
+    /* It can't wait on s->connected, since it is set asynchronously
+     * in TLS and telnet cases, only wait for an accepted socket */
+    while (!s->ioc) {
+        if (s->is_listen) {
+            error_report("QEMU waiting for connection on: %s",
+                         chr->filename);
+            qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, N=
ULL);
+            tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
+            qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), false, =
NULL);
+        } else {
+            sioc =3D qio_channel_socket_new();
+            tcp_chr_set_client_ioc_name(chr, sioc);
+            if (qio_channel_socket_connect_sync(sioc, s->addr, errp) < 0=
) {
+                object_unref(OBJECT(sioc));
+                return -1;
+            }
+            tcp_chr_new_client(chr, sioc);
+            object_unref(OBJECT(sioc));
+        }
+    }
+
+    return 0;
+}
+
+static void char_socket_finalize(Object *obj)
+{
+    Chardev *chr =3D CHARDEV(obj);
+    SocketChardev *s =3D SOCKET_CHARDEV(obj);
+
+    tcp_chr_free_connection(chr);
+
+    if (s->reconnect_timer) {
+        g_source_remove(s->reconnect_timer);
+        s->reconnect_timer =3D 0;
+    }
+    qapi_free_SocketAddress(s->addr);
+    if (s->listen_tag) {
+        g_source_remove(s->listen_tag);
+        s->listen_tag =3D 0;
+    }
+    if (s->listen_ioc) {
+        object_unref(OBJECT(s->listen_ioc));
+    }
+    if (s->tls_creds) {
+        object_unref(OBJECT(s->tls_creds));
+    }
+
+    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+}
+
+static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
+{
+    QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(qio_task_get_source(ta=
sk));
+    Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    Error *err =3D NULL;
+
+    if (qio_task_propagate_error(task, &err)) {
+        check_report_connect_error(chr, err);
+        error_free(err);
+        goto cleanup;
+    }
+
+    s->connect_err_reported =3D false;
+    tcp_chr_new_client(chr, sioc);
+
+cleanup:
+    object_unref(OBJECT(sioc));
+}
+
+static gboolean socket_reconnect_timeout(gpointer opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
+    QIOChannelSocket *sioc;
+
+    s->reconnect_timer =3D 0;
+
+    if (chr->be_open) {
+        return false;
+    }
+
+    sioc =3D qio_channel_socket_new();
+    tcp_chr_set_client_ioc_name(chr, sioc);
+    qio_channel_socket_connect_async(sioc, s->addr,
+                                     qemu_chr_socket_connected,
+                                     chr, NULL);
+
+    return false;
+}
+
+static void qmp_chardev_open_socket(Chardev *chr,
+                                    ChardevBackend *backend,
+                                    bool *be_opened,
+                                    Error **errp)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    ChardevSocket *sock =3D backend->u.socket.data;
+    SocketAddress *addr =3D sock->addr;
+    bool do_nodelay     =3D sock->has_nodelay ? sock->nodelay : false;
+    bool is_listen      =3D sock->has_server  ? sock->server  : true;
+    bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false;
+    bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
+    int64_t reconnect   =3D sock->has_reconnect ? sock->reconnect : 0;
+    QIOChannelSocket *sioc =3D NULL;
+
+    s->is_unix =3D addr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX;
+    s->is_listen =3D is_listen;
+    s->is_telnet =3D is_telnet;
+    s->do_nodelay =3D do_nodelay;
+    if (sock->tls_creds) {
+        Object *creds;
+        creds =3D object_resolve_path_component(
+            object_get_objects_root(), sock->tls_creds);
+        if (!creds) {
+            error_setg(errp, "No TLS credentials with id '%s'",
+                       sock->tls_creds);
+            goto error;
+        }
+        s->tls_creds =3D (QCryptoTLSCreds *)
+            object_dynamic_cast(creds,
+                                TYPE_QCRYPTO_TLS_CREDS);
+        if (!s->tls_creds) {
+            error_setg(errp, "Object with id '%s' is not TLS credentials=
",
+                       sock->tls_creds);
+            goto error;
+        }
+        object_ref(OBJECT(s->tls_creds));
+        if (is_listen) {
+            if (s->tls_creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_S=
ERVER) {
+                error_setg(errp, "%s",
+                           "Expected TLS credentials for server endpoint=
");
+                goto error;
+            }
+        } else {
+            if (s->tls_creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_C=
LIENT) {
+                error_setg(errp, "%s",
+                           "Expected TLS credentials for client endpoint=
");
+                goto error;
+            }
+        }
+    }
+
+    s->addr =3D QAPI_CLONE(SocketAddress, sock->addr);
+
+    qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
+    if (s->is_unix) {
+        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
+    }
+
+    /* be isn't opened until we get a connection */
+    *be_opened =3D false;
+
+    chr->filename =3D SocketAddress_to_str("disconnected:",
+                                         addr, is_listen, is_telnet);
+
+    if (is_listen) {
+        if (is_telnet) {
+            s->do_telnetopt =3D 1;
+        }
+    } else if (reconnect > 0) {
+        s->reconnect_time =3D reconnect;
+    }
+
+    if (s->reconnect_time) {
+        sioc =3D qio_channel_socket_new();
+        tcp_chr_set_client_ioc_name(chr, sioc);
+        qio_channel_socket_connect_async(sioc, s->addr,
+                                         qemu_chr_socket_connected,
+                                         chr, NULL);
+    } else {
+        if (s->is_listen) {
+            char *name;
+            sioc =3D qio_channel_socket_new();
+
+            name =3D g_strdup_printf("chardev-tcp-listener-%s", chr->lab=
el);
+            qio_channel_set_name(QIO_CHANNEL(sioc), name);
+            g_free(name);
+
+            if (qio_channel_socket_listen_sync(sioc, s->addr, errp) < 0)=
 {
+                goto error;
+            }
+            s->listen_ioc =3D sioc;
+            if (is_waitconnect &&
+                qemu_chr_wait_connected(chr, errp) < 0) {
+                return;
+            }
+            if (!s->ioc) {
+                s->listen_tag =3D qio_channel_add_watch(
+                    QIO_CHANNEL(s->listen_ioc), G_IO_IN,
+                    tcp_chr_accept, chr, NULL);
+            }
+        } else if (qemu_chr_wait_connected(chr, errp) < 0) {
+            goto error;
+        }
+    }
+
+    return;
+
+error:
+    if (sioc) {
+        object_unref(OBJECT(sioc));
+    }
+}
+
+static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
+                                  Error **errp)
+{
+    bool is_listen      =3D qemu_opt_get_bool(opts, "server", false);
+    bool is_waitconnect =3D is_listen && qemu_opt_get_bool(opts, "wait",=
 true);
+    bool is_telnet      =3D qemu_opt_get_bool(opts, "telnet", false);
+    bool do_nodelay     =3D !qemu_opt_get_bool(opts, "delay", true);
+    int64_t reconnect   =3D qemu_opt_get_number(opts, "reconnect", 0);
+    const char *path =3D qemu_opt_get(opts, "path");
+    const char *host =3D qemu_opt_get(opts, "host");
+    const char *port =3D qemu_opt_get(opts, "port");
+    const char *tls_creds =3D qemu_opt_get(opts, "tls-creds");
+    SocketAddress *addr;
+    ChardevSocket *sock;
+
+    backend->type =3D CHARDEV_BACKEND_KIND_SOCKET;
+    if (!path) {
+        if (!host) {
+            error_setg(errp, "chardev: socket: no host given");
+            return;
+        }
+        if (!port) {
+            error_setg(errp, "chardev: socket: no port given");
+            return;
+        }
+    } else {
+        if (tls_creds) {
+            error_setg(errp, "TLS can only be used over TCP socket");
+            return;
+        }
+    }
+
+    sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
+
+    sock->has_nodelay =3D true;
+    sock->nodelay =3D do_nodelay;
+    sock->has_server =3D true;
+    sock->server =3D is_listen;
+    sock->has_telnet =3D true;
+    sock->telnet =3D is_telnet;
+    sock->has_wait =3D true;
+    sock->wait =3D is_waitconnect;
+    sock->has_reconnect =3D true;
+    sock->reconnect =3D reconnect;
+    sock->tls_creds =3D g_strdup(tls_creds);
+
+    addr =3D g_new0(SocketAddress, 1);
+    if (path) {
+        UnixSocketAddress *q_unix;
+        addr->type =3D SOCKET_ADDRESS_KIND_UNIX;
+        q_unix =3D addr->u.q_unix.data =3D g_new0(UnixSocketAddress, 1);
+        q_unix->path =3D g_strdup(path);
+    } else {
+        addr->type =3D SOCKET_ADDRESS_KIND_INET;
+        addr->u.inet.data =3D g_new(InetSocketAddress, 1);
+        *addr->u.inet.data =3D (InetSocketAddress) {
+            .host =3D g_strdup(host),
+            .port =3D g_strdup(port),
+            .has_to =3D qemu_opt_get(opts, "to"),
+            .to =3D qemu_opt_get_number(opts, "to", 0),
+            .has_ipv4 =3D qemu_opt_get(opts, "ipv4"),
+            .ipv4 =3D qemu_opt_get_bool(opts, "ipv4", 0),
+            .has_ipv6 =3D qemu_opt_get(opts, "ipv6"),
+            .ipv6 =3D qemu_opt_get_bool(opts, "ipv6", 0),
+        };
+    }
+    sock->addr =3D addr;
+}
+
+static void char_socket_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_socket;
+    cc->open =3D qmp_chardev_open_socket;
+    cc->chr_wait_connected =3D tcp_chr_wait_connected;
+    cc->chr_write =3D tcp_chr_write;
+    cc->chr_sync_read =3D tcp_chr_sync_read;
+    cc->chr_disconnect =3D tcp_chr_disconnect;
+    cc->get_msgfds =3D tcp_get_msgfds;
+    cc->set_msgfds =3D tcp_set_msgfds;
+    cc->chr_add_client =3D tcp_chr_add_client;
+    cc->chr_add_watch =3D tcp_chr_add_watch;
+    cc->chr_update_read_handler =3D tcp_chr_update_read_handler;
+}
+
+static const TypeInfo char_socket_type_info =3D {
+    .name =3D TYPE_CHARDEV_SOCKET,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(SocketChardev),
+    .instance_finalize =3D char_socket_finalize,
+    .class_init =3D char_socket_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_socket_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index 8393bb0294..73b6663aa4 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -93,71 +93,6 @@
 #include "char-win-stdio.h"
 #endif
=20
-#define TCP_MAX_FDS 16
-
-/***********************************************************/
-/* Socket address helpers */
-
-static char *SocketAddress_to_str(const char *prefix, SocketAddress *add=
r,
-                                  bool is_listen, bool is_telnet)
-{
-    switch (addr->type) {
-    case SOCKET_ADDRESS_KIND_INET:
-        return g_strdup_printf("%s%s:%s:%s%s", prefix,
-                               is_telnet ? "telnet" : "tcp",
-                               addr->u.inet.data->host,
-                               addr->u.inet.data->port,
-                               is_listen ? ",server" : "");
-        break;
-    case SOCKET_ADDRESS_KIND_UNIX:
-        return g_strdup_printf("%sunix:%s%s", prefix,
-                               addr->u.q_unix.data->path,
-                               is_listen ? ",server" : "");
-        break;
-    case SOCKET_ADDRESS_KIND_FD:
-        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.data->str=
,
-                               is_listen ? ",server" : "");
-        break;
-    default:
-        abort();
-    }
-}
-
-static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_l=
en,
-                             struct sockaddr_storage *ps, socklen_t ps_l=
en,
-                             bool is_listen, bool is_telnet)
-{
-    char shost[NI_MAXHOST], sserv[NI_MAXSERV];
-    char phost[NI_MAXHOST], pserv[NI_MAXSERV];
-    const char *left =3D "", *right =3D "";
-
-    switch (ss->ss_family) {
-#ifndef _WIN32
-    case AF_UNIX:
-        return g_strdup_printf("unix:%s%s",
-                               ((struct sockaddr_un *)(ss))->sun_path,
-                               is_listen ? ",server" : "");
-#endif
-    case AF_INET6:
-        left  =3D "[";
-        right =3D "]";
-        /* fall through */
-    case AF_INET:
-        getnameinfo((struct sockaddr *) ss, ss_len, shost, sizeof(shost)=
,
-                    sserv, sizeof(sserv), NI_NUMERICHOST | NI_NUMERICSER=
V);
-        getnameinfo((struct sockaddr *) ps, ps_len, phost, sizeof(phost)=
,
-                    pserv, sizeof(pserv), NI_NUMERICHOST | NI_NUMERICSER=
V);
-        return g_strdup_printf("%s:%s%s%s:%s%s <-> %s%s%s:%s",
-                               is_telnet ? "telnet" : "tcp",
-                               left, shost, right, sserv,
-                               is_listen ? ",server" : "",
-                               left, phost, right, pserv);
-
-    default:
-        return g_strdup_printf("unknown");
-    }
-}
-
 /***********************************************************/
 /* character device */
=20
@@ -1672,640 +1607,7 @@ static void char_udp_finalize(Object *obj)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
-/***********************************************************/
-/* TCP Net console */
-
-typedef struct {
-    Chardev parent;
-    QIOChannel *ioc; /* Client I/O channel */
-    QIOChannelSocket *sioc; /* Client master channel */
-    QIOChannelSocket *listen_ioc;
-    guint listen_tag;
-    QCryptoTLSCreds *tls_creds;
-    int connected;
-    int max_size;
-    int do_telnetopt;
-    int do_nodelay;
-    int is_unix;
-    int *read_msgfds;
-    size_t read_msgfds_num;
-    int *write_msgfds;
-    size_t write_msgfds_num;
-
-    SocketAddress *addr;
-    bool is_listen;
-    bool is_telnet;
-
-    guint reconnect_timer;
-    int64_t reconnect_time;
-    bool connect_err_reported;
-} SocketChardev;
-
-#define SOCKET_CHARDEV(obj)                                     \
-    OBJECT_CHECK(SocketChardev, (obj), TYPE_CHARDEV_SOCKET)
-
-static gboolean socket_reconnect_timeout(gpointer opaque);
-
-static void qemu_chr_socket_restart_timer(Chardev *chr)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    char *name;
-
-    assert(s->connected =3D=3D 0);
-    s->reconnect_timer =3D g_timeout_add_seconds(s->reconnect_time,
-                                               socket_reconnect_timeout,=
 chr);
-    name =3D g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
-    g_source_set_name_by_id(s->reconnect_timer, name);
-    g_free(name);
-}
-
-static void check_report_connect_error(Chardev *chr,
-                                       Error *err)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-
-    if (!s->connect_err_reported) {
-        error_report("Unable to connect character device %s: %s",
-                     chr->label, error_get_pretty(err));
-        s->connect_err_reported =3D true;
-    }
-    qemu_chr_socket_restart_timer(chr);
-}
-
-static gboolean tcp_chr_accept(QIOChannel *chan,
-                               GIOCondition cond,
-                               void *opaque);
-
-/* Called with chr_write_lock held.  */
-static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-
-    if (s->connected) {
-        int ret =3D  io_channel_send_full(s->ioc, buf, len,
-                                        s->write_msgfds,
-                                        s->write_msgfds_num);
-
-        /* free the written msgfds, no matter what */
-        if (s->write_msgfds_num) {
-            g_free(s->write_msgfds);
-            s->write_msgfds =3D 0;
-            s->write_msgfds_num =3D 0;
-        }
-
-        return ret;
-    } else {
-        /* XXX: indicate an error ? */
-        return len;
-    }
-}
-
-static int tcp_chr_read_poll(void *opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
-    if (!s->connected)
-        return 0;
-    s->max_size =3D qemu_chr_be_can_write(chr);
-    return s->max_size;
-}
-
-#define IAC 255
-#define IAC_BREAK 243
-static void tcp_chr_process_IAC_bytes(Chardev *chr,
-                                      SocketChardev *s,
-                                      uint8_t *buf, int *size)
-{
-    /* Handle any telnet client's basic IAC options to satisfy char by
-     * char mode with no echo.  All IAC options will be removed from
-     * the buf and the do_telnetopt variable will be used to track the
-     * state of the width of the IAC information.
-     *
-     * IAC commands come in sets of 3 bytes with the exception of the
-     * "IAC BREAK" command and the double IAC.
-     */
-
-    int i;
-    int j =3D 0;
-
-    for (i =3D 0; i < *size; i++) {
-        if (s->do_telnetopt > 1) {
-            if ((unsigned char)buf[i] =3D=3D IAC && s->do_telnetopt =3D=3D=
 2) {
-                /* Double IAC means send an IAC */
-                if (j !=3D i)
-                    buf[j] =3D buf[i];
-                j++;
-                s->do_telnetopt =3D 1;
-            } else {
-                if ((unsigned char)buf[i] =3D=3D IAC_BREAK && s->do_teln=
etopt =3D=3D 2) {
-                    /* Handle IAC break commands by sending a serial bre=
ak */
-                    qemu_chr_be_event(chr, CHR_EVENT_BREAK);
-                    s->do_telnetopt++;
-                }
-                s->do_telnetopt++;
-            }
-            if (s->do_telnetopt >=3D 4) {
-                s->do_telnetopt =3D 1;
-            }
-        } else {
-            if ((unsigned char)buf[i] =3D=3D IAC) {
-                s->do_telnetopt =3D 2;
-            } else {
-                if (j !=3D i)
-                    buf[j] =3D buf[i];
-                j++;
-            }
-        }
-    }
-    *size =3D j;
-}
-
-static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-
-    int to_copy =3D (s->read_msgfds_num < num) ? s->read_msgfds_num : nu=
m;
-
-    assert(num <=3D TCP_MAX_FDS);
-
-    if (to_copy) {
-        int i;
-
-        memcpy(fds, s->read_msgfds, to_copy * sizeof(int));
-
-        /* Close unused fds */
-        for (i =3D to_copy; i < s->read_msgfds_num; i++) {
-            close(s->read_msgfds[i]);
-        }
-
-        g_free(s->read_msgfds);
-        s->read_msgfds =3D 0;
-        s->read_msgfds_num =3D 0;
-    }
-
-    return to_copy;
-}
-
-static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-
-    /* clear old pending fd array */
-    g_free(s->write_msgfds);
-    s->write_msgfds =3D NULL;
-    s->write_msgfds_num =3D 0;
-
-    if (!s->connected ||
-        !qio_channel_has_feature(s->ioc,
-                                 QIO_CHANNEL_FEATURE_FD_PASS)) {
-        return -1;
-    }
-
-    if (num) {
-        s->write_msgfds =3D g_new(int, num);
-        memcpy(s->write_msgfds, fds, num * sizeof(int));
-    }
-
-    s->write_msgfds_num =3D num;
-
-    return 0;
-}
-
-static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D len };
-    int ret;
-    size_t i;
-    int *msgfds =3D NULL;
-    size_t msgfds_num =3D 0;
-
-    if (qio_channel_has_feature(s->ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
-        ret =3D qio_channel_readv_full(s->ioc, &iov, 1,
-                                     &msgfds, &msgfds_num,
-                                     NULL);
-    } else {
-        ret =3D qio_channel_readv_full(s->ioc, &iov, 1,
-                                     NULL, NULL,
-                                     NULL);
-    }
-
-    if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
-        errno =3D EAGAIN;
-        ret =3D -1;
-    } else if (ret =3D=3D -1) {
-        errno =3D EIO;
-    }
-
-    if (msgfds_num) {
-        /* close and clean read_msgfds */
-        for (i =3D 0; i < s->read_msgfds_num; i++) {
-            close(s->read_msgfds[i]);
-        }
-
-        if (s->read_msgfds_num) {
-            g_free(s->read_msgfds);
-        }
-
-        s->read_msgfds =3D msgfds;
-        s->read_msgfds_num =3D msgfds_num;
-    }
-
-    for (i =3D 0; i < s->read_msgfds_num; i++) {
-        int fd =3D s->read_msgfds[i];
-        if (fd < 0) {
-            continue;
-        }
-
-        /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-        qemu_set_block(fd);
-
-#ifndef MSG_CMSG_CLOEXEC
-        qemu_set_cloexec(fd);
-#endif
-    }
-
-    return ret;
-}
-
-static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    return qio_channel_create_watch(s->ioc, cond);
-}
-
-static void tcp_chr_free_connection(Chardev *chr)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    int i;
-
-    if (!s->connected) {
-        return;
-    }
-
-    if (s->read_msgfds_num) {
-        for (i =3D 0; i < s->read_msgfds_num; i++) {
-            close(s->read_msgfds[i]);
-        }
-        g_free(s->read_msgfds);
-        s->read_msgfds =3D NULL;
-        s->read_msgfds_num =3D 0;
-    }
-
-    tcp_set_msgfds(chr, NULL, 0);
-    remove_fd_in_watch(chr);
-    object_unref(OBJECT(s->sioc));
-    s->sioc =3D NULL;
-    object_unref(OBJECT(s->ioc));
-    s->ioc =3D NULL;
-    g_free(chr->filename);
-    chr->filename =3D NULL;
-    s->connected =3D 0;
-}
-
-static void tcp_chr_disconnect(Chardev *chr)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-
-    if (!s->connected) {
-        return;
-    }
-
-    tcp_chr_free_connection(chr);
-
-    if (s->listen_ioc) {
-        s->listen_tag =3D qio_channel_add_watch(
-            QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, NU=
LL);
-    }
-    chr->filename =3D SocketAddress_to_str("disconnected:", s->addr,
-                                         s->is_listen, s->is_telnet);
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
-    if (s->reconnect_time) {
-        qemu_chr_socket_restart_timer(chr);
-    }
-}
-
-static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
-    uint8_t buf[CHR_READ_BUF_LEN];
-    int len, size;
-
-    if (!s->connected || s->max_size <=3D 0) {
-        return TRUE;
-    }
-    len =3D sizeof(buf);
-    if (len > s->max_size)
-        len =3D s->max_size;
-    size =3D tcp_chr_recv(chr, (void *)buf, len);
-    if (size =3D=3D 0 || size =3D=3D -1) {
-        /* connection closed */
-        tcp_chr_disconnect(chr);
-    } else if (size > 0) {
-        if (s->do_telnetopt)
-            tcp_chr_process_IAC_bytes(chr, s, buf, &size);
-        if (size > 0)
-            qemu_chr_be_write(chr, buf, size);
-    }
-
-    return TRUE;
-}
-
-static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    int size;
-
-    if (!s->connected) {
-        return 0;
-    }
-
-    size =3D tcp_chr_recv(chr, (void *) buf, len);
-    if (size =3D=3D 0) {
-        /* connection closed */
-        tcp_chr_disconnect(chr);
-    }
-
-    return size;
-}
-
-static void tcp_chr_connect(void *opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
-
-    g_free(chr->filename);
-    chr->filename =3D sockaddr_to_str(
-        &s->sioc->localAddr, s->sioc->localAddrLen,
-        &s->sioc->remoteAddr, s->sioc->remoteAddrLen,
-        s->is_listen, s->is_telnet);
-
-    s->connected =3D 1;
-    if (s->ioc) {
-        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
-                                           tcp_chr_read_poll,
-                                           tcp_chr_read,
-                                           chr, NULL);
-    }
-    qemu_chr_be_generic_open(chr);
-}
-
-static void tcp_chr_update_read_handler(Chardev *chr,
-                                        GMainContext *context)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-
-    if (!s->connected) {
-        return;
-    }
-
-    remove_fd_in_watch(chr);
-    if (s->ioc) {
-        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
-                                           tcp_chr_read_poll,
-                                           tcp_chr_read, chr,
-                                           context);
-    }
-}
-
-typedef struct {
-    Chardev *chr;
-    char buf[12];
-    size_t buflen;
-} TCPChardevTelnetInit;
-
-static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
-                                       GIOCondition cond G_GNUC_UNUSED,
-                                       gpointer user_data)
-{
-    TCPChardevTelnetInit *init =3D user_data;
-    ssize_t ret;
-
-    ret =3D qio_channel_write(ioc, init->buf, init->buflen, NULL);
-    if (ret < 0) {
-        if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
-            ret =3D 0;
-        } else {
-            tcp_chr_disconnect(init->chr);
-            return FALSE;
-        }
-    }
-    init->buflen -=3D ret;
-
-    if (init->buflen =3D=3D 0) {
-        tcp_chr_connect(init->chr);
-        return FALSE;
-    }
-
-    memmove(init->buf, init->buf + ret, init->buflen);
-
-    return TRUE;
-}
-
-static void tcp_chr_telnet_init(Chardev *chr)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    TCPChardevTelnetInit *init =3D g_new0(TCPChardevTelnetInit, 1);
-    size_t n =3D 0;
-
-    init->chr =3D chr;
-    init->buflen =3D 12;
-
-#define IACSET(x, a, b, c)                      \
-    do {                                        \
-        x[n++] =3D a;                             \
-        x[n++] =3D b;                             \
-        x[n++] =3D c;                             \
-    } while (0)
-
-    /* Prep the telnet negotion to put telnet in binary,
-     * no echo, single char mode */
-    IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
-    IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ahead =
*/
-    IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL Binary */
-    IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
-
-#undef IACSET
-
-    qio_channel_add_watch(
-        s->ioc, G_IO_OUT,
-        tcp_chr_telnet_init_io,
-        init, NULL);
-}
-
-
-static void tcp_chr_tls_handshake(QIOTask *task,
-                                  gpointer user_data)
-{
-    Chardev *chr =3D user_data;
-    SocketChardev *s =3D user_data;
-
-    if (qio_task_propagate_error(task, NULL)) {
-        tcp_chr_disconnect(chr);
-    } else {
-        if (s->do_telnetopt) {
-            tcp_chr_telnet_init(chr);
-        } else {
-            tcp_chr_connect(chr);
-        }
-    }
-}
-
-
-static void tcp_chr_tls_init(Chardev *chr)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    QIOChannelTLS *tioc;
-    Error *err =3D NULL;
-    gchar *name;
-
-    if (s->is_listen) {
-        tioc =3D qio_channel_tls_new_server(
-            s->ioc, s->tls_creds,
-            NULL, /* XXX Use an ACL */
-            &err);
-    } else {
-        tioc =3D qio_channel_tls_new_client(
-            s->ioc, s->tls_creds,
-            s->addr->u.inet.data->host,
-            &err);
-    }
-    if (tioc =3D=3D NULL) {
-        error_free(err);
-        tcp_chr_disconnect(chr);
-        return;
-    }
-    name =3D g_strdup_printf("chardev-tls-%s-%s",
-                           s->is_listen ? "server" : "client",
-                           chr->label);
-    qio_channel_set_name(QIO_CHANNEL(tioc), name);
-    g_free(name);
-    object_unref(OBJECT(s->ioc));
-    s->ioc =3D QIO_CHANNEL(tioc);
-
-    qio_channel_tls_handshake(tioc,
-                              tcp_chr_tls_handshake,
-                              chr,
-                              NULL);
-}
-
-
-static void tcp_chr_set_client_ioc_name(Chardev *chr,
-                                        QIOChannelSocket *sioc)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    char *name;
-    name =3D g_strdup_printf("chardev-tcp-%s-%s",
-                           s->is_listen ? "server" : "client",
-                           chr->label);
-    qio_channel_set_name(QIO_CHANNEL(sioc), name);
-    g_free(name);
-
-}
-
-static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-
-    if (s->ioc !=3D NULL) {
-	return -1;
-    }
-
-    s->ioc =3D QIO_CHANNEL(sioc);
-    object_ref(OBJECT(sioc));
-    s->sioc =3D sioc;
-    object_ref(OBJECT(sioc));
-
-    qio_channel_set_blocking(s->ioc, false, NULL);
-
-    if (s->do_nodelay) {
-        qio_channel_set_delay(s->ioc, false);
-    }
-    if (s->listen_tag) {
-        g_source_remove(s->listen_tag);
-        s->listen_tag =3D 0;
-    }
-
-    if (s->tls_creds) {
-        tcp_chr_tls_init(chr);
-    } else {
-        if (s->do_telnetopt) {
-            tcp_chr_telnet_init(chr);
-        } else {
-            tcp_chr_connect(chr);
-        }
-    }
-
-    return 0;
-}
-
-
-static int tcp_chr_add_client(Chardev *chr, int fd)
-{
-    int ret;
-    QIOChannelSocket *sioc;
-
-    sioc =3D qio_channel_socket_new_fd(fd, NULL);
-    if (!sioc) {
-        return -1;
-    }
-    tcp_chr_set_client_ioc_name(chr, sioc);
-    ret =3D tcp_chr_new_client(chr, sioc);
-    object_unref(OBJECT(sioc));
-    return ret;
-}
-
-static gboolean tcp_chr_accept(QIOChannel *channel,
-                               GIOCondition cond,
-                               void *opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    QIOChannelSocket *sioc;
-
-    sioc =3D qio_channel_socket_accept(QIO_CHANNEL_SOCKET(channel),
-                                     NULL);
-    if (!sioc) {
-        return TRUE;
-    }
-
-    tcp_chr_new_client(chr, sioc);
-
-    object_unref(OBJECT(sioc));
-
-    return TRUE;
-}
-
-static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    QIOChannelSocket *sioc;
-
-    /* It can't wait on s->connected, since it is set asynchronously
-     * in TLS and telnet cases, only wait for an accepted socket */
-    while (!s->ioc) {
-        if (s->is_listen) {
-            error_report("QEMU waiting for connection on: %s",
-                         chr->filename);
-            qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, N=
ULL);
-            tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
-            qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), false, =
NULL);
-        } else {
-            sioc =3D qio_channel_socket_new();
-            tcp_chr_set_client_ioc_name(chr, sioc);
-            if (qio_channel_socket_connect_sync(sioc, s->addr, errp) < 0=
) {
-                object_unref(OBJECT(sioc));
-                return -1;
-            }
-            tcp_chr_new_client(chr, sioc);
-            object_unref(OBJECT(sioc));
-        }
-    }
-
-    return 0;
-}
-
-static int qemu_chr_wait_connected(Chardev *chr, Error **errp)
+int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
     ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
=20
@@ -2326,54 +1628,6 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Er=
ror **errp)
     return qemu_chr_wait_connected(be->chr, errp);
 }
=20
-static void char_socket_finalize(Object *obj)
-{
-    Chardev *chr =3D CHARDEV(obj);
-    SocketChardev *s =3D SOCKET_CHARDEV(obj);
-
-    tcp_chr_free_connection(chr);
-
-    if (s->reconnect_timer) {
-        g_source_remove(s->reconnect_timer);
-        s->reconnect_timer =3D 0;
-    }
-    qapi_free_SocketAddress(s->addr);
-    if (s->listen_tag) {
-        g_source_remove(s->listen_tag);
-        s->listen_tag =3D 0;
-    }
-    if (s->listen_ioc) {
-        object_unref(OBJECT(s->listen_ioc));
-    }
-    if (s->tls_creds) {
-        object_unref(OBJECT(s->tls_creds));
-    }
-
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
-}
-
-
-static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
-{
-    QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(qio_task_get_source(ta=
sk));
-    Chardev *chr =3D CHARDEV(opaque);
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    Error *err =3D NULL;
-
-    if (qio_task_propagate_error(task, &err)) {
-        check_report_connect_error(chr, err);
-        error_free(err);
-        goto cleanup;
-    }
-
-    s->connect_err_reported =3D false;
-    tcp_chr_new_client(chr, sioc);
-
- cleanup:
-    object_unref(OBJECT(sioc));
-}
-
-
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
 {
     char host[65], port[33], width[8], height[8];
@@ -2651,76 +1905,6 @@ static const TypeInfo char_pipe_type_info =3D {
     .class_init =3D char_pipe_class_init,
 };
=20
-static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
-                                  Error **errp)
-{
-    bool is_listen      =3D qemu_opt_get_bool(opts, "server", false);
-    bool is_waitconnect =3D is_listen && qemu_opt_get_bool(opts, "wait",=
 true);
-    bool is_telnet      =3D qemu_opt_get_bool(opts, "telnet", false);
-    bool do_nodelay     =3D !qemu_opt_get_bool(opts, "delay", true);
-    int64_t reconnect   =3D qemu_opt_get_number(opts, "reconnect", 0);
-    const char *path =3D qemu_opt_get(opts, "path");
-    const char *host =3D qemu_opt_get(opts, "host");
-    const char *port =3D qemu_opt_get(opts, "port");
-    const char *tls_creds =3D qemu_opt_get(opts, "tls-creds");
-    SocketAddress *addr;
-    ChardevSocket *sock;
-
-    backend->type =3D CHARDEV_BACKEND_KIND_SOCKET;
-    if (!path) {
-        if (!host) {
-            error_setg(errp, "chardev: socket: no host given");
-            return;
-        }
-        if (!port) {
-            error_setg(errp, "chardev: socket: no port given");
-            return;
-        }
-    } else {
-        if (tls_creds) {
-            error_setg(errp, "TLS can only be used over TCP socket");
-            return;
-        }
-    }
-
-    sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
-
-    sock->has_nodelay =3D true;
-    sock->nodelay =3D do_nodelay;
-    sock->has_server =3D true;
-    sock->server =3D is_listen;
-    sock->has_telnet =3D true;
-    sock->telnet =3D is_telnet;
-    sock->has_wait =3D true;
-    sock->wait =3D is_waitconnect;
-    sock->has_reconnect =3D true;
-    sock->reconnect =3D reconnect;
-    sock->tls_creds =3D g_strdup(tls_creds);
-
-    addr =3D g_new0(SocketAddress, 1);
-    if (path) {
-        UnixSocketAddress *q_unix;
-        addr->type =3D SOCKET_ADDRESS_KIND_UNIX;
-        q_unix =3D addr->u.q_unix.data =3D g_new0(UnixSocketAddress, 1);
-        q_unix->path =3D g_strdup(path);
-    } else {
-        addr->type =3D SOCKET_ADDRESS_KIND_INET;
-        addr->u.inet.data =3D g_new(InetSocketAddress, 1);
-        *addr->u.inet.data =3D (InetSocketAddress) {
-            .host =3D g_strdup(host),
-            .port =3D g_strdup(port),
-            .has_to =3D qemu_opt_get(opts, "to"),
-            .to =3D qemu_opt_get_number(opts, "to", 0),
-            .has_ipv4 =3D qemu_opt_get(opts, "ipv4"),
-            .ipv4 =3D qemu_opt_get_bool(opts, "ipv4", 0),
-            .has_ipv6 =3D qemu_opt_get(opts, "ipv6"),
-            .ipv6 =3D qemu_opt_get_bool(opts, "ipv6", 0),
-        };
-    }
-    sock->addr =3D addr;
-}
-
 static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
                                Error **errp)
 {
@@ -3426,166 +2610,6 @@ static const TypeInfo char_serial_type_info =3D {
 };
 #endif
=20
-static gboolean socket_reconnect_timeout(gpointer opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
-    QIOChannelSocket *sioc;
-
-    s->reconnect_timer =3D 0;
-
-    if (chr->be_open) {
-        return false;
-    }
-
-    sioc =3D qio_channel_socket_new();
-    tcp_chr_set_client_ioc_name(chr, sioc);
-    qio_channel_socket_connect_async(sioc, s->addr,
-                                     qemu_chr_socket_connected,
-                                     chr, NULL);
-
-    return false;
-}
-
-static void qmp_chardev_open_socket(Chardev *chr,
-                                    ChardevBackend *backend,
-                                    bool *be_opened,
-                                    Error **errp)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    ChardevSocket *sock =3D backend->u.socket.data;
-    SocketAddress *addr =3D sock->addr;
-    bool do_nodelay     =3D sock->has_nodelay ? sock->nodelay : false;
-    bool is_listen      =3D sock->has_server  ? sock->server  : true;
-    bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false;
-    bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
-    int64_t reconnect   =3D sock->has_reconnect ? sock->reconnect : 0;
-    QIOChannelSocket *sioc =3D NULL;
-
-    s->is_unix =3D addr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX;
-    s->is_listen =3D is_listen;
-    s->is_telnet =3D is_telnet;
-    s->do_nodelay =3D do_nodelay;
-    if (sock->tls_creds) {
-        Object *creds;
-        creds =3D object_resolve_path_component(
-            object_get_objects_root(), sock->tls_creds);
-        if (!creds) {
-            error_setg(errp, "No TLS credentials with id '%s'",
-                       sock->tls_creds);
-            goto error;
-        }
-        s->tls_creds =3D (QCryptoTLSCreds *)
-            object_dynamic_cast(creds,
-                                TYPE_QCRYPTO_TLS_CREDS);
-        if (!s->tls_creds) {
-            error_setg(errp, "Object with id '%s' is not TLS credentials=
",
-                       sock->tls_creds);
-            goto error;
-        }
-        object_ref(OBJECT(s->tls_creds));
-        if (is_listen) {
-            if (s->tls_creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_S=
ERVER) {
-                error_setg(errp, "%s",
-                           "Expected TLS credentials for server endpoint=
");
-                goto error;
-            }
-        } else {
-            if (s->tls_creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_C=
LIENT) {
-                error_setg(errp, "%s",
-                           "Expected TLS credentials for client endpoint=
");
-                goto error;
-            }
-        }
-    }
-
-    s->addr =3D QAPI_CLONE(SocketAddress, sock->addr);
-
-    qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
-    if (s->is_unix) {
-        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
-    }
-
-    /* be isn't opened until we get a connection */
-    *be_opened =3D false;
-
-    chr->filename =3D SocketAddress_to_str("disconnected:",
-                                         addr, is_listen, is_telnet);
-
-    if (is_listen) {
-        if (is_telnet) {
-            s->do_telnetopt =3D 1;
-        }
-    } else if (reconnect > 0) {
-        s->reconnect_time =3D reconnect;
-    }
-
-    if (s->reconnect_time) {
-        sioc =3D qio_channel_socket_new();
-        tcp_chr_set_client_ioc_name(chr, sioc);
-        qio_channel_socket_connect_async(sioc, s->addr,
-                                         qemu_chr_socket_connected,
-                                         chr, NULL);
-    } else {
-        if (s->is_listen) {
-            char *name;
-            sioc =3D qio_channel_socket_new();
-
-            name =3D g_strdup_printf("chardev-tcp-listener-%s", chr->lab=
el);
-            qio_channel_set_name(QIO_CHANNEL(sioc), name);
-            g_free(name);
-
-            if (qio_channel_socket_listen_sync(sioc, s->addr, errp) < 0)=
 {
-                goto error;
-            }
-            s->listen_ioc =3D sioc;
-            if (is_waitconnect &&
-                qemu_chr_wait_connected(chr, errp) < 0) {
-                return;
-            }
-            if (!s->ioc) {
-                s->listen_tag =3D qio_channel_add_watch(
-                    QIO_CHANNEL(s->listen_ioc), G_IO_IN,
-                    tcp_chr_accept, chr, NULL);
-            }
-        } else if (qemu_chr_wait_connected(chr, errp) < 0) {
-            goto error;
-        }
-    }
-
-    return;
-
-error:
-    if (sioc) {
-        object_unref(OBJECT(sioc));
-    }
-}
-
-static void char_socket_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->parse =3D qemu_chr_parse_socket;
-    cc->open =3D qmp_chardev_open_socket;
-    cc->chr_wait_connected =3D tcp_chr_wait_connected;
-    cc->chr_write =3D tcp_chr_write;
-    cc->chr_sync_read =3D tcp_chr_sync_read;
-    cc->chr_disconnect =3D tcp_chr_disconnect;
-    cc->get_msgfds =3D tcp_get_msgfds;
-    cc->set_msgfds =3D tcp_set_msgfds;
-    cc->chr_add_client =3D tcp_chr_add_client;
-    cc->chr_add_watch =3D tcp_chr_add_watch;
-    cc->chr_update_read_handler =3D tcp_chr_update_read_handler;
-}
-
-static const TypeInfo char_socket_type_info =3D {
-    .name =3D TYPE_CHARDEV_SOCKET,
-    .parent =3D TYPE_CHARDEV,
-    .instance_size =3D sizeof(SocketChardev),
-    .instance_finalize =3D char_socket_finalize,
-    .class_init =3D char_socket_class_init,
-};
-
 static void qmp_chardev_open_udp(Chardev *chr,
                                  ChardevBackend *backend,
                                  bool *be_opened,
@@ -3731,7 +2755,6 @@ void qemu_chr_cleanup(void)
 static void register_types(void)
 {
     type_register_static(&char_type_info);
-    type_register_static(&char_socket_type_info);
     type_register_static(&char_udp_type_info);
     type_register_static(&char_file_type_info);
     type_register_static(&char_stdio_type_info);
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 3c4a328de8..c57c375d5b 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -4,5 +4,6 @@ chardev-obj-y +=3D char-io.o
 chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
 chardev-obj-y +=3D char-ringbuf.o
+chardev-obj-y +=3D char-socket.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
--=20
2.11.0.295.gd7dffce1c.dirty
