Received: from eggs.gnu.org ([2001:4830:134:3::10]:51171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cijJz-0000o8-Jl
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cijJy-0001OT-VB
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:04:11 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 14:55:07 +0000
Message-Id: <1488293711-14195-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] handle reparenting of SD cards for rpi2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Clement Deschamps <clement.deschamps@antfield.fr>, Paolo Bonzini <pbonzini@redhat.com>

These patches are a respin of Clement's work on the
rpi2 sd controller/gpio. They fix the valgrind issue that
I was seeing because we got reparenting of the card wrong.

This patchset adds a new qdev patch which makes the
qdev_set_parent_bus() function do most of the work of
unplugging and replugging if the device was already on
a bus. In particular it calls bus_remove_child() which does
a lot of things that the previous "just call object_unparent"
attempt didn't do.

Comments on whether this makes sense to people welcome.
I'm still kind of hoping we can squeeze this into 2.9;
comments on whether that would be unwise also welcome.

thanks
-- PMM


Clement Deschamps (3):
  hw/sd: add card-reparenting function
  bcm2835_gpio: add bcm2835 gpio controller
  bcm2835: add sdhost and gpio controllers

Peter Maydell (1):
  qdev: Have qdev_set_parent_bus() handle devices already on a bus

 hw/gpio/Makefile.objs                |   1 +
 include/hw/arm/bcm2835_peripherals.h |   4 +
 include/hw/gpio/bcm2835_gpio.h       |  39 ++++
 include/hw/sd/sd.h                   |  11 ++
 hw/arm/bcm2835_peripherals.c         |  43 ++++-
 hw/core/qdev.c                       |  14 ++
 hw/gpio/bcm2835_gpio.c               | 353 +++++++++++++++++++++++++++++++++++
 hw/sd/core.c                         |  27 +++
 8 files changed, 490 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/gpio/bcm2835_gpio.h
 create mode 100644 hw/gpio/bcm2835_gpio.c

-- 
2.7.4
