Received: from eggs.gnu.org ([209.51.188.92]:44656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gtzKE-00058D-2s
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gtzKC-0000Y8-1o
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:32:02 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:42966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gtzKB-0000RL-5W
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:31:59 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 13 Feb 2019 19:31:52 +0100
Message-Id: <20190213183153.23746-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190213183153.23746-1-samuel.thibault@ens-lyon.org>
References: <20190213183153.23746-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] slirp: remove slirp_ prefix for socket
 wrappers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

QEMU wraps the socket functions in os-win32.h, but in commit
a9d8b3ec4385793815d71217857304, the header inclusion was dropped,
breaking libslirp on Windows.

There are already a few socket functions that are wrapped in libslirp,
with "slirp_" prefix, but many of them are missing, and we are going
to wrap the missing functions in a second patch.

Using "slirp_" prefix avoids the conflict with socket function #define
wrappers in QEMU os-win32.h, but they are quite intrusive. In the end,
the functions should behave the same as original one, but with errno
being set. To avoid the churn, and potential confusion, remove the
"slirp_" prefix. A series of #undef is necessary until libslirp is
made standalone to prevent the #define conflict with QEMU.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190212160953.29051-2-marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip_icmp.c  |  4 ++--
 slirp/misc.c     | 14 +++++++-------
 slirp/slirp.c    |  2 +-
 slirp/socket.c   | 14 +++++++-------
 slirp/tcp_subr.c | 10 +++++-----
 slirp/udp.c      |  2 +-
 slirp/util.h     | 31 ++++++++++++++++++++-----------
 7 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index ce79c0b051..120108f582 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -114,7 +114,7 @@ static int icmp_send(struct socket *so, struct mbuf *=
m, int hlen)
 void icmp_detach(struct socket *so)
 {
     so->slirp->cb->unregister_poll_fd(so->s, so->slirp->opaque);
-    slirp_closesocket(so->s);
+    closesocket(so->s);
     sofree(so);
 }
=20
@@ -421,7 +421,7 @@ void icmp_receive(struct socket *so)
     icp =3D mtod(m, struct icmp *);
=20
     id =3D icp->icmp_id;
-    len =3D slirp_recv(so->s, icp, M_ROOM(m), 0);
+    len =3D recv(so->s, icp, M_ROOM(m), 0);
     /*
      * The behavior of reading SOCK_DGRAM+IPPROTO_ICMP sockets is incons=
istent
      * between host OSes.  On Linux, only the ICMP header and payload is
diff --git a/slirp/misc.c b/slirp/misc.c
index 3f4cd852f8..d9fc586a24 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -98,16 +98,16 @@ slirp_socketpair_with_oob(int sv[2])
         goto err;
     }
=20
-    slirp_closesocket(s);
+    closesocket(s);
     return 0;
=20
 err:
     g_critical("slirp_socketpair(): %s", strerror(errno));
     if (s >=3D 0) {
-        slirp_closesocket(s);
+        closesocket(s);
     }
     if (sv[1] >=3D 0) {
-        slirp_closesocket(sv[1]);
+        closesocket(sv[1]);
     }
     return -1;
 }
@@ -211,16 +211,16 @@ fork_exec(struct socket *so, const char *ex)
     if (err) {
         g_critical("fork_exec: %s", err->message);
         g_error_free(err);
-        slirp_closesocket(sp[0]);
-        slirp_closesocket(sp[1]);
+        closesocket(sp[0]);
+        closesocket(sp[1]);
         return 0;
     }
=20
     so->s =3D sp[0];
-    slirp_closesocket(sp[1]);
+    closesocket(sp[1]);
     slirp_socket_set_fast_reuse(so->s);
     opt =3D 1;
-    slirp_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int))=
;
+    setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
     slirp_set_nonblock(so->s);
     so->slirp->cb->register_poll_fd(so->s, so->slirp->opaque);
     return 1;
diff --git a/slirp/slirp.c b/slirp/slirp.c
index a746c6fd86..55591430dc 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -961,7 +961,7 @@ int slirp_remove_hostfwd(Slirp *slirp, int is_udp, st=
ruct in_addr host_addr,
             addr.sin_addr.s_addr =3D=3D host_addr.s_addr &&
             addr.sin_port =3D=3D port) {
             so->slirp->cb->unregister_poll_fd(so->s, so->slirp->opaque);
-            slirp_closesocket(so->s);
+            closesocket(so->s);
             sofree(so);
             return 0;
         }
diff --git a/slirp/socket.c b/slirp/socket.c
index ce1d6ffa1d..4876ea3f31 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -185,7 +185,7 @@ soread(struct socket *so)
 	 */
 	sopreprbuf(so, iov, &n);
=20
-	nn =3D slirp_recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
+	nn =3D recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
 	if (nn <=3D 0) {
 		if (nn < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN))
 			return 0;
@@ -201,7 +201,7 @@ soread(struct socket *so)
 				if (getpeername(so->s, paddr, &alen) < 0) {
 					err =3D errno;
 				} else {
-					slirp_getsockopt(so->s, SOL_SOCKET, SO_ERROR,
+					getsockopt(so->s, SOL_SOCKET, SO_ERROR,
 						&err, &elen);
 				}
 			}
@@ -231,7 +231,7 @@ soread(struct socket *so)
 	 */
 	if (n =3D=3D 2 && nn =3D=3D iov[0].iov_len) {
             int ret;
-            ret =3D slirp_recv(so->s, iov[1].iov_base, iov[1].iov_len,0)=
;
+            ret =3D recv(so->s, iov[1].iov_base, iov[1].iov_len,0);
             if (ret > 0)
                 nn +=3D ret;
         }
@@ -552,7 +552,7 @@ sorecvfrom(struct socket *so)
 	   */
 	  len =3D M_FREEROOM(m);
 	  /* if (so->so_fport !=3D htons(53)) { */
-	  slirp_ioctlsocket(so->s, FIONREAD, &n);
+	  ioctlsocket(so->s, FIONREAD, &n);
=20
 	  if (n > len) {
 	    n =3D (m->m_data - m->m_dat) + m->m_len + n + 1;
@@ -724,7 +724,7 @@ tcp_listen(Slirp *slirp, uint32_t haddr, unsigned hpo=
rt, uint32_t laddr,
 		int tmperrno =3D errno; /* Don't clobber the real reason we failed */
=20
                 if (s >=3D 0) {
-                    slirp_closesocket(s);
+                    closesocket(s);
                 }
 		sofree(so);
 		/* Restore the real errno */
@@ -735,9 +735,9 @@ tcp_listen(Slirp *slirp, uint32_t haddr, unsigned hpo=
rt, uint32_t laddr,
 #endif
 		return NULL;
 	}
-	slirp_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
+	setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
 	opt =3D 1;
-	slirp_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(int));
+	setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(int));
=20
 	getsockname(s,(struct sockaddr *)&addr,&addrlen);
 	so->so_ffamily =3D AF_INET;
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index cda94815f6..262a42d6c8 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -337,7 +337,7 @@ tcp_close(struct tcpcb *tp)
 	if (so =3D=3D slirp->tcp_last_so)
 		slirp->tcp_last_so =3D &slirp->tcb;
 	so->slirp->cb->unregister_poll_fd(so->s, so->slirp->opaque);
-	slirp_closesocket(so->s);
+	closesocket(so->s);
 	sbfree(&so->so_rcv);
 	sbfree(&so->so_snd);
 	sofree(so);
@@ -416,9 +416,9 @@ int tcp_fconnect(struct socket *so, unsigned short af=
)
     so->slirp->cb->register_poll_fd(so->s, so->slirp->opaque);
     slirp_socket_set_fast_reuse(s);
     opt =3D 1;
-    slirp_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
+    setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
     opt =3D 1;
-    slirp_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
+    setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
=20
     addr =3D so->fhost.ss;
     DEBUG_CALL(" connect()ing");
@@ -489,7 +489,7 @@ void tcp_connect(struct socket *inso)
     so->slirp->cb->register_poll_fd(so->s, so->slirp->opaque);
     slirp_socket_set_fast_reuse(s);
     opt =3D 1;
-    slirp_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
+    setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
     slirp_socket_set_nodelay(s);
=20
     so->fhost.ss =3D addr;
@@ -499,7 +499,7 @@ void tcp_connect(struct socket *inso)
     if (inso->so_state & SS_FACCEPTONCE) {
         /* If we only accept once, close the accept() socket */
         so->slirp->cb->unregister_poll_fd(so->s, so->slirp->opaque);
-        slirp_closesocket(so->s);
+        closesocket(so->s);
=20
         /* Don't select it yet, even though we have an FD */
         /* if it's not FACCEPTONCE, it's already NOFDREF */
diff --git a/slirp/udp.c b/slirp/udp.c
index 29a31e9400..3d9a19b85a 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -292,7 +292,7 @@ void
 udp_detach(struct socket *so)
 {
 	so->slirp->cb->unregister_poll_fd(so->s, so->slirp->opaque);
-	slirp_closesocket(so->s);
+	closesocket(so->s);
 	sofree(so);
 }
=20
diff --git a/slirp/util.h b/slirp/util.h
index 4963747aef..685b5af099 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -81,21 +81,30 @@ struct iovec {
 #define ETH_P_NCSI                (0x88f8)
 #define ETH_P_UNKNOWN             (0xffff)
=20
+/* FIXME: remove me when made standalone */
 #ifdef _WIN32
+#undef closesocket
+#undef getsockopt
+#undef ioctlsocket
+#undef recv
+#undef setsockopt
+#endif
+
+#ifdef _WIN32
+#define closesocket slirp_closesocket
 int slirp_closesocket(int fd);
+#define ioctlsocket slirp_ioctlsocket
 int slirp_ioctlsocket(int fd, int req, void *val);
-int inet_aton(const char *cp, struct in_addr *ia);
-#define slirp_getsockopt(sockfd, level, optname, optval, optlen) \
+#define getsockopt(sockfd, level, optname, optval, optlen) \
     getsockopt(sockfd, level, optname, (void *)optval, optlen)
-#define slirp_setsockopt(sockfd, level, optname, optval, optlen)        =
\
+#define setsockopt(sockfd, level, optname, optval, optlen)        \
     setsockopt(sockfd, level, optname, (const void *)optval, optlen)
-#define slirp_recv(sockfd, buf, len, flags) recv(sockfd, (void *)buf, le=
n, flags)
+#define recv(sockfd, buf, len, flags) recv(sockfd, (void *)buf, len, fla=
gs)
+
+int inet_aton(const char *cp, struct in_addr *ia);
 #else
-#define slirp_setsockopt setsockopt
-#define slirp_getsockopt getsockopt
-#define slirp_recv recv
-#define slirp_closesocket close
-#define slirp_ioctlsocket ioctl
+#define closesocket(s) close(s)
+#define ioctlsocket(s, r, v) ioctl(s, r, v)
 #endif
=20
 int slirp_socket(int domain, int type, int protocol);
@@ -104,14 +113,14 @@ void slirp_set_nonblock(int fd);
 static inline int slirp_socket_set_nodelay(int fd)
 {
     int v =3D 1;
-    return slirp_setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &v, sizeof(v))=
;
+    return setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &v, sizeof(v));
 }
=20
 static inline int slirp_socket_set_fast_reuse(int fd)
 {
 #ifndef _WIN32
     int v =3D 1;
-    return slirp_setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &v, sizeof(v))=
;
+    return setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &v, sizeof(v));
 #else
     /* Enabling the reuse of an endpoint that was used by a socket still=
 in
      * TIME_WAIT state is usually performed by setting SO_REUSEADDR. On =
Windows
--=20
2.20.1
