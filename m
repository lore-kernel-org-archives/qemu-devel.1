Received: from eggs.gnu.org ([2001:4830:134:3::10]:51338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW3N6-0000uf-5S
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW3N3-00070V-IH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:23:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
	<1500029487-14822-9-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4526aa49-b018-5331-2c2a-61f0ae684ec4@amsat.org>
Date: Fri, 14 Jul 2017 13:23:09 -0300
MIME-Version: 1.0
In-Reply-To: <1500029487-14822-9-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 8/9] hw/arm/mps2: Add ethernet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Alistair Francis <alistair.francis@xilinx.com>

On 07/14/2017 07:51 AM, Peter Maydell wrote:
> The MPS2 FPGA images support ethernet via a LAN9220. We use
> QEMU's LAN9118 model, which is software compatible except
> that it is missing the checksum-offload feature.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/arm/mps2.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index bdc631a..6adfb22 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -35,6 +35,8 @@
>   #include "hw/char/cmsdk-apb-uart.h"
>   #include "hw/timer/cmsdk-apb-timer.h"
>   #include "hw/misc/mps2-scc.h"
> +#include "hw/devices.h"
> +#include "net/net.h"
>   
>   typedef enum MPS2FPGAType {
>       FPGA_AN385,
> @@ -210,7 +212,6 @@ static void mps2_common_init(MachineState *machine)
>       create_unimplemented_device("Extra peripheral region @0x40020000",
>                                   0x40020000, 0x00010000);
>       create_unimplemented_device("RESERVED 4", 0x40030000, 0x001D0000);
> -    create_unimplemented_device("Ethernet", 0x40200000, 0x00100000);
>       create_unimplemented_device("VGA", 0x41000000, 0x0200000);
>   
>       switch (mmc->fpga_type) {
> @@ -309,6 +310,13 @@ static void mps2_common_init(MachineState *machine)
>                                &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(sccdev), 0, 0x4002f000);
>   
> +    /* In hardware this is a LAN9220; the LAN9118 is software compatible
> +     * except that it doesn't support the checksum-offload feature.
> +     */
> +    lan9118_init(&nd_table[0], 0x40200000,
> +                 qdev_get_gpio_in(armv7m,
> +                                  mmc->fpga_type == FPGA_AN385 ? 13 : 47));
> +
>       system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
>   
>       armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> 
