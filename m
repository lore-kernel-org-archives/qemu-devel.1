Received: from eggs.gnu.org ([2001:4830:134:3::10]:58231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cVkAN-0005th-7n
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cVkAJ-0007eT-Uz
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:20:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cVkAJ-0007eK-Jm
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:20:31 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C711C635F9
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 19:20:31 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 23 Jan 2017 21:20:17 +0200
Message-Id: <1485199220-3298-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V3 0/3] hw/pcie: Introduce Generic PCI Express
 Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, kraxel@redhat.com, abologna@redhat.com

v2 -> v3:
 - Keep only the root port base class code in pcie_root_port.c (Michael)
 - Use msix for the generic root port implementation (Michael and Gerd)
   - The task required some refactoring like having some common
     init/uninit interrupts functions to be implemented by both
     generic and Intel Root Ports.

v1 -> v2:
 - Rebased on master.

The Generic Root Port behaves the same as the
Intel's IOH device with id 3420, without having
Intel specific attributes.

The device has two purposes:
 (1) Can be used on both X86 and ARM machines.
 (2) It will allow us to tweak the behaviour
    (e.g add vendor-specific PCI capabilities)
     - something that obviously cannot be done
       on a known device.

Patch 1/3: Introduce a base class for Root Ports - most of the code
           is migrated from IOH3420 implementation.
Patch 2/3: Derives the IOH3420 from the new base class
Patch 3/3: Introduces the generic Root Port.

Tested with Linux and Windows guests only on x86 hosts.

Marcel Apfelbaum (3):
  hw/pcie: Introduce a base class for PCI Express Root Ports
  hw/ioh3420: derive from PCI Express Root Port base class
  hw/pcie: Introduce Generic PCI Express Root Port

 default-configs/arm-softmmu.mak    |   1 +
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/pci-bridge/Makefile.objs        |   1 +
 hw/pci-bridge/gen_pcie_root_port.c |  88 +++++++++++++++++++
 hw/pci-bridge/ioh3420.c            | 121 ++++----------------------
 hw/pci-bridge/pcie_root_port.c     | 171 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h               |   1 +
 include/hw/pci/pcie_port.h         |  19 +++++
 9 files changed, 298 insertions(+), 106 deletions(-)
 create mode 100644 hw/pci-bridge/gen_pcie_root_port.c
 create mode 100644 hw/pci-bridge/pcie_root_port.c

-- 
2.5.5
