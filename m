Received: from eggs.gnu.org ([2001:4830:134:3::10]:39772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evTp4-0004I5-5S
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evTp2-00078x-Ni
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:13:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32806 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evTp2-00078g-IE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:13:28 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 12 Mar 2018 20:13:05 +0000
Message-Id: <20180312201305.16972-10-berrange@redhat.com>
In-Reply-To: <20180312201305.16972-1-berrange@redhat.com>
References: <20180312201305.16972-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] char: allow passing pre-opened socket file
 descriptor at startup
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

When starting QEMU management apps will usually setup a monitor socket, and
then open it immediately after startup. If not using QEMU's own -daemonize
arg, this process can be troublesome to handle correctly. The mgmt app will
need to repeatedly call connect() until it succeeds, because it does not
know when QEMU has created the listener socket. If can't retry connect()
forever though, because an error might have caused QEMU to exit before it
even creates the monitor.

The obvious way to fix this kind of problem is to just pass in a pre-opened
socket file descriptor for the QEMU monitor to listen on. The management
app can now immediately call connect() just once. If connect() fails it
knows that QEMU has exited with an error.

The SocketAddress(Legacy) structs allow for FD passing via the monitor, and
now via inherited file descriptors from the process that spawned QEMU. The
final missing piece is adding a 'fd' parameter in the socket chardev
options.

This allows both HMP usage, pass any FD number with SCM_RIGHTS, then
running HMP commands:

   getfd myfd
   chardev-add socket,fd=myfd

Note that numeric FDs cannot be referenced directly in HMP, only named FDs.

And also CLI usage, by leak FD 3 from parent by clearing O_CLOEXEC, then
spawning QEMU with

  -chardev socket,fd=3,id=mon
  -mon chardev=mon,mode=control

Note that named FDs cannot be referenced in CLI args, only numeric FDs.

We do not wire this up in the legacy chardev syntax, so you cannot use FD
passing with '-qmp', you must use the modern '-mon' + '-chardev' pair.

When passing pre-opened FDs there is a restriction on use of TLS encryption.
It can be used on a server socket chardev, but cannot be used for a client
socket chardev. This is because when validating a server's certificate, the
client needs to have a hostname available to match against the certificate
identity.

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

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c | 15 +++++++++++++--
 chardev/char.c        |  3 +++
 tests/test-char.c     | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a916ef4012..0c8d6d430a 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1008,13 +1008,14 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     const char *path = qemu_opt_get(opts, "path");
     const char *host = qemu_opt_get(opts, "host");
     const char *port = qemu_opt_get(opts, "port");
+    const char *fd = qemu_opt_get(opts, "fd");
     const char *tls_creds = qemu_opt_get(opts, "tls-creds");
     SocketAddressLegacy *addr;
     ChardevSocket *sock;
 
-    if ((!!path + !!host) != 1) {
+    if ((!!path + !!fd + !!host) != 1) {
         error_setg(errp,
-                   "Exactly one of 'path' or 'host' required");
+                   "Exactly one of 'path', 'fd' or 'host' required");
         return;
     }
 
@@ -1029,6 +1030,12 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
             error_setg(errp, "chardev: socket: no port given");
             return;
         }
+    } else if (fd) {
+        /* We don't know what host to validate against when in client mode */
+        if (tls_creds && !is_listen) {
+            error_setg(errp, "TLS can not be used with pre-opened client FD");
+            return;
+        }
     } else {
         g_assert_not_reached();
     }
@@ -1069,6 +1076,10 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
             .has_ipv6 = qemu_opt_get(opts, "ipv6"),
             .ipv6 = qemu_opt_get_bool(opts, "ipv6", 0),
         };
+    } else if (fd) {
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
+        addr->u.fd.data = g_new(String, 1);
+        addr->u.fd.data->str = g_strdup(fd);
     } else {
         g_assert_not_reached();
     }
diff --git a/chardev/char.c b/chardev/char.c
index 5d7b079ef0..f7e0d37f24 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -807,6 +807,9 @@ QemuOptsList qemu_chardev_opts = {
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
index b3a77af085..dffb354202 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -302,9 +302,8 @@ static int socket_can_read_hello(void *opaque)
     return 10;
 }
 
-static void char_socket_test(void)
+static void char_socket_test_common(Chardev *chr)
 {
-    Chardev *chr = qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowait");
     Chardev *chr_client;
     QObject *addr;
     QDict *qdict;
@@ -359,6 +358,47 @@ static void char_socket_test(void)
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
+static void char_socket_fdpass_test(void)
+{
+    Chardev *chr;
+    char *optstr;
+    QemuOpts *opts;
+    int fd;
+    SocketAddress *addr = g_new0(SocketAddress, 1);
+
+    addr->type = SOCKET_ADDRESS_TYPE_INET;
+    addr->u.inet.host = g_strdup("127.0.0.1");
+    addr->u.inet.port = g_strdup("0");
+
+    fd = socket_listen(addr, &error_abort);
+    g_assert(fd >= 0);
+
+    qapi_free_SocketAddress(addr);
+
+    optstr = g_strdup_printf("socket,id=cdev,fd=%d,server,nowait", fd);
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                   optstr, true);
+    g_free(optstr);
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
 #ifndef _WIN32
 static void char_pipe_test(void)
 {
@@ -775,7 +815,8 @@ int main(int argc, char **argv)
 #ifndef _WIN32
     g_test_add_func("/char/file-fifo", char_file_fifo_test);
 #endif
-    g_test_add_func("/char/socket", char_socket_test);
+    g_test_add_func("/char/socket/basic", char_socket_basic_test);
+    g_test_add_func("/char/socket/fdpass", char_socket_fdpass_test);
     g_test_add_func("/char/udp", char_udp_test);
 #ifdef HAVE_CHARDEV_SERIAL
     g_test_add_func("/char/serial", char_serial_test);
-- 
2.14.3
