Received: from eggs.gnu.org ([2001:4830:134:3::10]:38018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1csZH8-0007vI-Rr
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1csZH4-00030H-RR
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:21:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1csZH4-0002zw-8q
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:21:50 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 27 Mar 2017 20:21:37 +0200
Message-Id: <20170327182137.7006-2-laurent@vivier.eu>
In-Reply-To: <20170327182137.7006-1-laurent@vivier.eu>
References: <20170327182137.7006-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>

When the VM is used behind a firewall, This allows
to use a SOCKS5 proxy server to connect the VM IP stack
directly to the Internet.

This implementation doesn't manage UDP packets, so they
are simply dropped (as with restrict=on), except for
the localhost as we need it for DNS.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 net/slirp.c         |  30 +++++-
 qapi-schema.json    |   3 +
 qemu-options.hx     |  11 ++
 slirp/Makefile.objs |   2 +-
 slirp/ip_icmp.c     |   2 +-
 slirp/libslirp.h    |   3 +
 slirp/slirp.c       |  66 +++++++++++-
 slirp/slirp.h       |   6 ++
 slirp/socket.h      |   4 +
 slirp/socks5.c      | 283 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/socks5.h      |  85 ++++++++++++++++
 slirp/tcp_subr.c    |  21 +++-
 slirp/udp.c         |   9 ++
 slirp/udp6.c        |   2 +-
 14 files changed, 515 insertions(+), 12 deletions(-)
 create mode 100644 slirp/socks5.c
 create mode 100644 slirp/socks5.h

diff --git a/net/slirp.c b/net/slirp.c
index f97ec23..7299b54 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -139,6 +139,26 @@ static void net_slirp_cleanup(NetClientState *nc)
     QTAILQ_REMOVE(&slirp_stacks, s, entry);
 }
 
+static int net_slirp_add_proxy(SlirpState *s, const char *proxy_server,
+                               const char *proxy_user, const char *proxy_passwd)
+{
+    InetSocketAddress *addr;
+    int ret;
+
+    if (proxy_server == NULL) {
+        return 0;
+    }
+
+    addr = inet_parse(proxy_server, &error_fatal);
+
+    ret = slirp_add_proxy(s->slirp, addr->host, atoi(addr->port),
+                          proxy_user, proxy_passwd);
+
+    qapi_free_InetSocketAddress(addr);
+
+    return ret;
+}
+
 static NetClientInfo net_slirp_info = {
     .type = NET_CLIENT_DRIVER_USER,
     .size = sizeof(SlirpState),
@@ -155,7 +175,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
                           const char *bootfile, const char *vdhcp_start,
                           const char *vnameserver, const char *vnameserver6,
                           const char *smb_export, const char *vsmbserver,
-                          const char **dnssearch)
+                          const char **dnssearch, const char *proxy_server,
+                          const char *proxy_user, const char *proxy_passwd)
 {
     /* default settings according to historic slirp */
     struct in_addr net  = { .s_addr = htonl(0x0a000200) }; /* 10.0.2.0 */
@@ -361,6 +382,10 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     }
 #endif
 
+    if (net_slirp_add_proxy(s, proxy_server, proxy_user, proxy_passwd) < 0) {
+        goto error;
+    }
+
     s->exit_notifier.notify = slirp_smb_exit;
     qemu_add_exit_notifier(&s->exit_notifier);
     return 0;
@@ -878,7 +903,8 @@ int net_init_slirp(const Netdev *netdev, const char *name,
                          user->ipv6_host, user->hostname, user->tftp,
                          user->bootfile, user->dhcpstart,
                          user->dns, user->ipv6_dns, user->smb,
-                         user->smbserver, dnssearch);
+                         user->smbserver, dnssearch, user->proxy_server,
+                         user->proxy_user, user->proxy_passwd);
 
     while (slirp_configs) {
         config = slirp_configs;
diff --git a/qapi-schema.json b/qapi-schema.json
index 68a4327..62eb23b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3680,6 +3680,9 @@
     '*ipv6-dns':         'str',
     '*smb':       'str',
     '*smbserver': 'str',
+    '*proxy-server': 'str',
+    '*proxy-user':   'str',
+    '*proxy-passwd': 'str',
     '*hostfwd':   ['String'],
     '*guestfwd':  ['String'] } }
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 99af8ed..472ab6a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1645,6 +1645,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #ifndef _WIN32
                                              "[,smb=dir[,smbserver=addr]]\n"
 #endif
+    "         [,proxy-server=addr:port[,proxy-user=user,proxy-passwd=passwd]]\n"
     "                configure a user mode network backend with ID 'str',\n"
     "                its DHCP server and optional services\n"
 #endif
@@ -1883,6 +1884,16 @@ Note that a SAMBA server must be installed on the host OS.
 QEMU was tested successfully with smbd versions from Red Hat 9,
 Fedora Core 3 and OpenSUSE 11.x.
 
+@item proxy-server=@var{addr}:@var{port}[,proxy-user=@var{user},proxy-passwd=@var{passwd}]]
+If you provide a SOCKS5 proxy server address @var{addr} and a port number @var{port},
+QEMU will use it to connect to Internet. If the proxy server needs an user id and a password
+the values are provided with proxy-user and proxy-passwd.
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
index f90f0f5..d16f2b0 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -26,6 +26,9 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error);
 
 void slirp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len);
 
+int slirp_add_proxy(Slirp *slirp, const char *server, int port,
+                    const char *user, const char *passwd);
+
 /* you must provide the following functions: */
 void slirp_output(void *opaque, const uint8_t *pkt, int pkt_len);
 
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 60539de..0385e2f 100644
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
+                                          slirp->proxy_passwd, so->fhost.ss,
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
@@ -1069,6 +1085,48 @@ int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
                     htons(guest_port));
 }
 
+int slirp_add_proxy(Slirp *slirp, const char *server, int port,
+                    const char *user, const char *passwd)
+{
+    int fd;
+    socks5_state_t state;
+    struct sockaddr_storage addr;
+
+    /* check the connection */
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
+        if (socks5_send(fd, user, passwd, addr, &state) < 0) {
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
+    if (passwd) {
+        slirp->proxy_passwd = g_strdup(passwd);
+    }
+
+    return 0;
+}
+
 ssize_t slirp_send(struct socket *so, const void *buf, size_t len, int flags)
 {
     if (so->s == -1 && so->extra) {
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 3877f66..9478a83 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -214,6 +214,12 @@ struct Slirp {
     char *tftp_prefix;
     struct tftp_session tftp_sessions[TFTP_SESSIONS_MAX];
 
+    /* proxy */
+    char *proxy_server;
+    int proxy_port;
+    char *proxy_user;
+    char *proxy_passwd;
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
index 0000000..9f2d2f1
--- /dev/null
+++ b/slirp/socks5.c
@@ -0,0 +1,283 @@
+/* some parts from nmap/ncat GPLv2 */
+
+#include "qemu/osdep.h"
+#include "qemu/sockets.h"
+
+#include "socks5.h"
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
+    saddr.sin_family = AF_INET;
+    saddr.sin_addr = *(struct in_addr *)he->h_addr;
+    saddr.sin_port = htons(port);
+
+    return connect(fd, (struct sockaddr *)&saddr, sizeof(saddr));
+}
+
+static int socks5_send_negociate(int fd, const char *user, const char *passwd)
+{
+    struct socks5_connect socks5msg;
+    int len;
+
+    memset(&socks5msg, 0, sizeof(socks5msg));
+    socks5msg.ver = SOCKS5_VERSION;
+    socks5msg.nmethods = 1;
+    socks5msg.methods[0] = SOCKS5_AUTH_NONE;
+    len = 3;
+
+    if (user && passwd) {
+        socks5msg.nmethods++;
+        socks5msg.methods[1] = SOCKS5_AUTH_USERPASS;
+        len++;
+    }
+
+    return send(fd, (char *)&socks5msg, len, 0);
+}
+
+static int socks5_recv_negociate(int fd)
+{
+    char socksbuf[2];
+
+    /* socksbuf[0] is the protocol version number: 0x05
+     * socksbuf[1] is the selected authentification protocol
+     */
+
+    if (recv(fd, socksbuf, 2, 0) != 2) {
+        return -1;
+    }
+
+    if (socksbuf[0] != SOCKS5_VERSION) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    return socksbuf[1];
+}
+
+static int socks5_send_authenticate(int fd, const char *user,
+                                    const char *passwd)
+{
+    struct socks5_auth socks5auth;
+    int len;
+
+    if (user == NULL || passwd == NULL) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    if (strlen(user) + strlen(passwd) > SOCKS_BUFF_SIZE - 2) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    socks5auth.ver = 1;
+    socks5auth.data[0] = strlen(user);
+    memcpy(socks5auth.data + 1, user, strlen(user));
+    len = 2 + strlen(user);
+
+    socks5auth.data[len - 1] = strlen(passwd);
+    memcpy(socks5auth.data + len, passwd, strlen(passwd));
+    len += 1 + strlen(passwd);
+
+    return send(fd, (char *)&socks5auth, len, 0);
+}
+
+static int socks5_recv_authenticate(int fd)
+{
+    char socksbuf[2];
+    if (recv(fd, socksbuf, 2, 0) != 2) {
+        return -1;
+    }
+    if (socksbuf[0] != 1 || socksbuf[1] != 0) {
+        errno = EINVAL;
+        return -1;
+    }
+    return 0;
+}
+
+static int socks5_send_connect(int fd, struct sockaddr_storage *addr)
+{
+    struct socks5_request socks5msg;
+    int len;
+
+    memset(&socks5msg, 0, sizeof(socks5msg));
+
+    socks5msg.ver = SOCKS5_VERSION;
+    socks5msg.cmd = SOCKS_CONNECT;
+    socks5msg.rsv = 0;
+
+    switch (addr->ss_family) {
+    case AF_INET: {
+            struct sockaddr_in *a = (struct sockaddr_in *)addr;
+
+            socks5msg.atyp = SOCKS5_ATYP_IPv4;
+            memcpy(socks5msg.dst, &a->sin_addr, sizeof(a->sin_addr));
+            len = sizeof(a->sin_addr);
+            memcpy(socks5msg.dst + len, &a->sin_port, sizeof(a->sin_port));
+            len += sizeof(a->sin_port);
+        }
+        break;
+    case AF_INET6: {
+            struct sockaddr_in6 *a = (struct sockaddr_in6 *)addr;
+
+            socks5msg.atyp = SOCKS5_ATYP_IPv6;
+            memcpy(socks5msg.dst, &a->sin6_addr, sizeof(a->sin6_addr));
+            len = sizeof(a->sin6_addr);
+            memcpy(socks5msg.dst + len, &a->sin6_port, sizeof(a->sin6_port));
+            len += sizeof(a->sin6_port);
+        }
+        break;
+    default:
+        errno = EINVAL;
+        return -1;
+    }
+    len += 4;
+
+    return send(fd, (char *)&socks5msg, len, 0);
+}
+
+static int socks5_recv_connect(int fd)
+{
+    struct socks5_request socks5msg;
+
+    if (recv(fd, &socks5msg, 4, 0) != 4) {
+        return -1;
+    }
+
+    if (socks5msg.ver != SOCKS5_VERSION) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    if (socks5msg.cmd != 0x00) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    switch (socks5msg.atyp) {
+    case SOCKS5_ATYP_IPv4:
+        if (recv(fd, socks5msg.dst, 6, 0) != 6) {
+            return -1;
+        }
+        break;
+    case SOCKS5_ATYP_IPv6:
+        if (recv(fd, socks5msg.dst, 18, 0) != 18) {
+            return -1;
+        }
+        break;
+    case SOCKS5_ATYP_NAME:
+        if (recv(fd, socks5msg.dst, 1, 0) != 1) {
+            return -1;
+        }
+        if (recv(fd, socks5msg.dst + 1,
+                 socks5msg.dst[0], 0) != socks5msg.dst[0]) {
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
+int socks5_send(int fd, const char *user, const char *passwd,
+                struct sockaddr_storage addr, socks5_state_t *state)
+{
+    int ret;
+
+    switch (*state) {
+    case SOCKS5_STATE_NEGOCIATE:
+        ret = socks5_send_negociate(fd, user, passwd);
+        if (ret < 0) {
+            return ret;
+        }
+        ret = 0;
+        *state = SOCKS5_STATE_NEGOCIATING;
+        break;
+    case SOCKS5_STATE_AUTHENTICATE:
+        ret = socks5_send_authenticate(fd, user, passwd);
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
+        case SOCKS5_AUTH_NONE: /* no authentification */
+            *state = SOCKS5_STATE_ESTABLISH;
+            break;
+        case SOCKS5_AUTH_USERPASS: /* username/password */
+            *state = SOCKS5_STATE_AUTHENTICATE;
+            break;
+        default:
+            break;
+        }
+        break;
+    case SOCKS5_STATE_AUTHENTICATING:
+        ret = socks5_recv_authenticate(fd);
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
index 0000000..895cc88
--- /dev/null
+++ b/slirp/socks5.h
@@ -0,0 +1,85 @@
+#ifndef SOCKS5_H
+#define SOCKS5_H
+
+#include <sys/types.h>
+#include <sys/socket.h>
+
+/* some parts from nmap/ncat GPLv2 */
+
+#define SOCKS_BUFF_SIZE 512
+
+struct socks4_data {
+    char version;
+    char type;
+    unsigned short port;
+    uint32_t address;
+    char data[SOCKS_BUFF_SIZE]; /* to hold FQDN and username */
+} __attribute__((packed));
+
+struct socks5_connect {
+    char ver;
+    char nmethods;
+    char methods[3];
+} __attribute__((packed));
+
+struct socks5_auth {
+  char ver; /* must be always 1 */
+  char data[SOCKS_BUFF_SIZE];
+} __attribute__((packed));
+
+struct socks5_request {
+    char ver;
+    char cmd;
+    char rsv;
+    char atyp;
+    char dst[SOCKS_BUFF_SIZE]; /* addr/name and port info */
+} __attribute__((packed));
+
+/* defines */
+
+/* Default port for SOCKS5 */
+#define DEFAULT_SOCKS5_PORT 1080
+
+/* SOCKS4 protocol responses */
+#define SOCKS4_VERSION          4
+#define SOCKS_CONNECT           1
+#define SOCKS_BIND              2
+#define SOCKS4_CONN_ACC         90
+#define SOCKS4_CONN_REF         91
+#define SOCKS4_CONN_IDENT       92
+#define SOCKS4_CONN_IDENTDIFF   93
+
+/* SOCKS5 protocol */
+#define SOCKS5_VERSION          5
+#define SOCKS5_AUTH_NONE        0
+#define SOCKS5_AUTH_GSSAPI      1
+#define SOCKS5_AUTH_USERPASS    2
+#define SOCKS5_AUTH_FAILED      255
+#define SOCKS5_ATYP_IPv4        1
+#define SOCKS5_ATYP_NAME        3
+#define SOCKS5_ATYP_IPv6        4
+
+
+/* Length of IPv6 address */
+#ifndef INET6_ADDRSTRLEN
+#define INET6_ADDRSTRLEN 46
+#endif
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
+int socks5_send(int fd, const char *user, const char *passwd,
+                struct sockaddr_storage addr, socks5_state_t *state);
+void socks5_recv(int fd, socks5_state_t *state);
+#endif
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index ed16e18..5e394fd 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -40,6 +40,7 @@
 
 #include "qemu/osdep.h"
 #include "slirp.h"
+#include "socks5.h"
 
 /* patchable/settable parameters for tcp */
 /* Don't do rfc1323 performance enhancements */
@@ -394,11 +395,21 @@ tcp_sockclosed(struct tcpcb *tp)
 int tcp_fconnect(struct socket *so, unsigned short af)
 {
   int ret=0;
+  Slirp *slirp = so->slirp;
 
   DEBUG_CALL("tcp_fconnect");
   DEBUG_ARG("so = %p", so);
 
-  ret = so->s = qemu_socket(af, SOCK_STREAM, 0);
+  /* local traffic doesn't go to the proxy */
+  if (slirp->proxy_server &&
+      !(af == AF_INET &&
+        (so->so_faddr.s_addr & slirp->vnetwork_mask.s_addr) ==
+        slirp->vnetwork_addr.s_addr)) {
+    ret = so->s = socks5_socket(&so->so_proxy_state);
+  } else {
+    ret = so->s = qemu_socket(af, SOCK_STREAM, 0);
+  }
+
   if (ret >= 0) {
     int opt, s=so->s;
     struct sockaddr_storage addr;
@@ -413,8 +424,12 @@ int tcp_fconnect(struct socket *so, unsigned short af)
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
index 9fa314b..995181d 100644
--- a/slirp/udp6.c
+++ b/slirp/udp6.c
@@ -22,7 +22,7 @@ void udp6_input(struct mbuf *m)
     DEBUG_CALL("udp6_input");
     DEBUG_ARG("m = %lx", (long)m);
 
-    if (slirp->restricted) {
+    if (slirp->restricted || slirp->proxy_server) {
         goto bad;
     }
 
-- 
2.9.3
