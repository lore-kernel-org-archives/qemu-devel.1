Received: from eggs.gnu.org ([2001:4830:134:3::10]:60027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9RB-00086G-Tp
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9R8-0002wc-PL
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:24:49 -0500
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:33294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9R8-0002wL-JY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:24:46 -0500
Received: by mail-qt0-x233.google.com with SMTP id e2so15239927qti.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:24:46 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 15:24:22 -0300
Message-Id: <20180115182436.2066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 00/14] SDHCI: housekeeping (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

Since v7:
- addressed Peter & Paolo reviews 
  - do not use qdev_property_add_static() but move common properties into
    a new DEFINE_SDHCI_COMMON_PROPERTIES()
  - use &address_space_memory rather than create AS with address_space_init()

Since v6:
- addressed Peter reviews
  - do not use an unique Property[] for both sysbus/pci
    Peter didn't recommend me to use the qdev_property_add_static() API since
    it is only used by the ARM cpus and may be due for removal, however I found
    it cleaner.
    At the end of those series, the only differences is the sysbus having 2
    more properties: "pending-insert-quirk" and "dma", all other are generic
    to SDHCI and shared.
  - use the PCI AS for DMA.
    Should we check for the PCI_COMMAND_MASTER bit?

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
001/14:[----] [--] 'sdhci: clean up includes'
002/14:[----] [--] 'sdhci: remove dead code'
003/14:[0043] [FC] 'sdhci: use DEFINE_SDHCI_COMMON_PROPERTIES() for common sysbus/pci properties'
004/14:[0001] [FC] 'sdhci: refactor common sysbus/pci class_init() into sdhci_common_class_init()'
005/14:[----] [-C] 'sdhci: refactor common sysbus/pci realize() into sdhci_common_realize()'
006/14:[----] [-C] 'sdhci: refactor common sysbus/pci unrealize() into sdhci_common_unrealize()'
007/14:[----] [--] 'sdhci: use qemu_log_mask(UNIMP) instead of fprintf()'
008/14:[----] [--] 'sdhci: convert the DPRINT() calls into trace events'
009/14:[----] [--] 'sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"'
010/14:[----] [--] 'sdhci: rename the SDHC_CAPAB register'
011/14:[0008] [FC] 'sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only'
012/14:[----] [--] 'sdhci: Implement write method of ACMD12ERRSTS register'
013/14:[0006] [FC] 'sdhci: fix the PCI device, using the PCI address space for DMA'
014/14:[0023] [FC] 'sdhci: add a 'dma' property to the sysbus devices'

Andrey Smirnov (1):
  sdhci: Implement write method of ACMD12ERRSTS register

Philippe Mathieu-Daudé (13):
  sdhci: clean up includes
  sdhci: remove dead code
  sdhci: use DEFINE_SDHCI_COMMON_PROPERTIES() for common sysbus/pci properties
  sdhci: refactor common sysbus/pci class_init() into sdhci_common_class_init()
  sdhci: refactor common sysbus/pci realize() into sdhci_common_realize()
  sdhci: refactor common sysbus/pci unrealize() into sdhci_common_unrealize()
  sdhci: use qemu_log_mask(UNIMP) instead of fprintf()
  sdhci: convert the DPRINT() calls into trace events
  sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"
  sdhci: rename the SDHC_CAPAB register
  sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only
  sdhci: fix the PCI device, using the PCI address space for DMA
  sdhci: add a 'dma' property to the sysbus devices

 include/hw/sd/sdhci.h  |  19 ++--
 hw/sd/sdhci-internal.h |   7 +-
 hw/sd/sdhci.c          | 266 ++++++++++++++++++++++++++++++-------------------
 hw/sd/trace-events     |  14 +++
 4 files changed, 190 insertions(+), 116 deletions(-)

-- 
2.15.1
