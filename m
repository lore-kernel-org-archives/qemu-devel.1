Received: from eggs.gnu.org ([2001:4830:134:3::10]:60856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cg8k8-000649-7m
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cg8k3-0007xI-Hn
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:36:28 -0500
MIME-Version: 1.0
In-Reply-To: <1487604965-23220-5-git-send-email-peter.maydell@linaro.org>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
	<1487604965-23220-5-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Feb 2017 03:35:49 -0800
Message-ID: <CAKmqyKPLsevYz52KKGw2tfiZXdbeagd8zEKAMJvSV2ELGsRx9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 04/11] armv7m: Use QOMified armv7m object
 in armv7m_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>

On Mon, Feb 20, 2017 at 7:35 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> Make the legacy armv7m_init() function use the newly QOMified
> armv7m object rather than doing everything by hand.
>
> We can return the armv7m object rather than the NVIC from
> armv7m_init() because its interface to the rest of the
> board (GPIOs, etc) is identical.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/arm/armv7m.c | 49 ++++++++++++-------------------------------------
>  1 file changed, 12 insertions(+), 37 deletions(-)
>
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 56d02d4..36f213c 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -131,21 +131,6 @@ static void bitband_init(Object *obj)
>      sysbus_init_mmio(dev, &s->iomem);
>  }
>
> -static void armv7m_bitband_init(void)
> -{
> -    DeviceState *dev;
> -
> -    dev = qdev_create(NULL, TYPE_BITBAND);
> -    qdev_prop_set_uint32(dev, "base", 0x20000000);
> -    qdev_init_nofail(dev);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x22000000);
> -
> -    dev = qdev_create(NULL, TYPE_BITBAND);
> -    qdev_prop_set_uint32(dev, "base", 0x40000000);
> -    qdev_init_nofail(dev);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x42000000);
> -}
> -
>  /* Board init.  */
>
>  static const hwaddr bitband_input_addr[ARMV7M_NUM_BITBANDS] = {
> @@ -283,35 +268,25 @@ static void armv7m_reset(void *opaque)
>
>  /* Init CPU and memory for a v7-M based board.
>     mem_size is in bytes.
> -   Returns the NVIC array.  */
> +   Returns the ARMv7M device.  */
>
>  DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
>                        const char *kernel_filename, const char *cpu_model)
>  {
> -    ARMCPU *cpu;
> -    CPUARMState *env;
> -    DeviceState *nvic;
> +    DeviceState *armv7m;
>
>      if (cpu_model == NULL) {
> -       cpu_model = "cortex-m3";
> +        cpu_model = "cortex-m3";
>      }
> -    cpu = cpu_arm_init(cpu_model);
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
> -    env = &cpu->env;
> -
> -    armv7m_bitband_init();
> -
> -    nvic = qdev_create(NULL, "armv7m_nvic");
> -    qdev_prop_set_uint32(nvic, "num-irq", num_irq);
> -    env->nvic = nvic;
> -    qdev_init_nofail(nvic);
> -    sysbus_connect_irq(SYS_BUS_DEVICE(nvic), 0,
> -                       qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
> -    armv7m_load_kernel(cpu, kernel_filename, mem_size);
> -    return nvic;
> +
> +    armv7m = qdev_create(NULL, "armv7m");
> +    qdev_prop_set_uint32(armv7m, "num-irq", num_irq);
> +    qdev_prop_set_string(armv7m, "cpu-model", cpu_model);
> +    /* This will exit with an error if the user passed us a bad cpu_model */
> +    qdev_init_nofail(armv7m);
> +
> +    armv7m_load_kernel(ARM_CPU(first_cpu), kernel_filename, mem_size);
> +    return armv7m;
>  }
>
>  void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
> --
> 2.7.4
>
