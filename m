Received: from eggs.gnu.org ([2001:4830:134:3::10]:57155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Cb-0002gu-LQ
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Ca-0002Hb-NY
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:13 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 24 Sep 2017 15:47:39 +0100
Message-Id: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/7] mac_dbdma: tidy-up and QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Whilst looking at implementing another DBDMA device for the Mac machines
I noticed a couple of things: firstly there were some unused fields still
in DBDMAState, and secondly the existing code still used global functions
to register DMA channels and handle the relationship between macio IDE and
DBDMA.

This patchset removes the now-unused fields from DBDMA state, QOMifys the
DBDMA device, uses a QOM object link to allow the macio IDE object to
reference the DBDMA device, and then finally removes the global DBDMA_*
functions substituting them instead for QOM methods.

Note: this patchset does not apply to master but on top of David's
ppc-for-2.11 branch since there are merge conflicts with my previous
patchset. Hopefully the Based-On line below is enough to keep patchew
happy, even though it wasn't the final version applied to the ppc-for-2.11
branch.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Based-on: 1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk (ppc: more Mac-related fixups)


Mark Cave-Ayland (7):
  mac_dbdma: remove unused IO fields from DBDMAState
  mac_dbdma: QOMify
  mac_dbdma: remove DBDMA_init() function
  macio: pass channel into MACIOIDEState via qdev property
  macio: use object link between MACIO_IDE and MAC_DBDMA object
  mac_dbdma: change DBDMA_register_channel to a MAC_DBDMA type method
  mac_dbdma: change DBDMA_kick to a MAC_DBDMA type method

 hw/ide/macio.c             |   26 ++++++++++-----
 hw/misc/macio/mac_dbdma.c  |   79 +++++++++++++++++++++++++++++---------------
 hw/misc/macio/macio.c      |   20 ++++++++---
 hw/ppc/mac.h               |    4 +--
 include/hw/ppc/mac_dbdma.h |   22 ++++++------
 5 files changed, 97 insertions(+), 54 deletions(-)

-- 
1.7.10.4
