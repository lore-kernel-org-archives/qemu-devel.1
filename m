Received: from eggs.gnu.org ([2001:4830:134:3::10]:47723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNeK-0006Va-9Y
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNeI-00031R-PF
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:46:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eSNeI-00030i-GW
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:46:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 972A330A099
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 13:46:05 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 22 Dec 2017 13:45:25 +0000
Message-Id: <20171222134527.14467-7-berrange@redhat.com>
In-Reply-To: <20171222134527.14467-1-berrange@redhat.com>
References: <20171222134527.14467-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/8] sockets: allow SocketAddress 'fd' to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The SocketAddress 'fd' kind accepts the name of a file descriptor passed
to the monitor with the 'getfd' command. This makes it impossible to use
the 'fd' kind in cases where a monitor is not available. This can apply in
handling command line argv at startup, or simply if internal code wants to
use SocketAddress and pass a numeric FD it has acquired from elsewhere.

Fortunately the 'getfd' command mandated that the FD names must not start
with a leading digit. We can thus safely extend semantics of the
SocketAddress 'fd' kind, to allow a purely numeric name to reference an
file descriptor that QEMU already has open. There will be restrictions on
when each kind can be used.

In codepaths where we are handling a monitor command (ie cur_mon != NULL),
we will only support use of named file descriptors as before. Use of FD
numbers is still not permitted for monitor commands.

In codepaths where we are not handling a monitor command (ie cur_mon ==
NULL), we will not support named file descriptors. Instead we can reference
FD numers explicitly. This allows the app spawning QEMU to intentionally
"leak" a pre-opened socket to QEMU and reference that in a SocketAddress
definition, or for code inside QEMU to pass pre-opened FDs around.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qapi/sockets.json    |   7 ++++
 tests/test-sockets.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++---
 util/qemu-sockets.c  |  16 ++++++--
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
+# @fd: decimal is for file descriptor number, otherwise a file descriptor name.
+#      Named file descriptors are permitted in monitor commands, in combination
+#      with the 'getfd' command. Decimal file descriptors are permitted at
+#      startup or other contexts where no monitor context is active.
+#
 # Since: 2.9
 ##
 { 'enum': 'SocketAddressType',
diff --git a/tests/test-sockets.c b/tests/test-sockets.c
index 8a2962fe7b..8307e4774f 100644
--- a/tests/test-sockets.c
+++ b/tests/test-sockets.c
@@ -49,7 +49,7 @@ Monitor *cur_mon;
 void monitor_init(Chardev *chr, int flags) {}
 
 
-static void test_socket_fd_pass_good(void)
+static void test_socket_fd_pass_name_good(void)
 {
     SocketAddress addr;
     int fd;
@@ -80,7 +80,7 @@ static void test_socket_fd_pass_good(void)
     cur_mon = NULL;
 }
 
-static void test_socket_fd_pass_bad(void)
+static void test_socket_fd_pass_name_bad(void)
 {
     SocketAddress addr;
     Error *err = NULL;
@@ -110,6 +110,98 @@ static void test_socket_fd_pass_bad(void)
     cur_mon = NULL;
 }
 
+static void test_socket_fd_pass_name_nomon(void)
+{
+    SocketAddress addr;
+    Error *err = NULL;
+    int fd;
+
+    g_assert(cur_mon == NULL);
+
+    addr.type = SOCKET_ADDRESS_TYPE_FD;
+    addr.u.fd.str = g_strdup("myfd");
+
+    fd = socket_connect(&addr, &err);
+    g_assert_cmpint(fd, ==, -1);
+    error_free_or_abort(&err);
+
+    fd = socket_listen(&addr, &err);
+    g_assert_cmpint(fd, ==, -1);
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
+    g_assert(cur_mon == NULL);
+    sfd = qemu_socket(AF_INET, SOCK_STREAM, 0);
+    g_assert_cmpint(sfd, >, STDERR_FILENO);
+
+    addr.type = SOCKET_ADDRESS_TYPE_FD;
+    addr.u.fd.str = g_strdup_printf("%d", sfd);
+
+    fd = socket_connect(&addr, &error_abort);
+    g_assert_cmpint(fd, ==, sfd);
+
+    fd = socket_listen(&addr, &error_abort);
+    g_assert_cmpint(fd, ==, sfd);
+
+    g_free(addr.u.fd.str);
+    close(sfd);
+}
+
+static void test_socket_fd_pass_num_bad(void)
+{
+    SocketAddress addr;
+    Error *err = NULL;
+    int fd, sfd;
+
+    g_assert(cur_mon == NULL);
+    sfd = dup(STDOUT_FILENO);
+
+    addr.type = SOCKET_ADDRESS_TYPE_FD;
+    addr.u.fd.str = g_strdup_printf("%d", sfd);
+
+    fd = socket_connect(&addr, &err);
+    g_assert_cmpint(fd, ==, -1);
+    error_free_or_abort(&err);
+
+    fd = socket_listen(&addr, &err);
+    g_assert_cmpint(fd, ==, -1);
+    error_free_or_abort(&err);
+
+    g_free(addr.u.fd.str);
+    close(sfd);
+}
+
+static void test_socket_fd_pass_num_nocli(void)
+{
+    SocketAddress addr;
+    Error *err = NULL;
+    int fd;
+
+    cur_mon = g_malloc(1); /* Fake a monitor */
+
+    addr.type = SOCKET_ADDRESS_TYPE_FD;
+    addr.u.fd.str = g_strdup_printf("%d", STDOUT_FILENO);
+
+    fd = socket_connect(&addr, &err);
+    g_assert_cmpint(fd, ==, -1);
+    error_free_or_abort(&err);
+
+    fd = socket_listen(&addr, &err);
+    g_assert_cmpint(fd, ==, -1);
+    error_free_or_abort(&err);
+
+    g_free(addr.u.fd.str);
+}
+
+
 int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
@@ -129,10 +221,18 @@ int main(int argc, char **argv)
     }
 
     if (has_ipv4) {
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
 
     return g_test_run();
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 6a7b194428..8ac4eed122 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1029,9 +1029,19 @@ fail:
 
 static int socket_get_fd(const char *fdstr, Error **errp)
 {
-    int fd = monitor_get_fd(cur_mon, fdstr, errp);
-    if (fd < 0) {
-        return -1;
+    int fd;
+    if (cur_mon) {
+        fd = monitor_get_fd(cur_mon, fdstr, errp);
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
-- 
2.14.3
