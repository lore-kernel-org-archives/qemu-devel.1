Received: from eggs.gnu.org ([2001:4830:134:3::10]:51004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqWp-0001nz-Tm
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqWl-0007Ny-Ke
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:24:51 -0500
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:39680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqWl-0007Nb-Eu
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:24:47 -0500
Received: by mail-qk0-x229.google.com with SMTP id c5so3236638qkg.6
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:24:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:11 -0300
Message-Id: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/25] SDCard: housekeeping, improve SPI,
 introduce new Specs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series intends to simplify the sdcard device:
- add trace points,
- have a more robust SD mode,
- improve the SPI mode,
- introduce the MMC mode (split for a later series)

3 patches as tagged RFC as I need to fix few XXX comments,
checking back the specs.

Since v1:
- rewrote mostly all patches to keep it simpler.

Regards,

Phil.

$ git backport-diff
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/25:[down] 'sdcard: reorder SDState struct members'
002/25:[0026] [FC] 'sdcard: replace DPRINTF() by trace events'
003/25:[----] [-C] 'sdcard: add more trace events'
004/25:[down] 'sdcard: define SDCARD_CMD_MAX instead of using the magic '64''
005/25:[down] 'sdcard: display command name when tracing CMD/ACMD'
006/25:[----] [-C] 'sdcard: let cmd_valid_while_locked() returns a bool'
007/25:[down] 'sdcard: rename sd_set_$REG() functions called once as sd_reset_$REG()'
008/25:[down] 'sdcard: use the registerfields API to access the OCR register'
009/25:[down] 'sdcard: use G_BYTE from cutils'
010/25:[down] 'sdcard: remove unreachable code'
011/25:[down] 'sdcard: replace switch(unique case) statements -> if(case)'
012/25:[down] 'sdcard: use a 16-bit integer for the 16-bit RCA register'
013/25:[down] 'sdcard: let function handling response codes returns the response size'
014/25:[down] 'sdcard: add missing command CMD55'
015/25:[down] 'sdcard: add missing CMD54 SDIO command'
016/25:[down] 'sdcard: add missing SPI legal commands'
017/25:[down] 'sdcard: fix SPI response length'
018/25:[down] 'sdcard: add an enum for the SD PHY Spec version'
019/25:[down] 'sdcard: check if the card capacity is supported'
020/25:[down] 'sdcard: Don't always set the high capacity bit'
021/25:[down] 'sdcard: add cmd_version_supported(), improve cmd_class_supported()'
022/25:[down] 'sdcard: remove unreachable SPI commands'
023/25:[down] 'sdcard: store the bus protocol in an enum'
024/25:[down] 'sdcard: introduce Spec v3.01 SD commands'
025/25:[down] 'sdcard: introduce Spec v4.51 & v5.1 MMC commands'

Based-on: 20180103183418.23730-26-f4bug@amsat.org
          (SDHCI: add qtests and fix few issues)

Philippe Mathieu-Daudé (25):
  sdcard: reorder SDState struct members
  sdcard: replace DPRINTF() by trace events
  sdcard: add more trace events
  sdcard: define SDCARD_CMD_MAX instead of using the magic '64'
  sdcard: display command name when tracing CMD/ACMD
  sdcard: let cmd_valid_while_locked() returns a bool
  sdcard: rename sd_set_$REG() functions called once as sd_reset_$REG()
  sdcard: use the registerfields API to access the OCR register
  sdcard: use G_BYTE from cutils
  sdcard: remove unreachable code
  sdcard: replace switch(unique case) statements -> if(case)
  sdcard: use a 16-bit integer for the 16-bit RCA register
  sdcard: let function handling response codes returns the response size
  sdcard: add missing command CMD55
  sdcard: add missing CMD54 SDIO command
  sdcard: add missing SPI legal commands
  sdcard: fix SPI response length
  sdcard: add an enum for the SD PHY Spec version
  sdcard: check if the card capacity is supported
  sdcard: Don't always set the high capacity bit
  sdcard: add cmd_version_supported(), improve cmd_class_supported()
  sdcard: remove unreachable SPI commands
  sdcard: store the bus protocol in an enum
  sdcard: introduce Spec v3.01 SD commands
  sdcard: introduce Spec v4.51 & v5.1 MMC commands

 include/hw/sd/sd.h            |   6 +
 include/hw/sd/sdcard_legacy.h |   2 +-
 hw/sd/sd.c                    | 872 +++++++++++++++++++++++++++++-------------
 hw/sd/trace-events            |  15 +
 4 files changed, 627 insertions(+), 268 deletions(-)

-- 
2.15.1
