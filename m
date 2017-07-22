Received: from eggs.gnu.org ([2001:4830:134:3::10]:59906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2dD-0000Qh-Tw
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2dA-0006kW-Qt
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:15 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZ2dA-0006k6-Iv
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:12 -0400
Received: by mail-lf0-x241.google.com with SMTP id x16so861209lfb.4
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 15:12:10 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 01:11:46 +0300
Message-Id: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v2 0/4] Allow RedHat PCI bridges reserve
 more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: marcel@redhat.com, kraxel@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

Now PCI bridges get a bus range number on a system init,
basing on currently plugged devices. That's why when one wants to hotplug another bridge,
it needs his child bus, which the parent is unable to provide (speaking about virtual device).
The suggested workaround is to have vendor-specific capability in Red Hat PCI bridges
that contains number of additional bus to reserve on BIOS PCI init.
So this capability is intented only for pure QEMU->SeaBIOS usage.

Considering all aforesaid, this series is directly connected with
QEMU RFC series (v2) "Generic PCIE-PCI Bridge".

Although the new PCI capability is supposed to contain various limits along with
bus number to reserve, now only its full layout is proposed, but
only bus_reserve field is used in QEMU and BIOS. Limits usage
is still a subject for implementation as now
the main goal of this series to provide necessary support from the 
firmware side to PCIE-PCI bridge hotplug. 

Changes v1->v2:
1. New #define for Red Hat vendor added (addresses Konrad's comment).
2. Refactored pci_find_capability function (addresses Marcel's comment).
3. Capability reworked:
	- data type added;
	- reserve space in a structure for IO, memory and 
	  prefetchable memory limits.


Aleksandr Bezzubikov (4):
  pci: refactor pci_find_capapibilty to get bdf as the first argument
    instead of the whole pci_device
  pci: add RedHat vendor ID
  pci: add QEMU-specific PCI capability structure
  pci: enable RedHat PCI bridges to reserve additional buses on PCI init

 src/fw/pciinit.c    | 18 ++++++++++++++----
 src/hw/pci_cap.h    | 23 +++++++++++++++++++++++
 src/hw/pci_ids.h    |  2 ++
 src/hw/pcidevice.c  | 12 ++++++------
 src/hw/pcidevice.h  |  2 +-
 src/hw/virtio-pci.c |  4 ++--
 6 files changed, 48 insertions(+), 13 deletions(-)
 create mode 100644 src/hw/pci_cap.h

-- 
2.7.4
