Received: from eggs.gnu.org ([2001:4830:134:3::10]:36870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUDjD-0002ZB-H2
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUDWR-0005Bb-MX
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:26:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gUDWR-0005BG-FB
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:26:07 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 04 Dec 2018 09:26:05 -0700
Message-ID: <154394076572.28192.17922483382108051842.stgit@gimli.home>
In-Reply-To: <154393964026.28192.13536237934563059985.stgit@gimli.home>
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-4.0 PATCH v3 1/9] pcie: Create enums for link
 speed and width
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Geoffrey McRae <geoff@hostfission.com>

In preparation for reporting higher virtual link speeds and widths,
create enums and macros to help us manage them.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci/pcie.c              |    7 ++++---
 hw/vfio/pci.c              |    3 ++-
 include/hw/pci/pcie_regs.h |   23 +++++++++++++++++++++--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6c91bd44a0a5..914a5261a79b 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -68,11 +68,12 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
     pci_set_long(exp_cap + PCI_EXP_LNKCAP,
                  (port << PCI_EXP_LNKCAP_PN_SHIFT) |
                  PCI_EXP_LNKCAP_ASPMS_0S |
-                 PCI_EXP_LNK_MLW_1 |
-                 PCI_EXP_LNK_LS_25);
+                 QEMU_PCI_EXP_LNKCAP_MLW(QEMU_PCI_EXP_LNK_X1) |
+                 QEMU_PCI_EXP_LNKCAP_MLS(QEMU_PCI_EXP_LNK_2_5GT));
 
     pci_set_word(exp_cap + PCI_EXP_LNKSTA,
-                 PCI_EXP_LNK_MLW_1 | PCI_EXP_LNK_LS_25);
+                 QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1) |
+                 QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT));
 
     if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
         pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5c7bd9698496..74f9a46b4be0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1897,7 +1897,8 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                                    PCI_EXP_TYPE_ENDPOINT << 4,
                                    PCI_EXP_FLAGS_TYPE);
             vfio_add_emulated_long(vdev, pos + PCI_EXP_LNKCAP,
-                                   PCI_EXP_LNK_MLW_1 | PCI_EXP_LNK_LS_25, ~0);
+                           QEMU_PCI_EXP_LNKCAP_MLW(QEMU_PCI_EXP_LNK_X1) |
+                           QEMU_PCI_EXP_LNKCAP_MLS(QEMU_PCI_EXP_LNK_2_5GT), ~0);
             vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
         }
 
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index a95522a13b04..ad4e7808b8ac 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -34,10 +34,29 @@
 
 /* PCI_EXP_LINK{CAP, STA} */
 /* link speed */
-#define PCI_EXP_LNK_LS_25               1
+typedef enum PCIExpLinkSpeed {
+    QEMU_PCI_EXP_LNK_2_5GT = 1,
+    QEMU_PCI_EXP_LNK_5GT,
+    QEMU_PCI_EXP_LNK_8GT,
+    QEMU_PCI_EXP_LNK_16GT,
+} PCIExpLinkSpeed;
+
+#define QEMU_PCI_EXP_LNKCAP_MLS(speed)  (speed)
+#define QEMU_PCI_EXP_LNKSTA_CLS         QEMU_PCI_EXP_LNKCAP_MLS
+
+typedef enum PCIExpLinkWidth {
+    QEMU_PCI_EXP_LNK_X1 = 1,
+    QEMU_PCI_EXP_LNK_X2 = 2,
+    QEMU_PCI_EXP_LNK_X4 = 4,
+    QEMU_PCI_EXP_LNK_X8 = 8,
+    QEMU_PCI_EXP_LNK_X12 = 12,
+    QEMU_PCI_EXP_LNK_X16 = 16,
+    QEMU_PCI_EXP_LNK_X32 = 32,
+} PCIExpLinkWidth;
 
 #define PCI_EXP_LNK_MLW_SHIFT           ctz32(PCI_EXP_LNKCAP_MLW)
-#define PCI_EXP_LNK_MLW_1               (1 << PCI_EXP_LNK_MLW_SHIFT)
+#define QEMU_PCI_EXP_LNKCAP_MLW(width)  (width << PCI_EXP_LNK_MLW_SHIFT)
+#define QEMU_PCI_EXP_LNKSTA_NLW         QEMU_PCI_EXP_LNKCAP_MLW
 
 /* PCI_EXP_LINKCAP */
 #define PCI_EXP_LNKCAP_ASPMS_SHIFT      ctz32(PCI_EXP_LNKCAP_ASPMS)
