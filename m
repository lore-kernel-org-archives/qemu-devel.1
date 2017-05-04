Received: from eggs.gnu.org ([2001:4830:134:3::10]:46677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FBm-0004cF-3i
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FBl-0004xs-67
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6FBk-0004xc-Te
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:53 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:30 +0400
Message-Id: <20170504114232.20318-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/21] tests: add /char/socket test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 1 file changed, 112 insertions(+), 2 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 87a4e2986d..9971498391 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -3,9 +3,11 @@
=20
 #include "qemu-common.h"
 #include "qemu/config-file.h"
+#include "qemu/sockets.h"
 #include "sysemu/char.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
+#include "qom/qom-qobject.h"
 #include "qmp-commands.h"
=20
 static bool quit;
@@ -16,7 +18,6 @@ typedef struct FeHandler {
     char read_buf[128];
 } FeHandler;
=20
-#ifndef _WIN32
 static void main_loop(void)
 {
     bool nonblocking;
@@ -28,7 +29,6 @@ static void main_loop(void)
         last_io =3D main_loop_wait(nonblocking);
     } while (!quit);
 }
-#endif
=20
 static int fe_can_read(void *opaque)
 {
@@ -211,6 +211,114 @@ static void char_mux_test(void)
     object_unparent(OBJECT(chr));
 }
=20
+typedef struct SocketIdleData {
+    GMainLoop *loop;
+    Chardev *chr;
+    bool conn_expected;
+    CharBackend *be;
+    CharBackend *client_be;
+} SocketIdleData;
+
+static gboolean char_socket_test_idle(gpointer user_data)
+{
+    SocketIdleData *data =3D user_data;
+
+    if (object_property_get_bool(OBJECT(data->chr), "connected", NULL)
+        =3D=3D data->conn_expected) {
+        quit =3D true;
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+static void socket_read(void *opaque, const uint8_t *buf, int size)
+{
+    SocketIdleData *data =3D opaque;
+
+    g_assert_cmpint(size, =3D=3D, 1);
+    g_assert_cmpint(*buf, =3D=3D, 'Z');
+
+    size =3D qemu_chr_fe_write(data->be, (const uint8_t *)"hello", 5);
+    g_assert_cmpint(size, =3D=3D, 5);
+}
+
+static int socket_can_read(void *opaque)
+{
+    return 10;
+}
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
+static void char_socket_test(void)
+{
+    Chardev *chr =3D qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowa=
it");
+    Chardev *chr_client;
+    QObject *addr;
+    QDict *qdict, *data;
+    const char *port;
+    SocketIdleData d =3D { .chr =3D chr };
+    CharBackend be;
+    CharBackend client_be;
+    char *tmp;
+
+    d.be =3D &be;
+    d.client_be =3D &be;
+
+    g_assert_nonnull(chr);
+    g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_=
abort));
+
+    addr =3D object_property_get_qobject(OBJECT(chr), "addr", &error_abo=
rt);
+    qdict =3D qobject_to_qdict(addr);
+    data =3D qdict_get_qdict(qdict, "data");
+    port =3D qdict_get_str(data, "port");
+    tmp =3D g_strdup_printf("tcp:127.0.0.1:%s", port);
+    QDECREF(qdict);
+
+    qemu_chr_fe_init(&be, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&be, socket_can_read, socket_read,
+                             NULL, &d, NULL, true);
+
+    chr_client =3D qemu_chr_new("client", tmp);
+    qemu_chr_fe_init(&client_be, chr_client, &error_abort);
+    qemu_chr_fe_set_handlers(&client_be, socket_can_read_hello,
+                             socket_read_hello,
+                             NULL, &d, NULL, true);
+    g_free(tmp);
+
+    d.conn_expected =3D true;
+    guint id =3D g_idle_add(char_socket_test_idle, &d);
+    g_source_set_name_by_id(id, "test-idle");
+    g_assert_cmpint(id, >, 0);
+    main_loop();
+
+    g_assert(object_property_get_bool(OBJECT(chr), "connected", &error_a=
bort));
+    g_assert(object_property_get_bool(OBJECT(chr_client),
+                                      "connected", &error_abort));
+
+    qemu_chr_write_all(chr_client, (const uint8_t *)"Z", 1);
+    main_loop();
+
+    object_unparent(OBJECT(chr_client));
+
+    d.conn_expected =3D false;
+    g_idle_add(char_socket_test_idle, &d);
+    main_loop();
+
+    object_unparent(OBJECT(chr));
+}
+
 #ifndef _WIN32
 static void char_pipe_test(void)
 {
@@ -401,6 +509,7 @@ static void char_invalid_test(void)
 int main(int argc, char **argv)
 {
     qemu_init_main_loop(&error_abort);
+    socket_init();
=20
     g_test_init(&argc, &argv, NULL);
=20
@@ -419,6 +528,7 @@ int main(int argc, char **argv)
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
     g_test_add_func("/char/file", char_file_test);
+    g_test_add_func("/char/socket", char_socket_test);
=20
     return g_test_run();
 }
--=20
2.12.0.191.gc5d8de91d
