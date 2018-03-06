Received: from eggs.gnu.org ([2001:4830:134:3::10]:42430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJF4-0000T6-U0
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJF1-0005UT-PV
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:31:22 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 20:30:44 +0000
Message-Id: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 00/19] uninorth fixes/mac_newworld board wiring
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

[This is for New World Machines: there is a follow-up patch for Old World Machines]

This patchset is a combination of uninorth fixes/cleanup with the final aim
of removing the remaining custom init functions and switching IRQ arrays over
to qdev GPIOs.

The first couple of patches apply some style fixups and remove what appears to
be an obsolete set of uninorth registers according to my testing.

Following on from this, the next few patches QOMify the PCI/AGP host bridges
and change the existing _init() functions to return the device itself. This
allows the memory regions to be setup during device init, and using a temporary
qdev pointer property allows moving the remaining initialisation to device
realize.

Next we fix the mixup between the PCI/AGP host bridges making sure that the correct
PCI bus instance is instantiated for the corresponding host bridge , and enabling
the third PCI host bridge. This allows potential handling of any accesses although
it should be ignored for all OSs that correctly parse the DT since OpenBIOS currently
only supports (and exposes) a single PCI host bridge.

Once the legacy _init() functions have been removed and all devices are
instantiated via the qdev API, it is then possible to wire up the PCI IO
space to the relevant PCI bus.

After this we implement a separate uninorth device (equivalent to uni-n in the
Mac New World DT) as suggested by the TODO comment and wire it up as part of the
board initialisation.

Finally once this is done we can remove the temporary pics IRQ array and instead
wire up the macio_newworld device to the PIC directly using the existing object
link.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (19):
  uninorth: trivial style fixups
  uninorth: remove second set of uninorth token registers
  uninorth: QOMify PCI and AGP host bridges
  uninorth: remove stray PCIBus realize from mac_newworld.c
  uninorth: move uninorth definitions into uninorth.h
  uninorth: alter pci_pmac_init() and pci_pmac_u3_init() to return
    uninorth device
  uninorth: move PCI mmio memory region initialisation into init
    function
  uninorth: introduce temporary pic_irqs device property
  uninorth: move PCI host bridge bus initialisation into device realize
  uninorth: fix PCI and AGP bus mixup
  uninorth: enable internal PCI host bridge
  uninorth: remove obsolete pci_pmac_init() function
  uninorth: remove obsolete pci_pmac_u3_init() function
  uninorth: use object link to pass OpenPIC object to uninorth
  uninorth: move PCI IO (ISA) memory region into the uninorth device
  uninorth: rename UNINState to UNINHostState
  uninorth: create new uninorth device
  mac_newworld: remove pics IRQ array and wire up macio to OpenPIC
    directly
  mac_newworld: move wiring of macio IRQs to macio_newworld_realize()

 hw/misc/macio/macio.c          |  37 ++--
 hw/pci-host/trace-events       |   2 +
 hw/pci-host/uninorth.c         | 415 ++++++++++++++++++++++++-----------------
 hw/ppc/mac.h                   |  20 +-
 hw/ppc/mac_newworld.c          | 124 ++++++------
 hw/ppc/trace-events            |   4 -
 include/hw/misc/macio/macio.h  |   1 -
 include/hw/pci-host/uninorth.h |  65 +++++++
 8 files changed, 404 insertions(+), 264 deletions(-)
 create mode 100644 include/hw/pci-host/uninorth.h

-- 
2.11.0
