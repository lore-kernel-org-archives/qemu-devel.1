Received: from eggs.gnu.org ([2001:4830:134:3::10]:47138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCS0-0003zy-Dj
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRy-0006gW-Sx
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:12 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:46 +1000
Message-Id: <20170609052652.23200-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/20] hw/ppc/spapr: Adjust firmware name for
 PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

SLOF uses "pci" as name for PCI bridges nodes in the device tree instead
of "pci-bridges", so booting via bootindex from a device behind a PCI
bridge currently does not work since QEMU passes the wrong name in the
"qemu,boot-list" property. Fix it by changing the name of the PCI bridge
nodes to "pci" instead.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1459170
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e340ff3..01dda9e 100644
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
2.9.4
