Received: from eggs.gnu.org ([2001:4830:134:3::10]:45155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPlz-0007NV-RU
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPlv-0002Yk-3d
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:53:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:7729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPlu-0002Xo-Pe
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:53:27 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301666-24320-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [RFC 4/5] vfio: use vfio_device_put/vfio_device_get
 for device status save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 26 Jun 2017 08:53:33 -0000
To: qemu-devel@nongnu.org
Cc: zhenyuw@linux.intel.com, zhi.a.wang@intel.com, joonas.lahtinen@linux.intel.com, kevin.tian@intel.com, xiao.zheng@intel.com, Yulei Zhang <yulei.zhang@intel.com>

For VFIO pci device status migrate, on the source side with
funtion vfio_device_put to save the following states
1. pci configuration space addr0~addr5
2. pci configuration space msi_addr msi_data
3. pci device status fetch from device driver

And on the target side with funtion vfio_device_get to restore
the same states
1. re-setup the pci bar configuration
2. re-setup the pci device msi configuration
3. restore the pci device status

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 hw/vfio/pci.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 605a473..833cd90 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2961,18 +2961,121 @@ static void vfio_vm_change_state_handler(void *pv, int running, RunState state)
     vfio_status->flags = running ? VFIO_DEVICE_PCI_START :
 				  VFIO_DEVICE_PCI_STOP;
 
-    ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_STATUS_SET, vfio_status);
+    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_STATUS_SET, vfio_status)) {
+        error_report("vfio: Failed to %s device\n", running ? "start" : "stop");
+    }
     g_free(vfio_status);
 }
 
 static int vfio_device_put(QEMUFile *f, void *pv, size_t size, VMStateField *field,
                             QJSON *vmdesc)
 {
+    VFIOPCIDevice *vdev = pv;
+    PCIDevice *pdev = &vdev->pdev;
+    VFIORegion *region = &vdev->device_state.region;
+    int sz = region->size;
+    uint8_t *buf = NULL;
+    uint32_t msi_cfg, msi_lo, msi_hi, msi_data, bar_cfg, i;
+    bool msi_64bit;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        bar_cfg = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i*4, 4);
+        qemu_put_be32(f, bar_cfg);
+    }
+
+    msi_cfg = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS, 2);
+    msi_64bit = !!(msi_cfg & PCI_MSI_FLAGS_64BIT);
+
+    msi_lo = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
+    qemu_put_be32(f, msi_lo);
+
+    if (msi_64bit) {
+        msi_hi = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI, 4);
+        qemu_put_be32(f, msi_hi);
+    }
+
+    msi_data = pci_default_read_config(pdev,
+                 pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32), 2);
+    qemu_put_be32(f, msi_data);
+
+    buf = g_malloc(sz);
+    if (buf == NULL) {
+        error_report("vfio: Failed to allocate memory for migrate\n");
+        goto exit;
+    }
+
+    if (pread(vdev->vbasedev.fd, buf, sz, region->fd_offset) != sz) {
+        error_report("vfio: Failed to read Device State Region\n");
+        goto exit;
+    }
+
+    qemu_put_buffer(f, buf, sz);
+
+exit:
+    if (buf)
+        g_free(buf);
+
     return 0;
 }
 
 static int vfio_device_get(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
+    VFIOPCIDevice *vdev = pv;
+    PCIDevice *pdev = &vdev->pdev;
+    VFIORegion *region = &vdev->device_state.region;
+    int sz = region->size;
+    uint8_t *buf = NULL;
+    uint32_t ctl, msi_lo, msi_hi, msi_data, bar_cfg, i;
+    bool msi_64bit;
+
+    /* retore pci bar configuration */
+    ctl = pci_default_read_config(pdev, PCI_COMMAND, 2);
+    vfio_pci_write_config(pdev, PCI_COMMAND,
+                          ctl & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        bar_cfg = qemu_get_be32(f);
+        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i*4, bar_cfg, 4);
+    }
+    vfio_pci_write_config(pdev, PCI_COMMAND,
+                          ctl | PCI_COMMAND_IO | PCI_COMMAND_MEMORY, 2);
+
+    /* restore msi configuration */
+    ctl = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS, 2);
+    msi_64bit = !!(ctl & PCI_MSI_FLAGS_64BIT);
+
+    vfio_pci_write_config(&vdev->pdev,
+                          pdev->msi_cap + PCI_MSI_FLAGS,
+                          ctl & (!PCI_MSI_FLAGS_ENABLE), 2);
+
+    msi_lo = qemu_get_be32(f);
+    vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO, msi_lo, 4);
+
+    if (msi_64bit) {
+        msi_hi = qemu_get_be32(f);
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI, msi_hi, 4);
+    }
+    msi_data = qemu_get_be32(f);
+    vfio_pci_write_config(pdev,
+                          pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
+                          msi_data, 2);
+
+    vfio_pci_write_config(&vdev->pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                          ctl | PCI_MSI_FLAGS_ENABLE, 2);
+
+    buf = g_malloc(sz);
+    if (buf == NULL) {
+        error_report("vfio: Failed to allocate memory for migrate\n");
+        return -1;
+    }
+
+    qemu_get_buffer(f, buf, sz);
+    if (pwrite(vdev->vbasedev.fd, buf, sz, region->fd_offset) != sz) {
+        error_report("vfio: Failed to write Device State Region\n");
+        return -1;
+    }
+
+    if (buf)
+	g_free(buf);
     return 0;
 }
 
-- 
2.7.4
