Received: from eggs.gnu.org ([2001:4830:134:3::10]:57987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fP9CY-0003hJ-Ho
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 12:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fP9CX-0001TC-F2
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 12:16:22 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fP9CX-0001SK-9Y
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 12:16:21 -0400
Received: by mail-ot0-x241.google.com with SMTP id q17-v6so22184045otg.2
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 09:16:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180602141446.29982-3-stefanha@redhat.com>
References: <20180602141446.29982-1-stefanha@redhat.com>
	<20180602141446.29982-3-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Jun 2018 17:16:00 +0100
Message-ID: <CAFEAcA9cnV6fyc4AMO--jvvycrHPdy1Syvrqxy3J=OyM3cqGpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 2/2] arm: add ARMv6-M device container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>

On 2 June 2018 at 15:14, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Introduce armv6m_init() and the glue code needed to wire together an
> ARMv6-M ARMCPU with memory and the NVIC.
>
> The "microbit" board needs to use a Cortex M0 CPU instead of a Cortex
> M3.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/arm/Makefile.objs            |   1 +
>  hw/intc/Makefile.objs           |   2 +-
>  hw/timer/Makefile.objs          |   2 +-
>  include/hw/arm/arm.h            |  16 +++
>  include/hw/arm/armv6m.h         |  49 ++++++++
>  hw/arm/armv6m.c                 | 190 ++++++++++++++++++++++++++++++++
>  hw/arm/nrf51_soc.c              |   5 +-
>  default-configs/arm-softmmu.mak |   2 +
>  8 files changed, 262 insertions(+), 5 deletions(-)
>  create mode 100644 include/hw/arm/armv6m.h
>  create mode 100644 hw/arm/armv6m.c
>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index cecbe41086..5fb135791d 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -17,6 +17,7 @@ obj-$(CONFIG_VERSATILE) += vexpress.o versatilepb.o
>  obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
>
>  obj-$(CONFIG_ARM_V7M) += armv7m.o
> +obj-$(CONFIG_ARM_V6M) += armv6m.o
>  obj-$(CONFIG_EXYNOS4) += exynos4210.o
>  obj-$(CONFIG_PXA2XX) += pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
>  obj-$(CONFIG_DIGIC) += digic.o
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index 0e9963f5ee..dbfb7195db 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -26,7 +26,7 @@ obj-$(CONFIG_APIC) += apic.o apic_common.o
>  obj-$(CONFIG_ARM_GIC_KVM) += arm_gic_kvm.o
>  obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_kvm.o
>  obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_its_kvm.o
> -obj-$(CONFIG_ARM_V7M) += armv7m_nvic.o
> +obj-$(call lor,$(CONFIG_ARM_V7M),$(CONFIG_ARM_V6M)) += armv7m_nvic.o
>  obj-$(CONFIG_EXYNOS4) += exynos4210_gic.o exynos4210_combiner.o
>  obj-$(CONFIG_GRLIB) += grlib_irqmp.o
>  obj-$(CONFIG_IOAPIC) += ioapic.o
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 8b27a4b7ef..03d98a7871 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -1,6 +1,6 @@
>  common-obj-$(CONFIG_ARM_TIMER) += arm_timer.o
>  common-obj-$(CONFIG_ARM_MPTIMER) += arm_mptimer.o
> -common-obj-$(CONFIG_ARM_V7M) += armv7m_systick.o
> +common-obj-$(call lor,$(CONFIG_ARM_V7M),$(CONFIG_ARM_V6M)) += armv7m_systick.o
>  common-obj-$(CONFIG_A9_GTIMER) += a9gtimer.o
>  common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
>  common-obj-$(CONFIG_DS1338) += ds1338.o
> diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
> index 70fa2287e2..a0eaf52ae6 100644
> --- a/include/hw/arm/arm.h
> +++ b/include/hw/arm/arm.h
> @@ -23,6 +23,22 @@ typedef enum {
>      ARM_ENDIANNESS_BE32,
>  } arm_endianness;
>
> +/**
> + * armv6m_init:
> + * @system_memory: System memory region
> + * @mem_size: RAM size, in bytes
> + * @num_irq: number of interrupt pins
> + * @kernel_filename: path to kernel image
> + * @cpu_type: an ARMv6-M CPU implementation
> + *
> + * Initializes CPU and memory for an ARMv6-M based board.
> + *
> + * Returns: ARMV6M device containing CPU and NVIC.
> + */
> +DeviceState *armv6m_init(MemoryRegion *system_memory, int mem_size,
> +                         int num_irq, const char *kernel_filename,
> +                         const char *cpu_type);

I just submitted a patchset that removes armv7m_init(), so
please don't add one for armv6m.


> --- /dev/null
> +++ b/hw/arm/armv6m.c
> @@ -0,0 +1,190 @@
> +/*
> + * ARMV6M System emulation.
> + *
> + * Copyright (C) 2018 Red Hat, Inc.
> + *
> + * Based on hw/arm/armv7m.c (written by Paul Brook),
> + * Copyright (c) 2006-2007 CodeSourcery.
> + *
> + * This code is licensed under the GPL.
> + */

There's a lot of code duplication here with the armv7m object;
can't we avoid that? What (if anything) needs to be done
differently from armv7m/armv8m (which both share the same
code)? Can we handle it by parameterizing or a shared base
class or something instead?

(This code will break if the "check we actually have an
NVIC for M profile cores" patchset I sent the other day
is applied, because changes made there to armv7m would
need to be propagated across to this copied code. It would
be nice not to have to change multiple places for that
sort of thing.)

thanks
-- PMM
