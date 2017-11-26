Received: from eggs.gnu.org ([2001:4830:134:3::10]:34074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIx69-0000QO-18
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIx65-0006bi-4b
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:35:53 -0500
Received: from chuckie.co.uk ([82.165.15.123]:48791
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eIx64-0006bN-Tw
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:35:49 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 26 Nov 2017 13:35:18 +0000
Message-Id: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/8] sparc: IOMMU tidy-up and reorganisation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Following on from the previous sun4u patchset, here is the next step of
IOMMU-related updates for 2.12.

This patchset does 2 main things: firstly it moves the sun4m IOMMU
device out of hw/dma and into hw/sparc to match existing architectures.
With this (and the previous sun4m DMA rework) the old sun4m.h header can
now be completely removed.

Secondly in a similar manner, we split the sun4u IOMMU functionality out
from the APB device into a new sun4u-iommu device in hw/sparc64, adding in
a conversion from DPRINTF macros to trace-events for good measure while
we are here.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Based-on: 1511699686-12605-1-git-send-email-mark.cave-ayland@ilande.co.uk ([PATCHv2 00/15] sun4u: tidy-up CPU, APB and ebus)


Mark Cave-Ayland (8):
  sun4m: move sun4m_iommu.c from hw/dma to hw/sparc
  sun4m: move IOMMU declarations from sun4m.h to sun4m_iommu.h
  sun4m: remove include/hw/sparc/sun4m.h and all references to it
  apb: QOMify IOMMU
  sun4u: split IOMMU device out from apb.c to sun4u_iommu.c
  sun4u_iommu: update to reflect IOMMU is no longer part of the APB
    device
  sun4u_iommu: convert from IOMMU_DPRINTF to trace-events
  sun4u_iommu: add trace event for IOMMU translations

 hw/dma/Makefile.objs           |    1 -
 hw/dma/sparc32_dma.c           |    2 +-
 hw/dma/sun4m_iommu.c           |  406 ---------------------------------------
 hw/dma/trace-events            |   10 -
 hw/intc/slavio_intctl.c        |    1 -
 hw/net/lance.c                 |    2 +-
 hw/pci-host/apb.c              |  256 +------------------------
 hw/sparc/Makefile.objs         |    2 +-
 hw/sparc/sun4m.c               |    2 +-
 hw/sparc/sun4m_iommu.c         |  407 ++++++++++++++++++++++++++++++++++++++++
 hw/sparc/trace-events          |   10 +
 hw/sparc64/Makefile.objs       |    1 +
 hw/sparc64/sun4u.c             |    8 +-
 hw/sparc64/sun4u_iommu.c       |  342 +++++++++++++++++++++++++++++++++
 hw/sparc64/trace-events        |    5 +
 hw/timer/slavio_timer.c        |    1 -
 include/hw/pci-host/apb.h      |   53 +-----
 include/hw/sparc/sun4m.h       |   35 ----
 include/hw/sparc/sun4m_iommu.h |   51 +++++
 include/hw/sparc/sun4u_iommu.h |   50 +++++
 20 files changed, 889 insertions(+), 756 deletions(-)
 delete mode 100644 hw/dma/sun4m_iommu.c
 create mode 100644 hw/sparc/sun4m_iommu.c
 create mode 100644 hw/sparc64/sun4u_iommu.c
 delete mode 100644 include/hw/sparc/sun4m.h
 create mode 100644 include/hw/sparc/sun4m_iommu.h
 create mode 100644 include/hw/sparc/sun4u_iommu.h

-- 
1.7.10.4
