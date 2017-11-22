Received: from eggs.gnu.org ([2001:4830:134:3::10]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHNPb-0001pW-42
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHNPX-0005DZ-W8
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:17:27 -0500
Received: from ozlabs.ru ([107.173.13.209]:59574)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHNPX-0005DR-Pw
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:17:23 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 22 Nov 2017 16:16:49 +1100
Message-Id: <20171122051649.3599-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] vfio: Allow configuration without INTx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

On some platforms INTx may not be enabled on a KVM host (one such
example is IBM pHyp hypervisor and this is intentional). However
the PCI_INTERRUPT_PIN is not 0 so QEMU tries initializing INTx, fails as
(!vdev->pdev->irq) in the VFIO's vfio_intx_enable() and this is
a fatal error.

This adds a debug switch - "x-no-intx" - in order to allow broken INTx
configuration.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

In practice, test teams run PR KVM under HV KVM and there INTx is enabled
on all levels so having this as a debug switch is enough.
---
 hw/vfio/pci.h | 1 +
 hw/vfio/pci.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 502a575..c5e168e 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -141,6 +141,7 @@ typedef struct VFIOPCIDevice {
     bool has_flr;
     bool has_pm_reset;
     bool rom_read_failed;
+    bool no_intx;
     bool no_kvm_intx;
     bool no_kvm_msi;
     bool no_kvm_msix;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c977ee3..c9caf6a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2869,7 +2869,12 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         pci_device_set_intx_routing_notifier(&vdev->pdev, vfio_intx_update);
         ret = vfio_intx_enable(vdev, errp);
         if (ret) {
-            goto out_teardown;
+            if (vdev->no_intx) {
+                error_report_err(*errp);
+                *errp = NULL;
+            } else {
+                goto out_teardown;
+            }
         }
     }
 
@@ -2986,6 +2991,7 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
+    DEFINE_PROP_BOOL("x-no-intx", VFIOPCIDevice, no_intx, false),
     DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
     DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
     DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
-- 
2.11.0
