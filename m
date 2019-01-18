Received: from eggs.gnu.org ([209.51.188.92]:52228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7a-0004wJ-W7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7a-0001Fd-48
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:38 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:15 +0100
Message-Id: <20190118121925.24468-2-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/11] s390: avoid potential null dereference in
 s390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>, Cornelia Huck <cohuck@redhat.com>

From: Li Qiang <liq3ea@163.com>

When getting the 'pbdev', the if...else has no default branch.
>From Coverity, the 'pbdev' maybe null when the 'dev' is not
the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
This patch adds a default branch for device plug and unplug.

Spotted by Coverity: CID 1398593

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190108151114.33140-1-liq3ea@163.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
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
2.17.2
