Received: from eggs.gnu.org ([2001:4830:134:3::10]:51677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJA-0005cC-0O
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ8-0000Y2-KH
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJ8-0000Q4-DW
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:46 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ4-0002zU-5W
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:42 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:17 +0100
Message-Id: <20180504171540.25813-2-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/24] hw/arm/virt: Add linux,
 pci-domain property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to pin the host controller in the Linux PCI domain space.
Linux requires that property to be available consistently or not at all,
in which case the domain number becomes unstable on additions/removals.
Adding it here won't make a difference in practice for most setups as we
only expose one controller.

However, enabling Jailhouse on top may introduce another controller, and
that one would like to have stable address as well. So the property is
needed for the first controller as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-id: 3301c5bc-7b47-1b0e-8ce4-30435057a276@web.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a18291c5d5..dc0c0335a2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1023,6 +1023,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
     qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "pci");
     qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 3);
     qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 2);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "linux,pci-domain", 0);
     qemu_fdt_setprop_cells(vms->fdt, nodename, "bus-range", 0,
                            nr_pcie_buses - 1);
     qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
-- 
2.17.0
