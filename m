Received: from eggs.gnu.org ([209.51.188.92]:52494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7y-0005ER-2D
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7x-0001rZ-8j
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:20:02 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:23 +0100
Message-Id: <20190118121925.24468-10-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 09/11] s390x/pci: Always delete and free the
 release_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

We should always get rid of it. I don't see a reason to keep the timer
alive if the devices are going away. This looks like a memory leak.

(hmp) device_add virtio-mouse-pci,id=test
(hmp) device_del test
-> guest notified, timer pending.
-> guest does not react for some reason (e.g. crash)
-> s390_pcihost_timer_cb(). Timer not pending anymore. qmp_unplug().

-> Device deleted. Timer expired (not pending) but not freed.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190114103110.10909-4-david@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index c467cc526b..e5a4cf03b2 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -986,7 +986,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (pbdev->release_timer && timer_pending(pbdev->release_timer)) {
+    if (pbdev->release_timer) {
         timer_del(pbdev->release_timer);
         timer_free(pbdev->release_timer);
         pbdev->release_timer = NULL;
-- 
2.17.2
