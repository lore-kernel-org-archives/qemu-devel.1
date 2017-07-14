Received: from eggs.gnu.org ([2001:4830:134:3::10]:49523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVzgk-0007eU-TM
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVzgg-00014o-V7
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:27:18 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Jul 2017 20:27:06 +0800
Message-Id: <1500035226-6530-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-net: fix offload ctrl endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dmitry Fleytman <dfleytma@redhat.com>

Spec said offloads should be le64, so use virtio_ldq_p() to guarantee
valid endian.

Fixes: 644c98587d4c ("virtio-net: dynamic network offloads configuration")
Cc: qemu-stable@nongnu.org
Cc: Dmitry Fleytman <dfleytma@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 657d099..eb8f5b6 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -757,6 +757,7 @@ static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
 
     if (cmd == VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET) {
         uint64_t supported_offloads;
+        offloads = virtio_ldq_p(vdev, &offloads);
 
         if (!n->has_vnet_hdr) {
             return VIRTIO_NET_ERR;
-- 
2.7.4
