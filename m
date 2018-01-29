Received: from eggs.gnu.org ([2001:4830:134:3::10]:46393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1egEt5-0005zS-Ck
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1egEt0-000075-Cr
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:39 -0500
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 30 Jan 2018 03:13:42 +0800
Message-Id: <1517253224-14361-3-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC 2/4] qemu-socket: Allow custom socket options in
 socket_connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Sheepdog" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

Currently, socket_connect doesn't allow custom socket options,
which is inconvenient when the caller wants a different kind of
socket from that the socket_connect provides. This patch allows
custom config in socket_connect by providing an extra parameter.
Existing functions can just pass a NULL pointer.

Note the caller who wants a non-blocking socket should always
check the errno after socket_connect returns to see if the
connection is really established or still inprogress.

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 block/sheepdog.c       |  2 +-
 block/ssh.c            |  2 +-
 include/qemu/sockets.h |  5 +--
 io/channel-socket.c    |  2 +-
 util/qemu-sockets.c    | 82 ++++++++++++++++++++++++++++++++++++++++----------
 5 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index f684477..f96e091 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -591,7 +591,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
 {
     int fd;
 
-    fd = socket_connect(s->addr, errp);
+    fd = socket_connect(s->addr, errp, NULL);
 
     if (s->addr->type == SOCKET_ADDRESS_TYPE_INET && fd >= 0) {
         int ret = socket_set_nodelay(fd);
diff --git a/block/ssh.c b/block/ssh.c
index b049a16..c9d00c8 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -678,7 +678,7 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
     }
 
     /* Open the socket and connect. */
-    s->sock = inet_connect_saddr(s->inet, errp);
+    s->sock = inet_connect_saddr(s->inet, errp, NULL);
     if (s->sock < 0) {
         ret = -EIO;
         goto err;
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index ab06943..13d6716 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -46,7 +46,8 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
                                 Error **errp);
 int inet_parse(InetSocketAddress *addr, const char *str, Error **errp);
 int inet_connect(const char *str, Error **errp);
-int inet_connect_saddr(InetSocketAddress *saddr, Error **errp);
+int inet_connect_saddr(InetSocketAddress *saddr, Error **errp,
+                       QemuSocketConfig *sconf);
 
 NetworkAddressFamily inet_netfamily(int family);
 
@@ -54,7 +55,7 @@ int unix_listen(const char *path, Error **errp);
 int unix_connect(const char *path, Error **errp);
 
 SocketAddress *socket_parse(const char *str, Error **errp);
-int socket_connect(SocketAddress *addr, Error **errp);
+int socket_connect(SocketAddress *addr, Error **errp, QemuSocketConfig *sconf);
 int socket_listen(SocketAddress *addr, Error **errp, QemuSocketConfig *sconf);
 void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 9942cf0..f010a8e 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -140,7 +140,7 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
     int fd;
 
     trace_qio_channel_socket_connect_sync(ioc, addr);
-    fd = socket_connect(addr, errp);
+    fd = socket_connect(addr, errp, NULL);
     if (fd < 0) {
         trace_qio_channel_socket_connect_fail(ioc);
         return -1;
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b171f23..3a10206 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -372,9 +372,11 @@ listen_ok:
     ((rc) == -EINPROGRESS)
 #endif
 
-static int inet_connect_addr(struct addrinfo *addr, Error **errp);
+static int inet_connect_addr(struct addrinfo *addr, Error **errp,
+                             QemuSocketConfig *sconf);
 
-static int inet_connect_addr(struct addrinfo *addr, Error **errp)
+static int inet_connect_addr(struct addrinfo *addr, Error **errp,
+                             QemuSocketConfig *sconf)
 {
     int sock, rc;
 
@@ -385,12 +387,26 @@ static int inet_connect_addr(struct addrinfo *addr, Error **errp)
     }
     socket_set_fast_reuse(sock);
 
+    if(parse_socket_options(sock, errp, sconf) < 0) {
+        error_setg_errno(errp, errno, "Failed to set socket options");
+        return -1;
+    }
+
     /* connect to peer */
     do {
         rc = 0;
         if (connect(sock, addr->ai_addr, addr->ai_addrlen) < 0) {
             rc = -errno;
         }
+        /* More judge for nonblocking socket, borrowed from net_socket_connect_init */
+        if(sconf->nonblocking) {
+            if(rc == -EWOULDBLOCK)
+                continue;
+            else if(rc == -EINPROGRESS ||
+                    rc == -EALREADY ||
+                    rc == -EINVAL)
+                return sock; /* caller needs tp judge errno */
+        }
     } while (rc == -EINTR);
 
     if (rc < 0) {
@@ -459,7 +475,8 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
  *
  * Returns: -1 on error, file descriptor on success.
  */
-int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
+int inet_connect_saddr(InetSocketAddress *saddr, Error **errp,
+                       QemuSocketConfig *sconf)
 {
     Error *local_err = NULL;
     struct addrinfo *res, *e;
@@ -473,7 +490,7 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
     for (e = res; e != NULL; e = e->ai_next) {
         error_free(local_err);
         local_err = NULL;
-        sock = inet_connect_addr(e, &local_err);
+        sock = inet_connect_addr(e, &local_err, sconf);
         if (sock >= 0) {
             break;
         }
@@ -661,7 +678,7 @@ int inet_connect(const char *str, Error **errp)
     InetSocketAddress *addr = g_new(InetSocketAddress, 1);
 
     if (!inet_parse(addr, str, errp)) {
-        sock = inet_connect_saddr(addr, errp);
+        sock = inet_connect_saddr(addr, errp, NULL);
     }
     qapi_free_InetSocketAddress(addr);
     return sock;
@@ -694,7 +711,8 @@ static bool vsock_parse_vaddr_to_sockaddr(const VsockSocketAddress *vaddr,
     return true;
 }
 
-static int vsock_connect_addr(const struct sockaddr_vm *svm, Error **errp)
+static int vsock_connect_addr(const struct sockaddr_vm *svm, Error **errp,
+                              QemuSocketConfig *sconf)
 {
     int sock, rc;
 
@@ -704,12 +722,25 @@ static int vsock_connect_addr(const struct sockaddr_vm *svm, Error **errp)
         return -1;
     }
 
+    if(parse_socket_options(sock, errp, sconf) < 0) {
+        error_setg_errno(errp, errno, "Failed to set socket option");
+        return -1;
+    }
+
     /* connect to peer */
     do {
         rc = 0;
         if (connect(sock, (const struct sockaddr *)svm, sizeof(*svm)) < 0) {
             rc = -errno;
         }
+        if(sconf->nonblocking) {
+            if(rc == -EWOULDBLOCK)
+                continue;
+            else if(rc == -EINPROGRESS ||
+                    rc == -EALREADY ||
+                    rc == -EINVAL)
+                return sock;
+        }
     } while (rc == -EINTR);
 
     if (rc < 0) {
@@ -721,7 +752,8 @@ static int vsock_connect_addr(const struct sockaddr_vm *svm, Error **errp)
     return sock;
 }
 
-static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
+static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp,\
+                               QemuSocketConfig *sconf)
 {
     struct sockaddr_vm svm;
     int sock = -1;
@@ -730,7 +762,7 @@ static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
         return -1;
     }
 
-    sock = vsock_connect_addr(&svm, errp);
+    sock = vsock_connect_addr(&svm, errp, sconf);
 
     return sock;
 }
@@ -798,7 +830,8 @@ static void vsock_unsupported(Error **errp)
     error_setg(errp, "socket family AF_VSOCK unsupported");
 }
 
-static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
+static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp,
+                               QemuSocketConfig *sconf)
 {
     vsock_unsupported(errp);
     return -1;
@@ -903,7 +936,8 @@ err:
     return -1;
 }
 
-static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
+static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp,
+                              QemuSocketConfig *sconf)
 {
     struct sockaddr_un un;
     int sock, rc;
@@ -919,6 +953,11 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
         return -1;
     }
 
+    if(parse_socket_options(sock, errp, sconf) < 0) {
+        error_setg_errno(errp, errno, "Failed to set socket options");
+        return -1;
+    }
+
     if (strlen(saddr->path) > sizeof(un.sun_path)) {
         error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
@@ -936,6 +975,15 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
         if (connect(sock, (struct sockaddr *) &un, sizeof(un)) < 0) {
             rc = -errno;
         }
+        /* More judge for nonblocking socket, borrowed from net_socket_connect_init */
+        if(sconf->nonblocking) {
+            if(rc == -EWOULDBLOCK)
+                continue;
+            else if(rc == -EINPROGRESS ||
+                    rc == -EALREADY ||
+                    rc == -EINVAL)
+                break;
+        }
     } while (rc == -EINTR);
 
     if (rc < 0) {
@@ -962,7 +1010,8 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     return -1;
 }
 
-static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
+static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp,
+                              QemuSocketConfig *sconf)
 {
     error_setg(errp, "unix sockets are not available on windows");
     errno = ENOTSUP;
@@ -1004,7 +1053,7 @@ int unix_connect(const char *path, Error **errp)
 
     saddr = g_new0(UnixSocketAddress, 1);
     saddr->path = g_strdup(path);
-    sock = unix_connect_saddr(saddr, errp);
+    sock = unix_connect_saddr(saddr, errp, NULL);
     qapi_free_UnixSocketAddress(saddr);
     return sock;
 }
@@ -1049,17 +1098,18 @@ fail:
     return NULL;
 }
 
-int socket_connect(SocketAddress *addr, Error **errp)
+int socket_connect(SocketAddress *addr, Error **errp,
+                   QemuSocketConfig *sconf)
 {
     int fd;
 
     switch (addr->type) {
     case SOCKET_ADDRESS_TYPE_INET:
-        fd = inet_connect_saddr(&addr->u.inet, errp);
+        fd = inet_connect_saddr(&addr->u.inet, errp, sconf);
         break;
 
     case SOCKET_ADDRESS_TYPE_UNIX:
-        fd = unix_connect_saddr(&addr->u.q_unix, errp);
+        fd = unix_connect_saddr(&addr->u.q_unix, errp, sconf);
         break;
 
     case SOCKET_ADDRESS_TYPE_FD:
@@ -1067,7 +1117,7 @@ int socket_connect(SocketAddress *addr, Error **errp)
         break;
 
     case SOCKET_ADDRESS_TYPE_VSOCK:
-        fd = vsock_connect_saddr(&addr->u.vsock, errp);
+        fd = vsock_connect_saddr(&addr->u.vsock, errp, sconf);
         break;
 
     default:
-- 
2.7.4
