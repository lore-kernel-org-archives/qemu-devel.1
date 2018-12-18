Received: from eggs.gnu.org ([2001:4830:134:3::10]:40165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQG-0007xF-6q
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQD-0004CU-Gw
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:07 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQC-00044b-17
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:05 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:50 +0100
Message-Id: <20181218230442.27887-13-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/64] slirp: add tftp tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Useful when debugging pxeboot, to see what the guest tries to do.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 Makefile.objs      | 1 +
 slirp/tftp.c       | 3 +++
 slirp/trace-events | 5 +++++
 3 files changed, 9 insertions(+)
 create mode 100644 slirp/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 56af0347d3..7f777a4908 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -190,6 +190,7 @@ trace-events-subdirs +=3D net
 trace-events-subdirs +=3D qapi
 trace-events-subdirs +=3D qom
 trace-events-subdirs +=3D scsi
+trace-events-subdirs +=3D slirp
 trace-events-subdirs +=3D target/arm
 trace-events-subdirs +=3D target/i386
 trace-events-subdirs +=3D target/mips
diff --git a/slirp/tftp.c b/slirp/tftp.c
index a9bc4bb1b6..735b57aa55 100644
--- a/slirp/tftp.c
+++ b/slirp/tftp.c
@@ -26,6 +26,7 @@
 #include "slirp.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
+#include "trace.h"
=20
 static inline int tftp_session_in_use(struct tftp_session *spt)
 {
@@ -204,6 +205,7 @@ static void tftp_send_error(struct tftp_session *spt,
   struct mbuf *m;
   struct tftp_t *tp;
=20
+  trace_slirp_tftp_error(msg);
   m =3D m_get(spt->slirp);
=20
   if (!m) {
@@ -323,6 +325,7 @@ static void tftp_handle_rrq(Slirp *slirp, struct sock=
addr_storage *srcsas,
       break;
     }
   }
+  trace_slirp_tftp_rrq(req_fname);
=20
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
--=20
2.19.2
