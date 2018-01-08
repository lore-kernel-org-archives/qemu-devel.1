Received: from eggs.gnu.org ([2001:4830:134:3::10]:44684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYbaF-0006Ih-K1
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYbZO-0000XB-CG
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:51:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eYbZN-0000Vx-Mo
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:50:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1AC6C051665
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 17:50:44 +0000 (UTC)
Received: from redhat.com (ovpn-122-176.rdu2.redhat.com [10.10.122.176])
	by smtp.corp.redhat.com (Postfix) with SMTP id 53B98605E1
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 17:50:44 +0000 (UTC)
Date: Mon, 8 Jan 2018 19:50:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1515433816-5700-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH 1/2] vhost-user: factor out msg head and payload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

split header and payload into separate structures,
to enable easier handling of alignment issues.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 192 +++++++++++++++++++++++++------------------------
 1 file changed, 98 insertions(+), 94 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675e..e2477a1 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -92,15 +92,7 @@ typedef struct VhostUserLog {
     uint64_t mmap_offset;
 } VhostUserLog;
 
-typedef struct VhostUserMsg {
-    VhostUserRequest request;
-
-#define VHOST_USER_VERSION_MASK     (0x3)
-#define VHOST_USER_REPLY_MASK       (0x1<<2)
-#define VHOST_USER_NEED_REPLY_MASK  (0x1 << 3)
-    uint32_t flags;
-    uint32_t size; /* the following payload size */
-    union {
+typedef union {
 #define VHOST_USER_VRING_IDX_MASK   (0xff)
 #define VHOST_USER_VRING_NOFD_MASK  (0x1<<8)
         uint64_t u64;
@@ -109,15 +101,27 @@ typedef struct VhostUserMsg {
         VhostUserMemory memory;
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
-    } payload;
+} VhostUserPayload;
+
+typedef struct {
+    VhostUserRequest request;
+
+#define VHOST_USER_VERSION_MASK     (0x3)
+#define VHOST_USER_REPLY_MASK       (0x1<<2)
+#define VHOST_USER_NEED_REPLY_MASK  (0x1 << 3)
+    uint32_t flags;
+    uint32_t size; /* the following payload size */
+} QEMU_PACKED VhostUserHeader;
+
+typedef struct VhostUserMsg {
+    VhostUserHeader hdr;
+    VhostUserPayload payload;
 } QEMU_PACKED VhostUserMsg;
 
 static VhostUserMsg m __attribute__ ((unused));
-#define VHOST_USER_HDR_SIZE (sizeof(m.request) \
-                            + sizeof(m.flags) \
-                            + sizeof(m.size))
+#define VHOST_USER_HDR_SIZE (sizeof(VhostUserHeader))
 
-#define VHOST_USER_PAYLOAD_SIZE (sizeof(m) - VHOST_USER_HDR_SIZE)
+#define VHOST_USER_PAYLOAD_SIZE (sizeof(VhostUserPayload))
 
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    (0x1)
@@ -142,33 +146,33 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
     r = qemu_chr_fe_read_all(chr, p, size);
     if (r != size) {
         error_report("Failed to read msg header. Read %d instead of %d."
-                     " Original request %d.", r, size, msg->request);
+                     " Original request %d.", r, size, msg->hdr.request);
         goto fail;
     }
 
     /* validate received flags */
-    if (msg->flags != (VHOST_USER_REPLY_MASK | VHOST_USER_VERSION)) {
+    if (msg->hdr.flags != (VHOST_USER_REPLY_MASK | VHOST_USER_VERSION)) {
         error_report("Failed to read msg header."
-                " Flags 0x%x instead of 0x%x.", msg->flags,
+                " Flags 0x%x instead of 0x%x.", msg->hdr.flags,
                 VHOST_USER_REPLY_MASK | VHOST_USER_VERSION);
         goto fail;
     }
 
     /* validate message size is sane */
-    if (msg->size > VHOST_USER_PAYLOAD_SIZE) {
+    if (msg->hdr.size > VHOST_USER_PAYLOAD_SIZE) {
         error_report("Failed to read msg header."
-                " Size %d exceeds the maximum %zu.", msg->size,
+                " Size %d exceeds the maximum %zu.", msg->hdr.size,
                 VHOST_USER_PAYLOAD_SIZE);
         goto fail;
     }
 
-    if (msg->size) {
+    if (msg->hdr.size) {
         p += VHOST_USER_HDR_SIZE;
-        size = msg->size;
+        size = msg->hdr.size;
         r = qemu_chr_fe_read_all(chr, p, size);
         if (r != size) {
             error_report("Failed to read msg payload."
-                         " Read %d instead of %d.", r, msg->size);
+                         " Read %d instead of %d.", r, msg->hdr.size);
             goto fail;
         }
     }
@@ -184,7 +188,7 @@ static int process_message_reply(struct vhost_dev *dev,
 {
     VhostUserMsg msg_reply;
 
-    if ((msg->flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
+    if ((msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
         return 0;
     }
 
@@ -192,10 +196,10 @@ static int process_message_reply(struct vhost_dev *dev,
         return -1;
     }
 
-    if (msg_reply.request != msg->request) {
+    if (msg_reply.hdr.request != msg->hdr.request) {
         error_report("Received unexpected msg type."
                      "Expected %d received %d",
-                     msg->request, msg_reply.request);
+                     msg->hdr.request, msg_reply.hdr.request);
         return -1;
     }
 
@@ -222,15 +226,15 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
 {
     struct vhost_user *u = dev->opaque;
     CharBackend *chr = u->chr;
-    int ret, size = VHOST_USER_HDR_SIZE + msg->size;
+    int ret, size = VHOST_USER_HDR_SIZE + msg->hdr.size;
 
     /*
      * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
      * we just need send it once in the first time. For later such
      * request, we just ignore it.
      */
-    if (vhost_user_one_time_request(msg->request) && dev->vq_index != 0) {
-        msg->flags &= ~VHOST_USER_NEED_REPLY_MASK;
+    if (vhost_user_one_time_request(msg->hdr.request) && dev->vq_index != 0) {
+        msg->hdr.flags &= ~VHOST_USER_NEED_REPLY_MASK;
         return 0;
     }
 
@@ -257,11 +261,11 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     bool shmfd = virtio_has_feature(dev->protocol_features,
                                     VHOST_USER_PROTOCOL_F_LOG_SHMFD);
     VhostUserMsg msg = {
-        .request = VHOST_USER_SET_LOG_BASE,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_SET_LOG_BASE,
+        .hdr.flags = VHOST_USER_VERSION,
         .payload.log.mmap_size = log->size * sizeof(*(log->log)),
         .payload.log.mmap_offset = 0,
-        .size = sizeof(msg.payload.log),
+        .hdr.size = sizeof(msg.payload.log),
     };
 
     if (shmfd && log->fd != -1) {
@@ -273,15 +277,15 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     }
 
     if (shmfd) {
-        msg.size = 0;
+        msg.hdr.size = 0;
         if (vhost_user_read(dev, &msg) < 0) {
             return -1;
         }
 
-        if (msg.request != VHOST_USER_SET_LOG_BASE) {
+        if (msg.hdr.request != VHOST_USER_SET_LOG_BASE) {
             error_report("Received unexpected msg type. "
                          "Expected %d received %d",
-                         VHOST_USER_SET_LOG_BASE, msg.request);
+                         VHOST_USER_SET_LOG_BASE, msg.hdr.request);
             return -1;
         }
     }
@@ -299,12 +303,12 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                               VHOST_USER_PROTOCOL_F_REPLY_ACK);
 
     VhostUserMsg msg = {
-        .request = VHOST_USER_SET_MEM_TABLE,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_SET_MEM_TABLE,
+        .hdr.flags = VHOST_USER_VERSION,
     };
 
     if (reply_supported) {
-        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
     for (i = 0; i < dev->mem->nregions; ++i) {
@@ -334,9 +338,9 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         return -1;
     }
 
-    msg.size = sizeof(msg.payload.memory.nregions);
-    msg.size += sizeof(msg.payload.memory.padding);
-    msg.size += fd_num * sizeof(VhostUserMemoryRegion);
+    msg.hdr.size = sizeof(msg.payload.memory.nregions);
+    msg.hdr.size += sizeof(msg.payload.memory.padding);
+    msg.hdr.size += fd_num * sizeof(VhostUserMemoryRegion);
 
     if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
         return -1;
@@ -353,10 +357,10 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
                                      struct vhost_vring_addr *addr)
 {
     VhostUserMsg msg = {
-        .request = VHOST_USER_SET_VRING_ADDR,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_SET_VRING_ADDR,
+        .hdr.flags = VHOST_USER_VERSION,
         .payload.addr = *addr,
-        .size = sizeof(msg.payload.addr),
+        .hdr.size = sizeof(msg.payload.addr),
     };
 
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
@@ -372,10 +376,10 @@ static int vhost_user_set_vring_endian(struct vhost_dev *dev,
     bool cross_endian = virtio_has_feature(dev->protocol_features,
                                            VHOST_USER_PROTOCOL_F_CROSS_ENDIAN);
     VhostUserMsg msg = {
-        .request = VHOST_USER_SET_VRING_ENDIAN,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_SET_VRING_ENDIAN,
+        .hdr.flags = VHOST_USER_VERSION,
         .payload.state = *ring,
-        .size = sizeof(msg.payload.state),
+        .hdr.size = sizeof(msg.payload.state),
     };
 
     if (!cross_endian) {
@@ -395,10 +399,10 @@ static int vhost_set_vring(struct vhost_dev *dev,
                            struct vhost_vring_state *ring)
 {
     VhostUserMsg msg = {
-        .request = request,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = request,
+        .hdr.flags = VHOST_USER_VERSION,
         .payload.state = *ring,
-        .size = sizeof(msg.payload.state),
+        .hdr.size = sizeof(msg.payload.state),
     };
 
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
@@ -444,10 +448,10 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
                                      struct vhost_vring_state *ring)
 {
     VhostUserMsg msg = {
-        .request = VHOST_USER_GET_VRING_BASE,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_GET_VRING_BASE,
+        .hdr.flags = VHOST_USER_VERSION,
         .payload.state = *ring,
-        .size = sizeof(msg.payload.state),
+        .hdr.size = sizeof(msg.payload.state),
     };
 
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
@@ -458,13 +462,13 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
         return -1;
     }
 
-    if (msg.request != VHOST_USER_GET_VRING_BASE) {
+    if (msg.hdr.request != VHOST_USER_GET_VRING_BASE) {
         error_report("Received unexpected msg type. Expected %d received %d",
-                     VHOST_USER_GET_VRING_BASE, msg.request);
+                     VHOST_USER_GET_VRING_BASE, msg.hdr.request);
         return -1;
     }
 
-    if (msg.size != sizeof(msg.payload.state)) {
+    if (msg.hdr.size != sizeof(msg.payload.state)) {
         error_report("Received bad msg size.");
         return -1;
     }
@@ -481,10 +485,10 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     size_t fd_num = 0;
     VhostUserMsg msg = {
-        .request = request,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = request,
+        .hdr.flags = VHOST_USER_VERSION,
         .payload.u64 = file->index & VHOST_USER_VRING_IDX_MASK,
-        .size = sizeof(msg.payload.u64),
+        .hdr.size = sizeof(msg.payload.u64),
     };
 
     if (ioeventfd_enabled() && file->fd > 0) {
@@ -515,10 +519,10 @@ static int vhost_user_set_vring_call(struct vhost_dev *dev,
 static int vhost_user_set_u64(struct vhost_dev *dev, int request, uint64_t u64)
 {
     VhostUserMsg msg = {
-        .request = request,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = request,
+        .hdr.flags = VHOST_USER_VERSION,
         .payload.u64 = u64,
-        .size = sizeof(msg.payload.u64),
+        .hdr.size = sizeof(msg.payload.u64),
     };
 
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
@@ -543,8 +547,8 @@ static int vhost_user_set_protocol_features(struct vhost_dev *dev,
 static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
 {
     VhostUserMsg msg = {
-        .request = request,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = request,
+        .hdr.flags = VHOST_USER_VERSION,
     };
 
     if (vhost_user_one_time_request(request) && dev->vq_index != 0) {
@@ -559,13 +563,13 @@ static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
         return -1;
     }
 
-    if (msg.request != request) {
+    if (msg.hdr.request != request) {
         error_report("Received unexpected msg type. Expected %d received %d",
-                     request, msg.request);
+                     request, msg.hdr.request);
         return -1;
     }
 
-    if (msg.size != sizeof(msg.payload.u64)) {
+    if (msg.hdr.size != sizeof(msg.payload.u64)) {
         error_report("Received bad msg size.");
         return -1;
     }
@@ -583,8 +587,8 @@ static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *features)
 static int vhost_user_set_owner(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
-        .request = VHOST_USER_SET_OWNER,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_SET_OWNER,
+        .hdr.flags = VHOST_USER_VERSION,
     };
 
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
@@ -597,8 +601,8 @@ static int vhost_user_set_owner(struct vhost_dev *dev)
 static int vhost_user_reset_device(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
-        .request = VHOST_USER_RESET_OWNER,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_RESET_OWNER,
+        .hdr.flags = VHOST_USER_VERSION,
     };
 
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
@@ -622,21 +626,21 @@ static void slave_read(void *opaque)
         goto err;
     }
 
-    if (msg.size > VHOST_USER_PAYLOAD_SIZE) {
+    if (msg.hdr.size > VHOST_USER_PAYLOAD_SIZE) {
         error_report("Failed to read msg header."
-                " Size %d exceeds the maximum %zu.", msg.size,
+                " Size %d exceeds the maximum %zu.", msg.hdr.size,
                 VHOST_USER_PAYLOAD_SIZE);
         goto err;
     }
 
     /* Read payload */
-    size = read(u->slave_fd, &msg.payload, msg.size);
-    if (size != msg.size) {
+    size = read(u->slave_fd, &msg.payload, msg.hdr.size);
+    if (size != msg.hdr.size) {
         error_report("Failed to read payload from slave.");
         goto err;
     }
 
-    switch (msg.request) {
+    switch (msg.hdr.request) {
     case VHOST_USER_SLAVE_IOTLB_MSG:
         ret = vhost_backend_handle_iotlb_msg(dev, &msg.payload.iotlb);
         break;
@@ -649,15 +653,15 @@ static void slave_read(void *opaque)
      * REPLY_ACK feature handling. Other reply types has to be managed
      * directly in their request handlers.
      */
-    if (msg.flags & VHOST_USER_NEED_REPLY_MASK) {
-        msg.flags &= ~VHOST_USER_NEED_REPLY_MASK;
-        msg.flags |= VHOST_USER_REPLY_MASK;
+    if (msg.hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+        msg.hdr.flags &= ~VHOST_USER_NEED_REPLY_MASK;
+        msg.hdr.flags |= VHOST_USER_REPLY_MASK;
 
         msg.payload.u64 = !!ret;
-        msg.size = sizeof(msg.payload.u64);
+        msg.hdr.size = sizeof(msg.payload.u64);
 
-        size = write(u->slave_fd, &msg, VHOST_USER_HDR_SIZE + msg.size);
-        if (size != VHOST_USER_HDR_SIZE + msg.size) {
+        size = write(u->slave_fd, &msg, VHOST_USER_HDR_SIZE + msg.hdr.size);
+        if (size != VHOST_USER_HDR_SIZE + msg.hdr.size) {
             error_report("Failed to send msg reply to slave.");
             goto err;
         }
@@ -675,8 +679,8 @@ err:
 static int vhost_setup_slave_channel(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
-        .request = VHOST_USER_SET_SLAVE_REQ_FD,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_SET_SLAVE_REQ_FD,
+        .hdr.flags = VHOST_USER_VERSION,
     };
     struct vhost_user *u = dev->opaque;
     int sv[2], ret = 0;
@@ -697,7 +701,7 @@ static int vhost_setup_slave_channel(struct vhost_dev *dev)
     qemu_set_fd_handler(u->slave_fd, slave_read, NULL, dev);
 
     if (reply_supported) {
-        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
     ret = vhost_user_write(dev, &msg, &sv[1], 1);
@@ -842,10 +846,10 @@ static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
     /* if backend supports VHOST_USER_PROTOCOL_F_RARP ask it to send the RARP */
     if (virtio_has_feature(dev->protocol_features,
                            VHOST_USER_PROTOCOL_F_RARP)) {
-        msg.request = VHOST_USER_SEND_RARP;
-        msg.flags = VHOST_USER_VERSION;
+        msg.hdr.request = VHOST_USER_SEND_RARP;
+        msg.hdr.flags = VHOST_USER_VERSION;
         memcpy((char *)&msg.payload.u64, mac_addr, 6);
-        msg.size = sizeof(msg.payload.u64);
+        msg.hdr.size = sizeof(msg.payload.u64);
 
         return vhost_user_write(dev, &msg, NULL, 0);
     }
@@ -879,12 +883,12 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
         return 0;
     }
 
-    msg.request = VHOST_USER_NET_SET_MTU;
+    msg.hdr.request = VHOST_USER_NET_SET_MTU;
     msg.payload.u64 = mtu;
-    msg.size = sizeof(msg.payload.u64);
-    msg.flags = VHOST_USER_VERSION;
+    msg.hdr.size = sizeof(msg.payload.u64);
+    msg.hdr.flags = VHOST_USER_VERSION;
     if (reply_supported) {
-        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
@@ -903,9 +907,9 @@ static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
                                             struct vhost_iotlb_msg *imsg)
 {
     VhostUserMsg msg = {
-        .request = VHOST_USER_IOTLB_MSG,
-        .size = sizeof(msg.payload.iotlb),
-        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+        .hdr.request = VHOST_USER_IOTLB_MSG,
+        .hdr.size = sizeof(msg.payload.iotlb),
+        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
         .payload.iotlb = *imsg,
     };
 
-- 
MST
