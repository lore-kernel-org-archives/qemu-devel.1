Received: from eggs.gnu.org ([209.51.188.92]:51174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gizWu-0004am-R4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gizWt-0001JA-Sx
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:31:40 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 14 Jan 2019 11:31:07 +0100
Message-Id: <20190114103110.10909-4-david@redhat.com>
In-Reply-To: <20190114103110.10909-1-david@redhat.com>
References: <20190114103110.10909-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] s390x/pci: Always delete and free the
 release_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

We should always get rid of it. I don't see a reason to keep the timer
alive if the devices are going away. This looks like a memory leak.

(hmp) device_add virtio-mouse-pci,id=test
(hmp) device_del test
-> guest notified, timer pending.
-> guest does not react for some reason (e.g. crash)
-> s390_pcihost_timer_cb(). Timer not pending anymore. qmp_unplug().

-> Device deleted. Timer expired (not pending) but not freed.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 1775388524..59325cae3b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -982,7 +982,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (pbdev->release_timer && timer_pending(pbdev->release_timer)) {
+    if (pbdev->release_timer) {
         timer_del(pbdev->release_timer);
         timer_free(pbdev->release_timer);
         pbdev->release_timer = NULL;
-- 
2.17.2
