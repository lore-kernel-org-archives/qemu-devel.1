Received: from eggs.gnu.org ([2001:4830:134:3::10]:60855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqZ0Y-0007Mo-C1
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 01:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqZ0S-00059e-Mo
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 01:45:02 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Feb 2018 07:44:44 +0100
Message-Id: <1519713884-2346-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/libqos: Check for valid dev pointer when
 looking for PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

dev could be NULL if the PCI device can not be found due to some
reasons, so we must not dereference the pointer in this case.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/virtio-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 7ac15c0..550dede 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -315,7 +315,9 @@ QVirtioPCIDevice *qvirtio_pci_device_find(QPCIBus *bus, uint16_t device_type)
     qvirtio_pci_foreach(bus, device_type, false, 0,
                         qvirtio_pci_assign_device, &dev);
 
-    dev->vdev.bus = &qvirtio_pci;
+    if (dev) {
+        dev->vdev.bus = &qvirtio_pci;
+    }
 
     return dev;
 }
-- 
1.8.3.1
