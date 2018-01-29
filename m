Received: from eggs.gnu.org ([2001:4830:134:3::10]:46273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1egEsu-0005qR-SF
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1egEst-0008UN-EQ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:28 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1egEst-0008Tu-6X
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:27 -0500
Received: by mail-pf0-x241.google.com with SMTP id k19so6231192pfj.5
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 11:14:27 -0800 (PST)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 30 Jan 2018 03:13:41 +0800
Message-Id: <1517253224-14361-2-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC 1/4] qemu-socket: Allow custom socket option in
 socket_listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Currently, socket_listen does not allow caller to set custom
socket options, which is inconvenient when the caller wants
a non-blocking socket or wants to set TCP_NODELAY. Therefore,
two new structs are added and an extra parameter is provided
to socket_listen. Existing functions are unaffected by
providing a NULL pointer.

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 include/qemu/sockets.h | 17 +++++++++++-
 io/channel-socket.c    |  2 +-
 qga/channel-posix.c    |  2 +-
 util/qemu-sockets.c    | 74 ++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 8889bcb..ab06943 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -11,6 +11,21 @@ int inet_aton(const char *cp, struct in_addr *ia);
 
 #include "qapi-types.h"
 
+struct QemuSocketOption {
+    int level;
+    int optname;
+    void *optval;
+    socklen_t optlen;
+    struct QemuSocketOption *next;
+};
+typedef struct QemuSocketOption QemuSocketOption;
+
+struct QemuSocketConfig {
+    bool nonblocking;
+    QemuSocketOption *options;
+};
+typedef struct QemuSocketConfig QemuSocketConfig;
+
 /* misc helpers */
 int qemu_socket(int domain, int type, int protocol);
 int qemu_accept(int s, struct sockaddr *addr, socklen_t *addrlen);
@@ -40,7 +55,7 @@ int unix_connect(const char *path, Error **errp);
 
 SocketAddress *socket_parse(const char *str, Error **errp);
 int socket_connect(SocketAddress *addr, Error **errp);
-int socket_listen(SocketAddress *addr, Error **errp);
+int socket_listen(SocketAddress *addr, Error **errp, QemuSocketConfig *sconf);
 void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 563e297..9942cf0 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -198,7 +198,7 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
     int fd;
 
     trace_qio_channel_socket_listen_sync(ioc, addr);
-    fd = socket_listen(addr, errp);
+    fd = socket_listen(addr, errp, NULL);
     if (fd < 0) {
         trace_qio_channel_socket_listen_fail(ioc);
         return -1;
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index b812bf4..16c8524 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -215,7 +215,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
                 return false;
             }
 
-            fd = socket_listen(addr, &local_err);
+            fd = socket_listen(addr, &local_err, NULL);
             qapi_free_SocketAddress(addr);
             if (local_err != NULL) {
                 g_critical("%s", error_get_pretty(local_err));
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d6a1e17..b171f23 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -43,7 +43,6 @@
 # define AI_NUMERICSERV 0
 #endif
 
-
 static int inet_getport(struct addrinfo *e)
 {
     struct sockaddr_in *i4;
@@ -196,9 +195,40 @@ static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
 #endif
 }
 
+static int parse_socket_options(int fd,
+                                Error **errp,
+                                QemuSocketConfig *sconf)
+{
+    QemuSocketOption *sopt;
+
+    if(!sconf) {
+        /* No extra socket options are defined */
+        return fd;
+    }
+
+    if(sconf->nonblocking) {
+        qemu_set_nonblock(fd);
+    } 
+
+    for(sopt = sconf->options; sopt; sopt = sopt->next) {
+        if(sopt->level < IPPROTO_IP || sopt->optname < SO_DEBUG || 
+                              !sopt->optval || sopt->optlen <= 0) {
+            error_setg(errp, "Invalid socket option:\n"
+                             "level=%d, optname=%d, optval=%p, optlen=%d\n",
+                    sopt->level, sopt->optname, sopt->optval, sopt->optlen);
+            return -1;
+        }
+        qemu_setsockopt(fd, sopt->level, sopt->optname, 
+                            sopt->optval, sopt->optlen);
+    }
+
+    return fd;
+}
+
 static int inet_listen_saddr(InetSocketAddress *saddr,
                              int port_offset,
-                             Error **errp)
+                             Error **errp,
+                             QemuSocketConfig *sconf)
 {
     struct addrinfo ai,*res,*e;
     char port[33];
@@ -287,6 +317,11 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
             }
             socket_created = true;
 
+            if(parse_socket_options(slisten, errp, sconf) < 0) {
+                error_setg_errno(errp, errno, "Failed to set socket options");
+                goto listen_failed;
+            }
+
             rc = try_bind(slisten, saddr, e);
             if (rc < 0) {
                 if (errno != EADDRINUSE) {
@@ -701,7 +736,8 @@ static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
 }
 
 static int vsock_listen_saddr(VsockSocketAddress *vaddr,
-                              Error **errp)
+                              Error **errp,
+                              QemuSocketConfig *sconf)
 {
     struct sockaddr_vm svm;
     int slisten;
@@ -716,6 +752,12 @@ static int vsock_listen_saddr(VsockSocketAddress *vaddr,
         return -1;
     }
 
+    if(parse_socket_options(slisten, errp, sconf) < 0) {
+        error_setg_errno(errp, errno, "Failed to set socket options");
+        closesocket(slisten);
+        return -1;
+    }
+
     if (bind(slisten, (const struct sockaddr *)&svm, sizeof(svm)) != 0) {
         error_setg_errno(errp, errno, "Failed to bind socket");
         closesocket(slisten);
@@ -763,7 +805,8 @@ static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
 }
 
 static int vsock_listen_saddr(VsockSocketAddress *vaddr,
-                              Error **errp)
+                              Error **errp,
+                              QemuSocketConfig *sconf)
 {
     vsock_unsupported(errp);
     return -1;
@@ -780,7 +823,8 @@ static int vsock_parse(VsockSocketAddress *addr, const char *str,
 #ifndef _WIN32
 
 static int unix_listen_saddr(UnixSocketAddress *saddr,
-                             Error **errp)
+                             Error **errp,
+                             QemuSocketConfig *sconf)
 {
     struct sockaddr_un un;
     int sock, fd;
@@ -793,6 +837,12 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         return -1;
     }
 
+    if(parse_socket_options(sock, errp, sconf) < 0) {
+        error_setg_errno(errp, errno, "Failed to set socket option");
+        closesocket(sock);
+        return -1;
+    }
+
     if (saddr->path && saddr->path[0]) {
         path = saddr->path;
     } else {
@@ -904,7 +954,8 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 #else
 
 static int unix_listen_saddr(UnixSocketAddress *saddr,
-                             Error **errp)
+                             Error **errp,
+                             QemuSocketConfig *sconf)
 {
     error_setg(errp, "unix sockets are not available on windows");
     errno = ENOTSUP;
@@ -940,7 +991,7 @@ int unix_listen(const char *str, Error **errp)
         saddr->path = g_strdup(str);
     }
 
-    sock = unix_listen_saddr(saddr, errp);
+    sock = unix_listen_saddr(saddr, errp, NULL);
 
     qapi_free_UnixSocketAddress(saddr);
     return sock;
@@ -1025,17 +1076,18 @@ int socket_connect(SocketAddress *addr, Error **errp)
     return fd;
 }
 
-int socket_listen(SocketAddress *addr, Error **errp)
+int socket_listen(SocketAddress *addr, Error **errp,
+                  QemuSocketConfig *sconf)
 {
     int fd;
 
     switch (addr->type) {
     case SOCKET_ADDRESS_TYPE_INET:
-        fd = inet_listen_saddr(&addr->u.inet, 0, errp);
+        fd = inet_listen_saddr(&addr->u.inet, 0, errp, sconf);
         break;
 
     case SOCKET_ADDRESS_TYPE_UNIX:
-        fd = unix_listen_saddr(&addr->u.q_unix, errp);
+        fd = unix_listen_saddr(&addr->u.q_unix, errp, sconf);
         break;
 
     case SOCKET_ADDRESS_TYPE_FD:
@@ -1043,7 +1095,7 @@ int socket_listen(SocketAddress *addr, Error **errp)
         break;
 
     case SOCKET_ADDRESS_TYPE_VSOCK:
-        fd = vsock_listen_saddr(&addr->u.vsock, errp);
+        fd = vsock_listen_saddr(&addr->u.vsock, errp, sconf);
         break;
 
     default:
-- 
2.7.4
