Received: from eggs.gnu.org ([2001:4830:134:3::10]:47832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dKluz-0007fF-Ja
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dKluy-0008E6-M3
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:31:37 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 13 Jun 2017 15:31:14 +0200
Message-Id: <1497360677-4780-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] Generic PCIe host bridge INTx
 determination for INTx routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: christoffer.dall@linaro.org, agraf@suse.de, pranavkumar@linaro.org, drjones@redhat.com, wei@redhat.com

This series implements INTx to gsi routing for ARM VIRT/GPEX. This is
a respin of [1] which was lost in limbo.

ARM virt uses GPEX PCIe bridge. This latter does not implement INTx
to GSI routing. PCIe/INTx assignment works but the consequence is
irqfd is not used along with INTx interrupts and VFIO INTx handlers
are executed on userspace leading to an important performance degradation.

This issue is witnessed by the following messages;

qemu-system-aarch64: -device vfio-pci,host=0006:90:00.0: PCI: Bug -
unimplemented PCI INTx routing (gpex-pcihost)
qemu-system-aarch64: PCI: Bug - unimplemented PCI INTx routing (gpex-pcihost)
qemu-system-aarch64: PCI: Bug - unimplemented PCI INTx routing (gpex-pcihost)

So with this series, irqfd is set up for PCIe/INTx passthrough and we get
the optimal performance. Also we get rid of the above messages.

This series can be found at:
https://github.com/eauger/qemu/tree/v2.9-gpex-intx-v3

References:
[1] Generic PCIe host bridge INTx determination for INTx routing
   https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg04975.html

Pranavkumar Sawargaonkar (3):
  hw/pci-host/gpex: Set INTx index/gsi mapping
  hw/arm/virt: Set INTx/gsi mapping
  hw/pci-host/gpex: Implement PCI INTx routing

 hw/arm/virt.c              |  4 ++++
 hw/pci-host/gpex.c         | 22 ++++++++++++++++++++++
 include/hw/pci-host/gpex.h |  3 +++
 3 files changed, 29 insertions(+)

-- 
2.5.5
