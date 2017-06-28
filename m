Received: from eggs.gnu.org ([2001:4830:134:3::10]:40350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDc-0004Vk-BG
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDb-00086K-Fc
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIDb-00085x-69
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:39 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:25 +0100
Message-Id: <20170628190047.26159-8-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 07/29] postcopy: Add vhost-user flag for postcopy
 and check it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a vhost feature flag for postcopy support, and
use the postcopy notifier to check it before allowing postcopy.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  1 +
 hw/virtio/vhost-user.c                | 39 ++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 53ef222c0b..82a6bf4549 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -34,6 +34,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ = 0,
     VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
     VHOST_USER_PROTOCOL_F_RARP = 2,
+    VHOST_USER_PROTOCOL_F_POSTCOPY = 6,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 958ee09bcb..78eaf9b022 100644
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
@@ -33,7 +35,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
     VHOST_USER_PROTOCOL_F_NET_MTU = 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
-
+    VHOST_USER_PROTOCOL_F_POSTCOPY = 6,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -121,8 +123,10 @@ static VhostUserMsg m __attribute__ ((unused));
 #define VHOST_USER_VERSION    (0x1)
 
 struct vhost_user {
+    struct vhost_dev *dev;
     CharBackend *chr;
     int slave_fd;
+    NotifierWithReturn postcopy_notifier;
 };
 
 static bool ioeventfd_enabled(void)
@@ -701,6 +705,33 @@ out:
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
+                                VHOST_USER_PROTOCOL_F_POSTCOPY)) {
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
@@ -712,6 +743,7 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
     u = g_new0(struct vhost_user, 1);
     u->chr = opaque;
     u->slave_fd = -1;
+    u->dev = dev;
     dev->opaque = u;
 
     err = vhost_user_get_features(dev, &features);
@@ -763,11 +795,15 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
                    "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
     }
 
+    u->postcopy_notifier.notify = vhost_user_postcopy_notifier;
+
     err = vhost_setup_slave_channel(dev);
     if (err < 0) {
         return err;
     }
 
+    postcopy_add_notifier(&u->postcopy_notifier);
+
     return 0;
 }
 
@@ -778,6 +814,7 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
     u = dev->opaque;
+    postcopy_remove_notifier(&u->postcopy_notifier);
     if (u->slave_fd >= 0) {
         close(u->slave_fd);
         u->slave_fd = -1;
-- 
2.13.0
