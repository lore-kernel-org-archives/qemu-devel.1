Received: from eggs.gnu.org ([2001:4830:134:3::10]:55971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fX3Pd-0001E8-T7
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 07:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fX3PZ-0007n8-1X
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 07:42:33 -0400
Message-Id: <cover.1529839203.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 24 Jun 2018 13:20:03 +0200
Subject: [Qemu-devel] [PATCH v5 0/4] Misc sam460ex improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

These are the remaining patches for sam460ex needed to implement RTC
and get AmigaOS to boot. The sm501 patches are also needed but that's
now a separate series. I'd appreciate if this could be reviewed and
merged before the imminent 3.0 freeze.

I think only patch 1/4 (i2c rewrite) is a bit more complex but given
that originally it was only a stub and previous patches just hacked it
for u-boot IMO it does not worth trying to make incremental changes to
the previous nonsense behaviour instead of replacing it with a more
proper implementation which is what this patch does. Basically it
implements the 4 byte FIFO for mdata register and implements
interrupts the device should generate. Considering that this device is
only used on some not too well maintained boards it should be low risk
to make this change.

Patches 1-3 are for RTC emulation, patch 4 is new and is needed by
AmigaOS.

Regards,
BALATON Zoltan

BALATON Zoltan (4):
  ppc4xx_i2c: Rewrite to model hardware more closely
  hw/timer: Add basic M41T80 emulation
  sam460ex: Add RTC device
  ppc440_uc: Basic emulation of PPC440 DMA controller

 MAINTAINERS                     |   1 +
 default-configs/ppc-softmmu.mak |   1 +
 hw/i2c/ppc4xx_i2c.c             | 222 +++++++++++++++++++---------------------
 hw/ppc/ppc440.h                 |   1 +
 hw/ppc/ppc440_uc.c              | 215 ++++++++++++++++++++++++++++++++++++++
 hw/ppc/sam460ex.c               |   4 +
 hw/timer/Makefile.objs          |   1 +
 hw/timer/m41t80.c               | 117 +++++++++++++++++++++
 include/hw/i2c/ppc4xx_i2c.h     |   3 +-
 9 files changed, 450 insertions(+), 115 deletions(-)
 create mode 100644 hw/timer/m41t80.c

-- 
2.7.6
