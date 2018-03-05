Received: from eggs.gnu.org ([2001:4830:134:3::10]:49056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1esmbc-0005e1-NV
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1esmbb-00066H-V2
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:40:28 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  5 Mar 2018 09:40:04 +0000
Message-Id: <20180305094006.21446-5-stefanha@redhat.com>
In-Reply-To: <20180305094006.21446-1-stefanha@redhat.com>
References: <20180305094006.21446-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] tests/libqos: Check for valid dev pointer
 when looking for PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Thomas Huth <thuth@redhat.com>

dev could be NULL if the PCI device can not be found due to some
reasons, so we must not dereference the pointer in this case.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1519713884-2346-1-git-send-email-thuth@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 7ac15c04e1..550dede0a2 100644
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
2.14.3
