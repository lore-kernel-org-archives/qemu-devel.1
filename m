Received: from eggs.gnu.org ([2001:4830:134:3::10]:53170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZCBF-0007VO-II
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZCB9-0001ea-PB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:00:49 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gZCB9-0001e8-EL
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:00:43 -0500
Received: by mail-pf1-x444.google.com with SMTP id w73so7886791pfk.10
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 02:00:43 -0800 (PST)
From: elohimes@gmail.com
Date: Tue, 18 Dec 2018 17:59:57 +0800
Message-Id: <20181218100002.11219-3-xieyongji@baidu.com>
In-Reply-To: <20181218100002.11219-1-xieyongji@baidu.com>
References: <20181218100002.11219-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v2 for-4.0 2/7] vhost-user: Support providing
 shared memory to backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, yury-kotov@yandex-team.ru, maxime.coquelin@redhat.com
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This patch introduces two new messages VHOST_USER_GET_SHM_SIZE
and VHOST_USER_SET_SHM_FD to support providing shared
memory to backend.

Firstly, qemu uses VHOST_USER_GET_SHM_SIZE to get the
required size of shared memory from backend. Then, qemu
allocates memory and sends them back to backend through
VHOST_USER_SET_SHM_FD.

Note that the shared memory should be used to record
inflight I/O by backend. Qemu will clear it when vm reset.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Chai Wen <chaiwen@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 docs/interop/vhost-user.txt       |  41 +++++++++++
 hw/virtio/vhost-user.c            |  86 ++++++++++++++++++++++
 hw/virtio/vhost.c                 | 117 ++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |   9 +++
 include/hw/virtio/vhost.h         |  19 +++++
 5 files changed, 272 insertions(+)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index c2194711d9..5ee9c28ab0 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -142,6 +142,19 @@ Depending on the request type, payload can be:
    Offset: a 64-bit offset of this area from the start of the
        supplied file descriptor
 
+ * Shm description
+   -----------------------------------
+   | mmap_size | mmap_offset | dev_size | vq_size | align | version |
+   -----------------------------------
+
+   Mmap_size: a 64-bit size of the shared memory
+   Mmap_offset: a 64-bit offset of the shared memory from the start
+                of the supplied file descriptor
+   Dev_size: a 32-bit size of device region in shared memory
+   Vq_size: a 32-bit size of each virtqueue region in shared memory
+   Align: a 32-bit align of each region in shared memory
+   Version: a 32-bit version of this shared memory
+
 In QEMU the vhost-user message is implemented with the following struct:
 
 typedef struct VhostUserMsg {
@@ -157,6 +170,7 @@ typedef struct VhostUserMsg {
         struct vhost_iotlb_msg iotlb;
         VhostUserConfig config;
         VhostUserVringArea area;
+        VhostUserShm shm;
     };
 } QEMU_PACKED VhostUserMsg;
 
@@ -175,6 +189,7 @@ the ones that do:
  * VHOST_USER_GET_PROTOCOL_FEATURES
  * VHOST_USER_GET_VRING_BASE
  * VHOST_USER_SET_LOG_BASE (if VHOST_USER_PROTOCOL_F_LOG_SHMFD)
+ * VHOST_USER_GET_SHM_SIZE (if VHOST_USER_PROTOCOL_F_SLAVE_SHMFD)
 
 [ Also see the section on REPLY_ACK protocol extension. ]
 
@@ -188,6 +203,7 @@ in the ancillary data:
  * VHOST_USER_SET_VRING_CALL
  * VHOST_USER_SET_VRING_ERR
  * VHOST_USER_SET_SLAVE_REQ_FD
+ * VHOST_USER_SET_SHM_FD (if VHOST_USER_PROTOCOL_F_SLAVE_SHMFD)
 
 If Master is unable to send the full message or receives a wrong reply it will
 close the connection. An optional reconnection mechanism can be implemented.
@@ -397,6 +413,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_CONFIG         9
 #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
 #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
+#define VHOST_USER_PROTOCOL_F_SLAVE_SHMFD 12
 
 Master message types
 --------------------
@@ -761,6 +778,30 @@ Master message types
       was previously sent.
       The value returned is an error indication; 0 is success.
 
+ * VHOST_USER_GET_SHM_SIZE
+      Id: 31
+      Equivalent ioctl: N/A
+      Master payload: shm description
+
+      When VHOST_USER_PROTOCOL_F_SLAVE_SHMFD protocol feature has been
+      successfully negotiated, master need to provide a shared memory to
+      slave. This message is used by master to get required size from slave.
+      The shared memory contains one region for device and several regions
+      for virtqueue. The size of those two kinds of regions is specified
+      by dev_size field and vq_size filed. The align field specify the alignment
+      of those regions.
+
+ * VHOST_USER_SET_SHM_FD
+      Id: 32
+      Equivalent ioctl: N/A
+      Master payload: shm description
+
+      When VHOST_USER_PROTOCOL_F_SLAVE_SHMFD protocol feature has been
+      successfully negotiated, master uses this message to set shared memory
+      for slave. The memory fd is passed in the ancillary data. The shared
+      memory should be used to record inflight I/O by slave. And master will
+      clear it when vm reset.
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e09bed0e4a..8cdf3b5121 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -52,6 +52,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CONFIG = 9,
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
+    VHOST_USER_PROTOCOL_F_SLAVE_SHMFD = 12,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -89,6 +90,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_ADVISE  = 28,
     VHOST_USER_POSTCOPY_LISTEN  = 29,
     VHOST_USER_POSTCOPY_END     = 30,
+    VHOST_USER_GET_SHM_SIZE = 31,
+    VHOST_USER_SET_SHM_FD = 32,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -147,6 +150,15 @@ typedef struct VhostUserVringArea {
     uint64_t offset;
 } VhostUserVringArea;
 
+typedef struct VhostUserShm {
+    uint64_t mmap_size;
+    uint64_t mmap_offset;
+    uint32_t dev_size;
+    uint32_t vq_size;
+    uint32_t align;
+    uint32_t version;
+} VhostUserShm;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -169,6 +181,7 @@ typedef union {
         VhostUserConfig config;
         VhostUserCryptoSession session;
         VhostUserVringArea area;
+        VhostUserShm shm;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1739,6 +1752,77 @@ static bool vhost_user_mem_section_filter(struct vhost_dev *dev,
     return result;
 }
 
+static int vhost_user_get_shm_size(struct vhost_dev *dev,
+                                   struct vhost_shm *shm)
+{
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_GET_SHM_SIZE,
+        .hdr.flags = VHOST_USER_VERSION,
+        .hdr.size = sizeof(msg.payload.shm),
+    };
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_SLAVE_SHMFD)) {
+        shm->dev_size = 0;
+        shm->vq_size = 0;
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
+    if (msg.hdr.request != VHOST_USER_GET_SHM_SIZE) {
+        error_report("Received unexpected msg type. "
+                     "Expected %d received %d",
+                     VHOST_USER_GET_SHM_SIZE, msg.hdr.request);
+        return -1;
+    }
+
+    if (msg.hdr.size != sizeof(msg.payload.shm)) {
+        error_report("Received bad msg size.");
+        return -1;
+    }
+
+    shm->dev_size = msg.payload.shm.dev_size;
+    shm->vq_size = msg.payload.shm.vq_size;
+    shm->align = msg.payload.shm.align;
+    shm->version = msg.payload.shm.version;
+
+    return 0;
+}
+
+static int vhost_user_set_shm_fd(struct vhost_dev *dev,
+                                 struct vhost_shm *shm)
+{
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_SET_SHM_FD,
+        .hdr.flags = VHOST_USER_VERSION,
+        .payload.shm.mmap_size = shm->mmap_size,
+        .payload.shm.mmap_offset = 0,
+        .payload.shm.dev_size = shm->dev_size,
+        .payload.shm.vq_size = shm->vq_size,
+        .payload.shm.align = shm->align,
+        .payload.shm.version = shm->version,
+        .hdr.size = sizeof(msg.payload.shm),
+    };
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_SLAVE_SHMFD)) {
+        return 0;
+    }
+
+    if (vhost_user_write(dev, &msg, &shm->fd, 1) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
 VhostUserState *vhost_user_init(void)
 {
     VhostUserState *user = g_new0(struct VhostUserState, 1);
@@ -1790,4 +1874,6 @@ const VhostOps user_ops = {
         .vhost_crypto_create_session = vhost_user_crypto_create_session,
         .vhost_crypto_close_session = vhost_user_crypto_close_session,
         .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
+        .vhost_get_shm_size = vhost_user_get_shm_size,
+        .vhost_set_shm_fd = vhost_user_set_shm_fd,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 569c4053ea..7a38fed50f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1481,6 +1481,123 @@ void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
     hdev->config_ops = ops;
 }
 
+void vhost_dev_reset_shm(struct vhost_shm *shm)
+{
+    if (shm->addr) {
+        memset(shm->addr, 0, shm->mmap_size);
+    }
+}
+
+void vhost_dev_free_shm(struct vhost_shm *shm)
+{
+    if (shm->addr) {
+        qemu_memfd_free(shm->addr, shm->mmap_size, shm->fd);
+        shm->addr = NULL;
+        shm->fd = -1;
+    }
+}
+
+int vhost_dev_alloc_shm(struct vhost_shm *shm)
+{
+    Error *err = NULL;
+    int fd = -1;
+    void *addr = qemu_memfd_alloc("vhost-shm", shm->mmap_size,
+                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                                  &fd, &err);
+    if (err) {
+        error_report_err(err);
+        return -1;
+    }
+
+    shm->addr = addr;
+    shm->fd = fd;
+
+    return 0;
+}
+
+void vhost_dev_save_shm(struct vhost_shm *shm, QEMUFile *f)
+{
+    if (shm->addr) {
+        qemu_put_be64(f, shm->mmap_size);
+        qemu_put_be32(f, shm->dev_size);
+        qemu_put_be32(f, shm->vq_size);
+        qemu_put_be32(f, shm->align);
+        qemu_put_be32(f, shm->version);
+        qemu_put_buffer(f, shm->addr, shm->mmap_size);
+    } else {
+        qemu_put_be64(f, 0);
+    }
+}
+
+int vhost_dev_load_shm(struct vhost_shm *shm, QEMUFile *f)
+{
+    uint64_t mmap_size;
+
+    mmap_size = qemu_get_be64(f);
+    if (!mmap_size) {
+        return 0;
+    }
+
+    vhost_dev_free_shm(shm);
+
+    shm->mmap_size = mmap_size;
+    shm->dev_size = qemu_get_be32(f);
+    shm->vq_size = qemu_get_be32(f);
+    shm->align = qemu_get_be32(f);
+    shm->version = qemu_get_be32(f);
+
+    if (vhost_dev_alloc_shm(shm)) {
+        return -ENOMEM;
+    }
+
+    qemu_get_buffer(f, shm->addr, mmap_size);
+
+    return 0;
+}
+
+int vhost_dev_set_shm(struct vhost_dev *dev, struct vhost_shm *shm)
+{
+    int r;
+
+    if (dev->vhost_ops->vhost_set_shm_fd && shm->addr) {
+        r = dev->vhost_ops->vhost_set_shm_fd(dev, shm);
+        if (r) {
+            VHOST_OPS_DEBUG("vhost_set_vring_shm_fd failed");
+            return -errno;
+        }
+    }
+
+    return 0;
+}
+
+int vhost_dev_init_shm(struct vhost_dev *dev, struct vhost_shm *shm)
+{
+    int r;
+
+    if (dev->vhost_ops->vhost_get_shm_size) {
+        r = dev->vhost_ops->vhost_get_shm_size(dev, shm);
+        if (r) {
+            VHOST_OPS_DEBUG("vhost_get_vring_shm_size failed");
+            return -errno;
+        }
+
+        if (!shm->dev_size && !shm->vq_size) {
+            return 0;
+        }
+
+        shm->mmap_size = QEMU_ALIGN_UP(shm->dev_size, shm->align) +
+                         dev->nvqs * QEMU_ALIGN_UP(shm->vq_size, shm->align);
+
+        if (vhost_dev_alloc_shm(shm)) {
+            return -ENOMEM;
+        }
+
+        vhost_dev_reset_shm(shm);
+    }
+
+    return 0;
+}
+
 /* Host notifiers must be enabled at this point. */
 int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
 {
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 81283ec50f..4e7f13c9e9 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -25,6 +25,7 @@ typedef enum VhostSetConfigType {
     VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
 } VhostSetConfigType;
 
+struct vhost_shm;
 struct vhost_dev;
 struct vhost_log;
 struct vhost_memory;
@@ -104,6 +105,12 @@ typedef int (*vhost_crypto_close_session_op)(struct vhost_dev *dev,
 typedef bool (*vhost_backend_mem_section_filter_op)(struct vhost_dev *dev,
                                                 MemoryRegionSection *section);
 
+typedef int (*vhost_get_shm_size_op)(struct vhost_dev *dev,
+                                     struct vhost_shm *shm);
+
+typedef int (*vhost_set_shm_fd_op)(struct vhost_dev *dev,
+                                   struct vhost_shm *shm);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -142,6 +149,8 @@ typedef struct VhostOps {
     vhost_crypto_create_session_op vhost_crypto_create_session;
     vhost_crypto_close_session_op vhost_crypto_close_session;
     vhost_backend_mem_section_filter_op vhost_backend_mem_section_filter;
+    vhost_get_shm_size_op vhost_get_shm_size;
+    vhost_set_shm_fd_op vhost_set_shm_fd;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a7f449fa87..b6e3d6ab56 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -7,6 +7,17 @@
 #include "exec/memory.h"
 
 /* Generic structures common for any vhost based device. */
+
+struct vhost_shm {
+    void *addr;
+    uint64_t mmap_size;
+    uint32_t dev_size;
+    uint32_t vq_size;
+    uint32_t align;
+    uint32_t version;
+    int fd;
+};
+
 struct vhost_virtqueue {
     int kick;
     int call;
@@ -120,4 +131,12 @@ int vhost_dev_set_config(struct vhost_dev *dev, const uint8_t *data,
  */
 void vhost_dev_set_config_notifier(struct vhost_dev *dev,
                                    const VhostDevConfigOps *ops);
+
+void vhost_dev_reset_shm(struct vhost_shm *shm);
+void vhost_dev_free_shm(struct vhost_shm *shm);
+int vhost_dev_alloc_shm(struct vhost_shm *shm);
+void vhost_dev_save_shm(struct vhost_shm *shm, QEMUFile *f);
+int vhost_dev_load_shm(struct vhost_shm *shm, QEMUFile *f);
+int vhost_dev_set_shm(struct vhost_dev *dev, struct vhost_shm *shm);
+int vhost_dev_init_shm(struct vhost_dev *dev, struct vhost_shm *shm);
 #endif
-- 
2.17.1
