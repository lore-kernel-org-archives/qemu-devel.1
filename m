Received: from eggs.gnu.org ([209.51.188.92]:47434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gRB-0003CU-2G
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gRA-0003u9-8c
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:59:01 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:43760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h1gRA-0003tW-1M
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:59:00 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  7 Mar 2019 00:58:46 +0100
Message-Id: <20190306235850.30110-9-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
References: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/12] slirp: use "slirp_" prefix for
 inet_aton() win32 implementation
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

To avoid conflict with QEMU inet_aton() implementation, let's use the
"slirp_" prefix. This allows to drop the WITH_QEMU, thus the source
won't make a distinction when building with QEMU or not.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190212162524.31504-4-marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/Makefile.objs | 2 +-
 slirp/util.c        | 4 ++--
 slirp/util.h        | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/slirp/Makefile.objs b/slirp/Makefile.objs
index 69e140f965..e91daf0e91 100644
--- a/slirp/Makefile.objs
+++ b/slirp/Makefile.objs
@@ -33,4 +33,4 @@ slirp.mo-objs =3D \
 	vmstate.o \
 	$(NULL)
=20
-slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\" -DWITH_QEMU
+slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\"
diff --git a/slirp/util.c b/slirp/util.c
index 1cbaa26b60..5ec2fa87ab 100644
--- a/slirp/util.c
+++ b/slirp/util.c
@@ -31,8 +31,8 @@
 #include <fcntl.h>
 #include <stdint.h>
=20
-#if defined(_WIN32) && !defined(WITH_QEMU)
-int inet_aton(const char *cp, struct in_addr *ia)
+#if defined(_WIN32)
+int slirp_inet_aton(const char *cp, struct in_addr *ia)
 {
     uint32_t addr =3D inet_addr(cp);
     if (addr =3D=3D 0xffffffff) {
diff --git a/slirp/util.h b/slirp/util.h
index c4207a49d6..e94ee4e7f1 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -138,8 +138,8 @@ int slirp_getsockopt_wrap(int sockfd, int level, int =
optname,
 #define setsockopt slirp_setsockopt_wrap
 int slirp_setsockopt_wrap(int sockfd, int level, int optname,
                           const void *optval, int optlen);
-
-int inet_aton(const char *cp, struct in_addr *ia);
+#define inet_aton slirp_inet_aton
+int slirp_inet_aton(const char *cp, struct in_addr *ia);
 #else
 #define closesocket(s) close(s)
 #define ioctlsocket(s, r, v) ioctl(s, r, v)
--=20
2.20.1
