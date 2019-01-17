Received: from eggs.gnu.org ([209.51.188.92]:57172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66H-0005Tn-Tx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66F-0004Up-9E
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk66F-0004Q5-04
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:38 +0400
Message-Id: <20190117114359.5164-7-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/27] slirp: replace trace functions with
 DEBUG calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Remove a dependency on QEMU. Use the existing logging facilities.
Set SLIRP_DEBUG=3Dtftp to get tftp log.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/debug.h      | 13 ++++++++++---
 slirp/slirp.c      |  1 +
 slirp/tftp.c       |  7 ++++---
 Makefile.objs      |  1 -
 slirp/trace-events |  5 -----
 5 files changed, 15 insertions(+), 12 deletions(-)
 delete mode 100644 slirp/trace-events

diff --git a/slirp/debug.h b/slirp/debug.h
index 269d97d8073..f6a048450dd 100644
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
+    if (slirp_debug & DBG_TFTP) {               \
+        g_debug(fmt, ##__VA_ARGS__);            \
+    }                                           \
+} while (0)
+
 #endif /* DEBUG_H_ */
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 7b23722d5db..dd72829017f 100644
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
index a9ba1480db4..6fb381ef337 100644
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
diff --git a/Makefile.objs b/Makefile.objs
index 67a054b08af..b7aae33367f 100644
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
diff --git a/slirp/trace-events b/slirp/trace-events
deleted file mode 100644
index ff8f656e8c5..00000000000
--- a/slirp/trace-events
+++ /dev/null
@@ -1,5 +0,0 @@
-# See docs/devel/tracing.txt for syntax documentation.
-
-# slirp/tftp.c
-slirp_tftp_rrq(const char *file) "file: %s"
-slirp_tftp_error(const char *file) "msg: %s"
--=20
2.20.1.98.gecbdaf0899
