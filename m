Received: from eggs.gnu.org ([2001:4830:134:3::10]:56591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRH-0000bv-77
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRE-0002Ou-29
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0bRD-0002Oc-SE
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 18 Apr 2017 19:17:18 -0300
Message-Id: <20170418221724.5707-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 0/6] pci: Refactor PCI root bus creation code
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

Changes v1 -> v2:
* Original series subject:
  "pci: Type-safety and phb->bus initialization cleanup"
* In addition to changing function signatures, also rename the
  functions to pci_host_bus_init*()
* Inline pci_bus_init() and pci_host_bus_register() inside their
  callers
* Remove unnecessary PCIBus* variables

The purpose of the pci_bus_new*() and pci_register_bus() is not
clear from their signatures: they look like generic functions to
create PCI buss, but the functions work only when creating a root
bus in a PCI host bridge.

This series implements the following changes:

1) Rename pci_bus_new*() and pci_register_bus() to
   pci_host_bus_init*()
2) Replace DeviceState with PCIHostState on their argument type,
   because they already require a PCI_HOST_BRIDGE object
3) Move PCIHostState::bus initialization inside pci_host_bus_init*(),
   to avoid code duplication and make sure the field will be
   always initialized consistently.

Eduardo Habkost (6):
  pci: Inline pci_host_bus_register() inside pci_bus_init()
  pci: Move pci_bus_init() logic to pci_bus_new_inplace()
  pci: Rename and change signatures of pci_bus_new() & related functions
  pci: Manually simplify QOM casts at pci_host_bus_init*() calls
  pci: Set phb->bus inside pci_host_bus_init_inplace()
  pci: Remove unnecessary PCIBus variables

 include/hw/pci/pci.h                | 31 +++++++-------
 hw/alpha/typhoon.c                  | 17 ++++----
 hw/mips/gt64xxx_pci.c               |  9 ++---
 hw/pci-bridge/pci_expander_bridge.c | 14 +++----
 hw/pci-host/apb.c                   |  7 +---
 hw/pci-host/bonito.c                |  7 ++--
 hw/pci-host/gpex.c                  |  6 +--
 hw/pci-host/grackle.c               | 10 ++---
 hw/pci-host/piix.c                  | 30 +++++++-------
 hw/pci-host/ppce500.c               | 14 +++----
 hw/pci-host/prep.c                  |  7 ++--
 hw/pci-host/q35.c                   |  5 +--
 hw/pci-host/uninorth.c              | 18 +++------
 hw/pci-host/versatile.c             |  8 ++--
 hw/pci-host/xilinx-pcie.c           |  6 +--
 hw/pci/pci.c                        | 81 +++++++++++++++++--------------=
------
 hw/ppc/ppc4xx_pci.c                 | 10 ++---
 hw/ppc/spapr_pci.c                  | 11 ++---
 hw/s390x/s390-pci-bus.c             | 13 +++---
 hw/sh4/sh_pci.c                     |  9 ++---
 20 files changed, 135 insertions(+), 178 deletions(-)

--=20
2.11.0.259.g40922b1
