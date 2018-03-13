Received: from eggs.gnu.org ([2001:4830:134:3::10]:40341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evoQI-0001HP-5d
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evoQE-0007QS-5C
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:13:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evoQD-0007QD-VQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:13:14 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 13 Mar 2018 18:12:45 +0000
Message-Id: <20180313181248.16215-7-berrange@redhat.com>
In-Reply-To: <20180313181248.16215-1-berrange@redhat.com>
References: <20180313181248.16215-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 6/9] sockets: check that the named file
 descriptor is a socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The SocketAddress struct has an "fd" type, which references the name of a
file descriptor passed over the monitor using the "getfd" command. We
currently blindly assume the FD is a socket, which can lead to hard to
diagnose errors later. This adds an explicit check that the FD is actuall=
y
a socket to improve the error diagnosis.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/test-util-sockets.c | 89 +++++++++++++++++++++++++++++++++++++++++=
++++++
 util/qemu-sockets.c       | 18 ++++++++--
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 65190e0530..06eb0e4a28 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -23,6 +23,7 @@
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "socket-helpers.h"
+#include "monitor/monitor.h"
=20
 static void test_fd_is_socket_bad(void)
 {
@@ -49,6 +50,90 @@ static void test_fd_is_socket_good(void)
     close(fd);
 }
=20
+static int mon_fd =3D -1;
+static const char *mon_fdname;
+
+int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
+{
+    g_assert(cur_mon);
+    g_assert(mon =3D=3D cur_mon);
+    if (mon_fd =3D=3D -1 || !g_str_equal(mon_fdname, fdname)) {
+        error_setg(errp, "No fd named %s", fdname);
+        return -1;
+    }
+    return dup(mon_fd);
+}
+
+/* Syms in libqemustub.a are discarded at .o file granularity.
+ * To replace monitor_get_fd() we must ensure everything in
+ * stubs/monitor.c is defined, to make sure monitor.o is discarded
+ * otherwise we get duplicate syms at link time.
+ */
+Monitor *cur_mon;
+void monitor_init(Chardev *chr, int flags) {}
+
+
+static void test_socket_fd_pass_good(void)
+{
+    SocketAddress addr;
+    int fd;
+
+    cur_mon =3D g_malloc(1); /* Fake a monitor */
+    mon_fdname =3D "myfd";
+    mon_fd =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
+    g_assert_cmpint(mon_fd, >, STDERR_FILENO);
+
+    addr.type =3D SOCKET_ADDRESS_TYPE_FD;
+    addr.u.fd.str =3D g_strdup(mon_fdname);
+
+    fd =3D socket_connect(&addr, &error_abort);
+    g_assert_cmpint(fd, !=3D, -1);
+    g_assert_cmpint(fd, !=3D, mon_fd);
+    close(fd);
+
+    fd =3D socket_listen(&addr, &error_abort);
+    g_assert_cmpint(fd, !=3D, -1);
+    g_assert_cmpint(fd, !=3D, mon_fd);
+    close(fd);
+
+    g_free(addr.u.fd.str);
+    mon_fdname =3D NULL;
+    close(mon_fd);
+    mon_fd =3D -1;
+    g_free(cur_mon);
+    cur_mon =3D NULL;
+}
+
+static void test_socket_fd_pass_bad(void)
+{
+    SocketAddress addr;
+    Error *err =3D NULL;
+    int fd;
+
+    cur_mon =3D g_malloc(1); /* Fake a monitor */
+    mon_fdname =3D "myfd";
+    mon_fd =3D dup(STDOUT_FILENO);
+    g_assert_cmpint(mon_fd, >, STDERR_FILENO);
+
+    addr.type =3D SOCKET_ADDRESS_TYPE_FD;
+    addr.u.fd.str =3D g_strdup(mon_fdname);
+
+    fd =3D socket_connect(&addr, &err);
+    g_assert_cmpint(fd, =3D=3D, -1);
+    error_free_or_abort(&err);
+
+    fd =3D socket_listen(&addr, &err);
+    g_assert_cmpint(fd, =3D=3D, -1);
+    error_free_or_abort(&err);
+
+    g_free(addr.u.fd.str);
+    mon_fdname =3D NULL;
+    close(mon_fd);
+    mon_fd =3D -1;
+    g_free(cur_mon);
+    cur_mon =3D NULL;
+}
+
 int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
@@ -71,6 +156,10 @@ int main(int argc, char **argv)
                         test_fd_is_socket_bad);
         g_test_add_func("/util/socket/is-socket/good",
                         test_fd_is_socket_good);
+        g_test_add_func("/socket/fd-pass/good",
+                        test_socket_fd_pass_good);
+        g_test_add_func("/socket/fd-pass/bad",
+                        test_socket_fd_pass_bad);
     }
=20
     return g_test_run();
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index fa79471647..6dc4613855 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1042,6 +1042,20 @@ fail:
     return NULL;
 }
=20
+static int socket_get_fd(const char *fdstr, Error **errp)
+{
+    int fd =3D monitor_get_fd(cur_mon, fdstr, errp);
+    if (fd < 0) {
+        return -1;
+    }
+    if (!fd_is_socket(fd)) {
+        error_setg(errp, "File descriptor '%s' is not a socket", fdstr);
+        close(fd);
+        return -1;
+    }
+    return fd;
+}
+
 int socket_connect(SocketAddress *addr, Error **errp)
 {
     int fd;
@@ -1056,7 +1070,7 @@ int socket_connect(SocketAddress *addr, Error **err=
p)
         break;
=20
     case SOCKET_ADDRESS_TYPE_FD:
-        fd =3D monitor_get_fd(cur_mon, addr->u.fd.str, errp);
+        fd =3D socket_get_fd(addr->u.fd.str, errp);
         break;
=20
     case SOCKET_ADDRESS_TYPE_VSOCK:
@@ -1083,7 +1097,7 @@ int socket_listen(SocketAddress *addr, Error **errp=
)
         break;
=20
     case SOCKET_ADDRESS_TYPE_FD:
-        fd =3D monitor_get_fd(cur_mon, addr->u.fd.str, errp);
+        fd =3D socket_get_fd(addr->u.fd.str, errp);
         break;
=20
     case SOCKET_ADDRESS_TYPE_VSOCK:
--=20
2.14.3
