Received: from eggs.gnu.org ([209.51.188.92]:33808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwAss-0008Cz-Kz
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwAsq-0000zz-Nd
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:16:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gwAsp-0000zT-PF
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:16:48 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 19 Feb 2019 12:06:43 -0700
Message-ID: <155060310248.19547.14979269067689441201.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] pci: Sanity test minimum downstream LNKSTA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jens Freimann <jfreimann@redhat.com>, mst@redhat.com, marcel.apfelbaum@gmail.com

The entire link status register for SR-IOV VFs is defined as RsvdZ,
reads simply return zero.  Usually this is nothing more than lspci
reporting inconsequentially broken values:

    LnkSta: Speed unknown, Width x0, ...

However, now that we're using the downstream endpoint link status to
fill in the value at the parent downstream port, invalid values become
a problem.  In particular, the PCIe hotplug driver in Linux looks for
a valid negotiated link width and will fail to enumerate hot-added
downstream endpoints without non-zero value here, ex:

    pciehp 0000:00:02.0:pcie004: Slot(0): Attention button pressed
    pciehp 0000:00:02.0:pcie004: Slot(0) Powering on due to button press
    pciehp 0000:00:02.0:pcie004: Slot(0): Card present
    pciehp 0000:00:02.0:pcie004: Slot(0): Link Up
    pciehp 0000:00:02.0:pcie004: link training error: status 0x2000
    pciehp 0000:00:02.0:pcie004: Failed to check link status

Resolve by using minimum width and speed values for the downstream
port link status when the endpoint fails to provide valid values.
Long term, we may want to implement emulation in the vfio-pci host
driver to suppliment this field with the PF value as the SR-IOV spec
seems to allow, but the solution here is compatible should that be
implemented later.

Fixes: 727b48661f75 ("pci: Sync PCIe downstream port LNKSTA on read")
Reported-by: Jens Freimann <jfreimann@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci/pcie.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 3f7c36609313..3618d6ab2e1a 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -834,9 +834,12 @@ void pcie_add_capability(PCIDevice *dev,
 /*
  * Sync the PCIe Link Status negotiated speed and width of a bridge with the
  * downstream device.  If downstream device is not present, re-write with the
- * Link Capability fields.  Limit width and speed to bridge capabilities for
- * compatibility.  Use config_read to access the downstream device since it
- * could be an assigned device with volatile link information.
+ * Link Capability fields.  If downstream device reports invalid width or
+ * speed, replace with minimum values (LnkSta fields are RsvdZ on VFs but such
+ * values interfere with PCIe native hotplug detecting new devices).  Limit
+ * width and speed to bridge capabilities for compatibility.  Use config_read
+ * to access the downstream device since it could be an assigned device with
+ * volatile link information.
  */
 void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
 {
@@ -856,11 +859,15 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
         if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
             lnksta &= ~PCI_EXP_LNKSTA_NLW;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
+        } else if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
+            lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
         }
 
         if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
             lnksta &= ~PCI_EXP_LNKSTA_CLS;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
+        } else if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
+            lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
         }
     }
 
