Received: from eggs.gnu.org ([2001:4830:134:3::10]:48127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB6kw-0000ny-N5
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB6kv-0005MM-5D
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:18 -0400
Date: Thu, 18 May 2017 00:45:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1495057396-13387-4-git-send-email-mst@redhat.com>
References: <1495057396-13387-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1495057396-13387-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/13] hw/virtio: fix vhost user fails to
 startup when MQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhiyong Yang <zhiyong.yang@intel.com>, qemu-stable@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jens Freimann <jfreiman@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Zhiyong Yang <zhiyong.yang@intel.com>

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
Cc: qemu-stable@nongnu.org
Fixes: ca525ce5618b ("vhost-user: Introduce a new protocol feature REPLY_=
ACK.")
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Jens Freimann <jfreiman@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/vhost-user.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9334a8a..32a95a8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -163,22 +163,26 @@ fail:
 }
=20
 static int process_message_reply(struct vhost_dev *dev,
-                                 VhostUserRequest request)
+                                 VhostUserMsg msg)
 {
-    VhostUserMsg msg;
+    VhostUserMsg msg_reply;
=20
-    if (vhost_user_read(dev, &msg) < 0) {
+    if ((msg.flags & VHOST_USER_NEED_REPLY_MASK) =3D=3D 0) {
+        return 0;
+    }
+
+    if (vhost_user_read(dev, &msg_reply) < 0) {
         return -1;
     }
=20
-    if (msg.request !=3D request) {
+    if (msg_reply.request !=3D msg.request) {
         error_report("Received unexpected msg type."
                      "Expected %d received %d",
-                     request, msg.request);
+                     msg.request, msg_reply.request);
         return -1;
     }
=20
-    return msg.payload.u64 ? -1 : 0;
+    return msg_reply.payload.u64 ? -1 : 0;
 }
=20
 static bool vhost_user_one_time_request(VhostUserRequest request)
@@ -208,6 +212,7 @@ static int vhost_user_write(struct vhost_dev *dev, Vh=
ostUserMsg *msg,
      * request, we just ignore it.
      */
     if (vhost_user_one_time_request(msg->request) && dev->vq_index !=3D =
0) {
+        msg->flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
         return 0;
     }
=20
@@ -320,7 +325,7 @@ static int vhost_user_set_mem_table(struct vhost_dev =
*dev,
     }
=20
     if (reply_supported) {
-        return process_message_reply(dev, msg.request);
+        return process_message_reply(dev, msg);
     }
=20
     return 0;
@@ -712,7 +717,7 @@ static int vhost_user_net_set_mtu(struct vhost_dev *d=
ev, uint16_t mtu)
=20
     /* If reply_ack supported, slave has to ack specified MTU is valid *=
/
     if (reply_supported) {
-        return process_message_reply(dev, msg.request);
+        return process_message_reply(dev, msg);
     }
=20
     return 0;
--=20
MST
