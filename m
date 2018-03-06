Received: from eggs.gnu.org ([2001:4830:134:3::10]:37306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1et9Vx-0002CJ-Tj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1et9Vw-0003bE-T8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:08:09 -0500
From: Nia Alarie <nia.alarie@gmail.com>
Date: Tue,  6 Mar 2018 10:07:21 +0000
Message-Id: <20180306100721.19419-2-nia.alarie@gmail.com>
In-Reply-To: <20180306100721.19419-1-nia.alarie@gmail.com>
References: <20180306100721.19419-1-nia.alarie@gmail.com>
Subject: [Qemu-devel] [PATCH v3 2/2] s390x: Change return type of
 virtio_ccw_exit to void.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, Nia Alarie <nia.alarie@gmail.com>

Allows a branch to be removed - this function always returns 0.

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/virtio-ccw.c | 6 +++---
 hw/s390x/virtio-ccw.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 8f7fbc2ab7..0773818a82 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -752,7 +752,7 @@ out_err:
     g_free(sch);
 }
 
-static int virtio_ccw_exit(VirtioCcwDevice *dev)
+static void virtio_ccw_exit(VirtioCcwDevice *dev)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     SubchDev *sch = ccw_dev->sch;
@@ -765,7 +765,6 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
         release_indicator(&dev->routes.adapter, dev->indicators);
         dev->indicators = NULL;
     }
-    return 0;
 }
 
 static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **errp)
@@ -1710,7 +1709,8 @@ static int virtio_ccw_busdev_exit(DeviceState *dev)
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
     VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
 
-    return _info->exit(_dev);
+    _info->exit(_dev);
+    return 0;
 }
 
 static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 3905f3a3d6..8ffe7fe095 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -76,7 +76,7 @@ typedef struct VirtioCcwDevice VirtioCcwDevice;
 typedef struct VirtIOCCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(VirtioCcwDevice *dev, Error **errp);
-    int (*exit)(VirtioCcwDevice *dev);
+    void (*exit)(VirtioCcwDevice *dev);
 } VirtIOCCWDeviceClass;
 
 /* Performance improves when virtqueue kick processing is decoupled from the
-- 
2.16.2
