Received: from eggs.gnu.org ([2001:4830:134:3::10]:43395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1gX1EP-0005gT-Ts
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1gX1EM-0005vc-ON
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39145 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiangyiwen@huawei.com>)
	id 1gX1EM-0005t8-AR
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:02 -0500
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5C10DAE9.3010605@huawei.com>
Date: Wed, 12 Dec 2018 17:54:49 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vhost-vsock: support parse mergeable feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

Currently vhost-vsock doesn't have any feature bits, so it
don't support parse mergeable rx buffer feature. And the
feature is support in another series of patches named
"VSOCK: support mergeable rx buffer in vhost-vsock".

So we neet to support parse mergeable feature in vhost-vsock
if above patches are merged.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 hw/virtio/vhost-vsock.c                       | 9 +++++++--
 include/standard-headers/linux/virtio_vsock.h | 3 +++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index aa5af92..5023c05 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -178,8 +178,13 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
                                          uint64_t requested_features,
                                          Error **errp)
 {
-    /* No feature bits used yet */
-    return requested_features;
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
+    uint64_t features;
+
+    virtio_add_feature(&requested_features, VIRTIO_VSOCK_F_MRG_RXBUF);
+    features = requested_features & vsock->vhost_dev.features;
+
+    return features;
 }

 static void vhost_vsock_handle_output(VirtIODevice *vdev, VirtQueue *vq)
diff --git a/include/standard-headers/linux/virtio_vsock.h b/include/standard-headers/linux/virtio_vsock.h
index be44321..4c583ec 100644
--- a/include/standard-headers/linux/virtio_vsock.h
+++ b/include/standard-headers/linux/virtio_vsock.h
@@ -38,6 +38,9 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_config.h"

+/* Virtio-vsock feature */
+#define VIRTIO_VSOCK_F_MRG_RXBUF 0 /* Host can merge receive buffers. */
+
 struct virtio_vsock_config {
 	uint64_t guest_cid;
 } QEMU_PACKED;
-- 
1.8.3.1
