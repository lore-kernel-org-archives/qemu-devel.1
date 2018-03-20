Received: from eggs.gnu.org ([2001:4830:134:3::10]:51081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mX-0006sw-N9
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mU-0008Ic-GU
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mU-0008IW-Az
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:46 -0400
Date: Tue, 20 Mar 2018 05:17:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-30-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 29/50] libvhost-user: Open userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Yongji Xie <xieyongji@baidu.com>, Peter Xu <peterx@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Open a userfaultfd (on a postcopy_advise) and send it back in
the reply to the qemu for it to monitor.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  3 +++
 contrib/libvhost-user/libvhost-user.c | 42 +++++++++++++++++++++++++++++=
++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 00d78a8..074b786 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -282,6 +282,9 @@ struct VuDev {
      * re-initialize */
     vu_panic_cb panic;
     const VuDevIface *iface;
+
+    /* Postcopy data */
+    int postcopy_ufd;
 };
=20
 typedef struct VuVirtqElement {
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index ed9f314..9e31f47 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -26,9 +26,20 @@
 #include <sys/socket.h>
 #include <sys/eventfd.h>
 #include <sys/mman.h>
+#include "qemu/compiler.h"
+
+#if defined(__linux__)
+#include <sys/syscall.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
 #include <linux/vhost.h>
=20
-#include "qemu/compiler.h"
+#ifdef __NR_userfaultfd
+#include <linux/userfaultfd.h>
+#endif
+
+#endif
+
 #include "qemu/atomic.h"
=20
 #include "libvhost-user.h"
@@ -888,8 +899,35 @@ vu_set_config(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
 {
-    /* TODO: Open ufd, pass it back in the request */
+    dev->postcopy_ufd =3D -1;
+#ifdef UFFDIO_API
+    struct uffdio_api api_struct;
+
+    dev->postcopy_ufd =3D syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLO=
CK);
     vmsg->size =3D 0;
+#endif
+
+    if (dev->postcopy_ufd =3D=3D -1) {
+        vu_panic(dev, "Userfaultfd not available: %s", strerror(errno));
+        goto out;
+    }
+
+#ifdef UFFDIO_API
+    api_struct.api =3D UFFD_API;
+    api_struct.features =3D 0;
+    if (ioctl(dev->postcopy_ufd, UFFDIO_API, &api_struct)) {
+        vu_panic(dev, "Failed UFFDIO_API: %s", strerror(errno));
+        close(dev->postcopy_ufd);
+        dev->postcopy_ufd =3D -1;
+        goto out;
+    }
+    /* TODO: Stash feature flags somewhere */
+#endif
+
+out:
+    /* Return a ufd to the QEMU */
+    vmsg->fd_num =3D 1;
+    vmsg->fds[0] =3D dev->postcopy_ufd;
     return true; /* =3D send a reply */
 }
=20
--=20
MST
