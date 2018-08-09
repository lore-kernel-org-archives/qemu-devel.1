Received: from eggs.gnu.org ([2001:4830:134:3::10]:55648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fneVd-0000w0-9E
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fneVN-0006JK-J0
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:33:21 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:34692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fneVN-0006Gk-2J
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:33:05 -0400
Received: by mail-pg1-x52d.google.com with SMTP id y5-v6so2270717pgv.1
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 23:33:04 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu,  9 Aug 2018 14:28:35 +0800
Message-Id: <1533796115-15837-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC v4 0/6] pci_expander_brdige: Support pxb-pcie
 host bridge into separate pci domain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, mst@redhat.com, Zihan Yang <whois.zihan.yang@gmail.com>

Currently only q35 host bridge is allocated an item in MCFG table, all pxb
host bridges stay within pci domain 0. This series of patches put each pxb
host bridge in separate pci domain, allocating a new MCFG table item for it.

Users can configure whether to put pxb host bridge into separate domain
by passing parameter domain_nr to pxb pcie device. start_bus property
indicates the Base Bus Number(BBN) of the pxb host bridge. Another property
max_bus specifies the maximum desired bus numbers to reduce MCFG space cost.
Example command is

    -device pxb-pcie,id=br3,bus="pcie.0",start_bus=0,domain_nr=1,max_bus=15

Then this pxb-pcie host bridge is placed at pci domain 1, and only reserve
(15+1)=16 buses, which is much smaller than the default 256 buses.

The pxb host does not have an mch in it, as q35 host already has one. All
pxb host bridges just serve as expander bridges in QEMU, which makes them
a little simpler than q35 host bridge.

The corresponding seabios patch link is

https://mail.coreboot.org/pipermail/seabios/2018-August/012401.html

Current issues:
* seabios will still throw a PCI IO space out of range error, it seems the
  pcie_pci_bridge is not correctly recognized. I'm working on it.

v4 <- v3:
- Fix bug in setting mcfg table
- bus_nr is not used when pxb-pcie is in a new pci domain

v3 <- v2:
- Replace duplicate properties in pxb pcie host with link property to PXBDev
- Allow seabios to access config space and data space of expander bridge
  through a different ioport, because 0xcf8 is attached only to sysbus.
- Add a new property start_bus to indicate the BBN of pxb host bridge. The
  bus_nr property is used as the bus number of pxb-pcie device on pcie.0 bus

v2 <- v1:
- Allow user to configure whether to put pxb-pcie into seperate domain
- Add AML description part of each host bridge
- Modify the location of MCFG space to between RAM hotplug and pci hole64

Zihan Yang (6):
  pci_expander_bridge: add type TYPE_PXB_PCIE_HOST
  acpi-build: allocate mcfg for pxb-pcie host bridges
  i386/acpi-build: describe new pci domain in AML
  pci_expander_bridge: Add config_read callback
  pci_expander_bridge: Add ioport for pxb host bus
  i386/acpi-build: pxb-pcie start bus should always be 0 in separate pci
    domain

 hw/i386/acpi-build.c                        | 169 ++++++++++++++------
 hw/i386/pc.c                                |  14 +-
 hw/pci-bridge/pci_expander_bridge.c         | 230 +++++++++++++++++++++++++++-
 hw/pci-host/q35.c                           |   2 +
 hw/pci/pci.c                                |  14 +-
 include/hw/i386/pc.h                        |   1 +
 include/hw/pci-bridge/pci_expander_bridge.h |  15 ++
 include/hw/pci-host/q35.h                   |   1 +
 include/hw/pci/pci.h                        |   1 +
 include/hw/pci/pci_bus.h                    |   1 +
 include/hw/pci/pci_host.h                   |   2 +-
 11 files changed, 389 insertions(+), 61 deletions(-)
 create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h

-- 
2.7.4
