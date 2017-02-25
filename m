Received: from eggs.gnu.org ([2001:4830:134:3::10]:51238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1chXa1-0001VS-An
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 03:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1chXZy-0008SZ-Vd
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 03:19:49 -0500
Received: from [59.151.112.132] (port=45078 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1chXZy-0008R1-0V
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 03:19:46 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Sat, 25 Feb 2017 16:26:35 +0800
Message-ID: <1488011202-32121-2-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1488011202-32121-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1488011202-32121-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v10 1/8] msix: Rename and create a wrapper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>

Rename msix_init to msix_validate_and_init, and use it from vfio which
might get a reasonable -EINVAL.  New a wrapper msix_init which assert the
programming error for debug purpose and use it from other devices.

CC: Alex Williamson <alex.williamson@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/pci/msix.c         | 30 +++++++++++++++++++++---------
 hw/vfio/pci.c         | 12 ++++++------
 include/hw/pci/msix.h |  5 +++++
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index bb54e8b0ac37..2b7541ab2c8d 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -239,6 +239,19 @@ static void msix_mask_all(struct PCIDevice *dev, unsigned nentries)
     }
 }
 
+/* Just a wrapper to check the return value */
+int msix_init(struct PCIDevice *dev, unsigned short nentries,
+              MemoryRegion *table_bar, uint8_t table_bar_nr,
+              unsigned table_offset, MemoryRegion *pba_bar,
+              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
+              Error **errp)
+{
+    int ret = msix_validate_and_init(dev, nentries, table_bar, table_bar_nr,
+            table_offset, pba_bar, pba_bar_nr, pba_offset, cap_pos, errp);
+
+    assert(ret != -EINVAL);
+    return ret;
+}
 /*
  * Make PCI device @dev MSI-X capable
  * @nentries is the max number of MSI-X vectors that the device support.
@@ -259,11 +272,11 @@ static void msix_mask_all(struct PCIDevice *dev, unsigned nentries)
  * also means a programming error, except device assignment, which can check
  * if a real HW is broken.
  */
-int msix_init(struct PCIDevice *dev, unsigned short nentries,
-              MemoryRegion *table_bar, uint8_t table_bar_nr,
-              unsigned table_offset, MemoryRegion *pba_bar,
-              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
-              Error **errp)
+int msix_validate_and_init(struct PCIDevice *dev, unsigned short nentries,
+                           MemoryRegion *table_bar, uint8_t table_bar_nr,
+                           unsigned table_offset, MemoryRegion *pba_bar,
+                           uint8_t pba_bar_nr, unsigned pba_offset,
+                           uint8_t cap_pos, Error **errp)
 {
     int cap;
     unsigned table_size, pba_size;
@@ -361,10 +374,9 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
     memory_region_init(&dev->msix_exclusive_bar, OBJECT(dev), name, bar_size);
     g_free(name);
 
-    ret = msix_init(dev, nentries, &dev->msix_exclusive_bar, bar_nr,
-                    0, &dev->msix_exclusive_bar,
-                    bar_nr, bar_pba_offset,
-                    0, errp);
+    ret = msix_validate_and_init(dev, nentries, &dev->msix_exclusive_bar,
+                                 bar_nr, 0, &dev->msix_exclusive_bar,
+                                 bar_nr, bar_pba_offset, 0, errp);
     if (ret) {
         return ret;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 332f41d6627f..06828b537a75 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1436,12 +1436,12 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 
     vdev->msix->pending = g_malloc0(BITS_TO_LONGS(vdev->msix->entries) *
                                     sizeof(unsigned long));
-    ret = msix_init(&vdev->pdev, vdev->msix->entries,
-                    vdev->bars[vdev->msix->table_bar].region.mem,
-                    vdev->msix->table_bar, vdev->msix->table_offset,
-                    vdev->bars[vdev->msix->pba_bar].region.mem,
-                    vdev->msix->pba_bar, vdev->msix->pba_offset, pos,
-                    &err);
+    ret = msix_validate_and_init(&vdev->pdev, vdev->msix->entries,
+                             vdev->bars[vdev->msix->table_bar].region.mem,
+                             vdev->msix->table_bar, vdev->msix->table_offset,
+                             vdev->bars[vdev->msix->pba_bar].region.mem,
+                             vdev->msix->pba_bar, vdev->msix->pba_offset, pos,
+                             &err);
     if (ret < 0) {
         if (ret == -ENOTSUP) {
             error_report_err(err);
diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
index 1f27658d352f..815e59bc96f3 100644
--- a/include/hw/pci/msix.h
+++ b/include/hw/pci/msix.h
@@ -11,6 +11,11 @@ int msix_init(PCIDevice *dev, unsigned short nentries,
               unsigned table_offset, MemoryRegion *pba_bar,
               uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
               Error **errp);
+int msix_validate_and_init(PCIDevice *dev, unsigned short nentries,
+                           MemoryRegion *table_bar, uint8_t table_bar_nr,
+                           unsigned table_offset, MemoryRegion *pba_bar,
+                           uint8_t pba_bar_nr, unsigned pba_offset,
+                           uint8_t cap_pos, Error **errp);
 int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
                             uint8_t bar_nr, Error **errp);
 
-- 
2.1.0
