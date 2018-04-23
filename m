Received: from eggs.gnu.org ([2001:4830:134:3::10]:59204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fATsC-00055E-Oh
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fATs8-0006tQ-PO
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:18:44 -0400
Received: from mout.web.de ([217.72.192.78]:53201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1fATs8-0006se-FK
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:18:40 -0400
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <3301c5bc-7b47-1b0e-8ce4-30435057a276@web.de>
Date: Mon, 23 Apr 2018 07:18:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] hw/arm/virt: Add linux,pci-domain property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

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
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 94dcb125d3..943371b75e 100644
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
2.13.6
