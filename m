Received: from eggs.gnu.org ([209.51.188.92]:51707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkb-0003Ny-QL
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipka-0006mP-OE
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:09 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipka-0006aw-EK
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:08 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:03:16 +0100
Message-Id: <20190114000326.29847-56-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 55/65] slirp: introduce SLIRP_DEBUG environment
 variable
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

Learn to read SLIRP_DEBUG=3Dcall,misc,error (all or help also handled)
to set the slirp_debug flags.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.c  |  8 --------
 slirp/slirp.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index e30d2ceb2a..a0f104be5e 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -11,14 +11,6 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
=20
-#ifdef DEBUG
-#define SLIRP_DEBUG (DBG_CALL | DBG_MISC | DBG_ERROR)
-#else
-#define SLIRP_DEBUG 0
-#endif
-
-int slirp_debug =3D SLIRP_DEBUG;
-
 inline void
 insque(void *a, void *b)
 {
diff --git a/slirp/slirp.c b/slirp/slirp.c
index ce5f571d0f..0b70cb9fb6 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -35,6 +35,8 @@
 #include <net/if.h>
 #endif
=20
+int slirp_debug;
+
 /* Define to 1 if you want KEEPALIVE timers */
 bool slirp_do_keepalive;
=20
@@ -250,6 +252,7 @@ int get_dns6_addr(struct in6_addr *pdns6_addr, uint32=
_t *scope_id)
 static void slirp_init_once(void)
 {
     static int initialized;
+    const char *debug;
 #ifdef _WIN32
     WSADATA Data;
 #endif
@@ -266,6 +269,18 @@ static void slirp_init_once(void)
=20
     loopback_addr.s_addr =3D htonl(INADDR_LOOPBACK);
     loopback_mask =3D htonl(IN_CLASSA_NET);
+
+    debug =3D g_getenv("SLIRP_DEBUG");
+    if (debug) {
+        const GDebugKey keys[] =3D {
+            { "call", DBG_CALL },
+            { "misc", DBG_MISC },
+            { "error", DBG_ERROR },
+        };
+        slirp_debug =3D g_parse_debug_string(debug, keys, G_N_ELEMENTS(k=
eys));
+    }
+
+
 }
=20
 static void slirp_state_save(QEMUFile *f, void *opaque);
--=20
2.20.1
