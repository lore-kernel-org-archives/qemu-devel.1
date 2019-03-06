Received: from eggs.gnu.org ([209.51.188.92]:43863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1UxX-0006jp-Hz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1UxV-0005XQ-HZ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1UxV-0005X9-7V
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:37 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Mar 2019 11:42:24 +0000
Message-Id: <20190306114227.9125-20-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-1-dgilbert@redhat.com>
References: <20190306114227.9125-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/22] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com
Cc: eblake@redhat.com, armbru@redhat.com

From: Wei Wang <wei.w.wang@intel.com>

The new feature enables the virtio-balloon device to receive hints of
guest free pages from the free page vq.

A notifier is registered to the migration precopy notifier chain. The
notifier calls free_page_start after the migration thread syncs the dirty
bitmap, so that the free page optimization starts to clear bits of free
pages from the bitmap. It calls the free_page_stop before the migration
thread syncs the bitmap, which is the end of the current round of ram
save. The free_page_stop is also called to stop the optimization in the
case when there is an error occurred in the process of ram saving.

Note: balloon will report pages which were free at the time of this call.
As the reporting happens asynchronously, dirty bit logging must be
enabled before this free_page_start call is made. Guest reporting must be
disabled before the migration dirty bitmap is synchronized.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Message-Id: <1544516693-5395-8-git-send-email-wei.w.wang@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  dgilbert: Dropped kernel header update, fixed up CMD_ID_* name change
---
 hw/virtio/virtio-balloon.c         | 263 +++++++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h |  28 ++-
 2 files changed, 290 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d3f2913a85..e3a65940ef 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -27,6 +27,7 @@
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "migration/misc.h"
=20
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
@@ -378,6 +379,184 @@ out:
     }
 }
=20
+static void virtio_balloon_handle_free_page_vq(VirtIODevice *vdev,
+                                               VirtQueue *vq)
+{
+    VirtIOBalloon *s =3D VIRTIO_BALLOON(vdev);
+    qemu_bh_schedule(s->free_page_bh);
+}
+
+static bool get_free_page_hints(VirtIOBalloon *dev)
+{
+    VirtQueueElement *elem;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtQueue *vq =3D dev->free_page_vq;
+
+    while (dev->block_iothread) {
+        qemu_cond_wait(&dev->free_page_cond, &dev->free_page_lock);
+    }
+
+    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return false;
+    }
+
+    if (elem->out_num) {
+        uint32_t id;
+        size_t size =3D iov_to_buf(elem->out_sg, elem->out_num, 0,
+                                 &id, sizeof(id));
+        virtqueue_push(vq, elem, size);
+        g_free(elem);
+
+        virtio_tswap32s(vdev, &id);
+        if (unlikely(size !=3D sizeof(id))) {
+            virtio_error(vdev, "received an incorrect cmd id");
+            return false;
+        }
+        if (id =3D=3D dev->free_page_report_cmd_id) {
+            dev->free_page_report_status =3D FREE_PAGE_REPORT_S_START;
+        } else {
+            /*
+             * Stop the optimization only when it has started. This
+             * avoids a stale stop sign for the previous command.
+             */
+            if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_S=
TART) {
+                dev->free_page_report_status =3D FREE_PAGE_REPORT_S_STOP=
;
+            }
+        }
+    }
+
+    if (elem->in_num) {
+        if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_START=
) {
+            qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
+                                      elem->in_sg[0].iov_len);
+        }
+        virtqueue_push(vq, elem, 1);
+        g_free(elem);
+    }
+
+    return true;
+}
+
+static void virtio_ballloon_get_free_page_hints(void *opaque)
+{
+    VirtIOBalloon *dev =3D opaque;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtQueue *vq =3D dev->free_page_vq;
+    bool continue_to_get_hints;
+
+    do {
+        qemu_mutex_lock(&dev->free_page_lock);
+        virtio_queue_set_notification(vq, 0);
+        continue_to_get_hints =3D get_free_page_hints(dev);
+        qemu_mutex_unlock(&dev->free_page_lock);
+        virtio_notify(vdev, vq);
+      /*
+       * Start to poll the vq once the reporting started. Otherwise, con=
tinue
+       * only when there are entries on the vq, which need to be given b=
ack.
+       */
+    } while (continue_to_get_hints ||
+             dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_STAR=
T);
+    virtio_queue_set_notification(vq, 1);
+}
+
+static bool virtio_balloon_free_page_support(void *opaque)
+{
+    VirtIOBalloon *s =3D opaque;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT=
);
+}
+
+static void virtio_balloon_free_page_start(VirtIOBalloon *s)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
+
+    /* For the stop and copy phase, we don't need to start the optimizat=
ion */
+    if (!vdev->vm_running) {
+        return;
+    }
+
+    if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
+        s->free_page_report_cmd_id =3D
+                       VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
+    } else {
+        s->free_page_report_cmd_id++;
+    }
+
+    s->free_page_report_status =3D FREE_PAGE_REPORT_S_REQUESTED;
+    virtio_notify_config(vdev);
+}
+
+static void virtio_balloon_free_page_stop(VirtIOBalloon *s)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
+
+    if (s->free_page_report_status !=3D FREE_PAGE_REPORT_S_STOP) {
+        /*
+         * The lock also guarantees us that the
+         * virtio_ballloon_get_free_page_hints exits after the
+         * free_page_report_status is set to S_STOP.
+         */
+        qemu_mutex_lock(&s->free_page_lock);
+        /*
+         * The guest hasn't done the reporting, so host sends a notifica=
tion
+         * to the guest to actively stop the reporting.
+         */
+        s->free_page_report_status =3D FREE_PAGE_REPORT_S_STOP;
+        qemu_mutex_unlock(&s->free_page_lock);
+        virtio_notify_config(vdev);
+    }
+}
+
+static void virtio_balloon_free_page_done(VirtIOBalloon *s)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
+
+    s->free_page_report_status =3D FREE_PAGE_REPORT_S_DONE;
+    virtio_notify_config(vdev);
+}
+
+static int
+virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data=
)
+{
+    VirtIOBalloon *dev =3D container_of(n, VirtIOBalloon,
+                                      free_page_report_notify);
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    PrecopyNotifyData *pnd =3D data;
+
+    if (!virtio_balloon_free_page_support(dev)) {
+        /*
+         * This is an optimization provided to migration, so just return=
 0 to
+         * have the normal migration process not affected when this feat=
ure is
+         * not supported.
+         */
+        return 0;
+    }
+
+    switch (pnd->reason) {
+    case PRECOPY_NOTIFY_SETUP:
+        precopy_enable_free_page_optimization();
+        break;
+    case PRECOPY_NOTIFY_COMPLETE:
+    case PRECOPY_NOTIFY_CLEANUP:
+    case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
+        virtio_balloon_free_page_stop(dev);
+        break;
+    case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
+        if (vdev->vm_running) {
+            virtio_balloon_free_page_start(dev);
+        } else {
+            virtio_balloon_free_page_done(dev);
+        }
+        break;
+    default:
+        virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reaso=
n);
+    }
+
+    return 0;
+}
+
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *confi=
g_data)
 {
     VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
@@ -386,6 +565,17 @@ static void virtio_balloon_get_config(VirtIODevice *=
vdev, uint8_t *config_data)
     config.num_pages =3D cpu_to_le32(dev->num_pages);
     config.actual =3D cpu_to_le32(dev->actual);
=20
+    if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_REQUESTED=
) {
+        config.free_page_report_cmd_id =3D
+                       cpu_to_le32(dev->free_page_report_cmd_id);
+    } else if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_ST=
OP) {
+        config.free_page_report_cmd_id =3D
+                       cpu_to_le32(VIRTIO_BALLOON_CMD_ID_STOP);
+    } else if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_DO=
NE) {
+        config.free_page_report_cmd_id =3D
+                       cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
+    }
+
     trace_virtio_balloon_get_config(config.num_pages, config.actual);
     memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
 }
@@ -446,6 +636,7 @@ static uint64_t virtio_balloon_get_features(VirtIODev=
ice *vdev, uint64_t f,
     VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
     f |=3D dev->host_features;
     virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
+
     return f;
 }
=20
@@ -482,6 +673,18 @@ static int virtio_balloon_post_load_device(void *opa=
que, int version_id)
     return 0;
 }
=20
+static const VMStateDescription vmstate_virtio_balloon_free_page_report =
=3D {
+    .name =3D "virtio-balloon-device/free-page-report",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D virtio_balloon_free_page_support,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
+        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_balloon_device =3D {
     .name =3D "virtio-balloon-device",
     .version_id =3D 1,
@@ -492,6 +695,10 @@ static const VMStateDescription vmstate_virtio_ballo=
on_device =3D {
         VMSTATE_UINT32(actual, VirtIOBalloon),
         VMSTATE_END_OF_LIST()
     },
+    .subsections =3D (const VMStateDescription * []) {
+        &vmstate_virtio_balloon_free_page_report,
+        NULL
+    }
 };
=20
 static void virtio_balloon_device_realize(DeviceState *dev, Error **errp=
)
@@ -516,6 +723,29 @@ static void virtio_balloon_device_realize(DeviceStat=
e *dev, Error **errp)
     s->dvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output)=
;
     s->svq =3D virtio_add_queue(vdev, 128, virtio_balloon_receive_stats)=
;
=20
+    if (virtio_has_feature(s->host_features,
+                           VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        s->free_page_vq =3D virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
+                                           virtio_balloon_handle_free_pa=
ge_vq);
+        s->free_page_report_status =3D FREE_PAGE_REPORT_S_STOP;
+        s->free_page_report_cmd_id =3D
+                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
+        s->free_page_report_notify.notify =3D
+                                       virtio_balloon_free_page_report_n=
otify;
+        precopy_add_notifier(&s->free_page_report_notify);
+        if (s->iothread) {
+            object_ref(OBJECT(s->iothread));
+            s->free_page_bh =3D aio_bh_new(iothread_get_aio_context(s->i=
othread),
+                                       virtio_ballloon_get_free_page_hin=
ts, s);
+            qemu_mutex_init(&s->free_page_lock);
+            qemu_cond_init(&s->free_page_cond);
+            s->block_iothread =3D false;
+        } else {
+            /* Simply disable this feature if the iothread wasn't create=
d. */
+            s->host_features &=3D ~(1 << VIRTIO_BALLOON_F_FREE_PAGE_HINT=
);
+            virtio_error(vdev, "iothread is missing");
+        }
+    }
     reset_stats(s);
 }
=20
@@ -524,6 +754,11 @@ static void virtio_balloon_device_unrealize(DeviceSt=
ate *dev, Error **errp)
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOBalloon *s =3D VIRTIO_BALLOON(dev);
=20
+    if (virtio_balloon_free_page_support(s)) {
+        qemu_bh_delete(s->free_page_bh);
+        virtio_balloon_free_page_stop(s);
+        precopy_remove_notifier(&s->free_page_report_notify);
+    }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
     virtio_cleanup(vdev);
@@ -533,6 +768,10 @@ static void virtio_balloon_device_reset(VirtIODevice=
 *vdev)
 {
     VirtIOBalloon *s =3D VIRTIO_BALLOON(vdev);
=20
+    if (virtio_balloon_free_page_support(s)) {
+        virtio_balloon_free_page_stop(s);
+    }
+
     if (s->stats_vq_elem !=3D NULL) {
         virtqueue_unpop(s->svq, s->stats_vq_elem, 0);
         g_free(s->stats_vq_elem);
@@ -550,6 +789,26 @@ static void virtio_balloon_set_status(VirtIODevice *=
vdev, uint8_t status)
          * was stopped */
         virtio_balloon_receive_stats(vdev, s->svq);
     }
+
+    if (virtio_balloon_free_page_support(s)) {
+        /*
+         * The VM is woken up and the iothread was blocked, so signal it=
 to
+         * continue.
+         */
+        if (vdev->vm_running && s->block_iothread) {
+            qemu_mutex_lock(&s->free_page_lock);
+            s->block_iothread =3D false;
+            qemu_cond_signal(&s->free_page_cond);
+            qemu_mutex_unlock(&s->free_page_lock);
+        }
+
+        /* The VM is stopped, block the iothread. */
+        if (!vdev->vm_running) {
+            qemu_mutex_lock(&s->free_page_lock);
+            s->block_iothread =3D true;
+            qemu_mutex_unlock(&s->free_page_lock);
+        }
+    }
 }
=20
 static void virtio_balloon_instance_init(Object *obj)
@@ -578,6 +837,10 @@ static const VMStateDescription vmstate_virtio_ballo=
on =3D {
 static Property virtio_balloon_properties[] =3D {
     DEFINE_PROP_BIT("deflate-on-oom", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
+    DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
+                     IOThread *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
index 99dcd6d105..1afafb12f6 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -17,11 +17,14 @@
=20
 #include "standard-headers/linux/virtio_balloon.h"
 #include "hw/virtio/virtio.h"
+#include "sysemu/iothread.h"
=20
 #define TYPE_VIRTIO_BALLOON "virtio-balloon-device"
 #define VIRTIO_BALLOON(obj) \
         OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
=20
+#define VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN 0x80000000
+
 typedef struct virtio_balloon_stat VirtIOBalloonStat;
=20
 typedef struct virtio_balloon_stat_modern {
@@ -32,15 +35,38 @@ typedef struct virtio_balloon_stat_modern {
=20
 typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
=20
+enum virtio_balloon_free_page_report_status {
+    FREE_PAGE_REPORT_S_STOP =3D 0,
+    FREE_PAGE_REPORT_S_REQUESTED =3D 1,
+    FREE_PAGE_REPORT_S_START =3D 2,
+    FREE_PAGE_REPORT_S_DONE =3D 3,
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
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
     QEMUTimer *stats_timer;
+    IOThread *iothread;
+    QEMUBH *free_page_bh;
+    /*
+     * Lock to synchronize threads to access the free page reporting rel=
ated
+     * fields (e.g. free_page_report_status).
+     */
+    QemuMutex free_page_lock;
+    QemuCond  free_page_cond;
+    /*
+     * Set to block iothread to continue reading free page hints as the =
VM is
+     * stopped.
+     */
+    bool block_iothread;
+    NotifierWithReturn free_page_report_notify;
     int64_t stats_last_update;
     int64_t stats_poll_interval;
     uint32_t host_features;
--=20
2.20.1
