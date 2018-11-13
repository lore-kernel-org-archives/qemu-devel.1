Received: from eggs.gnu.org ([2001:4830:134:3::10]:40467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gMXdU-0006K7-QW
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gMXdN-0003RK-GF
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:17:38 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 13 Nov 2018 13:17:10 +0100
Message-Id: <20181113121710.18490-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2] s390x/pci: properly fail if the zPCI device
 cannot be created
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

Right now, errors during realize()/pre_plug/plug of the zPCI device
would result in QEMU crashing instead of failing nicely when creating
a zPCI device for a PCI device.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Fix setting of "target" property (key and value was inverted)

 hw/s390x/s390-pci-bus.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e42e1b80d6..060ff062bc 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -780,17 +780,31 @@ static void s390_pci_msix_free(S390PCIBusDevice *pbdev)
 }
 
 static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
-                                             const char *target)
+                                             const char *target, Error **errp)
 {
-    DeviceState *dev = NULL;
+    Error *local_err = NULL;
+    DeviceState *dev;
 
     dev = qdev_try_create(BUS(s->bus), TYPE_S390_PCI_DEVICE);
     if (!dev) {
+        error_setg(errp, "zPCI device could not be created");
         return NULL;
     }
 
-    qdev_prop_set_string(dev, "target", target);
-    qdev_init_nofail(dev);
+    object_property_set_str(OBJECT(dev), target, "target", &local_err);
+    if (local_err) {
+        object_unparent(OBJECT(dev));
+        error_propagate_prepend(errp, local_err,
+                                "zPCI device could not be created: ");
+        return NULL;
+    }
+    object_property_set_bool(OBJECT(dev), true, "realized", &local_err);
+    if (local_err) {
+        object_unparent(OBJECT(dev));
+        error_propagate_prepend(errp, local_err,
+                                "zPCI device could not be created: ");
+        return NULL;
+    }
 
     return S390_PCI_DEVICE(dev);
 }
@@ -865,9 +879,8 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
 
         pbdev = s390_pci_find_dev_by_target(s, dev->id);
         if (!pbdev) {
-            pbdev = s390_pci_device_new(s, dev->id);
+            pbdev = s390_pci_device_new(s, dev->id, errp);
             if (!pbdev) {
-                error_setg(errp, "create zpci device failed");
                 return;
             }
         }
-- 
2.17.2
