Received: from eggs.gnu.org ([209.51.188.92]:42187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKl-0003EJ-Ci
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKj-00031b-9y
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:29:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMKi-000314-Ur
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:29:01 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:39 +0000
Message-Id: <20190123172740.32452-16-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/16] tests: expand coverage of socket
 chardev test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yongji Xie <elohimes@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The current socket chardev tests try to exercise the chardev socket
driver in both server and client mode at the same time. The chardev API
is not very well designed to handle both ends of the connection being in
the same process so this approach makes the test case quite unpleasant
to deal with.

This splits the tests into distinct cases, one to test server socket
chardevs and one to test client socket chardevs. In each case the peer
is run in a background thread using the simpler QIOChannelSocket APIs.
The main test case code can now be written in a way that mirrors the
typical usage from within QEMU.

In doing this recfactoring it is possible to greatly expand the test
coverage for the socket chardevs to test all combinations except for a
server operating in blocking wait mode.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-char.c | 640 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 475 insertions(+), 165 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index a93908f044..88534b2f75 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -11,6 +11,9 @@
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qmp/qdict.h"
 #include "qom/qom-qobject.h"
+#include "io/channel-socket.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-sockets.h"
=20
 static bool quit;
=20
@@ -257,168 +260,6 @@ static void char_mux_test(void)
     qemu_chr_fe_deinit(&chr_be2, true);
 }
=20
-typedef struct SocketIdleData {
-    GMainLoop *loop;
-    Chardev *chr;
-    bool conn_expected;
-    CharBackend *be;
-    CharBackend *client_be;
-} SocketIdleData;
-
-static gboolean char_socket_test_idle(gpointer user_data)
-{
-    SocketIdleData *data =3D user_data;
-
-    if (object_property_get_bool(OBJECT(data->chr), "connected", NULL)
-        =3D=3D data->conn_expected) {
-        quit =3D true;
-        return FALSE;
-    }
-
-    return TRUE;
-}
-
-static void socket_read(void *opaque, const uint8_t *buf, int size)
-{
-    SocketIdleData *data =3D opaque;
-
-    g_assert_cmpint(size, =3D=3D, 1);
-    g_assert_cmpint(*buf, =3D=3D, 'Z');
-
-    size =3D qemu_chr_fe_write(data->be, (const uint8_t *)"hello", 5);
-    g_assert_cmpint(size, =3D=3D, 5);
-}
-
-static int socket_can_read(void *opaque)
-{
-    return 10;
-}
-
-static void socket_read_hello(void *opaque, const uint8_t *buf, int size=
)
-{
-    g_assert_cmpint(size, =3D=3D, 5);
-    g_assert(strncmp((char *)buf, "hello", 5) =3D=3D 0);
-
-    quit =3D true;
-}
-
-static int socket_can_read_hello(void *opaque)
-{
-    return 10;
-}
-
-static void char_socket_test_common(Chardev *chr, bool reconnect)
-{
-    Chardev *chr_client;
-    QObject *addr;
-    QDict *qdict;
-    const char *port;
-    SocketIdleData d =3D { .chr =3D chr };
-    CharBackend be;
-    CharBackend client_be;
-    char *tmp;
-
-    d.be =3D &be;
-    d.client_be =3D &be;
-
-    g_assert_nonnull(chr);
-    g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_=
abort));
-
-    addr =3D object_property_get_qobject(OBJECT(chr), "addr", &error_abo=
rt);
-    qdict =3D qobject_to(QDict, addr);
-    port =3D qdict_get_str(qdict, "port");
-    tmp =3D g_strdup_printf("tcp:127.0.0.1:%s%s", port,
-                          reconnect ? ",reconnect=3D1" : "");
-    qobject_unref(qdict);
-
-    qemu_chr_fe_init(&be, chr, &error_abort);
-    qemu_chr_fe_set_handlers(&be, socket_can_read, socket_read,
-                             NULL, NULL, &d, NULL, true);
-
-    chr_client =3D qemu_chr_new("client", tmp);
-    qemu_chr_fe_init(&client_be, chr_client, &error_abort);
-    qemu_chr_fe_set_handlers(&client_be, socket_can_read_hello,
-                             socket_read_hello,
-                             NULL, NULL, &d, NULL, true);
-    g_free(tmp);
-
-    d.conn_expected =3D true;
-    guint id =3D g_idle_add(char_socket_test_idle, &d);
-    g_source_set_name_by_id(id, "test-idle");
-    g_assert_cmpint(id, >, 0);
-    main_loop();
-
-    d.chr =3D chr_client;
-    id =3D g_idle_add(char_socket_test_idle, &d);
-    g_source_set_name_by_id(id, "test-idle");
-    g_assert_cmpint(id, >, 0);
-    main_loop();
-
-    g_assert(object_property_get_bool(OBJECT(chr), "connected", &error_a=
bort));
-    g_assert(object_property_get_bool(OBJECT(chr_client),
-                                      "connected", &error_abort));
-
-    qemu_chr_write_all(chr_client, (const uint8_t *)"Z", 1);
-    main_loop();
-
-    object_unparent(OBJECT(chr_client));
-
-    d.chr =3D chr;
-    d.conn_expected =3D false;
-    g_idle_add(char_socket_test_idle, &d);
-    main_loop();
-
-    object_unparent(OBJECT(chr));
-}
-
-
-static void char_socket_basic_test(void)
-{
-    Chardev *chr =3D qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowa=
it");
-
-    char_socket_test_common(chr, false);
-}
-
-
-static void char_socket_reconnect_test(void)
-{
-    Chardev *chr =3D qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowa=
it");
-
-    char_socket_test_common(chr, true);
-}
-
-
-static void char_socket_fdpass_test(void)
-{
-    Chardev *chr;
-    char *optstr;
-    QemuOpts *opts;
-    int fd;
-    SocketAddress *addr =3D g_new0(SocketAddress, 1);
-
-    addr->type =3D SOCKET_ADDRESS_TYPE_INET;
-    addr->u.inet.host =3D g_strdup("127.0.0.1");
-    addr->u.inet.port =3D g_strdup("0");
-
-    fd =3D socket_listen(addr, &error_abort);
-    g_assert(fd >=3D 0);
-
-    qapi_free_SocketAddress(addr);
-
-    optstr =3D g_strdup_printf("socket,id=3Dcdev,fd=3D%d,server,nowait",=
 fd);
-
-    opts =3D qemu_opts_parse_noisily(qemu_find_opts("chardev"),
-                                   optstr, true);
-    g_free(optstr);
-    g_assert_nonnull(opts);
-
-    chr =3D qemu_chr_new_from_opts(opts, &error_abort);
-
-    qemu_opts_del(opts);
-
-    char_socket_test_common(chr, false);
-}
-
=20
 static void websock_server_read(void *opaque, const uint8_t *buf, int si=
ze)
 {
@@ -610,6 +451,28 @@ static void char_pipe_test(void)
 }
 #endif
=20
+typedef struct SocketIdleData {
+    GMainLoop *loop;
+    Chardev *chr;
+    bool conn_expected;
+    CharBackend *be;
+    CharBackend *client_be;
+} SocketIdleData;
+
+
+static void socket_read_hello(void *opaque, const uint8_t *buf, int size=
)
+{
+    g_assert_cmpint(size, =3D=3D, 5);
+    g_assert(strncmp((char *)buf, "hello", 5) =3D=3D 0);
+
+    quit =3D true;
+}
+
+static int socket_can_read_hello(void *opaque)
+{
+    return 10;
+}
+
 static int make_udp_socket(int *port)
 {
     struct sockaddr_in addr =3D { 0, };
@@ -680,6 +543,391 @@ static void char_udp_test(void)
     char_udp_test_internal(NULL, 0);
 }
=20
+
+typedef struct {
+    int event;
+    bool got_pong;
+} CharSocketTestData;
+
+
+#define SOCKET_PING "Hello"
+#define SOCKET_PONG "World"
+
+
+static void
+char_socket_event(void *opaque, int event)
+{
+    CharSocketTestData *data =3D opaque;
+    data->event =3D event;
+}
+
+
+static void
+char_socket_read(void *opaque, const uint8_t *buf, int size)
+{
+    CharSocketTestData *data =3D opaque;
+    g_assert_cmpint(size, =3D=3D, sizeof(SOCKET_PONG));
+    g_assert(memcmp(buf, SOCKET_PONG, size) =3D=3D 0);
+    data->got_pong =3D true;
+}
+
+
+static int
+char_socket_can_read(void *opaque)
+{
+    return sizeof(SOCKET_PONG);
+}
+
+
+static char *
+char_socket_addr_to_opt_str(SocketAddress *addr, bool fd_pass,
+                            const char *reconnect, bool is_listen)
+{
+    if (fd_pass) {
+        QIOChannelSocket *ioc =3D qio_channel_socket_new();
+        int fd;
+        char *optstr;
+        g_assert(!reconnect);
+        if (is_listen) {
+            qio_channel_socket_listen_sync(ioc, addr, &error_abort);
+        } else {
+            qio_channel_socket_connect_sync(ioc, addr, &error_abort);
+        }
+        fd =3D ioc->fd;
+        ioc->fd =3D -1;
+        optstr =3D g_strdup_printf("socket,id=3Dcdev0,fd=3D%d%s",
+                                 fd, is_listen ? ",server,nowait" : "");
+        object_unref(OBJECT(ioc));
+        return optstr;
+    } else {
+        switch (addr->type) {
+        case SOCKET_ADDRESS_TYPE_INET:
+            return g_strdup_printf("socket,id=3Dcdev0,host=3D%s,port=3D%=
s%s%s",
+                                   addr->u.inet.host,
+                                   addr->u.inet.port,
+                                   reconnect ? reconnect : "",
+                                   is_listen ? ",server,nowait" : "");
+
+        case SOCKET_ADDRESS_TYPE_UNIX:
+            return g_strdup_printf("socket,id=3Dcdev0,path=3D%s%s%s",
+                                   addr->u.q_unix.path,
+                                   reconnect ? reconnect : "",
+                                   is_listen ? ",server,nowait" : "");
+
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+
+
+static void
+char_socket_ping_pong(QIOChannel *ioc)
+{
+    char greeting[sizeof(SOCKET_PING)];
+    const char *response =3D SOCKET_PONG;
+
+    qio_channel_read_all(ioc, greeting, sizeof(greeting), &error_abort);
+
+    g_assert(memcmp(greeting, SOCKET_PING, sizeof(greeting)) =3D=3D 0);
+
+    qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), &error_abo=
rt);
+
+    object_unref(OBJECT(ioc));
+}
+
+
+static gpointer
+char_socket_server_client_thread(gpointer data)
+{
+    SocketAddress *addr =3D data;
+    QIOChannelSocket *ioc =3D qio_channel_socket_new();
+
+    qio_channel_socket_connect_sync(ioc, addr, &error_abort);
+
+    char_socket_ping_pong(QIO_CHANNEL(ioc));
+
+    return NULL;
+}
+
+
+typedef struct {
+    SocketAddress *addr;
+    bool wait_connected;
+    bool fd_pass;
+} CharSocketServerTestConfig;
+
+
+static void char_socket_server_test(gconstpointer opaque)
+{
+    const CharSocketServerTestConfig *config =3D opaque;
+    Chardev *chr;
+    CharBackend be =3D {0};
+    CharSocketTestData data =3D {0};
+    QObject *qaddr;
+    SocketAddress *addr;
+    Visitor *v;
+    QemuThread thread;
+    int ret;
+    bool reconnected;
+    char *optstr;
+    QemuOpts *opts;
+
+    setenv("QTEST_SILENT_ERRORS", "1", 1);
+    /*
+     * We rely on config->addr containing "nowait", otherwise
+     * qemu_chr_new() will block until a client connects. We
+     * can't spawn our client thread though, because until
+     * qemu_chr_new() returns we don't know what TCP port was
+     * allocated by the OS
+     */
+    optstr =3D char_socket_addr_to_opt_str(config->addr,
+                                         config->fd_pass,
+                                         NULL,
+                                         true);
+    opts =3D qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                   optstr, true);
+    g_assert_nonnull(opts);
+    chr =3D qemu_chr_new_from_opts(opts, &error_abort);
+    qemu_opts_del(opts);
+    g_assert_nonnull(chr);
+    g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_=
abort));
+
+    qaddr =3D object_property_get_qobject(OBJECT(chr), "addr", &error_ab=
ort);
+    g_assert_nonnull(qaddr);
+
+    v =3D qobject_input_visitor_new(qaddr);
+    visit_type_SocketAddress(v, "addr", &addr, &error_abort);
+    visit_free(v);
+    qobject_unref(qaddr);
+
+    qemu_chr_fe_init(&be, chr, &error_abort);
+
+ reconnect:
+    data.event =3D -1;
+    qemu_chr_fe_set_handlers(&be, NULL, NULL,
+                             char_socket_event, NULL,
+                             &data, NULL, true);
+    g_assert(data.event =3D=3D -1);
+
+    /*
+     * Kick off a thread to act as the "remote" client
+     * which just plays ping-pong with us
+     */
+    qemu_thread_create(&thread, "client",
+                       char_socket_server_client_thread,
+                       addr, QEMU_THREAD_JOINABLE);
+    g_assert(data.event =3D=3D -1);
+
+    if (config->wait_connected) {
+        /* Synchronously accept a connection */
+        qemu_chr_wait_connected(chr, &error_abort);
+    } else {
+        /*
+         * Asynchronously accept a connection when the evnt
+         * loop reports the listener socket as readable
+         */
+        while (data.event =3D=3D -1) {
+            main_loop_wait(false);
+        }
+    }
+    g_assert(object_property_get_bool(OBJECT(chr), "connected", &error_a=
bort));
+    g_assert(data.event =3D=3D CHR_EVENT_OPENED);
+    data.event =3D -1;
+
+    /* Send a greeting to the client */
+    ret =3D qemu_chr_fe_write_all(&be, (const uint8_t *)SOCKET_PING,
+                                sizeof(SOCKET_PING));
+    g_assert_cmpint(ret, =3D=3D, sizeof(SOCKET_PING));
+    g_assert(data.event =3D=3D -1);
+
+    /* Setup a callback to receive the reply to our greeting */
+    qemu_chr_fe_set_handlers(&be, char_socket_can_read,
+                             char_socket_read,
+                             char_socket_event, NULL,
+                             &data, NULL, true);
+    g_assert(data.event =3D=3D CHR_EVENT_OPENED);
+    data.event =3D -1;
+
+    /* Wait for the client to go away */
+    while (data.event =3D=3D -1) {
+        main_loop_wait(false);
+    }
+    g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_=
abort));
+    g_assert(data.event =3D=3D CHR_EVENT_CLOSED);
+    g_assert(data.got_pong);
+
+    qemu_thread_join(&thread);
+
+    if (!reconnected) {
+        reconnected =3D true;
+        goto reconnect;
+    }
+
+    qapi_free_SocketAddress(addr);
+    object_unparent(OBJECT(chr));
+    g_free(optstr);
+    unsetenv("QTEST_SILENT_ERRORS");
+}
+
+
+static gpointer
+char_socket_client_server_thread(gpointer data)
+{
+    QIOChannelSocket *ioc =3D data;
+    QIOChannelSocket *cioc;
+
+    cioc =3D qio_channel_socket_accept(ioc, &error_abort);
+    g_assert_nonnull(cioc);
+
+    char_socket_ping_pong(QIO_CHANNEL(cioc));
+
+    return NULL;
+}
+
+
+typedef struct {
+    SocketAddress *addr;
+    const char *reconnect;
+    bool wait_connected;
+    bool fd_pass;
+} CharSocketClientTestConfig;
+
+
+static void char_socket_client_test(gconstpointer opaque)
+{
+    const CharSocketClientTestConfig *config =3D opaque;
+    QIOChannelSocket *ioc;
+    char *optstr;
+    Chardev *chr;
+    CharBackend be =3D {0};
+    CharSocketTestData data =3D {0};
+    SocketAddress *addr;
+    QemuThread thread;
+    int ret;
+    bool reconnected =3D false;
+    QemuOpts *opts;
+
+    /*
+     * Setup a listener socket and determine get its address
+     * so we know the TCP port for the client later
+     */
+    ioc =3D qio_channel_socket_new();
+    g_assert_nonnull(ioc);
+    qio_channel_socket_listen_sync(ioc, config->addr, &error_abort);
+    addr =3D qio_channel_socket_get_local_address(ioc, &error_abort);
+    g_assert_nonnull(addr);
+
+    /*
+     * Kick off a thread to act as the "remote" client
+     * which just plays ping-pong with us
+     */
+    qemu_thread_create(&thread, "client",
+                       char_socket_client_server_thread,
+                       ioc, QEMU_THREAD_JOINABLE);
+
+    /*
+     * Populate the chardev address based on what the server
+     * is actually listening on
+     */
+    optstr =3D char_socket_addr_to_opt_str(addr,
+                                         config->fd_pass,
+                                         config->reconnect,
+                                         false);
+
+    opts =3D qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                   optstr, true);
+    g_assert_nonnull(opts);
+    chr =3D qemu_chr_new_from_opts(opts, &error_abort);
+    qemu_opts_del(opts);
+    g_assert_nonnull(chr);
+
+    if (config->reconnect) {
+        /*
+         * If reconnect is set, the connection will be
+         * established in a background thread and we won't
+         * see the "connected" status updated until we
+         * run the main event loop, or call qemu_chr_wait_connected
+         */
+        g_assert(!object_property_get_bool(OBJECT(chr), "connected",
+                                           &error_abort));
+    } else {
+        g_assert(object_property_get_bool(OBJECT(chr), "connected",
+                                          &error_abort));
+    }
+
+    qemu_chr_fe_init(&be, chr, &error_abort);
+
+ reconnect:
+    data.event =3D -1;
+    qemu_chr_fe_set_handlers(&be, NULL, NULL,
+                             char_socket_event, NULL,
+                             &data, NULL, true);
+    if (config->reconnect) {
+        g_assert(data.event =3D=3D -1);
+    } else {
+        g_assert(data.event =3D=3D CHR_EVENT_OPENED);
+    }
+
+    if (config->wait_connected) {
+        /*
+         * Synchronously wait for the connection to complete
+         * This should be a no-op if reconnect is not set.
+         */
+        qemu_chr_wait_connected(chr, &error_abort);
+    } else {
+        /*
+         * Asynchronously wait for the connection to be reported
+         * as complete when the background thread reports its
+         * status.
+         * The loop will short-circuit if reconnect was set
+         */
+        while (data.event =3D=3D -1) {
+            main_loop_wait(false);
+        }
+    }
+    g_assert(data.event =3D=3D CHR_EVENT_OPENED);
+    data.event =3D -1;
+    g_assert(object_property_get_bool(OBJECT(chr), "connected", &error_a=
bort));
+
+    /* Send a greeting to the server */
+    ret =3D qemu_chr_fe_write_all(&be, (const uint8_t *)SOCKET_PING,
+                                sizeof(SOCKET_PING));
+    g_assert_cmpint(ret, =3D=3D, sizeof(SOCKET_PING));
+    g_assert(data.event =3D=3D -1);
+
+    /* Setup a callback to receive the reply to our greeting */
+    qemu_chr_fe_set_handlers(&be, char_socket_can_read,
+                             char_socket_read,
+                             char_socket_event, NULL,
+                             &data, NULL, true);
+    g_assert(data.event =3D=3D CHR_EVENT_OPENED);
+    data.event =3D -1;
+
+    /* Wait for the server to go away */
+    while (data.event =3D=3D -1) {
+        main_loop_wait(false);
+    }
+    g_assert(data.event =3D=3D CHR_EVENT_CLOSED);
+    g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_=
abort));
+    g_assert(data.got_pong);
+    qemu_thread_join(&thread);
+
+    if (config->reconnect && !reconnected) {
+        reconnected =3D true;
+        qemu_thread_create(&thread, "client",
+                           char_socket_client_server_thread,
+                           ioc, QEMU_THREAD_JOINABLE);
+        goto reconnect;
+    }
+
+    object_unref(OBJECT(ioc));
+    object_unparent(OBJECT(chr));
+    qapi_free_SocketAddress(addr);
+    g_free(optstr);
+}
+
+
 #ifdef HAVE_CHARDEV_SERIAL
 static void char_serial_test(void)
 {
@@ -959,9 +1207,71 @@ int main(int argc, char **argv)
 #ifndef _WIN32
     g_test_add_func("/char/file-fifo", char_file_fifo_test);
 #endif
-    g_test_add_func("/char/socket/basic", char_socket_basic_test);
-    g_test_add_func("/char/socket/reconnect", char_socket_reconnect_test=
);
-    g_test_add_func("/char/socket/fdpass", char_socket_fdpass_test);
+
+    SocketAddress tcpaddr =3D {
+        .type =3D SOCKET_ADDRESS_TYPE_INET,
+        .u.inet.host =3D (char *)"127.0.0.1",
+        .u.inet.port =3D (char *)"0",
+    };
+#ifndef WIN32
+    SocketAddress unixaddr =3D {
+        .type =3D SOCKET_ADDRESS_TYPE_UNIX,
+        .u.q_unix.path =3D (char *)"test-char.sock",
+    };
+#endif
+
+#define SOCKET_SERVER_TEST(name, addr)                                  =
\
+    CharSocketServerTestConfig server1 ## name =3D                      =
  \
+        { addr, false, false };                                         =
\
+    CharSocketServerTestConfig server2 ## name =3D                      =
  \
+        { addr, true, false };                                          =
\
+    CharSocketServerTestConfig server3 ## name =3D                      =
  \
+        { addr, false, true };                                          =
\
+    CharSocketServerTestConfig server4 ## name =3D                      =
  \
+        { addr, true, true };                                           =
\
+    g_test_add_data_func("/char/socket/server/mainloop/" # name,        =
\
+                         &server1 ##name, char_socket_server_test);     =
\
+    g_test_add_data_func("/char/socket/server/wait-conn/" # name,       =
\
+                         &server2 ##name, char_socket_server_test);     =
\
+    g_test_add_data_func("/char/socket/server/mainloop-fdpass/" # name, =
\
+                         &server3 ##name, char_socket_server_test);     =
\
+    g_test_add_data_func("/char/socket/server/wait-conn-fdpass/" # name,=
 \
+                         &server4 ##name, char_socket_server_test)
+
+#define SOCKET_CLIENT_TEST(name, addr)                                  =
\
+    CharSocketClientTestConfig client1 ## name =3D                      =
  \
+        { addr, NULL, false, false };                                   =
\
+    CharSocketClientTestConfig client2 ## name =3D                      =
  \
+        { addr, NULL, true, false };                                    =
\
+    CharSocketClientTestConfig client3 ## name =3D                      =
  \
+        { addr, ",reconnect=3D1", false };                              =
  \
+    CharSocketClientTestConfig client4 ## name =3D                      =
  \
+        { addr, ",reconnect=3D1", true };                               =
  \
+    CharSocketClientTestConfig client5 ## name =3D                      =
  \
+        { addr, NULL, false, true };                                    =
\
+    CharSocketClientTestConfig client6 ## name =3D                      =
  \
+        { addr, NULL, true, true };                                     =
\
+    g_test_add_data_func("/char/socket/client/mainloop/" # name,        =
\
+                         &client1 ##name, char_socket_client_test);     =
\
+    g_test_add_data_func("/char/socket/client/wait-conn/" # name,       =
\
+                         &client2 ##name, char_socket_client_test);     =
\
+    g_test_add_data_func("/char/socket/client/mainloop-reconnect/" # nam=
e, \
+                         &client3 ##name, char_socket_client_test);     =
\
+    g_test_add_data_func("/char/socket/client/wait-conn-reconnect/" # na=
me, \
+                         &client4 ##name, char_socket_client_test);     =
\
+    g_test_add_data_func("/char/socket/client/mainloop-fdpass/" # name, =
\
+                         &client5 ##name, char_socket_client_test);     =
\
+    g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name,=
 \
+                         &client6 ##name, char_socket_client_test)
+
+    SOCKET_SERVER_TEST(tcp, &tcpaddr);
+    SOCKET_CLIENT_TEST(tcp, &tcpaddr);
+#ifndef WIN32
+    SOCKET_SERVER_TEST(unix, &unixaddr);
+    SOCKET_CLIENT_TEST(unix, &unixaddr);
+#endif
+
+
     g_test_add_func("/char/udp", char_udp_test);
 #ifdef HAVE_CHARDEV_SERIAL
     g_test_add_func("/char/serial", char_serial_test);
--=20
2.20.1
