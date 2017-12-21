Received: from eggs.gnu.org ([2001:4830:134:3::10]:53242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS0so-0006lN-Oh
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:27:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS0sn-0004jR-4U
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:27:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eS0sm-0004iO-Rh
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:27:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 08560624DF
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 13:27:32 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 21 Dec 2017 13:27:17 +0000
Message-Id: <20171221132717.30284-3-berrange@redhat.com>
In-Reply-To: <20171221132717.30284-1-berrange@redhat.com>
References: <20171221132717.30284-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/2] char: allow passing pre-opened socket
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
the 'getfd' command, but only when using QMP JSON syntax. The HMP syntax has
no way to initialize the SocketAddress(Legacy) 'fd' variant. So this patch
first wires up the 'fd' parameter to refer to a monitor file descriptor,
allowing HMP to use

   getfd myfd
   chardev-add socket,fd=myfd

The SocketAddress 'fd' variant is currently tied to the use of the monitor
'getfd' command, so we have a chicken & egg problem with reusing that at
startup wher no monitor connection is available. We could define that the
special fd name prefix '/dev/fdset' refers to a FD passed via the CLI, but
magic strings feel unpleasant.

Instead we define a SocketAddress 'fdset' variant that takes an fd set number
that works in combination with the 'add-fd' command line argument. e.g.

  -add-fd fd=3,set=1
  -chardev socket,fdset=1,id=mon
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
      "-add-fd", "fd=$fd,set=1", \
      "-chardev", "socket,fdset=1,server,nowait,id=mon", \
      "-mon", "chardev=mon,mode=control";

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c | 66 +++++++++++++++++++++++++++++++++++++++++++++------
 chardev/char.c        |  6 +++++
 monitor.c             |  5 ++++
 qapi/common.json      | 11 +++++++++
 qapi/sockets.json     | 14 ++++++++---
 util/qemu-sockets.c   | 36 ++++++++++++++++++++++++++++
 6 files changed, 128 insertions(+), 10 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 6013972f72..c85298589f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -28,6 +28,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
+#include "qemu/cutils.h"
 
 #include "chardev/char-io.h"
 
@@ -372,6 +373,10 @@ static char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
         return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.str,
                                is_listen ? ",server" : "");
         break;
+    case SOCKET_ADDRESS_TYPE_FDSET:
+        return g_strdup_printf("%sfdset:%" PRId64 "%s", prefix, addr->u.fdset.i,
+                               is_listen ? ",server" : "");
+        break;
     case SOCKET_ADDRESS_TYPE_VSOCK:
         return g_strdup_printf("%svsock:%s:%s", prefix,
                                addr->u.vsock.cid,
@@ -983,25 +988,62 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     const char *path = qemu_opt_get(opts, "path");
     const char *host = qemu_opt_get(opts, "host");
     const char *port = qemu_opt_get(opts, "port");
+    const char *fd = qemu_opt_get(opts, "fd");
+    const char *fdset = qemu_opt_get(opts, "fdset");
+    int64_t fdseti;
     const char *tls_creds = qemu_opt_get(opts, "tls-creds");
     SocketAddressLegacy *addr;
     ChardevSocket *sock;
+    int num = 0;
+
+    if (path) {
+        num++;
+    }
+    if (fd) {
+        num++;
+    }
+    if (fdset) {
+        num++;
+    }
+    if (host) {
+        num++;
+    }
+    if (num != 1) {
+        error_setg(errp,
+                   "Exactly one of 'path', 'fd', 'fdset' or 'host' required");
+        return;
+    }
 
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
+            return;
+        }
+    } else if (fdset) {
+        /* We don't know what host to validate against when in client mode */
+        if (tls_creds && !is_listen) {
+            error_setg(errp, "TLS can not be used with pre-opened client FD");
             return;
         }
+        if (qemu_strtoi64(fdset, NULL, 10, &fdseti) < 0) {
+            error_setg_errno(errp, errno,
+                             "Cannot parse fd set number %s", fdset);
+            return;
+        }
+    } else {
+        g_assert_not_reached();
     }
 
     sock = backend->u.socket.data = g_new0(ChardevSocket, 1);
@@ -1027,7 +1069,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         q_unix = addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         q_unix->path = g_strdup(path);
-    } else {
+    } else if (host) {
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = g_new(InetSocketAddress, 1);
         *addr->u.inet.data = (InetSocketAddress) {
@@ -1040,6 +1082,16 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
             .has_ipv6 = qemu_opt_get(opts, "ipv6"),
             .ipv6 = qemu_opt_get_bool(opts, "ipv6", 0),
         };
+    } else if (fd) {
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
+        addr->u.fd.data = g_new(String, 1);
+        addr->u.fd.data->str = g_strdup(fd);
+    } else if (fdset) {
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_FDSET;
+        addr->u.fdset.data = g_new(Int, 1);
+        addr->u.fdset.data->i = fdseti;
+    } else {
+        g_assert_not_reached();
     }
     sock->addr = addr;
 }
diff --git a/chardev/char.c b/chardev/char.c
index 2ae4f465ec..db940fc40f 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -798,6 +798,12 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "port",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "fd",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "fdset",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "localaddr",
             .type = QEMU_OPT_STRING,
diff --git a/monitor.c b/monitor.c
index d682eee2d8..c7df558535 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1962,6 +1962,11 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
 
+    if (mon == NULL) {
+        error_setg(errp, "No monitor is available to acquire FD");
+        return -1;
+    }
+
     QLIST_FOREACH(monfd, &mon->fds, next) {
         int fd;
 
diff --git a/qapi/common.json b/qapi/common.json
index 6eb01821ef..a15cdc36e9 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -74,6 +74,17 @@
 { 'enum': 'OnOffSplit',
   'data': [ 'on', 'off', 'split' ] }
 
+##
+# @Int:
+#
+# A fat type wrapping 'int', to be embedded in lists.
+#
+# Since: 2.12
+##
+{ 'struct': 'Int',
+  'data': {
+    'i': 'int' } }
+
 ##
 # @String:
 #
diff --git a/qapi/sockets.json b/qapi/sockets.json
index ac022c6ad0..f3cac02166 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -112,7 +112,8 @@
     'inet': 'InetSocketAddress',
     'unix': 'UnixSocketAddress',
     'vsock': 'VsockSocketAddress',
-    'fd': 'String' } }
+    'fd': 'String',
+    'fdset': 'Int' } }
 
 ##
 # @SocketAddressType:
@@ -123,10 +124,16 @@
 #
 # @unix:  Unix domain socket
 #
+# @vsock: VSOCK socket
+#
+# @fd: socket file descriptor passed over monitor
+#
+# @fdset: socket file descriptor passed via CLI (since 2.12)
+#
 # Since: 2.9
 ##
 { 'enum': 'SocketAddressType',
-  'data': [ 'inet', 'unix', 'vsock', 'fd' ] }
+  'data': [ 'inet', 'unix', 'vsock', 'fd', 'fdset' ] }
 
 ##
 # @SocketAddress:
@@ -144,4 +151,5 @@
   'data': { 'inet': 'InetSocketAddress',
             'unix': 'UnixSocketAddress',
             'vsock': 'VsockSocketAddress',
-            'fd': 'String' } }
+            'fd': 'String',
+            'fdset': 'Int' } }
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 1d23f0b742..d623a9840c 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1049,6 +1049,22 @@ int socket_connect(SocketAddress *addr, Error **errp)
         fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
         break;
 
+    case SOCKET_ADDRESS_TYPE_FDSET:
+        fd = monitor_fdset_get_fd(addr->u.fdset.i, O_RDWR);
+        if (fd < 0) {
+            error_setg_errno(errp, errno,
+                             "Unable to get FD from fdset %" PRId64,
+                             addr->u.fdset.i);
+            return -1;
+        }
+        if (!fd_is_socket(fd)) {
+            error_setg(errp, "Expected a socket FD from fdset %" PRId64,
+                       addr->u.fdset.i);
+            close(fd);
+            return -1;
+        }
+        break;
+
     case SOCKET_ADDRESS_TYPE_VSOCK:
         fd = vsock_connect_saddr(&addr->u.vsock, errp);
         break;
@@ -1076,6 +1092,22 @@ int socket_listen(SocketAddress *addr, Error **errp)
         fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
         break;
 
+    case SOCKET_ADDRESS_TYPE_FDSET:
+        fd = monitor_fdset_get_fd(addr->u.fdset.i, O_RDWR);
+        if (fd < 0) {
+            error_setg_errno(errp, errno,
+                             "Unable to get FD from fdset %" PRId64,
+                             addr->u.fdset.i);
+            return -1;
+        }
+        if (!fd_is_socket(fd)) {
+            error_setg(errp, "Expected a socket FD from fdset %" PRId64,
+                       addr->u.fdset.i);
+            close(fd);
+            return -1;
+        }
+        break;
+
     case SOCKET_ADDRESS_TYPE_VSOCK:
         fd = vsock_listen_saddr(&addr->u.vsock, errp);
         break;
@@ -1293,6 +1325,10 @@ SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
         addr->type = SOCKET_ADDRESS_TYPE_FD;
         QAPI_CLONE_MEMBERS(String, &addr->u.fd, addr_legacy->u.fd.data);
         break;
+    case SOCKET_ADDRESS_LEGACY_KIND_FDSET:
+        addr->type = SOCKET_ADDRESS_TYPE_FDSET;
+        QAPI_CLONE_MEMBERS(Int, &addr->u.fdset, addr_legacy->u.fdset.data);
+        break;
     default:
         abort();
     }
-- 
2.14.3
