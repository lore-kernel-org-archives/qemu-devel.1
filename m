Received: from eggs.gnu.org ([2001:4830:134:3::10]:60310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2gs-0003I7-Mk
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2gp-0008E7-KQ
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:02 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZ2gp-0008Df-Co
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:15:59 -0400
Received: by mail-lf0-x241.google.com with SMTP id p11so5151539lfd.1
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 15:15:59 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 01:15:37 +0300
Message-Id: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v2 0/6] Generic PCIE-PCI Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kraxel@redhat.com, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

This series introduces a new device - generic PCI Express to PCI bridge,
and also makes all necessary changes to enable hotplug of the bridge itself
and any device into the bridge.

Obvious reasons to remain RFC:
1. The new PCI capability: layout, creation interface.
2. Windows SHPC issue - devices hotplugging into the bridge
   doens't work on Windows 7 (unlike Windows 10),
   whereas an old pci-bridge usage is fine.
3. Hot-unplug not completely tested.

Changes v1->v2:
1. Enable SHPC for the bridge.
2. Enable SHPC support for the Q35 machine (ACPI stuff).
3. Introduce PCI capability to help firmware on the system init.
   This allows the bridge to be hotpluggable. Now it's supported 
   only for pcie-root-port. Now it's supposed to used with 
   SeaBIOS only, look at the SeaBIOS corresponding series
   "".

Aleksandr Bezzubikov (6):
  hw/pci: introduce pcie-pci-bridge device
  hw/i386: allow SHPC for Q35 machine
  hw/pci: enable SHPC for PCIE-PCI bridge
  hw/pci: introduce bridge-only vendor-specific capability to provide
    some hints to firmware
  hw/pci: add bus_reserve property to pcie-root-port
  hw/pci: add hint capabilty for additional bus reservation to
    pcie-root-port

 hw/i386/acpi-build.c            |   2 +-
 hw/pci-bridge/Makefile.objs     |   2 +-
 hw/pci-bridge/pcie_pci_bridge.c | 212 ++++++++++++++++++++++++++++++++++++++++
 hw/pci-bridge/pcie_root_port.c  |   6 ++
 hw/pci/pci_bridge.c             |  27 +++++
 include/hw/pci/pci.h            |   1 +
 include/hw/pci/pci_bridge.h     |  18 ++++
 include/hw/pci/pcie_port.h      |   3 +
 8 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 hw/pci-bridge/pcie_pci_bridge.c

-- 
2.7.4
