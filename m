Received: from eggs.gnu.org ([2001:4830:134:3::10]:51368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPagn-0006DT-Ob
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPagi-0004k1-VA
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPagc-0004R5-B0
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:32 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:37 +0400
Message-Id: <20181121220647.18844-21-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 20/30] slirp: introduce
 SLIRP_DEBUG environment variable
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

Learn to read SLIRP_DEBUG=3Dcall,misc,error (all or help also handled)
to set the slirp_debug flags.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/misc.c  |  8 --------
 slirp/slirp.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 0b7ec89595..f9b2c64541 100644
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
index 432adb02c4..51c5813c7c 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -34,6 +34,8 @@
 #include <net/if.h>
 #endif
=20
+int slirp_debug;
+
 /* Define to 1 if you want KEEPALIVE timers */
 bool slirp_do_keepalive;
=20
@@ -249,6 +251,7 @@ int get_dns6_addr(struct in6_addr *pdns6_addr, uint32=
_t *scope_id)
 static void slirp_init_once(void)
 {
     static int initialized;
+    const char *debug;
 #ifdef _WIN32
     WSADATA Data;
 #endif
@@ -265,6 +268,18 @@ static void slirp_init_once(void)
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
2.20.0.rc1
