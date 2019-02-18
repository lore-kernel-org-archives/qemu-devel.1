Received: from eggs.gnu.org ([209.51.188.92]:43303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gvgAB-0008WS-Cy
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gvgA4-0006Ao-CO
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:28:37 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gvg9q-00061E-RT
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:28:23 -0500
Received: by mail-pl1-x643.google.com with SMTP id q3so1215614pll.4
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 02:28:16 -0800 (PST)
From: elohimes@gmail.com
Date: Mon, 18 Feb 2019 18:27:42 +0800
Message-Id: <20190218102748.2242-2-xieyongji@baidu.com>
In-Reply-To: <20190218102748.2242-1-xieyongji@baidu.com>
References: <20190218102748.2242-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v6 1/7] vhost-user: Support transferring
 inflight buffer between qemu and backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, stefanha@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This patch introduces two new messages VHOST_USER_GET_INFLIGHT_FD
and VHOST_USER_SET_INFLIGHT_FD to support transferring a shared
buffer between qemu and backend.

Firstly, qemu uses VHOST_USER_GET_INFLIGHT_FD to get the
shared buffer from backend. Then qemu should send it back
through VHOST_USER_SET_INFLIGHT_FD each time we start vhost-user.

This shared buffer is used to track inflight I/O by backend.
Qemu should retrieve a new one when vm reset.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Chai Wen <chaiwen@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 docs/interop/vhost-user.txt       | 264 ++++++++++++++++++++++++++++++
 hw/virtio/vhost-user.c            | 107 ++++++++++++
 hw/virtio/vhost.c                 |  96 +++++++++++
 include/hw/virtio/vhost-backend.h |  10 ++
 include/hw/virtio/vhost.h         |  18 ++
 5 files changed, 495 insertions(+)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index c2194711d9..61c6d0e415 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -142,6 +142,17 @@ Depending on the request type, payload can be:
    Offset: a 64-bit offset of this area from the start of the
        supplied file descriptor
 
+ * Inflight description
+   -----------------------------------------------------
+   | mmap size | mmap offset | num queues | queue size |
+   -----------------------------------------------------
+
+   mmap size: a 64-bit size of area to track inflight I/O
+   mmap offset: a 64-bit offset of this area from the start
+                of the supplied file descriptor
+   num queues: a 16-bit number of virtqueues
+   queue size: a 16-bit size of virtqueues
+
 In QEMU the vhost-user message is implemented with the following struct:
 
 typedef struct VhostUserMsg {
@@ -157,6 +168,7 @@ typedef struct VhostUserMsg {
         struct vhost_iotlb_msg iotlb;
         VhostUserConfig config;
         VhostUserVringArea area;
+        VhostUserInflight inflight;
     };
 } QEMU_PACKED VhostUserMsg;
 
@@ -175,6 +187,7 @@ the ones that do:
  * VHOST_USER_GET_PROTOCOL_FEATURES
  * VHOST_USER_GET_VRING_BASE
  * VHOST_USER_SET_LOG_BASE (if VHOST_USER_PROTOCOL_F_LOG_SHMFD)
+ * VHOST_USER_GET_INFLIGHT_FD (if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)
 
 [ Also see the section on REPLY_ACK protocol extension. ]
 
@@ -188,6 +201,7 @@ in the ancillary data:
  * VHOST_USER_SET_VRING_CALL
  * VHOST_USER_SET_VRING_ERR
  * VHOST_USER_SET_SLAVE_REQ_FD
+ * VHOST_USER_SET_INFLIGHT_FD (if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)
 
 If Master is unable to send the full message or receives a wrong reply it will
 close the connection. An optional reconnection mechanism can be implemented.
@@ -382,6 +396,235 @@ If VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD protocol feature is negotiated,
 slave can send file descriptors (at most 8 descriptors in each message)
 to master via ancillary data using this fd communication channel.
 
+Inflight I/O tracking
+---------------------
+
+To support reconnecting after restart or crash, slave may need to resubmit
+inflight I/Os. If virtqueue is processed in order, we can easily achieve
+that by getting the inflight descriptors from descriptor table (split virtqueue)
+or descriptor ring (packed virtqueue). However, it can't work when we process
+descriptors out-of-order because some entries which store the information of
+inflight descriptors in available ring (split virtqueue) or descriptor
+ring (packed virtqueue) might be overrided by new entries. To solve this
+problem, slave need to allocate an extra buffer to store this information of inflight
+descriptors and share it with master for persistent. VHOST_USER_GET_INFLIGHT_FD and
+VHOST_USER_SET_INFLIGHT_FD are used to transfer this buffer between master
+and slave. And the format of this buffer is described below:
+
+-------------------------------------------------------
+| queue0 region | queue1 region | ... | queueN region |
+-------------------------------------------------------
+
+N is the number of available virtqueues. Slave could get it from num queues
+field of VhostUserInflight.
+
+For split virtqueue, queue region can be implemented as:
+
+typedef struct DescStateSplit {
+    /* Indicate whether this descriptor is inflight or not.
+     * Only available for head-descriptor. */
+    uint8_t inflight;
+
+    /* Padding */
+    uint8_t padding;
+
+    /* Link to the last processed entry */
+    uint16_t next;
+} DescStateSplit;
+
+typedef struct QueueRegionSplit {
+    /* The feature flags of this region. Now it's initialized to 0. */
+    uint64_t features;
+
+    /* The version of this region. It's 1 currently.
+     * Zero value indicates an uninitialized buffer */
+    uint16_t version;
+
+    /* The size of DescStateSplit array. It's equal to the virtqueue
+     * size. Slave could get it from queue size field of VhostUserInflight. */
+    uint16_t desc_num;
+
+    /* The head of processed DescStateSplit entry list */
+    uint16_t process_head;
+
+    /* Storing the idx value of used ring */
+    uint16_t used_idx;
+
+    /* Used to track the state of each descriptor in descriptor table */
+    DescStateSplit desc[0];
+} QueueRegionSplit;
+
+To track inflight I/O, the queue region should be processed as follows:
+
+When receiving available buffers from the driver:
+
+    1. Get the next available head-descriptor index from available ring, i
+
+    2. Set desc[i].inflight to 1
+
+When supplying used buffers to the driver:
+
+    1. Get corresponding used head-descriptor index, i
+
+    2. Set desc[i].next to process_head
+
+    3. Set process_head to i
+
+    4. Steps 1,2,3 may be performed repeatedly if batching is possible
+
+    5. Increase the idx value of used ring by the size of the batch
+
+    6. Set the inflight field of each DescStateSplit entry in the batch to 0
+
+    7. Set used_idx to the idx value of used ring
+
+When reconnecting:
+
+    1. If the value of used_idx does not match the idx value of used ring,
+
+        (a) Subtract the value of used_idx from the idx value of used ring to get
+        the number of in-progress DescStateSplit entries
+
+        (b) Set the inflight field of the in-progress DescStateSplit entries which
+        start from process_head to 0
+
+        (c) Set used_idx to the idx value of used ring
+
+    2. Resubmit each inflight DescStateSplit entry
+
+For packed virtqueue, queue region can be implemented as:
+
+typedef struct DescStatePacked {
+    /* Indicate whether this descriptor is inflight or not.
+     * Only available for head-descriptor. */
+    uint8_t inflight;
+
+    /* Padding */
+    uint8_t padding;
+
+    /* Link to the next free entry */
+    uint16_t next;
+
+    /* Link to the last entry of descriptor list.
+     * Only available for head-descriptor. */
+    uint16_t last;
+
+    /* The length of descriptor list.
+     * Only available for head-descriptor. */
+    uint16_t num;
+
+    /* The buffer id */
+    uint16_t id;
+
+    /* The descriptor flags */
+    uint16_t flags;
+
+    /* The buffer length */
+    uint32_t len;
+
+    /* The buffer address */
+    uint64_t addr;
+} DescStatePacked;
+
+typedef struct QueueRegionPacked {
+    /* The feature flags of this region. Now it's initialized to 0. */
+    uint64_t features;
+
+    /* The version of this region. It's 1 currently.
+     * Zero value indicates an uninitialized buffer */
+    uint16_t version;
+
+    /* The size of DescStatePacked array. It's equal to the virtqueue
+     * size. Slave could get it from queue size field of VhostUserInflight. */
+    uint16_t desc_num;
+
+    /* The head of free DescStatePacked entry list */
+    uint16_t free_head;
+
+    /* The old head of free DescStatePacked entry list */
+    uint16_t old_free_head;
+
+    /* The used index of descriptor ring */
+    uint16_t used_idx;
+
+    /* The old used index of descriptor ring */
+    uint16_t old_used_idx;
+
+    /* Device ring wrap counter */
+    uint8_t used_wrap_counter;
+
+    /* The old device ring wrap counter */
+    uint8_t old_used_wrap_counter;
+
+    /* Padding */
+    uint8_t padding[7];
+
+    /* Used to track the state of each descriptor fetched from descriptor ring */
+    DescStatePacked desc[0];
+} QueueRegionPacked;
+
+To track inflight I/O, the queue region should be processed as follows:
+
+When receiving available buffers from the driver:
+
+    1. Get the next available descriptor entry from descriptor ring, d
+
+    2. If d is head descriptor,
+
+        (a) Set desc[old_free_head].num to 0
+
+        (b) Set desc[old_free_head].inflight to 1
+
+    3. If d is last descriptor, set desc[old_free_head].last to free_head
+
+    4. Increase desc[old_free_head].num by 1
+
+    5. Set desc[free_head].addr, desc[free_head].len, desc[free_head].flags,
+    desc[free_head].id to d.addr, d.len, d.flags, d.id
+
+    6. Set free_head to desc[free_head].next
+
+    7. If d is last descriptor, set old_free_head to free_head
+
+When supplying used buffers to the driver:
+
+    1. Get corresponding used head-descriptor entry from descriptor ring, d
+
+    2. Get corresponding DescStatePacked entry, e
+
+    3. Set desc[e.last].next to free_head
+
+    4. Set free_head to the index of e
+
+    5. Steps 1,2,3,4 may be performed repeatedly if batching is possible
+
+    6. Increase used_idx by the size of the batch and update used_wrap_counter if needed
+
+    7. Update d.flags
+
+    8. Set the inflight field of each head DescStatePacked entry in the batch to 0
+
+    9. Set old_free_head, old_used_idx, old_used_wrap_counter to free_head, used_idx,
+    used_wrap_counter
+
+When reconnecting:
+
+    1. If used_idx does not match old_used_idx,
+
+        (a) Get the next descriptor ring entry through old_used_idx, d
+
+        (b) Use old_used_wrap_counter to calculate the available flags
+
+        (c) If d.flags is not equal to the calculated flags value, set old_free_head,
+        old_used_idx, old_used_wrap_counter to free_head, used_idx, used_wrap_counter
+
+    2. Set free_head, used_idx, used_wrap_counter to old_free_head, old_used_idx,
+    old_used_wrap_counter
+
+    3. Set the inflight field of each free DescStatePacked entry to 0
+
+    4. Resubmit each inflight DescStatePacked entry
+
 Protocol features
 -----------------
 
@@ -397,6 +640,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_CONFIG         9
 #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
 #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
+#define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
 
 Master message types
 --------------------
@@ -761,6 +1005,26 @@ Master message types
       was previously sent.
       The value returned is an error indication; 0 is success.
 
+ * VHOST_USER_GET_INFLIGHT_FD
+      Id: 31
+      Equivalent ioctl: N/A
+      Master payload: inflight description
+
+      When VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD protocol feature has been
+      successfully negotiated, this message is submitted by master to get
+      a shared buffer from slave. The shared buffer will be used to track
+      inflight I/O by slave. QEMU should retrieve a new one when vm reset.
+
+ * VHOST_USER_SET_INFLIGHT_FD
+      Id: 32
+      Equivalent ioctl: N/A
+      Master payload: inflight description
+
+      When VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD protocol feature has been
+      successfully negotiated, this message is submitted by master to send
+      the shared inflight buffer back to slave so that slave could get
+      inflight I/O after a crash or restart.
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 564a31d12c..21a81998ba 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -52,6 +52,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CONFIG = 9,
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
+    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -89,6 +90,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_ADVISE  = 28,
     VHOST_USER_POSTCOPY_LISTEN  = 29,
     VHOST_USER_POSTCOPY_END     = 30,
+    VHOST_USER_GET_INFLIGHT_FD = 31,
+    VHOST_USER_SET_INFLIGHT_FD = 32,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -147,6 +150,13 @@ typedef struct VhostUserVringArea {
     uint64_t offset;
 } VhostUserVringArea;
 
+typedef struct VhostUserInflight {
+    uint64_t mmap_size;
+    uint64_t mmap_offset;
+    uint16_t num_queues;
+    uint16_t queue_size;
+} VhostUserInflight;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -169,6 +179,7 @@ typedef union {
         VhostUserConfig config;
         VhostUserCryptoSession session;
         VhostUserVringArea area;
+        VhostUserInflight inflight;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1739,6 +1750,100 @@ static bool vhost_user_mem_section_filter(struct vhost_dev *dev,
     return result;
 }
 
+static int vhost_user_get_inflight_fd(struct vhost_dev *dev,
+                                      uint16_t queue_size,
+                                      struct vhost_inflight *inflight)
+{
+    void *addr;
+    int fd;
+    struct vhost_user *u = dev->opaque;
+    CharBackend *chr = u->user->chr;
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_GET_INFLIGHT_FD,
+        .hdr.flags = VHOST_USER_VERSION,
+        .payload.inflight.num_queues = dev->nvqs,
+        .payload.inflight.queue_size = queue_size,
+        .hdr.size = sizeof(msg.payload.inflight),
+    };
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    if (vhost_user_read(dev, &msg) < 0) {
+        return -1;
+    }
+
+    if (msg.hdr.request != VHOST_USER_GET_INFLIGHT_FD) {
+        error_report("Received unexpected msg type. "
+                     "Expected %d received %d",
+                     VHOST_USER_GET_INFLIGHT_FD, msg.hdr.request);
+        return -1;
+    }
+
+    if (msg.hdr.size != sizeof(msg.payload.inflight)) {
+        error_report("Received bad msg size.");
+        return -1;
+    }
+
+    if (!msg.payload.inflight.mmap_size) {
+        return 0;
+    }
+
+    fd = qemu_chr_fe_get_msgfd(chr);
+    if (fd < 0) {
+        error_report("Failed to get mem fd");
+        return -1;
+    }
+
+    addr = mmap(0, msg.payload.inflight.mmap_size, PROT_READ | PROT_WRITE,
+                MAP_SHARED, fd, msg.payload.inflight.mmap_offset);
+
+    if (addr == MAP_FAILED) {
+        error_report("Failed to mmap mem fd");
+        close(fd);
+        return -1;
+    }
+
+    inflight->addr = addr;
+    inflight->fd = fd;
+    inflight->size = msg.payload.inflight.mmap_size;
+    inflight->offset = msg.payload.inflight.mmap_offset;
+    inflight->queue_size = queue_size;
+
+    return 0;
+}
+
+static int vhost_user_set_inflight_fd(struct vhost_dev *dev,
+                                      struct vhost_inflight *inflight)
+{
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_SET_INFLIGHT_FD,
+        .hdr.flags = VHOST_USER_VERSION,
+        .payload.inflight.mmap_size = inflight->size,
+        .payload.inflight.mmap_offset = inflight->offset,
+        .payload.inflight.num_queues = dev->nvqs,
+        .payload.inflight.queue_size = inflight->queue_size,
+        .hdr.size = sizeof(msg.payload.inflight),
+    };
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (vhost_user_write(dev, &msg, &inflight->fd, 1) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
 VhostUserState *vhost_user_init(void)
 {
     VhostUserState *user = g_new0(struct VhostUserState, 1);
@@ -1790,4 +1895,6 @@ const VhostOps user_ops = {
         .vhost_crypto_create_session = vhost_user_crypto_create_session,
         .vhost_crypto_close_session = vhost_user_crypto_close_session,
         .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
+        .vhost_get_inflight_fd = vhost_user_get_inflight_fd,
+        .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 569c4053ea..8db1a855eb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1481,6 +1481,102 @@ void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
     hdev->config_ops = ops;
 }
 
+void vhost_dev_free_inflight(struct vhost_inflight *inflight)
+{
+    if (inflight->addr) {
+        qemu_memfd_free(inflight->addr, inflight->size, inflight->fd);
+        inflight->addr = NULL;
+        inflight->fd = -1;
+    }
+}
+
+static int vhost_dev_resize_inflight(struct vhost_inflight *inflight,
+                                     uint64_t new_size)
+{
+    Error *err = NULL;
+    int fd = -1;
+    void *addr = qemu_memfd_alloc("vhost-inflight", new_size,
+                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                                  &fd, &err);
+
+    if (err) {
+        error_report_err(err);
+        return -1;
+    }
+
+    vhost_dev_free_inflight(inflight);
+    inflight->offset = 0;
+    inflight->addr = addr;
+    inflight->fd = fd;
+    inflight->size = new_size;
+
+    return 0;
+}
+
+void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f)
+{
+    if (inflight->addr) {
+        qemu_put_be64(f, inflight->size);
+        qemu_put_be16(f, inflight->queue_size);
+        qemu_put_buffer(f, inflight->addr, inflight->size);
+    } else {
+        qemu_put_be64(f, 0);
+    }
+}
+
+int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
+{
+    uint64_t size;
+
+    size = qemu_get_be64(f);
+    if (!size) {
+        return 0;
+    }
+
+    if (inflight->size != size) {
+        if (vhost_dev_resize_inflight(inflight, size)) {
+            return -1;
+        }
+    }
+    inflight->queue_size = qemu_get_be16(f);
+
+    qemu_get_buffer(f, inflight->addr, size);
+
+    return 0;
+}
+
+int vhost_dev_set_inflight(struct vhost_dev *dev,
+                           struct vhost_inflight *inflight)
+{
+    int r;
+
+    if (dev->vhost_ops->vhost_set_inflight_fd && inflight->addr) {
+        r = dev->vhost_ops->vhost_set_inflight_fd(dev, inflight);
+        if (r) {
+            VHOST_OPS_DEBUG("vhost_set_inflight_fd failed");
+            return -errno;
+        }
+    }
+
+    return 0;
+}
+
+int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
+                           struct vhost_inflight *inflight)
+{
+    int r;
+
+    if (dev->vhost_ops->vhost_get_inflight_fd) {
+        r = dev->vhost_ops->vhost_get_inflight_fd(dev, queue_size, inflight);
+        if (r) {
+            VHOST_OPS_DEBUG("vhost_get_inflight_fd failed");
+            return -errno;
+        }
+    }
+
+    return 0;
+}
+
 /* Host notifiers must be enabled at this point. */
 int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
 {
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 81283ec50f..d6632a18e6 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -25,6 +25,7 @@ typedef enum VhostSetConfigType {
     VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
 } VhostSetConfigType;
 
+struct vhost_inflight;
 struct vhost_dev;
 struct vhost_log;
 struct vhost_memory;
@@ -104,6 +105,13 @@ typedef int (*vhost_crypto_close_session_op)(struct vhost_dev *dev,
 typedef bool (*vhost_backend_mem_section_filter_op)(struct vhost_dev *dev,
                                                 MemoryRegionSection *section);
 
+typedef int (*vhost_get_inflight_fd_op)(struct vhost_dev *dev,
+                                        uint16_t queue_size,
+                                        struct vhost_inflight *inflight);
+
+typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
+                                        struct vhost_inflight *inflight);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -142,6 +150,8 @@ typedef struct VhostOps {
     vhost_crypto_create_session_op vhost_crypto_create_session;
     vhost_crypto_close_session_op vhost_crypto_close_session;
     vhost_backend_mem_section_filter_op vhost_backend_mem_section_filter;
+    vhost_get_inflight_fd_op vhost_get_inflight_fd;
+    vhost_set_inflight_fd_op vhost_set_inflight_fd;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a7f449fa87..619498c8f4 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -7,6 +7,15 @@
 #include "exec/memory.h"
 
 /* Generic structures common for any vhost based device. */
+
+struct vhost_inflight {
+    int fd;
+    void *addr;
+    uint64_t size;
+    uint64_t offset;
+    uint16_t queue_size;
+};
+
 struct vhost_virtqueue {
     int kick;
     int call;
@@ -120,4 +129,13 @@ int vhost_dev_set_config(struct vhost_dev *dev, const uint8_t *data,
  */
 void vhost_dev_set_config_notifier(struct vhost_dev *dev,
                                    const VhostDevConfigOps *ops);
+
+void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
+void vhost_dev_free_inflight(struct vhost_inflight *inflight);
+void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
+int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
+int vhost_dev_set_inflight(struct vhost_dev *dev,
+                           struct vhost_inflight *inflight);
+int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
+                           struct vhost_inflight *inflight);
 #endif
-- 
2.17.1
