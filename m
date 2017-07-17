Received: from eggs.gnu.org ([2001:4830:134:3::10]:48493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52n-000117-9s
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52k-0008Le-7e
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:33 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:45 +0800
Message-Id: <1500294105-13713-15-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 14/14] virtio-net: fix offload ctrl endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org, Dmitry Fleytman <dfleytma@redhat.com>

Spec said offloads should be le64, so use virtio_ldq_p() to guarantee
valid endian.

Fixes: 644c98587d4c ("virtio-net: dynamic network offloads configuration")
Cc: qemu-stable@nongnu.org
Cc: Dmitry Fleytman <dfleytma@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 657d099..148071a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -758,6 +758,8 @@ static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
     if (cmd == VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET) {
         uint64_t supported_offloads;
 
+        offloads = virtio_ldq_p(vdev, &offloads);
+
         if (!n->has_vnet_hdr) {
             return VIRTIO_NET_ERR;
         }
-- 
2.7.4
