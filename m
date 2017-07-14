Received: from eggs.gnu.org ([2001:4830:134:3::10]:53530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVyCS-0004xc-AJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVyCN-0007Fj-Us
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:51:56 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 11:51:18 +0100
Message-Id: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/9] ARM: implement MPS2 board (with 2 FPGA
 flavours)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>

This patchseries adds support for the ARM MPS2/MPS2+ dev board:

The MPS2 and MPS2+ dev boards are FPGA based (the 2+ has a bigger
FPGA but is otherwise the same as the 2). Since the CPU itself
and most of the devices are in the FPGA, the details of the board
as seen by the guest depend significantly on the FPGA image.

We model the following FPGA images:
 "mps2_an385" -- Cortex-M3 as documented in ARM Application Note AN385
 "mps2_an511" -- Cortex-M3 'DesignStart' as documented in AN511

They are fairly similar but differ in the details for some
peripherals.
Further info and links to all the documentation for the
board and the various FPGA images can be found here:
 https://developer.arm.com/products/system-design/development-boards/cortex-m-prototyping-system

This patchset adds the boards themselves, and the UART, timer
and system-controller devices they need. There are a number
of other devices on the board which are not yet modelled
(notably more GPIOs, a watchdog, another different kind of timer,
and a display device), but this minimal set is sufficient to
boot the "hello world" binary of the Zephyr RTOS and the
"blinky" binary of the mbed RTOS.
[To run the zephyr binary you also need this fix:
  http://patchwork.ozlabs.org/patch/782811/
 which is in the target-arm pullreq I just sent so should
 get into master in a few days.]

We can add more devices to the model later, but I figured
this was a sufficient place to start.

The underlying motivation here is that the v8M work that I
have planned will need a board, and there is a v8M FPGA
image for the MPS2 that we can use. It's also perhaps a more
useful M profile board for general purposes than the stellaris
boards (64K RAM) or the Netduino2 (128K RAM), since it has
16MB of RAM.

Changes v1->v2:
 * fixed handling of ID register arrays in uart and timer devices
 * moved variable declarations to top of function
 * removed stray braces
 * log guest error if Tx enabled with bad baudrate
 * fixed cut-n-paste error in mps2-scc.h header comment
 * added ethernet support (I actually wrote this patch earlier
   but forgot to put it in v1 ;-))
 * added MAINTAINERS file entries

Non-change:
 * I've stuck with the naming of types/files/boards in the
   first patch, because after consideration I still think
   this is the best choice overall.

Patches which still need review: 1, 2, 8, 9

I'd quite like to get this into 2.10 if possible
(softfreeze deadline rapidly approaching) so if people
have time to review before tuesday that would be great.

thanks
-- PMM

Peter Maydell (9):
  hw/arm/mps2: Implement skeleton mps2-an385 and mps2-an511 board models
  hw/char/cmsdk-apb-uart.c: Implement CMSDK APB UART
  hw/arm/mps2: Add UARTs
  hw/char/cmsdk-apb-timer: Implement CMSDK APB timer device
  hw/arm/mps2: Add timers
  hw/misc/mps2_scc: Implement MPS2 Serial Communication Controller
  hw/arm/mps2: Add SCC
  hw/arm/mps2: Add ethernet
  MAINTAINERS: Add entries for MPS2 board

 hw/arm/Makefile.objs               |   1 +
 hw/char/Makefile.objs              |   1 +
 hw/misc/Makefile.objs              |   1 +
 hw/timer/Makefile.objs             |   1 +
 include/hw/char/cmsdk-apb-uart.h   |  78 +++++++
 include/hw/misc/mps2-scc.h         |  43 ++++
 include/hw/timer/cmsdk-apb-timer.h |  59 ++++++
 hw/arm/mps2.c                      | 384 +++++++++++++++++++++++++++++++++++
 hw/char/cmsdk-apb-uart.c           | 402 +++++++++++++++++++++++++++++++++++++
 hw/misc/mps2-scc.c                 | 310 ++++++++++++++++++++++++++++
 hw/timer/cmsdk-apb-timer.c         | 253 +++++++++++++++++++++++
 MAINTAINERS                        |  14 +-
 default-configs/arm-softmmu.mak    |   6 +
 hw/char/trace-events               |   9 +
 hw/misc/trace-events               |   8 +
 hw/timer/trace-events              |   5 +
 16 files changed, 1574 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/char/cmsdk-apb-uart.h
 create mode 100644 include/hw/misc/mps2-scc.h
 create mode 100644 include/hw/timer/cmsdk-apb-timer.h
 create mode 100644 hw/arm/mps2.c
 create mode 100644 hw/char/cmsdk-apb-uart.c
 create mode 100644 hw/misc/mps2-scc.c
 create mode 100644 hw/timer/cmsdk-apb-timer.c

-- 
2.7.4
