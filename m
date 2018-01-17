Received: from eggs.gnu.org ([2001:4830:134:3::10]:54616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebhYB-00053X-8a
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebhY8-0003n9-7r
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:59301)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ebhY7-0003l7-RP
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:16 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 17 Jan 2018 14:31:57 +0800
Message-Id: <1516170720-4948-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
References: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 1/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_VQ
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

The new feature enables the virtio-balloon device to receive the hint of
guest free pages from the free page vq, and clears the corresponding bits
of the free page from the dirty bitmap, so that those free pages are not
transferred by the migration thread.

Without this feature, to local live migrate an 8G idle guest takes
~2286 ms. With this featrue, it takes ~260 ms, which redues the
migration time to ~11%.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Liang Li <liang.z.li@intel.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 balloon.c                                       |  46 ++++++--
 hw/virtio/virtio-balloon.c                      | 140 +++++++++++++++++++++---
 include/hw/virtio/virtio-balloon.h              |   7 +-
 include/migration/misc.h                        |   3 +
 include/standard-headers/linux/virtio_balloon.h |   4 +
 include/sysemu/balloon.h                        |  15 ++-
 migration/ram.c                                 |  10 ++
 7 files changed, 198 insertions(+), 27 deletions(-)

diff --git a/balloon.c b/balloon.c
index 1d720ff..480a989 100644
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
 
@@ -64,17 +67,41 @@ static bool have_balloon(Error **errp)
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
+    return balloon_free_page_support_fn &&
+           balloon_free_page_support_fn(balloon_opaque);
+}
+
+void balloon_free_page_start(void)
+{
+    balloon_free_page_start_fn(balloon_opaque);
+}
+
+void balloon_free_page_stop(void)
+{
+    balloon_free_page_stop_fn(balloon_opaque);
+}
+
+int qemu_add_balloon_handler(QEMUBalloonEvent *event_fn,
+                             QEMUBalloonStatus *stat_fn,
+                             QEMUBalloonFreePageSupport *free_page_support_fn,
+                             QEMUBalloonFreePageStart *free_page_start_fn,
+                             QEMUBalloonFreePageStop *free_page_stop_fn,
+                             void *opaque)
+{
+    if (balloon_event_fn || balloon_stat_fn || balloon_free_page_support_fn ||
+        balloon_free_page_start_fn || balloon_free_page_stop_fn ||
+        balloon_opaque) {
+        /* We already registered one balloon handler. */
         return -1;
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
     return 0;
 }
@@ -86,6 +113,9 @@ void qemu_remove_balloon_handler(void *opaque)
     }
     balloon_event_fn = NULL;
     balloon_stat_fn = NULL;
+    balloon_free_page_support_fn = NULL;
+    balloon_free_page_start_fn = NULL;
+    balloon_free_page_stop_fn = NULL;
     balloon_opaque = NULL;
 }
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 14e08d2..a2a5536 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -30,6 +30,7 @@
 
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
+#include "migration/misc.h"
 
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
 
@@ -73,6 +74,13 @@ static bool balloon_stats_supported(const VirtIOBalloon *s)
     return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_STATS_VQ);
 }
 
+static bool balloon_free_page_supported(const VirtIOBalloon *s)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_VQ);
+}
+
 static bool balloon_stats_enabled(const VirtIOBalloon *s)
 {
     return s->stats_poll_interval > 0;
@@ -305,6 +313,85 @@ out:
     }
 }
 
+static void virtio_balloon_handle_free_pages(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
+    VirtQueueElement *elem;
+    uint32_t size, id;
+
+    for (;;) {
+        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            break;
+        }
+
+        if (elem->out_num) {
+            iov_to_buf(elem->out_sg, elem->out_num, 0, &id, sizeof(uint32_t));
+            size = elem->out_sg[0].iov_len;
+            if (id == dev->free_page_report_cmd_id) {
+                atomic_set(&dev->free_page_report_status,
+                           FREE_PAGE_REPORT_S_IN_PROGRESS);
+            } else {
+                atomic_set(&dev->free_page_report_status,
+                           FREE_PAGE_REPORT_S_STOP);
+            }
+        }
+
+        if (elem->in_num) {
+            RAMBlock *block;
+            ram_addr_t offset;
+
+            if (atomic_read(&dev->free_page_report_status) ==
+                FREE_PAGE_REPORT_S_IN_PROGRESS) {
+                block = qemu_ram_block_from_host(elem->in_sg[0].iov_base,
+                                                 false, &offset);
+                size = elem->in_sg[0].iov_len;
+                skip_free_pages_from_dirty_bitmap(block, offset, size);
+            }
+        }
+
+        virtqueue_push(vq, elem, sizeof(id));
+        g_free(elem);
+    }
+}
+
+static bool virtio_balloon_free_page_support(void *opaque)
+{
+    VirtIOBalloon *s = opaque;
+
+    if (!balloon_free_page_supported(s)) {
+        return false;
+    }
+
+    return true;
+}
+
+static void virtio_balloon_free_page_start(void *opaque)
+{
+    VirtIOBalloon *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    dev->free_page_report_cmd_id++;
+    virtio_notify_config(vdev);
+    atomic_set(&dev->free_page_report_status, FREE_PAGE_REPORT_S_START);
+}
+
+static void virtio_balloon_free_page_stop(void *opaque)
+{
+    VirtIOBalloon *dev = opaque;
+
+    /* The guest has done the report */
+    if (atomic_read(&dev->free_page_report_status) ==
+        FREE_PAGE_REPORT_S_STOP) {
+        return;
+    }
+
+    /* Wait till a stop sign is received from the guest */
+    while (atomic_read(&dev->free_page_report_status) !=
+           FREE_PAGE_REPORT_S_STOP)
+        ;
+}
+
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 {
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
@@ -312,6 +399,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
+    config.free_page_report_cmd_id = cpu_to_le32(dev->free_page_report_cmd_id);
 
     trace_virtio_balloon_get_config(config.num_pages, config.actual);
     memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
@@ -418,6 +506,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(num_pages, VirtIOBalloon),
         VMSTATE_UINT32(actual, VirtIOBalloon),
+        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -426,24 +515,18 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
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
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_VQ)) {
+        s->free_page_vq = virtio_add_queue(vdev, 128,
+                                           virtio_balloon_handle_free_pages);
+        atomic_set(&s->free_page_report_status, FREE_PAGE_REPORT_S_STOP);
+    }
     reset_stats(s);
 }
 
@@ -471,12 +554,35 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
 static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
+    int ret = 0;
+
+    if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+        if (!s->stats_vq_elem && vdev->vm_running &&
+            virtqueue_rewind(s->svq, 1)) {
+            /*
+             * Poll stats queue for the element we have discarded when the VM
+             * was stopped.
+             */
+            virtio_balloon_receive_stats(vdev, s->svq);
+        }
 
-    if (!s->stats_vq_elem && vdev->vm_running &&
-        (status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->svq, 1)) {
-        /* poll stats queue for the element we have discarded when the VM
-         * was stopped */
-        virtio_balloon_receive_stats(vdev, s->svq);
+        if (balloon_free_page_supported(s)) {
+            ret = qemu_add_balloon_handler(virtio_balloon_to_target,
+                                           virtio_balloon_stat,
+                                           virtio_balloon_free_page_support,
+                                           virtio_balloon_free_page_start,
+                                           virtio_balloon_free_page_stop,
+                                           s);
+        } else {
+            ret = qemu_add_balloon_handler(virtio_balloon_to_target,
+                                           virtio_balloon_stat, NULL, NULL,
+                                           NULL, s);
+        }
+        if (ret < 0) {
+                fprintf(stderr, "Only one balloon device is supported\n");
+                virtio_cleanup(vdev);
+                return;
+        }
     }
 }
 
@@ -506,6 +612,8 @@ static const VMStateDescription vmstate_virtio_balloon = {
 static Property virtio_balloon_properties[] = {
     DEFINE_PROP_BIT("deflate-on-oom", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
+    DEFINE_PROP_BIT("free-page-vq", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_FREE_PAGE_VQ, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 1ea13bd..b84b4af 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -31,11 +31,16 @@ typedef struct virtio_balloon_stat_modern {
        uint64_t val;
 } VirtIOBalloonStatModern;
 
+#define FREE_PAGE_REPORT_S_START        0
+#define FREE_PAGE_REPORT_S_IN_PROGRESS  1
+#define FREE_PAGE_REPORT_S_STOP         2
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;
+    uint32_t free_page_report_cmd_id;
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 77fd4f5..6df419c 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -14,11 +14,14 @@
 #ifndef MIGRATION_MISC_H
 #define MIGRATION_MISC_H
 
+#include "exec/cpu-common.h"
 #include "qemu/notify.h"
 
 /* migration/ram.c */
 
 void ram_mig_init(void);
+void skip_free_pages_from_dirty_bitmap(RAMBlock *block, ram_addr_t offset,
+                                       size_t len);
 
 /* migration/block.c */
 
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9d06ccd..596df5d 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -34,15 +34,19 @@
 #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
 #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
+#define VIRTIO_BALLOON_F_FREE_PAGE_VQ	3 /* VQ to report free pages */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
 
+#define VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID 0
 struct virtio_balloon_config {
 	/* Number of pages host wants Guest to give up. */
 	uint32_t num_pages;
 	/* Number of pages we've actually got in balloon. */
 	uint32_t actual;
+        /* The free_page report command id, readonly by guest */
+	uint32_t free_page_report_cmd_id;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index af49e19..cfee3ca 100644
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
+int qemu_add_balloon_handler(QEMUBalloonEvent *event_fn,
+                             QEMUBalloonStatus *stat_fn,
+                             QEMUBalloonFreePageSupport *free_page_support_fn,
+                             QEMUBalloonFreePageStart *free_page_start_fn,
+                             QEMUBalloonFreePageStop *free_page_stop_fn,
+                             void *opaque);
 
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index cb1950f..d6f462c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2186,6 +2186,16 @@ static int ram_init_all(RAMState **rsp)
     return 0;
 }
 
+void skip_free_pages_from_dirty_bitmap(RAMBlock *block, ram_addr_t offset,
+                                       size_t len)
+{
+    long start = offset >> TARGET_PAGE_BITS,
+         nr = len >> TARGET_PAGE_BITS;
+
+    bitmap_clear(block->bmap, start, nr);
+    ram_state->migration_dirty_pages -= nr;
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
-- 
1.8.3.1
