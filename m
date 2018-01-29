Received: from eggs.gnu.org ([2001:4830:134:3::10]:34099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1egFyD-0003ZO-Ie
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1egFy9-0006ys-JB
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:24:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1egFy9-0006yR-B3
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:23:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1384780DB
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 20:23:55 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 29 Jan 2018 13:23:50 -0700
Message-ID: <20180129202326.9417.71344.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vfio/pci: Add option to disable GeForce quirks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com

These quirks are necessary for GeForce, but not for Quadro/GRID/Tesla
assignment.  Leaving them enabled is fully functional and provides the
most compatibility, but due to the unique NVIDIA MSI ACK behavior[1],
it also introduces latency in re-triggering the MSI interrupt.  This
overhead is typically negligible, but has been shown to adversely
affect some (very) high interrupt rate applications.  This adds the
vfio-pci device option "x-no-geforce-quirks=" which can be set to
"on" to disable this additional overhead.

A follow-on optimization for GeForce might be to make use of an
ioeventfd to allow KVM to trigger an irqfd in the kernel vfio-pci
driver, avoiding the bounce through userspace to handle this device
write.

[1] Background: the NVIDIA driver has been observed to write 0xff to
the read-only MSI capability ID register via the MMIO mirror of PCI
config space in order for the MSI interrupt to re-trigger.  This PCI
config space mirror is virtualized in QEMU for GeForce.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |    9 ++++++---
 hw/vfio/pci.c        |    2 ++
 hw/vfio/pci.h        |    1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 60ad5fb91a83..e5779a7ad35b 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -542,7 +542,8 @@ static void vfio_vga_probe_nvidia_3d0_quirk(VFIOPCIDevice *vdev)
     VFIOQuirk *quirk;
     VFIONvidia3d0Quirk *data;
 
-    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
+    if (vdev->no_geforce_quirks ||
+        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
         !vdev->bars[1].region.size) {
         return;
     }
@@ -660,7 +661,8 @@ static void vfio_probe_nvidia_bar5_quirk(VFIOPCIDevice *vdev, int nr)
     VFIONvidiaBAR5Quirk *bar5;
     VFIOConfigWindowQuirk *window;
 
-    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
+    if (vdev->no_geforce_quirks ||
+        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
         !vdev->vga || nr != 5 || !vdev->bars[5].ioport) {
         return;
     }
@@ -754,7 +756,8 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     VFIOQuirk *quirk;
     VFIOConfigMirrorQuirk *mirror;
 
-    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
+    if (vdev->no_geforce_quirks ||
+        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
         !vfio_is_vga(vdev) || nr != 0) {
         return;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2c7129512563..6d260b92c1e1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2989,6 +2989,8 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
     DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
     DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
+    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
+                     no_geforce_quirks, false),
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice, vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice, device_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a8fb3b34222c..7c55087a1c44 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -142,6 +142,7 @@ typedef struct VFIOPCIDevice {
     bool no_kvm_intx;
     bool no_kvm_msi;
     bool no_kvm_msix;
+    bool no_geforce_quirks;
 } VFIOPCIDevice;
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
