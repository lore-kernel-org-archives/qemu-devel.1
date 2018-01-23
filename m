Received: from eggs.gnu.org ([2001:4830:134:3::10]:37624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIK-00034V-Px
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIH-0007cA-Lc
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:44 -0500
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:44886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIH-0007bm-HB
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:41 -0500
Received: by mail-qt0-x22a.google.com with SMTP id l20so25131435qtj.11
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:30:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:16 -0300
Message-Id: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/18] SDCard: bugfixes,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

Some refactors, few bugfixes, better SD/SPI support.

With this series apply, machines can use cards in UHS-I mode.
(mostly imported from Alistair Francis work)

MMC mode split out for another series.

Since v2:
- split again in 2... other part is cleanup/tracing

Since v1:
- rewrote mostly all patches to keep it simpler.

$ git backport-diff
001/18:[0003] [FC] 'sdcard: Don't always set the high capacity bit'
002/18:[down] 'sdcard: update the CSD CRC register regardless the CSD structure version'
003/18:[down] 'sdcard: fix the 'maximum data transfer rate' to 25MHz'
004/18:[down] 'sdcard: clean the SCR register and add few comments'
005/18:[down] 'sdcard: remove commands from unsupported old MMC specification'
006/18:[down] 'sdcard: simplify using the ldst API'
007/18:[down] 'sdcard: use the correct masked OCR in the R3 reply'
008/18:[down] 'sdcard: use the registerfields API for the CARD_STATUS register masks'
009/18:[down] 'sdcard: handles more commands in SPI mode'
010/18:[down] 'sdcard: handle CMD54 (SDIO)'
011/18:[down] 'sdcard: check the card is in correct state for APP CMD (CMD55)'
012/18:[down] 'sdcard: warn if host uses an incorrect address for APP CMD (CMD55)'
013/18:[down] 'sdcard: simplify SEND_IF_COND (CMD8)'
014/18:[down] 'sdcard: simplify SD_SEND_OP_COND (ACMD41)'
015/18:[down] 'sdcard: add SD SEND_TUNING_BLOCK (CMD19)'
016/18:[down] 'sdcard: add a 'uhs' property, update the OCR register ACCEPT_SWITCH_1V8 bit'
017/18:[down] 'sdcard: implement the UHS-I SWITCH_FUNCTION entries (Spec v3)'
018/18:[0006] [FC] 'sdcard: add an enum for the SD PHY Spec version'

Based-on: 20180123032135.28863-13-f4bug@amsat.org

Philippe Mathieu-Daudé (18):
  sdcard: Don't always set the high capacity bit
  sdcard: update the CSD CRC register regardless the CSD structure version
  sdcard: fix the 'maximum data transfer rate' to 25MHz
  sdcard: clean the SCR register and add few comments
  sdcard: remove commands from unsupported old MMC specification
  sdcard: simplify using the ldst API
  sdcard: use the correct masked OCR in the R3 reply
  sdcard: use the registerfields API for the CARD_STATUS register masks
  sdcard: handles more commands in SPI mode
  sdcard: handle CMD54 (SDIO)
  sdcard: check the card is in correct state for APP CMD (CMD55)
  sdcard: warn if host uses an incorrect address for APP CMD (CMD55)
  sdcard: simplify SEND_IF_COND (CMD8)
  sdcard: simplify SD_SEND_OP_COND (ACMD41)
  sdcard: add SD SEND_TUNING_BLOCK (CMD19)
  sdcard: add a 'uhs' property, update the OCR register ACCEPT_SWITCH_1V8 bit
  sdcard: implement the UHS-I SWITCH_FUNCTION entries (Spec v3)
  sdcard: add an enum for the SD PHY Spec version

 hw/sd/sd.c         | 501 +++++++++++++++++++++++++++++++++++++----------------
 hw/sd/trace-events |   1 +
 2 files changed, 354 insertions(+), 148 deletions(-)

-- 
2.15.1
