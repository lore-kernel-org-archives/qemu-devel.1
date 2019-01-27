Received: from eggs.gnu.org ([209.51.188.92]:52722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCI-0001V5-Fk
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCC-0007Sx-1g
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:58 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:46450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCB-0007PZ-JJ
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:51 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:06 +0100
Message-Id: <20190127120526.15457-12-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/31] slirp: replace most qemu socket utilities
 with slirp own version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qemu_set_nonblock() is slightly more problematic and will be dealt
with in a separate patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/Makefile.objs |   3 +-
 slirp/ip_icmp.c     |   6 +-
 slirp/misc.c        |  20 ++---
 slirp/socket.c      |  18 ++---
 slirp/tcp_subr.c    |  18 ++---
 slirp/udp.c         |   8 +-
 slirp/util.c        | 176 ++++++++++++++++++++++++++++++++++++++++++++
 slirp/util.h        |  61 +++++++++++++++
 8 files changed, 274 insertions(+), 36 deletions(-)
 create mode 100644 slirp/util.c

diff --git a/slirp/Makefile.objs b/slirp/Makefile.objs
index 959558c732..d2ead94b3b 100644
--- a/slirp/Makefile.objs
+++ b/slirp/Makefile.objs
@@ -27,6 +27,7 @@ slirp.mo-objs =3D \
 	tftp.o \
 	udp.o \
 	udp6.o \
+	util.o \
 	$(NULL)
=20
-slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\"
+slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\" -DWITH_QEMU
diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 7c7e042049..b59daa801d 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -83,7 +83,7 @@ static int icmp_send(struct socket *so, struct mbuf *m,=
 int hlen)
     struct ip *ip =3D mtod(m, struct ip *);
     struct sockaddr_in addr;
=20
-    so->s =3D qemu_socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
+    so->s =3D slirp_socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
     if (so->s =3D=3D -1) {
         return -1;
     }
@@ -114,7 +114,7 @@ static int icmp_send(struct socket *so, struct mbuf *=
m, int hlen)
=20
 void icmp_detach(struct socket *so)
 {
-    closesocket(so->s);
+    slirp_closesocket(so->s);
     sofree(so);
 }
=20
@@ -421,7 +421,7 @@ void icmp_receive(struct socket *so)
     icp =3D mtod(m, struct icmp *);
=20
     id =3D icp->icmp_id;
-    len =3D qemu_recv(so->s, icp, M_ROOM(m), 0);
+    len =3D slirp_recv(so->s, icp, M_ROOM(m), 0);
     /*
      * The behavior of reading SOCK_DGRAM+IPPROTO_ICMP sockets is incons=
istent
      * between host OSes.  On Linux, only the ICMP header and payload is
diff --git a/slirp/misc.c b/slirp/misc.c
index b8a2bf971a..32ec02a525 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -72,14 +72,14 @@ slirp_socketpair_with_oob(int sv[2])
     int ret, s;
=20
     sv[1] =3D -1;
-    s =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
+    s =3D slirp_socket(AF_INET, SOCK_STREAM, 0);
     if (s < 0 || bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
         listen(s, 1) < 0 ||
         getsockname(s, (struct sockaddr *)&addr, &addrlen) < 0) {
         goto err;
     }
=20
-    sv[1] =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
+    sv[1] =3D slirp_socket(AF_INET, SOCK_STREAM, 0);
     if (sv[1] < 0) {
         goto err;
     }
@@ -102,16 +102,16 @@ slirp_socketpair_with_oob(int sv[2])
         goto err;
     }
=20
-    closesocket(s);
+    slirp_closesocket(s);
     return 0;
=20
 err:
     g_critical("slirp_socketpair(): %s", strerror(errno));
     if (s >=3D 0) {
-        closesocket(s);
+        slirp_closesocket(s);
     }
     if (sv[1] >=3D 0) {
-        closesocket(sv[1]);
+        slirp_closesocket(sv[1]);
     }
     return -1;
 }
@@ -153,16 +153,16 @@ fork_exec(struct socket *so, const char *ex)
     if (err) {
         g_critical("fork_exec: %s", err->message);
         g_error_free(err);
-        closesocket(sp[0]);
-        closesocket(sp[1]);
+        slirp_closesocket(sp[0]);
+        slirp_closesocket(sp[1]);
         return 0;
     }
=20
     so->s =3D sp[0];
-    closesocket(sp[1]);
-    socket_set_fast_reuse(so->s);
+    slirp_closesocket(sp[1]);
+    slirp_socket_set_fast_reuse(so->s);
     opt =3D 1;
-    qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
+    slirp_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int))=
;
     qemu_set_nonblock(so->s);
     return 1;
 }
diff --git a/slirp/socket.c b/slirp/socket.c
index 5ffbaa064a..5805d30f3d 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -187,7 +187,7 @@ soread(struct socket *so)
 	 */
 	sopreprbuf(so, iov, &n);
=20
-	nn =3D qemu_recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
+	nn =3D slirp_recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
 	if (nn <=3D 0) {
 		if (nn < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN))
 			return 0;
@@ -203,7 +203,7 @@ soread(struct socket *so)
 				if (getpeername(so->s, paddr, &alen) < 0) {
 					err =3D errno;
 				} else {
-					getsockopt(so->s, SOL_SOCKET, SO_ERROR,
+					slirp_getsockopt(so->s, SOL_SOCKET, SO_ERROR,
 						&err, &elen);
 				}
 			}
@@ -233,7 +233,7 @@ soread(struct socket *so)
 	 */
 	if (n =3D=3D 2 && nn =3D=3D iov[0].iov_len) {
             int ret;
-            ret =3D qemu_recv(so->s, iov[1].iov_base, iov[1].iov_len,0);
+            ret =3D slirp_recv(so->s, iov[1].iov_base, iov[1].iov_len,0)=
;
             if (ret > 0)
                 nn +=3D ret;
         }
@@ -554,7 +554,7 @@ sorecvfrom(struct socket *so)
 	   */
 	  len =3D M_FREEROOM(m);
 	  /* if (so->so_fport !=3D htons(53)) { */
-	  ioctlsocket(so->s, FIONREAD, &n);
+	  slirp_ioctlsocket(so->s, FIONREAD, &n);
=20
 	  if (n > len) {
 	    n =3D (m->m_data - m->m_dat) + m->m_len + n + 1;
@@ -719,14 +719,14 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hpor=
t, uint32_t laddr,
 	addr.sin_addr.s_addr =3D haddr;
 	addr.sin_port =3D hport;
=20
-	if (((s =3D qemu_socket(AF_INET,SOCK_STREAM,0)) < 0) ||
-	    (socket_set_fast_reuse(s) < 0) ||
+	if (((s =3D slirp_socket(AF_INET,SOCK_STREAM,0)) < 0) ||
+	    (slirp_socket_set_fast_reuse(s) < 0) ||
 	    (bind(s,(struct sockaddr *)&addr, sizeof(addr)) < 0) ||
 	    (listen(s,1) < 0)) {
 		int tmperrno =3D errno; /* Don't clobber the real reason we failed */
=20
                 if (s >=3D 0) {
-                    closesocket(s);
+                    slirp_closesocket(s);
                 }
 		sofree(so);
 		/* Restore the real errno */
@@ -737,9 +737,9 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport,=
 uint32_t laddr,
 #endif
 		return NULL;
 	}
-	qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
+	slirp_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
 	opt =3D 1;
-	qemu_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(int));
+	slirp_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(int));
=20
 	getsockname(s,(struct sockaddr *)&addr,&addrlen);
 	so->so_ffamily =3D AF_INET;
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 4e81736d6f..3567f320ff 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -337,7 +337,7 @@ tcp_close(struct tcpcb *tp)
 	/* clobber input socket cache if we're closing the cached connection */
 	if (so =3D=3D slirp->tcp_last_so)
 		slirp->tcp_last_so =3D &slirp->tcb;
-	closesocket(so->s);
+	slirp_closesocket(so->s);
 	sbfree(&so->so_rcv);
 	sbfree(&so->so_snd);
 	sofree(so);
@@ -407,17 +407,17 @@ int tcp_fconnect(struct socket *so, unsigned short =
af)
   DEBUG_CALL("tcp_fconnect");
   DEBUG_ARG("so =3D %p", so);
=20
-  ret =3D so->s =3D qemu_socket(af, SOCK_STREAM, 0);
+  ret =3D so->s =3D slirp_socket(af, SOCK_STREAM, 0);
   if (ret >=3D 0) {
     int opt, s=3Dso->s;
     struct sockaddr_storage addr;
=20
     qemu_set_nonblock(s);
-    socket_set_fast_reuse(s);
+    slirp_socket_set_fast_reuse(s);
     opt =3D 1;
-    qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
+    slirp_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
     opt =3D 1;
-    qemu_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
+    slirp_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
=20
     addr =3D so->fhost.ss;
     DEBUG_CALL(" connect()ing");
@@ -485,10 +485,10 @@ void tcp_connect(struct socket *inso)
         return;
     }
     qemu_set_nonblock(s);
-    socket_set_fast_reuse(s);
+    slirp_socket_set_fast_reuse(s);
     opt =3D 1;
-    qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
-    socket_set_nodelay(s);
+    slirp_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
+    slirp_socket_set_nodelay(s);
=20
     so->fhost.ss =3D addr;
     sotranslate_accept(so);
@@ -496,7 +496,7 @@ void tcp_connect(struct socket *inso)
     /* Close the accept() socket, set right state */
     if (inso->so_state & SS_FACCEPTONCE) {
         /* If we only accept once, close the accept() socket */
-        closesocket(so->s);
+        slirp_closesocket(so->s);
=20
         /* Don't select it yet, even though we have an FD */
         /* if it's not FACCEPTONCE, it's already NOFDREF */
diff --git a/slirp/udp.c b/slirp/udp.c
index 309feb9aae..6c3fb9a29f 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -281,7 +281,7 @@ int udp_output(struct socket *so, struct mbuf *m,
 int
 udp_attach(struct socket *so, unsigned short af)
 {
-  so->s =3D qemu_socket(af, SOCK_DGRAM, 0);
+  so->s =3D slirp_socket(af, SOCK_DGRAM, 0);
   if (so->s !=3D -1) {
     so->so_expire =3D curtime + SO_EXPIRE;
     insque(so, &so->slirp->udb);
@@ -292,7 +292,7 @@ udp_attach(struct socket *so, unsigned short af)
 void
 udp_detach(struct socket *so)
 {
-	closesocket(so->s);
+	slirp_closesocket(so->s);
 	sofree(so);
 }
=20
@@ -327,7 +327,7 @@ udp_listen(Slirp *slirp, uint32_t haddr, u_int hport,=
 uint32_t laddr,
 	socklen_t addrlen =3D sizeof(struct sockaddr_in);
=20
 	so =3D socreate(slirp);
-	so->s =3D qemu_socket(AF_INET,SOCK_DGRAM,0);
+	so->s =3D slirp_socket(AF_INET,SOCK_DGRAM,0);
         if (so->s < 0) {
             sofree(so);
             return NULL;
@@ -343,7 +343,7 @@ udp_listen(Slirp *slirp, uint32_t haddr, u_int hport,=
 uint32_t laddr,
 		udp_detach(so);
 		return NULL;
 	}
-	socket_set_fast_reuse(so->s);
+	slirp_socket_set_fast_reuse(so->s);
=20
 	getsockname(so->s,(struct sockaddr *)&addr,&addrlen);
 	so->fhost.sin =3D addr;
diff --git a/slirp/util.c b/slirp/util.c
new file mode 100644
index 0000000000..b1a36b27bc
--- /dev/null
+++ b/slirp/util.c
@@ -0,0 +1,176 @@
+/*
+ * util.c (mostly based on QEMU os-win32.c)
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2010-2016 Red Hat, Inc.
+ *
+ * QEMU library functions for win32 which are shared between QEMU and
+ * the QEMU tools.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "util.h"
+
+#include <glib.h>
+#include <fcntl.h>
+#include <stdint.h>
+
+#if defined(_WIN32) && !defined(WITH_QEMU)
+int inet_aton(const char *cp, struct in_addr *ia)
+{
+    uint32_t addr =3D inet_addr(cp);
+    if (addr =3D=3D 0xffffffff) {
+        return 0;
+    }
+    ia->s_addr =3D addr;
+    return 1;
+}
+#endif
+
+static void slirp_set_cloexec(int fd)
+{
+#ifndef _WIN32
+    int f;
+    f =3D fcntl(fd, F_GETFD);
+    assert(f !=3D -1);
+    f =3D fcntl(fd, F_SETFD, f | FD_CLOEXEC);
+    assert(f !=3D -1);
+#endif
+}
+
+/*
+ * Opens a socket with FD_CLOEXEC set
+ */
+int slirp_socket(int domain, int type, int protocol)
+{
+    int ret;
+
+#ifdef SOCK_CLOEXEC
+    ret =3D socket(domain, type | SOCK_CLOEXEC, protocol);
+    if (ret !=3D -1 || errno !=3D EINVAL) {
+        return ret;
+    }
+#endif
+    ret =3D socket(domain, type, protocol);
+    if (ret >=3D 0) {
+        slirp_set_cloexec(ret);
+    }
+
+    return ret;
+}
+
+#ifdef _WIN32
+static int socket_error(void)
+{
+    switch (WSAGetLastError()) {
+    case 0:
+        return 0;
+    case WSAEINTR:
+        return EINTR;
+    case WSAEINVAL:
+        return EINVAL;
+    case WSA_INVALID_HANDLE:
+        return EBADF;
+    case WSA_NOT_ENOUGH_MEMORY:
+        return ENOMEM;
+    case WSA_INVALID_PARAMETER:
+        return EINVAL;
+    case WSAENAMETOOLONG:
+        return ENAMETOOLONG;
+    case WSAENOTEMPTY:
+        return ENOTEMPTY;
+    case WSAEWOULDBLOCK:
+         /* not using EWOULDBLOCK as we don't want code to have
+          * to check both EWOULDBLOCK and EAGAIN */
+        return EAGAIN;
+    case WSAEINPROGRESS:
+        return EINPROGRESS;
+    case WSAEALREADY:
+        return EALREADY;
+    case WSAENOTSOCK:
+        return ENOTSOCK;
+    case WSAEDESTADDRREQ:
+        return EDESTADDRREQ;
+    case WSAEMSGSIZE:
+        return EMSGSIZE;
+    case WSAEPROTOTYPE:
+        return EPROTOTYPE;
+    case WSAENOPROTOOPT:
+        return ENOPROTOOPT;
+    case WSAEPROTONOSUPPORT:
+        return EPROTONOSUPPORT;
+    case WSAEOPNOTSUPP:
+        return EOPNOTSUPP;
+    case WSAEAFNOSUPPORT:
+        return EAFNOSUPPORT;
+    case WSAEADDRINUSE:
+        return EADDRINUSE;
+    case WSAEADDRNOTAVAIL:
+        return EADDRNOTAVAIL;
+    case WSAENETDOWN:
+        return ENETDOWN;
+    case WSAENETUNREACH:
+        return ENETUNREACH;
+    case WSAENETRESET:
+        return ENETRESET;
+    case WSAECONNABORTED:
+        return ECONNABORTED;
+    case WSAECONNRESET:
+        return ECONNRESET;
+    case WSAENOBUFS:
+        return ENOBUFS;
+    case WSAEISCONN:
+        return EISCONN;
+    case WSAENOTCONN:
+        return ENOTCONN;
+    case WSAETIMEDOUT:
+        return ETIMEDOUT;
+    case WSAECONNREFUSED:
+        return ECONNREFUSED;
+    case WSAELOOP:
+        return ELOOP;
+    case WSAEHOSTUNREACH:
+        return EHOSTUNREACH;
+    default:
+        return EIO;
+    }
+}
+
+#undef ioctlsocket
+int slirp_ioctlsocket(int fd, int req, void *val)
+{
+    int ret;
+    ret =3D ioctlsocket(fd, req, val);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef closesocket
+int slirp_closesocket(int fd)
+{
+    int ret;
+    ret =3D closesocket(fd);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+#endif /* WIN32 */
diff --git a/slirp/util.h b/slirp/util.h
index 00291c30a6..fe6f1fbb62 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -23,10 +23,71 @@
 #ifndef UTIL_H_
 #define UTIL_H_
=20
+#include <stdlib.h>
+#include <stdio.h>
+#include <assert.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <inttypes.h>
+
+#ifdef _WIN32
+#include <winsock2.h>
+#include <windows.h>
+#else
+#include <sys/socket.h>
+#include <netinet/tcp.h>
+#include <netinet/in.h>
+#endif
+
 #if defined(_WIN32)
 # define SLIRP_PACKED __attribute__((gcc_struct, packed))
 #else
 # define SLIRP_PACKED __attribute__((packed))
 #endif
=20
+#ifdef _WIN32
+int slirp_closesocket(int fd);
+int slirp_ioctlsocket(int fd, int req, void *val);
+#ifndef WITH_QEMU
+int inet_aton(const char *cp, struct in_addr *ia);
+#endif
+#define slirp_getsockopt(sockfd, level, optname, optval, optlen) \
+    getsockopt(sockfd, level, optname, (void *)optval, optlen)
+#define slirp_setsockopt(sockfd, level, optname, optval, optlen)        =
\
+    setsockopt(sockfd, level, optname, (const void *)optval, optlen)
+#define slirp_recv(sockfd, buf, len, flags) recv(sockfd, (void *)buf, le=
n, flags)
+#else
+#define slirp_setsockopt setsockopt
+#define slirp_getsockopt getsockopt
+#define slirp_recv recv
+#define slirp_closesocket close
+#define slirp_ioctlsocket ioctl
+#endif
+
+int slirp_socket(int domain, int type, int protocol);
+
+static inline int slirp_socket_set_nodelay(int fd)
+{
+    int v =3D 1;
+    return slirp_setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &v, sizeof(v))=
;
+}
+
+static inline int slirp_socket_set_fast_reuse(int fd)
+{
+#ifndef _WIN32
+    int v =3D 1;
+    return slirp_setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &v, sizeof(v))=
;
+#else
+    /* Enabling the reuse of an endpoint that was used by a socket still=
 in
+     * TIME_WAIT state is usually performed by setting SO_REUSEADDR. On =
Windows
+     * fast reuse is the default and SO_REUSEADDR does strange things. S=
o we
+     * don't have to do anything here. More info can be found at:
+     * http://msdn.microsoft.com/en-us/library/windows/desktop/ms740621.=
aspx */
+    return 0;
+#endif
+}
+
 #endif
--=20
2.20.1
