Received: from eggs.gnu.org ([2001:4830:134:3::10]:60315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVma-0005Iv-Pn
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmX-0002Rq-Mo
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:29:52 -0500
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:42517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmX-0002Rh-I7
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:29:49 -0500
Received: by mail-vk0-x241.google.com with SMTP id b132so1054022vke.9
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 18:29:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 23:29:25 -0300
Message-Id: <20180216022933.10945-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/7] SDHCI: convert legacy devices to the
 SDBus API (part 6)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>, Michael Walle <michael@walle.cc>, Stefan Weil <sw@weilnetz.de>

Hi,

Since v2:
- pl181: remove legacy sd_set_cb() (Peter)

Since v1:
- rebased on /master (Peter sdcard reset() patches)
- fix milkymist-mmc from previous seris using instance_init (Michael Walle)

This series convert 3 devices using the legacy SDCard API to the SDBus API:
- milkymist-mmc
- pl181
- ssi-sd

Then move the legacy API to a separate header "sdcard_legacy.h".

Now the OMAP MMC is the last device using the legacy API, but need to get
QOM'ified first.

Having a common sdbus interface simplify qtesting (next series)

This series is not related to the previous set (4/5) and can be applied
independently.

Regards,

Phil.

$ git backport-diff
001/7:[----] [--] 'hw/sd/milkymist-memcard: use qemu_log_mask()'
002/7:[----] [--] 'hw/sd/milkymist-memcard: split realize() out of SysBusDevice init()'
003/7:[----] [--] 'hw/sd/milkymist-memcard: expose a SDBus and connect the SDCard to it'
004/7:[----] [--] 'hw/sd/ssi-sd: use the SDBus API, connect the SDCard to the bus'
005/7:[0034] [FC] 'hw/sd/pl181: expose a SDBus and connect the SDCard to it'
006/7:[down] 'hw/sd: make sd_data_ready() static'
007/7:[0003] [FC] 'hw/sd: move sdcard legacy API to "hw/sd/sdcard_legacy.h"'

Philippe Mathieu-Daudé (7):
  hw/sd/milkymist-memcard: use qemu_log_mask()
  hw/sd/milkymist-memcard: split realize() out of SysBusDevice init()
  hw/sd/milkymist-memcard: expose a SDBus and connect the SDCard to it
  hw/sd/ssi-sd: use the SDBus API, connect the SDCard to the bus
  hw/sd/pl181: expose a SDBus and connect the SDCard to it
  hw/sd: make sd_data_ready() static
  hw/sd: move sdcard legacy API to "hw/sd/sdcard_legacy.h"

 include/hw/sd/sd.h            | 17 ---------
 include/hw/sd/sdcard_legacy.h | 50 ++++++++++++++++++++++++++
 hw/sd/milkymist-memcard.c     | 81 ++++++++++++++++++++++++-------------------
 hw/sd/omap_mmc.c              |  2 +-
 hw/sd/pl181.c                 | 59 +++++++++++++++++++++++--------
 hw/sd/sd.c                    |  3 +-
 hw/sd/ssi-sd.c                | 32 ++++++++++-------
 7 files changed, 162 insertions(+), 82 deletions(-)
 create mode 100644 include/hw/sd/sdcard_legacy.h

-- 
2.16.1
