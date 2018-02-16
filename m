Received: from eggs.gnu.org ([2001:4830:134:3::10]:51758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emfsX-0001Gc-KR
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emfsW-0005ia-Hn
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emfsW-0005hz-Bj
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07261404085A
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 13:16:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Feb 2018 13:16:04 +0000
Message-Id: <20180216131625.9639-9-dgilbert@redhat.com>
In-Reply-To: <20180216131625.9639-1-dgilbert@redhat.com>
References: <20180216131625.9639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/29] libvhost-user: Open userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, imammedo@redhat.com, mst@redhat.com
Cc: quintela@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Open a userfaultfd (on a postcopy_advise) and send it back in
the reply to the qemu for it to monitor.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 45 +++++++++++++++++++++++++++++++----
 contrib/libvhost-user/libvhost-user.h |  3 +++
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index eb0ab9338c..0b563fc5ae 100644
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
 
-#include "qemu/compiler.h"
+#ifdef __NR_userfaultfd
+#include <linux/userfaultfd.h>
+#endif
+
+#endif
+
 #include "qemu/atomic.h"
 
 #include "libvhost-user.h"
@@ -888,11 +899,37 @@ vu_set_config(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
 {
-    /* TODO: Open ufd, pass it back in the request
-     * TODO: Add addresses
-     */
+    dev->postcopy_ufd = -1;
+#ifdef UFFDIO_API
+    struct uffdio_api api_struct;
+
+    dev->postcopy_ufd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+    /* TODO: Add addresses */
     vmsg->payload.u64 = 0xcafe;
     vmsg->size = sizeof(vmsg->payload.u64);
+#endif
+
+    if (dev->postcopy_ufd == -1) {
+        vu_panic(dev, "Userfaultfd not available: %s", strerror(errno));
+        goto out;
+    }
+
+#ifdef UFFDIO_API
+    api_struct.api = UFFD_API;
+    api_struct.features = 0;
+    if (ioctl(dev->postcopy_ufd, UFFDIO_API, &api_struct)) {
+        vu_panic(dev, "Failed UFFDIO_API: %s", strerror(errno));
+        close(dev->postcopy_ufd);
+        dev->postcopy_ufd = -1;
+        goto out;
+    }
+    /* TODO: Stash feature flags somewhere */
+#endif
+
+out:
+    /* Return a ufd to the QEMU */
+    vmsg->fd_num = 1;
+    vmsg->fds[0] = dev->postcopy_ufd;
     return true; /* = send a reply */
 }
 
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 9c3a180777..bb33b33f3b 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -279,6 +279,9 @@ struct VuDev {
      * re-initialize */
     vu_panic_cb panic;
     const VuDevIface *iface;
+
+    /* Postcopy data */
+    int postcopy_ufd;
 };
 
 typedef struct VuVirtqElement {
-- 
2.14.3
