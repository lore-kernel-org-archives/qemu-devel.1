Received: from eggs.gnu.org ([2001:4830:134:3::10]:59218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gKHmf-0007aG-Pp
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 01:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gKHmc-0008B6-A6
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 01:57:49 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gKHmb-00081q-Jl
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 01:57:46 -0500
Received: by mail-lf1-x141.google.com with SMTP id h192so10703067lfg.3
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 22:57:43 -0800 (PST)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed,  7 Nov 2018 12:57:30 +0600
Message-Id: <7b5279e8946325b7f3c22a4a51ab02777202ce77.1541573846.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH] netdev: fix socket backend implementation and
 docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>

Changes:
- user documentation and QAPI 'NetdevSocketOptions' comments updated
to match current implementation ('udp' type description added, 'fd'
option separated to exclusive type and described, 'localaddr'-related
description for 'mcast' type fixed, hostname parts in "[host]:port"
options updated to match optional/required syntax, various fixes and
improvements in options breakdown and wording);
- 'fd' type backend: requirement for socket handle being already
binded and connected made explicit and documented;
- 'fd' type backend: fix broken SOCK_DGRAM support;
- 'fd' type backend: removed multicast support and cleaned up broken
workaround for it (never called);
- fix possible broken multicasting in win32 platform;
- fix parsing of "[host]:port" options (added error handling for cases
where "host" part is documented as required but isn't provided);
- some error messages improved;
- other small fixes and refactoring in code.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---

Notes:
    (Since these changes are closely related, I've combined them in one patch.)
    This patch addresses all issues I've pointed earlier (http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06695.html), except internal protocol, and plus additional ones.
    
    'fd' transport and its special 'af_inet multicast' case deserve special attention.
    Firstly, it already wasn't working as expected at least in current qemu version, so it isn't supposed to break any compabitibility if someone cares.
    The only question is a way of fixing it.
    It depends on concept behind 'fd' transport, which is unknown to me. Seems like initially it was just optional parameter to any transport allowing to replace newly created socket descriptor with user supplied one, but at some time someone changed it to be separate transport and not accounted 'af_inet multicast' case (code analysis shows that condition "is_connected && mcast != NULL" in 'net_socket_fd_init_dgram' function never can be true and "s->dgram_dst" value is left unassigned).
    I would prefer concept of separate transport when qemu doesn't depend on underlying domain, type and protocol of socket (almost). To make it universal/flexible, qemu shouldn't handle their specifics, such as 'af_inet multicast' one. So I fixed things accordingly. For example, if user needs multicasting, it should already know that it cannot share one socket between its app and qemu instances, so user should use 'mcast' transport of qemu which will create separate socket for qemu instance. And there are maybe other socket types (possibly not existing at present moment yet) with their own specifics.
    Since this concept restricts usage of sockets which cannot work in connected state (such as af_inet multicast), I've prepared and ready to submit another version of patch which solves this restriction by checking socket type and handling it accordingly. Currently it supports only 'af_inet multicast' case by preserving existed hack (slightly modified): it extracts multicast address from socket and duplicates socket in proper unconnected state. It also requires synchronization with user who will unconnect original socket back. All of this is very hacky, but I'm open for discussion...

 include/qemu-common.h  |   3 +
 include/qemu/sockets.h |   2 +-
 net/net.c              |   8 ++-
 net/socket.c           | 148 ++++++++++++++++++++++---------------------------
 qapi/net.json          |  12 ++--
 qemu-options.hx        |  85 +++++++++++++++++++++-------
 6 files changed, 147 insertions(+), 111 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index ed60ba2..d4e4121 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -67,6 +67,8 @@ int qemu_openpty_raw(int *aslave, char *pty_name);
 #define qemu_setsockopt(sockfd, level, optname, optval, optlen) \
     setsockopt(sockfd, level, optname, (const void *)optval, optlen)
 #define qemu_recv(sockfd, buf, len, flags) recv(sockfd, (void *)buf, len, flags)
+#define qemu_send(sockfd, buf, len, flags) \
+    send(sockfd, (const void *)buf, len, flags)
 #define qemu_sendto(sockfd, buf, len, flags, destaddr, addrlen) \
     sendto(sockfd, (const void *)buf, len, flags, destaddr, addrlen)
 #else
@@ -75,6 +77,7 @@ int qemu_openpty_raw(int *aslave, char *pty_name);
 #define qemu_setsockopt(sockfd, level, optname, optval, optlen) \
     setsockopt(sockfd, level, optname, optval, optlen)
 #define qemu_recv(sockfd, buf, len, flags) recv(sockfd, buf, len, flags)
+#define qemu_send(sockfd, buf, len, flags) send(sockfd, buf, len, flags)
 #define qemu_sendto(sockfd, buf, len, flags, destaddr, addrlen) \
     sendto(sockfd, buf, len, flags, destaddr, addrlen)
 #endif
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 8140fea..3fad004 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -46,7 +46,7 @@ void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
 
 /* Old, ipv4 only bits.  Don't use for new code. */
-int parse_host_port(struct sockaddr_in *saddr, const char *str,
+int parse_host_port(struct sockaddr_in *saddr, const char *str, bool h_addr_opt,
                     Error **errp);
 int socket_init(void);
 
diff --git a/net/net.c b/net/net.c
index 07c194a..5103d78 100644
--- a/net/net.c
+++ b/net/net.c
@@ -83,7 +83,7 @@ static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
     return 0;
 }
 
-int parse_host_port(struct sockaddr_in *saddr, const char *str,
+int parse_host_port(struct sockaddr_in *saddr, const char *str, bool h_addr_opt,
                     Error **errp)
 {
     char buf[512];
@@ -99,6 +99,10 @@ int parse_host_port(struct sockaddr_in *saddr, const char *str,
     }
     saddr->sin_family = AF_INET;
     if (buf[0] == '\0') {
+        if (!h_addr_opt) {
+            error_setg(errp, "'%s' doesn't contain hostname/address part", str);
+            return -1;
+        }
         saddr->sin_addr.s_addr = 0;
     } else {
         if (qemu_isdigit(buf[0])) {
@@ -111,7 +115,7 @@ int parse_host_port(struct sockaddr_in *saddr, const char *str,
             he = gethostbyname(buf);
             if (he == NULL) {
                 error_setg(errp, "can't resolve host address '%s'", buf);
-                return - 1;
+                return -1;
             }
             saddr->sin_addr = *(struct in_addr *)he->h_addr;
         }
diff --git a/net/socket.c b/net/socket.c
index 90ef351..1dd44dc 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -40,7 +40,10 @@ typedef struct NetSocketState {
     int fd;
     SocketReadState rs;
     unsigned int send_index;      /* number of bytes sent (only SOCK_STREAM) */
-    struct sockaddr_in dgram_dst; /* contains inet host and port destination iff connectionless (SOCK_DGRAM) */
+    bool dgram_connected;         /* whether connect() call was done for socket
+                                   * (SOCK_DGRAM) */
+    struct sockaddr_in dgram_dst; /* contains inet host and port destination
+                                   * if dgram_connected=false */
     IOHandler *send_fn;           /* differs between SOCK_STREAM/SOCK_DGRAM */
     bool read_poll;               /* waiting to receive data? */
     bool write_poll;              /* waiting to transmit data? */
@@ -78,7 +81,8 @@ static void net_socket_writable(void *opaque)
     qemu_flush_queued_packets(&s->nc);
 }
 
-static ssize_t net_socket_receive(NetClientState *nc, const uint8_t *buf, size_t size)
+static ssize_t net_socket_receive(NetClientState *nc,
+                                  const uint8_t *buf, size_t size)
 {
     NetSocketState *s = DO_UPCAST(NetSocketState, nc, nc);
     uint32_t len = htonl(size);
@@ -113,15 +117,21 @@ static ssize_t net_socket_receive(NetClientState *nc, const uint8_t *buf, size_t
     return size;
 }
 
-static ssize_t net_socket_receive_dgram(NetClientState *nc, const uint8_t *buf, size_t size)
+static ssize_t net_socket_receive_dgram(NetClientState *nc,
+                                        const uint8_t *buf, size_t size)
 {
     NetSocketState *s = DO_UPCAST(NetSocketState, nc, nc);
+    struct sockaddr *raddr = NULL;
+    socklen_t raddr_size = 0;
     ssize_t ret;
 
+    if (!s->dgram_connected) {
+        raddr = (struct sockaddr *)&s->dgram_dst;
+        raddr_size = sizeof(s->dgram_dst);
+    }
+
     do {
-        ret = qemu_sendto(s->fd, buf, size, 0,
-                          (struct sockaddr *)&s->dgram_dst,
-                          sizeof(s->dgram_dst));
+        ret = qemu_sendto(s->fd, buf, size, 0, raddr, raddr_size);
     } while (ret == -1 && errno == EINTR);
 
     if (ret == -1 && errno == EAGAIN) {
@@ -213,6 +223,7 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr,
                                    struct in_addr *localaddr,
                                    Error **errp)
 {
+    struct sockaddr_in bind_addr;
     struct ip_mreq imr;
     int fd;
     int val, ret;
@@ -249,14 +260,7 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr,
         goto fail;
     }
 
-    ret = bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr));
-    if (ret < 0) {
-        error_setg_errno(errp, errno, "can't bind ip=%s to socket",
-                         inet_ntoa(mcastaddr->sin_addr));
-        goto fail;
-    }
-
-    /* Add host to multicast group */
+    /* Init multicast group request */
     imr.imr_multiaddr = mcastaddr->sin_addr;
     if (localaddr) {
         imr.imr_interface = *localaddr;
@@ -264,6 +268,21 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr,
         imr.imr_interface.s_addr = htonl(INADDR_ANY);
     }
 
+    bind_addr = *mcastaddr;
+#ifdef _WIN32
+    /* See remarks about multicasting at
+     * https://docs.microsoft.com/ru-ru/windows/desktop/api/winsock2/nf-winsock2-bind
+     */
+    bind_addr.sin_addr = imr.imr_interface;
+#endif
+    ret = bind(fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr));
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "can't bind ip=%s to socket",
+                         inet_ntoa(bind_addr.sin_addr));
+        goto fail;
+    }
+
+    /* Add host to multicast group */
     ret = qemu_setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
                           &imr, sizeof(struct ip_mreq));
     if (ret < 0) {
@@ -328,66 +347,26 @@ static NetClientInfo net_dgram_socket_info = {
 static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
                                                 const char *model,
                                                 const char *name,
-                                                int fd, int is_connected,
-                                                const char *mcast,
-                                                Error **errp)
+                                                int fd, bool is_connected)
 {
-    struct sockaddr_in saddr;
-    int newfd;
     NetClientState *nc;
     NetSocketState *s;
 
-    /* fd passed: multicast: "learn" dgram_dst address from bound address and save it
-     * Because this may be "shared" socket from a "master" process, datagrams would be recv()
-     * by ONLY ONE process: we must "clone" this dgram socket --jjo
-     */
-
-    if (is_connected && mcast != NULL) {
-            if (parse_host_port(&saddr, mcast, errp) < 0) {
-                goto err;
-            }
-            /* must be bound */
-            if (saddr.sin_addr.s_addr == 0) {
-                error_setg(errp, "can't setup multicast destination address");
-                goto err;
-            }
-            /* clone dgram socket */
-            newfd = net_socket_mcast_create(&saddr, NULL, errp);
-            if (newfd < 0) {
-                goto err;
-            }
-            /* clone newfd to fd, close newfd */
-            dup2(newfd, fd);
-            close(newfd);
-
-    }
-
     nc = qemu_new_net_client(&net_dgram_socket_info, peer, model, name);
 
     s = DO_UPCAST(NetSocketState, nc, nc);
 
     s->fd = fd;
     s->listen_fd = -1;
+    s->dgram_connected = is_connected;
     s->send_fn = net_socket_send_dgram;
     net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
     net_socket_read_poll(s, true);
 
-    /* mcast: save bound address as dst */
-    if (is_connected && mcast != NULL) {
-        s->dgram_dst = saddr;
-        snprintf(nc->info_str, sizeof(nc->info_str),
-                 "socket: fd=%d (cloned mcast=%s:%d)",
-                 fd, inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
-    } else {
-        snprintf(nc->info_str, sizeof(nc->info_str),
-                 "socket: fd=%d", fd);
-    }
+    snprintf(nc->info_str, sizeof(nc->info_str),
+             "socket: fd=%d", fd);
 
     return s;
-
-err:
-    closesocket(fd);
-    return NULL;
 }
 
 static void net_socket_connect(void *opaque)
@@ -407,7 +386,7 @@ static NetClientInfo net_socket_info = {
 static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
                                                  const char *model,
                                                  const char *name,
-                                                 int fd, int is_connected)
+                                                 int fd, bool is_connected)
 {
     NetClientState *nc;
     NetSocketState *s;
@@ -435,21 +414,20 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
 
 static NetSocketState *net_socket_fd_init(NetClientState *peer,
                                           const char *model, const char *name,
-                                          int fd, int is_connected,
-                                          const char *mc, Error **errp)
+                                          int fd, bool is_connected,
+                                          Error **errp)
 {
     int so_type = -1, optlen=sizeof(so_type);
 
     if(getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
         (socklen_t *)&optlen)< 0) {
-        error_setg(errp, "can't get socket option SO_TYPE");
+        error_setg_errno(errp, errno, "can't get socket option SO_TYPE");
         closesocket(fd);
         return NULL;
     }
     switch(so_type) {
     case SOCK_DGRAM:
-        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected,
-                                        mc, errp);
+        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected);
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     default:
@@ -497,7 +475,7 @@ static int net_socket_listen_init(NetClientState *peer,
     struct sockaddr_in saddr;
     int fd, ret;
 
-    if (parse_host_port(&saddr, host_str, errp) < 0) {
+    if (parse_host_port(&saddr, host_str, true, errp) < 0) {
         return -1;
     }
 
@@ -542,10 +520,11 @@ static int net_socket_connect_init(NetClientState *peer,
                                    Error **errp)
 {
     NetSocketState *s;
-    int fd, connected, ret;
+    int fd, ret;
     struct sockaddr_in saddr;
+    bool connected;
 
-    if (parse_host_port(&saddr, host_str, errp) < 0) {
+    if (parse_host_port(&saddr, host_str, false, errp) < 0) {
         return -1;
     }
 
@@ -556,7 +535,7 @@ static int net_socket_connect_init(NetClientState *peer,
     }
     qemu_set_nonblock(fd);
 
-    connected = 0;
+    connected = false;
     for(;;) {
         ret = connect(fd, (struct sockaddr *)&saddr, sizeof(saddr));
         if (ret < 0) {
@@ -572,11 +551,11 @@ static int net_socket_connect_init(NetClientState *peer,
                 return -1;
             }
         } else {
-            connected = 1;
+            connected = true;
             break;
         }
     }
-    s = net_socket_fd_init(peer, model, name, fd, connected, NULL, errp);
+    s = net_socket_fd_init(peer, model, name, fd, connected, errp);
     if (!s) {
         return -1;
     }
@@ -599,7 +578,7 @@ static int net_socket_mcast_init(NetClientState *peer,
     struct sockaddr_in saddr;
     struct in_addr localaddr, *param_localaddr;
 
-    if (parse_host_port(&saddr, host_str, errp) < 0) {
+    if (parse_host_port(&saddr, host_str, false, errp) < 0) {
         return -1;
     }
 
@@ -619,7 +598,7 @@ static int net_socket_mcast_init(NetClientState *peer,
         return -1;
     }
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, errp);
+    s = net_socket_fd_init(peer, model, name, fd, false, errp);
     if (!s) {
         return -1;
     }
@@ -644,11 +623,11 @@ static int net_socket_udp_init(NetClientState *peer,
     int fd, ret;
     struct sockaddr_in laddr, raddr;
 
-    if (parse_host_port(&laddr, lhost, errp) < 0) {
+    if (parse_host_port(&laddr, lhost, true, errp) < 0) {
         return -1;
     }
 
-    if (parse_host_port(&raddr, rhost, errp) < 0) {
+    if (parse_host_port(&raddr, rhost, false, errp) < 0) {
         return -1;
     }
 
@@ -667,20 +646,26 @@ static int net_socket_udp_init(NetClientState *peer,
     }
     ret = bind(fd, (struct sockaddr *)&laddr, sizeof(laddr));
     if (ret < 0) {
-        error_setg_errno(errp, errno, "can't bind ip=%s to socket",
-                         inet_ntoa(laddr.sin_addr));
+        error_setg_errno(errp, errno, "can't bind %s:%"PRIu16" to socket",
+                         inet_ntoa(laddr.sin_addr), laddr.sin_port);
+        closesocket(fd);
+        return -1;
+    }
+    do {
+        ret = connect(fd, (struct sockaddr *)&raddr, sizeof(raddr));
+    } while ((ret < 0) && (errno == EINTR));
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "can't connect socket");
         closesocket(fd);
         return -1;
     }
     qemu_set_nonblock(fd);
 
-    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, errp);
+    s = net_socket_fd_init(peer, model, name, fd, true, errp);
     if (!s) {
         return -1;
     }
 
-    s->dgram_dst = raddr;
-
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "socket: udp=%s:%d",
              inet_ntoa(raddr.sin_addr), ntohs(raddr.sin_port));
@@ -697,7 +682,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
 
     if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
         sock->has_udp != 1) {
-        error_setg(errp, "exactly one of listen=, connect=, mcast= or udp="
+        error_setg(errp, "exactly one of fd=, listen=, connect=, mcast= or udp="
                    " is required");
         return -1;
     }
@@ -715,8 +700,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
             return -1;
         }
         qemu_set_nonblock(fd);
-        if (!net_socket_fd_init(peer, "socket", name, fd, 1, sock->mcast,
-                                errp)) {
+        if (!net_socket_fd_init(peer, "socket", name, fd, true, errp)) {
             return -1;
         }
         return 0;
diff --git a/qapi/net.json b/qapi/net.json
index 8f99fd9..d6f526b 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -269,15 +269,15 @@
 #
 # @fd: file descriptor of an already opened socket
 #
-# @listen: port number, and optional hostname, to listen on
+# @listen: port number, and optional hostname, to listen on (new TCP socket)
 #
-# @connect: port number, and optional hostname, to connect to
+# @connect: port number, and optional hostname, to connect to (new TCP socket)
 #
-# @mcast: UDP multicast address and port number
+# @localaddr: source address (optional for tunnel) and port (new UDP socket)
 #
-# @localaddr: source address and port for multicast and udp packets
+# @mcast: multicast address and port number (new UDP multicast socket)
 #
-# @udp: UDP unicast address and port number
+# @udp: unicast address and port number (new UDP tunnel socket)
 #
 # Since: 1.2
 ##
@@ -286,8 +286,8 @@
     '*fd':        'str',
     '*listen':    'str',
     '*connect':   'str',
-    '*mcast':     'str',
     '*localaddr': 'str',
+    '*mcast':     'str',
     '*udp':       'str' } }
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index 08f8516..510ad8f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1892,15 +1892,23 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                use 'pincounter=on' to work around broken counter handling in peer\n"
     "                use 'offset=X' to add an extra offset between header and data\n"
 #endif
-    "-netdev socket,id=str[,fd=h][,listen=[host]:port][,connect=host:port]\n"
+    "-netdev socket,id=str,fd=h\n"
     "                configure a network backend to connect to another network\n"
-    "                using a socket connection\n"
-    "-netdev socket,id=str[,fd=h][,mcast=maddr:port[,localaddr=addr]]\n"
+    "                using an existing socket connection\n"
+    "-netdev socket,id=str,listen=[host]:port\n"
+    "                configure a network backend to accept and use an incoming TCP connection\n"
+    "                from remote client\n"
+    "-netdev socket,id=str,connect=host:port\n"
+    "                configure a network backend to connect to remote server\n"
+    "                using an outgoing TCP connection\n"
+    "-netdev socket,id=str,mcast=maddr:port[,localaddr=addr]\n"
     "                configure a network backend to connect to a multicast maddr and port\n"
-    "                use 'localaddr=addr' to specify the host address to send packets from\n"
-    "-netdev socket,id=str[,fd=h][,udp=host:port][,localaddr=host:port]\n"
-    "                configure a network backend to connect to another network\n"
+    "                using UDP multicasting\n"
+    "                use 'localaddr' to specify the address of host network interface to bind to\n"
+    "-netdev socket,id=str,udp=rhost:rport,localaddr=[host]:port\n"
+    "                configure a network backend to connect to an unicast rhost and rport\n"
     "                using an UDP tunnel\n"
+    "                use 'localaddr' to specify the host address and port to bind to\n"
 #ifdef CONFIG_VDE
     "-netdev vde,id=str[,sock=socketpath][,port=n][,group=groupname][,mode=octalmode]\n"
     "                configure a network backend to connect to port 'n' of a vde switch\n"
@@ -2211,14 +2219,25 @@ qemu-system-i386 linux.img -netdev bridge,id=n1 -device virtio-net,netdev=n1
 qemu-system-i386 linux.img -netdev bridge,br=qemubr0,id=n1 -device virtio-net,netdev=n1
 @end example
 
-@item -netdev socket,id=@var{id}[,fd=@var{h}][,listen=[@var{host}]:@var{port}][,connect=@var{host}:@var{port}]
+@item -netdev socket,id=@var{id},fd=@var{h}
 
-This host network backend can be used to connect the guest's network to
-another QEMU virtual machine using a TCP socket connection. If @option{listen}
-is specified, QEMU waits for incoming connections on @var{port}
-(@var{host} is optional). @option{connect} is used to connect to
-another QEMU instance using the @option{listen} option. @option{fd}=@var{h}
-specifies an already opened TCP socket.
+Configure a socket host network backend to connect the guest's network to
+another QEMU virtual machine using an existing socket connection, specified
+by socket descriptor @option{fd}=@var{h}.
+User application must pass already binded and/or connected socket endpoint of
+SOCK_STREAM or SOCK_DGRAM type, created in AF_LOCAL/AF_UNIX or AF_INET domain.
+For example, application may create unix socket pair to connect two QEMU
+instances. On the other side, this has restriction preventing passing
+multicast (AF_INET) sockets, because they will not work in connected state.
+
+@item -netdev socket,id=@var{id}[,listen=[@var{host}]:@var{port}][,connect=@var{host}:@var{port}]
+
+Configure a socket host network backend to connect the guest's network to
+another QEMU virtual machine using a TCP socket connection (IPv4 only).
+Exactly one of @option{listen} or @option{connect} options must be specified.
+Option @option{listen} tells QEMU to wait for incoming (single) connection
+on @var{port} (@var{host} is optional). Option @option{connect} tells QEMU
+to connect to another QEMU instance using the @option{listen} option.
 
 Example:
 @example
@@ -2232,21 +2251,26 @@ qemu-system-i386 linux.img \
                  -netdev socket,id=n2,connect=127.0.0.1:1234
 @end example
 
-@item -netdev socket,id=@var{id}[,fd=@var{h}][,mcast=@var{maddr}:@var{port}[,localaddr=@var{addr}]]
+@item -netdev socket,id=@var{id},mcast=@var{maddr}:@var{port}[,localaddr=@var{addr}]
 
 Configure a socket host network backend to share the guest's network traffic
-with another QEMU virtual machines using a UDP multicast socket, effectively
-making a bus for every QEMU with same multicast address @var{maddr} and @var{port}.
-NOTES:
+with another QEMU virtual machines using a UDP multicasting (IPv4 only),
+effectively making a bus for every QEMU with same multicast address @var{maddr}
+and @var{port}.
+Use @option{localaddr}=@var{addr} to specify address of specific network
+interface on host machine to bind socket to.
+
+Notes:
 @enumerate
 @item
 Several QEMU can be running on different hosts and share same bus (assuming
 correct multicast setup for these hosts).
 @item
-mcast support is compatible with User Mode Linux (argument @option{eth@var{N}=mcast}), see
-@url{http://user-mode-linux.sf.net}.
+Without specifying @option{localaddr} default network interface will be
+selected, which choice is very specific to host OS and its setup.
 @item
-Use @option{fd=h} to specify an already opened UDP multicast socket.
+mcast support is compatible with User Mode Linux (argument
+@option{eth@var{N}=mcast}), see @url{http://user-mode-linux.sf.net}.
 @end enumerate
 
 Example:
@@ -2282,6 +2306,27 @@ qemu-system-i386 linux.img \
                  -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 @end example
 
+@item -netdev socket,id=@var{id},udp=@var{rhost}:@var{rport},localaddr=[@var{host}]:@var{port}
+
+Configure a socket host network backend to connect the guest's network to
+another QEMU virtual machine using an UDP tunnel (IPv4 only).
+Use @option{localaddr} to specify @var{host} address (optional) and @var{port}
+to bind socket to (receive packets in and send packets from). Another QEMU
+instance must be binded to specified @var{rhost} (or all addresses)
+and @var{rport}.
+
+Example:
+@example
+# launch a first QEMU instance
+qemu-system-i386 linux.img \
+                 -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
+                 -netdev socket,id=n1,udp=127.0.0.1:1234,localaddr=:4321
+# launch a second QEMU instance
+qemu-system-i386 linux.img \
+                 -device e1000,netdev=n2,mac=52:54:00:12:34:57 \
+                 -netdev socket,id=n2,udp=127.0.0.1:4321,localaddr=:1234
+@end example
+
 @item -netdev l2tpv3,id=@var{id},src=@var{srcaddr},dst=@var{dstaddr}[,srcport=@var{srcport}][,dstport=@var{dstport}],txsession=@var{txsession}[,rxsession=@var{rxsession}][,ipv6][,udp][,cookie64][,counter][,pincounter][,txcookie=@var{txcookie}][,rxcookie=@var{rxcookie}][,offset=@var{offset}]
 Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3391) is a
 popular protocol to transport Ethernet (and other Layer 2) data frames between
-- 
2.7.4
