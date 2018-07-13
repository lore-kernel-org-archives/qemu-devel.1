Received: from eggs.gnu.org ([2001:4830:134:3::10]:56173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1fdygY-0003Bd-Dc
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1fdygX-0007Hn-BZ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:04:38 -0400
Received: from forwardcorp1o.cmail.yandex.net ([2a02:6b8:0:1a72::290]:36753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1fdygW-0007Es-Ux
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:04:37 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Fri, 13 Jul 2018 17:04:05 +0300
Message-Id: <1531490645-10989-1-git-send-email-yury-kotov@yandex-team.ru>
Subject: [Qemu-devel] [PATCH] vhost: fix invalid downcast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, wrfsh@yandex-team.ru

virtio_queue_get_desc_addr returns 64-bit hwaddr while int is usually 32-bit.
If returned hwaddr is not equal to 0 but least-significant 32 bits are
equal to 0 then this code will not actually stop running queue.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 hw/virtio/vhost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b129cb9..7edeee7 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1071,10 +1071,8 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
         .index = vhost_vq_index,
     };
     int r;
-    int a;
 
-    a = virtio_queue_get_desc_addr(vdev, idx);
-    if (a == 0) {
+    if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
         return;
     }
-- 
2.7.4
