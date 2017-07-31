Received: from eggs.gnu.org ([2001:4830:134:3::10]:48666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dc49h-0005zn-A8
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dc49e-0007Ws-5h
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:6607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dc49d-0007Ui-RT
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:14 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1494316727-15518-4-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1494316727-15518-1-git-send-email-yulei.zhang@intel.com>
References: <1494316727-15518-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [RFC V2 3/4] vfio: Add struct vfio_vmstate_info to
 introduce put/get callback funtion for vfio device status save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 31 Jul 2017 06:26:21 -0000
To: qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, xiao.zheng@intel.com, zhi.a.wang@intel.com, alex.williamson@redhat.com, Yulei Zhang <yulei.zhang@intel.com>

Introduce vfio_device_put/vfio_device_get funtion for vfio device state
save/restore usage.

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
 hw/vfio/pci.c              | 132 +++++++++++++++++++++++++++++++++++++++++++++
 linux-headers/linux/vfio.h |   2 +
 2 files changed, 134 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 753da80..c0fc1d2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2959,6 +2959,118 @@ static void vfio_vm_change_state_handler(void *pv, int running, RunState state)
     vbasedev->device_state = dev_state;
 }
 
+static int vfio_device_put(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                            QJSON *vmdesc)
+{
+    VFIOPCIDevice *vdev = pv;
+    PCIDevice *pdev = &vdev->pdev;
+    int sz = vdev->device_state.size - VFIO_DEVICE_STATE_OFFSET;
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
+    if (pread(vdev->vbasedev.fd, buf, sz,
+              vdev->device_state.offset + VFIO_DEVICE_STATE_OFFSET) != sz) {
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
+    return 0;
+}
+
+static int vfio_device_get(QEMUFile *f, void *pv, size_t size, VMStateField *field)
+{
+    VFIOPCIDevice *vdev = pv;
+    PCIDevice *pdev = &vdev->pdev;
+    int sz = vdev->device_state.size - VFIO_DEVICE_STATE_OFFSET;
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
+    if (pwrite(vdev->vbasedev.fd, buf, sz,
+               vdev->device_state.offset + VFIO_DEVICE_STATE_OFFSET) != sz) {
+        error_report("vfio: Failed to write Device State Region\n");
+        return -1;
+    }
+
+    if (buf)
+	g_free(buf);
+    return 0;
+}
+
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
@@ -3003,9 +3115,29 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static VMStateInfo vfio_vmstate_info = {
+    .name = "vfio-state",
+    .get = vfio_device_get,
+    .put = vfio_device_put,
+};
+
 static VMStateDescription vfio_pci_vmstate = {
     .name = "vfio-pci",
     .unmigratable = 1,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        {
+            .name         = "vfio dev",
+            .version_id   = 0,
+            .field_exists = NULL,
+            .size         = 0,
+            .info         = &vfio_vmstate_info,
+            .flags        = VMS_SINGLE,
+            .offset       = 0,
+         },
+        VMSTATE_END_OF_LIST()
+    },
 };
 
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index ae1b953..dbbe7e1 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -302,6 +302,8 @@ struct vfio_region_info_cap_type {
 #define VFIO_DEVICE_START	0
 #define VFIO_DEVICE_STOP	1
 
+#define VFIO_DEVICE_STATE_OFFSET       1
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
-- 
2.7.4
