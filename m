Received: from eggs.gnu.org ([2001:4830:134:3::10]:60628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQn-0007zv-Va
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQl-0003H5-M7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQl-0003GI-CH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:55 -0500
Date: Mon, 5 Nov 2018 13:16:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-24-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 23/33] hw/pci-host/x86: extend the 64-bit PCI
 hole relative to the fw-assigned base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Laszlo Ersek <lersek@redhat.com>

In commit 9fa99d2519cb ("hw/pci-host: Fix x86 Host Bridges 64bit PCI
hole", 2017-11-16), we meant to expose such a 64-bit PCI MMIO aperture in
the ACPI DSDT that would be at least as large as the new "pci-hole64-size"
property (2GB on i440fx, 32GB on q35). The goal was to offer "enough"
64-bit MMIO aperture to the guest OS for hotplug purposes.

In that commit, we added or modified five functions:

- pc_pci_hole64_start(): shared between i440fx and q35. Provides a default
  64-bit base, which starts beyond the cold-plugged 64-bit RAM, and skips
  the DIMM hotplug area too (if any).

- i440fx_pcihost_get_pci_hole64_start(), q35_host_get_pci_hole64_start():
  board-specific 64-bit base property getters called abstractly by the
  ACPI generator. Both of these fall back to pc_pci_hole64_start() if the
  firmware didn't program any 64-bit hole (i.e. if the firmware didn't
  assign a 64-bit GPA to any MMIO BAR on any device). Otherwise, they
  honor the firmware's BAR assignments (i.e., they treat the lowest 64-bit
  GPA programmed by the firmware as the base address for the aperture).

- i440fx_pcihost_get_pci_hole64_end(), q35_host_get_pci_hole64_end():
  these intended to extend the aperture to our size recommendation,
  calculated relative to the base of the aperture.

Despite the original intent, i440fx_pcihost_get_pci_hole64_end() and
q35_host_get_pci_hole64_end() currently only extend the aperture relative
to the default base (pc_pci_hole64_start()), ignoring any programming done
by the firmware. This means that our size recommendation may not be met.
Fix it by honoring the firmware's address assignments.

The strange extension sizes were spotted by Alex, in the log of a guest
kernel running on top of OVMF (which prefers to assign 64-bit GPAs to
64-bit BARs).

This change only affects DSDT generation, therefore no new compat property
is being introduced.

Using an i440fx OVMF guest with 5GB RAM, an example _CRS change is:

> @@ -881,9 +881,9 @@
>              QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
>                  0x0000000000000000, // Granularity
>                  0x0000000800000000, // Range Minimum
> -                0x000000080001C0FF, // Range Maximum
> +                0x000000087FFFFFFF, // Range Maximum
>                  0x0000000000000000, // Translation Offset
> -                0x000000000001C100, // Length
> +                0x0000000080000000, // Length
>                  ,, , AddressRangeMemory, TypeStatic)
>          })
>          Device (GPE0)

(On i440fx, the low RAM split is at 3GB, in this case. Therefore, with 5GB
guest RAM and no DIMM hotplug range, pc_pci_hole64_start() returns 4 +
(5-3) = 6 GB. Adding the 2GB extension to that yields 8GB, which is below
the firmware-programmed base of 32GB, before the patch. Therefore, before
the patch, the extension is ineffective. After the patch, we add the 2GB
extension to the firmware-programmed base, namely 32GB.)

Using a q35 OVMF guest with 5GB RAM, an example _CRS change is:

> @@ -3162,9 +3162,9 @@
>              QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
>                  0x0000000000000000, // Granularity
>                  0x0000000800000000, // Range Minimum
> -                0x00000009BFFFFFFF, // Range Maximum
> +                0x0000000FFFFFFFFF, // Range Maximum
>                  0x0000000000000000, // Translation Offset
> -                0x00000001C0000000, // Length
> +                0x0000000800000000, // Length
>                  ,, , AddressRangeMemory, TypeStatic)
>          })
>          Device (GPE0)

(On Q35, the low RAM split is at 2GB. Therefore, with 5GB guest RAM and no
DIMM hotplug range, pc_pci_hole64_start() returns 4 + (5-2) = 7 GB. Adding
the 32GB extension to that yields 39GB (0x0000_0009_BFFF_FFFF + 1), before
the patch. After the patch, we add the 32GB extension to the
firmware-programmed base, namely 32GB.)

The ACPI test data for the bios-tables-test case that we added earlier in
this series are corrected too, as follows:

> @@ -3339,9 +3339,9 @@
>              QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
>                  0x0000000000000000, // Granularity
>                  0x0000000200000000, // Range Minimum
> -                0x00000009BFFFFFFF, // Range Maximum
> +                0x00000009FFFFFFFF, // Range Maximum
>                  0x0000000000000000, // Translation Offset
> -                0x00000007C0000000, // Length
> +                0x0000000800000000, // Length
>                  ,, , AddressRangeMemory, TypeStatic)
>          })
>          Device (GPE0)

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Fixes: 9fa99d2519cbf71f871e46871df12cb446dc1c3e
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/piix.c | 2 +-
 hw/pci-host/q35.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index ce271da9b0..ec5441583a 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -285,7 +285,7 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
-    uint64_t hole64_start = pc_pci_hole64_start();
+    uint64_t hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
     Range w64;
     uint64_t value, hole64_end;
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index ceb00f7706..0c38a8dfd3 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -149,7 +149,7 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     Q35PCIHost *s = Q35_HOST_DEVICE(obj);
-    uint64_t hole64_start = pc_pci_hole64_start();
+    uint64_t hole64_start = q35_host_get_pci_hole64_start_value(obj);
     Range w64;
     uint64_t value, hole64_end;
 
-- 
MST
