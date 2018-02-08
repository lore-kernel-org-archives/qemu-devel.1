Received: from eggs.gnu.org ([2001:4830:134:3::10]:54044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZ8-000612-Um
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZ7-0008Ez-Gs
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:02 -0500
Date: Thu, 8 Feb 2018 21:08:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-3-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 02/26] virtio: remove event notifier cleanup
 call on de-assign
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gal Hammer <ghammer@redhat.com>, Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org

From: Gal Hammer <ghammer@redhat.com>

The virtio_bus_set_host_notifier function no longer calls
event_notifier_cleanup when a event notifier is removed.

The commit updates the code to match the new behavior and calls
virtio_bus_cleanup_host_notifier after the notifier was de-assign
and no longer in use.

This change is a preparation to allow executing the
virtio_bus_set_host_notifier function in a memory region
transaction.

Signed-off-by: Gal Hammer <ghammer@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-bus.h  |  2 ++
 hw/block/dataplane/virtio-blk.c |  2 ++
 hw/scsi/virtio-scsi-dataplane.c |  2 ++
 hw/virtio/vhost.c               |  2 ++
 hw/virtio/virtio-bus.c          | 14 ++++++++++----
 hw/virtio/virtio.c              |  2 ++
 6 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index a63c1d2..ced3d2d 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -148,5 +148,7 @@ int virtio_bus_grab_ioeventfd(VirtioBusState *bus);
 void virtio_bus_release_ioeventfd(VirtioBusState *bus);
 /* Switch from/to the generic ioeventfd handler */
 int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign);
+/* Tell the bus that the ioeventfd handler is no longer required. */
+void virtio_bus_cleanup_host_notifier(VirtioBusState *bus, int n);
 
 #endif /* VIRTIO_BUS_H */
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index f6fc639..2cb9909 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -192,6 +192,7 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
             fprintf(stderr, "virtio-blk failed to set host notifier (%d)\n", r);
             while (i--) {
                 virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
+                virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
             }
             goto fail_guest_notifiers;
         }
@@ -267,6 +268,7 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
 
     for (i = 0; i < nvqs; i++) {
         virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
     }
 
     /* Clean up guest notifier (irq) */
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index add4b3f..1c33322 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -175,6 +175,7 @@ fail_vrings:
     aio_context_release(s->ctx);
     for (i = 0; i < vs->conf.num_queues + 2; i++) {
         virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
     }
     k->set_guest_notifiers(qbus->parent, vs->conf.num_queues + 2, false);
 fail_guest_notifiers:
@@ -213,6 +214,7 @@ void virtio_scsi_dataplane_stop(VirtIODevice *vdev)
 
     for (i = 0; i < vs->conf.num_queues + 2; i++) {
         virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
     }
 
     /* Clean up guest notifier (irq) */
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 23b9e17..56885aa 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1418,6 +1418,7 @@ fail_vq:
             error_report("vhost VQ %d notifier cleanup error: %d", i, -r);
         }
         assert (e >= 0);
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
     }
     virtio_device_release_ioeventfd(vdev);
 fail:
@@ -1441,6 +1442,7 @@ void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
             error_report("vhost VQ %d notifier cleanup failed: %d", i, -r);
         }
         assert (r >= 0);
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
     }
     virtio_device_release_ioeventfd(vdev);
 }
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 3042232..f9bc9ea 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -283,20 +283,26 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
         r = k->ioeventfd_assign(proxy, notifier, n, true);
         if (r < 0) {
             error_report("%s: unable to assign ioeventfd: %d", __func__, r);
-            goto cleanup_event_notifier;
+            virtio_bus_cleanup_host_notifier(bus, n);
         }
-        return 0;
     } else {
         k->ioeventfd_assign(proxy, notifier, n, false);
     }
 
-cleanup_event_notifier:
+    return r;
+}
+
+void virtio_bus_cleanup_host_notifier(VirtioBusState *bus, int n)
+{
+    VirtIODevice *vdev = virtio_bus_get_device(bus);
+    VirtQueue *vq = virtio_get_queue(vdev, n);
+    EventNotifier *notifier = virtio_queue_get_host_notifier(vq);
+
     /* Test and clear notifier after disabling event,
      * in case poll callback didn't have time to run.
      */
     virtio_queue_host_notifier_read(notifier);
     event_notifier_cleanup(notifier);
-    return r;
 }
 
 static char *virtio_bus_get_dev_path(DeviceState *dev)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d6002ee..3667cd6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2608,6 +2608,7 @@ assign_error:
         event_notifier_set_handler(&vq->host_notifier, NULL);
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
+        virtio_bus_cleanup_host_notifier(qbus, n);
     }
     return err;
 }
@@ -2634,6 +2635,7 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
         event_notifier_set_handler(&vq->host_notifier, NULL);
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
+        virtio_bus_cleanup_host_notifier(qbus, n);
     }
 }
 
-- 
MST
