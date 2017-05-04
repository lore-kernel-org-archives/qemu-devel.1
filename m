Received: from eggs.gnu.org ([2001:4830:134:3::10]:51184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhiyong.yang@intel.com>) id 1d6JeK-0005fb-Im
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhiyong.yang@intel.com>) id 1d6JeG-0004jG-LJ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:30:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:62621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhiyong.yang@intel.com>)
	id 1d6JeG-0004iY-BC
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:30:36 -0400
From: Zhiyong Yang <zhiyong.yang@intel.com>
Date: Fri,  5 May 2017 00:25:36 +0800
Message-Id: <1493915136-19150-1-git-send-email-zhiyong.yang@intel.com>
In-Reply-To: <1493363372-16861-1-git-send-email-zhiyong.yang@intel.com>
References: <1493363372-16861-1-git-send-email-zhiyong.yang@intel.com>
Subject: [Qemu-devel] [PATCH v2] hw/virtio: fix vhost user fails to startup
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
Cc: mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@gmail.com, Zhiyong Yang <zhiyong.yang@intel.com>

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

Changes in V2:
Thanks for Maxime's suggestion, if one-time request, clear the
VHOST_USER_NEED_REPLY flag in function vhost_user_write,
in process_message_reply(), return early, if this flag isn't set.

 hw/virtio/vhost-user.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9334a8a..32a95a8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -163,22 +163,26 @@ fail:
 }
 
 static int process_message_reply(struct vhost_dev *dev,
-                                 VhostUserRequest request)
+                                 VhostUserMsg msg)
 {
-    VhostUserMsg msg;
+    VhostUserMsg msg_reply;
 
-    if (vhost_user_read(dev, &msg) < 0) {
+    if ((msg.flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
+        return 0;
+    }
+
+    if (vhost_user_read(dev, &msg_reply) < 0) {
         return -1;
     }
 
-    if (msg.request != request) {
+    if (msg_reply.request != msg.request) {
         error_report("Received unexpected msg type."
                      "Expected %d received %d",
-                     request, msg.request);
+                     msg.request, msg_reply.request);
         return -1;
     }
 
-    return msg.payload.u64 ? -1 : 0;
+    return msg_reply.payload.u64 ? -1 : 0;
 }
 
 static bool vhost_user_one_time_request(VhostUserRequest request)
@@ -208,6 +212,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
      * request, we just ignore it.
      */
     if (vhost_user_one_time_request(msg->request) && dev->vq_index != 0) {
+        msg->flags &= ~VHOST_USER_NEED_REPLY_MASK;
         return 0;
     }
 
@@ -320,7 +325,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
     }
 
     if (reply_supported) {
-        return process_message_reply(dev, msg.request);
+        return process_message_reply(dev, msg);
     }
 
     return 0;
@@ -712,7 +717,7 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
 
     /* If reply_ack supported, slave has to ack specified MTU is valid */
     if (reply_supported) {
-        return process_message_reply(dev, msg.request);
+        return process_message_reply(dev, msg);
     }
 
     return 0;
-- 
2.7.4
