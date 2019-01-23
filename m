Received: from eggs.gnu.org ([209.51.188.92]:58730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmNHB-0005GW-FC
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmNH9-00061x-Me
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:29:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1gmNH9-0005zF-AX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:29:23 -0500
From: Knut Omang <knut.omang@oracle.com>
Date: Wed, 23 Jan 2019 19:27:59 +0100
Message-Id: <b6e8edb21e6cc5f616383cb733c2d5f75d89953e.1548266832.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.c7f64d9a8f7ff9259c785560765645151c85dc75.1548266832.git-series.knut.omang@oracle.com>
References: <cover.c7f64d9a8f7ff9259c785560765645151c85dc75.1548266832.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] pcie: Add a simple PCIe ACS (Access
 Control Services) helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tal Attaly <talat@mellanox.com>, Elijah Shakkour <elijahs@mellanox.com>, Stefan Hajnoczi <stefanha@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Knut Omang <knut.omang@oracle.com>

Add a helper function to add PCIe capability for Access Control Services (ACS)
ACS support in the associated root port is a prerequisite to be able to do useful
passthrough with VFIO without Alex Williamson's pcie_acs_override kernel patch.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 hw/pci/pcie.c              | 14 ++++++++++++++
 include/hw/pci/pcie.h      |  1 +
 include/hw/pci/pcie_regs.h |  4 ++++
 3 files changed, 19 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 230478f..18feff5 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -906,3 +906,17 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
 
     pci_set_word(dev->wmask + dev->exp.ats_cap + PCI_ATS_CTRL, 0x800f);
 }
+
+/* Add an ACS (Access Control Services) capability */
+void pcie_acs_init(PCIDevice *dev, uint16_t offset, uint8_t egress_ctrl_vec_sz)
+{
+    int ectrl_words = (egress_ctrl_vec_sz + 31) & ~31;
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_ACS, PCI_ACS_VER,
+                        offset, PCI_ACS_SIZEOF + ectrl_words);
+    pci_set_word(dev->config + offset + PCI_ACS_CAP,
+                 PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+    pci_set_word(dev->config + offset + PCI_ACS_CTRL,
+                 PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+    /* Make CTRL register writable */
+    memset(dev->wmask + offset + PCI_ACS_CTRL, 0xff, 2);
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 5b82a0d..c2da148 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -129,6 +129,7 @@ void pcie_add_capability(PCIDevice *dev,
 void pcie_sync_bridge_lnk(PCIDevice *dev);
 
 void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
+void pcie_acs_init(PCIDevice *dev, uint16_t offset, uint8_t egress_ctrl_vec_sz);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset);
 
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index ad4e780..5e7409c 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -175,4 +175,8 @@ typedef enum PCIExpLinkWidth {
                                          PCI_ERR_COR_INTERNAL |         \
                                          PCI_ERR_COR_HL_OVERFLOW)
 
+/* ACS */
+#define PCI_ACS_VER			0x2
+#define PCI_ACS_SIZEOF                  8
+
 #endif /* QEMU_PCIE_REGS_H */
-- 
git-series 0.9.1
