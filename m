Received: from eggs.gnu.org ([2001:4830:134:3::10]:48172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyL-0007Lk-Aa
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyJ-0006Ml-EK
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyH-0006KT-Vq
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id 206-v6so1557163wmb.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:40 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:47 +0200
Message-Id: <1539894735-14232-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/48] call HotplugHandler->plug() as the last
 step in device realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

When [2] was fixed it was agreed that adding and calling post_plug()
callback after device_reset() was low risk approach to hotfix issue
right before release. So it was merged instead of moving already
existing plug() callback after device_reset() is called which would
be more risky and require all plug() callbacks audit.

Looking at the current plug() callbacks, it doesn't seem that moving
plug() callback after device_reset() is breaking anything, so here
goes agreed upon [3] proper fix which essentially reverts [1][2]
and moves plug() callback after device_reset().
This way devices always comes to plug() stage, after it's been fully
initialized (including being reset), which fixes race condition [2]
without need for an extra post_plug() callback.

 1. (25e897881 "qdev: add HotplugHandler->post_plug() callback")
 2. (8449bcf94 "virtio-scsi: fix hotplug ->reset() vs event race")
 3. https://www.mail-archive.com/qemu-devel@nongnu.org/msg549915.html

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Pierre Morel<pmorel@linux.ibm.com>
Acked-by: Pierre Morel<pmorel@linux.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/hotplug.c     | 10 ----------
 hw/core/qdev.c        | 16 ++++++----------
 hw/scsi/virtio-scsi.c | 11 +----------
 include/hw/hotplug.h  | 11 -----------
 4 files changed, 7 insertions(+), 41 deletions(-)

diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 2253072..17ac986 100644
--- a/hw/core/hotplug.c
+++ b/hw/core/hotplug.c
@@ -35,16 +35,6 @@ void hotplug_handler_plug(HotplugHandler *plug_handler,
     }
 }
 
-void hotplug_handler_post_plug(HotplugHandler *plug_handler,
-                               DeviceState *plugged_dev)
-{
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
-
-    if (hdc->post_plug) {
-        hdc->post_plug(plug_handler, plugged_dev);
-    }
-}
-
 void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
                                     DeviceState *plugged_dev,
                                     Error **errp)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 046d8f1..6b3cc55 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -832,14 +832,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
 
         DEVICE_LISTENER_CALL(realize, Forward, dev);
 
-        if (hotplug_ctrl) {
-            hotplug_handler_plug(hotplug_ctrl, dev, &local_err);
-        }
-
-        if (local_err != NULL) {
-            goto post_realize_fail;
-        }
-
         /*
          * always free/re-initialize here since the value cannot be cleaned up
          * in device_unrealize due to its usage later on in the unplug path
@@ -869,8 +861,12 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         dev->pending_deleted_event = false;
 
         if (hotplug_ctrl) {
-            hotplug_handler_post_plug(hotplug_ctrl, dev);
-        }
+            hotplug_handler_plug(hotplug_ctrl, dev, &local_err);
+            if (local_err != NULL) {
+                goto child_realize_fail;
+            }
+       }
+
     } else if (!value && dev->realized) {
         Error **local_errp = NULL;
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 5a3057d..3aa9971 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -797,16 +797,8 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         virtio_scsi_acquire(s);
         blk_set_aio_context(sd->conf.blk, s->ctx);
         virtio_scsi_release(s);
-    }
-}
 
-/* Announce the new device after it has been plugged */
-static void virtio_scsi_post_hotplug(HotplugHandler *hotplug_dev,
-                                     DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(hotplug_dev);
-    VirtIOSCSI *s = VIRTIO_SCSI(vdev);
-    SCSIDevice *sd = SCSI_DEVICE(dev);
+    }
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
         virtio_scsi_acquire(s);
@@ -976,7 +968,6 @@ static void virtio_scsi_class_init(ObjectClass *klass, void *data)
     vdc->start_ioeventfd = virtio_scsi_dataplane_start;
     vdc->stop_ioeventfd = virtio_scsi_dataplane_stop;
     hc->plug = virtio_scsi_hotplug;
-    hc->post_plug = virtio_scsi_post_hotplug;
     hc->unplug = virtio_scsi_hotunplug;
 }
 
diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
index 51541d6..1a0516a 100644
--- a/include/hw/hotplug.h
+++ b/include/hw/hotplug.h
@@ -47,8 +47,6 @@ typedef void (*hotplug_fn)(HotplugHandler *plug_handler,
  * @parent: Opaque parent interface.
  * @pre_plug: pre plug callback called at start of device.realize(true)
  * @plug: plug callback called at end of device.realize(true).
- * @post_plug: post plug callback called after device.realize(true) and device
- *             reset
  * @unplug_request: unplug request callback.
  *                  Used as a means to initiate device unplug for devices that
  *                  require asynchronous unplug handling.
@@ -63,7 +61,6 @@ typedef struct HotplugHandlerClass {
     /* <public> */
     hotplug_fn pre_plug;
     hotplug_fn plug;
-    void (*post_plug)(HotplugHandler *plug_handler, DeviceState *plugged_dev);
     hotplug_fn unplug_request;
     hotplug_fn unplug;
 } HotplugHandlerClass;
@@ -87,14 +84,6 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
                               Error **errp);
 
 /**
- * hotplug_handler_post_plug:
- *
- * Call #HotplugHandlerClass.post_plug callback of @plug_handler.
- */
-void hotplug_handler_post_plug(HotplugHandler *plug_handler,
-                               DeviceState *plugged_dev);
-
-/**
  * hotplug_handler_unplug_request:
  *
  * Calls #HotplugHandlerClass.unplug_request callback of @plug_handler.
-- 
1.8.3.1
