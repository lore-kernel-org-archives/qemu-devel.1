Received: from eggs.gnu.org ([2001:4830:134:3::10]:57839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1fJnac-0000Oe-P8
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1fJnaY-00007i-PD
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:11:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:6552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1fJnaY-0008VA-Ff
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:11:02 -0400
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Sat, 19 May 2018 06:20:16 +0800
Message-Id: <1526682016-17336-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH] vhost-blk: turn on pre-defined RO feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, changpeng.liu@intel.com

Read only feature shouldn't be negotiable, because if the
backend device reported Read only feature supported, QEMU
host driver shouldn't change backend's RO attribute.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 hw/block/vhost-user-blk.c          | 5 +----
 include/hw/virtio/vhost-user-blk.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 262baca..cdc54dd 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -204,13 +204,11 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
     virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
     virtio_add_feature(&features, VIRTIO_BLK_F_FLUSH);
+    virtio_add_feature(&features, VIRTIO_BLK_F_RO);
 
     if (s->config_wce) {
         virtio_add_feature(&features, VIRTIO_BLK_F_CONFIG_WCE);
     }
-    if (s->config_ro) {
-        virtio_add_feature(&features, VIRTIO_BLK_F_RO);
-    }
     if (s->num_queues > 1) {
         virtio_add_feature(&features, VIRTIO_BLK_F_MQ);
     }
@@ -322,7 +320,6 @@ static Property vhost_user_blk_properties[] = {
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues, 1),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
     DEFINE_PROP_BIT("config-wce", VHostUserBlk, config_wce, 0, true),
-    DEFINE_PROP_BIT("config-ro", VHostUserBlk, config_ro, 0, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 5804cc9..8c7c79b 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -34,7 +34,6 @@ typedef struct VHostUserBlk {
     uint16_t num_queues;
     uint32_t queue_size;
     uint32_t config_wce;
-    uint32_t config_ro;
     struct vhost_dev dev;
 } VHostUserBlk;
 
-- 
1.9.3
