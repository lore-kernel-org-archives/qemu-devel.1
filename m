Received: from eggs.gnu.org ([209.51.188.92]:56558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ9OI-0006JP-G0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ9OH-0008Lr-9L
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:20:14 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 24 Apr 2019 14:19:56 +1000
Message-Id: <20190424041959.4087-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] Simplify some not-really-necessary PCI
 bus callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, clg@kaod.org, qemu-ppc@nongnu.org

c2077e2c "pci: Adjust PCI config limit based on bus topology"
introduced checking the availability of extended config space for
PCI-E devices which are in a bus topology that doesn't permit extended
config space access (e.g. under PCI-E to PCI then PCI to PCI-E
bridges).

This caused some problems for the spapr para-virtual PCI bus which
_does_ allow extended config space access, despite acting in most ways
like a vanilla PCI bus.

Greg Kurz made a fix for that which was merged as 1c685a90263 "pci:
Allow PCI bus subtypes to support extended config space accesses".
While that was an appropriate minimal fix for the 4.0 hard freeze, it
was kind of a hack longer term.

This series implements a simpler way of handling the extended config
space permission, which works for both the normal and weird-PAPR
cases.  While we're there, we also make other small cleanups to the
PCI code.

David Gibson (3):
  pcie: Remove redundant test in pcie_mmcfg_data_{read,write}()
  pci: Simplify pci_bus_is_root()
  pcie: Simplify pci_adjust_config_limit()

 hw/pci-bridge/pci_expander_bridge.c |  6 ----
 hw/pci/pci.c                        | 55 +++++++++++++----------------
 hw/pci/pci_host.c                   | 13 ++-----
 hw/pci/pcie_host.c                  | 10 ------
 hw/ppc/spapr_pci.c                  | 34 ++++++------------
 hw/virtio/virtio-pci.c              |  1 +
 include/hw/pci/pci.h                |  2 --
 include/hw/pci/pci_bus.h            | 21 +++++++++--
 8 files changed, 58 insertions(+), 84 deletions(-)

--=20
2.20.1
