Received: from eggs.gnu.org ([2001:4830:134:3::10]:47645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSb-0000AQ-JV
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSY-0006sE-DJ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:17 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSY-0006sA-86
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:14 -0500
Received: by mail-qt0-x243.google.com with SMTP id d4so3126542qtj.5
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:08:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:07:48 -0300
Message-Id: <20180103180805.18140-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 00/17] SDHCI: housekeeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

Patches still missing review: 4, 5, 6, 7, 12.

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

Note, the bcm2835 seems to have 1KB minimum blocksize, however the current
model is implemented with 512B. I didn't change the current value.

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
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/17:[----] [--] 'sdhci: clean up includes'
002/17:[----] [--] 'sdhci: sort registers comments'
003/17:[----] [--] 'sdhci: remove dead code'
004/17:[----] [--] 'sdhci: refactor same sysbus/pci properties into a common one'
005/17:[----] [--] 'sdhci: refactor common sysbus/pci class_init() into sdhci_common_class_init()'
006/17:[0021] [FC] 'sdhci: refactor common sysbus/pci realize() into sdhci_common_realize()'
007/17:[0008] [FC] 'sdhci: refactor common sysbus/pci unrealize() into sdhci_common_unrealize()'
008/17:[----] [--] 'sdhci: use qemu_log_mask(UNIMP) instead of fprintf()'
009/17:[----] [--] 'sdhci: convert the DPRINT() calls into trace events'
010/17:[----] [--] 'sdhci: add a GPIO for the 'access control' LED'
011/17:[----] [--] 'sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"'
012/17:[----] [--] 'sdhci: use FIELD_DP32() macro for the WRITE_PROTECT flag'
013/17:[----] [--] 'sdhci: rename the SDHC_CAPAB register'
014/17:[----] [--] 'sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only'
015/17:[----] [--] 'sdhci: Implement write method of ACMD12ERRSTS register'
016/17:[----] [--] 'sdhci: use deposit64() on admasysaddr'
017/17:[----] [-C] 'sdhci: add a "dma-memory" property'

Andrey Smirnov (1):
  sdhci: Implement write method of ACMD12ERRSTS register

Philippe Mathieu-Daudé (16):
  sdhci: clean up includes
  sdhci: sort registers comments
  sdhci: remove dead code
  sdhci: refactor same sysbus/pci properties into a common one
  sdhci: refactor common sysbus/pci class_init() into sdhci_common_class_init()
  sdhci: refactor common sysbus/pci realize() into sdhci_common_realize()
  sdhci: refactor common sysbus/pci unrealize() into sdhci_common_unrealize()
  sdhci: use qemu_log_mask(UNIMP) instead of fprintf()
  sdhci: convert the DPRINT() calls into trace events
  sdhci: add a GPIO for the 'access control' LED
  sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"
  sdhci: use FIELD_DP32() macro for the WRITE_PROTECT flag
  sdhci: rename the SDHC_CAPAB register
  sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only
  sdhci: use deposit64() on admasysaddr
  sdhci: add a "dma-memory" property

 include/hw/sd/sdhci.h  |  38 +++++--
 hw/sd/sdhci-internal.h |  11 +-
 hw/sd/sdhci.c          | 286 ++++++++++++++++++++++++++++---------------------
 hw/sd/trace-events     |  15 +++
 4 files changed, 211 insertions(+), 139 deletions(-)

-- 
2.15.1
