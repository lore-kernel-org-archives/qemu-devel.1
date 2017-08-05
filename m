Received: from eggs.gnu.org ([2001:4830:134:3::10]:56884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1de5g1-0006AB-0d
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1de5fw-0004zs-55
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:28:01 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:38476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1de5fv-0004vS-U7
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:27:56 -0400
Received: by mail-lf0-x241.google.com with SMTP id y15so3061040lfd.5
	for <qemu-devel@nongnu.org>; Sat, 05 Aug 2017 13:27:54 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sat,  5 Aug 2017 23:27:33 +0300
Message-Id: <1501964858-5159-1-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/5] Generic PCIE-PCI Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kevin@koconnor.net, kraxel@redhat.com, lersek@redhat.com, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

This series introduces a new device - Generic PCI Express to PCI bridge,
and also makes all necessary changes to enable hotplug of the bridge itself
and any device into the bridge.

Changes v3->v4:
1. PCIE-PCI Bridge device: "msi_enable"->"msi", "shpc"->"shpc_bar", remove local_err,
   make "msi" property OnOffAuto, shpc_present() is still here 
   to avoid SHPC_VMSTATE refactoring (address Marcel's comments). 
2. Change QEMU PCI capability layout (SeaBIOS side has the same changes):
  - change reservation fields types: bus_res - uint32_t, others - uint64_t
  - rename 'non_pref' and 'pref' fields
  - interpret -1 value as 'ignore'
3. Use parent_realize in Generic PCI Express Root Port properly.
4. Fix documentation: fully replace the DMI-PCI bridge references with the new PCIE-PCI bridge,
"PCIE"->"PCI Express", small mistakes and typos - address Laszlo's and Marcel's comments.
5. Rename QEMU PCI cap creation fucntion - addresses Marcel's comment.

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
   "Allow RedHat PCI bridges reserve more buses than necessary during init".

Aleksandr Bezzubikov (5):
  hw/i386: allow SHPC for Q35 machine
  hw/pci: introduce pcie-pci-bridge device
  hw/pci: introduce bridge-only vendor-specific capability to provide
    some hints to firmware
  hw/pci: add QEMU-specific PCI capability to the Generic PCI Express
    Root Port
  docs: update documentation considering PCIE-PCI bridge

 docs/pcie.txt                      |  49 +++++----
 docs/pcie_pci_bridge.txt           | 110 +++++++++++++++++++
 hw/i386/acpi-build.c               |   4 +-
 hw/pci-bridge/Makefile.objs        |   2 +-
 hw/pci-bridge/gen_pcie_root_port.c |  33 ++++++
 hw/pci-bridge/pcie_pci_bridge.c    | 212 +++++++++++++++++++++++++++++++++++++
 hw/pci/pci_bridge.c                |  29 +++++
 include/hw/pci/pci.h               |   1 +
 include/hw/pci/pci_bridge.h        |  21 ++++
 include/hw/pci/pcie_port.h         |   1 +
 10 files changed, 436 insertions(+), 26 deletions(-)
 create mode 100644 docs/pcie_pci_bridge.txt
 create mode 100644 hw/pci-bridge/pcie_pci_bridge.c

-- 
2.7.4
