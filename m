Received: from eggs.gnu.org ([209.51.188.92]:37313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gme5T-0001D7-Kc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gme5Q-0005HV-T6
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gme5O-0005B4-Kl
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:22 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 24 Jan 2019 12:26:14 +0000
Message-Id: <20190124122614.16624-2-berrange@redhat.com>
In-Reply-To: <20190124122614.16624-1-berrange@redhat.com>
References: <20190124122614.16624-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] io: ensure UNIX client doesn't unlink
 server socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

The qio_channel_socket_close method for was mistakenly unlinking the
UNIX server socket, even if the channel was a client connection. This
was not noticed with chardevs, since they never call close, but with the
VNC server, this caused the VNC server socket to be deleted after the
first client quit.

The qio_channel_socket_close method also needlessly reimplemented the
logic that already exists in socket_listen_cleanup(). Just call that
method directly, for listen sockets only.

This fixes a regression introduced in QEMU 3.0.0 with

  commit d66f78e1eaa832f73c771d9df1b606fe75d52a50
  Author: Pavel Balaev <mail@void.so>
  Date:   Mon May 21 19:17:35 2018 +0300

    Delete AF_UNIX socket after close

Fixes launchpad #1795100

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 io/channel-socket.c            | 19 ++------
 tests/test-io-channel-socket.c | 86 ++++++++++++++++++++++++++++++----
 2 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index b50e63a053..bc5f80e780 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -688,10 +688,13 @@ qio_channel_socket_close(QIOChannel *ioc,
     int rc =3D 0;
=20
     if (sioc->fd !=3D -1) {
-        SocketAddress *addr =3D socket_local_address(sioc->fd, errp);
 #ifdef WIN32
         WSAEventSelect(sioc->fd, NULL, 0);
 #endif
+        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_LISTEN)) {
+            socket_listen_cleanup(sioc->fd, errp);
+        }
+
         if (closesocket(sioc->fd) < 0) {
             sioc->fd =3D -1;
             error_setg_errno(errp, errno,
@@ -699,20 +702,6 @@ qio_channel_socket_close(QIOChannel *ioc,
             return -1;
         }
         sioc->fd =3D -1;
-
-        if (addr && addr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX
-            && addr->u.q_unix.path) {
-            if (unlink(addr->u.q_unix.path) < 0 && errno !=3D ENOENT) {
-                error_setg_errno(errp, errno,
-                                 "Failed to unlink socket %s",
-                                 addr->u.q_unix.path);
-                rc =3D -1;
-            }
-        }
-
-        if (addr) {
-            qapi_free_SocketAddress(addr);
-        }
     }
     return rc;
 }
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socke=
t.c
index 0597213f93..c253ae30f5 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -49,6 +49,7 @@ static void test_io_channel_set_socket_bufs(QIOChannel =
*src,
=20
 static void test_io_channel_setup_sync(SocketAddress *listen_addr,
                                        SocketAddress *connect_addr,
+                                       QIOChannel **srv,
                                        QIOChannel **src,
                                        QIOChannel **dst)
 {
@@ -78,7 +79,7 @@ static void test_io_channel_setup_sync(SocketAddress *l=
isten_addr,
=20
     test_io_channel_set_socket_bufs(*src, *dst);
=20
-    object_unref(OBJECT(lioc));
+    *srv =3D QIO_CHANNEL(lioc);
 }
=20
=20
@@ -99,6 +100,7 @@ static void test_io_channel_complete(QIOTask *task,
=20
 static void test_io_channel_setup_async(SocketAddress *listen_addr,
                                         SocketAddress *connect_addr,
+                                        QIOChannel **srv,
                                         QIOChannel **src,
                                         QIOChannel **dst)
 {
@@ -146,21 +148,34 @@ static void test_io_channel_setup_async(SocketAddre=
ss *listen_addr,
     qio_channel_set_delay(*src, false);
     test_io_channel_set_socket_bufs(*src, *dst);
=20
-    object_unref(OBJECT(lioc));
+    *srv =3D QIO_CHANNEL(lioc);
=20
     g_main_loop_unref(data.loop);
 }
=20
=20
+static void test_io_channel_socket_path_exists(SocketAddress *addr,
+                                               bool expectExists)
+{
+    if (addr->type !=3D SOCKET_ADDRESS_TYPE_UNIX) {
+        return;
+    }
+
+    g_assert(g_file_test(addr->u.q_unix.path,
+                         G_FILE_TEST_EXISTS) =3D=3D expectExists);
+}
+
+
 static void test_io_channel(bool async,
                             SocketAddress *listen_addr,
                             SocketAddress *connect_addr,
                             bool passFD)
 {
-    QIOChannel *src, *dst;
+    QIOChannel *src, *dst, *srv;
     QIOChannelTest *test;
     if (async) {
-        test_io_channel_setup_async(listen_addr, connect_addr, &src, &ds=
t);
+        test_io_channel_setup_async(listen_addr, connect_addr,
+                                    &srv, &src, &dst);
=20
         g_assert(!passFD ||
                  qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_FD_PAS=
S));
@@ -169,14 +184,25 @@ static void test_io_channel(bool async,
         g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDO=
WN));
         g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDO=
WN));
=20
+        test_io_channel_socket_path_exists(listen_addr, true);
+
         test =3D qio_channel_test_new();
         qio_channel_test_run_threads(test, true, src, dst);
         qio_channel_test_validate(test);
=20
+        test_io_channel_socket_path_exists(listen_addr, true);
+
+        /* unref without close, to ensure finalize() cleans up */
+
         object_unref(OBJECT(src));
         object_unref(OBJECT(dst));
+        test_io_channel_socket_path_exists(listen_addr, true);
=20
-        test_io_channel_setup_async(listen_addr, connect_addr, &src, &ds=
t);
+        object_unref(OBJECT(srv));
+        test_io_channel_socket_path_exists(listen_addr, false);
+
+        test_io_channel_setup_async(listen_addr, connect_addr,
+                                    &srv, &src, &dst);
=20
         g_assert(!passFD ||
                  qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_FD_PAS=
S));
@@ -189,10 +215,24 @@ static void test_io_channel(bool async,
         qio_channel_test_run_threads(test, false, src, dst);
         qio_channel_test_validate(test);
=20
+        /* close before unref, to ensure finalize copes with already clo=
sed */
+
+        qio_channel_close(src, &error_abort);
+        qio_channel_close(dst, &error_abort);
+        test_io_channel_socket_path_exists(listen_addr, true);
+
         object_unref(OBJECT(src));
         object_unref(OBJECT(dst));
+        test_io_channel_socket_path_exists(listen_addr, true);
+
+        qio_channel_close(srv, &error_abort);
+        test_io_channel_socket_path_exists(listen_addr, false);
+
+        object_unref(OBJECT(srv));
+        test_io_channel_socket_path_exists(listen_addr, false);
     } else {
-        test_io_channel_setup_sync(listen_addr, connect_addr, &src, &dst=
);
+        test_io_channel_setup_sync(listen_addr, connect_addr,
+                                   &srv, &src, &dst);
=20
         g_assert(!passFD ||
                  qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_FD_PAS=
S));
@@ -201,14 +241,25 @@ static void test_io_channel(bool async,
         g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDO=
WN));
         g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDO=
WN));
=20
+        test_io_channel_socket_path_exists(listen_addr, true);
+
         test =3D qio_channel_test_new();
         qio_channel_test_run_threads(test, true, src, dst);
         qio_channel_test_validate(test);
=20
+        test_io_channel_socket_path_exists(listen_addr, true);
+
+        /* unref without close, to ensure finalize() cleans up */
+
         object_unref(OBJECT(src));
         object_unref(OBJECT(dst));
+        test_io_channel_socket_path_exists(listen_addr, true);
+
+        object_unref(OBJECT(srv));
+        test_io_channel_socket_path_exists(listen_addr, false);
=20
-        test_io_channel_setup_sync(listen_addr, connect_addr, &src, &dst=
);
+        test_io_channel_setup_sync(listen_addr, connect_addr,
+                                   &srv, &src, &dst);
=20
         g_assert(!passFD ||
                  qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_FD_PAS=
S));
@@ -221,8 +272,23 @@ static void test_io_channel(bool async,
         qio_channel_test_run_threads(test, false, src, dst);
         qio_channel_test_validate(test);
=20
+        test_io_channel_socket_path_exists(listen_addr, true);
+
+        /* close before unref, to ensure finalize copes with already clo=
sed */
+
+        qio_channel_close(src, &error_abort);
+        qio_channel_close(dst, &error_abort);
+        test_io_channel_socket_path_exists(listen_addr, true);
+
         object_unref(OBJECT(src));
         object_unref(OBJECT(dst));
+        test_io_channel_socket_path_exists(listen_addr, true);
+
+        qio_channel_close(srv, &error_abort);
+        test_io_channel_socket_path_exists(listen_addr, false);
+
+        object_unref(OBJECT(srv));
+        test_io_channel_socket_path_exists(listen_addr, false);
     }
 }
=20
@@ -316,7 +382,6 @@ static void test_io_channel_unix(bool async)
=20
     qapi_free_SocketAddress(listen_addr);
     qapi_free_SocketAddress(connect_addr);
-    g_assert(g_file_test(TEST_SOCKET, G_FILE_TEST_EXISTS) =3D=3D FALSE);
 }
=20
=20
@@ -335,7 +400,7 @@ static void test_io_channel_unix_fd_pass(void)
 {
     SocketAddress *listen_addr =3D g_new0(SocketAddress, 1);
     SocketAddress *connect_addr =3D g_new0(SocketAddress, 1);
-    QIOChannel *src, *dst;
+    QIOChannel *src, *dst, *srv;
     int testfd;
     int fdsend[3];
     int *fdrecv =3D NULL;
@@ -359,7 +424,7 @@ static void test_io_channel_unix_fd_pass(void)
     connect_addr->type =3D SOCKET_ADDRESS_TYPE_UNIX;
     connect_addr->u.q_unix.path =3D g_strdup(TEST_SOCKET);
=20
-    test_io_channel_setup_sync(listen_addr, connect_addr, &src, &dst);
+    test_io_channel_setup_sync(listen_addr, connect_addr, &srv, &src, &d=
st);
=20
     memcpy(bufsend, "Hello World", G_N_ELEMENTS(bufsend));
=20
@@ -412,6 +477,7 @@ static void test_io_channel_unix_fd_pass(void)
=20
     object_unref(OBJECT(src));
     object_unref(OBJECT(dst));
+    object_unref(OBJECT(srv));
     qapi_free_SocketAddress(listen_addr);
     qapi_free_SocketAddress(connect_addr);
     unlink(TEST_SOCKET);
--=20
2.20.1
