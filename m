Received: from eggs.gnu.org ([2001:4830:134:3::10]:44338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqX-00086F-O7
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqW-0001O5-F5
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:33 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:25:05 +1100
Message-Id: <20170303032507.16142-16-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/17] spapr_pci: Advertise access to PCIe
 extended config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The (paravirtual) PCI host bridge on the 'pseries' machine in most
regards acts like a regular PCI bus, rather than a PCIe bus.  Despite
this, though, it does allow access to the PCIe extended config space.

We already implemented the RTAS methods to allow this access.. but
forgot to put the markers into the device tree so that guest's know it
is there.  This adds them in.

With this, a pseries guest is able to view extended config space on
(for example an e1000e device.  This should be enough to allow guests
to use at least some PCIe devices.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 2a3499e..919d3c2 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1321,6 +1321,10 @@ static int spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
     _FDT(fdt_setprop(fdt, offset, "assigned-addresses",
                      (uint8_t *)rp.assigned, rp.assigned_len));
 
+    if (pci_is_express(dev)) {
+        _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", 0x1));
+    }
+
     return 0;
 }
 
-- 
2.9.3
