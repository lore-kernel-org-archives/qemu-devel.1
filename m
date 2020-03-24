Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C1CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E98A206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E98A206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGk0r-0006YE-Lj
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jGk0B-00068S-J3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1jGk09-0006vZ-MV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:53:55 -0400
Received: from michel.telenet-ops.be ([2a02:1800:110:4::f00:18]:40166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1jGk09-0006pu-GS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:53:53 -0400
Received: from ramsan ([84.195.182.253]) by michel.telenet-ops.be with bizsmtp
 id JDtb2200n5USYZQ06DtbLp; Tue, 24 Mar 2020 14:53:48 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jGjzr-0006Nd-Qp; Tue, 24 Mar 2020 14:53:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jGjzr-0001WE-My; Tue, 24 Mar 2020 14:53:35 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v6 0/8] gpio: Add GPIO Aggregator
Date: Tue, 24 Mar 2020 14:53:28 +0100
Message-Id: <20200324135328.5796-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:110:4::f00:18
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

	Hi all,

GPIO controllers are exported to userspace using /dev/gpiochip*
character devices.  Access control to these devices is provided by
standard UNIX file system permissions, on an all-or-nothing basis:
either a GPIO controller is accessible for a user, or it is not.
Currently no mechanism exists to control access to individual GPIOs.

Hence this adds a GPIO driver to aggregate existing GPIOs, and expose
them as a new gpiochip.  This is useful for implementing access control,
and assigning a set of GPIOs to a specific user.  Furthermore, this
simplifies and hardens exporting GPIOs to a virtual machine, as the VM
can just grab the full GPIO controller, and no longer needs to care
about which GPIOs to grab and which not, reducing the attack surface.

Recently, other use cases have been discovered[1]:
  - Describing simple GPIO-operated devices in DT, and using the GPIO
    Aggregator as a generic GPIO driver for userspace, which is useful
    for industrial control.

Changes compared to v5[2]:
  - Convert raw gpiod_lookup users to GPIO_LOOKUP*(),
  - Update Documentation/driver-api/gpio/board.rst for gpiod_lookup
    changes,
  - Reword rationale behing looking up GPIOs by line name,
  - Introduce gpiod_set_config(),
  - Use gpiod_to_chip() instead of open-coding,
  - Drop debug print of gpio_desc.label, as it usually points to the
    GPIO Aggregator itself,
  - Drop no longer needed #include "gpiolib.h",
  - Fix missing offset translation in gpio_fwd_set_config(),
  - Fix "allows" without object,
  - Drop "gpiochipN" support,
  - Extend example,

Changes compared to v4[3]:
  - Add Reviewed-by, Tested-by,
  - Fix inconsistent indentation in documentation.

Changes compared to v3[4] (more details in the individual patches):
  - Drop controversial GPIO repeater,
  - Drop support for legacy sysfs interface based name matching,
  - Drop applied "gpiolib: Add GPIOCHIP_NAME definition",
  - Documentation improvements,
  - Lots of small cleanups.

Changes compared to v2[5] (more details in the individual patches):
  - Integrate GPIO Repeater functionality,
  - Absorb GPIO forwarder library, as the Aggregator and Repeater are
    now a single driver,
  - Use the aggregator parameters to create a GPIO lookup table instead
    of an array of GPIO descriptors,
  - Add documentation,
  - New patches:
      - "gpiolib: Add GPIOCHIP_NAME definition",
      - "gpiolib: Add support for gpiochipN-based table lookup",
      - "gpiolib: Add support for GPIO line table lookup",
      - "dt-bindings: gpio: Add gpio-repeater bindings",
      - "docs: gpio: Add GPIO Aggregator/Repeater documentation",
      - "MAINTAINERS: Add GPIO Aggregator/Repeater section".
  - Dropped patches:
      - "gpio: Export gpiod_{request,free}() to modular GPIO code",
      - "gpio: Export gpiochip_get_desc() to modular GPIO code",
      - "gpio: Export gpio_name_to_desc() to modular GPIO code",
      - "gpio: Add GPIO Forwarder Helper".

Changes compared to v1[6]:
  - Drop "virtual", rename to gpio-aggregator,
  - Create and use new GPIO Forwarder Helper, to allow sharing code with
    the GPIO inverter,
  - Lift limit on the maximum number of GPIOs,
  - Improve parsing of GPIO specifiers,
  - Fix modular build.

Aggregating GPIOs and exposing them as a new gpiochip was suggested in
response to my proof-of-concept for GPIO virtualization with QEMU[7][8].

For the first use case, aggregated GPIO controllers are instantiated and
destroyed by writing to atribute files in sysfs.
Sample session on the Renesas Koelsch development board:

  - Unbind LEDs from leds-gpio driver:

        echo leds > /sys/bus/platform/drivers/leds-gpio/unbind

  - Create aggregators:

    $ echo e6052000.gpio 19,20 \
        > /sys/bus/platform/drivers/gpio-aggregator/new_device

    gpio-aggregator gpio-aggregator.0: gpio 0 => gpio-953
    gpio-aggregator gpio-aggregator.0: gpio 1 => gpio-954
    gpiochip_find_base: found new base at 758
    gpio gpiochip12: (gpio-aggregator.0): added GPIO chardev (254:13)
    gpiochip_setup_dev: registered GPIOs 758 to 759 on device: gpiochip12 (gpio-aggregator.0)

    $ echo e6052000.gpio 21 e6050000.gpio 20-22 \
        > /sys/bus/platform/drivers/gpio-aggregator/new_device

    gpio-aggregator gpio-aggregator.1: gpio 0 => gpio-955
    gpio-aggregator gpio-aggregator.1: gpio 1 => gpio-1012
    gpio-aggregator gpio-aggregator.1: gpio 2 => gpio-1013
    gpio-aggregator gpio-aggregator.1: gpio 3 => gpio-1014
    gpiochip_find_base: found new base at 754
    gpio gpiochip13: (gpio-aggregator.1): added GPIO chardev (254:13)
    gpiochip_setup_dev: registered GPIOs 754 to 757 on device: gpiochip13 (gpio-aggregator.1)

  - Adjust permissions on /dev/gpiochip1[23] (optional)

  - Control LEDs:

    $ gpioset gpiochip12 0=0 1=1 # LED6 OFF, LED7 ON
    $ gpioset gpiochip12 0=1 1=0 # LED6 ON, LED7 OFF
    $ gpioset gpiochip13 0=1     # LED8 ON
    $ gpioset gpiochip13 0=0     # LED8 OFF

  - Destroy aggregators:

    $ echo gpio-aggregator.0 \
            > /sys/bus/platform/drivers/gpio-aggregator/delete_device
    $ echo gpio-aggregator.1 \
            > /sys/bus/platform/drivers/gpio-aggregator/delete_device

To ease testing, I have pushed this series to the
topic/gpio-aggregator-v6 branch of my renesas-drivers repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
Kbuild test robot <lkp@intel.com> reported no issues.

Thanks!

References:
  [1] "[PATCH V4 2/2] gpio: inverter: document the inverter bindings"
      (https://lore.kernel.org/r/1561699236-18620-3-git-send-email-harish_kandiga@mentor.com/)
  [2] "[PATCH v5 0/5] gpio: Add GPIO Aggregator"
      (https://lore.kernel.org/r/20200218151812.7816-1-geert+renesas@glider.be/)
  [3] "[PATCH v4 0/5] gpio: Add GPIO Aggregator"
      (https://lore.kernel.org/r/20200115181523.23556-1-geert+renesas@glider.be)
  [4] "[PATCH v3 0/7] gpio: Add GPIO Aggregator/Repeater"
      (https://lore.kernel.org/r/20191127084253.16356-1-geert+renesas@glider.be/)
  [5] "[PATCH/RFC v2 0/5] gpio: Add GPIO Aggregator Driver"
      (https://lore.kernel.org/r/20190911143858.13024-1-geert+renesas@glider.be/)
  [6] "[PATCH RFC] gpio: Add Virtual Aggregator GPIO Driver"
      (https://lore.kernel.org/r/20190705160536.12047-1-geert+renesas@glider.be/)
  [7] "[PATCH QEMU POC] Add a GPIO backend"
      (https://lore.kernel.org/r/20181003152521.23144-1-geert+renesas@glider.be/)
  [8] "Getting To Blinky: Virt Edition / Making device pass-through
       work on embedded ARM"
      (https://fosdem.org/2019/schedule/event/vai_getting_to_blinky/)

Geert Uytterhoeven (8):
  ARM: integrator: impd1: Use GPIO_LOOKUP() helper macro
  i2c: i801: Use GPIO_LOOKUP() helper macro
  mfd: sm501: Use GPIO_LOOKUP_IDX() helper macro
  gpiolib: Add support for GPIO lookup by line name
  gpiolib: Introduce gpiod_set_config()
  gpio: Add GPIO Aggregator
  docs: gpio: Add GPIO Aggregator documentation
  MAINTAINERS: Add GPIO Aggregator section

 .../admin-guide/gpio/gpio-aggregator.rst      | 111 ++++
 Documentation/admin-guide/gpio/index.rst      |   1 +
 Documentation/driver-api/gpio/board.rst       |  10 +-
 MAINTAINERS                                   |   7 +
 arch/arm/mach-integrator/impd1.c              |  11 +-
 drivers/gpio/Kconfig                          |  12 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-aggregator.c                | 568 ++++++++++++++++++
 drivers/gpio/gpiolib.c                        |  50 +-
 drivers/i2c/busses/i2c-i801.c                 |   6 +-
 drivers/mfd/sm501.c                           |  24 +-
 include/linux/gpio/consumer.h                 |   8 +
 include/linux/gpio/machine.h                  |  15 +-
 13 files changed, 776 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/gpio-aggregator.rst
 create mode 100644 drivers/gpio/gpio-aggregator.c

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

