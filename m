Received: from eggs.gnu.org ([2001:4830:134:3::10]:53800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmie-0001vx-CW
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmib-0004Cz-3K
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:16:16 -0500
Date: Thu, 26 Jan 2017 18:15:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485447262-27014-15-git-send-email-mst@redhat.com>
References: <1485447262-27014-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485447262-27014-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 14/18] pci: Convert msix_init() to Error and
 fix callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cao jin <caoj.fnst@cn.fujitsu.com>, Jiri Pirko <jiri@resnulli.us>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Cao jin <caoj.fnst@cn.fujitsu.com>

msix_init() reports errors with error_report(), which is wrong when
it's used in realize().  The same issue was fixed for msi_init() in
commit 1108b2f. In order to make the API change as small as possible,
leave the return value check to later patch.

For some devices(like e1000e, vmxnet3, nvme) who won't fail because of
msix_init's failure, suppress the error report by passing NULL error
object.

Bonus: add comment for msix_init.

CC: Jiri Pirko <jiri@resnulli.us>
CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Dmitry Fleytman <dmitry@daynix.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Hannes Reinecke <hare@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Alex Williamson <alex.williamson@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/msix.h              |  5 +++--
 hw/block/nvme.c                    |  2 +-
 hw/misc/ivshmem.c                  |  8 ++++----
 hw/net/e1000e.c                    |  2 +-
 hw/net/rocker/rocker.c             |  4 +++-
 hw/net/vmxnet3.c                   |  2 +-
 hw/pci-bridge/gen_pcie_root_port.c |  3 +--
 hw/pci/msix.c                      | 36 +++++++++++++++++++++++++++++++-----
 hw/scsi/megasas.c                  |  4 +++-
 hw/usb/hcd-xhci.c                  |  4 ++--
 hw/vfio/pci.c                      |  8 ++++++--
 hw/virtio/virtio-pci.c             |  4 ++--
 12 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
index 048a29d..1f27658 100644
--- a/include/hw/pci/msix.h
+++ b/include/hw/pci/msix.h
@@ -9,9 +9,10 @@ MSIMessage msix_get_message(PCIDevice *dev, unsigned int vector);
 int msix_init(PCIDevice *dev, unsigned short nentries,
               MemoryRegion *table_bar, uint8_t table_bar_nr,
               unsigned table_offset, MemoryRegion *pba_bar,
-              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos);
+              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
+              Error **errp);
 int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
-                            uint8_t bar_nr);
+                            uint8_t bar_nr, Error **errp);
 
 void msix_write_config(PCIDevice *dev, uint32_t address, uint32_t val, int len);
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d479fd2..ae91a18 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -872,7 +872,7 @@ static int nvme_init(PCIDevice *pci_dev)
     pci_register_bar(&n->parent_obj, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4);
+    msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL);
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index fd14d7a..0b5bd45 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -749,13 +749,13 @@ static void ivshmem_reset(DeviceState *d)
     }
 }
 
-static int ivshmem_setup_interrupts(IVShmemState *s)
+static int ivshmem_setup_interrupts(IVShmemState *s, Error **errp)
 {
     /* allocate QEMU callback data for receiving interrupts */
     s->msi_vectors = g_malloc0(s->vectors * sizeof(MSIVector));
 
     if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
-        if (msix_init_exclusive_bar(PCI_DEVICE(s), s->vectors, 1)) {
+        if (msix_init_exclusive_bar(PCI_DEVICE(s), s->vectors, 1, errp)) {
             return -1;
         }
 
@@ -898,8 +898,8 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
         qemu_chr_fe_set_handlers(&s->server_chr, ivshmem_can_receive,
                                  ivshmem_read, NULL, s, NULL, true);
 
-        if (ivshmem_setup_interrupts(s) < 0) {
-            error_setg(errp, "failed to initialize interrupts");
+        if (ivshmem_setup_interrupts(s, errp) < 0) {
+            error_prepend(errp, "Failed to initialize interrupts: ");
             return;
         }
     }
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 0e9a25b..b0f429b 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -292,7 +292,7 @@ e1000e_init_msix(E1000EState *s)
                         E1000E_MSIX_IDX, E1000E_MSIX_TABLE,
                         &s->msix,
                         E1000E_MSIX_IDX, E1000E_MSIX_PBA,
-                        0xA0);
+                        0xA0, NULL);
 
     if (res < 0) {
         trace_e1000e_msix_init_fail(res);
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index e9d215a..6e70fdd 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1256,14 +1256,16 @@ static int rocker_msix_init(Rocker *r)
 {
     PCIDevice *dev = PCI_DEVICE(r);
     int err;
+    Error *local_err = NULL;
 
     err = msix_init(dev, ROCKER_MSIX_VEC_COUNT(r->fp_ports),
                     &r->msix_bar,
                     ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_TABLE_OFFSET,
                     &r->msix_bar,
                     ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
-                    0);
+                    0, &local_err);
     if (err) {
+        error_report_err(local_err);
         return err;
     }
 
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 2cb2731..7dd4565 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2191,7 +2191,7 @@ vmxnet3_init_msix(VMXNET3State *s)
                         VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_TABLE,
                         &s->msix_bar,
                         VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA(s),
-                        VMXNET3_MSIX_OFFSET(s));
+                        VMXNET3_MSIX_OFFSET(s), NULL);
 
     if (0 > res) {
         VMW_WRPRN("Failed to initialize MSI-X, error %d", res);
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 185fd90..8ebffa8 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -29,11 +29,10 @@ static int gen_rp_interrupts_init(PCIDevice *d, Error **errp)
 {
     int rc;
 
-    rc = msix_init_exclusive_bar(d, GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR, 0);
+    rc = msix_init_exclusive_bar(d, GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR, 0, errp);
 
     if (rc < 0) {
         assert(rc == -ENOTSUP);
-        error_setg(errp, "Unable to init msix vectors");
     } else {
         msix_vector_use(d, 0);
     }
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index c938a9b..bb54e8b 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -21,6 +21,7 @@
 #include "hw/pci/pci.h"
 #include "hw/xen/xen.h"
 #include "qemu/range.h"
+#include "qapi/error.h"
 
 #define MSIX_CAP_LENGTH 12
 
@@ -238,11 +239,31 @@ static void msix_mask_all(struct PCIDevice *dev, unsigned nentries)
     }
 }
 
-/* Initialize the MSI-X structures */
+/*
+ * Make PCI device @dev MSI-X capable
+ * @nentries is the max number of MSI-X vectors that the device support.
+ * @table_bar is the MemoryRegion that MSI-X table structure resides.
+ * @table_bar_nr is number of base address register corresponding to @table_bar.
+ * @table_offset indicates the offset that the MSI-X table structure starts with
+ * in @table_bar.
+ * @pba_bar is the MemoryRegion that the Pending Bit Array structure resides.
+ * @pba_bar_nr is number of base address register corresponding to @pba_bar.
+ * @pba_offset indicates the offset that the Pending Bit Array structure
+ * starts with in @pba_bar.
+ * Non-zero @cap_pos puts capability MSI-X at that offset in PCI config space.
+ * @errp is for returning errors.
+ *
+ * Return 0 on success; set @errp and return -errno on error:
+ * -ENOTSUP means lacking msi support for a msi-capable platform.
+ * -EINVAL means capability overlap, happens when @cap_pos is non-zero,
+ * also means a programming error, except device assignment, which can check
+ * if a real HW is broken.
+ */
 int msix_init(struct PCIDevice *dev, unsigned short nentries,
               MemoryRegion *table_bar, uint8_t table_bar_nr,
               unsigned table_offset, MemoryRegion *pba_bar,
-              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos)
+              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
+              Error **errp)
 {
     int cap;
     unsigned table_size, pba_size;
@@ -250,10 +271,12 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
 
     /* Nothing to do if MSI is not supported by interrupt controller */
     if (!msi_nonbroken) {
+        error_setg(errp, "MSI-X is not supported by interrupt controller");
         return -ENOTSUP;
     }
 
     if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1) {
+        error_setg(errp, "The number of MSI-X vectors is invalid");
         return -EINVAL;
     }
 
@@ -266,10 +289,13 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
         table_offset + table_size > memory_region_size(table_bar) ||
         pba_offset + pba_size > memory_region_size(pba_bar) ||
         (table_offset | pba_offset) & PCI_MSIX_FLAGS_BIRMASK) {
+        error_setg(errp, "table & pba overlap, or they don't fit in BARs,"
+                   " or don't align");
         return -EINVAL;
     }
 
-    cap = pci_add_capability(dev, PCI_CAP_ID_MSIX, cap_pos, MSIX_CAP_LENGTH);
+    cap = pci_add_capability2(dev, PCI_CAP_ID_MSIX,
+                              cap_pos, MSIX_CAP_LENGTH, errp);
     if (cap < 0) {
         return cap;
     }
@@ -306,7 +332,7 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
 }
 
 int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
-                            uint8_t bar_nr)
+                            uint8_t bar_nr, Error **errp)
 {
     int ret;
     char *name;
@@ -338,7 +364,7 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
     ret = msix_init(dev, nentries, &dev->msix_exclusive_bar, bar_nr,
                     0, &dev->msix_exclusive_bar,
                     bar_nr, bar_pba_offset,
-                    0);
+                    0, errp);
     if (ret) {
         return ret;
     }
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 6aad7c9..1a8b04c 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2367,9 +2367,11 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
 
     if (megasas_use_msix(s) &&
         msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
-                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68)) {
+                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68, NULL)) {
+        /* TODO: check msix_init's error, and should fail on msix=on */
         s->msix = ON_OFF_AUTO_OFF;
     }
+
     if (pci_is_express(dev)) {
         pcie_endpoint_cap_init(dev, 0xa0);
     }
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 6575d05..f810678 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3703,11 +3703,11 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
     }
 
     if (xhci->msix != ON_OFF_AUTO_OFF) {
-        /* TODO check for errors */
+        /* TODO check for errors, and should fail when msix=on */
         msix_init(dev, xhci->numintrs,
                   &xhci->mem, 0, OFF_MSIX_TABLE,
                   &xhci->mem, 0, OFF_MSIX_PBA,
-                  0x90);
+                  0x90, NULL);
     }
 }
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 882d3a9..332f41d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1432,6 +1432,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
     int ret;
+    Error *err = NULL;
 
     vdev->msix->pending = g_malloc0(BITS_TO_LONGS(vdev->msix->entries) *
                                     sizeof(unsigned long));
@@ -1439,12 +1440,15 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
                     vdev->bars[vdev->msix->table_bar].region.mem,
                     vdev->msix->table_bar, vdev->msix->table_offset,
                     vdev->bars[vdev->msix->pba_bar].region.mem,
-                    vdev->msix->pba_bar, vdev->msix->pba_offset, pos);
+                    vdev->msix->pba_bar, vdev->msix->pba_offset, pos,
+                    &err);
     if (ret < 0) {
         if (ret == -ENOTSUP) {
+            error_report_err(err);
             return 0;
         }
-        error_setg(errp, "msix_init failed");
+
+        error_propagate(errp, err);
         return ret;
     }
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b5af2a0..5ce42af 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1686,9 +1686,9 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
 
     if (proxy->nvectors) {
         int err = msix_init_exclusive_bar(&proxy->pci_dev, proxy->nvectors,
-                                          proxy->msix_bar_idx);
+                                          proxy->msix_bar_idx, NULL);
         if (err) {
-            /* Notice when a system that supports MSIx can't initialize it.  */
+            /* Notice when a system that supports MSIx can't initialize it */
             if (err != -ENOTSUP) {
                 error_report("unable to init msix vectors to %" PRIu32,
                              proxy->nvectors);
-- 
MST
