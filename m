Received: from eggs.gnu.org ([2001:4830:134:3::10]:37248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqpVK-0001Kc-UT
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 20:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqpGw-0003yK-5C
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 20:39:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6405e67c-49a6-dff4-1a78-6e410a72ec0d@amsat.org>
Date: Fri, 17 Aug 2018 21:39:13 -0300
MIME-Version: 1.0
In-Reply-To: <20180809130115.28951-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/16] hw/arm/iotkit: Wire up
 the lines for MSCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/09/2018 10:01 AM, Peter Maydell wrote:
> The IoTKit doesn't have any MSCs itself but it does need
> some wiring to connect the external signals from MSCs
> in the outer board model up to the registers and the
> NVIC IRQ line.
> 
> We also need to expose a MemoryRegion corresponding to
> the AHB bus, so that MSCs in the outer board model can
> use that as their downstream port. (In the FPGA this is
> the "AHB Slave Expansion" ports shown in the block
> diagram in the AN505 documentation.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/iotkit.h |  8 ++++++++
>  hw/arm/iotkit.c         | 15 +++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
> index 1ffa31d521b..5bb66b10468 100644
> --- a/include/hw/arm/iotkit.h
> +++ b/include/hw/arm/iotkit.h
> @@ -28,6 +28,9 @@
>   *  + QOM property "EXP_NUMIRQ" sets the number of expansion interrupts
>   *  + Named GPIO inputs "EXP_IRQ" 0..n are the expansion interrupts, which
>   *    are wired to the NVIC lines 32 .. n+32
> + *  + sysbus MMIO region 0 is the "AHB Slave Expansion" which allows
> + *    bus master devices in the board model to make transactions into
> + *    all the devices and memory areas in the IoTKit
>   * Controlling up to 4 AHB expansion PPBs which a system using the IoTKit
>   * might provide:
>   *  + named GPIO outputs apb_ppcexp{0,1,2,3}_nonsec[0..15]
> @@ -45,6 +48,11 @@
>   * Controlling each of the 16 expansion MPCs which a system using the IoTKit
>   * might provide:
>   *  + named GPIO inputs mpcexp_status[0..15]
> + * Controlling each of the 16 expansion MSCs which a system using the IoTKit
> + * might provide:
> + *  + named GPIO inputs mscexp_status[0..15]
> + *  + named GPIO outputs mscexp_clear[0..15]
> + *  + named GPIO outputs mscexp_ns[0..15]
>   */
>  
>  #ifndef IOTKIT_H
> diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
> index 5d59ed5489f..8ae2a052517 100644
> --- a/hw/arm/iotkit.c
> +++ b/hw/arm/iotkit.c
> @@ -660,6 +660,21 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
>  
>      iotkit_forward_sec_resp_cfg(s);
>  
> +    /* Forward the MSC related signals */
> +    qdev_pass_gpios(dev_secctl, dev, "mscexp_status");
> +    qdev_pass_gpios(dev_secctl, dev, "mscexp_clear");
> +    qdev_pass_gpios(dev_secctl, dev, "mscexp_ns");
> +    qdev_connect_gpio_out_named(dev_secctl, "msc_irq", 0,
> +                                qdev_get_gpio_in(DEVICE(&s->armv7m), 11));
> +
> +    /*
> +     * Expose our container region to the board model; this corresponds
> +     * to the AHB Slave Expansion ports which allow bus master devices
> +     * (eg DMA controllers) in the board model to make transactions into
> +     * devices in the IoTKit.
> +     */
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->container);
> +
>      system_clock_scale = NANOSECONDS_PER_SECOND / s->mainclk_frq;
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
