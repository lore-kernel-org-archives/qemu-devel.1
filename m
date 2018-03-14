Received: from eggs.gnu.org ([2001:4830:134:3::10]:41719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51e-00032U-1J
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51c-0004d6-3o
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:56:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew51b-0004cx-Uo
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:56:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7279AEAEA2
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:56:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Mar 2018 11:55:57 +0000
Message-Id: <20180314115618.28831-9-dgilbert@redhat.com>
In-Reply-To: <20180314115618.28831-1-dgilbert@redhat.com>
References: <20180314115618.28831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 08/29] libvhost-user: Open userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Open a userfaultfd (on a postcopy_advise) and send it back in
the reply to the qemu for it to monitor.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 42 +++++++++++++++++++++++++++++=
++++--
 contrib/libvhost-user/libvhost-user.h |  3 +++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index ed9f3148d3..9e31f47b7a 100644
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
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 00d78a8810..074b7860f6 100644
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
--=20
2.14.3
