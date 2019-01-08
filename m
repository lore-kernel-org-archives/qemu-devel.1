Received: from eggs.gnu.org ([209.51.188.92]:52183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1ggt3c-0007PD-DH
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:12:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1ggt3V-0007EE-Ae
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:12:41 -0500
From: Li Qiang <liq3ea@163.com>
Date: Tue,  8 Jan 2019 07:11:14 -0800
Message-Id: <20190108151114.33140-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v3] s390: avoid potential null dereference
 ins390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

When getting the 'pbdev', the if...else has no default branch.
>From Coverity, the 'pbdev' maybe null when the 'dev' is not
the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
This patch adds a default branch for device plug and unplug.

Spotted by Coverity: CID 1398593

Signed-off-by: Li Qiang <liq3ea@163.com>
---

Change since v2: use g_assert_not_reached for default branch

 hw/s390x/s390-pci-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 15759b6514..a94700a78c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -912,6 +912,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->fh = pbdev->idx;
         QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
         g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
+    } else {
+        g_assert_not_reached();
     }
 }
 
@@ -956,6 +958,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
         pci_dev = pbdev->pdev;
+    } else {
+        g_assert_not_reached();
     }
 
     switch (pbdev->state) {
-- 
2.17.1
