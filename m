Received: from eggs.gnu.org ([2001:4830:134:3::10]:47321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH5F-00058I-K3
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH5D-0004zA-AV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ecH5C-0004yf-Vy
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:47 -0500
Date: Thu, 18 Jan 2018 22:46:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516308132-10272-28-git-send-email-mst@redhat.com>
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516308132-10272-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v4 27/29] vhost-user: factor out msg head and
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

split header and payload into separate structures,
to enable easier handling of alignment issues.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 198 +++++++++++++++++++++++++------------------------
 1 file changed, 101 insertions(+), 97 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8b94688..6ac3610 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -112,7 +112,7 @@ static VhostUserConfig c __attribute__ ((unused));
                                    + sizeof(c.size) \
                                    + sizeof(c.flags))
 
-typedef struct VhostUserMsg {
+typedef struct {
     VhostUserRequest request;
 
 #define VHOST_USER_VERSION_MASK     (0x3)
@@ -120,7 +120,9 @@ typedef struct VhostUserMsg {
 #define VHOST_USER_NEED_REPLY_MASK  (0x1 << 3)
     uint32_t flags;
     uint32_t size; /* the following payload size */
-    union {
+} QEMU_PACKED VhostUserHeader;
+
+typedef union {
 #define VHOST_USER_VRING_IDX_MASK   (0xff)
 #define VHOST_USER_VRING_NOFD_MASK  (0x1<<8)
         uint64_t u64;
@@ -130,15 +132,17 @@ typedef struct VhostUserMsg {
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
         VhostUserConfig config;
-    } payload;
+} VhostUserPayload;
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
@@ -163,33 +167,33 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
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
@@ -205,7 +209,7 @@ static int process_message_reply(struct vhost_dev *dev,
 {
     VhostUserMsg msg_reply;
 
-    if ((msg->flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
+    if ((msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
         return 0;
     }
 
@@ -213,10 +217,10 @@ static int process_message_reply(struct vhost_dev *dev,
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
 
@@ -243,15 +247,15 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
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
 
@@ -278,11 +282,11 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
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
@@ -294,15 +298,15 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
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
@@ -320,12 +324,12 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
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
@@ -355,9 +359,9 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
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
@@ -374,10 +378,10 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
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
@@ -393,10 +397,10 @@ static int vhost_user_set_vring_endian(struct vhost_dev *dev,
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
@@ -416,10 +420,10 @@ static int vhost_set_vring(struct vhost_dev *dev,
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
@@ -465,10 +469,10 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
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
@@ -479,13 +483,13 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
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
@@ -502,10 +506,10 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
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
@@ -536,10 +540,10 @@ static int vhost_user_set_vring_call(struct vhost_dev *dev,
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
@@ -564,8 +568,8 @@ static int vhost_user_set_protocol_features(struct vhost_dev *dev,
 static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
 {
     VhostUserMsg msg = {
-        .request = request,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = request,
+        .hdr.flags = VHOST_USER_VERSION,
     };
 
     if (vhost_user_one_time_request(request) && dev->vq_index != 0) {
@@ -580,13 +584,13 @@ static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
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
@@ -604,8 +608,8 @@ static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *features)
 static int vhost_user_set_owner(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
-        .request = VHOST_USER_SET_OWNER,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_SET_OWNER,
+        .hdr.flags = VHOST_USER_VERSION,
     };
 
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
@@ -618,8 +622,8 @@ static int vhost_user_set_owner(struct vhost_dev *dev)
 static int vhost_user_reset_device(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
-        .request = VHOST_USER_RESET_OWNER,
-        .flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_RESET_OWNER,
+        .hdr.flags = VHOST_USER_VERSION,
     };
 
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
@@ -658,21 +662,21 @@ static void slave_read(void *opaque)
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
@@ -688,15 +692,15 @@ static void slave_read(void *opaque)
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
@@ -714,8 +718,8 @@ err:
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
@@ -736,7 +740,7 @@ static int vhost_setup_slave_channel(struct vhost_dev *dev)
     qemu_set_fd_handler(u->slave_fd, slave_read, NULL, dev);
 
     if (reply_supported) {
-        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
     ret = vhost_user_write(dev, &msg, &sv[1], 1);
@@ -881,10 +885,10 @@ static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
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
@@ -918,12 +922,12 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
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
@@ -942,9 +946,9 @@ static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
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
 
@@ -965,9 +969,9 @@ static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
                                  uint32_t config_len)
 {
     VhostUserMsg msg = {
-        msg.request = VHOST_USER_GET_CONFIG,
-        msg.flags = VHOST_USER_VERSION,
-        msg.size = VHOST_USER_CONFIG_HDR_SIZE + config_len,
+        .hdr.request = VHOST_USER_GET_CONFIG,
+        .hdr.flags = VHOST_USER_VERSION,
+        .hdr.size = VHOST_USER_CONFIG_HDR_SIZE + config_len,
     };
 
     if (config_len > VHOST_USER_MAX_CONFIG_SIZE) {
@@ -984,13 +988,13 @@ static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
         return -1;
     }
 
-    if (msg.request != VHOST_USER_GET_CONFIG) {
+    if (msg.hdr.request != VHOST_USER_GET_CONFIG) {
         error_report("Received unexpected msg type. Expected %d received %d",
-                     VHOST_USER_GET_CONFIG, msg.request);
+                     VHOST_USER_GET_CONFIG, msg.hdr.request);
         return -1;
     }
 
-    if (msg.size != VHOST_USER_CONFIG_HDR_SIZE + config_len) {
+    if (msg.hdr.size != VHOST_USER_CONFIG_HDR_SIZE + config_len) {
         error_report("Received bad msg size.");
         return -1;
     }
@@ -1008,13 +1012,13 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
                                               VHOST_USER_PROTOCOL_F_REPLY_ACK);
 
     VhostUserMsg msg = {
-        msg.request = VHOST_USER_SET_CONFIG,
-        msg.flags = VHOST_USER_VERSION,
-        msg.size = VHOST_USER_CONFIG_HDR_SIZE + size,
+        .hdr.request = VHOST_USER_SET_CONFIG,
+        .hdr.flags = VHOST_USER_VERSION,
+        .hdr.size = VHOST_USER_CONFIG_HDR_SIZE + size,
     };
 
     if (reply_supported) {
-        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
     if (size > VHOST_USER_MAX_CONFIG_SIZE) {
-- 
MST
