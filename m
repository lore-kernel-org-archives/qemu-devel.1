Received: from eggs.gnu.org ([209.51.188.92]:52343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1sgQ-0004r4-2F
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1sgO-0003a2-Ke
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:03:34 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 14:03:09 +0100
Message-Id: <20190307130323.9353-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/14] pflash: Fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu

Alex Benn=C3=A9e posted this patch to address an XXX comment in
pflash_cfi01_realize() the other day:

Subject: [PATCH v2] hw/block: report when pflash backing file isn't align=
ed
Message-Id: <20190215122808.22301-1-alex.bennee@linaro.org>
https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg04166.html

Review led me to look into its callers.  Most of them are pleasantly
boring: they create flash memory of some fixed size at some fixed
address.  A few are more creative, and some of the creative ones look
quite broken to me.  Fix them, and clean up some along the way.

v3:
* PATCH 07,13: Commit message typo
* PATCH 08: Replaced [Philippe, Magnus]
* PATCH 09-11: New [Philippe]
* PATCH 12: Straightforward rebase onto new patches
* PATCH 14: Commit message improved [Philippe], lines joined [Zoltan]

v2:
* PATCH 01+10: Style cleanups [checkpatch]
* PATCH 02: Rewritten [Peter, Philippe]
* PATCH 03+04: New [Philippe]
* PATCH 06: Commit message improved, FIXME added, accidental
  replacement of 64 * KiB by 65536 backed out [Zoltan]
* PATCH 07: Style tweak [Alex, David]
* PATCH 08: Commit message typo [Philippe]
* PATCH 11: Commit message typo [L=C3=A1szl=C3=B3]
* Old PATCH 10 dropped [Max, Peter]

Markus Armbruster (11):
  pflash: Rename pflash_t to PFlashCFI01, PFlashCFI02
  pflash_cfi01: Do not exit() on guest aborting "write to buffer"
  pflash_cfi01: Log use of flawed "write to buffer"
  pflash: Rename *CFI_PFLASH* to *PFLASH_CFI*
  hw: Use PFLASH_CFI0{1,2} and TYPE_PFLASH_CFI0{1,2}
  sam460ex: Don't size flash memory to match backing image
  ppc405_boards: Don't size flash memory to match backing image
  r2d: Fix flash memory size, sector size, width, device ID
  mips_malta: Clean up definition of flash memory size somewhat
  pflash: Clean up after commit 368a354f02b, part 1
  pflash: Clean up after commit 368a354f02b, part 2

Philippe Mathieu-Daud=C3=A9 (3):
  hw/mips/malta: Fix the DEBUG_BOARD_INIT code
  hw/mips/malta: Remove fl_sectors variable
  hw/mips/malta: Restrict 'bios_size' variable scope

 hw/arm/collie.c                          |   9 +-
 hw/arm/digic_boards.c                    |   3 +-
 hw/arm/gumstix.c                         |  10 +-
 hw/arm/mainstone.c                       |   5 +-
 hw/arm/musicpal.c                        |   8 +-
 hw/arm/omap_sx1.c                        |  10 +-
 hw/arm/versatilepb.c                     |   3 +-
 hw/arm/vexpress.c                        |  10 +-
 hw/arm/virt.c                            |   3 +-
 hw/arm/xilinx_zynq.c                     |   7 +-
 hw/arm/z2.c                              |   6 +-
 hw/block/pflash_cfi01.c                  | 123 ++++++++++++-----------
 hw/block/pflash_cfi02.c                  |  79 ++++++++-------
 hw/i386/pc_sysfw.c                       |  10 +-
 hw/lm32/lm32_boards.c                    |   8 +-
 hw/lm32/milkymist.c                      |   5 +-
 hw/microblaze/petalogix_ml605_mmu.c      |   6 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |   5 +-
 hw/mips/mips_malta.c                     |  22 ++--
 hw/mips/mips_r4k.c                       |   5 +-
 hw/ppc/ppc405_boards.c                   |  57 ++++-------
 hw/ppc/sam460ex.c                        |  42 +++++---
 hw/ppc/virtex_ml507.c                    |   5 +-
 hw/sh4/r2d.c                             |  17 +++-
 hw/xtensa/xtfpga.c                       |  12 +--
 include/hw/block/flash.h                 |  57 +++++++----
 26 files changed, 265 insertions(+), 262 deletions(-)

--=20
2.17.2
