Received: from eggs.gnu.org ([2001:4830:134:3::10]:38226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiP-0004dS-Je
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiO-0001WQ-Mo
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:21 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosiO-0001RM-Es
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:20 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiG-000204-TN
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:12 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:35 +0000
Message-Id: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/32] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Latest run of arm patches -- most of these are Philippe's SD card
cleanups. I have more in my queue to review, but 32 is enough
patches to warrant sending out.

thanks
-- PMM

The following changes since commit ff8689611a1d954897d857b28f7ef404e11cfa2c:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-signed' into staging (2018-02-22 11:37:05 +0000)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180222

for you to fetch changes up to 4e5cc6756586e967993187657dfcdde4e00288d9:

  sdcard: simplify SD_SEND_OP_COND (ACMD41) (2018-02-22 15:12:54 +0000)

----------------------------------------------------------------
 * New "raspi3" machine emulating RaspberryPi 3
 * Fix bad register definitions for VMIDR and VMPIDR (which caused
   assertions for 64-bit guest CPUs with EL2 on big-endian hosts)
 * hw/char/stm32f2xx_usart: fix TXE/TC bit handling
 * Fix ast2500 protection register emulation
 * Lots of SD card emulation cleanups and bugfixes

----------------------------------------------------------------
Hugo Landau (1):
      Fix ast2500 protection register emulation

Pekka Enberg (1):
      raspi: Add "raspi3" machine type

Peter Maydell (1):
      target/arm: Fix register definitions for VMIDR and VMPIDR

Philippe Mathieu-Daudé (28):
      hw/sd/milkymist-memcard: use qemu_log_mask()
      hw/sd/milkymist-memcard: split realize() out of SysBusDevice init()
      hw/sd/milkymist-memcard: expose a SDBus and connect the SDCard to it
      hw/sd/ssi-sd: use the SDBus API, connect the SDCard to the bus
      sdcard: reorder SDState struct members
      sdcard: replace DPRINTF() by trace events
      sdcard: add a trace event for command responses
      sdcard: replace fprintf() by qemu_hexdump()
      sdcard: add more trace events
      sdcard: define SDMMC_CMD_MAX instead of using the magic '64'
      sdcard: use G_BYTE from cutils
      sdcard: use the registerfields API to access the OCR register
      sdcard: Don't always set the high capacity bit
      sdcard: update the CSD CRC register regardless the CSD structure version
      sdcard: fix the 'maximum data transfer rate' to 25MHz
      sdcard: clean the SCR register and add few comments
      sdcard: remove commands from unsupported old MMC specification
      sdcard: simplify using the ldst API
      sdcard: use the correct masked OCR in the R3 reply
      sdcard: use the registerfields API for the CARD_STATUS register masks
      sdcard: handle CMD54 (SDIO)
      sdcard: handle the Security Specification commands
      sdcard: use a more descriptive label 'unimplemented_spi_cmd'
      sdcard: handles more commands in SPI mode
      sdcard: check the card is in correct state for APP CMD (CMD55)
      sdcard: warn if host uses an incorrect address for APP CMD (CMD55)
      sdcard: simplify SEND_IF_COND (CMD8)
      sdcard: simplify SD_SEND_OP_COND (ACMD41)

Richard Braun (1):
      hw/char/stm32f2xx_usart: fix TXE/TC bit handling

 hw/sd/sdmmc-internal.h            |  15 ++
 include/hw/char/stm32f2xx_usart.h |   7 +-
 include/hw/sd/sd.h                |   1 -
 hw/arm/raspi.c                    |  23 ++
 hw/char/stm32f2xx_usart.c         |  12 +-
 hw/misc/aspeed_scu.c              |   6 +-
 hw/misc/aspeed_sdmc.c             |   8 +-
 hw/sd/milkymist-memcard.c         |  87 +++----
 hw/sd/sd.c                        | 467 +++++++++++++++++++++++---------------
 hw/sd/ssi-sd.c                    |  32 +--
 target/arm/helper.c               |   8 +-
 hw/sd/trace-events                |  20 ++
 12 files changed, 446 insertions(+), 240 deletions(-)
 create mode 100644 hw/sd/sdmmc-internal.h
