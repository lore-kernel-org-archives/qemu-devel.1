Received: from eggs.gnu.org ([2001:4830:134:3::10]:41236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA4H-0001EE-NN
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA4B-0002lO-Kj
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpA4B-0002kR-Bi
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:43 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 10:22:27 +0100
Message-Id: <20170905092230.8243-7-berrange@redhat.com>
In-Reply-To: <20170905092230.8243-1-berrange@redhat.com>
References: <20170905092230.8243-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 6/9] util: remove the obsolete non-blocking
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cao jin <caoj.fnst@cn.fujitsu.com>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, "Daniel P . Berrange" <berrange@redhat.com>

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
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/sheepdog.c       |   2 +-
 block/ssh.c            |   2 +-
 include/qemu/sockets.h |  12 +--
 io/channel-socket.c    |   2 +-
 util/qemu-sockets.c    | 205 ++++++-------------------------------------------
 5 files changed, 28 insertions(+), 195 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index abb2e79065..64ab07f3b7 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -591,7 +591,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
 {
     int fd;
 
-    fd = socket_connect(s->addr, NULL, NULL, errp);
+    fd = socket_connect(s->addr, errp);
 
     if (s->addr->type == SOCKET_ADDRESS_TYPE_INET && fd >= 0) {
         int ret = socket_set_nodelay(fd);
diff --git a/block/ssh.c b/block/ssh.c
index e8f0404c03..b049a16eb9 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -678,7 +678,7 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
     }
 
     /* Open the socket and connect. */
-    s->sock = inet_connect_saddr(s->inet, NULL, NULL, errp);
+    s->sock = inet_connect_saddr(s->inet, errp);
     if (s->sock < 0) {
         ret = -EIO;
         goto err;
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index ef6b5591f7..639cc079d9 100644
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
index 591d27e8c3..563e297357 100644
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
index 6a511fbf76..b47fb45885 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -342,88 +342,19 @@ listen_ok:
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
@@ -432,15 +363,12 @@ static int inet_connect_addr(struct addrinfo *addr, bool *in_progress,
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
 
@@ -498,44 +426,24 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
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
@@ -543,15 +451,8 @@ int inet_connect_saddr(InetSocketAddress *saddr,
 
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
@@ -730,7 +631,7 @@ int inet_connect(const char *str, Error **errp)
     InetSocketAddress *addr = g_new(InetSocketAddress, 1);
 
     if (!inet_parse(addr, str, errp)) {
-        sock = inet_connect_saddr(addr, NULL, NULL, errp);
+        sock = inet_connect_saddr(addr, errp);
     }
     qapi_free_InetSocketAddress(addr);
     return sock;
@@ -763,21 +664,16 @@ static bool vsock_parse_vaddr_to_sockaddr(const VsockSocketAddress *vaddr,
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
@@ -786,50 +682,26 @@ static int vsock_connect_addr(const struct sockaddr_vm *svm, bool *in_progress,
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
 
@@ -889,9 +761,7 @@ static void vsock_unsupported(Error **errp)
     error_setg(errp, "socket family AF_VSOCK unsupported");
 }
 
-static int vsock_connect_saddr(VsockSocketAddress *vaddr,
-                               NonBlockingConnectHandler *callback,
-                               void *opaque, Error **errp)
+static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
 {
     vsock_unsupported(errp);
     return -1;
@@ -994,12 +864,9 @@ err:
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
@@ -1012,12 +879,6 @@ static int unix_connect_saddr(UnixSocketAddress *saddr,
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
@@ -1038,29 +899,16 @@ static int unix_connect_saddr(UnixSocketAddress *saddr,
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
 
@@ -1075,9 +923,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     return -1;
 }
 
-static int unix_connect_saddr(UnixSocketAddress *saddr,
-                              NonBlockingConnectHandler *callback, void *opaque,
-                              Error **errp)
+static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 {
     error_setg(errp, "unix sockets are not available on windows");
     errno = ENOTSUP;
@@ -1123,7 +969,7 @@ int unix_connect(const char *path, Error **errp)
 
     saddr = g_new0(UnixSocketAddress, 1);
     saddr->path = g_strdup(path);
-    sock = unix_connect_saddr(saddr, NULL, NULL, errp);
+    sock = unix_connect_saddr(saddr, errp);
     qapi_free_UnixSocketAddress(saddr);
     return sock;
 }
@@ -1168,30 +1014,25 @@ fail:
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
2.13.5
