Received: from eggs.gnu.org ([2001:4830:134:3::10]:41214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeT-0005wd-1h
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeQ-00073X-JG
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:32 -0500
Received: from [59.151.112.132] (port=14080 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeP-0006sZ-9v
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:30 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Sat, 31 Dec 2016 17:13:06 +0800
Message-ID: <1483175588-17006-3-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC v11 2/4] vfio: new function to init aer cap
 for vfio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, izumi.taku@jp.fujitsu.com, Chen Fan <chen.fan.fnst@cn.fujitsu.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>

From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>

Introduce new function to initilize AER capability registers
for vfio-pci device.

Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/vfio/pci.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 hw/vfio/pci.h |  3 +++
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7dbe0e..76a8ac3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1851,18 +1851,81 @@ out:
     return 0;
 }
 
-static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
+static int vfio_setup_aer(VFIOPCIDevice *vdev, uint8_t cap_ver,
+                          int pos, uint16_t size, Error **errp)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *dev_iter;
+    uint8_t type;
+    uint32_t errcap;
+
+    /* In case the physical device has AER cap while user doesn't enable AER,
+     * still allocate the config space in the emulated device for AER */
+    if (!(vdev->features & VFIO_FEATURE_ENABLE_AER)) {
+        pcie_add_capability(pdev, PCI_EXT_CAP_ID_ERR,
+                            cap_ver, pos, size);
+        return 0;
+    }
+
+    dev_iter = pci_bridge_get_device(pdev->bus);
+    if (!dev_iter) {
+        goto error;
+    }
+
+    while (dev_iter) {
+        if (!pci_is_express(dev_iter)) {
+            goto error;
+        }
+
+        type = pcie_cap_get_type(dev_iter);
+        if ((type != PCI_EXP_TYPE_ROOT_PORT &&
+             type != PCI_EXP_TYPE_UPSTREAM &&
+             type != PCI_EXP_TYPE_DOWNSTREAM)) {
+            goto error;
+        }
+
+        if (!dev_iter->exp.aer_cap) {
+            goto error;
+        }
+
+        dev_iter = pci_bridge_get_device(dev_iter->bus);
+    }
+
+    errcap = vfio_pci_read_config(pdev, pos + PCI_ERR_CAP, 4);
+    /*
+     * The ability to record multiple headers is depending on
+     * the state of the Multiple Header Recording Capable bit and
+     * enabled by the Multiple Header Recording Enable bit.
+     */
+    if ((errcap & PCI_ERR_CAP_MHRC) &&
+        (errcap & PCI_ERR_CAP_MHRE)) {
+        pdev->exp.aer_log.log_max = PCIE_AER_LOG_MAX_DEFAULT;
+    } else {
+        pdev->exp.aer_log.log_max = 0;
+    }
+
+    pcie_cap_deverr_init(pdev);
+    return pcie_aer_init(pdev, cap_ver, pos, size);
+
+error:
+    error_setg(errp, "vfio: Unable to enable AER for device %s, parent bus "
+               "does not support AER signaling", vdev->vbasedev.name);
+    return -1;
+}
+
+static int vfio_add_ext_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
     uint32_t header;
     uint16_t cap_id, next, size;
     uint8_t cap_ver;
     uint8_t *config;
+    int ret = 0;
 
     /* Only add extended caps if we have them and the guest can see them */
     if (!pci_is_express(pdev) || !pci_bus_is_express(pdev->bus) ||
         !pci_get_long(pdev->config + PCI_CONFIG_SPACE_SIZE)) {
-        return;
+        return 0;
     }
 
     /*
@@ -1911,6 +1974,9 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
                                    PCI_EXT_CAP_NEXT_MASK);
 
         switch (cap_id) {
+        case PCI_EXT_CAP_ID_ERR:
+            ret = vfio_setup_aer(vdev, cap_ver, next, size, errp);
+            break;
         case PCI_EXT_CAP_ID_SRIOV: /* Read-only VF BARs confuse OVMF */
         case PCI_EXT_CAP_ID_ARI: /* XXX Needs next function virtualization */
             trace_vfio_add_ext_cap_dropped(vdev->vbasedev.name, cap_id, next);
@@ -1919,6 +1985,9 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
         }
 
+        if (ret) {
+            goto out;
+        }
     }
 
     /* Cleanup chain head ID if necessary */
@@ -1926,8 +1995,9 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
     }
 
+out:
     g_free(config);
-    return;
+    return ret;
 }
 
 static int vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
@@ -1945,8 +2015,8 @@ static int vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
         return ret;
     }
 
-    vfio_add_ext_cap(vdev);
-    return 0;
+    ret = vfio_add_ext_cap(vdev, errp);
+    return ret;
 }
 
 static void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
@@ -2769,6 +2839,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
+    if ((vdev->features & VFIO_FEATURE_ENABLE_AER) &&
+        !pdev->exp.aer_cap) {
+        error_setg(errp, "vfio: Unable to enable AER for device %s, device "
+                   "does not support AER signaling", vdev->vbasedev.name);
+        return;
+    }
+
     if (vdev->vga) {
         vfio_vga_quirk_setup(vdev);
     }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a8366bb..64701c4 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -15,6 +15,7 @@
 #include "qemu-common.h"
 #include "exec/memory.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/vfio/vfio-common.h"
 #include "qemu/event_notifier.h"
 #include "qemu/queue.h"
@@ -132,6 +133,8 @@ typedef struct VFIOPCIDevice {
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT 2
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
+#define VFIO_FEATURE_ENABLE_AER_BIT 3
+#define VFIO_FEATURE_ENABLE_AER (1 << VFIO_FEATURE_ENABLE_AER_BIT)
     int32_t bootindex;
     uint32_t igd_gms;
     uint8_t pm_cap;
-- 
1.8.3.1
