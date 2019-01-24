Received: from eggs.gnu.org ([209.51.188.92]:35009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmc84-0002nS-Mc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmc24-0005lQ-Vm
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:14:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1gmc24-0005Wm-6S
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:14:48 -0500
From: Knut Omang <knut.omang@oracle.com>
Date: Thu, 24 Jan 2019 11:12:52 +0100
Message-Id: <e74a05e53fdb6d5b9a48e44ce51ea987ffb7e2bf.1548323393.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.4fe3faa2cc295ab1e178284b738e33b940ab9312.1548323393.git-series.knut.omang@oracle.com>
References: <cover.4fe3faa2cc295ab1e178284b738e33b940ab9312.1548323393.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] pcie: Add a simple PCIe ACS (Access
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahs@mellanox.com>, Tal Attaly <talat@mellanox.com>, Knut Omang <knut.omang@oracle.com>

Add a helper function to add PCIe capability for Access Control Services (ACS)
ACS support in the associated root port is a prerequisite to be able to do
passthrough of individual functions of a device with VFIO
without Alex Williamson's pcie_acs_override kernel patch or similar
in the guest.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 hw/pci/pcie.c              | 21 +++++++++++++++++++++
 include/hw/pci/pcie.h      |  6 ++++++
 include/hw/pci/pcie_regs.h |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 230478f..5ab3d1d 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -742,6 +742,13 @@ bool pcie_cap_is_arifwd_enabled(const PCIDevice *dev)
         PCI_EXP_DEVCTL2_ARI;
 }
 
+/* Access Control Services (ACS)
+ */
+void pcie_cap_acs_reset(PCIDevice *dev)
+{
+    pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
+}
+
 /**************************************************************************
  * pci express extended capability list management functions
  * uint16_t ext_cap_id (16 bit)
@@ -906,3 +913,17 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
 
     pci_set_word(dev->wmask + dev->exp.ats_cap + PCI_ATS_CTRL, 0x800f);
 }
+
+/* ACS (Access Control Services) */
+void pcie_acs_init(PCIDevice *dev, uint16_t offset)
+{
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_ACS, PCI_ACS_VER,
+                        offset, PCI_ACS_SIZEOF);
+    dev->exp.acs_cap = offset;
+    pci_set_word(dev->config + offset + PCI_ACS_CAP,
+                 PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+
+    pci_set_word(dev->config + offset + PCI_ACS_CTRL, 0);
+    pci_set_word(dev->wmask + offset + PCI_ACS_CTRL,
+                 PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 5b82a0d..4c40711 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -79,6 +79,9 @@ struct PCIExpressDevice {
 
     /* Offset of ATS capability in config space */
     uint16_t ats_cap;
+
+    /* ACS */
+    uint16_t acs_cap;
 };
 
 #define COMPAT_PROP_PCP "power_controller_present"
@@ -116,6 +119,8 @@ void pcie_cap_flr_init(PCIDevice *dev);
 void pcie_cap_flr_write_config(PCIDevice *dev,
                            uint32_t addr, uint32_t val, int len);
 
+void pcie_cap_acs_reset(PCIDevice *dev);
+
 /* ARI forwarding capability and control */
 void pcie_cap_arifwd_init(PCIDevice *dev);
 void pcie_cap_arifwd_reset(PCIDevice *dev);
@@ -129,6 +134,7 @@ void pcie_add_capability(PCIDevice *dev,
 void pcie_sync_bridge_lnk(PCIDevice *dev);
 
 void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
+void pcie_acs_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset);
 
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index ad4e780..3fc9aca 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -175,4 +175,8 @@ typedef enum PCIExpLinkWidth {
                                          PCI_ERR_COR_INTERNAL |         \
                                          PCI_ERR_COR_HL_OVERFLOW)
 
+/* ACS */
+#define PCI_ACS_VER                     0x2
+#define PCI_ACS_SIZEOF                  8
+
 #endif /* QEMU_PCIE_REGS_H */
-- 
git-series 0.9.1
