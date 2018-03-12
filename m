Received: from eggs.gnu.org ([2001:4830:134:3::10]:39737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evTp1-0004Fq-Nd
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evTp0-00076u-0q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:13:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evToz-00076f-Qi
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:13:25 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 12 Mar 2018 20:13:03 +0000
Message-Id: <20180312201305.16972-8-berrange@redhat.com>
In-Reply-To: <20180312201305.16972-1-berrange@redhat.com>
References: <20180312201305.16972-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] sockets: allow SocketAddress 'fd' to
 reference numeric file descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: "Daniel P. Berrange" <berrange@redhat.com>

The SocketAddress 'fd' kind accepts the name of a file descriptor passed
to the monitor with the 'getfd' command. This makes it impossible to use
the 'fd' kind in cases where a monitor is not available. This can apply i=
n
handling command line argv at startup, or simply if internal code wants t=
o
use SocketAddress and pass a numeric FD it has acquired from elsewhere.

Fortunately the 'getfd' command mandated that the FD names must not start
with a leading digit. We can thus safely extend semantics of the
SocketAddress 'fd' kind, to allow a purely numeric name to reference an
file descriptor that QEMU already has open. There will be restrictions on
when each kind can be used.

In codepaths where we are handling a monitor command (ie cur_mon !=3D NUL=
L),
we will only support use of named file descriptors as before. Use of FD
numbers is still not permitted for monitor commands.

In codepaths where we are not handling a monitor command (ie cur_mon =3D=3D
NULL), we will not support named file descriptors. Instead we can referen=
ce
FD numers explicitly. This allows the app spawning QEMU to intentionally
"leak" a pre-opened socket to QEMU and reference that in a SocketAddress
definition, or for code inside QEMU to pass pre-opened FDs around.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qapi/sockets.json         |   7 +++
 tests/test-util-sockets.c | 112 ++++++++++++++++++++++++++++++++++++++++=
+++---
 util/qemu-sockets.c       |  16 +++++--
 3 files changed, 126 insertions(+), 9 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index ac022c6ad0..fc81d8d5e8 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -123,6 +123,13 @@
 #
 # @unix:  Unix domain socket
 #
+# @vsock: VMCI address
+#
+# @fd: decimal is for file descriptor number, otherwise a file descripto=
r name.
+#      Named file descriptors are permitted in monitor commands, in comb=
ination
+#      with the 'getfd' command. Decimal file descriptors are permitted =
at
+#      startup or other contexts where no monitor context is active.
+#
 # Since: 2.9
 ##
 { 'enum': 'SocketAddressType',
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 06eb0e4a28..acadd85e8f 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -73,7 +73,7 @@ Monitor *cur_mon;
 void monitor_init(Chardev *chr, int flags) {}
=20
=20
-static void test_socket_fd_pass_good(void)
+static void test_socket_fd_pass_name_good(void)
 {
     SocketAddress addr;
     int fd;
@@ -104,7 +104,7 @@ static void test_socket_fd_pass_good(void)
     cur_mon =3D NULL;
 }
=20
-static void test_socket_fd_pass_bad(void)
+static void test_socket_fd_pass_name_bad(void)
 {
     SocketAddress addr;
     Error *err =3D NULL;
@@ -134,6 +134,98 @@ static void test_socket_fd_pass_bad(void)
     cur_mon =3D NULL;
 }
=20
+static void test_socket_fd_pass_name_nomon(void)
+{
+    SocketAddress addr;
+    Error *err =3D NULL;
+    int fd;
+
+    g_assert(cur_mon =3D=3D NULL);
+
+    addr.type =3D SOCKET_ADDRESS_TYPE_FD;
+    addr.u.fd.str =3D g_strdup("myfd");
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
+}
+
+
+static void test_socket_fd_pass_num_good(void)
+{
+    SocketAddress addr;
+    int fd, sfd;
+
+    g_assert(cur_mon =3D=3D NULL);
+    sfd =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
+    g_assert_cmpint(sfd, >, STDERR_FILENO);
+
+    addr.type =3D SOCKET_ADDRESS_TYPE_FD;
+    addr.u.fd.str =3D g_strdup_printf("%d", sfd);
+
+    fd =3D socket_connect(&addr, &error_abort);
+    g_assert_cmpint(fd, =3D=3D, sfd);
+
+    fd =3D socket_listen(&addr, &error_abort);
+    g_assert_cmpint(fd, =3D=3D, sfd);
+
+    g_free(addr.u.fd.str);
+    close(sfd);
+}
+
+static void test_socket_fd_pass_num_bad(void)
+{
+    SocketAddress addr;
+    Error *err =3D NULL;
+    int fd, sfd;
+
+    g_assert(cur_mon =3D=3D NULL);
+    sfd =3D dup(STDOUT_FILENO);
+
+    addr.type =3D SOCKET_ADDRESS_TYPE_FD;
+    addr.u.fd.str =3D g_strdup_printf("%d", sfd);
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
+    close(sfd);
+}
+
+static void test_socket_fd_pass_num_nocli(void)
+{
+    SocketAddress addr;
+    Error *err =3D NULL;
+    int fd;
+
+    cur_mon =3D g_malloc(1); /* Fake a monitor */
+
+    addr.type =3D SOCKET_ADDRESS_TYPE_FD;
+    addr.u.fd.str =3D g_strdup_printf("%d", STDOUT_FILENO);
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
+}
+
+
 int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
@@ -156,10 +248,18 @@ int main(int argc, char **argv)
                         test_fd_is_socket_bad);
         g_test_add_func("/util/socket/is-socket/good",
                         test_fd_is_socket_good);
-        g_test_add_func("/socket/fd-pass/good",
-                        test_socket_fd_pass_good);
-        g_test_add_func("/socket/fd-pass/bad",
-                        test_socket_fd_pass_bad);
+        g_test_add_func("/socket/fd-pass/name/good",
+                        test_socket_fd_pass_name_good);
+        g_test_add_func("/socket/fd-pass/name/bad",
+                        test_socket_fd_pass_name_bad);
+        g_test_add_func("/socket/fd-pass/name/nomon",
+                        test_socket_fd_pass_name_nomon);
+        g_test_add_func("/socket/fd-pass/num/good",
+                        test_socket_fd_pass_num_good);
+        g_test_add_func("/socket/fd-pass/num/bad",
+                        test_socket_fd_pass_num_bad);
+        g_test_add_func("/socket/fd-pass/num/nocli",
+                        test_socket_fd_pass_num_nocli);
     }
=20
     return g_test_run();
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 6dc4613855..8bd8bb64eb 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1044,9 +1044,19 @@ fail:
=20
 static int socket_get_fd(const char *fdstr, Error **errp)
 {
-    int fd =3D monitor_get_fd(cur_mon, fdstr, errp);
-    if (fd < 0) {
-        return -1;
+    int fd;
+    if (cur_mon) {
+        fd =3D monitor_get_fd(cur_mon, fdstr, errp);
+        if (fd < 0) {
+            return -1;
+        }
+    } else {
+        if (qemu_strtoi(fdstr, NULL, 10, &fd) < 0) {
+            error_setg_errno(errp, errno,
+                             "Unable to parse FD number %s",
+                             fdstr);
+            return -1;
+        }
     }
     if (!fd_is_socket(fd)) {
         error_setg(errp, "File descriptor '%s' is not a socket", fdstr);
--=20
2.14.3
