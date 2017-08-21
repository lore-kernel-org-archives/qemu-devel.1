Received: from eggs.gnu.org ([2001:4830:134:3::10]:39386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1djbsf-0000hg-Nh
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 21:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1djbsc-0004wq-Mp
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 21:51:53 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:28132 helo=zte.com.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1djbsc-0004w8-Cg
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 21:51:50 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Mon, 21 Aug 2017 09:50:23 +0800
Message-Id: <1503280223-6880-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH] vhost: don't set vring call fd to -1 in
 vhost_virtqueue_start for vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

commit 96a3d98d2cdbd897ff5ab33427aa4cfb94077665 (vhost: don't set vring call
if no vector) set vring call fd to -1 for drivers does not use interrupt
at all(e.g virtio-net pmd). That patch setting vring call fd to -1 cause
the network to not work when running dpdk in the guest. The openvswitch port
status is down by executing the command "ovs-vsctl list interface"
in host of running the guest. The network is ok if it doesn't set vring call fd
to -1 in vhost_virtqueue_start.
The patch doesn't set vring call fd to -1 for vhost-user.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
---
 hw/virtio/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6eddb09..bb8db7d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1098,7 +1098,8 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
 
     if (k->query_guest_notifiers &&
         k->query_guest_notifiers(qbus->parent) &&
-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
+        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR &&
+        vdev->use_guest_notifier_mask) {
         file.fd = -1;
         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
         if (r) {
-- 
1.8.3.1
