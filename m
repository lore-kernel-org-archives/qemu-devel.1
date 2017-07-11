Received: from eggs.gnu.org ([2001:4830:134:3::10]:54494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUu2G-0006K2-47
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUu2F-0007eA-01
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:13:00 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Tue, 11 Jul 2017 09:11:50 -0300
Message-ID: <CAAdtpL5_Qfy9h_Osa=tyMDMu4LhOn2mkXA-jYpmpgYwbDJq0yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/7] ARM: implement MPS2 board (with 2 FPGA
 flavours)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

Hi Peter,

It seems you forgot to add some files to MAINTAINERS.

That said, is there some old school perl guy motivated to add a such
chek in checkpatch?


On Tue, Jul 11, 2017 at 8:17 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchseries adds support for the ARM MPS2/MPS2+ dev board:
>
> The MPS2 and MPS2+ dev boards are FPGA based (the 2+ has a bigger
> FPGA but is otherwise the same as the 2). Since the CPU itself
> and most of the devices are in the FPGA, the details of the board
> as seen by the guest depend significantly on the FPGA image.
>
> We model the following FPGA images:
>  "mps2_an385" -- Cortex-M3 as documented in ARM Application Note AN385
>  "mps2_an511" -- Cortex-M3 'DesignStart' as documented in AN511
>
> They are fairly similar but differ in the details for some
> peripherals.
> Further info and links to all the documentation for the
> board and the various FPGA images can be found here:
>  https://developer.arm.com/products/system-design/development-boards/cortex-m-prototyping-system
>
> This patchset adds the boards themselves, and the UART, timer
> and system-controller devices they need. There are a number
> of other devices on the board which are not yet modelled
> (notably more GPIOs, a watchdog, another different kind of timer,
> and a display device), but this minimal set is sufficient to
> boot the "hello world" binary of the Zephyr RTOS and the
> "blinky" binary of the mbed RTOS.
> [To run the zephyr binary you also need this fix:
>   http://patchwork.ozlabs.org/patch/782811/
>  which is in the target-arm pullreq I just sent so should
>  get into master in a few days.]
>
> We can add more devices to the model later, but I figured
> this was a sufficient place to start.
>
> The underlying motivation here is that the v8M work that I
> have planned will need a board, and there is a v8M FPGA
> image for the MPS2 that we can use. It's also perhaps a more
> useful M profile board for general purposes than the stellaris
> boards (64K RAM) or the Netduino2 (128K RAM), since it has
> 16MB of RAM.
>
> thanks
> -- PMM
>
> Peter Maydell (7):
>   hw/arm/mps2: Implement skeleton mps2-an385 and mps2-an511 board models
>   hw/char/cmsdk-apb-uart.c: Implement CMSDK APB UART
>   hw/arm/mps2: Add UARTs
>   hw/char/cmsdk-apb-timer: Implement CMSDK APB timer device
>   hw/arm/mps2: Add timers
>   hw/misc/mps2_scc: Implement MPS2 Serial Communication Controller
>   hw/arm/mps2: Add SCC
>
>  hw/arm/Makefile.objs               |   1 +
>  hw/char/Makefile.objs              |   1 +
>  hw/misc/Makefile.objs              |   1 +
>  hw/timer/Makefile.objs             |   1 +
>  include/hw/char/cmsdk-apb-uart.h   |  78 ++++++++
>  include/hw/misc/mps2-scc.h         |  43 ++++
>  include/hw/timer/cmsdk-apb-timer.h |  59 ++++++
>  hw/arm/mps2.c                      | 378 +++++++++++++++++++++++++++++++++++
>  hw/char/cmsdk-apb-uart.c           | 390 +++++++++++++++++++++++++++++++++++++
>  hw/misc/mps2-scc.c                 | 310 +++++++++++++++++++++++++++++
>  hw/timer/cmsdk-apb-timer.c         | 253 ++++++++++++++++++++++++
>  default-configs/arm-softmmu.mak    |   6 +
>  hw/char/trace-events               |   9 +
>  hw/misc/trace-events               |   8 +
>  hw/timer/trace-events              |   5 +
>  15 files changed, 1543 insertions(+)
>  create mode 100644 include/hw/char/cmsdk-apb-uart.h
>  create mode 100644 include/hw/misc/mps2-scc.h
>  create mode 100644 include/hw/timer/cmsdk-apb-timer.h
>  create mode 100644 hw/arm/mps2.c
>  create mode 100644 hw/char/cmsdk-apb-uart.c
>  create mode 100644 hw/misc/mps2-scc.c
>  create mode 100644 hw/timer/cmsdk-apb-timer.c
>
> --
> 2.7.4
>
>
