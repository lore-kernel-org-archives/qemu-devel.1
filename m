Received: from eggs.gnu.org ([2001:4830:134:3::10]:58287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmb-0004eK-Kn
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmW-0004xa-KS
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:37 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:43801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmW-0004xJ-F9
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:32 -0500
Received: by mail-qk0-x244.google.com with SMTP id i184so1554978qkf.10
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:13:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:05 -0300
Message-Id: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/20] SDCard: bugfixes,
 support UHS-I (part 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

Some refactors, few bugfixes, better SD/SPI support.

With this series apply, machines can use SD cards in UHS-I mode.
(mostly imported from Alistair Francis work)

MMC mode split out for another series,
so UHS enabled MMC cards are still not usable:

  kernel: mmc0: SDHCI controller on PCI [0000:00:05.0] using ADMA
  kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
  kernel: mmc0: Skipping voltage switch
  [mmc kthread looping]

Since v3:
- simpler SPI handling, improved descriptions (Alistair review)
- inverted patches 16/17 order

Since v2:
- split again in 2... other part is cleanup/tracing

Since v1:
- rewrote mostly all patches to keep it simpler.

$ git backport-diff
001/20:[----] [-C] 'sdcard: Don't always set the high capacity bit'
002/20:[----] [-C] 'sdcard: update the CSD CRC register regardless the CSD structure version'
003/20:[----] [-C] 'sdcard: fix the 'maximum data transfer rate' to 25MHz'
004/20:[----] [-C] 'sdcard: clean the SCR register and add few comments'
005/20:[----] [--] 'sdcard: remove commands from unsupported old MMC specification'
006/20:[----] [--] 'sdcard: simplify using the ldst API'
007/20:[0008] [FC] 'sdcard: use the correct masked OCR in the R3 reply'
008/20:[----] [-C] 'sdcard: use the registerfields API for the CARD_STATUS register masks'
009/20:[----] [--] 'sdcard: handle CMD54 (SDIO)'
010/20:[down] 'sdcard: handle the Security Specification commands'
011/20:[down] 'sdcard: use a more descriptive label 'unimplemented_spi_cmd''
012/20:[0034] [FC] 'sdcard: handles more commands in SPI mode'
013/20:[----] [--] 'sdcard: check the card is in correct state for APP CMD (CMD55)'
014/20:[----] [--] 'sdcard: warn if host uses an incorrect address for APP CMD (CMD55)'
015/20:[----] [--] 'sdcard: simplify SEND_IF_COND (CMD8)'
016/20:[----] [--] 'sdcard: simplify SD_SEND_OP_COND (ACMD41)'
017/20:[----] [--] 'sdcard: add SD SEND_TUNING_BLOCK (CMD19)'
018/20:[----] [--] 'sdcard: implement the UHS-I SWITCH_FUNCTION entries (Spec v3)'
019/20:[----] [-C] 'sdcard: add a 'uhs' property, update the OCR register ACCEPT_SWITCH_1V8 bit'
020/20:[----] [--] 'sdcard: add an enum for the SD PHY Spec version'

Based-on: 20180215220540.6556-12-f4bug@amsat.org

Philippe Mathieu-Daudé (20):
  sdcard: Don't always set the high capacity bit
  sdcard: update the CSD CRC register regardless the CSD structure
    version
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
  sdcard: add SD SEND_TUNING_BLOCK (CMD19)
  sdcard: implement the UHS-I SWITCH_FUNCTION entries (Spec v3)
  sdcard: add a 'uhs' property, update the OCR register
    ACCEPT_SWITCH_1V8 bit
  sdcard: add an enum for the SD PHY Spec version

 hw/sd/sd.c         | 498 ++++++++++++++++++++++++++++++++++++-----------------
 hw/sd/trace-events |   1 +
 2 files changed, 343 insertions(+), 156 deletions(-)

-- 
2.16.1
