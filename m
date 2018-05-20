Received: from eggs.gnu.org ([2001:4830:134:3::10]:52314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fKImJ-0000bm-AC
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fKImG-0006t6-70
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:29:15 -0400
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:46273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fKImG-0006sp-1W
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:29:12 -0400
Received: by mail-pl0-x22d.google.com with SMTP id 30-v6so6937465pld.13
	for <qemu-devel@nongnu.org>; Sun, 20 May 2018 00:29:11 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Sun, 20 May 2018 15:28:50 +0800
Message-Id: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC 0/3] pci_expander_brdige: Put pxb host bridge
 into separate pci domain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>

Currently only q35 host bridge is allocated an item in MCFG table, all pxb
host bridges stay within pci domain 0. This series of patches put each pxb
host bridge in separate pci domain, allocating a new MCFG table item for it.

The pxb host does not have an mch in it, as q35 host already has one. All
pxb host bridges just serve as expander bridges in QEMU, which makes them
a little simpler than q35 host bridge.

NOTE: These patches are just initial proof of concept, asking for suggestions.
      The aml part and seabios part are not finished at all. This means it
      still behaves like before, that all pci expander bridges stay in the
      same pci domain as a35 host.

Zihan Yang (3):
  pci_expander_bridge: reserve enough mcfg space for pxb host
  pci: Link pci_host_bridges with QTAILQ
  acpi-build: allocate mcfg for multiple host bridges

 hw/i386/acpi-build.c                        | 83 ++++++++++++++++++-------
 hw/i386/pc.c                                |  5 ++
 hw/pci-bridge/pci_expander_bridge.c         | 96 ++++++++++++++++++++++++++++-
 hw/pci/pci.c                                |  9 +--
 include/hw/pci-bridge/pci_expander_bridge.h |  7 +++
 include/hw/pci/pci_host.h                   |  2 +-
 6 files changed, 175 insertions(+), 27 deletions(-)
 create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h

-- 
2.7.4
