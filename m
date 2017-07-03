Received: from eggs.gnu.org ([2001:4830:134:3::10]:46868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7Hg-000824-UT
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7Hf-0002zg-Ks
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:25 -0400
Date: Mon, 3 Jul 2017 22:45:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-9-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 08/21] pci: Replace pci_add_capability2() with
 pci_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, dmitry@daynix.com, jasowang@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, armbru@redhat.com, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

After the patch 'Make errp the last parameter of pci_add_capability()',
pci_add_capability() and pci_add_capability2() now do exactly the same.
So drop the wrapper pci_add_capability() of pci_add_capability2(), then
replace the pci_add_capability2() with pci_add_capability() everywhere.

Cc: pbonzini@redhat.com
Cc: rth@twiddle.net
Cc: ehabkost@redhat.com
Cc: mst@redhat.com
Cc: dmitry@daynix.com
Cc: jasowang@redhat.com
Cc: marcel@redhat.com
Cc: alex.williamson@redhat.com
Cc: armbru@redhat.com
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h     |  3 ---
 hw/i386/kvm/pci-assign.c | 14 +++++++-------
 hw/ide/ich.c             |  2 +-
 hw/pci/msi.c             |  2 +-
 hw/pci/msix.c            |  2 +-
 hw/pci/pci.c             | 20 ++------------------
 hw/vfio/pci.c            |  6 +++---
 7 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index fe52aa8..e598b09 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -358,9 +358,6 @@ pcibus_t pci_get_bar_addr(PCIDevice *pci_dev, int region_num);
 int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
                        uint8_t offset, uint8_t size,
                        Error **errp);
-int pci_add_capability2(PCIDevice *pdev, uint8_t cap_id,
-                       uint8_t offset, uint8_t size,
-                       Error **errp);
 
 void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
 
diff --git a/hw/i386/kvm/pci-assign.c b/hw/i386/kvm/pci-assign.c
index 87dcbdd..3d60455 100644
--- a/hw/i386/kvm/pci-assign.c
+++ b/hw/i386/kvm/pci-assign.c
@@ -1254,7 +1254,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
         dev->dev.cap_present |= QEMU_PCI_CAP_MSI;
         dev->cap.available |= ASSIGNED_DEVICE_CAP_MSI;
         /* Only 32-bit/no-mask currently supported */
-        ret = pci_add_capability2(pci_dev, PCI_CAP_ID_MSI, pos, 10,
+        ret = pci_add_capability(pci_dev, PCI_CAP_ID_MSI, pos, 10,
                                   &local_err);
         if (ret < 0) {
             error_propagate(errp, local_err);
@@ -1288,7 +1288,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
         }
         dev->dev.cap_present |= QEMU_PCI_CAP_MSIX;
         dev->cap.available |= ASSIGNED_DEVICE_CAP_MSIX;
-        ret = pci_add_capability2(pci_dev, PCI_CAP_ID_MSIX, pos, 12,
+        ret = pci_add_capability(pci_dev, PCI_CAP_ID_MSIX, pos, 12,
                                   &local_err);
         if (ret < 0) {
             error_propagate(errp, local_err);
@@ -1318,7 +1318,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
     if (pos) {
         uint16_t pmc;
 
-        ret = pci_add_capability2(pci_dev, PCI_CAP_ID_PM, pos, PCI_PM_SIZEOF,
+        ret = pci_add_capability(pci_dev, PCI_CAP_ID_PM, pos, PCI_PM_SIZEOF,
                                   &local_err);
         if (ret < 0) {
             error_propagate(errp, local_err);
@@ -1386,7 +1386,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
             return -EINVAL;
         }
 
-        ret = pci_add_capability2(pci_dev, PCI_CAP_ID_EXP, pos, size,
+        ret = pci_add_capability(pci_dev, PCI_CAP_ID_EXP, pos, size,
                                   &local_err);
         if (ret < 0) {
             error_propagate(errp, local_err);
@@ -1462,7 +1462,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
         uint32_t status;
 
         /* Only expose the minimum, 8 byte capability */
-        ret = pci_add_capability2(pci_dev, PCI_CAP_ID_PCIX, pos, 8,
+        ret = pci_add_capability(pci_dev, PCI_CAP_ID_PCIX, pos, 8,
                                   &local_err);
         if (ret < 0) {
             error_propagate(errp, local_err);
@@ -1490,7 +1490,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
     pos = pci_find_cap_offset(pci_dev, PCI_CAP_ID_VPD, 0);
     if (pos) {
         /* Direct R/W passthrough */
-        ret = pci_add_capability2(pci_dev, PCI_CAP_ID_VPD, pos, 8,
+        ret = pci_add_capability(pci_dev, PCI_CAP_ID_VPD, pos, 8,
                                   &local_err);
         if (ret < 0) {
             error_propagate(errp, local_err);
@@ -1508,7 +1508,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
         pos += PCI_CAP_LIST_NEXT) {
         uint8_t len = pci_get_byte(pci_dev->config + pos + PCI_CAP_FLAGS);
         /* Direct R/W passthrough */
-        ret = pci_add_capability2(pci_dev, PCI_CAP_ID_VNDR, pos, len,
+        ret = pci_add_capability(pci_dev, PCI_CAP_ID_VNDR, pos, len,
                                   &local_err);
         if (ret < 0) {
             error_propagate(errp, local_err);
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 4599169..989fca5 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -130,7 +130,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
                      &d->ahci.mem);
 
-    sata_cap_offset = pci_add_capability2(dev, PCI_CAP_ID_SATA,
+    sata_cap_offset = pci_add_capability(dev, PCI_CAP_ID_SATA,
                                           ICH9_SATA_CAP_OFFSET, SATA_CAP_SIZE,
                                           errp);
     if (sata_cap_offset < 0) {
diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index a87b227..5e05ce5 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -216,7 +216,7 @@ int msi_init(struct PCIDevice *dev, uint8_t offset,
     }
 
     cap_size = msi_cap_sizeof(flags);
-    config_offset = pci_add_capability2(dev, PCI_CAP_ID_MSI, offset,
+    config_offset = pci_add_capability(dev, PCI_CAP_ID_MSI, offset,
                                         cap_size, errp);
     if (config_offset < 0) {
         return config_offset;
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index fc5fe51..5078d3d 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -301,7 +301,7 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
         return -EINVAL;
     }
 
-    cap = pci_add_capability2(dev, PCI_CAP_ID_MSIX,
+    cap = pci_add_capability(dev, PCI_CAP_ID_MSIX,
                               cap_pos, MSIX_CAP_LENGTH, errp);
     if (cap < 0) {
         return cap;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3ad6f4e..0c6f74a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2259,28 +2259,12 @@ static void pci_del_option_rom(PCIDevice *pdev)
 }
 
 /*
- * if offset = 0,
- * Find and reserve space and add capability to the linked list
- * in pci config space
- */
-int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
-                       uint8_t offset, uint8_t size,
-                       Error **errp)
-{
-    int ret;
-
-    ret = pci_add_capability2(pdev, cap_id, offset, size, errp);
-
-    return ret;
-}
-
-/*
- * On success, pci_add_capability2() returns a positive value
+ * On success, pci_add_capability() returns a positive value
  * that the offset of the pci capability.
  * On failure, it sets an error and returns a negative error
  * code.
  */
-int pci_add_capability2(PCIDevice *pdev, uint8_t cap_id,
+int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
                        uint8_t offset, uint8_t size,
                        Error **errp)
 {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 70bfb59..8de8272 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1837,14 +1837,14 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
     case PCI_CAP_ID_PM:
         vfio_check_pm_reset(vdev, pos);
         vdev->pm_cap = pos;
-        ret = pci_add_capability2(pdev, cap_id, pos, size, errp);
+        ret = pci_add_capability(pdev, cap_id, pos, size, errp);
         break;
     case PCI_CAP_ID_AF:
         vfio_check_af_flr(vdev, pos);
-        ret = pci_add_capability2(pdev, cap_id, pos, size, errp);
+        ret = pci_add_capability(pdev, cap_id, pos, size, errp);
         break;
     default:
-        ret = pci_add_capability2(pdev, cap_id, pos, size, errp);
+        ret = pci_add_capability(pdev, cap_id, pos, size, errp);
         break;
     }
 out:
-- 
MST
