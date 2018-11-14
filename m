Received: from eggs.gnu.org ([2001:4830:134:3::10]:60175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuVO-00046w-Pd
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuVI-0003zZ-QP
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuVG-0003sL-VT
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:32 +0400
Message-Id: <20181114123643.24091-31-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 30/41] slirp: replace trace functions
 with DEBUG calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Remove a dependency on QEMU. Use the existing logging facilities.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/tftp.c       | 7 ++++---
 Makefile.objs      | 1 -
 slirp/trace-events | 5 -----
 3 files changed, 4 insertions(+), 9 deletions(-)
 delete mode 100644 slirp/trace-events

diff --git a/slirp/tftp.c b/slirp/tftp.c
index 735b57aa55..dddb614b8a 100644
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
+  DEBUG_ERROR("tftp error msg: %s", msg);
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
+  DEBUG_MISC("tftp rrq file: %s", req_fname);
=20
   /* check mode */
   if ((pktlen - k) < 6) {
diff --git a/Makefile.objs b/Makefile.objs
index 31852eaf8f..1e1ff387d7 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -251,7 +251,6 @@ trace-events-subdirs +=3D net
 trace-events-subdirs +=3D qapi
 trace-events-subdirs +=3D qom
 trace-events-subdirs +=3D scsi
-trace-events-subdirs +=3D slirp
 trace-events-subdirs +=3D target/arm
 trace-events-subdirs +=3D target/i386
 trace-events-subdirs +=3D target/mips
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
2.19.1.708.g4ede3d42df
