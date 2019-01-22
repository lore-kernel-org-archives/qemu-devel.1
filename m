Received: from eggs.gnu.org ([209.51.188.92]:46543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1glrU4-0000ET-UM
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1glrTz-0002cv-C1
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:32:34 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1glrTy-0002bR-GY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:32:31 -0500
Received: by mail-pl1-x644.google.com with SMTP id w4so11124239plz.1
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 00:32:28 -0800 (PST)
From: elohimes@gmail.com
Date: Tue, 22 Jan 2019 16:31:47 +0800
Message-Id: <20190122083152.10705-2-xieyongji@baidu.com>
In-Reply-To: <20190122083152.10705-1-xieyongji@baidu.com>
References: <20190122083152.10705-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v5 1/6] vhost-user: Support transferring
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
Qemu should clear it when vm reset.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Chai Wen <chaiwen@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 docs/interop/vhost-user.txt       | 101 +++++++++++++++++++++++++++
 hw/virtio/vhost-user.c            | 110 ++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 | 105 ++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |  10 +++
 include/hw/virtio/vhost.h         |  19 ++++++
 5 files changed, 345 insertions(+)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index c2194711d9..fa470a8fe2 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -142,6 +142,18 @@ Depending on the request type, payload can be:
    Offset: a 64-bit offset of this area from the start of the
        supplied file descriptor
 
+ * Inflight description
+   ---------------------------------------------------------------
+   | mmap size | mmap offset | version | num queues | queue size |
+   ---------------------------------------------------------------
+
+   mmap size: a 64-bit size of area to track inflight I/O
+   mmap offset: a 64-bit offset of this area from the start
+                of the supplied file descriptor
+   version: a 16-bit version of this area
+   num queues: a 16-bit number of virtqueues
+   queue size: a 16-bit size of virtqueues
+
 In QEMU the vhost-user message is implemented with the following struct:
 
 typedef struct VhostUserMsg {
@@ -157,6 +169,7 @@ typedef struct VhostUserMsg {
         struct vhost_iotlb_msg iotlb;
         VhostUserConfig config;
         VhostUserVringArea area;
+        VhostUserInflight inflight;
     };
 } QEMU_PACKED VhostUserMsg;
 
@@ -175,6 +188,7 @@ the ones that do:
  * VHOST_USER_GET_PROTOCOL_FEATURES
  * VHOST_USER_GET_VRING_BASE
  * VHOST_USER_SET_LOG_BASE (if VHOST_USER_PROTOCOL_F_LOG_SHMFD)
+ * VHOST_USER_GET_INFLIGHT_FD (if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)
 
 [ Also see the section on REPLY_ACK protocol extension. ]
 
@@ -188,6 +202,7 @@ in the ancillary data:
  * VHOST_USER_SET_VRING_CALL
  * VHOST_USER_SET_VRING_ERR
  * VHOST_USER_SET_SLAVE_REQ_FD
+ * VHOST_USER_SET_INFLIGHT_FD (if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)
 
 If Master is unable to send the full message or receives a wrong reply it will
 close the connection. An optional reconnection mechanism can be implemented.
@@ -382,6 +397,71 @@ If VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD protocol feature is negotiated,
 slave can send file descriptors (at most 8 descriptors in each message)
 to master via ancillary data using this fd communication channel.
 
+Inflight I/O tracking
+---------------------
+
+To support reconnecting after restart or crash, slave may need to get
+and resubmit inflight I/O. If virtqueue is processed in order, we can
+easily achieve that by getting the inflight head-descriptor from avail ring.
+However, it can't work when we process descriptors out-of-order because
+some entries which store inflight head-descriptor in avail ring might be
+overrided by new entries. To solve this problem, slave need to allocate a
+buffer to track inflight head-descriptor and share it with master for
+persistent. VHOST_USER_GET_INFLIGHT_FD and VHOST_USER_SET_INFLIGHT_FD are
+used to transfer this buffer between master and slave. And the format of
+this buffer is described below:
+
+-------------------------------------------------------
+| queue0 region | queue1 region | ... | queueN region |
+-------------------------------------------------------
+
+N is the number of available virtqueues. Slave could get it from num queues
+field of VhostUserInflight.
+
+Queue region can be implemented as:
+
+typedef struct DescState {
+    uint8_t inuse;
+    uint8_t version;
+    uint16_t used_idx;
+    uint16_t avail_idx;
+    uint16_t reserved;
+} DescState;
+
+typedef struct QueueRegion {
+    uint8_t valid;
+    uint16_t desc_num;
+    DescState desc[0];
+} QueueRegion;
+
+The struct DescState is used to describe one head-descriptor's state. The
+fields have following meanings:
+
+    inuse: Indicate whether the descriptor is inuse or not.
+
+    version: Indicate whether we have an atomic update to used ring and
+    inflight buffer when slave crash at that point. This field should be
+    increased by one before and after this two updates. An odd version
+    indicates an in-progress update.
+
+    used_idx: Store old index of used ring before we update used ring and
+    inflight buffer so that slave can know whether an odd version inflight
+    head-descriptor in inflight buffer is processed or not.
+
+    avail_idx: Used to preserve the descriptor's order in avail ring so that
+    slave can resubmit descriptors in order.
+
+    reserved: Reserved for future use.
+
+An array of struct DescState is maintained to track all head-descriptors' state
+in queue region. The desc_num is the number of those head-descriptors which is
+also equal to the queue size of the virtqueue. Slave could get it from queue size
+field of VhostUserInflight. The valid field is used to specify whether the region
+is valid or not. Slave can use it to detect whether vm is reset because qemu will
+clear the buffer when the reset happens.
+
+Note that slave should align each region to cache line size.
+
 Protocol features
 -----------------
 
@@ -397,6 +477,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_CONFIG         9
 #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
 #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
+#define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
 
 Master message types
 --------------------
@@ -761,6 +842,26 @@ Master message types
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
+      inflight I/O by slave. QEMU should clear it when vm reset.
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
index 564a31d12c..9aa6204c91 100644
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
 
@@ -147,6 +150,14 @@ typedef struct VhostUserVringArea {
     uint64_t offset;
 } VhostUserVringArea;
 
+typedef struct VhostUserInflight {
+    uint64_t mmap_size;
+    uint64_t mmap_offset;
+    uint16_t version;
+    uint16_t num_queues;
+    uint16_t queue_size;
+} VhostUserInflight;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -169,6 +180,7 @@ typedef union {
         VhostUserConfig config;
         VhostUserCryptoSession session;
         VhostUserVringArea area;
+        VhostUserInflight inflight;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1739,6 +1751,102 @@ static bool vhost_user_mem_section_filter(struct vhost_dev *dev,
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
+    inflight->version = msg.payload.inflight.version;
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
+        .payload.inflight.version = inflight->version,
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
@@ -1790,4 +1898,6 @@ const VhostOps user_ops = {
         .vhost_crypto_create_session = vhost_user_crypto_create_session,
         .vhost_crypto_close_session = vhost_user_crypto_close_session,
         .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
+        .vhost_get_inflight_fd = vhost_user_get_inflight_fd,
+        .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 569c4053ea..0a4de6b91b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1481,6 +1481,111 @@ void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
     hdev->config_ops = ops;
 }
 
+void vhost_dev_reset_inflight(struct vhost_inflight *inflight)
+{
+    if (inflight->addr) {
+        memset(inflight->addr, 0, inflight->size);
+    }
+}
+
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
+        qemu_put_be16(f, inflight->version);
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
+    inflight->version = qemu_get_be16(f);
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
index a7f449fa87..f44f93f54a 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -7,6 +7,16 @@
 #include "exec/memory.h"
 
 /* Generic structures common for any vhost based device. */
+
+struct vhost_inflight {
+    int fd;
+    void *addr;
+    uint64_t size;
+    uint64_t offset;
+    uint16_t version;
+    uint16_t queue_size;
+};
+
 struct vhost_virtqueue {
     int kick;
     int call;
@@ -120,4 +130,13 @@ int vhost_dev_set_config(struct vhost_dev *dev, const uint8_t *data,
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
