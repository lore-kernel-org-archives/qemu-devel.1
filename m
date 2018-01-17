Received: from eggs.gnu.org ([2001:4830:134:3::10]:54652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebhYD-00053q-5b
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebhYB-0003rX-Qp
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:59302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ebhYB-0003no-H1
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:19 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 17 Jan 2018 14:31:59 +0800
Message-Id: <1516170720-4948-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
References: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 3/4] virtio-balloon: add a timer to limit
 the free page report wating time
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

This patch adds a timer to limit the time that the host waits for the
free pages reported by the guest. Users can specify the time in ms via
"free-page-wait-time" command line option. If a user doesn't specify a
time, the host waits till the guest finishes reporting all the free
pages. The policy (wait for all the free pages to be reported or use a
time limit) is determined by the orchestration layer.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c         | 85 +++++++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-pci.c             |  3 ++
 include/hw/virtio/virtio-balloon.h |  4 ++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a2a5536..dcc8cb3 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -213,6 +213,66 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
     balloon_stats_change_timer(s, 0);
 }
 
+static void balloon_free_page_change_timer(VirtIOBalloon *s, int64_t ms)
+{
+    timer_mod(s->free_page_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + ms);
+}
+
+static void balloon_stop_free_page_report(void *opaque)
+{
+    VirtIOBalloon *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    timer_del(dev->free_page_timer);
+    timer_free(dev->free_page_timer);
+    dev->free_page_timer = NULL;
+
+    if (atomic_read(&dev->free_page_report_status) ==
+        FREE_PAGE_REPORT_S_IN_PROGRESS) {
+        dev->host_stop_free_page = true;
+        virtio_notify_config(vdev);
+    }
+}
+
+static void balloon_free_page_get_wait_time(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    VirtIOBalloon *s = opaque;
+
+    visit_type_int(v, name, &s->free_page_wait_time, errp);
+}
+
+static void balloon_free_page_set_wait_time(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    VirtIOBalloon *s = opaque;
+    Error *local_err = NULL;
+    int64_t value;
+
+    visit_type_int(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    if (value < 0) {
+        error_setg(errp, "free page wait time must be greater than zero");
+        return;
+    }
+
+    if (value > UINT32_MAX) {
+        error_setg(errp, "free page wait time value is too big");
+        return;
+    }
+
+    s->free_page_wait_time = value;
+    g_assert(s->free_page_timer == NULL);
+    s->free_page_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                      balloon_stop_free_page_report, s);
+}
+
 static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
@@ -332,6 +392,7 @@ static void virtio_balloon_handle_free_pages(VirtIODevice *vdev, VirtQueue *vq)
                 atomic_set(&dev->free_page_report_status,
                            FREE_PAGE_REPORT_S_IN_PROGRESS);
             } else {
+                dev->host_stop_free_page = false;
                 atomic_set(&dev->free_page_report_status,
                            FREE_PAGE_REPORT_S_STOP);
             }
@@ -386,6 +447,10 @@ static void virtio_balloon_free_page_stop(void *opaque)
         return;
     }
 
+    if (dev->free_page_wait_time) {
+        balloon_free_page_change_timer(dev, dev->free_page_wait_time);
+    }
+
     /* Wait till a stop sign is received from the guest */
     while (atomic_read(&dev->free_page_report_status) !=
            FREE_PAGE_REPORT_S_STOP)
@@ -399,7 +464,19 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
-    config.free_page_report_cmd_id = cpu_to_le32(dev->free_page_report_cmd_id);
+    if (dev->host_stop_free_page) {
+        /*
+         * Host is actively requesting to stop the free page report, send the
+         * stop sign to the guest. This happens when the migration thread has
+         * reached the phase to send pages to the destination while the guest
+         * hasn't done the reporting.
+         */
+        config.free_page_report_cmd_id =
+                                    VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID;
+    } else {
+        config.free_page_report_cmd_id =
+                                    cpu_to_le32(dev->free_page_report_cmd_id);
+    }
 
     trace_virtio_balloon_get_config(config.num_pages, config.actual);
     memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
@@ -526,6 +603,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
         s->free_page_vq = virtio_add_queue(vdev, 128,
                                            virtio_balloon_handle_free_pages);
         atomic_set(&s->free_page_report_status, FREE_PAGE_REPORT_S_STOP);
+        s->host_stop_free_page = false;
     }
     reset_stats(s);
 }
@@ -597,6 +675,11 @@ static void virtio_balloon_instance_init(Object *obj)
                         balloon_stats_get_poll_interval,
                         balloon_stats_set_poll_interval,
                         NULL, s, NULL);
+
+    object_property_add(obj, "free-page-wait-time", "int",
+                        balloon_free_page_get_wait_time,
+                        balloon_free_page_set_wait_time,
+                        NULL, s, NULL);
 }
 
 static const VMStateDescription vmstate_virtio_balloon = {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6c75cca..3345104 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2250,6 +2250,9 @@ static void virtio_balloon_pci_instance_init(Object *obj)
     object_property_add_alias(obj, "guest-stats-polling-interval",
                               OBJECT(&dev->vdev),
                               "guest-stats-polling-interval", &error_abort);
+    object_property_add_alias(obj, "free-page-wait-time",
+                              OBJECT(&dev->vdev),
+                              "free-page-wait-time", &error_abort);
 }
 
 static const TypeInfo virtio_balloon_pci_info = {
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index b84b4af..268f7d6 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -37,6 +37,8 @@ typedef struct virtio_balloon_stat_modern {
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
     VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    /* The host is requesting the guest to stop free page reporting */
+    bool host_stop_free_page;
     uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;
@@ -45,8 +47,10 @@ typedef struct VirtIOBalloon {
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
     QEMUTimer *stats_timer;
+    QEMUTimer *free_page_timer;
     int64_t stats_last_update;
     int64_t stats_poll_interval;
+    int64_t free_page_wait_time;
     uint32_t host_features;
 } VirtIOBalloon;
 
-- 
1.8.3.1
