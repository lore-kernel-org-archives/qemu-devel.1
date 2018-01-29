Received: from eggs.gnu.org ([2001:4830:134:3::10]:42734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1egAJ9-0002fl-95
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1egAJ7-0007Wy-Bn
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:21:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1egAJ7-0007Wb-3t
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:21:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A2865B309
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 14:21:12 +0000 (UTC)
From: Gal Hammer <ghammer@redhat.com>
Date: Mon, 29 Jan 2018 16:20:56 +0200
Message-Id: <1517235657-22547-2-git-send-email-ghammer@redhat.com>
In-Reply-To: <1517235657-22547-1-git-send-email-ghammer@redhat.com>
References: <1517235657-22547-1-git-send-email-ghammer@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] virtio: remove event notifier cleanup
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
Cc: mst@redhat.com, Gal Hammer <ghammer@redhat.com>

The virtio_bus_set_host_notifier function no longer calls
event_notifier_cleanup when a event notifier is removed.

The commit updates the code to match the new behavior and calls
virtio_bus_cleanup_host_notifier after the notifier was de-assign
and no longer in use.

This change is a preparation to allow executing the
virtio_bus_set_host_notifier function in a memory region
transaction.

Signed-off-by: Gal Hammer <ghammer@redhat.com>
---
 hw/block/dataplane/virtio-blk.c |  2 ++
 hw/scsi/virtio-scsi-dataplane.c |  2 ++
 hw/virtio/vhost.c               |  2 ++
 hw/virtio/virtio-bus.c          | 14 ++++++++++----
 hw/virtio/virtio.c              |  2 ++
 include/hw/virtio/virtio-bus.h  |  2 ++
 6 files changed, 20 insertions(+), 4 deletions(-)

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
index 386aef8..2ee1f37 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1416,6 +1416,7 @@ fail_vq:
             error_report("vhost VQ %d notifier cleanup error: %d", i, -r);
         }
         assert (e >= 0);
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
     }
     virtio_device_release_ioeventfd(vdev);
 fail:
@@ -1439,6 +1440,7 @@ void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
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
-- 
2.7.5
