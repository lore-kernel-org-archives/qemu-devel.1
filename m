Received: from eggs.gnu.org ([2001:4830:134:3::10]:43037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp8-0002RT-2i
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp4-0007hH-UE
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1emjp4-0007gQ-Q1
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F0B3402290A
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:29:19 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 16 Feb 2018 18:29:06 +0100
Message-Id: <20180216172910.8549-2-maxime.coquelin@redhat.com>
In-Reply-To: <20180216172910.8549-1-maxime.coquelin@redhat.com>
References: <20180216172910.8549-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [RFC 1/5] vhost: send virtio device status update to
 the backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch adds a function to notify the vhost backend with
virtio device status updates.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/virtio/vhost.c                 | 11 +++++++++++
 include/hw/virtio/vhost-backend.h |  3 +++
 include/hw/virtio/vhost.h         |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 338e4395b7..95981e5a32 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1546,6 +1546,17 @@ void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
     hdev->config_ops = ops;
 }
 
+int vhost_dev_set_virtio_status(struct vhost_dev *hdev, uint8_t status)
+{
+    const VhostOps *vhost_ops = hdev->vhost_ops;
+
+    if (vhost_ops && vhost_ops->vhost_set_virtio_status) {
+        return vhost_ops->vhost_set_virtio_status(hdev, status);
+    }
+
+    return 0;
+}
+
 /* Host notifiers must be enabled at this point. */
 int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
 {
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 592254f40d..45f6b8f6c5 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -94,6 +94,8 @@ typedef int (*vhost_set_config_op)(struct vhost_dev *dev, const uint8_t *data,
                                    uint32_t flags);
 typedef int (*vhost_get_config_op)(struct vhost_dev *dev, uint8_t *config,
                                    uint32_t config_len);
+typedef int (*vhost_set_virtio_status_op)(struct vhost_dev *dev,
+                                          uint8_t status);
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
@@ -130,6 +132,7 @@ typedef struct VhostOps {
     vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
     vhost_get_config_op vhost_get_config;
     vhost_set_config_op vhost_set_config;
+    vhost_set_virtio_status_op vhost_set_virtio_status;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 1dc2d73d76..fe055b2bd5 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -121,4 +121,7 @@ int vhost_dev_set_config(struct vhost_dev *dev, const uint8_t *data,
  */
 void vhost_dev_set_config_notifier(struct vhost_dev *dev,
                                    const VhostDevConfigOps *ops);
+
+int vhost_dev_set_virtio_status(struct vhost_dev *hdev, uint8_t status);
+
 #endif
-- 
2.14.3
