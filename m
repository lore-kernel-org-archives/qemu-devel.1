Received: from eggs.gnu.org ([2001:4830:134:3::10]:57536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d0uEn-0001sC-Vk
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d0uEn-0003rT-3R
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:21:57 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:33615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgnyang@gmail.com>) id 1d0uEm-0003rI-V9
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:21:57 -0400
Received: by mail-io0-x241.google.com with SMTP id k87so5889329ioi.0
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 11:21:56 -0700 (PDT)
From: Zihan Yang <tgnyang@gmail.com>
Date: Thu, 20 Apr 2017 02:21:30 +0800
Message-Id: <1492626091-30531-2-git-send-email-tgnyang@gmail.com>
In-Reply-To: <1492626091-30531-1-git-send-email-tgnyang@gmail.com>
References: <1492626091-30531-1-git-send-email-tgnyang@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] hw/s390x: make virtio_ccw_exit function in
 virtio-ccw return void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <tgnyang@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>

    Note that only the virtio_ccw_exit, which is the exit function
    of VirtIOCCWDeviceClass, is modified to return void in this patch.
    'virtio_ccw_busdev_exit' belongs to DeviceClass so it remains
    unchanged for the moment to give a split-out patch, because
    modifying it would involve some other folders like hw/audio.

Signed-off-by: Zihan Yang <tgnyang@gmail.com>
---
 hw/s390x/event-facility.c | 6 +-----
 hw/s390x/virtio-ccw.c     | 6 +++---
 hw/s390x/virtio-ccw.h     | 2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 34b2faf..f7c509c 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -413,11 +413,7 @@ static void event_unrealize(DeviceState *qdev, Error **errp)
     SCLPEvent *event = SCLP_EVENT(qdev);
     SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
     if (child->exit) {
-        int rc = child->exit(event);
-        if (rc < 0) {
-            error_setg(errp, "SCLP event exit failed.");
-            return;
-        }
+        child->exit(event);
     }
 }
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 00b3bde..0dbd3ee 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -722,7 +722,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
     }
 }
 
-static int virtio_ccw_exit(VirtioCcwDevice *dev)
+static void virtio_ccw_exit(VirtioCcwDevice *dev)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     SubchDev *sch = ccw_dev->sch;
@@ -735,7 +735,6 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
         release_indicator(&dev->routes.adapter, dev->indicators);
         dev->indicators = NULL;
     }
-    return 0;
 }
 
 static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **errp)
@@ -1621,7 +1620,8 @@ static int virtio_ccw_busdev_exit(DeviceState *dev)
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
     VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
 
-    return _info->exit(_dev);
+    _info->exit(_dev);
+    return 0; /* TODO workaround, should remove once converted to unrealize */
 }
 
 static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 41d4010..ce8baa3 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -74,7 +74,7 @@ typedef struct VirtioCcwDevice VirtioCcwDevice;
 typedef struct VirtIOCCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(VirtioCcwDevice *dev, Error **errp);
-    int (*exit)(VirtioCcwDevice *dev);
+    void (*exit)(VirtioCcwDevice *dev);
 } VirtIOCCWDeviceClass;
 
 /* Performance improves when virtqueue kick processing is decoupled from the
-- 
2.7.4
