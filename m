Received: from eggs.gnu.org ([2001:4830:134:3::10]:47081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dLn4U-0004WQ-3z
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dLn4S-0006BJ-52
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:57:38 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 16 Jun 2017 16:54:45 +0800
Message-ID: <7fb8c9ff25d183cf7c0f729a90ee4f59c0632d64.1497602554.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] util: remove the obsolete non-blocking
 connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org, sheepdog@lists.wpkg.org, famz@redhat.com, quintela@redhat.com, Cao jin <caoj.fnst@cn.fujitsu.com>

From: Cao jin <caoj.fnst@cn.fujitsu.com>

The non-blocking connect mechanism is obsolete, and it doesn't
work well in inet connection, because it will call getaddrinfo
first and getaddrinfo will blocks on DNS lookups. Since commit
e65c67e4 & d984464e, the non-blocking connect of migration goes
through QIOChannel in a different manner(using a thread), and
nobody use this old non-blocking connect anymore.

Any newly written code which needs a non-blocking connect should
use the QIOChannel code, so we can drop NonBlockingConnectHandler
as a concept entirely.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
v3:
1. fix the mistake that adds a unmodified file '--help' [Fam Zheng]

v2:
1. block/ssh.c is not compiled in v1 which leads to no error
   reported when I run make & make check, although I make a
	mistake in block/ssh.c, because the package libssh2-devel
	missed in my system. Now fixed it.
2. Write the prototype in a single line. [Juan Quintela]

Because it's a minor change, so still add the r-b.

v1:
This patch was reviewed by Daniel about a years ago, but it has never
been merged just since socket_connect() called by net_socket_connect_init()
where NonBlockingConnectHandler was passed to socket_connect(). it's broken.

Now this problem was worked around by Daniel's patch(commit 6701e551 'Revert
"Change net/socket.c to use socket_*() functions" again'). Therefore, resend
it, of course, part of related code has changed over the years, so changed
the patch accordingly.

The reviewed patch listed on:
https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg06373.html

 block/sheepdog.c       |   2 +-
 block/ssh.c            |   2 +-
 include/qemu/sockets.h |  12 +--
 io/channel-socket.c    |   2 +-
 util/qemu-sockets.c    | 205 ++++++-------------------------------------------
 5 files changed, 28 insertions(+), 195 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index a18315a..97e6c96 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -589,7 +589,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
 {
     int fd;
 
-    fd = socket_connect(s->addr, NULL, NULL, errp);
+    fd = socket_connect(s->addr, errp);
 
     if (s->addr->type == SOCKET_ADDRESS_TYPE_INET && fd >= 0) {
         int ret = socket_set_nodelay(fd);
diff --git a/block/ssh.c b/block/ssh.c
index 11203fc..d6a82ae 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -679,7 +679,7 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
     }
 
     /* Open the socket and connect. */
-    s->sock = inet_connect_saddr(s->inet, NULL, NULL, errp);
+    s->sock = inet_connect_saddr(s->inet, errp);
     if (s->sock < 0) {
         ret = -EIO;
         goto err;
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 5c326db..dce0e41 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -27,18 +27,11 @@ int socket_set_fast_reuse(int fd);
 #define SHUT_RDWR 2
 #endif
 
-/* callback function for nonblocking connect
- * valid fd on success, negative error code on failure
- */
-typedef void NonBlockingConnectHandler(int fd, Error *err, void *opaque);
-
 int inet_ai_family_from_address(InetSocketAddress *addr,
                                 Error **errp);
 int inet_parse(InetSocketAddress *addr, const char *str, Error **errp);
 int inet_connect(const char *str, Error **errp);
-int inet_connect_saddr(InetSocketAddress *saddr,
-                       NonBlockingConnectHandler *callback, void *opaque,
-                       Error **errp);
+int inet_connect_saddr(InetSocketAddress *saddr, Error **errp);
 
 NetworkAddressFamily inet_netfamily(int family);
 
@@ -46,8 +39,7 @@ int unix_listen(const char *path, char *ostr, int olen, Error **errp);
 int unix_connect(const char *path, Error **errp);
 
 SocketAddress *socket_parse(const char *str, Error **errp);
-int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
-                   void *opaque, Error **errp);
+int socket_connect(SocketAddress *addr, Error **errp);
 int socket_listen(SocketAddress *addr, Error **errp);
 void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 53386b7..05ea120 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -140,7 +140,7 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
     int fd;
 
     trace_qio_channel_socket_connect_sync(ioc, addr);
-    fd = socket_connect(addr, NULL, NULL, errp);
+    fd = socket_connect(addr, errp);
     if (fd < 0) {
         trace_qio_channel_socket_connect_fail(ioc);
         return -1;
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 82290cb..af14f33 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -263,88 +263,19 @@ listen:
     ((rc) == -EINPROGRESS)
 #endif
 
-/* Struct to store connect state for non blocking connect */
-typedef struct ConnectState {
-    int fd;
-    struct addrinfo *addr_list;
-    struct addrinfo *current_addr;
-    NonBlockingConnectHandler *callback;
-    void *opaque;
-} ConnectState;
-
-static int inet_connect_addr(struct addrinfo *addr, bool *in_progress,
-                             ConnectState *connect_state, Error **errp);
+static int inet_connect_addr(struct addrinfo *addr, Error **errp);
 
-static void wait_for_connect(void *opaque)
-{
-    ConnectState *s = opaque;
-    int val = 0, rc = 0;
-    socklen_t valsize = sizeof(val);
-    bool in_progress;
-    Error *err = NULL;
-
-    qemu_set_fd_handler(s->fd, NULL, NULL, NULL);
-
-    do {
-        rc = qemu_getsockopt(s->fd, SOL_SOCKET, SO_ERROR, &val, &valsize);
-    } while (rc == -1 && errno == EINTR);
-
-    /* update rc to contain error */
-    if (!rc && val) {
-        rc = -1;
-        errno = val;
-    }
-
-    /* connect error */
-    if (rc < 0) {
-        error_setg_errno(&err, errno, "Error connecting to socket");
-        closesocket(s->fd);
-        s->fd = rc;
-    }
-
-    /* try to connect to the next address on the list */
-    if (s->current_addr) {
-        while (s->current_addr->ai_next != NULL && s->fd < 0) {
-            s->current_addr = s->current_addr->ai_next;
-            s->fd = inet_connect_addr(s->current_addr, &in_progress, s, NULL);
-            if (s->fd < 0) {
-                error_free(err);
-                err = NULL;
-                error_setg_errno(&err, errno, "Unable to start socket connect");
-            }
-            /* connect in progress */
-            if (in_progress) {
-                goto out;
-            }
-        }
-
-        freeaddrinfo(s->addr_list);
-    }
-
-    if (s->callback) {
-        s->callback(s->fd, err, s->opaque);
-    }
-    g_free(s);
-out:
-    error_free(err);
-}
-
-static int inet_connect_addr(struct addrinfo *addr, bool *in_progress,
-                             ConnectState *connect_state, Error **errp)
+static int inet_connect_addr(struct addrinfo *addr, Error **errp)
 {
     int sock, rc;
 
-    *in_progress = false;
-
     sock = qemu_socket(addr->ai_family, addr->ai_socktype, addr->ai_protocol);
     if (sock < 0) {
         error_setg_errno(errp, errno, "Failed to create socket");
         return -1;
     }
     socket_set_fast_reuse(sock);
-    if (connect_state != NULL) {
-        qemu_set_nonblock(sock);
-    }
+
     /* connect to peer */
     do {
         rc = 0;
@@ -353,15 +284,12 @@ static int inet_connect_addr(struct addrinfo *addr, bool *in_progress,
         }
     } while (rc == -EINTR);
 
-    if (connect_state != NULL && QEMU_SOCKET_RC_INPROGRESS(rc)) {
-        connect_state->fd = sock;
-        qemu_set_fd_handler(sock, NULL, wait_for_connect, connect_state);
-        *in_progress = true;
-    } else if (rc < 0) {
+    if (rc < 0) {
         error_setg_errno(errp, errno, "Failed to connect socket");
         closesocket(sock);
         return -1;
     }
+
     return sock;
 }
 
@@ -419,44 +347,24 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
  *
  * @saddr: Inet socket address specification
  * @errp: set on error
- * @callback: callback function for non-blocking connect
- * @opaque: opaque for callback function
  *
  * Returns: -1 on error, file descriptor on success.
- *
- * If @callback is non-null, the connect is non-blocking.  If this
- * function succeeds, callback will be called when the connection
- * completes, with the file descriptor on success, or -1 on error.
  */
-int inet_connect_saddr(InetSocketAddress *saddr,
-                       NonBlockingConnectHandler *callback, void *opaque,
-                       Error **errp)
+int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
 {
     Error *local_err = NULL;
     struct addrinfo *res, *e;
     int sock = -1;
-    bool in_progress;
-    ConnectState *connect_state = NULL;
 
     res = inet_parse_connect_saddr(saddr, errp);
     if (!res) {
         return -1;
     }
 
-    if (callback != NULL) {
-        connect_state = g_malloc0(sizeof(*connect_state));
-        connect_state->addr_list = res;
-        connect_state->callback = callback;
-        connect_state->opaque = opaque;
-    }
-
     for (e = res; e != NULL; e = e->ai_next) {
         error_free(local_err);
         local_err = NULL;
-        if (connect_state != NULL) {
-            connect_state->current_addr = e;
-        }
-        sock = inet_connect_addr(e, &in_progress, connect_state, &local_err);
+        sock = inet_connect_addr(e, &local_err);
         if (sock >= 0) {
             break;
         }
@@ -464,15 +372,8 @@ int inet_connect_saddr(InetSocketAddress *saddr,
 
     if (sock < 0) {
         error_propagate(errp, local_err);
-    } else if (in_progress) {
-        /* wait_for_connect() will do the rest */
-        return sock;
-    } else {
-        if (callback) {
-            callback(sock, NULL, opaque);
-        }
     }
-    g_free(connect_state);
+
     freeaddrinfo(res);
     return sock;
 }
@@ -655,7 +556,7 @@ int inet_connect(const char *str, Error **errp)
     InetSocketAddress *addr = g_new(InetSocketAddress, 1);
 
     if (!inet_parse(addr, str, errp)) {
-        sock = inet_connect_saddr(addr, NULL, NULL, errp);
+        sock = inet_connect_saddr(addr, errp);
     }
     qapi_free_InetSocketAddress(addr);
     return sock;
@@ -688,21 +589,16 @@ static bool vsock_parse_vaddr_to_sockaddr(const VsockSocketAddress *vaddr,
     return true;
 }
 
-static int vsock_connect_addr(const struct sockaddr_vm *svm, bool *in_progress,
-                              ConnectState *connect_state, Error **errp)
+static int vsock_connect_addr(const struct sockaddr_vm *svm, Error **errp)
 {
     int sock, rc;
 
-    *in_progress = false;
-
     sock = qemu_socket(AF_VSOCK, SOCK_STREAM, 0);
     if (sock < 0) {
         error_setg_errno(errp, errno, "Failed to create socket");
         return -1;
     }
-    if (connect_state != NULL) {
-        qemu_set_nonblock(sock);
-    }
+
     /* connect to peer */
     do {
         rc = 0;
@@ -711,50 +607,26 @@ static int vsock_connect_addr(const struct sockaddr_vm *svm, bool *in_progress,
         }
     } while (rc == -EINTR);
 
-    if (connect_state != NULL && QEMU_SOCKET_RC_INPROGRESS(rc)) {
-        connect_state->fd = sock;
-        qemu_set_fd_handler(sock, NULL, wait_for_connect, connect_state);
-        *in_progress = true;
-    } else if (rc < 0) {
+    if (rc < 0) {
         error_setg_errno(errp, errno, "Failed to connect socket");
         closesocket(sock);
         return -1;
     }
+
     return sock;
 }
 
-static int vsock_connect_saddr(VsockSocketAddress *vaddr,
-                               NonBlockingConnectHandler *callback,
-                               void *opaque,
-                               Error **errp)
+static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
 {
     struct sockaddr_vm svm;
     int sock = -1;
-    bool in_progress;
-    ConnectState *connect_state = NULL;
 
     if (!vsock_parse_vaddr_to_sockaddr(vaddr, &svm, errp)) {
         return -1;
     }
 
-    if (callback != NULL) {
-        connect_state = g_malloc0(sizeof(*connect_state));
-        connect_state->callback = callback;
-        connect_state->opaque = opaque;
-    }
+    sock = vsock_connect_addr(&svm, errp);
 
-    sock = vsock_connect_addr(&svm, &in_progress, connect_state, errp);
-    if (sock < 0) {
-        /* do nothing */
-    } else if (in_progress) {
-        /* wait_for_connect() will do the rest */
-        return sock;
-    } else {
-        if (callback) {
-            callback(sock, NULL, opaque);
-        }
-    }
-    g_free(connect_state);
     return sock;
 }
 
@@ -814,9 +686,7 @@ static void vsock_unsupported(Error **errp)
     error_setg(errp, "socket family AF_VSOCK unsupported");
 }
 
-static int vsock_connect_saddr(VsockSocketAddress *vaddr,
-                               NonBlockingConnectHandler *callback,
-                               void *opaque, Error **errp)
+static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
 {
     vsock_unsupported(errp);
     return -1;
@@ -919,12 +789,9 @@ err:
     return -1;
 }
 
-static int unix_connect_saddr(UnixSocketAddress *saddr,
-                              NonBlockingConnectHandler *callback, void *opaque,
-                              Error **errp)
+static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 {
     struct sockaddr_un un;
-    ConnectState *connect_state = NULL;
     int sock, rc;
 
     if (saddr->path == NULL) {
@@ -937,12 +804,6 @@ static int unix_connect_saddr(UnixSocketAddress *saddr,
         error_setg_errno(errp, errno, "Failed to create socket");
         return -1;
     }
-    if (callback != NULL) {
-        connect_state = g_malloc0(sizeof(*connect_state));
-        connect_state->callback = callback;
-        connect_state->opaque = opaque;
-        qemu_set_nonblock(sock);
-    }
 
     if (strlen(saddr->path) > sizeof(un.sun_path)) {
         error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
@@ -963,29 +824,16 @@ static int unix_connect_saddr(UnixSocketAddress *saddr,
         }
     } while (rc == -EINTR);
 
-    if (connect_state != NULL && QEMU_SOCKET_RC_INPROGRESS(rc)) {
-        connect_state->fd = sock;
-        qemu_set_fd_handler(sock, NULL, wait_for_connect, connect_state);
-        return sock;
-    } else if (rc >= 0) {
-        /* non blocking socket immediate success, call callback */
-        if (callback != NULL) {
-            callback(sock, NULL, opaque);
-        }
-    }
-
     if (rc < 0) {
         error_setg_errno(errp, -rc, "Failed to connect socket %s",
                          saddr->path);
         goto err;
     }
 
-    g_free(connect_state);
     return sock;
 
  err:
     close(sock);
-    g_free(connect_state);
     return -1;
 }
 
@@ -1000,9 +848,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     return -1;
 }
 
-static int unix_connect_saddr(UnixSocketAddress *saddr,
-                              NonBlockingConnectHandler *callback, void *opaque,
-                              Error **errp)
+static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 {
     error_setg(errp, "unix sockets are not available on windows");
     errno = ENOTSUP;
@@ -1048,7 +894,7 @@ int unix_connect(const char *path, Error **errp)
 
     saddr = g_new0(UnixSocketAddress, 1);
     saddr->path = g_strdup(path);
-    sock = unix_connect_saddr(saddr, NULL, NULL, errp);
+    sock = unix_connect_saddr(saddr, errp);
     qapi_free_UnixSocketAddress(saddr);
     return sock;
 }
@@ -1093,30 +939,25 @@ fail:
     return NULL;
 }
 
-int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
-                   void *opaque, Error **errp)
+int socket_connect(SocketAddress *addr, Error **errp)
 {
     int fd;
 
     switch (addr->type) {
     case SOCKET_ADDRESS_TYPE_INET:
-        fd = inet_connect_saddr(&addr->u.inet, callback, opaque, errp);
+        fd = inet_connect_saddr(&addr->u.inet, errp);
         break;
 
     case SOCKET_ADDRESS_TYPE_UNIX:
-        fd = unix_connect_saddr(&addr->u.q_unix, callback, opaque, errp);
+        fd = unix_connect_saddr(&addr->u.q_unix, errp);
         break;
 
     case SOCKET_ADDRESS_TYPE_FD:
         fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
-        if (fd >= 0 && callback) {
-            qemu_set_nonblock(fd);
-            callback(fd, NULL, opaque);
-        }
         break;
 
     case SOCKET_ADDRESS_TYPE_VSOCK:
-        fd = vsock_connect_saddr(&addr->u.vsock, callback, opaque, errp);
+        fd = vsock_connect_saddr(&addr->u.vsock, errp);
         break;
 
     default:
-- 
2.9.3
