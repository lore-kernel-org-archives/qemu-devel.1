Received: from eggs.gnu.org ([2001:4830:134:3::10]:59158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJI3j-0003dJ-H0
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJI3h-0000Zu-1v
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:26:31 -0400
Received: from [59.151.112.132] (port=9596 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJI3g-0000ZG-4c
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:26:28 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 9 Jun 2017 19:24:40 +0800
Message-ID: <23d76336ccef24473bf20f83628818eb3d97dac4.1496994386.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1496994386.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1496994386.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 5/7] pci: Replace pci_add_capability() with
 pci_add_capability2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, dmitry@daynix.com, jasowang@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, armbru@redhat.com

After the patch 'Make errp the last parameter of pci_add_capability()',
pci_add_capability() and pci_add_capability2() now do exactly the same.
So drop the wrapper pci_add_capability() of pci_add_capability2(), then
replace the pci_add_capability() with pci_add_capability2() everywhere.

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
---
 hw/i386/amd_iommu.c    |  6 +++---
 hw/net/e1000e.c        |  2 +-
 hw/net/eepro100.c      |  2 +-
 hw/pci/pci.c           | 16 ----------------
 hw/pci/pci_bridge.c    |  2 +-
 hw/pci/pcie.c          |  4 ++--
 hw/pci/shpc.c          |  2 +-
 hw/pci/slotid_cap.c    |  2 +-
 hw/vfio/pci.c          |  2 +-
 hw/virtio/virtio-pci.c |  4 ++--
 include/hw/pci/pci.h   |  3 ---
 11 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d93ffc2..281fd16 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1158,19 +1158,19 @@ static void amdvi_realize(DeviceState *dev, Error **err)
     x86_iommu->type = TYPE_AMD;
     qdev_set_parent_bus(DEVICE(&s->pci), &bus->qbus);
     object_property_set_bool(OBJECT(&s->pci), true, "realized", err);
-    ret = pci_add_capability(&s->pci.dev, AMDVI_CAPAB_ID_SEC, 0,
+    ret = pci_add_capability2(&s->pci.dev, AMDVI_CAPAB_ID_SEC, 0,
                                          AMDVI_CAPAB_SIZE, err);
     if (ret < 0) {
         return;
     }
     s->capab_offset = ret;
 
-    ret = pci_add_capability(&s->pci.dev, PCI_CAP_ID_MSI, 0,
+    ret = pci_add_capability2(&s->pci.dev, PCI_CAP_ID_MSI, 0,
                              AMDVI_CAPAB_REG_SIZE, err);
     if (ret < 0) {
         return;
     }
-    ret = pci_add_capability(&s->pci.dev, PCI_CAP_ID_HT, 0,
+    ret = pci_add_capability2(&s->pci.dev, PCI_CAP_ID_HT, 0,
                              AMDVI_CAPAB_REG_SIZE, err);
     if (ret < 0) {
         return;
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index d1b1a97..7d77261 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -374,7 +374,7 @@ static int
 e1000e_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
 {
     Error *local_err = NULL;
-    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
+    int ret = pci_add_capability2(pdev, PCI_CAP_ID_PM, offset,
                                  PCI_PM_SIZEOF, &local_err);
 
     if (local_err) {
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 5a4774a..0bdb725 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -570,7 +570,7 @@ static void e100_pci_reset(EEPRO100State *s, Error **errp)
     if (info->power_management) {
         /* Power Management Capabilities */
         int cfg_offset = 0xdc;
-        int r = pci_add_capability(&s->dev, PCI_CAP_ID_PM,
+        int r = pci_add_capability2(&s->dev, PCI_CAP_ID_PM,
                                    cfg_offset, PCI_PM_SIZEOF,
                                    errp);
         if (r < 0) {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2bba37a..e418ad6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2259,22 +2259,6 @@ static void pci_del_option_rom(PCIDevice *pdev)
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
  * On success, pci_add_capability2() returns a positive value
  * that the offset of the pci capability.
  * On failure, it sets an error and returns a negative error
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index bb0f3a3..c3f6215 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -46,7 +46,7 @@ int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
     int pos;
     Error *local_err = NULL;
 
-    pos = pci_add_capability(dev, PCI_CAP_ID_SSVID, offset,
+    pos = pci_add_capability2(dev, PCI_CAP_ID_SSVID, offset,
                              PCI_SSVID_SIZEOF, &local_err);
     if (pos < 0) {
         error_report_err(local_err);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index f187512..9232baa 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -95,7 +95,7 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type, uint8_t port)
 
     assert(pci_is_express(dev));
 
-    pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
+    pos = pci_add_capability2(dev, PCI_CAP_ID_EXP, offset,
                              PCI_EXP_VER2_SIZEOF, &local_err);
     if (pos < 0) {
         error_report_err(local_err);
@@ -130,7 +130,7 @@ int pcie_cap_v1_init(PCIDevice *dev, uint8_t offset, uint8_t type,
 
     assert(pci_is_express(dev));
 
-    pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
+    pos = pci_add_capability2(dev, PCI_CAP_ID_EXP, offset,
                              PCI_EXP_VER1_SIZEOF, &local_err);
     if (pos < 0) {
         error_report_err(local_err);
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index d72d5e4..8219691 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -451,7 +451,7 @@ static int shpc_cap_add_config(PCIDevice *d)
     uint8_t *config;
     int config_offset;
     Error *local_err = NULL;
-    config_offset = pci_add_capability(d, PCI_CAP_ID_SHPC,
+    config_offset = pci_add_capability2(d, PCI_CAP_ID_SHPC,
                                        0, SHPC_CAP_LENGTH,
                                        &local_err);
     if (config_offset < 0) {
diff --git a/hw/pci/slotid_cap.c b/hw/pci/slotid_cap.c
index bdca205..682afaa 100644
--- a/hw/pci/slotid_cap.c
+++ b/hw/pci/slotid_cap.c
@@ -24,7 +24,7 @@ int slotid_cap_init(PCIDevice *d, int nslots,
         return -EINVAL;
     }
 
-    cap = pci_add_capability(d, PCI_CAP_ID_SLOTID, offset,
+    cap = pci_add_capability2(d, PCI_CAP_ID_SLOTID, offset,
                              SLOTID_CAP_LENGTH, &local_err);
     if (cap < 0) {
         error_report_err(local_err);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 70bfb59..190e056 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1743,7 +1743,7 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                                PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
     }
 
-    pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size,
+    pos = pci_add_capability2(&vdev->pdev, PCI_CAP_ID_EXP, pos, size,
                              errp);
     if (pos < 0) {
         return pos;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1fc5059..9cd35b3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1162,7 +1162,7 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
     PCIDevice *dev = &proxy->pci_dev;
     int offset;
 
-    offset = pci_add_capability(dev, PCI_CAP_ID_VNDR, 0,
+    offset = pci_add_capability2(dev, PCI_CAP_ID_VNDR, 0,
                                 cap->cap_len, &error_abort);
 
     assert(cap->cap_len >= sizeof *cap);
@@ -1810,7 +1810,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
 
-        pos = pci_add_capability(pci_dev, PCI_CAP_ID_PM, 0,
+        pos = pci_add_capability2(pci_dev, PCI_CAP_ID_PM, 0,
                                  PCI_PM_SIZEOF, errp);
         if (pos < 0) {
             return;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index fe52aa8..836dfc7 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -355,9 +355,6 @@ void pci_register_vga(PCIDevice *pci_dev, MemoryRegion *mem,
 void pci_unregister_vga(PCIDevice *pci_dev);
 pcibus_t pci_get_bar_addr(PCIDevice *pci_dev, int region_num);
 
-int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
-                       uint8_t offset, uint8_t size,
-                       Error **errp);
 int pci_add_capability2(PCIDevice *pdev, uint8_t cap_id,
                        uint8_t offset, uint8_t size,
                        Error **errp);
-- 
2.9.3
