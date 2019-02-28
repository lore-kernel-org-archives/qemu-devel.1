Received: from eggs.gnu.org ([209.51.188.92]:37567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gzHT9-0000XM-Dx
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gzHT7-0004O5-3k
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:55:07 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gzHT3-0004JW-By
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:55:03 -0500
Received: by mail-pl1-x643.google.com with SMTP id bj4so9422328plb.7
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 00:54:54 -0800 (PST)
From: elohimes@gmail.com
Date: Thu, 28 Feb 2019 16:53:52 +0800
Message-Id: <20190228085355.9614-5-xieyongji@baidu.com>
In-Reply-To: <20190228085355.9614-1-xieyongji@baidu.com>
References: <20190228085355.9614-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v7 4/7] libvhost-user: Support tracking
 inflight I/O in shared memory
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

This patch adds support for VHOST_USER_GET_INFLIGHT_FD and
VHOST_USER_SET_INFLIGHT_FD message to set/get shared buffer
to/from qemu. Then backend can track inflight I/O in this buffer.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 Makefile                              |   2 +-
 contrib/libvhost-user/libvhost-user.c | 349 ++++++++++++++++++++++++--
 contrib/libvhost-user/libvhost-user.h |  70 ++++++
 3 files changed, 400 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index 7fa04e0821..3cf34bf8b3 100644
--- a/Makefile
+++ b/Makefile
@@ -479,7 +479,7 @@ Makefile: $(version-obj-y)
 # Build libraries
 
 libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
-libvhost-user.a: $(libvhost-user-obj-y)
+libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
 
 ######################################################################
 
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index ea0f414b6d..065ab60924 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -41,6 +41,8 @@
 #endif
 
 #include "qemu/atomic.h"
+#include "qemu/osdep.h"
+#include "qemu/memfd.h"
 
 #include "libvhost-user.h"
 
@@ -53,6 +55,18 @@
             _min1 < _min2 ? _min1 : _min2; })
 #endif
 
+/* Round number down to multiple */
+#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
+
+/* Round number up to multiple */
+#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
+
+/* Align each region to cache line size in inflight buffer */
+#define INFLIGHT_ALIGNMENT 64
+
+/* The version of inflight buffer */
+#define INFLIGHT_VERSION 1
+
 #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
 
 /* The version of the protocol we support */
@@ -66,6 +80,20 @@
         }                                       \
     } while (0)
 
+static inline
+bool has_feature(uint64_t features, unsigned int fbit)
+{
+    assert(fbit < 64);
+    return !!(features & (1ULL << fbit));
+}
+
+static inline
+bool vu_has_feature(VuDev *dev,
+                    unsigned int fbit)
+{
+    return has_feature(dev->features, fbit);
+}
+
 static const char *
 vu_request_to_string(unsigned int req)
 {
@@ -100,6 +128,8 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_POSTCOPY_ADVISE),
         REQ(VHOST_USER_POSTCOPY_LISTEN),
         REQ(VHOST_USER_POSTCOPY_END),
+        REQ(VHOST_USER_GET_INFLIGHT_FD),
+        REQ(VHOST_USER_SET_INFLIGHT_FD),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -890,6 +920,91 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
     return true;
 }
 
+static int
+inflight_desc_compare(const void *a, const void *b)
+{
+    VuVirtqInflightDesc *desc0 = (VuVirtqInflightDesc *)a,
+                        *desc1 = (VuVirtqInflightDesc *)b;
+
+    if (desc1->counter > desc0->counter &&
+        (desc1->counter - desc0->counter) < VIRTQUEUE_MAX_SIZE * 2) {
+        return 1;
+    }
+
+    return -1;
+}
+
+static int
+vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
+{
+    int i = 0;
+
+    if (!has_feature(dev->protocol_features,
+        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight)) {
+        return -1;
+    }
+
+    if (unlikely(!vq->inflight->version)) {
+        /* initialize the buffer */
+        vq->inflight->version = INFLIGHT_VERSION;
+        return 0;
+    }
+
+    vq->used_idx = vq->vring.used->idx;
+    vq->resubmit_num = 0;
+    vq->resubmit_list = NULL;
+    vq->counter = 0;
+
+    if (unlikely(vq->inflight->used_idx != vq->used_idx)) {
+        vq->inflight->desc[vq->inflight->last_batch_head].inflight = 0;
+
+        barrier();
+
+        vq->inflight->used_idx = vq->used_idx;
+    }
+
+    for (i = 0; i < vq->inflight->desc_num; i++) {
+        if (vq->inflight->desc[i].inflight == 1) {
+            vq->inuse++;
+        }
+    }
+
+    vq->shadow_avail_idx = vq->last_avail_idx = vq->inuse + vq->used_idx;
+
+    if (vq->inuse) {
+        vq->resubmit_list = malloc(sizeof(VuVirtqInflightDesc) * vq->inuse);
+        if (!vq->resubmit_list) {
+            return -1;
+        }
+
+        for (i = 0; i < vq->inflight->desc_num; i++) {
+            if (vq->inflight->desc[i].inflight) {
+                vq->resubmit_list[vq->resubmit_num].index = i;
+                vq->resubmit_list[vq->resubmit_num].counter =
+                                        vq->inflight->desc[i].counter;
+                vq->resubmit_num++;
+            }
+        }
+
+        if (vq->resubmit_num > 1) {
+            qsort(vq->resubmit_list, vq->resubmit_num,
+                  sizeof(VuVirtqInflightDesc), inflight_desc_compare);
+        }
+        vq->counter = vq->resubmit_list[0].counter + 1;
+    }
+
+    /* in case of I/O hang after reconnecting */
+    if (eventfd_write(vq->kick_fd, 1)) {
+        return -1;
+    }
+
+    return 0;
+}
+
 static bool
 vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -923,6 +1038,10 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
                dev->vq[index].kick_fd, index);
     }
 
+    if (vu_check_queue_inflights(dev, &dev->vq[index])) {
+        vu_panic(dev, "Failed to check inflights for vq: %d\n", index);
+    }
+
     return false;
 }
 
@@ -995,6 +1114,11 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     dev->vq[index].call_fd = vmsg->fds[0];
 
+    /* in case of I/O hang after reconnecting */
+    if (eventfd_write(vmsg->fds[0], 1)) {
+        return -1;
+    }
+
     DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
 
     return false;
@@ -1209,6 +1333,116 @@ vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg)
     return true;
 }
 
+static inline uint64_t
+vu_inflight_queue_size(uint16_t queue_size)
+{
+    return ALIGN_UP(sizeof(VuDescStateSplit) * queue_size +
+           sizeof(uint16_t), INFLIGHT_ALIGNMENT);
+}
+
+static bool
+vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int fd;
+    void *addr;
+    uint64_t mmap_size;
+    uint16_t num_queues, queue_size;
+
+    if (vmsg->size != sizeof(vmsg->payload.inflight)) {
+        vu_panic(dev, "Invalid get_inflight_fd message:%d", vmsg->size);
+        vmsg->payload.inflight.mmap_size = 0;
+        return true;
+    }
+
+    num_queues = vmsg->payload.inflight.num_queues;
+    queue_size = vmsg->payload.inflight.queue_size;
+
+    DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
+    DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
+
+    mmap_size = vu_inflight_queue_size(queue_size) * num_queues;
+
+    addr = qemu_memfd_alloc("vhost-inflight", mmap_size,
+                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                            &fd, NULL);
+
+    if (!addr) {
+        vu_panic(dev, "Failed to alloc vhost inflight area");
+        vmsg->payload.inflight.mmap_size = 0;
+        return true;
+    }
+
+    memset(addr, 0, mmap_size);
+
+    dev->inflight_info.addr = addr;
+    dev->inflight_info.size = vmsg->payload.inflight.mmap_size = mmap_size;
+    dev->inflight_info.fd = vmsg->fds[0] = fd;
+    vmsg->fd_num = 1;
+    vmsg->payload.inflight.mmap_offset = 0;
+
+    DPRINT("send inflight mmap_size: %"PRId64"\n",
+           vmsg->payload.inflight.mmap_size);
+    DPRINT("send inflight mmap offset: %"PRId64"\n",
+           vmsg->payload.inflight.mmap_offset);
+
+    return true;
+}
+
+static bool
+vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int fd, i;
+    uint64_t mmap_size, mmap_offset;
+    uint16_t num_queues, queue_size;
+    void *rc;
+
+    if (vmsg->fd_num != 1 ||
+        vmsg->size != sizeof(vmsg->payload.inflight)) {
+        vu_panic(dev, "Invalid set_inflight_fd message size:%d fds:%d",
+                 vmsg->size, vmsg->fd_num);
+        return false;
+    }
+
+    fd = vmsg->fds[0];
+    mmap_size = vmsg->payload.inflight.mmap_size;
+    mmap_offset = vmsg->payload.inflight.mmap_offset;
+    num_queues = vmsg->payload.inflight.num_queues;
+    queue_size = vmsg->payload.inflight.queue_size;
+
+    DPRINT("set_inflight_fd mmap_size: %"PRId64"\n", mmap_size);
+    DPRINT("set_inflight_fd mmap_offset: %"PRId64"\n", mmap_offset);
+    DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
+    DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
+
+    rc = mmap(0, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+              fd, mmap_offset);
+
+    if (rc == MAP_FAILED) {
+        vu_panic(dev, "set_inflight_fd mmap error: %s", strerror(errno));
+        return false;
+    }
+
+    if (dev->inflight_info.fd) {
+        close(dev->inflight_info.fd);
+    }
+
+    if (dev->inflight_info.addr) {
+        munmap(dev->inflight_info.addr, dev->inflight_info.size);
+    }
+
+    dev->inflight_info.fd = fd;
+    dev->inflight_info.addr = rc;
+    dev->inflight_info.size = mmap_size;
+
+    for (i = 0; i < num_queues; i++) {
+        dev->vq[i].inflight = (VuVirtqInflight *)rc;
+        dev->vq[i].inflight->desc_num = queue_size;
+        rc = (void *)((char *)rc + vu_inflight_queue_size(queue_size));
+    }
+
+    return false;
+}
+
 static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1286,6 +1520,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_postcopy_listen(dev, vmsg);
     case VHOST_USER_POSTCOPY_END:
         return vu_set_postcopy_end(dev, vmsg);
+    case VHOST_USER_GET_INFLIGHT_FD:
+        return vu_get_inflight_fd(dev, vmsg);
+    case VHOST_USER_SET_INFLIGHT_FD:
+        return vu_set_inflight_fd(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
@@ -1353,8 +1591,24 @@ vu_deinit(VuDev *dev)
             close(vq->err_fd);
             vq->err_fd = -1;
         }
+
+        if (vq->resubmit_list) {
+            free(vq->resubmit_list);
+            vq->resubmit_list = NULL;
+        }
+
+        vq->inflight = NULL;
+    }
+
+    if (dev->inflight_info.addr) {
+        munmap(dev->inflight_info.addr, dev->inflight_info.size);
+        dev->inflight_info.addr = NULL;
     }
 
+    if (dev->inflight_info.fd > 0) {
+        close(dev->inflight_info.fd);
+        dev->inflight_info.fd = -1;
+    }
 
     vu_close_log(dev);
     if (dev->slave_fd != -1) {
@@ -1681,20 +1935,6 @@ vu_queue_empty(VuDev *dev, VuVirtq *vq)
     return vring_avail_idx(vq) == vq->last_avail_idx;
 }
 
-static inline
-bool has_feature(uint64_t features, unsigned int fbit)
-{
-    assert(fbit < 64);
-    return !!(features & (1ULL << fbit));
-}
-
-static inline
-bool vu_has_feature(VuDev *dev,
-                    unsigned int fbit)
-{
-    return has_feature(dev->features, fbit);
-}
-
 static bool
 vring_notify(VuDev *dev, VuVirtq *vq)
 {
@@ -1823,12 +2063,6 @@ virtqueue_map_desc(VuDev *dev,
     *p_num_sg = num_sg;
 }
 
-/* Round number down to multiple */
-#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
-
-/* Round number up to multiple */
-#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
-
 static void *
 virtqueue_alloc_element(size_t sz,
                                      unsigned out_num, unsigned in_num)
@@ -1929,9 +2163,68 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
     return elem;
 }
 
+static int
+vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
+{
+    if (!has_feature(dev->protocol_features,
+        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight)) {
+        return -1;
+    }
+
+    vq->inflight->desc[desc_idx].counter = vq->counter++;
+    vq->inflight->desc[desc_idx].inflight = 1;
+
+    return 0;
+}
+
+static int
+vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
+{
+    if (!has_feature(dev->protocol_features,
+        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight)) {
+        return -1;
+    }
+
+    vq->inflight->last_batch_head = desc_idx;
+
+    return 0;
+}
+
+static int
+vu_queue_inflight_post_put(VuDev *dev, VuVirtq *vq, int desc_idx)
+{
+    if (!has_feature(dev->protocol_features,
+        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight)) {
+        return -1;
+    }
+
+    barrier();
+
+    vq->inflight->desc[desc_idx].inflight = 0;
+
+    barrier();
+
+    vq->inflight->used_idx = vq->used_idx;
+
+    return 0;
+}
+
 void *
 vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
 {
+    int i;
     unsigned int head;
     VuVirtqElement *elem;
 
@@ -1940,6 +2233,18 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
         return NULL;
     }
 
+    if (unlikely(vq->resubmit_list && vq->resubmit_num > 0)) {
+        i = (--vq->resubmit_num);
+        elem = vu_queue_map_desc(dev, vq, vq->resubmit_list[i].index, sz);
+
+        if (!vq->resubmit_num) {
+            free(vq->resubmit_list);
+            vq->resubmit_list = NULL;
+        }
+
+        return elem;
+    }
+
     if (vu_queue_empty(dev, vq)) {
         return NULL;
     }
@@ -1970,6 +2275,8 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
 
     vq->inuse++;
 
+    vu_queue_inflight_get(dev, vq, head);
+
     return elem;
 }
 
@@ -2114,5 +2421,7 @@ vu_queue_push(VuDev *dev, VuVirtq *vq,
               const VuVirtqElement *elem, unsigned int len)
 {
     vu_queue_fill(dev, vq, elem, len, 0);
+    vu_queue_inflight_pre_put(dev, vq, elem->index);
     vu_queue_flush(dev, vq, 1);
+    vu_queue_inflight_post_put(dev, vq, elem->index);
 }
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 4aa55b4d2d..8a32456943 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CONFIG = 9,
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
+    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -91,6 +92,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_ADVISE  = 28,
     VHOST_USER_POSTCOPY_LISTEN  = 29,
     VHOST_USER_POSTCOPY_END     = 30,
+    VHOST_USER_GET_INFLIGHT_FD = 31,
+    VHOST_USER_SET_INFLIGHT_FD = 32,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -138,6 +141,13 @@ typedef struct VhostUserVringArea {
     uint64_t offset;
 } VhostUserVringArea;
 
+typedef struct VhostUserInflight {
+    uint64_t mmap_size;
+    uint64_t mmap_offset;
+    uint16_t num_queues;
+    uint16_t queue_size;
+} VhostUserInflight;
+
 #if defined(_WIN32)
 # define VU_PACKED __attribute__((gcc_struct, packed))
 #else
@@ -163,6 +173,7 @@ typedef struct VhostUserMsg {
         VhostUserLog log;
         VhostUserConfig config;
         VhostUserVringArea area;
+        VhostUserInflight inflight;
     } payload;
 
     int fds[VHOST_MEMORY_MAX_NREGIONS];
@@ -234,9 +245,61 @@ typedef struct VuRing {
     uint32_t flags;
 } VuRing;
 
+typedef struct VuDescStateSplit {
+    /* Indicate whether this descriptor is inflight or not.
+     * Only available for head-descriptor. */
+    uint8_t inflight;
+
+    /* Padding */
+    uint8_t padding[5];
+
+    /* Maintain a list for the last batch of used descriptors.
+     * Only available when batching is used for submitting */
+    uint16_t next;
+
+    /* Used to preserve the order of fetching available descriptors.
+     * Only available for head-descriptor. */
+    uint64_t counter;
+} VuDescStateSplit;
+
+typedef struct VuVirtqInflight {
+    /* The feature flags of this region. Now it's initialized to 0. */
+    uint64_t features;
+
+    /* The version of this region. It's 1 currently.
+     * Zero value indicates a vm reset happened. */
+    uint16_t version;
+
+    /* The size of VuDescStateSplit array. It's equal to the virtqueue
+     * size. Slave could get it from queue size field of VhostUserInflight. */
+    uint16_t desc_num;
+
+    /* The head of list that track the last batch of used descriptors. */
+    uint16_t last_batch_head;
+
+    /* Storing the idx value of used ring */
+    uint16_t used_idx;
+
+    /* Used to track the state of each descriptor in descriptor table */
+    VuDescStateSplit desc[0];
+} VuVirtqInflight;
+
+typedef struct VuVirtqInflightDesc {
+    uint16_t index;
+    uint64_t counter;
+} VuVirtqInflightDesc;
+
 typedef struct VuVirtq {
     VuRing vring;
 
+    VuVirtqInflight *inflight;
+
+    VuVirtqInflightDesc *resubmit_list;
+
+    uint16_t resubmit_num;
+
+    uint64_t counter;
+
     /* Next head to pop */
     uint16_t last_avail_idx;
 
@@ -279,11 +342,18 @@ typedef void (*vu_set_watch_cb) (VuDev *dev, int fd, int condition,
                                  vu_watch_cb cb, void *data);
 typedef void (*vu_remove_watch_cb) (VuDev *dev, int fd);
 
+typedef struct VuDevInflightInfo {
+    int fd;
+    void *addr;
+    uint64_t size;
+} VuDevInflightInfo;
+
 struct VuDev {
     int sock;
     uint32_t nregions;
     VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
     VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
+    VuDevInflightInfo inflight_info;
     int log_call_fd;
     int slave_fd;
     uint64_t log_size;
-- 
2.17.1
