Received: from eggs.gnu.org ([209.51.188.92]:35790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6R-00008C-LR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6N-0004bn-6M
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6M-0004Zy-KW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFD0E3087BC2
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 55956600CD
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:16 +0100
Message-Id: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/27] Pflash and firmware configuration patches
 for 2019-03-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 377b155bde451d5ac545fbdcdfbf6ca17a4228=
f5:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2019-03-11 18:26:37 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-pflash-2019-03-11

for you to fetch changes up to e33763be7cd3769c9ae48e67d775348863fdabdb:

  docs/interop/firmware.json: Prefer -machine to if=3Dpflash (2019-03-11 =
22:54:25 +0100)

----------------------------------------------------------------
Pflash and firmware configuration patches for 2019-03-11

* Fix guest-triggerable exit() in cfi.pflash01 device
* Correct flash memory size with odd image files for machine types
  sam460ex, ref405ep, taihu.
* Correct flash memory size, sector siz, width and device ID for
  machine type r2d.
* Support firmware configuration with -blockdev for machine types
  pc-*.

----------------------------------------------------------------
Markus Armbruster (22):
      pflash: Rename pflash_t to PFlashCFI01, PFlashCFI02
      pflash_cfi01: Do not exit() on guest aborting "write to buffer"
      pflash_cfi01: Log use of flawed "write to buffer"
      pflash: Rename *CFI_PFLASH* to *PFLASH_CFI*
      hw: Use PFLASH_CFI0{1,2} and TYPE_PFLASH_CFI0{1,2}
      sam460ex: Don't size flash memory to match backing image
      ppc405_boards: Delete stale, disabled DEBUG_BOARD_INIT code
      ppc405_boards: Don't size flash memory to match backing image
      r2d: Fix flash memory size, sector size, width, device ID
      mips_malta: Delete disabled, broken DEBUG_BOARD_INIT code
      mips_malta: Clean up definition of flash memory size somewhat
      pflash: Clean up after commit 368a354f02b, part 1
      pflash: Clean up after commit 368a354f02b, part 2
      qdev: Fix latent bug with compat_props and onboard devices
      qom: Move compat_props machinery from qdev to QOM
      vl: Fix latent bug with -global and onboard devices
      sysbus: Fix latent bug with onboard devices
      vl: Improve legibility of BlockdevOptions queue
      vl: Factor configure_blockdev() out of main()
      vl: Create block backends before setting machine properties
      pc: Support firmware configuration with -blockdev
      docs/interop/firmware.json: Prefer -machine to if=3Dpflash

Philippe Mathieu-Daud=C3=A9 (5):
      hw/mips/malta: Remove fl_sectors variable
      hw/mips/malta: Restrict 'bios_size' variable scope
      pflash_cfi01: Add pflash_cfi01_get_blk() helper
      pc_sysfw: Remove unused PcSysFwDevice
      pc_sysfw: Pass PCMachineState to pc_system_firmware_init()

 accel/accel.c                            |   1 +
 docs/interop/firmware.json               |  20 ++-
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
 hw/block/pflash_cfi01.c                  | 128 +++++++++-------
 hw/block/pflash_cfi02.c                  |  81 ++++++-----
 hw/core/qdev.c                           |  21 +--
 hw/core/sysbus.c                         |   3 -
 hw/i386/pc.c                             |   4 +-
 hw/i386/pc_sysfw.c                       | 243 +++++++++++++++++++------=
------
 hw/lm32/lm32_boards.c                    |   8 +-
 hw/lm32/milkymist.c                      |   5 +-
 hw/microblaze/petalogix_ml605_mmu.c      |   6 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |   5 +-
 hw/mips/mips_malta.c                     |  21 +--
 hw/mips/mips_r4k.c                       |   5 +-
 hw/ppc/ppc405_boards.c                   | 102 ++-----------
 hw/ppc/sam460ex.c                        |  42 ++++--
 hw/ppc/virtex_ml507.c                    |   5 +-
 hw/sh4/r2d.c                             |  17 ++-
 hw/xtensa/xtfpga.c                       |  12 +-
 include/hw/block/flash.h                 |  58 +++++---
 include/hw/i386/pc.h                     |   6 +-
 include/hw/qdev-core.h                   |   2 -
 include/qom/object.h                     |   3 +
 qom/object.c                             |  39 +++++
 vl.c                                     | 125 ++++++++--------
 36 files changed, 547 insertions(+), 489 deletions(-)

--=20
2.17.2
