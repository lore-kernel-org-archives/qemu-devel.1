Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA178C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81278205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyciIFFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81278205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icY2S-00024X-Ij
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 12:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icXud-00042O-S9
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icXuX-00049S-2O
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:54:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icXuU-0002sy-V0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575478433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sn7syersY781ySQM/IKHN+gNGr7N27AdeWJ99eb3Pjw=;
 b=eyciIFFPcNKeuSUjuXTUItLgRFRsEC/6dsAmZmPHxOUqYmtM9x5qq+1ORFLHl9QCyWirOW
 ivOTTBrx+wf6u4ZWGt5f6g5U2S1VRaamc1k27ZWa1yNdW2Y35QF9vD06xqStomA4mU5HH0
 SQLREx9bnvDQ3+GTyWCIHVNc3BwEjik=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-bnIj1nTaPDWvZySKK4vQOQ-1; Wed, 04 Dec 2019 11:53:51 -0500
Received: by mail-wr1-f69.google.com with SMTP id b2so124867wrj.9
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 08:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sn7syersY781ySQM/IKHN+gNGr7N27AdeWJ99eb3Pjw=;
 b=qGAqng/ww3JrhbmOWOzPtPBfcM8BcwgJEiWtwx+irC+uCsZ0MR8rKUn0KdZ+uTluNx
 oUWda/sydzjwFMcQEgFsFLTx5TlXd/gPBemcX9Q7Ni2CdtU1IbPoFc+nwKpdUaeU9FQw
 G7irW0IzBXhCWuqu2PrARIt+Sr8VYpCT0IyOyujchyg1ozz6dZrCiXloBs3UFN6MRmcx
 vrFXv4LilRZmzlBxUk5pCd3i1eby6rVwYqP51bmHa78la7SRQg0/Dzugn8QBZGLlH7+y
 RSNXUDzFgYJMszsRf3IB80NwF85yLgEbWUAnTfO/XCfYeoJIS26AXV4WUCZgM0vCB+bT
 T/bQ==
X-Gm-Message-State: APjAAAXWbxxOoGGOEfAblXZVClY1qv52pAVJOXERJ5OG0jSaA8m461cG
 e6Gx+RTBZyM6wmE6DcxwfUDXa0h+VkA4VXdfXIHg6RsJi6hL3BZMmHBzV16aqFztUosSRvBvQYS
 pusc5CvpCQgBt1v4=
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr5203000wrm.241.1575478430064; 
 Wed, 04 Dec 2019 08:53:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqywXpKbxeh6tUAR88Jjn0N5UOWwT8JaopP6+eo+opwKYsH46xXT711/X/F6pxwdZ4qoR0ikeA==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr5202967wrm.241.1575478429632; 
 Wed, 04 Dec 2019 08:53:49 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l4sm7045743wml.33.2019.12.04.08.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 08:53:49 -0800 (PST)
Subject: Re: [PATCH 01/10] hw: arm: add Allwinner H3 System-on-Chip
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-2-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5d3961ca-8586-6d93-2525-fd2e29b233e1@redhat.com>
Date: Wed, 4 Dec 2019 17:53:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202210947.3603-2-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: bnIj1nTaPDWvZySKK4vQOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Niek,

On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> The Allwinner H3 is a System on Chip containing four ARM Cortex A7
> processor cores. Features and specifications include DDR2/DDR3 memory,
> SD/MMC storage cards, 10/100/1000Mbit ethernet, USB 2.0, HDMI and
> various I/O modules. This commit adds support for the Allwinner H3
> System on Chip.
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   MAINTAINERS                     |   7 ++
>   default-configs/arm-softmmu.mak |   1 +
>   hw/arm/Kconfig                  |   8 ++
>   hw/arm/Makefile.objs            |   1 +
>   hw/arm/allwinner-h3.c           | 215 ++++++++++++++++++++++++++++++++
>   include/hw/arm/allwinner-h3.h   | 118 ++++++++++++++++++
>   6 files changed, 350 insertions(+)
>   create mode 100644 hw/arm/allwinner-h3.c
>   create mode 100644 include/hw/arm/allwinner-h3.h

Since your series changes various files, can you have a look at the 
scripts/git.orderfile file and setup it for your QEMU contributions?

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..29c9936037 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -479,6 +479,13 @@ F: hw/*/allwinner*
>   F: include/hw/*/allwinner*
>   F: hw/arm/cubieboard.c
>   
> +Allwinner-h3
> +M: Niek Linnenbank <nieklinnenbank@gmail.com>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/*/allwinner-h3*
> +F: include/hw/*/allwinner-h3*
> +
>   ARM PrimeCell and CMSDK devices
>   M: Peter Maydell <peter.maydell@linaro.org>
>   L: qemu-arm@nongnu.org
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 1f2e0e7fde..d75a239c2c 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -40,3 +40,4 @@ CONFIG_FSL_IMX25=y
>   CONFIG_FSL_IMX7=y
>   CONFIG_FSL_IMX6UL=y
>   CONFIG_SEMIHOSTING=y
> +CONFIG_ALLWINNER_H3=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index c6e7782580..ebf8d2325f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -291,6 +291,14 @@ config ALLWINNER_A10
>       select SERIAL
>       select UNIMP
>   
> +config ALLWINNER_H3
> +    bool
> +    select ALLWINNER_A10_PIT
> +    select SERIAL
> +    select ARM_TIMER
> +    select ARM_GIC
> +    select UNIMP
> +
>   config RASPI
>       bool
>       select FRAMEBUFFER
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index fe749f65fd..956e496052 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -34,6 +34,7 @@ obj-$(CONFIG_DIGIC) += digic.o
>   obj-$(CONFIG_OMAP) += omap1.o omap2.o
>   obj-$(CONFIG_STRONGARM) += strongarm.o
>   obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
> +obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3.o
>   obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
>   obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
>   obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> new file mode 100644
> index 0000000000..470fdfebef
> --- /dev/null
> +++ b/hw/arm/allwinner-h3.c
> @@ -0,0 +1,215 @@
> +/*
> + * Allwinner H3 System on Chip emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/address-spaces.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +#include "cpu.h"
> +#include "hw/sysbus.h"
> +#include "hw/arm/allwinner-h3.h"
> +#include "hw/misc/unimp.h"
> +#include "sysemu/sysemu.h"
> +
> +static void aw_h3_init(Object *obj)
> +{
> +    AwH3State *s = AW_H3(obj);
> +
> +    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
> +                          TYPE_ARM_GIC);
> +
> +    sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
> +                          TYPE_AW_A10_PIT);
> +}
> +
> +static void aw_h3_realize(DeviceState *dev, Error **errp)
> +{
> +    AwH3State *s = AW_H3(dev);
> +    SysBusDevice *sysbusdev = NULL;
> +    Error *err = NULL;
> +    unsigned i = 0;
> +
> +    /* CPUs */
> +    for (i = 0; i < AW_H3_NUM_CPUS; i++) {

In https://www.mail-archive.com/qemu-devel@nongnu.org/msg662942.html
Markus noted some incorrect pattern, and apparently you inherited it.
You should initialize 'err' in the loop.

> +        Object *cpuobj = object_new(ARM_CPU_TYPE_NAME("cortex-a7"));
> +        CPUState *cpustate = CPU(cpuobj);

We loose access to the CPUs. Can you use an array of AW_H3_NUM_CPUS cpus 
in AwH3State?

> +
> +        /* Set the proper CPU index */
> +        cpustate->cpu_index = i;
> +
> +        /* Provide Power State Coordination Interface */
> +        object_property_set_int(cpuobj, QEMU_PSCI_CONDUIT_HVC,
> +                                "psci-conduit", &error_abort);

Here you use the error_abort shortcut.

> +
> +        /* Disable secondary CPUs */
> +        object_property_set_bool(cpuobj, i > 0, "start-powered-off", &err);
> +        if (err != NULL) {
> +            error_propagate(errp, err);
> +            return;

Here you return.

> +        }
> +
> +        /* All exception levels required */
> +        object_property_set_bool(cpuobj,
> +                                 true, "has_el3", NULL);
> +        object_property_set_bool(cpuobj,
> +                                 true, "has_el2", NULL);

Here you don't use error.

Cc'ing Markus who is the expert, since he might have better suggestions.

This function is called before the machine starts, and we are not 
handling with user-provided configurations, so I'd say using 
&error_abort in all places is OK.

> +
> +        /* Mark realized */
> +        object_property_set_bool(cpuobj, true, "realized", &err);
> +        if (err != NULL) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        object_unref(cpuobj);
> +    }
> +
> +    /* Generic Interrupt Controller */
> +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", AW_H3_GIC_NUM_SPI +
> +                                                     GIC_INTERNAL);
> +    qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
> +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", AW_H3_NUM_CPUS);
> +    qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", false);
> +    qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions", true);
> +
> +    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);

Why change API? Can we use qdev_init_nofail() instead?

> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    sysbusdev = SYS_BUS_DEVICE(&s->gic);
> +    sysbus_mmio_map(sysbusdev, 0, AW_H3_GIC_DIST_BASE);
> +    sysbus_mmio_map(sysbusdev, 1, AW_H3_GIC_CPU_BASE);
> +    sysbus_mmio_map(sysbusdev, 2, AW_H3_GIC_HYP_BASE);
> +    sysbus_mmio_map(sysbusdev, 3, AW_H3_GIC_VCPU_BASE);
> +
> +    /*
> +     * Wire the outputs from each CPU's generic timer and the GICv3
> +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
> +     */
> +    for (i = 0; i < AW_H3_NUM_CPUS; i++) {
> +        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
> +        int ppibase = AW_H3_GIC_NUM_SPI + i * GIC_INTERNAL + GIC_NR_SGIS;
> +        int irq;
> +        /*
> +         * Mapping from the output timer irq lines from the CPU to the
> +         * GIC PPI inputs used for this board.
> +         */
> +        const int timer_irq[] = {
> +            [GTIMER_PHYS] = AW_H3_GIC_PPI_ARM_PHYSTIMER,
> +            [GTIMER_VIRT] = AW_H3_GIC_PPI_ARM_VIRTTIMER,
> +            [GTIMER_HYP]  = AW_H3_GIC_PPI_ARM_HYPTIMER,
> +            [GTIMER_SEC]  = AW_H3_GIC_PPI_ARM_SECTIMER,
> +        };
> +
> +        /* Connect CPU timer outputs to GIC PPI inputs */
> +        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> +            qdev_connect_gpio_out(cpudev, irq,
> +                                  qdev_get_gpio_in(DEVICE(&s->gic),
> +                                                   ppibase + timer_irq[irq]));
> +        }
> +
> +        /* Connect GIC outputs to CPU interrupt inputs */
> +        sysbus_connect_irq(sysbusdev, i,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> +        sysbus_connect_irq(sysbusdev, i + AW_H3_NUM_CPUS,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> +        sysbus_connect_irq(sysbusdev, i + (2 * AW_H3_NUM_CPUS),
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> +        sysbus_connect_irq(sysbusdev, i + (3 * AW_H3_NUM_CPUS),
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> +
> +        /* GIC maintenance signal */
> +        sysbus_connect_irq(sysbusdev, i + (4 * AW_H3_NUM_CPUS),
> +                           qdev_get_gpio_in(DEVICE(&s->gic),
> +                                            ppibase + AW_H3_GIC_PPI_MAINT));
> +    }
> +
> +    for (i = 0; i < AW_H3_GIC_NUM_SPI; i++) {
> +        s->irq[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);

Apparently we don't need the irq array in AwH3State, because ...

> +    }
> +
> +    /* Timer */
> +    object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbusdev = SYS_BUS_DEVICE(&s->timer);
> +    sysbus_mmio_map(sysbusdev, 0, AW_H3_PIT_REG_BASE);
> +    sysbus_connect_irq(sysbusdev, 0, s->irq[AW_H3_GIC_SPI_TIMER0]);
> +    sysbus_connect_irq(sysbusdev, 1, s->irq[AW_H3_GIC_SPI_TIMER1]);

... we can call qdev_get_gpio_in() here directly.

> +
> +    /* SRAM */
> +    memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
> +                            AW_H3_SRAM_A1_SIZE, &error_fatal);
> +    memory_region_init_ram(&s->sram_a2, OBJECT(dev), "sram A2",
> +                            AW_H3_SRAM_A2_SIZE, &error_fatal);
> +    memory_region_init_ram(&s->sram_c, OBJECT(dev), "sram C",
> +                            AW_H3_SRAM_C_SIZE, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_A1_BASE,
> +                                &s->sram_a1);
> +    memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_A2_BASE,
> +                                &s->sram_a2);
> +    memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_C_BASE,
> +                                &s->sram_c);
> +
> +    /* UART */
> +    if (serial_hd(0)) {
> +        serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
> +                       s->irq[AW_H3_GIC_SPI_UART0], 115200, serial_hd(0),

qdev_get_gpio_in() here too.

> +                       DEVICE_NATIVE_ENDIAN);
> +    }
> +
> +    /* Unimplemented devices */
> +    create_unimplemented_device("display-engine", AW_H3_DE_BASE, AW_H3_DE_SIZE);
> +    create_unimplemented_device("dma", AW_H3_DMA_BASE, AW_H3_DMA_SIZE);
> +    create_unimplemented_device("lcd0", AW_H3_LCD0_BASE, AW_H3_LCD0_SIZE);
> +    create_unimplemented_device("lcd1", AW_H3_LCD1_BASE, AW_H3_LCD1_SIZE);
> +    create_unimplemented_device("gpu", AW_H3_GPU_BASE, AW_H3_GPU_SIZE);
> +    create_unimplemented_device("hdmi", AW_H3_HDMI_BASE, AW_H3_HDMI_SIZE);
> +    create_unimplemented_device("rtc", AW_H3_RTC_BASE, AW_H3_RTC_SIZE);
> +    create_unimplemented_device("audio-codec", AW_H3_AC_BASE, AW_H3_AC_SIZE);
> +}
> +
> +static void aw_h3_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = aw_h3_realize;
> +    /* Reason: uses serial_hds and nd_table */
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo aw_h3_type_info = {
> +    .name = TYPE_AW_H3,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(AwH3State),
> +    .instance_init = aw_h3_init,
> +    .class_init = aw_h3_class_init,
> +};
> +
> +static void aw_h3_register_types(void)
> +{
> +    type_register_static(&aw_h3_type_info);
> +}
> +
> +type_init(aw_h3_register_types)
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> new file mode 100644
> index 0000000000..af368c2254
> --- /dev/null
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -0,0 +1,118 @@
> +/*
> + * Allwinner H3 System on Chip emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_ARM_ALLWINNER_H3_H
> +#define HW_ARM_ALLWINNER_H3_H
> +
> +#include "qemu/error-report.h"
> +#include "qemu/units.h"
> +#include "hw/char/serial.h"
> +#include "hw/arm/boot.h"
> +#include "hw/timer/allwinner-a10-pit.h"
> +#include "hw/intc/arm_gic.h"
> +#include "target/arm/cpu.h"
> +
> +#define AW_H3_SRAM_A1_BASE     (0x00000000)
> +#define AW_H3_SRAM_A2_BASE     (0x00044000)
> +#define AW_H3_SRAM_C_BASE      (0x00010000)
> +#define AW_H3_DE_BASE          (0x01000000)
> +#define AW_H3_SYSCON_BASE      (0x01c00000)
> +#define AW_H3_DMA_BASE         (0x01c02000)
> +#define AW_H3_LCD0_BASE        (0x01c0c000)
> +#define AW_H3_LCD1_BASE        (0x01c0d000)
> +#define AW_H3_SID_BASE         (0x01c14000)
> +#define AW_H3_CCU_BASE         (0x01c20000)
> +#define AW_H3_PIC_REG_BASE     (0x01c20400)
> +#define AW_H3_PIT_REG_BASE     (0x01c20c00)
> +#define AW_H3_AC_BASE          (0x01c22c00)
> +#define AW_H3_UART0_REG_BASE   (0x01c28000)
> +#define AW_H3_EMAC_BASE        (0x01c30000)
> +#define AW_H3_MMC0_BASE        (0x01c0f000)
> +#define AW_H3_EHCI0_BASE       (0x01c1a000)
> +#define AW_H3_OHCI0_BASE       (0x01c1a400)
> +#define AW_H3_EHCI1_BASE       (0x01c1b000)
> +#define AW_H3_OHCI1_BASE       (0x01c1b400)
> +#define AW_H3_EHCI2_BASE       (0x01c1c000)
> +#define AW_H3_OHCI2_BASE       (0x01c1c400)
> +#define AW_H3_EHCI3_BASE       (0x01c1d000)
> +#define AW_H3_OHCI3_BASE       (0x01c1d400)
> +#define AW_H3_GPU_BASE         (0x01c40000)
> +#define AW_H3_GIC_DIST_BASE    (0x01c81000)
> +#define AW_H3_GIC_CPU_BASE     (0x01c82000)
> +#define AW_H3_GIC_HYP_BASE     (0x01c84000)
> +#define AW_H3_GIC_VCPU_BASE    (0x01c86000)
> +#define AW_H3_HDMI_BASE        (0x01ee0000)
> +#define AW_H3_RTC_BASE         (0x01f00000)
> +#define AW_H3_CPUCFG_BASE      (0x01f01c00)
> +#define AW_H3_SDRAM_BASE       (0x40000000)
> +
> +#define AW_H3_SRAM_A1_SIZE     (64 * KiB)
> +#define AW_H3_SRAM_A2_SIZE     (32 * KiB)
> +#define AW_H3_SRAM_C_SIZE      (44 * KiB)
> +#define AW_H3_DE_SIZE          (4 * MiB)
> +#define AW_H3_DMA_SIZE         (4 * KiB)
> +#define AW_H3_LCD0_SIZE        (4 * KiB)
> +#define AW_H3_LCD1_SIZE        (4 * KiB)
> +#define AW_H3_GPU_SIZE         (64 * KiB)
> +#define AW_H3_HDMI_SIZE        (128 * KiB)
> +#define AW_H3_RTC_SIZE         (1 * KiB)
> +#define AW_H3_AC_SIZE          (2 * KiB)
> +
> +#define AW_H3_GIC_PPI_MAINT          (9)
> +#define AW_H3_GIC_PPI_ARM_HYPTIMER  (10)
> +#define AW_H3_GIC_PPI_ARM_VIRTTIMER (11)
> +#define AW_H3_GIC_PPI_ARM_SECTIMER  (13)
> +#define AW_H3_GIC_PPI_ARM_PHYSTIMER (14)
> +
> +#define AW_H3_GIC_SPI_UART0         (0)
> +#define AW_H3_GIC_SPI_TIMER0        (18)
> +#define AW_H3_GIC_SPI_TIMER1        (19)
> +#define AW_H3_GIC_SPI_MMC0          (60)
> +#define AW_H3_GIC_SPI_MMC1          (61)
> +#define AW_H3_GIC_SPI_MMC2          (62)
> +#define AW_H3_GIC_SPI_EHCI0         (72)
> +#define AW_H3_GIC_SPI_OHCI0         (73)
> +#define AW_H3_GIC_SPI_EHCI1         (74)
> +#define AW_H3_GIC_SPI_OHCI1         (75)
> +#define AW_H3_GIC_SPI_EHCI2         (76)
> +#define AW_H3_GIC_SPI_OHCI2         (77)
> +#define AW_H3_GIC_SPI_EHCI3         (78)
> +#define AW_H3_GIC_SPI_OHCI3         (79)
> +#define AW_H3_GIC_SPI_EMAC          (82)

I'd move half of the previous definitions into allwinner-h3.c, since 
they are only used there.

Also, I'd use an enum for the PPI/SPI.

> +
> +#define AW_H3_GIC_NUM_SPI           (128)
> +#define AW_H3_NUM_CPUS              (4)
> +
> +#define TYPE_AW_H3 "allwinner-h3"
> +#define AW_H3(obj) OBJECT_CHECK(AwH3State, (obj), TYPE_AW_H3)
> +
> +typedef struct AwH3State {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +    /*< public >*/
> +
> +    qemu_irq irq[AW_H3_GIC_NUM_SPI];
> +    AwA10PITState timer;
> +    GICState gic;
> +    MemoryRegion sram_a1;
> +    MemoryRegion sram_a2;
> +    MemoryRegion sram_c;
> +} AwH3State;
> +
> +#endif
> 

Nice clean patch, for a first contribution :)


