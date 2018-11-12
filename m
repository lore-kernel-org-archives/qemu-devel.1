Received: from eggs.gnu.org ([2001:4830:134:3::10]:52737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJyj-0005iV-G9
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJyf-0002Xp-3B
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:42:41 -0500
Received: from steffen-goertz.de ([88.198.119.201]:35450)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJye-0002VR-IL
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:42:36 -0500
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon, 12 Nov 2018 16:42:10 -0500
Message-Id: <20181112214224.31560-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 00/14] arm: nRF51 Devices and Microbit
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

This series contains additional peripheral devices for the nRF51822
microcontroller.=20

Included devices:
- Random Number Generator
- Non-volatile Memories
- General purpose I/O
- Timer=20
- Stub for clock peripheral

v5:
	* Nearly entirely new timer. The old timer had a lot of flaws. Review ma=
rks removed.
    * Basic test for new timer
    * Flash memory is now implemented by NRF51 NVM using a rom_device; Ob=
eys write_enable and erase_enable.
    * Removed wrapper around qtest_set_irq (Thomas).
    * Use g_assert_not_reached in complementary default case in nrf51_gpi=
o (Peter).
    * Revised multiline comments.=20

v4:
    * Use int's instead of long's in set_irq_in, allow arbitrary base, fi=
x documentation (Laurent)
    * Do not clear UICR on reset (Stefan)
    * Remove c99 style variable declaration (Peter)
    * Default case for is_connected (Stefan)
    * Timer retrigger after live migration (Stefan)
    * Various small fixes (Stefan)

v3:
    * Included device instantiation in this patch
    * All devices use the common definitions provided by the header
    * Removed obsolete comment from NVM header
    * Device Struct names have consistent capitalisation

v2:
    * Factored out common definitions to won header (Stefan)
    * Add set_irq_in command to support tests for GPIO
    * Add tests for GPIO
    * Removed LED matrix from this patch set
    * Small tidy ups on RNG, NVM, GPIO and Timer


Based-on: 20181025005052.27661-1-jusual@mail.ru

Steffen G=C3=B6rtz (14):
  qtest: Add set_irq_in command to set IRQ/GPIO level
  arm: Add header to host common definition for nRF51 SOC peripherals
  hw/misc/nrf51_rng: Add NRF51 random number generator peripheral
  arm: Instantiate NRF51 random number generator
  hw/nvram/nrf51_nvm: Add nRF51 non-volatile memories
  arm: Instantiate NRF51 special NVM's and NVMC
  tests: Add bbc:microbit / nRF51 test suite
  hw/gpio/nrf51_gpio: Add nRF51 GPIO peripheral
  arm: Instantiate NRF51 general purpose I/O
  tests/microbit-test: Add Tests for nRF51 GPIO
  hw/timer/nrf51_timer: Add nRF51 Timer peripheral
  arm: Instantiate NRF51 Timers
  tests/microbit-test: Add Tests for nRF51 Timer
  arm: Add Clock peripheral stub to NRF51 SOC

 Makefile.objs                  |   1 +
 hw/arm/nrf51_soc.c             | 152 ++++++++++---
 hw/gpio/Makefile.objs          |   1 +
 hw/gpio/nrf51_gpio.c           | 300 ++++++++++++++++++++++++++
 hw/gpio/trace-events           |   7 +
 hw/misc/Makefile.objs          |   1 +
 hw/misc/nrf51_rng.c            | 262 +++++++++++++++++++++++
 hw/nvram/Makefile.objs         |   1 +
 hw/nvram/nrf51_nvm.c           | 378 +++++++++++++++++++++++++++++++++
 hw/timer/Makefile.objs         |   1 +
 hw/timer/nrf51_timer.c         | 337 +++++++++++++++++++++++++++++
 hw/timer/trace-events          |   5 +
 include/hw/arm/nrf51.h         |  45 ++++
 include/hw/arm/nrf51_soc.h     |  11 +
 include/hw/char/nrf51_uart.h   |   1 -
 include/hw/gpio/nrf51_gpio.h   |  69 ++++++
 include/hw/misc/nrf51_rng.h    |  83 ++++++++
 include/hw/nvram/nrf51_nvm.h   |  64 ++++++
 include/hw/timer/nrf51_timer.h |  81 +++++++
 qtest.c                        |  43 ++++
 tests/Makefile.include         |   2 +
 tests/libqtest.c               |  10 +
 tests/libqtest.h               |  13 ++
 tests/microbit-test.c          | 358 +++++++++++++++++++++++++++++++
 24 files changed, 2197 insertions(+), 29 deletions(-)
 create mode 100644 hw/gpio/nrf51_gpio.c
 create mode 100644 hw/gpio/trace-events
 create mode 100644 hw/misc/nrf51_rng.c
 create mode 100644 hw/nvram/nrf51_nvm.c
 create mode 100644 hw/timer/nrf51_timer.c
 create mode 100644 include/hw/arm/nrf51.h
 create mode 100644 include/hw/gpio/nrf51_gpio.h
 create mode 100644 include/hw/misc/nrf51_rng.h
 create mode 100644 include/hw/nvram/nrf51_nvm.h
 create mode 100644 include/hw/timer/nrf51_timer.h
 create mode 100644 tests/microbit-test.c

--=20
2.19.1
