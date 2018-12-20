Received: from eggs.gnu.org ([2001:4830:134:3::10]:60585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3F8-0005iw-0W
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3F5-0001wH-Rs
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3F5-0001tt-GF
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:19 -0500
Date: Thu, 20 Dec 2018 13:40:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-42-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 41/44] pci: Adjust PCI config limit based on
 bus topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Alex Williamson <alex.williamson@redhat.com>

A conventional PCI bus does not support config space accesses above
the standard 256 byte configuration space.  PCIe-to-PCI bridges are
not permitted to forward transactions if the extended register address
field is non-zero and must handle it as an unsupported request (PCIe
bridge spec rev 1.0, 4.1.3, 4.1.4).  Therefore, we should not support
extended config space if there is a conventional bus anywhere on the
path to a device.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci_host.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 5eaa935cb5..5f5345dbac 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bus.h"
 #include "trace.h"
@@ -50,9 +51,29 @@ static inline PCIDevice *pci_dev_find_by_addr(PCIBus *bus, uint32_t addr)
     return pci_find_device(bus, bus_num, devfn);
 }
 
+static void pci_adjust_config_limit(PCIBus *bus, uint32_t *limit)
+{
+    if (*limit > PCI_CONFIG_SPACE_SIZE) {
+        if (!pci_bus_is_express(bus)) {
+            *limit = PCI_CONFIG_SPACE_SIZE;
+            return;
+        }
+
+        if (!pci_bus_is_root(bus)) {
+            PCIDevice *bridge = pci_bridge_get_device(bus);
+            pci_adjust_config_limit(pci_get_bus(bridge), limit);
+        }
+    }
+}
+
 void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
                                   uint32_t limit, uint32_t val, uint32_t len)
 {
+    pci_adjust_config_limit(pci_get_bus(pci_dev), &limit);
+    if (limit <= addr) {
+        return;
+    }
+
     assert(len <= 4);
     /* non-zero functions are only exposed when function 0 is present,
      * allowing direct removal of unexposed functions.
@@ -71,6 +92,11 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
 {
     uint32_t ret;
 
+    pci_adjust_config_limit(pci_get_bus(pci_dev), &limit);
+    if (limit <= addr) {
+        return ~0x0;
+    }
+
     assert(len <= 4);
     /* non-zero functions are only exposed when function 0 is present,
      * allowing direct removal of unexposed functions.
-- 
MST
