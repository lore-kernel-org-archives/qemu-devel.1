Received: from eggs.gnu.org ([2001:4830:134:3::10]:45651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gMUGt-00036a-BE
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gMU6y-0006b5-2L
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:31:53 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 13 Nov 2018 19:31:01 +1100
Message-Id: <20181113083104.2692-5-aik@ozlabs.ru>
In-Reply-To: <20181113083104.2692-1-aik@ozlabs.ru>
References: <20181113083104.2692-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu RFC 4/7] vfio/nvidia-v100: Disable VBIOS
 update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>

The NVIDIA V100 GPUs often come in several instances on the same system
board where they are connected directly via out of band fabric called
"NVLink".

In order to make GPUs talk to each other, NVLink has to be enabled on
both GPUs and this is guaranteed by the firmware by providing special
MMIO registers to disable NVLink till GPU is reset.

This blocks GPU VBIOS update to add an extra level of assurance that
the firmware does not get reflashed with a malicious firmware which
does not implement NVLink disabling mechanism.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

NVIDIA firmwares come signed and GPUs do not accept unsigned images
anyway so this is probably overkill, or not?

Also, there is no available documentation on the magic value of 0x22408;
however it does help as the nvflash upgrade tool stops working with this
applied.
---
 hw/vfio/pci.h            |  1 +
 include/hw/pci/pci_ids.h |  1 +
 hw/vfio/pci-quirks.c     | 26 ++++++++++++++++++++++++++
 hw/vfio/pci.c            |  2 ++
 hw/vfio/trace-events     |  1 +
 5 files changed, 31 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index b1ae4c0..f4c5fb6 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -163,6 +163,7 @@ typedef struct VFIOPCIDevice {
     bool no_kvm_msi;
     bool no_kvm_msix;
     bool no_geforce_quirks;
+    bool no_nvidia_v100_quirks;
     bool no_kvm_ioeventfd;
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 3ed7d10..2140dad 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -272,5 +272,6 @@
 #define PCI_VENDOR_ID_SYNOPSYS           0x16C3
 
 #define PCI_VENDOR_ID_NVIDIA             0x10de
+#define PCI_VENDOR_ID_NVIDIA_V100_SXM2   0x1db1
 
 #endif
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 40a1200..2796837 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -996,6 +996,31 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     trace_vfio_quirk_nvidia_bar0_probe(vdev->vbasedev.name);
 }
 
+static void vfio_probe_nvidia_v100_bar0_quirk(VFIOPCIDevice *vdev, int nr)
+{
+    VFIOQuirk *quirk;
+
+    if (vdev->no_nvidia_v100_quirks ||
+        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA,
+                     PCI_VENDOR_ID_NVIDIA_V100_SXM2) ||
+        nr != 0) {
+        return;
+    }
+
+    quirk = vfio_quirk_alloc(1);
+
+    memory_region_init_io(quirk->mem, OBJECT(vdev),
+                          NULL, quirk,
+                          "vfio-nvidia-v100_bar0-block-quirk",
+                          4);
+    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                        0x22408, quirk->mem, 1);
+
+    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
+
+    trace_vfio_quirk_nvidia_v100_bar0_probe(vdev->vbasedev.name);
+}
+
 /*
  * TODO - Some Nvidia devices provide config access to their companion HDA
  * device and even to their parent bridge via these config space mirrors.
@@ -1853,6 +1878,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
     vfio_probe_ati_bar2_quirk(vdev, nr);
     vfio_probe_nvidia_bar5_quirk(vdev, nr);
     vfio_probe_nvidia_bar0_quirk(vdev, nr);
+    vfio_probe_nvidia_v100_bar0_quirk(vdev, nr);
     vfio_probe_rtl8168_bar2_quirk(vdev, nr);
     vfio_probe_igd_bar4_quirk(vdev, nr);
 }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5c7bd96..7848b28 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3203,6 +3203,8 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
     DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
                      no_geforce_quirks, false),
+    DEFINE_PROP_BOOL("x-no-nvidia-v100-quirks", VFIOPCIDevice,
+                     no_nvidia_v100_quirks, false),
     DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
                      false),
     DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index db730f3..adfa75e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -68,6 +68,7 @@ vfio_quirk_nvidia_bar5_state(const char *name, const char *state) "%s %s"
 vfio_quirk_nvidia_bar5_probe(const char *name) "%s"
 vfio_quirk_nvidia_bar0_msi_ack(const char *name) "%s"
 vfio_quirk_nvidia_bar0_probe(const char *name) "%s"
+vfio_quirk_nvidia_v100_bar0_probe(const char *name) "%s"
 vfio_quirk_rtl8168_fake_latch(const char *name, uint64_t val) "%s 0x%"PRIx64
 vfio_quirk_rtl8168_msix_write(const char *name, uint16_t offset, uint64_t val) "%s MSI-X table write[0x%x]: 0x%"PRIx64
 vfio_quirk_rtl8168_msix_read(const char *name, uint16_t offset, uint64_t val) "%s MSI-X table read[0x%x]: 0x%"PRIx64
-- 
2.17.1
