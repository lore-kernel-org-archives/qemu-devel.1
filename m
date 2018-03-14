Received: from eggs.gnu.org ([2001:4830:134:3::10]:41653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51S-0002qN-DB
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51R-0004Yu-5v
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:56:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew51R-0004Ym-0X
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:56:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 889CE406E8D1
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:56:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Mar 2018 11:55:54 +0000
Message-Id: <20180314115618.28831-6-dgilbert@redhat.com>
In-Reply-To: <20180314115618.28831-1-dgilbert@redhat.com>
References: <20180314115618.28831-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v6 05/29] postcopy: Add vhost-user flag for
 postcopy and check it
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

Add a vhost feature flag for postcopy support, and
use the postcopy notifier to check it before allowing postcopy.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  2 ++
 docs/interop/vhost-user.txt           | 10 +++++++++
 hw/virtio/vhost-user.c                | 41 ++++++++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 18f95f65d7..96db29c4ce 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -48,6 +48,8 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_NET_MTU = 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
+    VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index cb3a7595aa..91a572d781 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -290,6 +290,15 @@ Once the source has finished migration, rings will be stopped by
 the source. No further update must be done before rings are
 restarted.
 
+In postcopy migration the slave is started before all the memory has been
+received from the source host, and care must be taken to avoid accessing pages
+that have yet to be received.  The slave opens a 'userfault'-fd and registers
+the memory with it; this fd is then passed back over to the master.
+The master services requests on the userfaultfd for pages that are accessed
+and when the page is available it performs WAKE ioctl's on the userfaultfd
+to wake the stalled slave.  The client indicates support for this via the
+VHOST_USER_PROTOCOL_F_PAGEFAULT feature.
+
 Memory access
 -------------
 
@@ -369,6 +378,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
 #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
 #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
+#define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
 
 Master message types
 --------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ef14249aa3..fc7168654c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -18,6 +18,8 @@
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "sysemu/cryptodev.h"
+#include "migration/migration.h"
+#include "migration/postcopy-ram.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -41,7 +43,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
     VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
-
+    VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -166,8 +168,10 @@ static VhostUserMsg m __attribute__ ((unused));
 static bool vhost_user_free_memslots = true;
 
 struct vhost_user {
+    struct vhost_dev *dev;
     CharBackend *chr;
     int slave_fd;
+    NotifierWithReturn postcopy_notifier;
 };
 
 static bool ioeventfd_enabled(void)
@@ -807,6 +811,33 @@ out:
     return ret;
 }
 
+static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
+                                        void *opaque)
+{
+    struct PostcopyNotifyData *pnd = opaque;
+    struct vhost_user *u = container_of(notifier, struct vhost_user,
+                                         postcopy_notifier);
+    struct vhost_dev *dev = u->dev;
+
+    switch (pnd->reason) {
+    case POSTCOPY_NOTIFY_PROBE:
+        if (!virtio_has_feature(dev->protocol_features,
+                                VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
+            /* TODO: Get the device name into this error somehow */
+            error_setg(pnd->errp,
+                       "vhost-user backend not capable of postcopy");
+            return -ENOENT;
+        }
+        break;
+
+    default:
+        /* We ignore notifications we don't know */
+        break;
+    }
+
+    return 0;
+}
+
 static int vhost_user_init(struct vhost_dev *dev, void *opaque)
 {
     uint64_t features, protocol_features;
@@ -818,6 +849,7 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
     u = g_new0(struct vhost_user, 1);
     u->chr = opaque;
     u->slave_fd = -1;
+    u->dev = dev;
     dev->opaque = u;
 
     err = vhost_user_get_features(dev, &features);
@@ -874,6 +906,9 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
         return err;
     }
 
+    u->postcopy_notifier.notify = vhost_user_postcopy_notifier;
+    postcopy_add_notifier(&u->postcopy_notifier);
+
     return 0;
 }
 
@@ -884,6 +919,10 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
     u = dev->opaque;
+    if (u->postcopy_notifier.notify) {
+        postcopy_remove_notifier(&u->postcopy_notifier);
+        u->postcopy_notifier.notify = NULL;
+    }
     if (u->slave_fd >= 0) {
         qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
         close(u->slave_fd);
-- 
2.14.3
