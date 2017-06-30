Received: from eggs.gnu.org ([2001:4830:134:3::10]:57953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dQyPc-0005Hx-M1
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dQyPX-0004yl-On
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:04:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dQyPX-0004xJ-J9
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:04:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 204A83345BE
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 16:04:45 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 30 Jun 2017 18:04:21 +0200
Message-Id: <20170630160422.14842-2-maxime.coquelin@redhat.com>
In-Reply-To: <20170630160422.14842-1-maxime.coquelin@redhat.com>
References: <20170630160422.14842-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] vhost: ensure vhost_ops are set before
 calling iotlb callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, mlureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch fixes a crash that happens when vhost-user iommu
support is enabled and vhost-user socket is closed.

When it happens, if an IOTLB invalidation notification is sent
by the IOMMU, vhost_ops's NULL pointer is dereferenced.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/virtio/vhost-backend.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 4e31de1..cb055e8 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -309,7 +309,10 @@ int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
         return -EINVAL;
     }
 
-    return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+    if (dev->vhost_ops && dev->vhost_ops->vhost_send_device_iotlb_msg)
+        return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+
+    return -ENODEV;
 }
 
 int vhost_backend_invalidate_device_iotlb(struct vhost_dev *dev,
@@ -321,7 +324,10 @@ int vhost_backend_invalidate_device_iotlb(struct vhost_dev *dev,
     imsg.size = len;
     imsg.type = VHOST_IOTLB_INVALIDATE;
 
-    return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+    if (dev->vhost_ops && dev->vhost_ops->vhost_send_device_iotlb_msg)
+        return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+
+    return -ENODEV;
 }
 
 int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
-- 
2.9.4
