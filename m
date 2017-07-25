Received: from eggs.gnu.org ([2001:4830:134:3::10]:44087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKX-0001if-9Z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKW-0003Ml-An
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZwKW-0003MN-4Y
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:40 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 25 Jul 2017 11:40:14 +0200
Message-Id: <20170725094026.5376-3-cohuck@redhat.com>
In-Reply-To: <20170725094026.5376-1-cohuck@redhat.com>
References: <20170725094026.5376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 02/14] vfio/ccw: fix initialization of
 the Object DeviceState pointer in the common base-device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

Commit 7da624e2 ("vfio: Test realized when using VFIOGroup.device_list
iterator") introduced a pointer to the Object DeviceState in the VFIO
common base-device and skipped non-realized devices as we iterate
VFIOGroup.device_list. While it missed to initialize the pointer for
the vfio-ccw case. Let's fix it.

Fixes: 7da624e2 ("vfio: Test realized when using VFIOGroup.device_list
                  iterator")

Cc: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Message-Id: <20170718014926.44781-3-bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 8d97b53e77..a8baadf57a 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -338,6 +338,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
     vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
     vcdev->vdev.name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
                                        cdev->hostid.ssid, cdev->hostid.devid);
+    vcdev->vdev.dev = dev;
     QLIST_FOREACH(vbasedev, &group->device_list, next) {
         if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
             error_setg(&err, "vfio: subchannel %s has already been attached",
-- 
2.13.3
