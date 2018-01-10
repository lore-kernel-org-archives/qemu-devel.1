Received: from eggs.gnu.org ([2001:4830:134:3::10]:55111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eZLeG-0004fr-Jq
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eZLeB-0004Mm-KF
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eZLeB-0004ME-4I
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:47 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 10 Jan 2018 12:02:36 -0700
Message-ID: <20180110190236.5389.58765.stgit@gimli.home>
In-Reply-To: <20180110190049.5389.12984.stgit@gimli.home>
References: <20180110190049.5389.12984.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 5/5] vfio/pci: Allow relocating MSI-X MMIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, aik@ozlabs.ru

Recently proposed vfio-pci kernel changes (v4.16) remove the
restriction preventing userspace from mmap'ing PCI BARs in areas
overlapping the MSI-X vector table.  This change is primarily intended
to benefit host platforms which make use of system page sizes larger
than the PCI spec recommendation for alignment of MSI-X data
structures (ie. not x86_64).  In the case of POWER systems, the SPAPR
spec requires the VM to program MSI-X using hypercalls, rendering the
MSI-X vector table unused in the VM view of the device.  However,
ARM64 platforms also support 64KB pages and rely on QEMU emulation of
MSI-X.  Regardless of the kernel driver allowing mmaps overlapping
the MSI-X vector table, emulation of the MSI-X vector table also
prevents direct mapping of device MMIO spaces overlapping this page.
Thanks to the fact that PCI devices have a standard self discovery
mechanism, we can try to resolve this by relocating the MSI-X data
structures, either by creating a new PCI BAR or extending an existing
BAR and updating the MSI-X capability for the new location.  There's
even a very slim chance that this could benefit devices which do not
adhere to the PCI spec alignment guidelines on x86_64 systems.

This new x-msix-relocation option accepts the following choices:

  off: Disable MSI-X relocation, use native device config (default)
  auto: Use a known good combination for the platform/device (none yet)
  bar0..bar5: Specify the target BAR for MSI-X data structures

If compatible, the target BAR will either be created or extended and
the new portion will be used for MSI-X emulation.

The first obvious user question with this option is how to determine
whether a given platform and device might benefit from this option.
In most cases, the answer is that it won't, especially on x86_64.
Devices often dedicate an entire BAR to MSI-X and therefore no
performance sensitive registers overlap the MSI-X area.  Take for
example:

# lspci -vvvs 0a:00.0
0a:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection
	...
	Region 0: Memory at db680000 (32-bit, non-prefetchable) [size=512K]
	Region 3: Memory at db7f8000 (32-bit, non-prefetchable) [size=16K]
	...
	Capabilities: [70] MSI-X: Enable+ Count=10 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000

This device uses the 16K bar3 for MSI-X with the vector table at
offset zero and the pending bits arrary at offset 8K, fully honoring
the PCI spec alignment guidance.  The data sheet specifically refers
to this as an MSI-X BAR.  This device would not see a benefit from
MSI-X relocation regardless of the platform, regardless of the page
size.

However, here's another example:

# lspci -vvvs 02:00.0
02:00.0 Serial Attached SCSI controller: xxxxxxxx
	...
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at ef640000 (64-bit, non-prefetchable) [size=64K]
	Region 3: Memory at ef600000 (64-bit, non-prefetchable) [size=256K]
	...
	Capabilities: [c0] MSI-X: Enable+ Count=16 Masked-
		Vector table: BAR=1 offset=0000e000
		PBA: BAR=1 offset=0000f000

Here the MSI-X data structures are placed on separate 4K pages at the
end of a 64KB BAR.  If our host page size is 4K, we're likely fine,
but at 64KB page size, MSI-X emulation at that location prevents the
entire BAR from being directly mapped into the VM address space.
Overlapping performance sensitive registers then starts to be a very
likely scenario on such a platform.  At this point, the user could
enable tracing on vfio_region_read and vfio_region_write to determine
more conclusively if device accesses are being trapped through QEMU.

Upon finding a device and platform in need of MSI-X relocation, the
next problem is how to choose target PCI BAR to host the MSI-X data
structures.  A few key rules to keep in mind for this selection
include:

 * There are only 6 BAR slots, bar0..bar5
 * 64-bit BARs occupy two BAR slots, 'lspci -vvv' lists the first slot
 * PCI BARs are always a power of 2 in size, extending == doubling
 * The maximum size of a 32-bit BAR is 2GB
 * MSI-X data structures must reside in an MMIO BAR

Using these rules, we can evaluate each BAR of the second example
device above as follows:

 bar0: I/O port BAR, incompatible with MSI-X tables
 bar1: BAR could be extended, incurring another 64KB of MMIO
 bar2: Unavailable, bar1 is 64-bit, this register is used by bar1
 bar3: BAR could be extended, incurring another 256KB of MMIO
 bar4: Unavailable, bar3 is 64bit, this register is used by bar3
 bar5: Available, empty BAR, minimum additional MMIO

A secondary optimization we might wish to make in relocating MSI-X
is to minimize the additional MMIO required for the device, therefore
we might test the available choices in order of preference as bar5,
bar1, and finally bar3.  The original proposal for this feature
included an 'auto' option which would choose bar5 in this case, but
various drivers have been found that make assumptions about the
properties of the "first" BAR or the size of BARs such that there
appears to be no foolproof automatic selection available, requiring
known good combinations to be sourced from users.  This patch is
pre-enabled for an 'auto' selection making use of a validated lookup
table, but no entries are yet identified.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c        |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h        |    1 
 hw/vfio/trace-events |    2 +
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 20252ea7aeb7..7171ba18213c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1352,6 +1352,100 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
     }
 }
 
+static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
+{
+    int target_bar = -1;
+    size_t msix_sz;
+
+    if (!vdev->msix || vdev->msix_relo == OFF_AUTOPCIBAR_OFF) {
+        return;
+    }
+
+    /* The actual minimum size of MSI-X structures */
+    msix_sz = (vdev->msix->entries * PCI_MSIX_ENTRY_SIZE) +
+              (QEMU_ALIGN_UP(vdev->msix->entries, 64) / 8);
+    /* Round up to host pages, we don't want to share a page */
+    msix_sz = REAL_HOST_PAGE_ALIGN(msix_sz);
+    /* PCI BARs must be a power of 2 */
+    msix_sz = pow2ceil(msix_sz);
+
+    if (vdev->msix_relo == OFF_AUTOPCIBAR_AUTO) {
+        /*
+         * TODO: Lookup table for known devices.
+         *
+         * Logically we might use an algorithm here to select the BAR adding
+         * the least additional MMIO space, but we cannot programatically
+         * predict the driver dependency on BAR ordering or sizing, therefore
+         * 'auto' becomes a lookup for combinations reported to work.
+         */
+        if (target_bar < 0) {
+            error_setg_errno(errp, EINVAL, "No automatic MSI-X relocation "
+                             "available for device %04x:%04x",
+                             vdev->vendor_id, vdev->device_id);
+            return;
+        }
+    } else {
+        target_bar = (int)(vdev->msix_relo - OFF_AUTOPCIBAR_BAR0);
+    }
+
+    /* I/O port BARs cannot host MSI-X structures */
+    if (vdev->bars[target_bar].ioport) {
+        error_setg_errno(errp, EINVAL, "Invalid MSI-X relocation BAR %d, "
+                         "I/O port BAR", target_bar);
+        return;
+    }
+
+    /* Cannot use a BAR in the "shadow" of a 64-bit BAR */
+    if (!vdev->bars[target_bar].size &&
+         target_bar > 0 && vdev->bars[target_bar - 1].mem64) {
+        error_setg_errno(errp, EINVAL, "Invalid MSI-X relocation BAR %d, "
+                         "consumed by 64-bit BAR %d", target_bar,
+                         target_bar - 1);
+        return;
+    }
+
+    /* 2GB max size for 32-bit BARs */
+    if (vdev->bars[target_bar].size > (1 * 1024 * 1024 * 1024) &&
+        !vdev->bars[target_bar].mem64) {
+        error_setg_errno(errp, EINVAL, "Invalid MSI-X relocation BAR %d, "
+                         "no space to extend 32-bit BAR", target_bar);
+        return;
+    }
+
+    /*
+     * If adding a new BAR, test if we can make it 64bit.  We make it
+     * prefetchable since QEMU MSI-X emulation has no read side effects
+     * and doing so makes mapping more flexible.
+     */
+    if (!vdev->bars[target_bar].size) {
+        if (target_bar < (PCI_ROM_SLOT - 1) &&
+            !vdev->bars[target_bar + 1].size) {
+            vdev->bars[target_bar].mem64 = true;
+            vdev->bars[target_bar].type = PCI_BASE_ADDRESS_MEM_TYPE_64;
+        }
+        vdev->bars[target_bar].type |= PCI_BASE_ADDRESS_MEM_PREFETCH;
+        vdev->bars[target_bar].size = msix_sz;
+        vdev->msix->table_offset = 0;
+    } else {
+        vdev->bars[target_bar].size = MAX(vdev->bars[target_bar].size * 2,
+                                          msix_sz * 2);
+        /*
+         * Due to above size calc, MSI-X always starts halfway into the BAR,
+         * which will always be a separate host page.
+         */
+        vdev->msix->table_offset = vdev->bars[target_bar].size / 2;
+    }
+
+    vdev->msix->table_bar = target_bar;
+    vdev->msix->pba_bar = target_bar;
+    /* Requires 8-byte alignment, but PCI_MSIX_ENTRY_SIZE guarantees that */
+    vdev->msix->pba_offset = vdev->msix->table_offset +
+                                  (vdev->msix->entries * PCI_MSIX_ENTRY_SIZE);
+
+    trace_vfio_msix_relo(vdev->vbasedev.name,
+                         vdev->msix->table_bar, vdev->msix->table_offset);
+}
+
 /*
  * We don't have any control over how pci_add_capability() inserts
  * capabilities into the chain.  In order to setup MSI-X we need a
@@ -1430,6 +1524,8 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     vdev->msix = msix;
 
     vfio_pci_fixup_msix_region(vdev);
+
+    vfio_pci_relocate_msix(vdev, errp);
 }
 
 static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
@@ -2845,13 +2941,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_pci_size_rom(vdev);
 
+    vfio_bars_prepare(vdev);
+
     vfio_msix_early_setup(vdev, &err);
     if (err) {
         error_propagate(errp, err);
         goto error;
     }
 
-    vfio_bars_prepare(vdev);
     vfio_bars_register(vdev);
 
     ret = vfio_add_capabilities(vdev, errp);
@@ -3041,6 +3138,8 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
                                    nv_gpudirect_clique,
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
+    DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
+                                OFF_AUTOPCIBAR_OFF),
     /*
      * TODO - support passed fds... is this necessary?
      * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index dcdb1a806769..588381f201b4 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -135,6 +135,7 @@ typedef struct VFIOPCIDevice {
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
     int32_t bootindex;
     uint32_t igd_gms;
+    OffAutoPCIBAR msix_relo;
     uint8_t pm_cap;
     uint8_t nv_gpudirect_clique;
     bool pci_aer;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index fae096c0724f..437ccdd29053 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -16,6 +16,8 @@ vfio_msix_pba_disable(const char *name) " (%s)"
 vfio_msix_pba_enable(const char *name) " (%s)"
 vfio_msix_disable(const char *name) " (%s)"
 vfio_msix_fixup(const char *name, int bar, uint64_t start, uint64_t end) " (%s) MSI-X region %d mmap fixup [0x%"PRIx64" - 0x%"PRIx64"]"
+vfio_msix_relo_cost(const char *name, int bar, uint64_t cost) " (%s) BAR %d cost 0x%"PRIx64""
+vfio_msix_relo(const char *name, int bar, uint64_t offset) " (%s) BAR %d offset 0x%"PRIx64""
 vfio_msi_enable(const char *name, int nr_vectors) " (%s) Enabled %d MSI vectors"
 vfio_msi_disable(const char *name) " (%s)"
 vfio_pci_load_rom(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s ROM:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
