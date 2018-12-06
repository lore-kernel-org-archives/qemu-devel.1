Received: from eggs.gnu.org ([2001:4830:134:3::10]:52805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUnHJ-0001Sr-82
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUnHB-0003Os-LM
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:51 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gUnH9-0003MD-Hw
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:45 -0500
Received: by mail-pg1-x544.google.com with SMTP id w7so10179284pgp.13
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 22:36:42 -0800 (PST)
From: elohimes@gmail.com
Date: Thu,  6 Dec 2018 14:35:48 +0800
Message-Id: <20181206063552.6701-3-xieyongji@baidu.com>
In-Reply-To: <20181206063552.6701-1-xieyongji@baidu.com>
References: <20181206063552.6701-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH for-4.0 2/6] vhost-user: Add shared memory to
 record inflight I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This introduces a new message VHOST_USER_SET_VRING_INFLIGHT
to support offering shared memory to backend to record
its inflight I/O.

With this new message, the backend is able to restart without
missing I/O which would cause I/O hung for block device.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Chai Wen <chaiwen@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 hw/virtio/vhost-user.c            | 69 +++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 |  8 ++++
 include/hw/virtio/vhost-backend.h |  4 ++
 include/hw/virtio/vhost-user.h    |  8 ++++
 4 files changed, 89 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e09bed0e4a..4c0e64891d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -19,6 +19,7 @@
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
+#include "qemu/memfd.h"
 #include "sysemu/cryptodev.h"
 #include "migration/migration.h"
 #include "migration/postcopy-ram.h"
@@ -52,6 +53,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CONFIG = 9,
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
+    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -89,6 +91,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_ADVISE  = 28,
     VHOST_USER_POSTCOPY_LISTEN  = 29,
     VHOST_USER_POSTCOPY_END     = 30,
+    VHOST_USER_SET_VRING_INFLIGHT = 31,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -147,6 +150,11 @@ typedef struct VhostUserVringArea {
     uint64_t offset;
 } VhostUserVringArea;
 
+typedef struct VhostUserVringInflight {
+    uint32_t size;
+    uint32_t idx;
+} VhostUserVringInflight;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -169,6 +177,7 @@ typedef union {
         VhostUserConfig config;
         VhostUserCryptoSession session;
         VhostUserVringArea area;
+        VhostUserVringInflight inflight;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1739,6 +1748,58 @@ static bool vhost_user_mem_section_filter(struct vhost_dev *dev,
     return result;
 }
 
+static int vhost_user_set_vring_inflight(struct vhost_dev *dev, int idx)
+{
+    struct vhost_user *u = dev->opaque;
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (!u->user->inflight[idx].addr) {
+        Error *err = NULL;
+
+        u->user->inflight[idx].size = qemu_real_host_page_size;
+        u->user->inflight[idx].addr = qemu_memfd_alloc("vhost-inflight",
+                                      u->user->inflight[idx].size,
+                                      F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                                      &u->user->inflight[idx].fd, &err);
+        if (err) {
+            error_report_err(err);
+            u->user->inflight[idx].addr = NULL;
+            return -1;
+        }
+    }
+
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_SET_VRING_INFLIGHT,
+        .hdr.flags = VHOST_USER_VERSION,
+        .payload.inflight.size = u->user->inflight[idx].size,
+        .payload.inflight.idx = idx,
+        .hdr.size = sizeof(msg.payload.inflight),
+    };
+
+    if (vhost_user_write(dev, &msg, &u->user->inflight[idx].fd, 1) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+void vhost_user_inflight_reset(VhostUserState *user)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+        if (!user->inflight[i].addr) {
+            continue;
+        }
+
+        memset(user->inflight[i].addr, 0, user->inflight[i].size);
+    }
+}
+
 VhostUserState *vhost_user_init(void)
 {
     VhostUserState *user = g_new0(struct VhostUserState, 1);
@@ -1756,6 +1817,13 @@ void vhost_user_cleanup(VhostUserState *user)
             munmap(user->notifier[i].addr, qemu_real_host_page_size);
             user->notifier[i].addr = NULL;
         }
+
+        if (user->inflight[i].addr) {
+            munmap(user->inflight[i].addr, user->inflight[i].size);
+            user->inflight[i].addr = NULL;
+            close(user->inflight[i].fd);
+            user->inflight[i].fd = -1;
+        }
     }
 }
 
@@ -1790,4 +1858,5 @@ const VhostOps user_ops = {
         .vhost_crypto_create_session = vhost_user_crypto_create_session,
         .vhost_crypto_close_session = vhost_user_crypto_close_session,
         .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
+        .vhost_set_vring_inflight = vhost_user_set_vring_inflight,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 569c4053ea..2ca7b4e841 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -973,6 +973,14 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
         return -errno;
     }
 
+    if (dev->vhost_ops->vhost_set_vring_inflight) {
+        r = dev->vhost_ops->vhost_set_vring_inflight(dev, vhost_vq_index);
+        if (r) {
+            VHOST_OPS_DEBUG("vhost_set_vring_inflight failed");
+            return -errno;
+        }
+    }
+
     state.num = virtio_queue_get_last_avail_idx(vdev, idx);
     r = dev->vhost_ops->vhost_set_vring_base(dev, &state);
     if (r) {
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 81283ec50f..8110e09089 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -104,6 +104,9 @@ typedef int (*vhost_crypto_close_session_op)(struct vhost_dev *dev,
 typedef bool (*vhost_backend_mem_section_filter_op)(struct vhost_dev *dev,
                                                 MemoryRegionSection *section);
 
+typedef int (*vhost_set_vring_inflight_op)(struct vhost_dev *dev,
+                                           int idx);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -142,6 +145,7 @@ typedef struct VhostOps {
     vhost_crypto_create_session_op vhost_crypto_create_session;
     vhost_crypto_close_session_op vhost_crypto_close_session;
     vhost_backend_mem_section_filter_op vhost_backend_mem_section_filter;
+    vhost_set_vring_inflight_op vhost_set_vring_inflight;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index fd660393a0..ff13433153 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -17,11 +17,19 @@ typedef struct VhostUserHostNotifier {
     bool set;
 } VhostUserHostNotifier;
 
+typedef struct VhostUserInflight {
+    void *addr;
+    uint32_t size;
+    int fd;
+} VhostUserInflight;
+
 typedef struct VhostUserState {
     CharBackend *chr;
     VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
+    VhostUserInflight inflight[VIRTIO_QUEUE_MAX];
 } VhostUserState;
 
+void vhost_user_inflight_reset(VhostUserState *user);
 VhostUserState *vhost_user_init(void);
 void vhost_user_cleanup(VhostUserState *user);
 
-- 
2.17.1
