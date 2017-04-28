Received: from eggs.gnu.org ([2001:4830:134:3::10]:48892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d45Vj-0007df-9Q
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d45Vd-0002h8-Oy
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:00:35 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgnyang@gmail.com>) id 1d45Vd-0002gD-Is
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:00:29 -0400
Received: by mail-pf0-x243.google.com with SMTP id b23so1473187pfc.0
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 06:00:29 -0700 (PDT)
From: Zihan Yang <tgnyang@gmail.com>
Date: Fri, 28 Apr 2017 20:55:10 +0800
Message-Id: <1493384110-32060-4-git-send-email-tgnyang@gmail.com>
In-Reply-To: <1493384110-32060-1-git-send-email-tgnyang@gmail.com>
References: <1493384110-32060-1-git-send-email-tgnyang@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] hw/s390: replace exit with unrealize
 during class init of virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <tgnyang@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

Currently the virtio_ccw_device_class_init function sets dc->exit, which is
the exit callback of DeviceClass. It should be converted to dc->unrealize
since exit callback of DeviceClass will be removed in the future.

Signed-off-by: Zihan Yang <tgnyang@gmail.com>
---
 hw/s390x/virtio-ccw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 91b43ac..5c193a8 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1621,13 +1621,12 @@ static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
     virtio_ccw_device_realize(_dev, errp);
 }
 
-static int virtio_ccw_busdev_exit(DeviceState *dev)
+static void virtio_ccw_busdev_unrealize(DeviceState *dev, Error **errp)
 {
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
     VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
 
     _info->exit(_dev);
-    return 0;
 }
 
 static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
@@ -1645,7 +1644,7 @@ static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
 
     k->unplug = virtio_ccw_busdev_unplug;
     dc->realize = virtio_ccw_busdev_realize;
-    dc->exit = virtio_ccw_busdev_exit;
+    dc->unrealize = virtio_ccw_busdev_unrealize;
     dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
 }
 
-- 
2.7.4
