Received: from eggs.gnu.org ([2001:4830:134:3::10]:44642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ea0oY-0001w2-BO
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ea0oS-0003NE-3y
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:00:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ea0oR-0003Ks-Uy
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:00:08 -0500
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 12 Jan 2018 15:56:58 +0100
Message-Id: <20180112145658.17121-5-maxime.coquelin@redhat.com>
In-Reply-To: <20180112145658.17121-1-maxime.coquelin@redhat.com>
References: <20180112145658.17121-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] virtio-net: notify backend with number of
 queue pairs setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, mlureau@redhat.com, zhengxiang9@huawei.com, lersek@redhat.com, pbonzini@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/net/virtio-net.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 38674b08aa..b8908c98ed 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -561,6 +561,7 @@ static int peer_detach(VirtIONet *n, int index)
 
 static void virtio_net_set_queues(VirtIONet *n)
 {
+    NetClientState *nc = qemu_get_queue(n->nic);
     int i;
     int r;
 
@@ -568,6 +569,10 @@ static void virtio_net_set_queues(VirtIONet *n)
         return;
     }
 
+    if (get_vhost_net(nc->peer)) {
+        vhost_net_set_queue_num(nc->peer, n->curr_queues);
+    }
+
     for (i = 0; i < n->max_queues; i++) {
         if (i < n->curr_queues) {
             r = peer_attach(n, i);
-- 
2.14.3
