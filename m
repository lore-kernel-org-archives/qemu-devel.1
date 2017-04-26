Received: from eggs.gnu.org ([2001:4830:134:3::10]:54804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d3Gio-0002cV-K3
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d3Gij-00025P-Rw
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:46:42 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3857
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d3Gij-00020o-DT
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:46:37 -0400
From: Yunjian Wang <wangyunjian@huawei.com>
Date: Wed, 26 Apr 2017 14:45:56 +0800
Message-ID: <1493189156-14656-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] virtio-net: fix wild pointer when remove
 virtio-net queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: caihe@huawei.com, Yunjian Wang <wangyunjian@huawei.com>

The tx_bh or tx_timer will free in virtio_net_del_queue() function, when
removing virtio-net queues if the guest doesn't support multiqueue. But
it might be still referenced by virtio_net_set_status(), which needs to
be set NULL. And also the tx_waiting needs to be set zero to prevent
virtio_net_set_status() accessing tx_bh or tx_timer.

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 hw/net/virtio-net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7d091c9..98bd683 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1522,9 +1522,12 @@ static void virtio_net_del_queue(VirtIONet *n, int index)
     if (q->tx_timer) {
         timer_del(q->tx_timer);
         timer_free(q->tx_timer);
+        q->tx_timer = NULL;
     } else {
         qemu_bh_delete(q->tx_bh);
+        q->tx_bh = NULL;
     }
+    q->tx_waiting = 0;
     virtio_del_queue(vdev, index * 2 + 1);
 }
 
-- 
1.8.3.1
