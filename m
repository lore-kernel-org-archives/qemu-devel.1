Received: from eggs.gnu.org ([2001:4830:134:3::10]:39445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKPjn-0000ou-VS
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKPjm-0008Q0-0e
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:50:36 -0400
Received: from [59.151.112.132] (port=23824 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKPjl-0008P1-LA
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:50:33 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 12 Jun 2017 21:48:29 +0800
Message-ID: <eee360d6b199c0946919b68f86ce9ec8c42dc605.1497272778.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1497272778.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1497272778.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 3/9] pci: Fix the return value checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dmitry@daynix.com, jasowang@redhat.com, kraxel@redhat.com, alex.williamson@redhat.com, armbru@redhat.com

pci_add_capability returns a strictly positive value on success,
correct asserts.

Cc: dmitry@daynix.com
Cc: jasowang@redhat.com
Cc: kraxel@redhat.com
Cc: alex.williamson@redhat.com
Cc: armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/net/e1000e.c   | 2 +-
 hw/net/eepro100.c | 2 +-
 hw/usb/hcd-xhci.c | 2 +-
 hw/vfio/pci.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 6e23493..8259d67 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -374,7 +374,7 @@ e1000e_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
 {
     int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset, PCI_PM_SIZEOF);
 
-    if (ret >= 0) {
+    if (ret > 0) {
         pci_set_word(pdev->config + offset + PCI_PM_PMC,
                      PCI_PM_CAP_VER_1_1 |
                      pmc);
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 4bf71f2..da36816 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -571,7 +571,7 @@ static void e100_pci_reset(EEPRO100State * s)
         int cfg_offset = 0xdc;
         int r = pci_add_capability(&s->dev, PCI_CAP_ID_PM,
                                    cfg_offset, PCI_PM_SIZEOF);
-        assert(r >= 0);
+        assert(r > 0);
         pci_set_word(pci_conf + cfg_offset + PCI_PM_PMC, 0x7e21);
 #if 0 /* TODO: replace dummy code for power management emulation. */
         /* TODO: Power Management Control / Status. */
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index a0c7960..ab42f86 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3417,7 +3417,7 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
     if (pci_bus_is_express(dev->bus) ||
         xhci_get_flag(xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
         ret = pcie_endpoint_cap_init(dev, 0xa0);
-        assert(ret >= 0);
+        assert(ret > 0);
     }
 
     if (xhci->msix != ON_OFF_AUTO_OFF) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 32aca77..5881968 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1744,7 +1744,7 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
     }
 
     pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size);
-    if (pos >= 0) {
+    if (pos > 0) {
         vdev->pdev.exp.exp_cap = pos;
     }
 
-- 
2.9.3
