Received: from eggs.gnu.org ([2001:4830:134:3::10]:51329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPagi-00069Q-WC
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPagZ-0004XI-1y
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPagS-0004J9-U8
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:22 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:36 +0400
Message-Id: <20181121220647.18844-20-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 19/30] slirp: always build with
 debug statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Make debug statements condiitonal only on slirp_debug flags, instead
of the pre-processor DEBUG blocks, as it may introduce breakage
easily, since the debug code isn't always compiled.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/debug.h | 15 +++------------
 slirp/misc.c  |  6 +++++-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/slirp/debug.h b/slirp/debug.h
index ca3a4b04da..ff920f0b87 100644
--- a/slirp/debug.h
+++ b/slirp/debug.h
@@ -5,9 +5,8 @@
  * terms and conditions of the copyright.
  */
=20
-//#define DEBUG 1
-
-#ifdef DEBUG
+#ifndef DEBUG_H_
+#define DEBUG_H_
=20
 #define DBG_CALL 0x1
 #define DBG_MISC 0x2
@@ -50,12 +49,4 @@ extern int slirp_debug;
     }                                           \
 } while (0)
=20
-#else
-
-#define DEBUG_CALL(fmt, ...)
-#define DEBUG_ARG(fmt, ...)
-#define DEBUG_ARGS(fmt, ...)
-#define DEBUG_MISC(fmt, ...)
-#define DEBUG_ERROR(fmt, ...)
-
-#endif
+#endif /* DEBUG_H_ */
diff --git a/slirp/misc.c b/slirp/misc.c
index 6ee0ff0231..0b7ec89595 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -12,9 +12,13 @@
 #include "qemu/main-loop.h"
=20
 #ifdef DEBUG
-int slirp_debug =3D DBG_CALL|DBG_MISC|DBG_ERROR;
+#define SLIRP_DEBUG (DBG_CALL | DBG_MISC | DBG_ERROR)
+#else
+#define SLIRP_DEBUG 0
 #endif
=20
+int slirp_debug =3D SLIRP_DEBUG;
+
 inline void
 insque(void *a, void *b)
 {
--=20
2.20.0.rc1
