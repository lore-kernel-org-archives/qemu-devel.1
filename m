Received: from eggs.gnu.org ([2001:4830:134:3::10]:44423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYa-0002Xr-Kn
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYX-000542-Hj
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:32 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYW-00053T-W7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:29 -0500
Received: by mail-qt0-x242.google.com with SMTP id f2so3234278qtj.4
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:30:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 16:30:08 -0300
Message-Id: <20180111193021.17466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/13] SDHCI: housekeeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>

All patches reviewed :)

Since v5:
- addressed Alistair reviews
- added Alistair R-b
- renamed the dma property "dma-memory" -> "dma"

Since v4:
- fixed incorrect use of &local_err in sdhci_sysbus/pci_realize()

Since v3:
- since the series was getting too big and first part reviewed, split in 2. 
- addressed Fam's review from "refactor the common sysbus/pci qdev"
  - improved commit descriptions
  - restored useful s->fifo_buffer = NULL
- added Alistair R-b

Since v2:
- more detailed 'capabilities', all boards converted to use these properties
- since all qtests pass, removed the previous 'capareg' property
- added Stefan/Alistair R-b
- corrected 'access' LED behavior (Alistair's review)
- more uses of the registerfields API
- remove some dead code
- cosmetix:
  - added more comments
  - renamed a pair of registers
  - reordered few struct members

Since v1:
- addressed Alistair Francis review comments, added some R-b
- only move register defines to "sd-internal.h"
- fixed deposit64() arguments
- dropped unuseful s->fifo_buffer = NULL
- use a qemu_irq for the LED, restrict the logging to ON/OFF
- fixed a trace format string error
- included Andrey Smirnov ACMD12ERRSTS write patch
- dropped few unuseful patches, and separate the Python polemical ones for later

>From the "SDHCI housekeeping" series:
- 1: we restrict part of "sd/sd.h" into local "sd-internal.h",
- 2,3: we somehow beautiful the code, no logical changes,
- 4-7: we refactor the common sysbus/pci qdev code,
- 8-10: we add plenty of trace events which will result useful later,
- 11: we finally expose a "dma-memory" property.
>From the "SDHCI: add a qtest and fix few issues" series:
- 12,13: fix registers
- 14,15: boards can specify which SDHCI Spec to use (v2 and v3 so far)
- 15-20: HCI qtest

Regards,

Phil.

$ git backport-diff
001/13:[----] [--] 'sdhci: clean up includes'
002/13:[----] [--] 'sdhci: remove dead code'
003/13:[0004] [FC] 'sdhci: refactor same sysbus/pci properties into a common one'
004/13:[----] [--] 'sdhci: refactor common sysbus/pci class_init() into sdhci_common_class_init()'
005/13:[----] [--] 'sdhci: refactor common sysbus/pci realize() into sdhci_common_realize()'
006/13:[----] [--] 'sdhci: refactor common sysbus/pci unrealize() into sdhci_common_unrealize()'
007/13:[----] [--] 'sdhci: use qemu_log_mask(UNIMP) instead of fprintf()'
008/13:[0020] [FC] 'sdhci: convert the DPRINT() calls into trace events'
009/13:[----] [--] 'sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"'
010/13:[----] [-C] 'sdhci: rename the SDHC_CAPAB register'
011/13:[0002] [FC] 'sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only'
012/13:[----] [--] 'sdhci: Implement write method of ACMD12ERRSTS register'
013/13:[0004] [FC] 'sdhci: add a "dma" property'

Andrey Smirnov (1):
  sdhci: Implement write method of ACMD12ERRSTS register

Philippe Mathieu-Daudé (12):
  sdhci: clean up includes
  sdhci: remove dead code
  sdhci: refactor same sysbus/pci properties into a common one
  sdhci: refactor common sysbus/pci class_init() into sdhci_common_class_init()
  sdhci: refactor common sysbus/pci realize() into sdhci_common_realize()
  sdhci: refactor common sysbus/pci unrealize() into sdhci_common_unrealize()
  sdhci: use qemu_log_mask(UNIMP) instead of fprintf()
  sdhci: convert the DPRINT() calls into trace events
  sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"
  sdhci: rename the SDHC_CAPAB register
  sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only
  sdhci: add a "dma" property

 include/hw/sd/sdhci.h  |  19 ++--
 hw/sd/sdhci-internal.h |   7 +-
 hw/sd/sdhci.c          | 260 ++++++++++++++++++++++++++++---------------------
 hw/sd/trace-events     |  14 +++
 4 files changed, 176 insertions(+), 124 deletions(-)

-- 
2.15.1
