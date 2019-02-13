Received: from eggs.gnu.org ([209.51.188.92]:44669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gtzKG-00059G-Ou
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gtzKB-0000Xb-V8
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:32:04 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:50938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gtzKB-0000SC-4h
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:31:59 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 13 Feb 2019 19:31:53 +0100
Message-Id: <20190213183153.23746-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190213183153.23746-1-samuel.thibault@ens-lyon.org>
References: <20190213183153.23746-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] slirp: wrap the remaining socket functions
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

Wrap the missing functions.

Rename the wrapped function with "slirp_" prefix and "_wrap" suffix,
for consistency and to avoid a clash with existing function (such as
"slirp_socket").

Fixes: a9d8b3ec ("slirp: replace remaining qemu headers dependency")
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190212160953.29051-3-marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Howard Spoelstra
---
 slirp/util.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 slirp/util.h |  56 +++++++++++++++---
 2 files changed, 209 insertions(+), 11 deletions(-)

diff --git a/slirp/util.c b/slirp/util.c
index 84f5afdbc3..1cbaa26b60 100644
--- a/slirp/util.c
+++ b/slirp/util.c
@@ -167,7 +167,7 @@ static int socket_error(void)
 }
=20
 #undef ioctlsocket
-int slirp_ioctlsocket(int fd, int req, void *val)
+int slirp_ioctlsocket_wrap(int fd, int req, void *val)
 {
     int ret;
     ret =3D ioctlsocket(fd, req, val);
@@ -178,7 +178,7 @@ int slirp_ioctlsocket(int fd, int req, void *val)
 }
=20
 #undef closesocket
-int slirp_closesocket(int fd)
+int slirp_closesocket_wrap(int fd)
 {
     int ret;
     ret =3D closesocket(fd);
@@ -187,6 +187,166 @@ int slirp_closesocket(int fd)
     }
     return ret;
 }
+
+#undef connect
+int slirp_connect_wrap(int sockfd, const struct sockaddr *addr, int addr=
len)
+{
+    int ret;
+    ret =3D connect(sockfd, addr, addrlen);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef listen
+int slirp_listen_wrap(int sockfd, int backlog)
+{
+    int ret;
+    ret =3D listen(sockfd, backlog);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef bind
+int slirp_bind_wrap(int sockfd, const struct sockaddr *addr, int addrlen=
)
+{
+    int ret;
+    ret =3D bind(sockfd, addr, addrlen);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef socket
+int slirp_socket_wrap(int domain, int type, int protocol)
+{
+    int ret;
+    ret =3D socket(domain, type, protocol);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef accept
+int slirp_accept_wrap(int sockfd, struct sockaddr *addr, int *addrlen)
+{
+    int ret;
+    ret =3D accept(sockfd, addr, addrlen);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef shutdown
+int slirp_shutdown_wrap(int sockfd, int how)
+{
+    int ret;
+    ret =3D shutdown(sockfd, how);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef getsockopt
+int slirp_getsockopt_wrap(int sockfd, int level, int optname,
+                          void *optval, int *optlen)
+{
+    int ret;
+    ret =3D getsockopt(sockfd, level, optname, optval, optlen);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef setsockopt
+int slirp_setsockopt_wrap(int sockfd, int level, int optname,
+                          const void *optval, int optlen)
+{
+    int ret;
+    ret =3D setsockopt(sockfd, level, optname, optval, optlen);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef getpeername
+int slirp_getpeername_wrap(int sockfd, struct sockaddr *addr,
+                           int *addrlen)
+{
+    int ret;
+    ret =3D getpeername(sockfd, addr, addrlen);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef getsockname
+int slirp_getsockname_wrap(int sockfd, struct sockaddr *addr,
+                           int *addrlen)
+{
+    int ret;
+    ret =3D getsockname(sockfd, addr, addrlen);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef send
+ssize_t slirp_send_wrap(int sockfd, const void *buf, size_t len, int fla=
gs)
+{
+    int ret;
+    ret =3D send(sockfd, buf, len, flags);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef sendto
+ssize_t slirp_sendto_wrap(int sockfd, const void *buf, size_t len, int f=
lags,
+                     const struct sockaddr *addr, int addrlen)
+{
+    int ret;
+    ret =3D sendto(sockfd, buf, len, flags, addr, addrlen);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef recv
+ssize_t slirp_recv_wrap(int sockfd, void *buf, size_t len, int flags)
+{
+    int ret;
+    ret =3D recv(sockfd, buf, len, flags);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
+
+#undef recvfrom
+ssize_t slirp_recvfrom_wrap(int sockfd, void *buf, size_t len, int flags=
,
+                            struct sockaddr *addr, int *addrlen)
+{
+    int ret;
+    ret =3D recvfrom(sockfd, buf, len, flags, addr, addrlen);
+    if (ret < 0) {
+        errno =3D socket_error();
+    }
+    return ret;
+}
 #endif /* WIN32 */
=20
 void slirp_pstrcpy(char *buf, int buf_size, const char *str)
diff --git a/slirp/util.h b/slirp/util.h
index 685b5af099..c4207a49d6 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -83,23 +83,61 @@ struct iovec {
=20
 /* FIXME: remove me when made standalone */
 #ifdef _WIN32
+#undef accept
+#undef bind
 #undef closesocket
+#undef connect
+#undef getpeername
+#undef getsockname
 #undef getsockopt
 #undef ioctlsocket
+#undef listen
 #undef recv
+#undef recvfrom
+#undef send
+#undef sendto
 #undef setsockopt
+#undef shutdown
+#undef socket
 #endif
=20
 #ifdef _WIN32
-#define closesocket slirp_closesocket
-int slirp_closesocket(int fd);
-#define ioctlsocket slirp_ioctlsocket
-int slirp_ioctlsocket(int fd, int req, void *val);
-#define getsockopt(sockfd, level, optname, optval, optlen) \
-    getsockopt(sockfd, level, optname, (void *)optval, optlen)
-#define setsockopt(sockfd, level, optname, optval, optlen)        \
-    setsockopt(sockfd, level, optname, (const void *)optval, optlen)
-#define recv(sockfd, buf, len, flags) recv(sockfd, (void *)buf, len, fla=
gs)
+#define connect slirp_connect_wrap
+int slirp_connect_wrap(int fd, const struct sockaddr *addr, int addrlen)=
;
+#define listen slirp_listen_wrap
+int slirp_listen_wrap(int fd, int backlog);
+#define bind slirp_bind_wrap
+int slirp_bind_wrap(int fd, const struct sockaddr *addr, int addrlen);
+#define socket slirp_socket_wrap
+int slirp_socket_wrap(int domain, int type, int protocol);
+#define accept slirp_accept_wrap
+int slirp_accept_wrap(int fd, struct sockaddr *addr, int *addrlen);
+#define shutdown slirp_shutdown_wrap
+int slirp_shutdown_wrap(int fd, int how);
+#define getpeername slirp_getpeername_wrap
+int slirp_getpeername_wrap(int fd, struct sockaddr *addr, int *addrlen);
+#define getsockname slirp_getsockname_wrap
+int slirp_getsockname_wrap(int fd, struct sockaddr *addr, int *addrlen);
+#define send slirp_send_wrap
+ssize_t slirp_send_wrap(int fd, const void *buf, size_t len, int flags);
+#define sendto slirp_sendto_wrap
+ssize_t slirp_sendto_wrap(int fd, const void *buf, size_t len, int flags=
,
+                          const struct sockaddr *dest_addr, int addrlen)=
;
+#define recv slirp_recv_wrap
+ssize_t slirp_recv_wrap(int fd, void *buf, size_t len, int flags);
+#define recvfrom slirp_recvfrom_wrap
+ssize_t slirp_recvfrom_wrap(int fd, void *buf, size_t len, int flags,
+                            struct sockaddr *src_addr, int *addrlen);
+#define closesocket slirp_closesocket_wrap
+int slirp_closesocket_wrap(int fd);
+#define ioctlsocket slirp_ioctlsocket_wrap
+int slirp_ioctlsocket_wrap(int fd, int req, void *val);
+#define getsockopt slirp_getsockopt_wrap
+int slirp_getsockopt_wrap(int sockfd, int level, int optname,
+                     void *optval, int *optlen);
+#define setsockopt slirp_setsockopt_wrap
+int slirp_setsockopt_wrap(int sockfd, int level, int optname,
+                          const void *optval, int optlen);
=20
 int inet_aton(const char *cp, struct in_addr *ia);
 #else
--=20
2.20.1
