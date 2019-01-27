Received: from eggs.gnu.org ([209.51.188.92]:52567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCD-0001P0-CF
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCB-0007RY-IB
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:53 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:46436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCB-0007Oj-3A
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:51 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:04 +0100
Message-Id: <20190127120526.15457-10-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/31] slirp: replace trace functions with DEBUG
 calls
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

Remove a dependency on QEMU. Use the existing logging facilities.
Set SLIRP_DEBUG=3Dtftp to get tftp log.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 Makefile.objs      |  1 -
 slirp/debug.h      | 13 ++++++++++---
 slirp/slirp.c      |  1 +
 slirp/tftp.c       |  7 ++++---
 slirp/trace-events |  5 -----
 5 files changed, 15 insertions(+), 12 deletions(-)
 delete mode 100644 slirp/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 67a054b08a..b7aae33367 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -192,7 +192,6 @@ trace-events-subdirs +=3D net
 trace-events-subdirs +=3D qapi
 trace-events-subdirs +=3D qom
 trace-events-subdirs +=3D scsi
-trace-events-subdirs +=3D slirp
 trace-events-subdirs +=3D target/arm
 trace-events-subdirs +=3D target/i386
 trace-events-subdirs +=3D target/mips
diff --git a/slirp/debug.h b/slirp/debug.h
index 269d97d807..44d922df37 100644
--- a/slirp/debug.h
+++ b/slirp/debug.h
@@ -8,9 +8,10 @@
 #ifndef DEBUG_H_
 #define DEBUG_H_
=20
-#define DBG_CALL 0x1
-#define DBG_MISC 0x2
-#define DBG_ERROR 0x4
+#define DBG_CALL (1 << 0)
+#define DBG_MISC (1 << 1)
+#define DBG_ERROR (1 << 2)
+#define DBG_TFTP (1 << 3)
=20
 extern int slirp_debug;
=20
@@ -38,4 +39,10 @@ extern int slirp_debug;
     }                                           \
 } while (0)
=20
+#define DEBUG_TFTP(fmt, ...) do {               \
+    if (G_UNLIKELY(slirp_debug & DBG_TFTP)) {   \
+        g_debug(fmt, ##__VA_ARGS__);            \
+    }                                           \
+} while (0)
+
 #endif /* DEBUG_H_ */
diff --git a/slirp/slirp.c b/slirp/slirp.c
index a411221914..12677e5da7 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -270,6 +270,7 @@ static void slirp_init_once(void)
             { "call", DBG_CALL },
             { "misc", DBG_MISC },
             { "error", DBG_ERROR },
+            { "tftp", DBG_TFTP },
         };
         slirp_debug =3D g_parse_debug_string(debug, keys, G_N_ELEMENTS(k=
eys));
     }
diff --git a/slirp/tftp.c b/slirp/tftp.c
index a9ba1480db..6fb381ef33 100644
--- a/slirp/tftp.c
+++ b/slirp/tftp.c
@@ -26,7 +26,6 @@
 #include "slirp.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
-#include "trace.h"
=20
 static inline int tftp_session_in_use(struct tftp_session *spt)
 {
@@ -205,7 +204,8 @@ static void tftp_send_error(struct tftp_session *spt,
   struct mbuf *m;
   struct tftp_t *tp;
=20
-  trace_slirp_tftp_error(msg);
+  DEBUG_TFTP("tftp error msg: %s", msg);
+
   m =3D m_get(spt->slirp);
=20
   if (!m) {
@@ -325,7 +325,8 @@ static void tftp_handle_rrq(Slirp *slirp, struct sock=
addr_storage *srcsas,
       break;
     }
   }
-  trace_slirp_tftp_rrq(req_fname);
+
+  DEBUG_TFTP("tftp rrq file: %s", req_fname);
=20
   /* check mode */
   if ((pktlen - k) < 6) {
diff --git a/slirp/trace-events b/slirp/trace-events
deleted file mode 100644
index ff8f656e8c..0000000000
--- a/slirp/trace-events
+++ /dev/null
@@ -1,5 +0,0 @@
-# See docs/devel/tracing.txt for syntax documentation.
-
-# slirp/tftp.c
-slirp_tftp_rrq(const char *file) "file: %s"
-slirp_tftp_error(const char *file) "msg: %s"
--=20
2.20.1
