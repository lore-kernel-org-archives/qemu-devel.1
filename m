Received: from eggs.gnu.org ([2001:4830:134:3::10]:58768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fSfMU-0004JG-Hn
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fSfMQ-0006Ks-Gx
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:13:10 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:37512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fSfMQ-0006KI-9r
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:13:06 -0400
Received: by mail-pf0-x229.google.com with SMTP id y5-v6so10861739pfn.4
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 02:13:06 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 12 Jun 2018 17:12:35 +0800
Message-Id: <1528794755-6229-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC v2 0/3] pci_expander_brdige: Put pxb-pcie host
 bridge into separate pci domain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, Zihan Yang <whois.zihan.yang@gmail.com>

Hi all, after some delay, here is the v2 version of putting pxb host bridge
into separate pci domain.

Currently only q35 host bridge is allocated an item in MCFG table, all pxb
host bridges stay within pci domain 0. This series of patches put each pxb
host bridge in separate pci domain, allocating a new MCFG table item for it.

Users can configure whether to put pxb host bridge into separate domain
or just leave it in pci domain 0 by passing parameter sep_domain(bool) and
domain_nr(uint32_t), they can also specify the maximum desired bus numbers
to reduce MCFG space cost, for example,

    -device pxb-pcie,id=bridge3,bus="pcie.0",sep_domain=on,domain_nr=1,max_bus=130

Then this pxb-pcie host bridge is placed at pci domain 1, and only reserve
(130+1)=131 buses, which is much smaller than the default 256 buses.

The pxb host does not have an mch in it, as q35 host already has one. All
pxb host bridges just serve as expander bridges in QEMU, which makes them
a little simpler than q35 host bridge.

There are some things remaining TODO. For example, deal with the pci data
write to pxb host bridges, but that will need some work in SeaBIOS, which
I am starting soon. Also, we might need to limit the number of pci domains
in case it exceeds the bit limit of physical address when EPT is enabled.

v2 <- v1:
- Allow user to configure whether to put pxb-pcie into seperate domain
- Add AML description part of each host bridge
- Modify the location of MCFG space to between RAM hotplug and pci hole64


Zihan Yang (3):
  pci_expander_bridge: add type TYPE_PXB_PCIE_HOST
  acpi-build: allocate mcfg for pxb-pcie host bridges
  acpi-build: describe new pci domain in AML

 hw/i386/acpi-build.c                        | 162 ++++++++++++++++++++--------
 hw/i386/pc.c                                |  14 ++-
 hw/pci-bridge/pci_expander_bridge.c         | 142 +++++++++++++++++++++++-
 hw/pci-host/q35.c                           |   2 +
 hw/pci/pci.c                                |   9 +-
 include/hw/i386/pc.h                        |   1 +
 include/hw/pci-bridge/pci_expander_bridge.h |   6 ++
 include/hw/pci-host/q35.h                   |   1 +
 include/hw/pci/pci_host.h                   |   2 +-
 9 files changed, 285 insertions(+), 54 deletions(-)
 create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h

-- 
2.7.4
