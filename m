Received: from eggs.gnu.org ([209.51.188.92]:36156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hBCUK-000891-8F
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hBCTF-0003Rx-C3
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:00:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  2 Apr 2019 16:40:23 +1100
Message-Id: <20190402054028.20926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC for-4.1 0/5] Simplify some not-really-necessary
 PCI bus callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

c2077e2c "pci: Adjust PCI config limit based on bus topology"
introduced checking the availability of extended config space for
PCI-E devices which are in a bus topology that doesn't permit extended
config space access (e.g. under PCI-E to PCI then PCI to PCI-E
bridges).

This caused some problems for the spapr para-virtual PCI bus which
_does_ allow extended config space access, despite acting in most ways
like a vanilla PCI bus.

Greg Kurz has posted a proposed fix for that against qemu-4.0 - for
easy reference I've included that as the first two patches of this
series.

The rest of the series simplfies both the PCI-E config space access
and pci_bus_is_root() logic, using a new flags field on the PCI Bus
instance.

David Gibson (3):
  pcie: Remove redundant test in pcie_mmcfg_data_read()
  pci: Simplify pci_bus_is_root()
  pcie: Simplify pci_adjust_config_limit()

Greg Kurz (2):
  pci: Allow PCI bus subtypes to support extended config space accesses
  spapr_pci: Fix extended config space accesses

 hw/pci-bridge/pci_expander_bridge.c |  6 -----
 hw/pci/pci.c                        | 40 ++++++++++++++++++++++-------
 hw/pci/pci_host.c                   | 13 +++-------
 hw/pci/pcie_host.c                  |  5 ----
 hw/ppc/spapr_pci.c                  | 20 ++++++++++++++-
 hw/virtio/virtio-pci.c              |  1 +
 include/hw/pci/pci.h                |  3 ++-
 include/hw/pci/pci_bus.h            | 14 +++++++++-
 8 files changed, 69 insertions(+), 33 deletions(-)

--=20
2.20.1
