Received: from eggs.gnu.org ([2001:4830:134:3::10]:50044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhiyong.yang@intel.com>) id 1d406v-0008Bc-5u
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhiyong.yang@intel.com>) id 1d406q-0003Ps-LW
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:14:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:10608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhiyong.yang@intel.com>)
	id 1d406q-0003Pe-CY
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:14:32 -0400
From: Zhiyong Yang <zhiyong.yang@intel.com>
Date: Fri, 28 Apr 2017 15:09:32 +0800
Message-Id: <1493363372-16861-1-git-send-email-zhiyong.yang@intel.com>
Subject: [Qemu-devel] [PATCH] hw/virtio: fix vhost user fails to startup
 when MQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Zhiyong Yang <zhiyong.yang@intel.com>

   Qemu2.7~2.9 and vhost user for dpdk 17.02 release work together
to cause failures of new connection when negotiating to set MQ.
(one queue pair works well).
   Because there exist some bugs in qemu code when introducing
VHOST_USER_PROTOCOL_F_REPLY_ACK to qemu. When vhost_user_set_mem_table
is invoked to deal with the vhost message VHOST_USER_SET_MEM_TABLE
for the second time, qemu indeed doesn't send the messge (The message
needs to be sent only once)but still will be waiting for dpdk's reply
ack, then, qemu is always freezing, while DPDK is always waiting for
next vhost message from qemu.
  The patch aims to fix the bug, MQ can work well.
  The same bug is found in function vhost_user_net_set_mtu, it is fixed
at the same time.
  DPDK related patch is as following:
  http://www.dpdk.org/dev/patchwork/patch/23955/

Signed-off-by: Zhiyong Yang <zhiyong.yang@intel.com>
---
 hw/virtio/vhost-user.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9334a8a..c2c54ce 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -205,10 +205,11 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
     /*
      * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
      * we just need send it once in the first time. For later such
-     * request, we just ignore it.
+     * request, we just ignore it. In this case, return value is 1 which is
+     * different from 0 that stands for message written successfully.
      */
     if (vhost_user_one_time_request(msg->request) && dev->vq_index != 0) {
-        return 0;
+        return 1;
     }
 
     if (qemu_chr_fe_set_msgfds(chr, fds, fd_num) < 0) {
@@ -270,7 +271,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
     int fds[VHOST_MEMORY_MAX_NREGIONS];
-    int i, fd;
+    int i, fd, ret;
     size_t fd_num = 0;
     bool reply_supported = virtio_has_feature(dev->protocol_features,
                                               VHOST_USER_PROTOCOL_F_REPLY_ACK);
@@ -315,11 +316,12 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
     msg.size += sizeof(msg.payload.memory.padding);
     msg.size += fd_num * sizeof(VhostUserMemoryRegion);
 
-    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
+    ret = vhost_user_write(dev, &msg, fds, fd_num);
+    if (ret < 0) {
         return -1;
     }
 
-    if (reply_supported) {
+    if (reply_supported && (ret == 0)) {
         return process_message_reply(dev, msg.request);
     }
 
@@ -691,6 +693,7 @@ static bool vhost_user_can_merge(struct vhost_dev *dev,
 static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
 {
     VhostUserMsg msg;
+    int ret;
     bool reply_supported = virtio_has_feature(dev->protocol_features,
                                               VHOST_USER_PROTOCOL_F_REPLY_ACK);
 
@@ -706,12 +709,13 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
         msg.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
-    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+    ret = vhost_user_write(dev, &msg, NULL, 0);
+    if (ret < 0) {
         return -1;
     }
 
     /* If reply_ack supported, slave has to ack specified MTU is valid */
-    if (reply_supported) {
+    if (reply_supported && (ret == 0)) {
         return process_message_reply(dev, msg.request);
     }
 
-- 
2.7.4
