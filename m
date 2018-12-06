Received: from eggs.gnu.org ([2001:4830:134:3::10]:52875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUnHR-0001Xi-8V
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUnHL-0003Yu-5p
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:59 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gUnHH-0003Tm-AU
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:53 -0500
Received: by mail-pg1-x543.google.com with SMTP id s198so10211068pgs.2
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 22:36:50 -0800 (PST)
From: elohimes@gmail.com
Date: Thu,  6 Dec 2018 14:35:50 +0800
Message-Id: <20181206063552.6701-5-xieyongji@baidu.com>
In-Reply-To: <20181206063552.6701-1-xieyongji@baidu.com>
References: <20181206063552.6701-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH for-4.0 4/6] libvhost-user: Support recording
 inflight I/O in shared memory
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

This patch adds support for VHOST_USER_SET_VRING_INFLIGHT
message. Now we maintain a "bitmap" of all descriptors in
the shared memory for each queue. Then set it in vu_queue_pop()
and clear it in vu_queue_push();

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 contrib/libvhost-user/libvhost-user.c | 129 ++++++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h |  19 ++++
 2 files changed, 148 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 4432bd8bb4..38ef1f5898 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -100,6 +100,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_POSTCOPY_ADVISE),
         REQ(VHOST_USER_POSTCOPY_LISTEN),
         REQ(VHOST_USER_POSTCOPY_END),
+        REQ(VHOST_USER_SET_VRING_INFLIGHT),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -890,6 +891,41 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
     return true;
 }
 
+static int
+vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
+{
+    int i = 0;
+
+    if ((dev->protocol_features &
+         VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD) == 0) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight.addr)) {
+        return -1;
+    }
+
+    vq->used_idx = vq->vring.used->idx;
+    vq->inflight_num = 0;
+    for (i = 0; i < vq->vring.num; i++) {
+        if (vq->inflight.addr[i] == 0) {
+            continue;
+        }
+
+        vq->inflight_desc[vq->inflight_num++] = i;
+        vq->inuse++;
+    }
+    vq->shadow_avail_idx = vq->last_avail_idx = vq->inuse + vq->used_idx;
+
+    /* in case of I/O hang after reconnecting */
+    if (eventfd_write(vq->kick_fd, 1) ||
+        eventfd_write(vq->call_fd, 1)) {
+        return -1;
+    }
+
+    return 0;
+}
+
 static bool
 vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -925,6 +961,10 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
                dev->vq[index].kick_fd, index);
     }
 
+    if (vu_check_queue_inflights(dev, &dev->vq[index])) {
+        vu_panic(dev, "Failed to check inflights for vq: %d\n", index);
+    }
+
     return false;
 }
 
@@ -1215,6 +1255,44 @@ vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg)
     return true;
 }
 
+static bool
+vu_set_vring_inflight(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int fd;
+    uint32_t size, idx;
+    void *rc;
+
+    if (vmsg->fd_num != 1 ||
+        vmsg->size != sizeof(vmsg->payload.inflight)) {
+        vu_panic(dev, "Invalid vring_inflight message size:%d fds:%d",
+                 vmsg->size, vmsg->fd_num);
+        return false;
+    }
+
+    fd = vmsg->fds[0];
+    idx = vmsg->payload.inflight.idx;
+    size = vmsg->payload.inflight.size;
+    DPRINT("vring_inflight idx: %"PRId32"\n", idx);
+    DPRINT("vring_inflight size: %"PRId32"\n", size);
+
+    rc = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+    close(fd);
+
+    if (rc == MAP_FAILED) {
+        vu_panic(dev, "vring_inflight mmap error: %s", strerror(errno));
+        return false;
+    }
+
+    if (dev->vq[idx].inflight.addr) {
+        munmap(dev->vq[idx].inflight.addr, dev->vq[idx].inflight.size);
+    }
+    dev->vq[idx].inflight.addr = (char *)rc;
+    dev->vq[idx].inflight.size = size;
+
+    return false;
+}
+
 static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1292,6 +1370,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_postcopy_listen(dev, vmsg);
     case VHOST_USER_POSTCOPY_END:
         return vu_set_postcopy_end(dev, vmsg);
+    case VHOST_USER_SET_VRING_INFLIGHT:
+        return vu_set_vring_inflight(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
@@ -1359,6 +1439,11 @@ vu_deinit(VuDev *dev)
             close(vq->err_fd);
             vq->err_fd = -1;
         }
+
+        if (vq->inflight.addr) {
+            munmap(vq->inflight.addr, vq->inflight.size);
+            vq->inflight.addr = NULL;
+        }
     }
 
 
@@ -1935,9 +2020,44 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
     return elem;
 }
 
+static int
+vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
+{
+    if ((dev->protocol_features &
+         VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD) == 0) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight.addr)) {
+        return -1;
+    }
+
+    vq->inflight.addr[desc_idx] = 1;
+
+    return 0;
+}
+
+static int
+vu_queue_inflight_put(VuDev *dev, VuVirtq *vq, int desc_idx)
+{
+    if ((dev->protocol_features &
+         VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD) == 0) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight.addr)) {
+        return -1;
+    }
+
+    vq->inflight.addr[desc_idx] = 0;
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
 
@@ -1946,6 +2066,12 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
         return NULL;
     }
 
+    if (unlikely(vq->inflight_num > 0)) {
+        i = (--vq->inflight_num);
+        elem = vu_queue_map_desc(dev, vq, vq->inflight_desc[i], sz);
+        return elem;
+    }
+
     if (vu_queue_empty(dev, vq)) {
         return NULL;
     }
@@ -1974,6 +2100,8 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
 
     vq->inuse++;
 
+    vu_queue_inflight_get(dev, vq, head);
+
     return elem;
 }
 
@@ -2119,4 +2247,5 @@ vu_queue_push(VuDev *dev, VuVirtq *vq,
 {
     vu_queue_fill(dev, vq, elem, len, 0);
     vu_queue_flush(dev, vq, 1);
+    vu_queue_inflight_put(dev, vq, elem->index);
 }
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 4aa55b4d2d..2b0d14fd41 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CONFIG = 9,
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
+    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -91,6 +92,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_ADVISE  = 28,
     VHOST_USER_POSTCOPY_LISTEN  = 29,
     VHOST_USER_POSTCOPY_END     = 30,
+    VHOST_USER_SET_VRING_INFLIGHT = 31,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -138,6 +140,11 @@ typedef struct VhostUserVringArea {
     uint64_t offset;
 } VhostUserVringArea;
 
+typedef struct VhostUserVringInflight {
+    uint32_t size;
+    uint32_t idx;
+} VhostUserVringInflight;
+
 #if defined(_WIN32)
 # define VU_PACKED __attribute__((gcc_struct, packed))
 #else
@@ -163,6 +170,7 @@ typedef struct VhostUserMsg {
         VhostUserLog log;
         VhostUserConfig config;
         VhostUserVringArea area;
+        VhostUserVringInflight inflight;
     } payload;
 
     int fds[VHOST_MEMORY_MAX_NREGIONS];
@@ -234,9 +242,20 @@ typedef struct VuRing {
     uint32_t flags;
 } VuRing;
 
+typedef struct VuInflight {
+    char *addr;
+    uint32_t size;
+} VuInflight;
+
 typedef struct VuVirtq {
     VuRing vring;
 
+    VuInflight inflight;
+
+    uint16_t inflight_desc[VIRTQUEUE_MAX_SIZE];
+
+    uint16_t inflight_num;
+
     /* Next head to pop */
     uint16_t last_avail_idx;
 
-- 
2.17.1
