Received: from eggs.gnu.org ([208.118.235.92]:57612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf3bd-0007u8-Ra
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf3bd-0005m8-3F
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:04:17 -0500
From: Li Qiang <liq3ea@163.com>
Date: Thu,  3 Jan 2019 06:02:46 -0800
Message-Id: <20190103140246.50791-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] s390: avoid potential null dereference in
 s390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com, rth@twiddle.net, david@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, Li Qiang <liq3ea@163.com>

When getting the 'pbdev', the if...else has no default branch.
>From Coverity, the 'pbdev' maybe null when the 'dev' is not
the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.

Spotted by Coverity: CID 1398593

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/s390x/s390-pci-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 15759b6514..b3122268a3 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -956,6 +956,10 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
         pci_dev = pbdev->pdev;
+    } else {
+        error_setg(errp, "s390: device unplug for not supported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+        return;
     }
 
     switch (pbdev->state) {
-- 
2.17.1
