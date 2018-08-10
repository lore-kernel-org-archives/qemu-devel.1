Received: from eggs.gnu.org ([2001:4830:134:3::10]:35425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzcR-0005JH-Uv
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzcN-0003oB-5w
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:05:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11a99e21-64c3-403b-959f-b0d5ad8ebb2f@amsat.org>
Date: Fri, 10 Aug 2018 02:05:38 -0300
MIME-Version: 1.0
In-Reply-To: <20180809130115.28951-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 02/16] nvic: Expose NMI line
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
> On real v7M hardware, the NMI line is an externally visible signal
> that an SoC or board can toggle to assert an NMI. Expose it in
> our QEMU NVIC and armv7m container objects so that a board model
> can wire it up if it needs to.
> 
> In particular, the MPS2 watchdog is wired to NMI.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/armv7m.c       |  1 +
>  hw/intc/armv7m_nvic.c | 19 +++++++++++++++++++
>  hw/intc/trace-events  |  1 +
>  3 files changed, 21 insertions(+)
> 
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 6b076660574..66217a6053a 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -202,6 +202,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>       */
>      qdev_pass_gpios(DEVICE(&s->nvic), dev, NULL);
>      qdev_pass_gpios(DEVICE(&s->nvic), dev, "SYSRESETREQ");
> +    qdev_pass_gpios(DEVICE(&s->nvic), dev, "NMI");
>  
>      /* Wire the NVIC up to the CPU */
>      sbd = SYS_BUS_DEVICE(&s->nvic);
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index cd1e7f17299..be7771e9d1f 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -772,6 +772,24 @@ static void set_irq_level(void *opaque, int n, int level)
>      }
>  }
>  
> +/* callback when external NMI line is changed */
> +static void nvic_nmi_trigger(void *opaque, int n, int level)
> +{
> +    NVICState *s = opaque;
> +
> +    trace_nvic_set_nmi_level(level);
> +
> +    /*
> +     * The architecture doesn't specify whether NMI should share
> +     * the normal-interrupt behaviour of being resampled on
> +     * exception handler return. We choose not to, so just
> +     * set NMI pending here and don't track the current level.
> +     */
> +    if (level) {
> +        armv7m_nvic_set_pending(s, ARMV7M_EXCP_NMI, false);
> +    }
> +}
> +
>  static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>  {
>      ARMCPU *cpu = s->cpu;
> @@ -2310,6 +2328,7 @@ static void armv7m_nvic_instance_init(Object *obj)
>      qdev_init_gpio_out_named(dev, &nvic->sysresetreq, "SYSRESETREQ", 1);
>      qdev_init_gpio_in_named(dev, nvic_systick_trigger, "systick-trigger",
>                              M_REG_NUM_BANKS);
> +    qdev_init_gpio_in_named(dev, nvic_nmi_trigger, "NMI", 1);
>  }
>  
>  static void armv7m_nvic_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 5fb18e65c97..33e932fb918 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -184,6 +184,7 @@ nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (pr
>  nvic_get_pending_irq_info(int irq, bool secure) "NVIC next IRQ %d: targets_secure: %d"
>  nvic_complete_irq(int irq, bool secure) "NVIC complete IRQ %d (secure %d)"
>  nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
> +nvic_set_nmi_level(int level) "NVIC external NMI level set to %d"
>  nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  
> 
