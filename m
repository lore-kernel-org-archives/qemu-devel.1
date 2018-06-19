Received: from eggs.gnu.org ([2001:4830:134:3::10]:42758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVFQC-0000ua-LR
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVFQB-0003Cl-TY
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:07:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fVFQB-0003A9-Ll
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:07:39 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 13:07:30 +0100
Message-Id: <20180619120730.32586-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/pci-host/xilinx-pcie: don't make "io"
 region be RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paul Burton <paul.burton@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>

Currently we use memory_region_init_rom_nomigrate() to create
the "io" memory region to pass to pci_register_root_bus().
This is a dummy region, because this PCI controller doesn't
support accesses to PCI IO space.

There is no reason for the dummy region to be a RAM region;
it is only used as a place where PCI BARs can be mapped,
and if you could get a PCI card to do a bus master access
to the IO space it should not get acts-like-RAM behaviour.
Use a simple container memory region instead. (We do have
one PCI card model which can do bus master accesses to IO
space -- the LSI53C895A SCSI adaptor.)

This avoids the oddity of having a memory region which is
RAM but where the RAM is not migrated.

Note that the size of the region we use here has no
effect on behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/xilinx-pcie.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 044e312dc18..b0a31b917d8 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -120,9 +120,8 @@ static void xilinx_pcie_host_realize(DeviceState *dev, Error **errp)
     memory_region_init(&s->mmio, OBJECT(s), "mmio", UINT64_MAX);
     memory_region_set_enabled(&s->mmio, false);
 
-    /* dummy I/O region */
-    memory_region_init_ram_nomigrate(&s->io, OBJECT(s), "io", 16, NULL);
-    memory_region_set_enabled(&s->io, false);
+    /* dummy PCI I/O region (not visible to the CPU) */
+    memory_region_init(&s->io, OBJECT(s), "io", 16);
 
     /* interrupt out */
     qdev_init_gpio_out_named(dev, &s->irq, "interrupt_out", 1);
-- 
2.17.1
