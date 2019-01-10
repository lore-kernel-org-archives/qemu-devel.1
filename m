Received: from eggs.gnu.org ([209.51.188.92]:52087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghhgJ-0004oJ-Tv
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 16:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghhUn-0004e7-06
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 16:04:09 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 10 Jan 2019 22:03:58 +0100
Message-Id: <20190110210358.24035-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] s390x/pci: Send correct event on hotplug.
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

Comit 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
changed the initial state of zPCI devices from ZPCI_FS_STANDBY to
ZPCI_FS_DISABLED (a.k.a. configured). However we still only send a
HP_EVENT_RESERVED_TO_STANDBY event to the guest, indicating a wrong
state.

Let's send a HP_EVENT_TO_CONFIGURED event instead, to match the actual
state the device is in.

This fixes hotplugged devices having to be enabled explicitly in the
guest e.g. via echo 1 > /sys/bus/pci/slots/00000000/power.

Fixes: 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
Report-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 15759b6514..7f911b216a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -899,7 +899,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         }
 
         if (dev->hotplugged) {
-            s390_pci_generate_plug_event(HP_EVENT_RESERVED_TO_STANDBY,
+            s390_pci_generate_plug_event(HP_EVENT_TO_CONFIGURED ,
                                          pbdev->fh, pbdev->fid);
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
-- 
2.17.2
