Received: from eggs.gnu.org ([2001:4830:134:3::10]:46563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fRCsh-00069g-1A
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fRCsf-0000U5-37
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:36:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:58067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fRCse-0000OZ-KD
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:36:21 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  8 Jun 2018 16:10:43 +0800
Message-Id: <1528445443-43406-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
References: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v8 6/6] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

The new feature enables the virtio-balloon device to receive hints of
guest free pages from the free page vq.

A notifier is registered to the migration ram save state notifier list.
The notifier calls free_page_start after the migration thread syncs the
dirty bitmap, so that the free page hinting optimization starts to clear
bits of free pages from the bitmap. It calls the free_page_stop
before the migration thread syncs the bitmap, which is the end of the
current round of ram save. The free_page_stop is also called to stop the
optimization in the case there is an error happened in the process of
ram save.

Note: balloon will report pages which were free at the time of this call.
As the reporting happens asynchronously, dirty bit logging must be
enabled before this free_page_start call is made. Guest reporting must be
disabled before the migration dirty bitmap is synchronized.

TODO:
- If free pages are poisoned by guest, the hints are dropped currently.
  We will support clearing bits of poisoned pages from the bitmap in the
  future.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 hw/virtio/virtio-balloon.c                      | 260 ++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h              |  28 ++-
 include/standard-headers/linux/virtio_balloon.h |   7 +
 3 files changed, 294 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 1f7a87f..a7bb971 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -28,6 +28,7 @@
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "migration/misc.h"
 
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
@@ -310,6 +311,166 @@ out:
     }
 }
 
+static void get_free_page_hints(VirtIOBalloon *dev)
+{
+    VirtQueueElement *elem;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtQueue *vq = dev->free_page_vq;
+    uint32_t id;
+    size_t size;
+
+    while (dev->block_iothread) {
+        qemu_cond_wait(&dev->free_page_cond, &dev->free_page_lock);
+    }
+
+    /*
+     * If the migration thread actively stops the reporting, exit
+     * immediately.
+     */
+    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
+        return;
+    }
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return;
+    }
+
+    if (elem->out_num) {
+        size = iov_to_buf(elem->out_sg, elem->out_num, 0, &id, sizeof(id));
+        virtqueue_push(vq, elem, size);
+        g_free(elem);
+
+        virtio_tswap32s(vdev, &id);
+        if (unlikely(size != sizeof(id))) {
+            virtio_error(vdev, "received an incorrect cmd id");
+            return;
+        }
+        if (id == dev->free_page_report_cmd_id) {
+            dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
+        } else {
+            /*
+             * Stop the optimization only when it has started. This
+             * avoids a stale stop sign for the previous command.
+             */
+            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
+                dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+                return;
+            }
+        }
+    }
+
+    if (elem->in_num) {
+        /* TODO: send the poison value to the destination */
+        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START &&
+            !dev->poison_val) {
+            qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
+                                      elem->in_sg[0].iov_len);
+        }
+        virtqueue_push(vq, elem, 0);
+        g_free(elem);
+    }
+}
+
+static void virtio_balloon_poll_free_page_hints(void *opaque)
+{
+    VirtIOBalloon *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtQueue *vq = dev->free_page_vq;
+
+    while (dev->free_page_report_status != FREE_PAGE_REPORT_S_STOP) {
+        qemu_mutex_lock(&dev->free_page_lock);
+        get_free_page_hints(dev);
+        qemu_mutex_unlock(&dev->free_page_lock);
+    }
+    virtio_notify(vdev, vq);
+}
+
+static bool virtio_balloon_free_page_support(void *opaque)
+{
+    VirtIOBalloon *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
+}
+
+static bool virtio_balloon_page_poison_support(void *opaque)
+{
+    VirtIOBalloon *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+}
+
+static void virtio_balloon_free_page_start(void *opaque)
+{
+    VirtIOBalloon *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    /* For the stop and copy phase, we don't need to start the optimization */
+    if (!vdev->vm_running) {
+        return;
+    }
+
+    if (s->free_page_report_cmd_id == UINT_MAX) {
+        s->free_page_report_cmd_id =
+                       VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
+    } else {
+        s->free_page_report_cmd_id++;
+    }
+
+    s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
+    virtio_notify_config(vdev);
+    qemu_bh_schedule(s->free_page_bh);
+}
+
+static void virtio_balloon_free_page_stop(void *opaque)
+{
+    VirtIOBalloon *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    if (s->free_page_report_status != FREE_PAGE_REPORT_S_STOP) {
+        /*
+         * The lock also guarantees us that the
+         * virtio_balloon_poll_free_page_hints exits after the
+         * free_page_report_status is set to S_STOP.
+         */
+        qemu_mutex_lock(&s->free_page_lock);
+        /*
+         * The guest hasn't done the reporting, so host sends a notification
+         * to the guest to actively stop the reporting.
+         */
+        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+        qemu_mutex_unlock(&s->free_page_lock);
+        virtio_notify_config(vdev);
+    }
+}
+
+static void virtio_balloon_free_page_report_notify(Notifier *notifier,
+                                                   void *data)
+{
+    VirtIOBalloon *dev = container_of(notifier, VirtIOBalloon,
+                                      free_page_report_notify);
+    RAMState *rs = data;
+
+    if (!virtio_balloon_free_page_support(dev) || migrate_postcopy()) {
+        return;
+    }
+
+    switch (rs->ram_save_state) {
+    case RAM_SAVE_RESET:
+        rs->ram_bulk_stage = false;
+        break;
+    case RAM_SAVE_ERR:
+    case RAM_SAVE_BEFORE_SYNC_BITMAP:
+        virtio_balloon_free_page_stop(dev);
+        break;
+    case RAM_SAVE_AFTER_SYNC_BITMAP:
+        virtio_balloon_free_page_start(dev);
+        break;
+    }
+}
+
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 {
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
@@ -317,6 +478,17 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
+    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
+        config.poison_val = cpu_to_le32(dev->poison_val);
+    }
+
+    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
+        config.free_page_report_cmd_id =
+                       cpu_to_le32(VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID);
+    } else {
+        config.free_page_report_cmd_id =
+                       cpu_to_le32(dev->free_page_report_cmd_id);
+    }
 
     trace_virtio_balloon_get_config(config.num_pages, config.actual);
     memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
@@ -370,6 +542,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT),
                         &error_abort);
     }
+    dev->poison_val = le32_to_cpu(config.poison_val);
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
@@ -379,6 +552,12 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
     f |= dev->host_features;
     virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
+
+    if (virtio_has_feature(dev->host_features,
+                           VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
+    }
+
     return f;
 }
 
@@ -415,6 +594,28 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
     return 0;
 }
 
+static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
+    .name = "virtio-balloon-device/free-page-report",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = virtio_balloon_free_page_support,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_virtio_balloon_page_poison = {
+    .name = "virtio-balloon-device/page-poison",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = virtio_balloon_page_poison_support,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(poison_val, VirtIOBalloon),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_balloon_device = {
     .name = "virtio-balloon-device",
     .version_id = 1,
@@ -425,6 +626,11 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
         VMSTATE_UINT32(actual, VirtIOBalloon),
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_virtio_balloon_free_page_report,
+        &vmstate_virtio_balloon_page_poison,
+        NULL
+    }
 };
 
 static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
@@ -449,6 +655,28 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
+    if (virtio_has_feature(s->host_features,
+                           VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE, NULL);
+        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+        s->free_page_report_cmd_id =
+                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
+        s->free_page_report_notify.notify =
+                                       virtio_balloon_free_page_report_notify;
+        add_ram_save_state_change_notifier(&s->free_page_report_notify);
+        if (s->iothread) {
+            object_ref(OBJECT(s->iothread));
+            s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
+                                       virtio_balloon_poll_free_page_hints, s);
+            qemu_mutex_init(&s->free_page_lock);
+            qemu_cond_init(&s->free_page_cond);
+            s->block_iothread = false;
+        } else {
+            /* Simply disable this feature if the iothread wasn't created. */
+            s->host_features &= ~(1 << VIRTIO_BALLOON_F_FREE_PAGE_HINT);
+            virtio_error(vdev, "iothread is missing");
+        }
+    }
     reset_stats(s);
 }
 
@@ -457,6 +685,10 @@ static void virtio_balloon_device_unrealize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBalloon *s = VIRTIO_BALLOON(dev);
 
+    if (virtio_balloon_free_page_support(s)) {
+        qemu_bh_delete(s->free_page_bh);
+        virtio_balloon_free_page_stop(s);
+    }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
     virtio_cleanup(vdev);
@@ -466,6 +698,10 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
 
+    if (virtio_balloon_free_page_support(s)) {
+        virtio_balloon_free_page_stop(s);
+    }
+
     if (s->stats_vq_elem != NULL) {
         virtqueue_unpop(s->svq, s->stats_vq_elem, 0);
         g_free(s->stats_vq_elem);
@@ -483,6 +719,26 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
          * was stopped */
         virtio_balloon_receive_stats(vdev, s->svq);
     }
+
+    if (virtio_balloon_free_page_support(s)) {
+        /*
+         * The VM is woken up and the iothread was blocked, so signal it to
+         * continue.
+         */
+        if (vdev->vm_running && s->block_iothread) {
+            qemu_mutex_lock(&s->free_page_lock);
+            s->block_iothread = false;
+            qemu_cond_signal(&s->free_page_cond);
+            qemu_mutex_unlock(&s->free_page_lock);
+        }
+
+        /* The VM is stopped, block the iothread. */
+        if (!vdev->vm_running) {
+            qemu_mutex_lock(&s->free_page_lock);
+            s->block_iothread = true;
+            qemu_mutex_unlock(&s->free_page_lock);
+        }
+    }
 }
 
 static void virtio_balloon_instance_init(Object *obj)
@@ -511,6 +767,10 @@ static const VMStateDescription vmstate_virtio_balloon = {
 static Property virtio_balloon_properties[] = {
     DEFINE_PROP_BIT("deflate-on-oom", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
+    DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
+                     IOThread *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index e0df352..e14e545 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -17,11 +17,14 @@
 
 #include "standard-headers/linux/virtio_balloon.h"
 #include "hw/virtio/virtio.h"
+#include "sysemu/iothread.h"
 
 #define TYPE_VIRTIO_BALLOON "virtio-balloon-device"
 #define VIRTIO_BALLOON(obj) \
         OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
 
+#define VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN 0x80000000
+
 typedef struct virtio_balloon_stat VirtIOBalloonStat;
 
 typedef struct virtio_balloon_stat_modern {
@@ -30,15 +33,38 @@ typedef struct virtio_balloon_stat_modern {
        uint64_t val;
 } VirtIOBalloonStatModern;
 
+enum virtio_balloon_free_page_report_status {
+    FREE_PAGE_REPORT_S_STOP = 0,
+    FREE_PAGE_REPORT_S_REQUESTED = 1,
+    FREE_PAGE_REPORT_S_START = 2,
+};
+
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;
+    uint32_t free_page_report_cmd_id;
+    uint32_t poison_val;
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
     QEMUTimer *stats_timer;
+    IOThread *iothread;
+    QEMUBH *free_page_bh;
+    /*
+     * Lock to synchronize threads to access the free page reporting related
+     * fields (e.g. free_page_report_status).
+     */
+    QemuMutex free_page_lock;
+    QemuCond  free_page_cond;
+    /*
+     * Set to block iothread to continue reading free page hints as the VM is
+     * stopped.
+     */
+    bool block_iothread;
+    Notifier free_page_report_notify;
     int64_t stats_last_update;
     int64_t stats_poll_interval;
     uint32_t host_features;
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index e446805..eb47e6c 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -34,15 +34,22 @@
 #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
 #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
+#define VIRTIO_BALLOON_F_FREE_PAGE_HINT 3 /* VQ to report free pages */
+#define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
 
+#define VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID 0
 struct virtio_balloon_config {
 	/* Number of pages host wants Guest to give up. */
 	uint32_t num_pages;
 	/* Number of pages we've actually got in balloon. */
 	uint32_t actual;
+	/* Free page report command id, readonly by guest */
+	uint32_t free_page_report_cmd_id;
+	/* Stores PAGE_POISON if page poisoning is in use */
+	uint32_t poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
1.8.3.1
