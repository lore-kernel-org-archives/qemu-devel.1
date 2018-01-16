Received: from eggs.gnu.org ([2001:4830:134:3::10]:46343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVQ9-0001s5-Hh
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVQ8-0004IC-I2
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:53:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebVQ8-0004HS-9V
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:53:12 -0500
Date: Tue, 16 Jan 2018 19:53:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516121887-32738-32-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 31/34] vhost-user: fix misaligned access to
 payload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

We currently take a pointer to a misaligned field of a packed structure.
clang reports this as a build warning.
A fix is to keep payload in a separate structure, and access is it
from there using a vectored write.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 6ac3610..7930fd8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -652,33 +652,34 @@ static void slave_read(void *opaque)
 {
     struct vhost_dev *dev = opaque;
     struct vhost_user *u = dev->opaque;
-    VhostUserMsg msg = { 0, };
+    VhostUserHeader hdr = { 0, };
+    VhostUserPayload payload = { 0, };
     int size, ret = 0;
 
     /* Read header */
-    size = read(u->slave_fd, &msg, VHOST_USER_HDR_SIZE);
+    size = read(u->slave_fd, &hdr, VHOST_USER_HDR_SIZE);
     if (size != VHOST_USER_HDR_SIZE) {
         error_report("Failed to read from slave.");
         goto err;
     }
 
-    if (msg.hdr.size > VHOST_USER_PAYLOAD_SIZE) {
+    if (hdr.size > VHOST_USER_PAYLOAD_SIZE) {
         error_report("Failed to read msg header."
-                " Size %d exceeds the maximum %zu.", msg.hdr.size,
+                " Size %d exceeds the maximum %zu.", hdr.size,
                 VHOST_USER_PAYLOAD_SIZE);
         goto err;
     }
 
     /* Read payload */
-    size = read(u->slave_fd, &msg.payload, msg.hdr.size);
-    if (size != msg.hdr.size) {
+    size = read(u->slave_fd, &payload, hdr.size);
+    if (size != hdr.size) {
         error_report("Failed to read payload from slave.");
         goto err;
     }
 
-    switch (msg.hdr.request) {
+    switch (hdr.request) {
     case VHOST_USER_SLAVE_IOTLB_MSG:
-        ret = vhost_backend_handle_iotlb_msg(dev, &msg.payload.iotlb);
+        ret = vhost_backend_handle_iotlb_msg(dev, &payload.iotlb);
         break;
     case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG :
         ret = vhost_user_slave_handle_config_change(dev);
@@ -692,15 +693,23 @@ static void slave_read(void *opaque)
      * REPLY_ACK feature handling. Other reply types has to be managed
      * directly in their request handlers.
      */
-    if (msg.hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
-        msg.hdr.flags &= ~VHOST_USER_NEED_REPLY_MASK;
-        msg.hdr.flags |= VHOST_USER_REPLY_MASK;
+    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+        struct iovec iovec[2];
 
-        msg.payload.u64 = !!ret;
-        msg.hdr.size = sizeof(msg.payload.u64);
 
-        size = write(u->slave_fd, &msg, VHOST_USER_HDR_SIZE + msg.hdr.size);
-        if (size != VHOST_USER_HDR_SIZE + msg.hdr.size) {
+        hdr.flags &= ~VHOST_USER_NEED_REPLY_MASK;
+        hdr.flags |= VHOST_USER_REPLY_MASK;
+
+        payload.u64 = !!ret;
+        hdr.size = sizeof(payload.u64);
+
+        iovec[0].iov_base = &hdr;
+        iovec[0].iov_len = VHOST_USER_HDR_SIZE;
+        iovec[1].iov_base = &payload;
+        iovec[1].iov_len = hdr.size;
+
+        size = writev(u->slave_fd, iovec, ARRAY_SIZE(iovec));
+        if (size != VHOST_USER_HDR_SIZE + hdr.size) {
             error_report("Failed to send msg reply to slave.");
             goto err;
         }
-- 
MST
