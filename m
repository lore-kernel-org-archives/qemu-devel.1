Received: from eggs.gnu.org ([2001:4830:134:3::10]:59398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8On-0000Jz-L5
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8Om-0006N8-KT
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dF8Om-0006N4-Bg
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:04 -0400
Date: Mon, 29 May 2017 03:18:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496017081-24032-12-git-send-email-mst@redhat.com>
References: <1496017081-24032-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1496017081-24032-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/13] vhost-user: pass message as a pointer to
 process_message_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Zhiyong Yang <zhiyong.yang@intel.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

process_message_reply() was recently updated to get full message
content instead of only its request field.

There is no need to copy all the struct content into the stack,
so just pass its pointer as const.

Reviewed-by: Jens Freimann <jfreiman@redhat.com>
Reviewed-by: Zhiyong Yang <zhiyong.yang@intel.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/vhost-user.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b87a176..dde094a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -162,11 +162,11 @@ fail:
 }
=20
 static int process_message_reply(struct vhost_dev *dev,
-                                 VhostUserMsg msg)
+                                 const VhostUserMsg *msg)
 {
     VhostUserMsg msg_reply;
=20
-    if ((msg.flags & VHOST_USER_NEED_REPLY_MASK) =3D=3D 0) {
+    if ((msg->flags & VHOST_USER_NEED_REPLY_MASK) =3D=3D 0) {
         return 0;
     }
=20
@@ -174,10 +174,10 @@ static int process_message_reply(struct vhost_dev *=
dev,
         return -1;
     }
=20
-    if (msg_reply.request !=3D msg.request) {
+    if (msg_reply.request !=3D msg->request) {
         error_report("Received unexpected msg type."
                      "Expected %d received %d",
-                     msg.request, msg_reply.request);
+                     msg->request, msg_reply.request);
         return -1;
     }
=20
@@ -324,7 +324,7 @@ static int vhost_user_set_mem_table(struct vhost_dev =
*dev,
     }
=20
     if (reply_supported) {
-        return process_message_reply(dev, msg);
+        return process_message_reply(dev, &msg);
     }
=20
     return 0;
@@ -716,7 +716,7 @@ static int vhost_user_net_set_mtu(struct vhost_dev *d=
ev, uint16_t mtu)
=20
     /* If reply_ack supported, slave has to ack specified MTU is valid *=
/
     if (reply_supported) {
-        return process_message_reply(dev, msg);
+        return process_message_reply(dev, &msg);
     }
=20
     return 0;
--=20
MST
