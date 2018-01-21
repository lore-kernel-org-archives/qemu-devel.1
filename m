Received: from eggs.gnu.org ([2001:4830:134:3::10]:34711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfq-0006Ek-2b
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfl-00034G-2A
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:22 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47973
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1edBfk-0002st-R4
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:16 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 21 Jan 2018 09:11:44 +0000
Message-Id: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 00/10] sun4u: APB tidy-up/rename and
 tracepoint conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This patchset is the next round of sun4u tidy-ups mostly centered around the
APB (PCI host bridge). In its current form apb.c contains both the PCI host
bridge and the secondary PCI bridge, so we split the PCI bridge into a new
file and move it under hw/pci-bridge.

To order to avoid further confusion between PBM/APB naming I've gone for using
the Sun internal code names, sabre and simba for the two PCI bridges to keep
things consistent.

Finally there are a couple of conversions to trace-events for sabre and the
sparc CPU as used when debugging this patchset. Note that as hw/pci-host is
listed as having no maintainers, I've CCd the PCI bridge maintainers on the
hw/pci-host tracepoint conversion which I hope is reasonable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v2:
- Rebase onto master
- Add R-b and A-b tags from reviewers
- Squash patches 9 and 10 as requested by Philippe and Marcel


Mark Cave-Ayland (10):
  apb: split simba PCI bridge into hw/pci-bridge/simba.c
  simba: rename PBMPCIBridge and QOM types to reflect simba naming
  apb: rename APB functions to use sabre prefix
  apb: change pbm_pci_host prefix functions to use sabre_pci prefix
  apb: QOMify sabre PCI host bridge
  apb: rename QOM type from TYPE_APB to TYPE_SABRE
  sun4u: rename apb variables and constants
  apb: rename apb.c to sabre.c
  sabre: convert from SABRE_DPRINTF macro to trace-events
  sparc64: convert hw/sparc64/sparc64.c from DPRINTF macros to trace
    events

 Makefile.objs                          |   1 +
 default-configs/sparc64-softmmu.mak    |   3 +-
 hw/pci-bridge/Makefile.objs            |   2 +
 hw/pci-bridge/simba.c                  | 101 ++++++++++++
 hw/pci-host/Makefile.objs              |   2 +-
 hw/pci-host/{apb.c => sabre.c}         | 270 ++++++++++++---------------------
 hw/pci-host/trace-events               |  11 ++
 hw/sparc64/sparc64.c                   |  85 +++++------
 hw/sparc64/sun4u.c                     |  45 +++---
 hw/sparc64/trace-events                |  18 +++
 include/hw/pci-bridge/simba.h          |  38 +++++
 include/hw/pci-host/{apb.h => sabre.h} |  26 ++--
 12 files changed, 342 insertions(+), 260 deletions(-)
 create mode 100644 hw/pci-bridge/simba.c
 rename hw/pci-host/{apb.c => sabre.c} (62%)
 create mode 100644 hw/pci-host/trace-events
 create mode 100644 include/hw/pci-bridge/simba.h
 rename include/hw/pci-host/{apb.h => sabre.h} (69%)

-- 
2.11.0
