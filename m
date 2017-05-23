Received: from eggs.gnu.org ([2001:4830:134:3::10]:49980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzo7-0004rW-Jz
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzo6-0005Ia-KH
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:23 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 May 2017 10:43:53 +0800
Message-Id: <1495507439-1784-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
References: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] virtio-net: fix wild pointer when remove
 virtio-net queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Yunjian Wang <wangyunjian@huawei.com>, qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>

From: Yunjian Wang <wangyunjian@huawei.com>

The tx_bh or tx_timer will free in virtio_net_del_queue() function, when
removing virtio-net queues if the guest doesn't support multiqueue. But
it might be still referenced by virtio_net_set_status(), which needs to
be set NULL. And also the tx_waiting needs to be set zero to prevent
virtio_net_set_status() accessing tx_bh or tx_timer.

Cc: qemu-stable@nongnu.org
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
2.7.4
