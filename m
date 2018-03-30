Received: from eggs.gnu.org ([2001:4830:134:3::10]:54717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f1qZL-0007Fu-Ik
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f1qZJ-0007KK-Hh
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:45750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1f1qZJ-0007Io-1k
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:33 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 30 Mar 2018 17:24:35 +0800
Message-Id: <1522401876-39613-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1522401876-39613-1-git-send-email-wei.w.wang@intel.com>
References: <1522401876-39613-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v6 4/5] virtio-balloon:
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
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

The new feature enables the virtio-balloon device to receive hints of
guest free pages from the free page vq.

balloon_free_page_start - start guest free page hint reporting.
balloon_free_page_stop - stop guest free page hint reporting.

Note: balloon will report pages which were free at the time
of this call. As the reporting happens asynchronously, dirty bit logging
must be enabled before this call is made. Guest reporting must be
disabled before the migration dirty bitmap is synchronized.

TODO:
- handle the case when page poisoning is in use

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Liang Li <liang.z.li@intel.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
---
 balloon.c                                       |  58 +++++-
 hw/virtio/virtio-balloon.c                      | 240 ++++++++++++++++++++++--
 include/hw/virtio/virtio-balloon.h              |  27 ++-
 include/standard-headers/linux/virtio_balloon.h |   7 +
 include/sysemu/balloon.h                        |  15 +-
 5 files changed, 318 insertions(+), 29 deletions(-)

diff --git a/balloon.c b/balloon.c
index 6bf0a96..87a0410 100644
--- a/balloon.c
+++ b/balloon.c
@@ -36,6 +36,9 @@
 
 static QEMUBalloonEvent *balloon_event_fn;
 static QEMUBalloonStatus *balloon_stat_fn;
+static QEMUBalloonFreePageSupport *balloon_free_page_support_fn;
+static QEMUBalloonFreePageStart *balloon_free_page_start_fn;
+static QEMUBalloonFreePageStop *balloon_free_page_stop_fn;
 static void *balloon_opaque;
 static bool balloon_inhibited;
 
@@ -64,19 +67,51 @@ static bool have_balloon(Error **errp)
     return true;
 }
 
-int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
-                             QEMUBalloonStatus *stat_func, void *opaque)
+bool balloon_free_page_support(void)
 {
-    if (balloon_event_fn || balloon_stat_fn || balloon_opaque) {
-        /* We're already registered one balloon handler.  How many can
-         * a guest really have?
-         */
-        return -1;
+    return balloon_free_page_support_fn &&
+           balloon_free_page_support_fn(balloon_opaque);
+}
+
+/*
+ * Balloon will report pages which were free at the time of this call. As the
+ * reporting happens asynchronously, dirty bit logging must be enabled before
+ * this call is made.
+ */
+void balloon_free_page_start(void)
+{
+    balloon_free_page_start_fn(balloon_opaque);
+}
+
+/*
+ * Guest reporting must be disabled before the migration dirty bitmap is
+ * synchronized.
+ */
+void balloon_free_page_stop(void)
+{
+    balloon_free_page_stop_fn(balloon_opaque);
+}
+
+void qemu_add_balloon_handler(QEMUBalloonEvent *event_fn,
+                              QEMUBalloonStatus *stat_fn,
+                              QEMUBalloonFreePageSupport *free_page_support_fn,
+                              QEMUBalloonFreePageStart *free_page_start_fn,
+                              QEMUBalloonFreePageStop *free_page_stop_fn,
+                              void *opaque)
+{
+    if (balloon_event_fn || balloon_stat_fn || balloon_free_page_support_fn ||
+        balloon_free_page_start_fn || balloon_free_page_stop_fn ||
+        balloon_opaque) {
+        /* We already registered one balloon handler. */
+        return;
     }
-    balloon_event_fn = event_func;
-    balloon_stat_fn = stat_func;
+
+    balloon_event_fn = event_fn;
+    balloon_stat_fn = stat_fn;
+    balloon_free_page_support_fn = free_page_support_fn;
+    balloon_free_page_start_fn = free_page_start_fn;
+    balloon_free_page_stop_fn = free_page_stop_fn;
     balloon_opaque = opaque;
-    return 0;
 }
 
 void qemu_remove_balloon_handler(void *opaque)
@@ -86,6 +121,9 @@ void qemu_remove_balloon_handler(void *opaque)
     }
     balloon_event_fn = NULL;
     balloon_stat_fn = NULL;
+    balloon_free_page_support_fn = NULL;
+    balloon_free_page_start_fn = NULL;
+    balloon_free_page_stop_fn = NULL;
     balloon_opaque = NULL;
 }
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index f456cea..2710c6e 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -31,6 +31,7 @@
 
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
+#include "migration/misc.h"
 
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
 
@@ -308,6 +309,124 @@ out:
     }
 }
 
+static void virtio_balloon_poll_free_page_hints(void *opaque)
+{
+    VirtQueueElement *elem;
+    VirtIOBalloon *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtQueue *vq = dev->free_page_vq;
+    uint32_t id;
+    size_t size;
+
+    while (1) {
+        qemu_mutex_lock(&dev->free_page_lock);
+        while (dev->block_iothread) {
+            qemu_cond_wait(&dev->free_page_cond, &dev->free_page_lock);
+        }
+
+        /*
+         * If the migration thread actively stops the reporting, exit
+         * immediately.
+         */
+        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
+            qemu_mutex_unlock(&dev->free_page_lock);
+            break;
+        }
+
+        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            qemu_mutex_unlock(&dev->free_page_lock);
+            continue;
+        }
+
+        if (elem->out_num) {
+            size = iov_to_buf(elem->out_sg, elem->out_num, 0, &id, sizeof(id));
+            virtqueue_push(vq, elem, size);
+            g_free(elem);
+
+            virtio_tswap32s(vdev, &id);
+            if (unlikely(size != sizeof(id))) {
+                virtio_error(vdev, "received an incorrect cmd id");
+                break;
+            }
+            if (id == dev->free_page_report_cmd_id) {
+                dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
+            } else {
+                /*
+                 * Stop the optimization only when it has started. This
+                 * avoids a stale stop sign for the previous command.
+                 */
+                if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
+                    dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+                    qemu_mutex_unlock(&dev->free_page_lock);
+                    break;
+                }
+            }
+        }
+
+        if (elem->in_num) {
+            /* TODO: send the poison value to the destination */
+            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START &&
+                !dev->poison_val) {
+                qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
+                                          elem->in_sg[0].iov_len);
+            }
+            virtqueue_push(vq, elem, 0);
+            g_free(elem);
+        }
+        qemu_mutex_unlock(&dev->free_page_lock);
+    }
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
+    if (s->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
+        return;
+    } else {
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
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 {
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
@@ -315,6 +434,17 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
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
@@ -368,6 +498,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT),
                         &error_abort);
     }
+    dev->poison_val = le32_to_cpu(config.poison_val);
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
@@ -377,6 +508,11 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
     f |= dev->host_features;
     virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
+
+    if (dev->host_features & 1ULL << VIRTIO_BALLOON_F_FREE_PAGE_HINT) {
+        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
+    }
+
     return f;
 }
 
@@ -413,6 +549,18 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
     return 0;
 }
 
+static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
+    .name = "virtio-balloon-device/free-page-report",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = virtio_balloon_free_page_support,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
+        VMSTATE_UINT32(poison_val, VirtIOBalloon),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_balloon_device = {
     .name = "virtio-balloon-device",
     .version_id = 1,
@@ -423,30 +571,42 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
         VMSTATE_UINT32(actual, VirtIOBalloon),
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_virtio_balloon_free_page_report,
+        NULL
+    }
 };
 
 static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBalloon *s = VIRTIO_BALLOON(dev);
-    int ret;
 
     virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
                 sizeof(struct virtio_balloon_config));
 
-    ret = qemu_add_balloon_handler(virtio_balloon_to_target,
-                                   virtio_balloon_stat, s);
-
-    if (ret < 0) {
-        error_setg(errp, "Only one balloon device is supported");
-        virtio_cleanup(vdev);
-        return;
-    }
-
     s->ivq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
-
+    if (virtio_has_feature(s->host_features,
+                           VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE, NULL);
+        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+        s->free_page_report_cmd_id =
+                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN - 1;
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
 
@@ -455,6 +615,10 @@ static void virtio_balloon_device_unrealize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBalloon *s = VIRTIO_BALLOON(dev);
 
+    if (virtio_balloon_free_page_support(s)) {
+        qemu_bh_delete(s->free_page_bh);
+        virtio_balloon_free_page_stop(s);
+    }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
     virtio_cleanup(vdev);
@@ -464,6 +628,10 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
 
+    if (virtio_balloon_free_page_support(s)) {
+        virtio_balloon_free_page_stop(s);
+    }
+
     if (s->stats_vq_elem != NULL) {
         virtqueue_unpop(s->svq, s->stats_vq_elem, 0);
         g_free(s->stats_vq_elem);
@@ -475,11 +643,47 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
 
-    if (!s->stats_vq_elem && vdev->vm_running &&
-        (status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->svq, 1)) {
-        /* poll stats queue for the element we have discarded when the VM
-         * was stopped */
-        virtio_balloon_receive_stats(vdev, s->svq);
+    if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+        if (!s->stats_vq_elem && vdev->vm_running &&
+            virtqueue_rewind(s->svq, 1)) {
+            /*
+             * Poll stats queue for the element we have discarded when the VM
+             * was stopped.
+             */
+            virtio_balloon_receive_stats(vdev, s->svq);
+        }
+
+        if (virtio_balloon_free_page_support(s)) {
+            qemu_add_balloon_handler(virtio_balloon_to_target,
+                                     virtio_balloon_stat,
+                                     virtio_balloon_free_page_support,
+                                     virtio_balloon_free_page_start,
+                                     virtio_balloon_free_page_stop,
+                                     s);
+        } else {
+            qemu_add_balloon_handler(virtio_balloon_to_target,
+                                     virtio_balloon_stat, NULL, NULL, NULL, s);
+        }
+    }
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
     }
 }
 
@@ -509,6 +713,10 @@ static const VMStateDescription vmstate_virtio_balloon = {
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
index 1ea13bd..f865832 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -18,11 +18,14 @@
 #include "standard-headers/linux/virtio_balloon.h"
 #include "hw/virtio/virtio.h"
 #include "hw/pci/pci.h"
+#include "sysemu/iothread.h"
 
 #define TYPE_VIRTIO_BALLOON "virtio-balloon-device"
 #define VIRTIO_BALLOON(obj) \
         OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
 
+#define VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN 0x80000000
+
 typedef struct virtio_balloon_stat VirtIOBalloonStat;
 
 typedef struct virtio_balloon_stat_modern {
@@ -31,15 +34,37 @@ typedef struct virtio_balloon_stat_modern {
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
     int64_t stats_last_update;
     int64_t stats_poll_interval;
     uint32_t host_features;
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 7b0a41b..f89e80f 100644
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
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index 66543ae..6561a08 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -18,11 +18,22 @@
 
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
 typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
+typedef bool (QEMUBalloonFreePageSupport)(void *opaque);
+typedef void (QEMUBalloonFreePageStart)(void *opaque);
+typedef void (QEMUBalloonFreePageStop)(void *opaque);
 
-int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
-			     QEMUBalloonStatus *stat_func, void *opaque);
 void qemu_remove_balloon_handler(void *opaque);
 bool qemu_balloon_is_inhibited(void);
 void qemu_balloon_inhibit(bool state);
+bool balloon_free_page_support(void);
+void balloon_free_page_start(void);
+void balloon_free_page_stop(void);
+
+void qemu_add_balloon_handler(QEMUBalloonEvent *event_fn,
+                              QEMUBalloonStatus *stat_fn,
+                              QEMUBalloonFreePageSupport *free_page_support_fn,
+                              QEMUBalloonFreePageStart *free_page_start_fn,
+                              QEMUBalloonFreePageStop *free_page_stop_fn,
+                              void *opaque);
 
 #endif
-- 
1.8.3.1
