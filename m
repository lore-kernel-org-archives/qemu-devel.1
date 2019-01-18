Received: from eggs.gnu.org ([209.51.188.92]:52335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7f-0004xl-AG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7e-0001R1-G8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:43 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:19 +0100
Message-Id: <20190118121925.24468-6-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/11] s390x/pci: Send correct event on hotplug
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

Comit 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
changed the initial state of zPCI devices from ZPCI_FS_STANDBY to
ZPCI_FS_DISABLED (a.k.a. configured). However we still only send a
HP_EVENT_RESERVED_TO_STANDBY event to the guest, indicating a wrong
state.

Let's send a HP_EVENT_TO_CONFIGURED event instead, to match the actual
state the device is in.

This fixes hotplugged devices having to be enabled explicitly in the
guest e.g. via echo 1 > /sys/bus/pci/slots/00000000/power.

On real HW, a PCI device always pops up in the STANDBY state. In QEMU,
we decided to let it show up directly in the configured state (as
configuring it is otherwise just an extra burden for the admin). We can
safely bypass the STANDBY state when hotplugging PCI devices to a guest.

Fixes: 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190110210358.24035-1-david@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index a94700a78c..1579989213 100644
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
