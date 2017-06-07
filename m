Received: from eggs.gnu.org ([2001:4830:134:3::10]:38442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIWCg-00057j-8j
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIWCd-0003xr-4B
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:20:34 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  7 Jun 2017 10:20:27 +0200
Message-Id: <1496823627-17609-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr: Adjust firmware name for PCI
 bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, abologna@redhat.com

SLOF uses "pci" as name for PCI bridges nodes in the device tree instead
of "pci-bridges", so booting via bootindex from a device behind a PCI
bridge currently does not work since QEMU passes the wrong name in the
"qemu,boot-list" property. Fix it by changing the name of the PCI bridge
nodes to "pci" instead.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1459170
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 91b4057..27b1f3c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2441,6 +2441,12 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
         return g_strdup_printf("disk@%"PRIX64, (uint64_t)id << 32);
     }
 
+    if (g_str_equal("pci-bridge", qdev_fw_name(dev))) {
+        /* SLOF uses "pci" instead of "pci-bridge" for PCI bridges */
+        PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
+        return g_strdup_printf("pci@%x", PCI_SLOT(pcidev->devfn));
+    }
+
     return NULL;
 }
 
-- 
1.8.3.1
