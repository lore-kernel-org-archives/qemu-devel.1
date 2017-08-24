Received: from eggs.gnu.org ([2001:4830:134:3::10]:52145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxna-00025K-2O
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnY-0004SW-Qf
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxnY-0004Ri-Ga
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:12 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:06 +0100
Message-Id: <20170824192730.8440-9-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 08/32] postcopy: Add vhost-user flag for
 postcopy and check it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a vhost feature flag for postcopy support, and
use the postcopy notifier to check it before allowing postcopy.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  1 +
 docs/interop/vhost-user.txt           | 10 +++++++++
 hw/virtio/vhost-user.c                | 40 ++++++++++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index acd019876d..95d0d34a28 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -34,6 +34,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ = 0,
     VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
     VHOST_USER_PROTOCOL_F_RARP = 2,
+    VHOST_USER_PROTOCOL_F_PAGEFAULT = 7,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 954771d0d8..a279560eb0 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -273,6 +273,15 @@ Once the source has finished migration, rings will be stopped by
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
 IOMMU support
 -------------
 
@@ -327,6 +336,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_MTU            4
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
 #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
+#define VHOST_USER_PROTOCOL_F_PAGEFAULT      7
 
 Master message types
 --------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675ed98..c51bbd1296 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -17,6 +17,8 @@
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
+#include "migration/migration.h"
+#include "migration/postcopy-ram.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -34,7 +36,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_NET_MTU = 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
-
+    VHOST_USER_PROTOCOL_F_PAGEFAULT = 7,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -123,8 +125,10 @@ static VhostUserMsg m __attribute__ ((unused));
 #define VHOST_USER_VERSION    (0x1)
 
 struct vhost_user {
+    struct vhost_dev *dev;
     CharBackend *chr;
     int slave_fd;
+    NotifierWithReturn postcopy_notifier;
 };
 
 static bool ioeventfd_enabled(void)
@@ -720,6 +724,33 @@ out:
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
@@ -731,6 +762,7 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
     u = g_new0(struct vhost_user, 1);
     u->chr = opaque;
     u->slave_fd = -1;
+    u->dev = dev;
     dev->opaque = u;
 
     err = vhost_user_get_features(dev, &features);
@@ -787,6 +819,9 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
         return err;
     }
 
+    u->postcopy_notifier.notify = vhost_user_postcopy_notifier;
+    postcopy_add_notifier(&u->postcopy_notifier);
+
     return 0;
 }
 
@@ -797,6 +832,9 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
     u = dev->opaque;
+    if (u->postcopy_notifier.notify) {
+        postcopy_remove_notifier(&u->postcopy_notifier);
+    }
     if (u->slave_fd >= 0) {
         qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
         close(u->slave_fd);
-- 
2.13.5
