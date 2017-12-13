Received: from eggs.gnu.org ([2001:4830:134:3::10]:59383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePAGi-0002KZ-0m
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePAGh-0004JP-CI
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:52:28 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 16:52:19 +0000
Message-Id: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] GICv2 & GICv3: RAZ/WI reserved addresses
 rather than aborting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

The GICv2 and GICv3 specifications say that reserved register
addresses should RAZ/WI.  This means we need to return MEMTX_OK, not
MEMTX_ERROR, because now that we support generating external aborts
the latter will cause an abort on new board models.

In particular, at least some versions of UEFI try to
access a reserved address in the GICv3 redistributor
(at SGI_base + 0x184) and fail to boot on the virt board
without this.

thanks
-- PMM

Peter Maydell (2):
  hw/intc/arm_gicv3: Make reserved register addresses RAZ/WI
  hw/intc/arm_gic: reserved register addresses are RAZ/WI

 hw/intc/arm_gic.c              |  5 +++--
 hw/intc/arm_gicv3_dist.c       | 13 +++++++++++++
 hw/intc/arm_gicv3_its_common.c |  8 +++-----
 hw/intc/arm_gicv3_redist.c     | 13 +++++++++++++
 4 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.7.4
