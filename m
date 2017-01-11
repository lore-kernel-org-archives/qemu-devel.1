Received: from eggs.gnu.org ([2001:4830:134:3::10]:33355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhf-0002c7-SI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhc-0004xj-Ol
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:61694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cREhc-0004wY-Au
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:16 -0500
From: Liang Li <liang.z.li@intel.com>
Date: Wed, 11 Jan 2017 16:48:41 +0800
Message-Id: <1484124524-481-4-git-send-email-liang.z.li@intel.com>
In-Reply-To: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
References: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
Subject: [Qemu-devel] [PATCH v4 qemu 3/6] balloon: get unused page info from
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com, uintela@redhat.com, amit.shah@redhat.com, mtosatti@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, dave.hansen@intel.com, Liang Li <liang.z.li@intel.com>

Add a new feature to get the unused page information from guest,
the unused page information is saved in the {pfn|length} arrays.
Please note that 'unused page' means page is not inuse sometime after
host set the value of request ID and before it receive response with
the same ID.

Signed-off-by: Liang Li <liang.z.li@intel.com>
---
 balloon.c                          |  47 +++++++++++-
 hw/virtio/virtio-balloon.c         | 149 ++++++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-balloon.h |  18 ++++-
 include/sysemu/balloon.h           |  18 ++++-
 4 files changed, 227 insertions(+), 5 deletions(-)

diff --git a/balloon.c b/balloon.c
index f2ef50c..8efabe1 100644
--- a/balloon.c
+++ b/balloon.c
@@ -36,6 +36,8 @@
 
 static QEMUBalloonEvent *balloon_event_fn;
 static QEMUBalloonStatus *balloon_stat_fn;
+static QEMUBalloonGetUnusedPage *balloon_get_unused_page_fn;
+static QEMUBalloonUnusedPageReady *balloon_unused_page_ready_fn;
 static void *balloon_opaque;
 static bool balloon_inhibited;
 
@@ -65,9 +67,13 @@ static bool have_balloon(Error **errp)
 }
 
 int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
-                             QEMUBalloonStatus *stat_func, void *opaque)
+                             QEMUBalloonStatus *stat_func,
+                             QEMUBalloonGetUnusedPage *get_unused_page_func,
+                             QEMUBalloonUnusedPageReady *unused_page_ready_func,
+                             void *opaque)
 {
-    if (balloon_event_fn || balloon_stat_fn || balloon_opaque) {
+    if (balloon_event_fn || balloon_stat_fn || balloon_get_unused_page_fn
+        || balloon_unused_page_ready_fn || balloon_opaque) {
         /* We're already registered one balloon handler.  How many can
          * a guest really have?
          */
@@ -75,6 +81,8 @@ int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
     }
     balloon_event_fn = event_func;
     balloon_stat_fn = stat_func;
+    balloon_get_unused_page_fn = get_unused_page_func;
+    balloon_unused_page_ready_fn = unused_page_ready_func;
     balloon_opaque = opaque;
     return 0;
 }
@@ -86,6 +94,8 @@ void qemu_remove_balloon_handler(void *opaque)
     }
     balloon_event_fn = NULL;
     balloon_stat_fn = NULL;
+    balloon_get_unused_page_fn = NULL;
+    balloon_unused_page_ready_fn = NULL;
     balloon_opaque = NULL;
 }
 
@@ -116,3 +126,36 @@ void qmp_balloon(int64_t target, Error **errp)
     trace_balloon_event(balloon_opaque, target);
     balloon_event_fn(balloon_opaque, target);
 }
+
+bool balloon_unused_pages_support(void)
+{
+    return balloon_get_unused_page_fn ? true : false;
+}
+
+BalloonReqStatus balloon_get_unused_pages(unsigned long *bitmap,
+                                          unsigned long len,
+                                          unsigned long req_id)
+{
+    if (!balloon_get_unused_page_fn) {
+        return REQ_UNSUPPORT;
+    }
+
+    if (!bitmap) {
+        return REQ_INVALID_PARAM;
+    }
+
+    return balloon_get_unused_page_fn(balloon_opaque, bitmap, len, req_id);
+}
+
+BalloonReqStatus balloon_unused_page_ready(unsigned long *req_id)
+{
+    if (!balloon_unused_page_ready_fn) {
+        return REQ_UNSUPPORT;
+    }
+
+    if (!req_id) {
+        return REQ_INVALID_PARAM;
+    }
+
+    return balloon_unused_page_ready_fn(balloon_opaque, req_id);
+}
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4ab65ba..71c7e49 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -143,6 +143,13 @@ static bool balloon_page_ranges_supported(const VirtIOBalloon *s)
     return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_RANGE);
 }
 
+static bool balloon_host_request_vq_supported(const VirtIOBalloon *s)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_HOST_REQ_VQ);
+}
+
 static bool balloon_stats_enabled(const VirtIOBalloon *s)
 {
     return s->stats_poll_interval > 0;
@@ -394,6 +401,72 @@ out:
     }
 }
 
+static void virtio_balloon_handle_resp(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
+    VirtQueueElement *elem;
+    size_t offset = 0;
+    struct virtio_balloon_resp_hdr hdr;
+    uint64_t range;
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        s->req_status = REQ_ERROR;
+        return;
+    }
+
+    s->host_req_vq_elem = elem;
+    if (!elem->out_num) {
+        return;
+    }
+
+    iov_to_buf(elem->out_sg, elem->out_num, offset,
+               &hdr, sizeof(hdr));
+    offset += sizeof(hdr);
+
+    switch (hdr.cmd) {
+    case BALLOON_GET_UNUSED_PAGES:
+        if (hdr.id == s->host_req.param) {
+            if (s->bmap_len < hdr.data_len) {
+                 hdr.data_len = s->bmap_len;
+            }
+
+            while (offset < hdr.data_len + sizeof(hdr)) {
+                unsigned long pfn, nr_page;
+
+                iov_to_buf(elem->out_sg, elem->out_num, offset, &range,
+                              sizeof(range));
+
+                offset += sizeof(range);
+                pfn = range >> VIRTIO_BALLOON_NR_PFN_BITS;
+                nr_page = range & BALLOON_NR_PFN_MASK;
+                if (nr_page == 0) {
+                    if (iov_to_buf(elem->out_sg, elem->out_num, offset, &range,
+                               sizeof(range)) == sizeof(range)) {
+                        nr_page = range;
+                        offset += sizeof(range);
+                    }
+                }
+                bitmap_set(s->unused_page_bmap, pfn, nr_page);
+            }
+
+            if (hdr.flag == BALLOON_FLAG_DONE) {
+                s->req_id = hdr.id;
+                s->req_status = REQ_DONE;
+            } else {
+                s->req_status = REQ_ON_GOING;
+            }
+            virtqueue_push(vq, elem, 0);
+            virtio_notify(vdev, vq);
+            g_free(elem);
+        }
+        break;
+    default:
+        break;
+    }
+
+}
+
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 {
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
@@ -473,6 +546,61 @@ static void virtio_balloon_stat(void *opaque, BalloonInfo *info)
                                              VIRTIO_BALLOON_PFN_SHIFT);
 }
 
+static BalloonReqStatus virtio_balloon_free_pages(void *opaque,
+                                                  unsigned long *bitmap,
+                                                  unsigned long bmap_len,
+                                                  unsigned long req_id)
+{
+    VirtIOBalloon *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+    VirtQueueElement *elem = s->host_req_vq_elem;
+    int len;
+
+    if (!balloon_host_request_vq_supported(s)) {
+        return REQ_UNSUPPORT;
+    }
+
+    if (s->req_status == REQ_INIT || s->req_status == REQ_DONE) {
+        s->unused_page_bmap = bitmap;
+        if (elem == NULL || !elem->in_num) {
+            elem = virtqueue_pop(s->hvq, sizeof(VirtQueueElement));
+            if (!elem) {
+                return REQ_ERROR;
+            }
+            s->host_req_vq_elem = elem;
+        }
+        s->host_req.cmd = BALLOON_GET_UNUSED_PAGES;
+        s->host_req.param = req_id;
+        s->bmap_len = bmap_len;
+        len = iov_from_buf(elem->in_sg, elem->in_num, 0, &s->host_req,
+                           sizeof(s->host_req));
+        virtqueue_push(s->hvq, elem, len);
+        virtio_notify(vdev, s->hvq);
+        g_free(s->host_req_vq_elem);
+        s->host_req_vq_elem = NULL;
+        s->req_status = REQ_ON_GOING;
+        return REQ_START;
+    }
+
+    return REQ_ON_GOING;
+}
+
+static BalloonReqStatus virtio_balloon_free_page_ready(void *opaque,
+                                                       unsigned long *req_id)
+{
+    VirtIOBalloon *s = opaque;
+
+    if (!balloon_host_request_vq_supported(s)) {
+        return REQ_UNSUPPORT;
+    }
+
+    if (s->req_status == REQ_DONE) {
+        *req_id = s->req_id;
+    }
+
+    return s->req_status;
+}
+
 static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
 {
     VirtIOBalloon *dev = VIRTIO_BALLOON(opaque);
@@ -521,7 +649,9 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
                 sizeof(struct virtio_balloon_config));
 
     ret = qemu_add_balloon_handler(virtio_balloon_to_target,
-                                   virtio_balloon_stat, s);
+                                   virtio_balloon_stat,
+                                   virtio_balloon_free_pages,
+                                   virtio_balloon_free_page_ready, s);
 
     if (ret < 0) {
         error_setg(errp, "Only one balloon device is supported");
@@ -532,8 +662,10 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->ivq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
+    s->hvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_resp);
 
     reset_stats(s);
+    s->req_status = REQ_INIT;
 }
 
 static void virtio_balloon_device_unrealize(DeviceState *dev, Error **errp)
@@ -555,6 +687,12 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
         g_free(s->stats_vq_elem);
         s->stats_vq_elem = NULL;
     }
+
+    if (s->host_req_vq_elem != NULL) {
+        g_free(s->host_req_vq_elem);
+        s->host_req_vq_elem = NULL;
+    }
+    s->req_status = REQ_INIT;
 }
 
 static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
@@ -567,6 +705,13 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
          * was stopped */
         virtio_balloon_receive_stats(vdev, s->svq);
     }
+
+    if (!s->host_req_vq_elem && vdev->vm_running &&
+        (status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->hvq, 1)) {
+        /* poll misc queue for the element we have discarded when the VM
+         * was stopped */
+        virtio_balloon_handle_resp(vdev, s->hvq);
+    }
 }
 
 static void virtio_balloon_instance_init(Object *obj)
@@ -597,6 +742,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("page-ranges", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_PAGE_RANGE, true),
+    DEFINE_PROP_BIT("host-request-vq", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_HOST_REQ_VQ, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 1ea13bd..0af59af 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -23,6 +23,16 @@
 #define VIRTIO_BALLOON(obj) \
         OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
 
+typedef enum {
+    REQ_INIT,
+    REQ_START,
+    REQ_ON_GOING,
+    REQ_DONE,
+    REQ_ERROR,
+    REQ_INVALID_PARAM,
+    REQ_UNSUPPORT,
+} BalloonReqStatus;
+
 typedef struct virtio_balloon_stat VirtIOBalloonStat;
 
 typedef struct virtio_balloon_stat_modern {
@@ -33,16 +43,22 @@ typedef struct virtio_balloon_stat_modern {
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq;
+    VirtQueue *ivq, *dvq, *svq, *hvq;
     uint32_t num_pages;
     uint32_t actual;
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
+    VirtQueueElement *host_req_vq_elem;
     size_t stats_vq_offset;
     QEMUTimer *stats_timer;
     int64_t stats_last_update;
     int64_t stats_poll_interval;
     uint32_t host_features;
+    struct virtio_balloon_req_hdr host_req;
+    BalloonReqStatus req_status;
+    uint64_t *unused_page_bmap;
+    uint64_t bmap_len;
+    uint64_t req_id;
 } VirtIOBalloon;
 
 #endif
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index af49e19..a642c83 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -15,14 +15,30 @@
 #define QEMU_BALLOON_H
 
 #include "qapi-types.h"
+#include "hw/virtio/virtio-balloon.h"
 
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
 typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
+typedef BalloonReqStatus (QEMUBalloonGetUnusedPage)(void *opaque,
+                                                    unsigned long *bitmap,
+                                                    unsigned long len,
+                                                    unsigned long req_id);
+
+typedef BalloonReqStatus (QEMUBalloonUnusedPageReady)(void *opaque,
+                                                    unsigned long *req_id);
 
 int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
-			     QEMUBalloonStatus *stat_func, void *opaque);
+                             QEMUBalloonStatus *stat_func,
+                             QEMUBalloonGetUnusedPage *get_unused_page_func,
+                             QEMUBalloonUnusedPageReady *unused_page_ready_func,
+                             void *opaque);
 void qemu_remove_balloon_handler(void *opaque);
 bool qemu_balloon_is_inhibited(void);
 void qemu_balloon_inhibit(bool state);
+bool balloon_unused_pages_support(void);
+BalloonReqStatus balloon_get_unused_pages(unsigned long *bitmap,
+                                          unsigned long len,
+                                          unsigned long req_id);
+BalloonReqStatus balloon_unused_page_ready(unsigned long *req_id);
 
 #endif
-- 
1.9.1
