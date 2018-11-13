Received: from eggs.gnu.org ([2001:4830:134:3::10]:49937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMSjo-0001gB-3V
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMSjl-0007b6-29
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:03:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gMSjk-0007HZ-Rw
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:03:48 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Nov 2018 08:03:20 +0100
Message-Id: <20181113070320.16147-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] slirp: add tftp tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>

Useful when debugging pxeboot, to see what the guest tries to do.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile.objs      | 1 +
 slirp/tftp.c       | 3 +++
 slirp/trace-events | 5 +++++
 3 files changed, 9 insertions(+)
 create mode 100644 slirp/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 1e1ff387d7..31852eaf8f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -251,6 +251,7 @@ trace-events-subdirs += net
 trace-events-subdirs += qapi
 trace-events-subdirs += qom
 trace-events-subdirs += scsi
+trace-events-subdirs += slirp
 trace-events-subdirs += target/arm
 trace-events-subdirs += target/i386
 trace-events-subdirs += target/mips
diff --git a/slirp/tftp.c b/slirp/tftp.c
index a9bc4bb1b6..735b57aa55 100644
--- a/slirp/tftp.c
+++ b/slirp/tftp.c
@@ -26,6 +26,7 @@
 #include "slirp.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
+#include "trace.h"
 
 static inline int tftp_session_in_use(struct tftp_session *spt)
 {
@@ -204,6 +205,7 @@ static void tftp_send_error(struct tftp_session *spt,
   struct mbuf *m;
   struct tftp_t *tp;
 
+  trace_slirp_tftp_error(msg);
   m = m_get(spt->slirp);
 
   if (!m) {
@@ -323,6 +325,7 @@ static void tftp_handle_rrq(Slirp *slirp, struct sockaddr_storage *srcsas,
       break;
     }
   }
+  trace_slirp_tftp_rrq(req_fname);
 
   /* check mode */
   if ((pktlen - k) < 6) {
diff --git a/slirp/trace-events b/slirp/trace-events
new file mode 100644
index 0000000000..ff8f656e8c
--- /dev/null
+++ b/slirp/trace-events
@@ -0,0 +1,5 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# slirp/tftp.c
+slirp_tftp_rrq(const char *file) "file: %s"
+slirp_tftp_error(const char *file) "msg: %s"
-- 
2.9.3
