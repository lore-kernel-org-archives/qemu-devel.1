Received: from eggs.gnu.org ([209.51.188.92]:50008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGeW-00038O-C9
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGTv-0006Pb-LI
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:12 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGTu-0006Nb-S3
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:11 -0500
Received: by mail-wr1-x442.google.com with SMTP id q18so6327475wrx.9
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 04:51:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 12:50:53 +0000
Message-Id: <20190214125107.22178-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/14] Add model of the Arm Musca devboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset adds a model of the Arm Musca devboards
('musca-a' and 'musca-b1').
These boards are described here:
https://developer.arm.com/products/system-design/development-boards/iot-test-chips-and-boards/musca-a-test-chip-board
https://developer.arm.com/products/system-design/development-boards/iot-test-chips-and-boards/musca-b-test-chip-board

They're based on the SSE-200 subsystem for embedded which
we already have a model of. The two boards are somewhat
similar but have a different layout of devices (Musca-B1
puts them behind a more sophisticated PPC setup).

I've tested Musca-A with the Zephyr RTOS's "hello world"
program, and Musca-B1 with Arm Trusted Firmware M.
(Arm-TFM does in theory support also Musca-A, but in practice
it requires proper QSPI flash device support there; Zephyr
currently supports only Musca-A.)

Zephyr getting started guide:
https://docs.zephyrproject.org/latest/getting_started/index.html
Arm-TFM build instructions:
https://git.trustedfirmware.org/trusted-firmware-m.git/about/docs/user_guides/tfm_build_instruction.md

The first half of the patchset is some fairly straightforward
bugfixes and enhancements to various devices; the second half
does the actual implementation.

thanks
-- PMM

Peter Maydell (14):
  hw/arm/armsse: Fix miswiring of expansion IRQs
  hw/misc/tz-ppc: Support having unused ports in the middle of the range
  hw/timer/pl031: Allow use as an embedded-struct device
  hw/timer/pl031: Convert to using trace events
  hw/char/pl011: Allow use as an embedded-struct device
  hw/char/pl011: Support all interrupt lines
  hw/char/pl011: Use '0x' prefix when logging hex numbers
  hw/arm/armsse: Document SRAM_ADDR_WIDTH property in header comment
  hw/arm/armsse: Allow boards to specify init-svtor
  hw/arm/musca.c: Implement models of the Musca-A and -B1 boards
  hw/arm/musca: Add PPCs
  hw/arm/musca: Add MPCs
  hw/arm/musca: Wire up PL031 RTC
  hw/arm/musca: Wire up PL011 UARTs

 hw/arm/Makefile.objs            |   1 +
 include/hw/arm/armsse.h         |   5 +
 include/hw/char/pl011.h         |  34 ++
 include/hw/misc/tz-ppc.h        |   8 +-
 include/hw/timer/pl031.h        |  44 +++
 hw/arm/armsse.c                 |  10 +-
 hw/arm/musca.c                  | 669 ++++++++++++++++++++++++++++++++
 hw/char/pl011.c                 |  81 ++--
 hw/misc/tz-ppc.c                |  32 ++
 hw/timer/pl031.c                |  80 ++--
 MAINTAINERS                     |   7 +
 default-configs/arm-softmmu.mak |   1 +
 hw/timer/trace-events           |   6 +
 13 files changed, 890 insertions(+), 88 deletions(-)
 create mode 100644 include/hw/timer/pl031.h
 create mode 100644 hw/arm/musca.c

-- 
2.20.1
