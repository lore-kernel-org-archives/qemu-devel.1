Received: from eggs.gnu.org ([2001:4830:134:3::10]:40580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cvBq9-0007kQ-H6
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 19:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cvBq4-0002Sd-R5
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 19:56:53 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:65443)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cvBq4-0002Rf-9w
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 19:56:48 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  4 Apr 2017 01:56:36 +0200
Message-Id: <20170403235636.5647-2-laurent@vivier.eu>
In-Reply-To: <20170403235636.5647-1-laurent@vivier.eu>
References: <20170403235636.5647-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>

When the VM is used behind a firewall, This allows
the use of a SOCKS5 proxy server to connect the VM IP stack
directly to the Internet.

This implementation doesn't manage UDP packets, so they
are simply dropped (as with restrict=on), except for
the localhost as we need it for DNS.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 net/slirp.c         |  39 ++++++-
 qapi-schema.json    |   9 ++
 qemu-options.hx     |  11 ++
 slirp/Makefile.objs |   2 +-
 slirp/ip_icmp.c     |   2 +-
 slirp/libslirp.h    |   3 +
 slirp/slirp.c       |  68 ++++++++++-
 slirp/slirp.h       |   6 +
 slirp/socket.h      |   4 +
 slirp/socks5.c      | 328 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/socks5.h      |  24 ++++
 slirp/tcp_subr.c    |  22 +++-
 slirp/udp.c         |   9 ++
 slirp/udp6.c        |   8 ++
 14 files changed, 524 insertions(+), 11 deletions(-)
 create mode 100644 slirp/socks5.c
 create mode 100644 slirp/socks5.h

diff --git a/net/slirp.c b/net/slirp.c
index f97ec23..8a5dc3f 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -41,6 +41,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "crypto/secret.h"
 
 static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
 {
@@ -139,6 +140,33 @@ static void net_slirp_cleanup(NetClientState *nc)
     QTAILQ_REMOVE(&slirp_stacks, s, entry);
 }
 
+static int net_slirp_add_proxy(SlirpState *s, const char *proxy_server,
+                               const char *proxy_user,
+                               const char *proxy_secretid)
+{
+    InetSocketAddress *addr;
+    char *password = NULL;
+    int ret;
+
+    if (proxy_server == NULL) {
+        return 0;
+    }
+
+    if (proxy_secretid) {
+        password = qcrypto_secret_lookup_as_utf8(proxy_secretid, &error_fatal);
+    }
+
+    addr = inet_parse(proxy_server, &error_fatal);
+
+    ret = slirp_add_proxy(s->slirp, addr->host, atoi(addr->port),
+                          proxy_user, password);
+
+    qapi_free_InetSocketAddress(addr);
+    g_free(password);
+
+    return ret;
+}
+
 static NetClientInfo net_slirp_info = {
     .type = NET_CLIENT_DRIVER_USER,
     .size = sizeof(SlirpState),
@@ -155,7 +183,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
                           const char *bootfile, const char *vdhcp_start,
                           const char *vnameserver, const char *vnameserver6,
                           const char *smb_export, const char *vsmbserver,
-                          const char **dnssearch)
+                          const char **dnssearch, const char *proxy_server,
+                          const char *proxy_user, const char *proxy_secretid)
 {
     /* default settings according to historic slirp */
     struct in_addr net  = { .s_addr = htonl(0x0a000200) }; /* 10.0.2.0 */
@@ -361,6 +390,11 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     }
 #endif
 
+    if (net_slirp_add_proxy(s, proxy_server,
+                            proxy_user, proxy_secretid) < 0) {
+        goto error;
+    }
+
     s->exit_notifier.notify = slirp_smb_exit;
     qemu_add_exit_notifier(&s->exit_notifier);
     return 0;
@@ -878,7 +912,8 @@ int net_init_slirp(const Netdev *netdev, const char *name,
                          user->ipv6_host, user->hostname, user->tftp,
                          user->bootfile, user->dhcpstart,
                          user->dns, user->ipv6_dns, user->smb,
-                         user->smbserver, dnssearch);
+                         user->smbserver, dnssearch, user->proxy_server,
+                         user->proxy_user, user->proxy_secretid);
 
     while (slirp_configs) {
         config = slirp_configs;
diff --git a/qapi-schema.json b/qapi-schema.json
index b921994..1799ae2 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3658,6 +3658,12 @@
 #
 # @guestfwd: forward guest TCP connections
 #
+# @proxy-server: address of the SOCKS5 proxy server to use (since 2.10)
+#
+# @proxy-user: username to use with the proxy server (since 2.10)
+#
+# @proxy-secretid: secret id to use for the proxy server password (since 2.10)
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevUserOptions',
@@ -3680,6 +3686,9 @@
     '*ipv6-dns':         'str',
     '*smb':       'str',
     '*smbserver': 'str',
+    '*proxy-server': 'str',
+    '*proxy-user':   'str',
+    '*proxy-secretid': 'str',
     '*hostfwd':   ['String'],
     '*guestfwd':  ['String'] } }
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 99af8ed..e625d1a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1645,6 +1645,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #ifndef _WIN32
                                              "[,smb=dir[,smbserver=addr]]\n"
 #endif
+    "         [,proxy-server=addr:port[,proxy-user=user,proxy-secretid=id]]\n"
     "                configure a user mode network backend with ID 'str',\n"
     "                its DHCP server and optional services\n"
 #endif
@@ -1883,6 +1884,16 @@ Note that a SAMBA server must be installed on the host OS.
 QEMU was tested successfully with smbd versions from Red Hat 9,
 Fedora Core 3 and OpenSUSE 11.x.
 
+@item proxy-server=@var{addr}:@var{port}[,proxy-user=@var{user},proxy-secretid=@var{secretid}]]
+If you provide a SOCKS5 proxy server address @var{addr} and a port number @var{port},
+QEMU will use it to connect to Internet. If the proxy server needs an user id and a password
+the values are provided with proxy-user and proxy-secretid (via secret object).
+
+For example, to connect to a TOR proxy server on the host, use the following:
+@example
+qemu-system-i386 -net user,proxy-server=localhost:9050
+@end example
+
 @item hostfwd=[tcp|udp]:[@var{hostaddr}]:@var{hostport}-[@var{guestaddr}]:@var{guestport}
 Redirect incoming TCP or UDP connections to the host port @var{hostport} to
 the guest IP address @var{guestaddr} on guest port @var{guestport}. If
diff --git a/slirp/Makefile.objs b/slirp/Makefile.objs
index 1baa1f1..ce6d643 100644
--- a/slirp/Makefile.objs
+++ b/slirp/Makefile.objs
@@ -2,4 +2,4 @@ common-obj-y = cksum.o if.o ip_icmp.o ip6_icmp.o ip6_input.o ip6_output.o \
                ip_input.o ip_output.o dnssearch.o dhcpv6.o
 common-obj-y += slirp.o mbuf.o misc.o sbuf.o socket.o tcp_input.o tcp_output.o
 common-obj-y += tcp_subr.o tcp_timer.o udp.o udp6.o bootp.o tftp.o arp_table.o \
-                ndp_table.o
+                ndp_table.o socks5.o
diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 5ffc7a6..ed5e3eb 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -154,7 +154,7 @@ icmp_input(struct mbuf *m, int hlen)
     ip->ip_len += hlen;	             /* since ip_input subtracts this */
     if (ip->ip_dst.s_addr == slirp->vhost_addr.s_addr) {
       icmp_reflect(m);
-    } else if (slirp->restricted) {
+    } else if (slirp->restricted || slirp->proxy_server) {
         goto freeit;
     } else {
       struct socket *so;
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index f90f0f5..e6fc3f3 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -26,6 +26,9 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error);
 
 void slirp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len);
 
+int slirp_add_proxy(Slirp *slirp, const char *server, int port,
+                    const char *user, const char *password);
+
 /* you must provide the following functions: */
 void slirp_output(void *opaque, const uint8_t *pkt, int pkt_len);
 
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 5a94b06..529bf22 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -29,6 +29,7 @@
 #include "slirp.h"
 #include "hw/hw.h"
 #include "qemu/cutils.h"
+#include "socks5.h"
 
 #ifndef _WIN32
 #include <net/if.h>
@@ -442,6 +443,9 @@ void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout)
                     .fd = so->s,
                     .events = G_IO_OUT | G_IO_ERR,
                 };
+                if (so->so_proxy_state) {
+                    pfd.events |= G_IO_IN;
+                }
                 so->pollfds_idx = pollfds->len;
                 g_array_append_val(pollfds, pfd);
                 continue;
@@ -617,6 +621,10 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
                  * Check sockets for reading
                  */
                 else if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
+                    if (so->so_state & SS_ISFCONNECTING) {
+                        socks5_recv(so->s, &so->so_proxy_state);
+                        continue;
+                    }
                     /*
                      * Check for incoming connections
                      */
@@ -645,11 +653,19 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
                     /*
                      * Check for non-blocking, still-connecting sockets
                      */
-                    if (so->so_state & SS_ISFCONNECTING) {
-                        /* Connected */
-                        so->so_state &= ~SS_ISFCONNECTING;
 
-                        ret = send(so->s, (const void *) &ret, 0, 0);
+                    if (so->so_state & SS_ISFCONNECTING) {
+                        ret = socks5_send(so->s, slirp->proxy_user,
+                                          slirp->proxy_password, so->fhost.ss,
+                                          &so->so_proxy_state);
+                        if (ret == 0) {
+                            continue;
+                        }
+                        if (ret > 0) {
+                            /* Connected */
+                            so->so_state &= ~SS_ISFCONNECTING;
+                            ret = send(so->s, (const void *) &ret, 0, 0);
+                        }
                         if (ret < 0) {
                             /* XXXXX Must fix, zero bytes is a NOP */
                             if (errno == EAGAIN || errno == EWOULDBLOCK ||
@@ -1069,6 +1085,50 @@ int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
                     htons(guest_port));
 }
 
+int slirp_add_proxy(Slirp *slirp, const char *server, int port,
+                    const char *user, const char *password)
+{
+    int fd;
+    socks5_state_t state;
+    struct sockaddr_storage addr;
+
+    /* just check that the connection to the socks5 server works with
+     * the given credentials, and close without doing anything with it.
+     */
+
+    fd = socks5_socket(&state);
+    if (fd < 0) {
+        return -1;
+    }
+    if (socks5_connect(fd, server, port, &state) < 0) {
+        close(fd);
+        return -1;
+    }
+    while (state < SOCKS5_STATE_ESTABLISH) {
+        if (socks5_send(fd, user, password, addr, &state) < 0) {
+            close(fd);
+            return -1;
+        }
+        socks5_recv(fd, &state);
+        if (state == SOCKS5_STATE_NONE) {
+            close(fd);
+            return -1;
+        }
+    }
+    close(fd);
+
+    slirp->proxy_server = g_strdup(server);
+    slirp->proxy_port = port;
+    if (user) {
+        slirp->proxy_user = g_strdup(user);
+    }
+    if (password) {
+        slirp->proxy_password = g_strdup(password);
+    }
+
+    return 0;
+}
+
 ssize_t slirp_send(struct socket *so, const void *buf, size_t len, int flags)
 {
     if (so->s == -1 && so->extra) {
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 3877f66..9db58ed 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -214,6 +214,12 @@ struct Slirp {
     char *tftp_prefix;
     struct tftp_session tftp_sessions[TFTP_SESSIONS_MAX];
 
+    /* proxy */
+    char *proxy_server;
+    int proxy_port;
+    char *proxy_user;
+    char *proxy_password;
+
     ArpTable arp_table;
     NdpTable ndp_table;
 
diff --git a/slirp/socket.h b/slirp/socket.h
index 8feed2a..232f8e5 100644
--- a/slirp/socket.h
+++ b/slirp/socket.h
@@ -8,6 +8,8 @@
 #ifndef SLIRP_SOCKET_H
 #define SLIRP_SOCKET_H
 
+#include "socks5.h"
+
 #define SO_EXPIRE 240000
 #define SO_EXPIREFAST 10000
 
@@ -70,6 +72,8 @@ struct socket {
   struct sbuf so_rcv;		/* Receive buffer */
   struct sbuf so_snd;		/* Send buffer */
   void * extra;			/* Extra pointer */
+
+  socks5_state_t so_proxy_state;
 };
 
 
diff --git a/slirp/socks5.c b/slirp/socks5.c
new file mode 100644
index 0000000..813c3db
--- /dev/null
+++ b/slirp/socks5.c
@@ -0,0 +1,328 @@
+/* based on RFC 1928
+ *   SOCKS Protocol Version 5
+ * based on RFC 1929
+ *   Username/Password Authentication for SOCKS V5
+ * TODO:
+ *   - RFC 1961 GSS-API Authentication Method for SOCKS Version 5
+ *   - manage buffering on recv()
+ *   - IPv6 connection to proxy
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/sockets.h"
+
+#include "socks5.h"
+
+#define SOCKS_LEN_MAX                  0xff
+
+#define SOCKS_VERSION_5                0x05
+
+#define SOCKS5_AUTH_METHOD_NONE        0x00
+#define SOCKS5_AUTH_METHOD_GSSAPI      0x01
+#define SOCKS5_AUTH_METHOD_PASSWORD    0x02
+#define SOCKS5_AUTH_METHOD_REJECTED    0xff
+
+#define SOCKS5_AUTH_PASSWORD_VERSION   0x01
+#define SOCKS5_AUTH_PASSWORD_SUCCESS   0x00
+
+#define SOCKS5_CMD_CONNECT             0x01
+#define SOCKS5_CMD_BIND                0x02
+#define SOCKS5_CMD_UDP_ASSOCIATE       0x03
+
+#define SOCKS5_ATYPE_IPV4              0x01
+#define SOCKS5_ATYPE_FQDN              0x03
+#define SOCKS5_ATYPE_IPV6              0x04
+
+#define SOCKS5_CMD_SUCCESS             0x00
+#define SOCKS5_CMD_SERVER_FAILURE      0x01
+#define SOCKS5_CMD_NOT_ALLOWED         0x02
+#define SOCKS5_CMD_NETWORK_UNREACHABLE 0x03
+#define SOCKS5_CMD_HOST_UNREACHABLE    0x04
+#define SOCKS5_CMD_CONNECTION_REFUSED  0x05
+#define SOCKS5_CMD_TTL_EXPIRED         0x06
+#define SOCKS5_CMD_NOT_SUPPORTED       0x07
+#define SOCKS5_CMD_ATYPE_NOT_SUPPORTED 0x08
+
+static int socks5_proxy_connect(int fd, const char *server, int port)
+{
+    struct sockaddr_in saddr;
+    struct hostent *he;
+
+    he = gethostbyname(server);
+    if (he == NULL) {
+        errno = EINVAL;
+        return -1;
+    }
+    /* TODO: IPv6 */
+    saddr.sin_family = AF_INET;
+    saddr.sin_addr = *(struct in_addr *)he->h_addr;
+    saddr.sin_port = htons(port);
+
+    return connect(fd, (struct sockaddr *)&saddr, sizeof(saddr));
+}
+
+static int socks5_send_negociate(int fd, const char *user,
+                                 const char *password)
+{
+    uint8_t cmd[4];
+    int len = 0;
+
+    cmd[len++] = SOCKS_VERSION_5;
+    if (user && password) {
+        cmd[len++] = 2;
+        cmd[len++] = SOCKS5_AUTH_METHOD_NONE;
+        cmd[len++] = SOCKS5_AUTH_METHOD_PASSWORD;
+    } else {
+        cmd[len++] = 1;
+        cmd[len++] = SOCKS5_AUTH_METHOD_NONE;
+    }
+    return send(fd, cmd, len, 0);
+}
+
+static int socks5_recv_negociate(int fd)
+{
+    char reply[2];
+
+    /* reply[0] is the protocol version number: 0x05
+     * reply[1] is the selected authentification protocol
+     */
+
+    if (recv(fd, reply, 2, 0) != 2) {
+        return -1;
+    }
+
+    if (reply[0] != SOCKS_VERSION_5) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    return reply[1];
+}
+
+static int socks5_send_password(int fd, const char *user,
+                                const char *password)
+{
+    uint8_t *cmd;
+    int len = 0, ulen, plen;
+
+    if (user == NULL || password == NULL) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    ulen = strlen(user);
+    plen = strlen(password);
+    if (ulen > SOCKS_LEN_MAX || plen > SOCKS_LEN_MAX) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    cmd = alloca(3 + ulen + plen);
+
+    cmd[len++] = SOCKS5_AUTH_PASSWORD_VERSION;
+    cmd[len++] = ulen;
+    memcpy(cmd + len, user, ulen);
+    len += ulen;
+    cmd[len++] = plen;
+    memcpy(cmd + len, password, plen);
+
+    return send(fd, cmd, len, 0);
+}
+
+static int socks5_recv_password(int fd)
+{
+    char reply[2];
+    if (recv(fd, reply, 2, 0) != 2) {
+        return -1;
+    }
+
+    /* reply[0] is the subnegociation version number: 0x01
+     * reply[1] is the status
+     */
+    if (reply[0] != SOCKS5_AUTH_PASSWORD_VERSION ||
+        reply[1] != SOCKS5_AUTH_PASSWORD_SUCCESS) {
+        errno = EINVAL;
+        return -1;
+    }
+    return 0;
+}
+
+static int socks5_send_connect(int fd, struct sockaddr_storage *addr)
+{
+    uint8_t cmd[22]; /* max size with IPv6 address */
+    int len = 0;
+
+    cmd[len++] = SOCKS_VERSION_5;
+    cmd[len++] = SOCKS5_CMD_CONNECT;
+    cmd[len++] = 0; /* reserved */
+
+    switch (addr->ss_family) {
+    case AF_INET: {
+            struct sockaddr_in *a = (struct sockaddr_in *)addr;
+            cmd[len++] = SOCKS5_ATYPE_IPV4;
+            memcpy(cmd + len, &a->sin_addr, 4);
+            len += 4;
+            memcpy(cmd + len, &a->sin_port, 2);
+            len += 2;
+        }
+        break;
+    case AF_INET6: {
+            struct sockaddr_in6 *a = (struct sockaddr_in6 *)addr;
+            cmd[len++] = SOCKS5_ATYPE_IPV6;
+            memcpy(cmd + len, &a->sin6_addr, 16);
+            len += 16;
+            memcpy(cmd + len, &a->sin6_port, 2);
+            len += 2;
+        }
+        break;
+    default:
+        errno = EINVAL;
+        return -1;
+    }
+
+    return send(fd, cmd, len, 0);
+}
+
+static int socks5_recv_connect(int fd)
+{
+    uint8_t reply[7 + SOCKS_LEN_MAX]; /* can contains a FQDN */
+
+    /*
+     * reply[0] is protocol version: 5
+     * reply[1] is reply field
+     * reply[2] is reserved
+     * reply[3] is address type */
+
+    if (recv(fd, reply, 4, 0) != 4) {
+        return -1;
+    }
+
+    if (reply[0] != SOCKS_VERSION_5) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    if (reply[1] != SOCKS5_CMD_SUCCESS) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    switch (reply[3]) {
+    case SOCKS5_ATYPE_IPV4:
+        if (recv(fd, reply + 4, 6, 0) != 6) {
+            return -1;
+        }
+        break;
+    case SOCKS5_ATYPE_IPV6:
+        if (recv(fd, reply + 4, 18, 0) != 18) {
+            return -1;
+        }
+        break;
+    case SOCKS5_ATYPE_FQDN:
+        if (recv(fd, reply + 4, 1, 0) != 1) {
+            return -1;
+        }
+        if (recv(fd, reply + 5,
+                 reply[4], 0) != reply[4]) {
+            return -1;
+        }
+        break;
+    default:
+        errno = EINVAL;
+        return -1;
+    }
+    return 0;
+}
+
+int socks5_socket(socks5_state_t *state)
+{
+    *state = SOCKS5_STATE_CONNECT;
+    return qemu_socket(AF_INET, SOCK_STREAM, 0);
+}
+
+int socks5_connect(int fd, const char *server, int port,
+                   socks5_state_t *state)
+{
+    if (*state != SOCKS5_STATE_CONNECT) {
+        *state = SOCKS5_STATE_NONE;
+        errno = EINVAL;
+        return -1;
+    }
+
+    *state = SOCKS5_STATE_NEGOCIATE;
+    return socks5_proxy_connect(fd, server, port);
+}
+
+int socks5_send(int fd, const char *user, const char *password,
+                struct sockaddr_storage addr, socks5_state_t *state)
+{
+    int ret;
+
+    switch (*state) {
+    case SOCKS5_STATE_NEGOCIATE:
+        ret = socks5_send_negociate(fd, user, password);
+        if (ret < 0) {
+            return ret;
+        }
+        ret = 0;
+        *state = SOCKS5_STATE_NEGOCIATING;
+        break;
+    case SOCKS5_STATE_AUTHENTICATE:
+        ret = socks5_send_password(fd, user, password);
+        if (ret < 0) {
+            return ret;
+        }
+        ret = 0;
+        *state = SOCKS5_STATE_AUTHENTICATING;
+        break;
+    case SOCKS5_STATE_ESTABLISH:
+        ret = socks5_send_connect(fd, &addr);
+        if (ret < 0) {
+            return ret;
+        }
+        ret = 0;
+        *state = SOCKS5_STATE_ESTABLISHING;
+        break;
+    case SOCKS5_STATE_NONE:
+        ret = 1;
+        break;
+    default:
+        ret = 0;
+        break;
+    }
+    return ret;
+}
+
+void socks5_recv(int fd, socks5_state_t *state)
+{
+    int ret;
+
+    switch (*state) {
+    case SOCKS5_STATE_NEGOCIATING:
+        switch (socks5_recv_negociate(fd)) {
+        case SOCKS5_AUTH_METHOD_NONE: /* no authentification */
+            *state = SOCKS5_STATE_ESTABLISH;
+            break;
+        case SOCKS5_AUTH_METHOD_PASSWORD: /* username/password */
+            *state = SOCKS5_STATE_AUTHENTICATE;
+            break;
+        default:
+            break;
+        }
+        break;
+    case SOCKS5_STATE_AUTHENTICATING:
+        ret = socks5_recv_password(fd);
+        if (ret >= 0) {
+            *state = SOCKS5_STATE_ESTABLISH;
+        }
+        break;
+    case SOCKS5_STATE_ESTABLISHING:
+        ret = socks5_recv_connect(fd);
+        if (ret >= 0) {
+            *state = SOCKS5_STATE_NONE;
+        }
+        break;
+    default:
+        break;
+    }
+}
diff --git a/slirp/socks5.h b/slirp/socks5.h
new file mode 100644
index 0000000..24ff1d7
--- /dev/null
+++ b/slirp/socks5.h
@@ -0,0 +1,24 @@
+#ifndef SOCKS5_H
+#define SOCKS5_H
+
+#include <sys/types.h>
+#include <sys/socket.h>
+
+typedef enum {
+    SOCKS5_STATE_NONE = 0,
+    SOCKS5_STATE_CONNECT,
+    SOCKS5_STATE_NEGOCIATE,
+    SOCKS5_STATE_NEGOCIATING,
+    SOCKS5_STATE_AUTHENTICATE,
+    SOCKS5_STATE_AUTHENTICATING,
+    SOCKS5_STATE_ESTABLISH,
+    SOCKS5_STATE_ESTABLISHING,
+} socks5_state_t;
+
+int socks5_socket(socks5_state_t *state);
+int socks5_connect(int fd, const char *server, int port,
+                   socks5_state_t *state);
+int socks5_send(int fd, const char *user, const char *password,
+                struct sockaddr_storage addr, socks5_state_t *state);
+void socks5_recv(int fd, socks5_state_t *state);
+#endif
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index ed16e18..14fde73 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -40,6 +40,7 @@
 
 #include "qemu/osdep.h"
 #include "slirp.h"
+#include "socks5.h"
 
 /* patchable/settable parameters for tcp */
 /* Don't do rfc1323 performance enhancements */
@@ -394,11 +395,22 @@ tcp_sockclosed(struct tcpcb *tp)
 int tcp_fconnect(struct socket *so, unsigned short af)
 {
   int ret=0;
+  Slirp *slirp = so->slirp;
 
   DEBUG_CALL("tcp_fconnect");
   DEBUG_ARG("so = %p", so);
 
-  ret = so->s = qemu_socket(af, SOCK_STREAM, 0);
+  /* pass all non-local traffic through the proxy */
+  if (slirp->proxy_server &&
+      !(af == AF_INET &&
+        (so->so_faddr.s_addr & slirp->vnetwork_mask.s_addr) ==
+        slirp->vnetwork_addr.s_addr) &&
+      !(af == AF_INET6 && in6_equal_host(&so->so_faddr6))) {
+    ret = so->s = socks5_socket(&so->so_proxy_state);
+  } else {
+    ret = so->s = qemu_socket(af, SOCK_STREAM, 0);
+  }
+
   if (ret >= 0) {
     int opt, s=so->s;
     struct sockaddr_storage addr;
@@ -413,8 +425,12 @@ int tcp_fconnect(struct socket *so, unsigned short af)
     sotranslate_out(so, &addr);
 
     /* We don't care what port we get */
-    ret = connect(s, (struct sockaddr *)&addr, sockaddr_size(&addr));
-
+    if (so->so_proxy_state) {
+      ret = socks5_connect(s, slirp->proxy_server, slirp->proxy_port,
+                           &so->so_proxy_state);
+    } else {
+      ret = connect(s, (struct sockaddr *)&addr, sockaddr_size(&addr));
+    }
     /*
      * If it's not in progress, it failed, so we just return 0,
      * without clearing SS_NOFDREF
diff --git a/slirp/udp.c b/slirp/udp.c
index 227d779..1f4b39c 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -160,6 +160,15 @@ udp_input(register struct mbuf *m, int iphlen)
             goto bad;
         }
 
+        /* as our SOCKS5 client is not able to route UDP packets,
+         * only allow local UDP traffic (we need it for DNS)
+         */
+        if (slirp->proxy_server &&
+            (ip->ip_dst.s_addr & slirp->vnetwork_mask.s_addr) !=
+            slirp->vnetwork_addr.s_addr) {
+            goto bad;
+        }
+
 	/*
 	 * Locate pcb for datagram.
 	 */
diff --git a/slirp/udp6.c b/slirp/udp6.c
index 9fa314b..173e930 100644
--- a/slirp/udp6.c
+++ b/slirp/udp6.c
@@ -27,6 +27,14 @@ void udp6_input(struct mbuf *m)
     }
 
     ip = mtod(m, struct ip6 *);
+
+    /* as our SOCKS5 client is not able to route UDP6 packets,
+     * only allow local UDP6 traffic
+     */
+    if (slirp->proxy_server && !in6_equal_host(&ip->ip_dst)) {
+        goto bad;
+    }
+
     m->m_len -= iphlen;
     m->m_data += iphlen;
     uh = mtod(m, struct udphdr *);
-- 
2.9.3
