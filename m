Received: from eggs.gnu.org ([2001:4830:134:3::10]:47943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dDSEc-0006sX-B5
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dDSEZ-0002iS-2c
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:05:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dDSEY-0002iD-SO
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:05:35 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Wed, 24 May 2017 11:05:20 +0200
Message-Id: <20170524090520.321-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v2] vhost-user: pass message as a pointer to
 process_message_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhiyong.yang@intel.com, mst@redhat.com, qemu-devel@nongnu.org, jfreiman@redhat.com, marcandre.lureau@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

process_message_reply() was recently updated to get full message
content instead of only its request field.

There is no need to copy all the struct content into the stack,
so just pass its pointer as const.

Cc: Zhiyong Yang <zhiyong.yang@intel.com>
Fixes: 60cd11024f41 ("hw/virtio: fix vhost user fails to startup when MQ")
Reviewed-by: Jens Freimann <jfreiman@redhat.com>
Reviewed-by: Zhiyong Yang <zhiyong.yang@intel.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
V2:
 - Make msg pointer const (Marc-Andre)
 - Apply R-b's

 hw/virtio/vhost-user.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b87a176..dde094a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -162,11 +162,11 @@ fail:
 }
 
 static int process_message_reply(struct vhost_dev *dev,
-                                 VhostUserMsg msg)
+                                 const VhostUserMsg *msg)
 {
     VhostUserMsg msg_reply;
 
-    if ((msg.flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
+    if ((msg->flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
         return 0;
     }
 
@@ -174,10 +174,10 @@ static int process_message_reply(struct vhost_dev *dev,
         return -1;
     }
 
-    if (msg_reply.request != msg.request) {
+    if (msg_reply.request != msg->request) {
         error_report("Received unexpected msg type."
                      "Expected %d received %d",
-                     msg.request, msg_reply.request);
+                     msg->request, msg_reply.request);
         return -1;
     }
 
@@ -324,7 +324,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
     }
 
     if (reply_supported) {
-        return process_message_reply(dev, msg);
+        return process_message_reply(dev, &msg);
     }
 
     return 0;
@@ -716,7 +716,7 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
 
     /* If reply_ack supported, slave has to ack specified MTU is valid */
     if (reply_supported) {
-        return process_message_reply(dev, msg);
+        return process_message_reply(dev, &msg);
     }
 
     return 0;
-- 
2.9.4
