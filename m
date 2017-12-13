Received: from eggs.gnu.org ([2001:4830:134:3::10]:39302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtb-0003xO-CR
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtY-0006BR-7m
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:44:51 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 17:44:25 -0300
Message-Id: <20171213204436.5379-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/11] QOM'ify SDBus, housekeeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Hi,

This series also refactor the SDBus codebase to ease further development/series.

- 1: we add another hexbuf_strdup() helper, hoping someone will come with a
     clever way to do the same :)
- 2,4,5: add a sdbus_create_bus(master) and sdbus_create_slave(bus) to use
     instead of the current qbus_create_inplace(),
- 3: we add some trace events which will result useful later,
- 6-10: we use the TYPE_INTERFACE to enforce a stricter QOM, this also allow us
     to remove duplicate types,
- 11: we let the Xilinx Zynq machine set the "sd-bus-name" property, so now a
     slave SDCard can be now hot-plugged in the second bus.

In a later series we will update the PL181 and BCM2835 devices, having them
implement the TYPE_SD_BUS_MASTER_INTERFACE.

Regards,

Phil.

Based-on: 20171213195852.30439-15-f4bug@amsat.org
          (SDHCI housekeeping)

Philippe Mathieu-Daudé (11):
  util/cutils: add qemu_hexbuf_strdup(), yet another hexdump()
  bcm2835_peripherals: move GPIO 'sdbus' property link from init() ->
    realize()
  sdbus: add trace events
  sdbus: add sdbus_create_bus() to replace qbus_create_inplace()
  sdbus: add sdbus_create_slave()
  sdbus: rename SDCardClass -> SDSlaveClass
  sdbus: add a SD_BUS_SLAVE interface
  sdbus: add a SD_BUS_MASTER interface
  sdhci: implement the SD_BUS_MASTER interface
  hw/sd/pxa2xx: implement the SD_BUS_MASTER interface
  hw/arm/xilinx_zynq: use sdbus_create_slave() to name the different SD
    busses

 include/hw/sd/sd.h           |  3 ++
 include/hw/sd/sdhci.h        |  3 +-
 include/qemu/cutils.h        |  3 ++
 hw/sd/sd-internal.h          | 14 ++++++---
 hw/arm/bcm2835_peripherals.c |  9 +++---
 hw/arm/xilinx_zynq.c         |  9 ++++--
 hw/sd/core.c                 | 74 +++++++++++++++++++++++++++++++++++++-------
 hw/sd/pxa2xx_mmci.c          | 36 +++++++--------------
 hw/sd/sd.c                   |  8 +++--
 hw/sd/sdhci.c                | 66 +++++++++++++++++----------------------
 util/hexdump.c               | 19 ++++++++++++
 hw/sd/trace-events           |  6 ++++
 12 files changed, 162 insertions(+), 88 deletions(-)

-- 
2.15.1
