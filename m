Received: from eggs.gnu.org ([2001:4830:134:3::10]:57525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDBU-0002Za-UI
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDBQ-0005LY-0i
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:17 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 16:58:38 -0300
Message-Id: <20171213195852.30439-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/14] SDHCI housekeeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Fam Zheng <famz@redhat.com>

Hi,

This series refactor the SDHCI codebase to ease further development/series.

- 1: we restrict part of "sd/sd.h" into local "sd-internal.h",
- 2-5,13: we somehow beautiful the code, no logical changes,
- 6-9: we refactor the common sysbus/pci qdev code,
- 10-12: we add plenty of trace events which will result useful later,
- 14: we finally expose a "dma-memory" property.

Regards,

Phil.

Based-on: 20171213051736.17755-5-f4bug@amsat.org
          (Trivial changes in "registerfields.h")

Philippe Mathieu-Daudé (14):
  sd: split "sd-internal.h" of "hw/sd/sd.h"
  sdhci: clean up includes
  sdhci: use the ldst_le_dma API
  sdhci: use deposit64()
  sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"
  sdhci: refactor same sysbus/pci properties into a common one
  sdhci: refactor common sysbus/pci realize() into sdhci_realizefn()
  sdhci: refactor common sysbus/pci class_init() into sdhci_class_init()
  sdhci: refactor common sysbus/pci unrealize() into sdhci_unrealizefn()
  sdhci: use qemu_log_mask(UNIMP) instead of fprintf()
  sdhci: convert the DPRINT() calls into trace events
  sdhci: add a trace event for the LED control
  sdhci: add sdhci_init_capareg() to initialize the CAPAB register
  sdhci: add a "dma-memory" property

 include/hw/sd/sd.h        |  95 ++-----------------
 include/hw/sd/sdhci.h     |   6 +-
 hw/sd/sd-internal.h       | 119 +++++++++++++++++++++++
 hw/sd/sdhci-internal.h    |   5 +-
 hw/sd/core.c              |   3 +-
 hw/sd/milkymist-memcard.c |   2 +-
 hw/sd/omap_mmc.c          |   1 +
 hw/sd/pl181.c             |   2 +-
 hw/sd/pxa2xx_mmci.c       |   1 +
 hw/sd/sd.c                |   6 +-
 hw/sd/sdhci.c             | 235 ++++++++++++++++++++++++----------------------
 hw/sd/ssi-sd.c            |   2 +-
 hw/sd/trace-events        |  15 +++
 13 files changed, 276 insertions(+), 216 deletions(-)
 create mode 100644 hw/sd/sd-internal.h

-- 
2.15.1
