Received: from eggs.gnu.org ([2001:4830:134:3::10]:43749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhSxa-0003lN-I6
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhSxX-00051W-NZ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:45043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fhSxX-0004yY-Ef
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:35 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Mon, 23 Jul 2018 12:59:56 +0800
Message-Id: <20180723045956.27521-4-tiwei.bie@intel.com>
In-Reply-To: <20180723045956.27521-1-tiwei.bie@intel.com>
References: <20180723045956.27521-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [RFC 3/3] vhost-user: support programming VFIO group
 in master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: tiwei.bie@intel.com

Introduce a slave message to allow slave to share its
VFIO group fd to master and do the IOMMU programming
based on virtio device's DMA address space for this
group in QEMU.

For the vhost backends which support vDPA, they could
leverage this message to ask master to do the IOMMU
programming in QEMU for the vDPA device in backend.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 docs/interop/vhost-user.txt    | 16 ++++++++++++++
 hw/virtio/vhost-user.c         | 40 ++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user.h |  2 ++
 3 files changed, 58 insertions(+)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index f59667f498..a57a8f9451 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -397,6 +397,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_CONFIG         9
 #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
 #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
+#define VHOST_USER_PROTOCOL_F_VFIO_GROUP     12
 
 Master message types
 --------------------
@@ -815,6 +816,21 @@ Slave message types
       This request should be sent only when VHOST_USER_PROTOCOL_F_HOST_NOTIFIER
       protocol feature has been successfully negotiated.
 
+ * VHOST_USER_SLAVE_VFIO_GROUP_MSG
+
+      Id: 4
+      Equivalent ioctl: N/A
+      Slave payload: N/A
+      Master payload: N/A
+
+      When VHOST_USER_PROTOCOL_F_VFIO_GROUP is negotiated, vhost-user slave
+      could send this request to share its VFIO group fd via ancillary data
+      to master. After receiving this request from slave, master will close
+      the existing VFIO group if any and do the DMA programming based on the
+      virtio device's DMA address space for the new group if the request is
+      sent with a file descriptor.
+
+
 VHOST_USER_PROTOCOL_F_REPLY_ACK:
 -------------------------------
 The original vhost-user specification only demands replies for certain
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b041343632..db958e24c7 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -52,6 +52,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CONFIG = 9,
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
+    VHOST_USER_PROTOCOL_F_VFIO_GROUP = 12,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -97,6 +98,7 @@ typedef enum VhostUserSlaveRequest {
     VHOST_USER_SLAVE_IOTLB_MSG = 1,
     VHOST_USER_SLAVE_CONFIG_CHANGE_MSG = 2,
     VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG = 3,
+    VHOST_USER_SLAVE_VFIO_GROUP_MSG = 4,
     VHOST_USER_SLAVE_MAX
 }  VhostUserSlaveRequest;
 
@@ -949,6 +951,41 @@ static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
     return 0;
 }
 
+static int vhost_user_slave_handle_vfio_group(struct vhost_dev *dev,
+                                              int *fd)
+{
+    struct vhost_user *u = dev->opaque;
+    VhostUserState *user = u->user;
+    VirtIODevice *vdev = dev->vdev;
+    int groupfd = fd[0];
+    VFIOGroup *group;
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_VFIO_GROUP) ||
+        vdev == NULL) {
+        return -1;
+    }
+
+    if (user->vfio_group) {
+        vfio_put_group(user->vfio_group);
+        user->vfio_group = NULL;
+    }
+
+    group = vfio_get_group_from_fd(groupfd, vdev->dma_as, NULL);
+    if (group == NULL) {
+        return -1;
+    }
+
+    if (group->fd != groupfd) {
+        close(groupfd);
+    }
+
+    user->vfio_group = group;
+    fd[0] = -1;
+
+    return 0;
+}
+
 static void slave_read(void *opaque)
 {
     struct vhost_dev *dev = opaque;
@@ -1021,6 +1058,9 @@ static void slave_read(void *opaque)
         ret = vhost_user_slave_handle_vring_host_notifier(dev, &payload.area,
                                                           fd[0]);
         break;
+    case VHOST_USER_SLAVE_VFIO_GROUP_MSG:
+        ret = vhost_user_slave_handle_vfio_group(dev, fd);
+        break;
     default:
         error_report("Received unexpected msg type.");
         ret = -EINVAL;
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index fd660393a0..9e11473274 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -10,6 +10,7 @@
 
 #include "chardev/char-fe.h"
 #include "hw/virtio/virtio.h"
+#include "hw/vfio/vfio-common.h"
 
 typedef struct VhostUserHostNotifier {
     MemoryRegion mr;
@@ -20,6 +21,7 @@ typedef struct VhostUserHostNotifier {
 typedef struct VhostUserState {
     CharBackend *chr;
     VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
+    VFIOGroup *vfio_group;
 } VhostUserState;
 
 VhostUserState *vhost_user_init(void);
-- 
2.18.0
