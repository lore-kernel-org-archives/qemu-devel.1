Received: from eggs.gnu.org ([2001:4830:134:3::10]:58756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIyBi-0004nO-Um
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIyBh-0008Ry-Vz
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:13:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIyBh-0008Rh-Nd
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:13:25 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  8 Jun 2017 18:13:11 +0400
Message-Id: <20170608141313.27588-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170608141313.27588-1-marcandre.lureau@redhat.com>
References: <20170608141313.27588-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] char: fix alias devices regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Fix regression from commit 4d43a603c71, where the serial and parallel
headers got removed from char.c, which broke the alias table.

Move the HAVE_CHARDEV_SERIAL/HAVE_CHARDEV_PARPORT to osdep.h instead
of being in separate headers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/chardev/char-parallel.h |  5 -----
 include/chardev/char-serial.h   |  8 --------
 include/qemu/osdep.h            | 13 +++++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/chardev/char-parallel.h b/include/chardev/char-paral=
lel.h
index 3284a1b96b..c09751fd6c 100644
--- a/include/chardev/char-parallel.h
+++ b/include/chardev/char-parallel.h
@@ -26,11 +26,6 @@
=20
 #include "chardev/char.h"
=20
-#if defined(__linux__) || defined(__FreeBSD__) ||               \
-    defined(__FreeBSD_kernel__) || defined(__DragonFly__)
-#define HAVE_CHARDEV_PARPORT 1
-#endif
-
 #define CHR_IOCTL_PP_READ_DATA        3
 #define CHR_IOCTL_PP_WRITE_DATA       4
 #define CHR_IOCTL_PP_READ_CONTROL     5
diff --git a/include/chardev/char-serial.h b/include/chardev/char-serial.=
h
index cb2e59e82a..ad6891b26d 100644
--- a/include/chardev/char-serial.h
+++ b/include/chardev/char-serial.h
@@ -26,14 +26,6 @@
=20
 #include "chardev/char.h"
=20
-#ifdef _WIN32
-#define HAVE_CHARDEV_SERIAL 1
-#elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    =
\
-    || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFl=
y__) \
-    || defined(__GLIBC__)
-#define HAVE_CHARDEV_SERIAL 1
-#endif
-
 #define CHR_IOCTL_SERIAL_SET_PARAMS   1
 typedef struct {
     int speed;
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1c9f5e260c..fb008a2e65 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -284,6 +284,19 @@ void qemu_anon_ram_free(void *ptr, size_t size);
=20
 #endif
=20
+#ifdef _WIN32
+#define HAVE_CHARDEV_SERIAL 1
+#elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    =
\
+    || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFl=
y__) \
+    || defined(__GLIBC__)
+#define HAVE_CHARDEV_SERIAL 1
+#endif
+
+#if defined(__linux__) || defined(__FreeBSD__) ||               \
+    defined(__FreeBSD_kernel__) || defined(__DragonFly__)
+#define HAVE_CHARDEV_PARPORT 1
+#endif
+
 #if defined(CONFIG_LINUX)
 #ifndef BUS_MCEERR_AR
 #define BUS_MCEERR_AR 4
--=20
2.13.0.91.g00982b8dd
