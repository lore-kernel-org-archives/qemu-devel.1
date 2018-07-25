Received: from eggs.gnu.org ([2001:4830:134:3::10]:51119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fiFeI-000870-3G
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fiFeF-00021Q-6F
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:59:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 25 Jul 2018 09:59:37 +0100
Message-Id: <20180725085944.11856-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/7] arm: add Cortex M0 CPU model and hex
 file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mail@steffen-goertz.de, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, ilg@livius.net, qemu-arm@nongnu.org, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Steffen Gortz <qemu.ml@steffen-goertz.de>, jim@groklearning.com, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>

v3:
 * Rename ARMv7MState to ARMMProfileState so a single class can cater for
   ARMv6-M, ARMv7-M, and ARMv8-M [Peter]
 * Make bitbanding optional via a qdev property [Peter]
 * Add hex file loader patches to reduce dependencies in upcoming patch series
 * Implement rollback if hex file loader fails partway through [Peter]
 * Update hex file loader test case to use an ARMv7-M board since hex file
   loading is only done for ARM M Profile boards

This series contains the prerequistes for the "microbit" machine type that Joel
Stanley has written.  I have combined the Cortex M0 CPU model and hex loader
work into one series to reduce the dependencies in upcoming patch series from
Joel, Julia, and Steffen.

This patch series:
 * Renames ARMv7MState to ARMMProfileState since it's already used for ARMv8-M
   and soon ARMv6-M.
 * Adds a "cortex-m0" cpu type which can be used with ARMMProfileState.  This
   works thanks to Julia's Cortex M0 emulation patches, which are now all
   merged.
 * Adds Su Hang's Intel HEX file format loader so that micro:bit and other
   microcontroller firmware images can be run using -kernel.  The micro:bit
   development tools typically only emit .hex files and not ELFs.

Stefan Hajnoczi (5):
  hw/arm: rename armv7m_load_kernel()
  hw/arm: rename TYPE_ARMV7M to TYPE_ARM_M_PROFILE
  hw/arm: make bitbanded IO optional on ARM M Profile
  target/arm: add "cortex-m0" CPU model
  loader: add rom transaction API

Su Hang (2):
  loader: Implement .hex file loader
  Add QTest testcase for the Intel Hexadecimal

 MAINTAINERS                                  |   6 +
 configure                                    |   4 +
 hw/arm/Makefile.objs                         |   2 +-
 tests/Makefile.include                       |   2 +
 include/hw/arm/{armv7m.h => arm-m-profile.h} |  39 ++-
 include/hw/arm/arm.h                         |  11 +-
 include/hw/arm/iotkit.h                      |   4 +-
 include/hw/arm/msf2-soc.h                    |   4 +-
 include/hw/arm/stm32f205_soc.h               |   4 +-
 include/hw/loader.h                          |  31 ++
 hw/arm/{armv7m.c => arm-m-profile.c}         |  99 ++++---
 hw/arm/iotkit.c                              |   2 +-
 hw/arm/mps2-tz.c                             |   4 +-
 hw/arm/mps2.c                                |  11 +-
 hw/arm/msf2-soc.c                            |   3 +-
 hw/arm/msf2-som.c                            |   4 +-
 hw/arm/netduino2.c                           |   4 +-
 hw/arm/stellaris.c                           |   8 +-
 hw/arm/stm32f205_soc.c                       |   3 +-
 hw/core/loader.c                             | 280 +++++++++++++++++++
 target/arm/cpu.c                             |  11 +
 tests/hexloader-test.c                       |  56 ++++
 default-configs/arm-softmmu.mak              |   1 +
 tests/hex-loader-check-data/test.hex         |  12 +
 24 files changed, 522 insertions(+), 83 deletions(-)
 rename include/hw/arm/{armv7m.h => arm-m-profile.h} (64%)
 rename hw/arm/{armv7m.c => arm-m-profile.c} (76%)
 create mode 100644 tests/hexloader-test.c
 create mode 100644 tests/hex-loader-check-data/test.hex

-- 
2.17.1
