Received: from eggs.gnu.org ([2001:4830:134:3::10]:43201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS3Fq-0008OR-Aa
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS3Fo-0000FZ-HG
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:59:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60947)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eS3Fo-0000F5-8J
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:59:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DF6C25C52
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 15:59:27 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 21 Dec 2017 15:59:05 +0000
Message-Id: <20171221155905.3793-3-berrange@redhat.com>
In-Reply-To: <20171221155905.3793-1-berrange@redhat.com>
References: <20171221155905.3793-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] char: allow passing pre-opened socket
 file descriptor at startup
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

When starting QEMU management apps will usually setup a monitor socket, and
then open it immediately after startup. If not using QEMU's own -daemonize
arg, this process can be troublesome to handle correctly. The mgmt app will
need to repeatedly call connect() until it succeeds, because it does not
know when QEMU has created the listener socket. If can't retry connect()
forever though, because an error might have caused QEMU to exit before it
even creates the monitor.

The obvious way to fix this kind of problem is to just pass in a pre-opened
socket file descriptor for the QEMU monitor to listen on. The management app
can now immediately call connect() just once. If connect() fails it knows
that QEMU has exited with an error.

The SocketAddress(Legacy) structs allow for FD passing via the monitor, using
the 'getfd' command, but only when using QMP JSON syntax. The HMP & CLI syntax
for chardevs, however, has no way to initialize the SocketAddress(Legacy) 'fd'
variant. So this patch wires up the 'fd' parameter to refer to a refer to a
passed in file descriptor. It can refer either to a named FD passed via the
'getfd' command, as already supported with QMP, or if numeric it refers to an
FD passed to QEMU at startup. This allows both HMP usage:

   (pass any FD number with SCM_RIGHTS)
   getfd myfd
   chardev-add socket,fd=myfd

And also CLI usage

  (leak FD 3 from parent by clearing O_CLOEXEC)
  -chardev socket,fd=3,id=mon
  -mon chardev=mon,mode=control

Note that we do not wire this up in the legacy chardev syntax, so you cannot
use FD passing with '-qmp', you must use the modern '-mon' + '-chardev' pair

An illustrative example of usage is:

  #!/usr/bin/perl

  use IO::Socket::UNIX;
  use Fcntl;

  unlink "/tmp/qmp";
  my $srv = IO::Socket::UNIX->new(
    Type => SOCK_STREAM(),
    Local => "/tmp/qmp",
    Listen => 1,
  );

  my $flags = fcntl $srv, F_GETFD, 0;
  fcntl $srv, F_SETFD, $flags & ~FD_CLOEXEC;

  my $fd = $srv->fileno();

  exec "qemu-system-x86_64", \
      "-chardev", "socket,fd=$fd,server,nowait,id=mon", \
      "-mon", "chardev=mon,mode=control";

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c |  32 ++++++++--
 chardev/char.c        |   3 +
 tests/test-char.c     | 173 +++++++++++++++++++++++++++++++++++++++++++++++++-
 util/qemu-sockets.c   |  42 +++++++++++-
 4 files changed, 238 insertions(+), 12 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 6013972f72..e162db7542 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -28,6 +28,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
+#include "qemu/cutils.h"
 
 #include "chardev/char-io.h"
 
@@ -983,25 +984,36 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     const char *path = qemu_opt_get(opts, "path");
     const char *host = qemu_opt_get(opts, "host");
     const char *port = qemu_opt_get(opts, "port");
+    const char *fd = qemu_opt_get(opts, "fd");
     const char *tls_creds = qemu_opt_get(opts, "tls-creds");
     SocketAddressLegacy *addr;
     ChardevSocket *sock;
 
+    if ((!!path + !!fd + !!host) != 1) {
+        error_setg(errp,
+                   "Exactly one of 'path', 'fd' or 'host' required");
+        return;
+    }
+
     backend->type = CHARDEV_BACKEND_KIND_SOCKET;
-    if (!path) {
-        if (!host) {
-            error_setg(errp, "chardev: socket: no host given");
+    if (path) {
+        if (tls_creds) {
+            error_setg(errp, "TLS can only be used over TCP socket");
             return;
         }
+    } else if (host) {
         if (!port) {
             error_setg(errp, "chardev: socket: no port given");
             return;
         }
-    } else {
-        if (tls_creds) {
-            error_setg(errp, "TLS can only be used over TCP socket");
+    } else if (fd) {
+        /* We don't know what host to validate against when in client mode */
+        if (tls_creds && !is_listen) {
+            error_setg(errp, "TLS can not be used with pre-opened client FD");
             return;
         }
+    } else {
+        g_assert_not_reached();
     }
 
     sock = backend->u.socket.data = g_new0(ChardevSocket, 1);
@@ -1027,7 +1039,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         q_unix = addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         q_unix->path = g_strdup(path);
-    } else {
+    } else if (host) {
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = g_new(InetSocketAddress, 1);
         *addr->u.inet.data = (InetSocketAddress) {
@@ -1040,6 +1052,12 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
             .has_ipv6 = qemu_opt_get(opts, "ipv6"),
             .ipv6 = qemu_opt_get_bool(opts, "ipv6", 0),
         };
+    } else if (fd) {
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
+        addr->u.fd.data = g_new(String, 1);
+        addr->u.fd.data->str = g_strdup(fd);
+    } else {
+        g_assert_not_reached();
     }
     sock->addr = addr;
 }
diff --git a/chardev/char.c b/chardev/char.c
index 2ae4f465ec..9d674855ae 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -798,6 +798,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "port",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "fd",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "localaddr",
             .type = QEMU_OPT_STRING,
diff --git a/tests/test-char.c b/tests/test-char.c
index 7ac25ff73f..e72a20f0c2 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -9,6 +9,7 @@
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
 #include "qmp-commands.h"
+#include "monitor/monitor.h"
 
 static bool quit;
 
@@ -284,9 +285,8 @@ static int socket_can_read_hello(void *opaque)
     return 10;
 }
 
-static void char_socket_test(void)
+static void char_socket_test_common(Chardev *chr)
 {
-    Chardev *chr = qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowait");
     Chardev *chr_client;
     QObject *addr;
     QDict *qdict;
@@ -341,6 +341,169 @@ static void char_socket_test(void)
     object_unparent(OBJECT(chr));
 }
 
+
+static void char_socket_basic_test(void)
+{
+    Chardev *chr = qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowait");
+
+    char_socket_test_common(chr);
+}
+
+
+static int char_socket_listener(void)
+{
+    SocketAddress *addr = g_new0(SocketAddress, 1);
+    int srv;
+
+    addr->type = SOCKET_ADDRESS_TYPE_INET;
+    addr->u.inet.host = g_strdup("127.0.0.1");
+    addr->u.inet.port = g_strdup("0");
+
+    srv = socket_listen(addr, &error_abort);
+    g_assert(srv >= 0);
+
+    qapi_free_SocketAddress(addr);
+    return srv;
+}
+
+
+/* If a monitor is not active (ie cur_mon == NULL), then
+ * we should be able to use fd=<NUMBER> syntax
+ */
+static void char_socket_fdpass_cli_test(void)
+{
+    Chardev *chr;
+    char *optstr;
+    QemuOpts *opts;
+    int fd;
+
+    g_assert_null(cur_mon);
+
+    fd = char_socket_listener();
+
+    optstr = g_strdup_printf("socket,id=cdev,fd=%d,server,nowait", fd);
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                   optstr, true);
+    g_assert_nonnull(opts);
+
+    chr = qemu_chr_new_from_opts(opts, &error_abort);
+
+    qemu_opts_del(opts);
+
+    char_socket_test_common(chr);
+}
+
+
+static int mon_fd = -1;
+
+int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
+{
+    if (mon_fd == -1) {
+        error_setg(errp, "No fd named %s", fdname);
+        return -1;
+    }
+    return mon_fd;
+}
+
+/* Syms in libqemustub.a are discarded at .o file granularity.
+ * To replace monitor_get_fd() we must ensure everything in
+ * stubs/monitor.c is defined, to make sure monitor.o is discarded
+ * otherwise we get duplicate syms at link time.
+ */
+Monitor *cur_mon = NULL;
+void monitor_init(Chardev *chr, int flags) {}
+
+/* If a monitor is active (ie cur_mon != NULL), then
+ * we should be able to use fd=<NAME> syntax
+ */
+static void char_socket_fdpass_mon_test(void)
+{
+    Chardev *chr;
+    const char *optstr;
+    QemuOpts *opts;
+    int fd;
+
+    fd = char_socket_listener();
+    mon_fd = fd;
+    cur_mon = g_malloc(1); /* Pretend we have a mon available */
+
+    optstr = "socket,id=cdev,fd=myfd,server,nowait";
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                   optstr, true);
+    g_assert_nonnull(opts);
+
+    chr = qemu_chr_new_from_opts(opts, &error_abort);
+
+    qemu_opts_del(opts);
+
+    char_socket_test_common(chr);
+    mon_fd = -1;
+    g_free(cur_mon);
+    cur_mon = NULL;
+}
+
+
+/* If a monitor is active (ie cur_mon != NULL), then
+ * we should not allow using fd=<NUMBER> syntax
+ */
+static void char_socket_fdpass_nocli_test(void)
+{
+    Chardev *chr;
+    char *optstr;
+    QemuOpts *opts;
+    int fd;
+    Error *local_err = NULL;
+
+    fd = char_socket_listener();
+    cur_mon = g_malloc(1); /* Pretend we have a mon available */
+
+    optstr = g_strdup_printf("socket,id=cdev,fd=%d,server,nowait", fd);
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                   optstr, true);
+    g_assert_nonnull(opts);
+
+    chr = qemu_chr_new_from_opts(opts, &local_err);
+
+    qemu_opts_del(opts);
+
+    g_assert_nonnull(local_err);
+    g_assert_null(chr);
+    error_free(local_err);
+    g_free(cur_mon);
+    cur_mon = NULL;
+}
+
+
+/* If a monitor is not active (ie cur_mon == NULL), then
+ * we should not allow using fd=<NAME> syntax
+ */
+static void char_socket_fdpass_nomon_test(void)
+{
+    Chardev *chr;
+    const char *optstr;
+    QemuOpts *opts;
+    Error *local_err = NULL;
+
+    g_assert_null(cur_mon);
+    optstr = "socket,id=cdev,fd=myfd,server,nowait";
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                   optstr, true);
+    g_assert_nonnull(opts);
+
+    chr = qemu_chr_new_from_opts(opts, &local_err);
+
+    qemu_opts_del(opts);
+
+    g_assert_nonnull(local_err);
+    g_assert_null(chr);
+    error_free(local_err);
+}
+
+
 #ifndef _WIN32
 static void char_pipe_test(void)
 {
@@ -757,7 +920,11 @@ int main(int argc, char **argv)
 #ifndef _WIN32
     g_test_add_func("/char/file-fifo", char_file_fifo_test);
 #endif
-    g_test_add_func("/char/socket", char_socket_test);
+    g_test_add_func("/char/socket/basic", char_socket_basic_test);
+    g_test_add_func("/char/socket/fdpass/cli", char_socket_fdpass_cli_test);
+    g_test_add_func("/char/socket/fdpass/mon", char_socket_fdpass_mon_test);
+    g_test_add_func("/char/socket/fdpass/nocli", char_socket_fdpass_nocli_test);
+    g_test_add_func("/char/socket/fdpass/nomon", char_socket_fdpass_nomon_test);
     g_test_add_func("/char/udp", char_udp_test);
 #ifdef HAVE_CHARDEV_SERIAL
     g_test_add_func("/char/serial", char_serial_test);
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 1d23f0b742..9400f9a940 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1046,7 +1046,26 @@ int socket_connect(SocketAddress *addr, Error **errp)
         break;
 
     case SOCKET_ADDRESS_TYPE_FD:
-        fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
+        if (cur_mon) {
+            fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
+            if (fd < 0) {
+                return -1;
+            }
+        } else {
+            unsigned long i;
+            if (qemu_strtoul(addr->u.fd.str, NULL, 10, &i) < 0) {
+                error_setg_errno(errp, errno,
+                                 "Unable to parse FD number %s",
+                                 addr->u.fd.str);
+                return -1;
+            }
+            fd = i;
+        }
+        if (!fd_is_socket(fd)) {
+            error_setg(errp, "Expected a socket FD %s", addr->u.fd.str);
+            close(fd);
+            return -1;
+        }
         break;
 
     case SOCKET_ADDRESS_TYPE_VSOCK:
@@ -1073,7 +1092,26 @@ int socket_listen(SocketAddress *addr, Error **errp)
         break;
 
     case SOCKET_ADDRESS_TYPE_FD:
-        fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
+        if (cur_mon) {
+            fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
+            if (fd < 0) {
+                return -1;
+            }
+        } else {
+            unsigned long i;
+            if (qemu_strtoul(addr->u.fd.str, NULL, 10, &i) < 0) {
+                error_setg_errno(errp, errno,
+                                 "Unable to parse FD number %s",
+                                 addr->u.fd.str);
+                return -1;
+            }
+            fd = i;
+        }
+        if (!fd_is_socket(fd)) {
+            error_setg(errp, "Expected a socket FD %s", addr->u.fd.str);
+            close(fd);
+            return -1;
+        }
         break;
 
     case SOCKET_ADDRESS_TYPE_VSOCK:
-- 
2.14.3
