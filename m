Received: from eggs.gnu.org ([209.51.188.92]:52788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCN-0001Xb-Lt
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCM-0007g5-RV
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:03 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCM-0007RP-Ip
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:02 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:12 +0100
Message-Id: <20190127120526.15457-18-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/31] slirp: improve windows headers inclusion
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

Our API usage requires Vista, set WIN32_LEAN_AND_MEAN to fix a number
of issues (winsock2.h include order for ex, which is better to include
first for legacy reasons).

While at it, group redundants #ifndef _WIN32 blocks.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 8d9d72ca9d..5a830ddcb8 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -3,10 +3,19 @@
=20
 #ifdef _WIN32
=20
+/* as defined in sdkddkver.h */
+#ifndef _WIN32_WINNT
+#define _WIN32_WINNT 0x0600 /* Vista */
+#endif
+/* reduces the number of implicitly included headers */
+#ifndef WIN32_LEAN_AND_MEAN
+#define WIN32_LEAN_AND_MEAN
+#endif
+
 typedef char *caddr_t;
=20
-# include <windows.h>
 # include <winsock2.h>
+# include <windows.h>
 # include <ws2tcpip.h>
 # include <sys/timeb.h>
 # include <iphlpapi.h>
@@ -19,19 +28,10 @@ typedef char *caddr_t;
=20
 #ifndef _WIN32
 #include <sys/uio.h>
-#endif
-
-#ifndef _WIN32
 #include <netinet/in.h>
 #include <arpa/inet.h>
-#endif
-
-#ifndef _WIN32
 #include <sys/socket.h>
-#endif
-
-#ifndef _WIN32
-# include <sys/ioctl.h>
+#include <sys/ioctl.h>
 #endif
=20
 #ifdef __APPLE__
--=20
2.20.1
