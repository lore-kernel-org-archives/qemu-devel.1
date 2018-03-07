Received: from eggs.gnu.org ([2001:4830:134:3::10]:42775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1etXWn-0006DI-91
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1etXWl-00024c-2T
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:46:36 -0500
From: Sergio Lopez <slp@redhat.com>
Date: Wed,  7 Mar 2018 12:44:59 +0100
Message-Id: <20180307114459.26636-1-slp@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-blk: dataplane: Don't batch
 notifications if EVENT_IDX is present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>

Commit 5b2ffbe4d99843fd8305c573a100047a8c962327 ("virtio-blk: dataplane:
notify guest as a batch") deferred guest notification to a BH in order
batch notifications, with purpose of avoiding flooding the guest with
interruptions.

This optimization came with a cost. The average latency perceived in the
guest is increased by a few microseconds, but also when multiple IO
operations finish at the same time, the guest won't be notified until
all completions from each operation has been run. On the contrary,
virtio-scsi issues the notification at the end of each completion.

On the other hand, nowadays we have the EVENT_IDX feature that allows a
better coordination between QEMU and the Guest OS to avoid sending
unnecessary interruptions.

With this change, virtio-blk/dataplane only batches notifications if the
EVENT_IDX feature is not present.

Some numbers obtained with fio (ioengine=sync, iodepth=1, direct=1):
 - Test specs:
   * fio-3.4 (ioengine=sync, iodepth=1, direct=1)
   * qemu master
   * virtio-blk with a dedicated iothread (default poll-max-ns)
   * backend: null_blk nr_devices=1 irqmode=2 completion_nsec=280000
   * 8 vCPUs pinned to isolated physical cores
   * Emulator and iothread also pinned to separate isolated cores
   * variance between runs < 1%

 - Not patched
   * numjobs=1:  lat_avg=327.32  irqs=29998
   * numjobs=4:  lat_avg=337.89  irqs=29073
   * numjobs=8:  lat_avg=342.98  irqs=28643

 - Patched:
   * numjobs=1:  lat_avg=323.92  irqs=30262
   * numjobs=4:  lat_avg=332.65  irqs=29520
   * numjobs=8:  lat_avg=335.54  irqs=29323

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 2cb990997e..c46253a924 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -34,6 +34,7 @@ struct VirtIOBlockDataPlane {
     VirtIODevice *vdev;
     QEMUBH *bh;                     /* bh for guest notification */
     unsigned long *batch_notify_vqs;
+    bool batch_notifications;
 
     /* Note that these EventNotifiers are assigned by value.  This is
      * fine as long as you do not call event_notifier_cleanup on them
@@ -47,8 +48,12 @@ struct VirtIOBlockDataPlane {
 /* Raise an interrupt to signal guest, if necessary */
 void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq)
 {
-    set_bit(virtio_get_queue_index(vq), s->batch_notify_vqs);
-    qemu_bh_schedule(s->bh);
+    if (s->batch_notifications) {
+        set_bit(virtio_get_queue_index(vq), s->batch_notify_vqs);
+        qemu_bh_schedule(s->bh);
+    } else {
+        virtio_notify_irqfd(s->vdev, vq);
+    }
 }
 
 static void notify_guest_bh(void *opaque)
@@ -177,6 +182,12 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
 
     s->starting = true;
 
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
+        s->batch_notifications = true;
+    } else {
+        s->batch_notifications = false;
+    }
+
     /* Set up guest notifier (irq) */
     r = k->set_guest_notifiers(qbus->parent, nvqs, true);
     if (r != 0) {
-- 
2.14.3
