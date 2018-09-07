Received: from eggs.gnu.org ([2001:4830:134:3::10]:60836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyOf2-00008h-GX
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyOf1-0005sF-NP
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:28 -0400
Date: Fri, 7 Sep 2018 17:51:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180907215109.146867-7-mst@redhat.com>
References: <20180907215109.146867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907215109.146867-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] vhost: fix invalid downcast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yury Kotov <yury-kotov@yandex-team.ru>, Jia He <hejianet@gmail.com>, qemu-stable@nongnu.org

From: Yury Kotov <yury-kotov@yandex-team.ru>

virtio_queue_get_desc_addr returns 64-bit hwaddr while int is usually 32-bit.
If returned hwaddr is not equal to 0 but least-significant 32 bits are
equal to 0 then this code will not actually stop running queue.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Acked-by: Jia He <hejianet@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d4cb5894a8..569c4053ea 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1073,10 +1073,8 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
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
MST
