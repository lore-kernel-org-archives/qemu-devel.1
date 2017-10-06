Received: from eggs.gnu.org ([2001:4830:134:3::10]:43980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSl-0002hf-F0
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSk-0008V5-OU
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:27 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:18 -0300
Message-Id: <20171006235023.11952-84-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 83/88] hw/pci: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci/pci.c          | 2 +-
 hw/pci/pcie_port.c    | 2 +-
 tests/libqos/pci-pc.c | 2 +-
 tests/libqos/pci.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1e6fb88eba..32625d9fcc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1644,7 +1644,7 @@ static PciMemoryRegionList *qmp_query_pci_regions(const PCIDevice *dev)
             continue;
         }
 
-        region = g_malloc0(sizeof(*region));
+        region = g_new0(PciMemoryRegionList, 1);
         region->value = g_malloc0(sizeof(*region->value));
 
         if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index 6432b9ac1f..236d8bc4db 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -72,7 +72,7 @@ void pcie_chassis_create(uint8_t chassis_number)
     if (c) {
         return;
     }
-    c = g_malloc0(sizeof(*c));
+    c = g_new0(struct PCIEChassis, 1);
     c->number = chassis_number;
     QLIST_INIT(&c->slots);
     QLIST_INSERT_HEAD(&chassis, c, next);
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index ded1c54c06..cde5e0a627 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -119,7 +119,7 @@ QPCIBus *qpci_init_pc(QGuestAllocator *alloc)
 {
     QPCIBusPC *ret;
 
-    ret = g_malloc(sizeof(*ret));
+    ret = g_new(QPCIBusPC, 1);
 
     ret->bus.pio_readb = qpci_pc_pio_readb;
     ret->bus.pio_readw = qpci_pc_pio_readw;
diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 0b73cb23d0..9dd689c7b5 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -54,7 +54,7 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
 {
     QPCIDevice *dev;
 
-    dev = g_malloc0(sizeof(*dev));
+    dev = g_new0(QPCIDevice, 1);
     dev->bus = bus;
     dev->devfn = devfn;
 
-- 
2.14.2
