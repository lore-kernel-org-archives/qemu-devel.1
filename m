Received: from eggs.gnu.org ([2001:4830:134:3::10]:44653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYbaC-0006Gh-85
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYbZP-0000Y2-F5
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:51:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eYbZP-0000X7-15
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:50:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3AA782102
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 17:50:45 +0000 (UTC)
Received: from redhat.com (ovpn-122-176.rdu2.redhat.com [10.10.122.176])
	by smtp.corp.redhat.com (Postfix) with SMTP id 9E356601B3
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 17:50:45 +0000 (UTC)
Date: Mon, 8 Jan 2018 19:50:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1515433816-5700-2-git-send-email-mst@redhat.com>
References: <1515433816-5700-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515433816-5700-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] vhost-user: fix misaligned access to
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

We currently take a pointer to a misaligned field of a packed structure.
clang reports this as a build warning.
A fix is to keep payload in a separate structure, and access is it
from there using a vectored write.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e2477a1..a9a251e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -616,33 +616,34 @@ static void slave_read(void *opaque)
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
     default:
         error_report("Received unexpected msg type.");
@@ -653,15 +654,23 @@ static void slave_read(void *opaque)
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
