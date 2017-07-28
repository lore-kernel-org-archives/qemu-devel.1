Received: from eggs.gnu.org ([2001:4830:134:3::10]:59253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEpW-00048R-3C
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEpS-0002NI-NR
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:02 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dbEpS-0002Mo-Fm
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:37:58 -0400
Received: by mail-lf0-x243.google.com with SMTP id 65so7022312lfa.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:37:58 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sat, 29 Jul 2017 02:37:48 +0300
Message-Id: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/5] Generic PCIE-PCI Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, kevin@koconnor.net, lersek@redhat.com, seabios@seabios.org, kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

This series introduces a new device - generic PCI Express to PCI bridge,
and also makes all necessary changes to enable hotplug of the bridge itself
and any device into the bridge.

Changes v2->v3:
(0). 'do_not_use' capability field flag is still _not_ in here since we haven't come to consesus on it yet.
1. Merge commits 5 (bus_reserve property creation) and 6 (property usage) together - addresses Michael's comment.
2. Add 'bus_reserve' property and QEMU PCI capability only to Generic PCIE Root Port - addresses Michael's and Marcel's comments.
3. Change 'bus_reserve' property's default value to 0 - addresses Michael's comment.
4. Rename QEMU bridge-specific PCI capability creation function - addresses Michael's comment.
5. Init the whole QEMU PCI capability with zeroes - addresses Michael's and Laszlo's comments.
6. Change QEMU PCI capability layout (SeaBIOS side has the same changes)
	- add 'type' field to distinguish multiple 
		RedHat-specific capabilities - addresses Michael's comment
	- do not mimiс PCI Config space register layout, but use mutually exclusive differently
		sized fields for IO and prefetchable memory limits - addresses Laszlo's comment
7. Correct error handling in PCIE-PCI bridge realize function.
8. Replace a '2' constant with PCI_CAP_FLAGS in the capability creation function - addresses Michael's comment.
9. Remove a comment on _OSC which isn't correct anymore - address Marcel's comment.
10. Add documentation for the Generic PCIE-PCI Bridge and QEMU PCI capability - addresses Michael's comment.

Changes v1->v2:
1. Enable SHPC for the bridge.
2. Enable SHPC support for the Q35 machine (ACPI stuff).
3. Introduce PCI capability to help firmware on the system init.
   This allows the bridge to be hotpluggable. Now it's supported 
   only for pcie-root-port. Now it's supposed to used with 
   SeaBIOS only, look at the SeaBIOS corresponding series
   "".

Aleksandr Bezzubikov (5):
  hw/i386: allow SHPC for Q35 machine
  hw/pci: introduce pcie-pci-bridge device
  hw/pci: introduce bridge-only vendor-specific capability to provide
    some hints to firmware
  hw/pci: add QEMU-specific PCI capability to Generic PCI Express Root
    Port
  docs: update documentation considering PCIE-PCI bridge

 docs/pcie.txt                      |  46 ++++----
 docs/pcie_pci_bridge.txt           | 121 ++++++++++++++++++++
 hw/i386/acpi-build.c               |   4 +-
 hw/pci-bridge/Makefile.objs        |   2 +-
 hw/pci-bridge/gen_pcie_root_port.c |  23 ++++
 hw/pci-bridge/pcie_pci_bridge.c    | 220 +++++++++++++++++++++++++++++++++++++
 hw/pci-bridge/pcie_root_port.c     |   2 +-
 hw/pci/pci_bridge.c                |  37 +++++++
 include/hw/pci/pci.h               |   1 +
 include/hw/pci/pci_bridge.h        |  28 +++++
 include/hw/pci/pcie_port.h         |   2 +
 11 files changed, 462 insertions(+), 24 deletions(-)
 create mode 100644 docs/pcie_pci_bridge.txt
 create mode 100644 hw/pci-bridge/pcie_pci_bridge.c

-- 
2.7.4
