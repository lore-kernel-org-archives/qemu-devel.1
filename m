Received: from eggs.gnu.org ([2001:4830:134:3::10]:33793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fO23e-0003ue-Oj
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fO23d-0000LW-Ml
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:26:34 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 30 May 2018 16:26:18 +0200
Message-Id: <1527690380-9782-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] ARM virt: Support up to 256 PCIe buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, ard.biesheuvel@linaro.org

Current Machvirt PCI host controller's ECAM region is 16MB large.
This limits the number of PCIe buses to 16.

PC/Q35 machines have a 256MB region allowing up to 256 buses.
This series tries to bridge the gap.

It declares a new ECAM region located beyond 256GB, of size 256MB
The new ECAM region is used if:
- highmem option is set (default) and,
- either FW is not loaded or we are run an aarch64 guest
- machine type >= 3.0.

aarch32 FW does not support this highmem ECAM region. For guests without
LPAE support the highmem option must be turned off.

Best Regards

Eric

Git: complete series available at
https://github.com/eauger/qemu/tree/v2.12.0-256MB-ECAM-PATCH-v1
Previous version:
https://github.com/eauger/qemu/tree/v2.12.0-256MB-ECAM-RFCv1

- Tested with guest running in aarch64 and aarch32 modes (aarch64=off)
- Tested with aarch32 FW
- In aarch32 mode I encountered the issue the vmalloc region may be
  reported too small for the needs (dmesg excerpt below). So I had to
  extend the vmalloc size by passing the "vmalloc=512M" option to the
  bootargs and this eventually booted fine.

[    1.399581] pl061_gpio 9030000.pl061: PL061 GPIO chip @0x0000000009030000 registered
[    1.402636] OF: PCI: host bridge /pcie@10000000 ranges:
[    1.404506] OF: PCI:    IO 0x3eff0000..0x3effffff -> 0x00000000
[    1.406606] OF: PCI:   MEM 0x10000000..0x3efeffff -> 0x10000000
[    1.408690] OF: PCI:   MEM 0x8000000000..0xffffffffff -> 0x8000000000
[    1.411992] vmap allocation for size 1052672 failed: use vmalloc=<size> to increase size
[    1.414895] pci-host-generic 4010000000.pcie: ECAM ioremap failed
[    1.427472] pci-host-generic: probe of 4010000000.pcie failed with error -12


Eric Auger (2):
  hw/arm/virt: Add a new 256MB ECAM region
  hw/arm/virt: Add virt-3.0 machine type

 hw/arm/virt-acpi-build.c | 21 +++++++++++++--------
 hw/arm/virt.c            | 43 ++++++++++++++++++++++++++++++++++++-------
 include/hw/arm/virt.h    |  3 +++
 3 files changed, 52 insertions(+), 15 deletions(-)

-- 
2.5.5
