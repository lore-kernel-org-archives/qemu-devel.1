Received: from eggs.gnu.org ([2001:4830:134:3::10]:55141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfqk2-00070Y-TA
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfqjy-0002NQ-Uv
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:23:10 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
	<1487604965-23220-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e6ebfe0d-c866-e28e-2366-d55ac5d77d47@amsat.org>
Date: Mon, 20 Feb 2017 13:23:02 -0300
MIME-Version: 1.0
In-Reply-To: <1487604965-23220-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 01/11] armv7m: Abstract out the
 "load kernel" code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>, patches@linaro.org

On 02/20/2017 12:35 PM, Peter Maydell wrote:
> Abstract the "load kernel" code out of armv7m_init() into its own
> function.  This includes the registration of the CPU reset function,
> to parallel how we handle this for A profile cores.
>
> We make the function public so that boards which choose to
> directly instantiate an ARMv7M device object can call it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/arm/arm.h | 12 ++++++++++++
>  hw/arm/armv7m.c      | 23 ++++++++++++++++++-----
>  2 files changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
> index c175c0e..a3f79d3 100644
> --- a/include/hw/arm/arm.h
> +++ b/include/hw/arm/arm.h
> @@ -26,6 +26,18 @@ typedef enum {
>  /* armv7m.c */
>  DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
>                        const char *kernel_filename, const char *cpu_model);
> +/**
> + * armv7m_load_kernel:
> + * @cpu: CPU
> + * @kernel_filename: file to load
> + * @mem_size: mem_size: maximum image size to load
> + *
> + * Load the guest image for an ARMv7M system. This must be called by
> + * any ARMv7M board, either directly or via armv7m_init(). (This is
> + * necessary to ensure that the CPU resets correctly on system reset,
> + * as well as for kernel loading.)
> + */
> +void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size);
>
>  /*
>   * struct used as a parameter of the arm_load_kernel machine init
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 0c9ca7b..b2cc6e9 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -176,10 +176,6 @@ DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
>      ARMCPU *cpu;
>      CPUARMState *env;
>      DeviceState *nvic;
> -    int image_size;
> -    uint64_t entry;
> -    uint64_t lowaddr;
> -    int big_endian;
>
>      if (cpu_model == NULL) {
>  	cpu_model = "cortex-m3";
> @@ -199,6 +195,16 @@ DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
>      qdev_init_nofail(nvic);
>      sysbus_connect_irq(SYS_BUS_DEVICE(nvic), 0,
>                         qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
> +    armv7m_load_kernel(cpu, kernel_filename, mem_size);
> +    return nvic;
> +}
> +
> +void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
> +{
> +    int image_size;
> +    uint64_t entry;
> +    uint64_t lowaddr;
> +    int big_endian;
>
>  #ifdef TARGET_WORDS_BIGENDIAN
>      big_endian = 1;
> @@ -224,8 +230,15 @@ DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
>          }
>      }
>
> +    /* CPU objects (unlike devices) are not automatically reset on system
> +     * reset, so we must always register a handler to do so. Unlike
> +     * A-profile CPUs, we don't need to do anything special in the
> +     * handler to arrange that it starts correctly.
> +     * This is arguably the wrong place to do this, but it matches the
> +     * way A-profile does it. Note that this means that every M profile
> +     * board must call this function!
> +     */
>      qemu_register_reset(armv7m_reset, cpu);
> -    return nvic;
>  }
>
>  static Property bitband_properties[] = {
>
