Received: from eggs.gnu.org ([2001:4830:134:3::10]:48847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d45Vc-0007Zy-SE
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d45VY-0002d5-1N
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:00:28 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgnyang@gmail.com>) id 1d45VX-0002cD-R6
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:00:23 -0400
Received: by mail-pf0-x243.google.com with SMTP id g23so17395348pfj.1
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 06:00:23 -0700 (PDT)
From: Zihan Yang <tgnyang@gmail.com>
Date: Fri, 28 Apr 2017 20:55:09 +0800
Message-Id: <1493384110-32060-3-git-send-email-tgnyang@gmail.com>
In-Reply-To: <1493384110-32060-1-git-send-email-tgnyang@gmail.com>
References: <1493384110-32060-1-git-send-email-tgnyang@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] hw/s390x: make virtio_ccw_exit function in
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
Cc: Zihan Yang <tgnyang@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Only virtio_ccw_exit and the exit callback in VirtIOCCWDeviceClass are
converted to void in this patch. 'virtio_ccw_busdev_exit' belongs to
DeviceClass so it still returns int, DeviceClass::exit will return
void in future patches.

Signed-off-by: Zihan Yang <tgnyang@gmail.com>
---
 hw/s390x/virtio-ccw.c | 6 +++---
 hw/s390x/virtio-ccw.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index e7167e3..91b43ac 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -731,7 +731,7 @@ out_err:
     g_free(sch);
 }
 
-static int virtio_ccw_exit(VirtioCcwDevice *dev)
+static void virtio_ccw_exit(VirtioCcwDevice *dev)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     SubchDev *sch = ccw_dev->sch;
@@ -744,7 +744,6 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
         release_indicator(&dev->routes.adapter, dev->indicators);
         dev->indicators = NULL;
     }
-    return 0;
 }
 
 static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **errp)
@@ -1627,7 +1626,8 @@ static int virtio_ccw_busdev_exit(DeviceState *dev)
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
     VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
 
-    return _info->exit(_dev);
+    _info->exit(_dev);
+    return 0;
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
