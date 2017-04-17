Received: from eggs.gnu.org ([2001:4830:134:3::10]:54161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0EgB-0000KC-NG
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0Eg8-0005kp-NE
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0Eg8-0005ki-Gj
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Apr 2017 18:59:09 -0300
Message-Id: <20170417215916.12431-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 0/7] pci: Type-safety and phb->bus initialization
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

I've noticed that pci_bus_new*() and pci_register_bus() require
'parent' to be a PCI_HOST_BRIDGE object, but this is not clear
from the function signatures.

This series implements two changes in the PCI code:

1) Replace DeviceState with PCIHostState on functions that
   already require a PCI_HOST_BRIDGE argument. Makes the
   functions harder to misuse.
2) Move PCIHostState::bus initialization inside pci_bus_new*(),
   to avoid code duplication and make sure the field will be
   always initialized consistently.

Eduardo Habkost (7):
  pci: Change pci_host_bus_register() parameter to PCIHostState
  pci: Change pci_bus_init() 'parent' parameter to PCIHostState
  pci: Change pci_bus_new*() parameter to PCIHostState
  pci: Change pci_register_bus() 'parent' parameter to PCIHostState
  pci: Set phb->bus inside pci_register_bus()
  pci: Set phb->bus inside pci_bus_new()
  pci: Set phb->bus inside pci_bus_new_inplace()

 include/hw/pci/pci.h                | 17 ++++++++--------
 hw/alpha/typhoon.c                  | 10 +++++-----
 hw/mips/gt64xxx_pci.c               |  9 +++------
 hw/pci-bridge/pci_expander_bridge.c | 15 +++++++-------
 hw/pci-host/apb.c                   |  7 ++-----
 hw/pci-host/bonito.c                |  7 +++----
 hw/pci-host/gpex.c                  |  5 ++---
 hw/pci-host/grackle.c               |  9 ++-------
 hw/pci-host/piix.c                  |  3 +--
 hw/pci-host/ppce500.c               |  8 ++++----
 hw/pci-host/prep.c                  |  4 +---
 hw/pci-host/q35.c                   |  6 +++---
 hw/pci-host/uninorth.c              | 18 ++++++-----------
 hw/pci-host/versatile.c             |  3 +--
 hw/pci-host/xilinx-pcie.c           |  6 +++---
 hw/pci/pci.c                        | 40 ++++++++++++++++++-------------=
------
 hw/ppc/ppc4xx_pci.c                 |  8 ++++----
 hw/ppc/spapr_pci.c                  | 10 +++++-----
 hw/s390x/s390-pci-bus.c             | 10 +++++-----
 hw/sh4/sh_pci.c                     |  9 +++------
 20 files changed, 89 insertions(+), 115 deletions(-)

--=20
2.11.0.259.g40922b1
