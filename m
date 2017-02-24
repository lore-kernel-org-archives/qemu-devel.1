Received: from eggs.gnu.org ([2001:4830:134:3::10]:50416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1chIux-0003O8-PU
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1chIuw-0001CP-Nd
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:40:27 -0500
From: Clement Deschamps <clement.deschamps@antfield.fr>
Date: Fri, 24 Feb 2017 17:40:17 +0100
Message-Id: <20170224164021.9066-1-clement.deschamps@antfield.fr>
Subject: [Qemu-devel] [PATCH v3 0/4] bcm2835: add sdhost and gpio controllers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org, peter.maydell@linaro.org, andrew.baumann@microsoft.com

This patches add the Arasan SDHost controller and the GPIO controller to the BCM2835/36 platforms.

This patches have been tested with raspbian 2015-09-24 (which uses the SDHCI controller),
and raspbian 2017-01-11 (which dynamically switches to the SDHost controller).


I spotted an issue with the raspi2 platform, but it is not related to this patch.
The CP15 timer frequency is set to 19.20MHz in the raspbian kernel DTB.
There is a constant (GTIMER_SCALE) in target/arm/internals.h which seems to tell that the timer is at 62.5MHz.
This causes problems:
- The sleep command entered in guest lasts around 1/3 of the time it is supposed to last.
- The cursor is blinking faster that it should
- The systemd timeouts expire too early.          
- ...

Did you already have this issue on another platform ?
Should the frequency in the DTB be dynamically replaced depending on the GTIMER_SCALE value ?
Or should the constant GTIMER_SCALE be platform dependent ?


v2:
- implements the GPIO controller for supporting SD controller selection via alternate functions of GPIOs 48-53

v3:
- removed unneeded alias (sd-bus-2)
- changed license to GPLv2 'or later'
- moved the sdbus_reparent_card() function to hw/sd/core.c
- added 'readonly' state propagation in sdbus_reparent_card()
- the gpio controller is now exposing an sdbus and has 2 references to sdbus of sdhci and sdhost controllers

Clement Deschamps (4):
  bcm2835_sdhost: add bcm2835 sdhost controller
  hw/sd: add card-reparenting function
  bcm2835_gpio: add bcm2835 gpio controller
  bcm2835: add sdhost and gpio controllers

 hw/arm/bcm2835_peripherals.c         |  43 +++-
 hw/gpio/Makefile.objs                |   1 +
 hw/gpio/bcm2835_gpio.c               | 353 ++++++++++++++++++++++++++++
 hw/sd/Makefile.objs                  |   1 +
 hw/sd/bcm2835_sdhost.c               | 429 +++++++++++++++++++++++++++++++++++
 hw/sd/core.c                         |  30 +++
 include/hw/arm/bcm2835_peripherals.h |   4 +
 include/hw/gpio/bcm2835_gpio.h       |  39 ++++
 include/hw/sd/bcm2835_sdhost.h       |  48 ++++
 include/hw/sd/sd.h                   |   1 +
 10 files changed, 947 insertions(+), 2 deletions(-)
 create mode 100644 hw/gpio/bcm2835_gpio.c
 create mode 100644 hw/sd/bcm2835_sdhost.c
 create mode 100644 include/hw/gpio/bcm2835_gpio.h
 create mode 100644 include/hw/sd/bcm2835_sdhost.h

-- 
2.11.1
