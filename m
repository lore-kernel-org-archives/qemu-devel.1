Received: from eggs.gnu.org ([2001:4830:134:3::10]:41005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORY-0000gr-29
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORX-0005GK-5X
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:27 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZORW-0004zg-G6
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:26 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:32 +0100
Message-Id: <20181218230442.27887-55-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 54/64] slirp: always build with debug statements
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

Make debug statements condiitonal only on slirp_debug flags, instead
of the pre-processor DEBUG blocks, as it may introduce breakage
easily, since the debug code isn't always compiled.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
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
index 526cefa0f1..e30d2ceb2a 100644
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
2.19.2
