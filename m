Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D164BC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E452073D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDiWJzup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E452073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igFKY-00064X-Mj
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igFJh-0005HU-E1
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igFJf-0007RO-9h
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:51:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20715
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igFJf-0007O4-2e
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576360270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxlNDlcm8HsAwIL81XV9LrgyeoomdszW36hbadR0U1g=;
 b=aDiWJzupWuw5/dcojEA/xNS3an9uwLER1HnLQmBnae78pHJk58YbY+Rc8HJ6zoeGPADweO
 PlvIDPTHvE67PCnYy8aLpNAcYQZSfxsljCNlj5qd/xgP8sT68yYDMEvIQE/gY2cNYIx9n1
 7zJqB6CFIuGmtCUpMl55sOYk4wR0nM4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-x05kUDVEMj22fR1uXDBe-g-1; Sat, 14 Dec 2019 08:49:10 -0500
Received: by mail-wr1-f69.google.com with SMTP id r2so1009217wrp.7
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 05:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QxlNDlcm8HsAwIL81XV9LrgyeoomdszW36hbadR0U1g=;
 b=NHrc1f5k6T9QlI3DbF45FEq9jigtVI+j2puZsNFkDAOLIt6XeGfKkM7ZRQGq2We5qJ
 4TcjRLVM2qgYm2hpJYiAT8q6mRrHQ4yg35ikPhRbrgWuLd8G+7c5sBmp9q3fyn1ktr/4
 fb0AEv36XyZTfBNiJtPoL8duHlWUcVmiwD3XV8i3LgOvYqFRae1zesyb0CeLqtWIRMUq
 AriVF9vioG2A7L/2UM43N9VVMM/Oq0nmzAy+5OBA+uwwo9jIBq37jWhw2d6AFeECXa1W
 FbUc90xMSVZamWtcSmNcz6X8cnQo89rF1Pr3NVvtk+CueJjMHdMuRupqBhv0AOVVQSLK
 5Jgg==
X-Gm-Message-State: APjAAAWcTDiCYz5enTakp80AHIa5o4Ocrc8I8rF+AoZ39b9CsNJ9qKOl
 McKbXUDHRPYpzJb9E4zcNZWCAPKLKa7ScxVyBi3TErQPxXD0AMvALVW1PhgaExL/xunqUBr9e6J
 3tCiLxZ9FQ6h9dOc=
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr17915731wrv.368.1576331349371; 
 Sat, 14 Dec 2019 05:49:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqvi8Yv1gAgKdRu9tRXcCo6khF6hJCVTPIhVSRHMZUfuwPa3WcoEeICZrrYm/E+fPccfPriA==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr17915697wrv.368.1576331348971; 
 Sat, 14 Dec 2019 05:49:08 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id h8sm14723069wrx.63.2019.12.14.05.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 05:49:08 -0800 (PST)
Subject: Re: [PATCH v6 2/4] hw/misc: Add the STM32F4xx EXTI device
To: Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <cover.1576227325.git.alistair@alistair23.me>
 <717e76b6d41e09c352d98a83708c3e3c9fe5d63b.1576227325.git.alistair@alistair23.me>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <13f8810e-fb67-24c8-fecf-72f48ac5c7db@redhat.com>
Date: Sat, 14 Dec 2019 14:49:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <717e76b6d41e09c352d98a83708c3e3c9fe5d63b.1576227325.git.alistair@alistair23.me>
Content-Language: en-US
X-MC-Unique: x05kUDVEMj22fR1uXDBe-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: alistair23@gmail.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On 12/14/19 3:44 AM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig                   |   1 +
>   hw/misc/Kconfig                  |   3 +
>   hw/misc/Makefile.objs            |   1 +
>   hw/misc/stm32f4xx_exti.c         | 189 +++++++++++++++++++++++++++++++
>   hw/misc/trace-events             |   5 +
>   include/hw/misc/stm32f4xx_exti.h |  60 ++++++++++
>   6 files changed, 259 insertions(+)
>   create mode 100644 hw/misc/stm32f4xx_exti.c
>   create mode 100644 include/hw/misc/stm32f4xx_exti.h
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 4660d14715..3d86691ae0 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -315,6 +315,7 @@ config STM32F405_SOC
>       bool
>       select ARM_V7M
>       select STM32F4XX_SYSCFG
> +    select STM32F4XX_EXTI
>   
>   config XLNX_ZYNQMP_ARM
>       bool
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 72609650b7..bdd77d8020 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -85,6 +85,9 @@ config STM32F2XX_SYSCFG
>   config STM32F4XX_SYSCFG
>       bool
>   
> +config STM32F4XX_EXTI
> +    bool
> +
>   config MIPS_ITU
>       bool
>   
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index ea8025e0bb..c6ecbdd7b0 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -59,6 +59,7 @@ common-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
>   common-obj-$(CONFIG_ZYNQ) += zynq-xadc.o
>   common-obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
>   common-obj-$(CONFIG_STM32F4XX_SYSCFG) += stm32f4xx_syscfg.o
> +common-obj-$(CONFIG_STM32F4XX_EXTI) += stm32f4xx_exti.o
>   obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
>   obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
>   obj-$(CONFIG_MIPS_ITU) += mips_itu.o
> diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
> new file mode 100644
> index 0000000000..7f87a885aa
> --- /dev/null
> +++ b/hw/misc/stm32f4xx_exti.c
> @@ -0,0 +1,189 @@
> +/*
> + * STM32F4XX EXTI
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/stm32f4xx_exti.h"
> +
> +static void stm32f4xx_exti_reset(DeviceState *dev)
> +{
> +    STM32F4xxExtiState *s = STM32F4XX_EXTI(dev);
> +
> +    s->exti_imr = 0x00000000;
> +    s->exti_emr = 0x00000000;
> +    s->exti_rtsr = 0x00000000;
> +    s->exti_ftsr = 0x00000000;
> +    s->exti_swier = 0x00000000;
> +    s->exti_pr = 0x00000000;
> +}
> +
> +static void stm32f4xx_exti_set_irq(void *opaque, int irq, int level)
> +{
> +    STM32F4xxExtiState *s = opaque;
> +
> +    if (!((1 << irq) & s->exti_imr)) {
> +        /* Interrupt is masked */
> +        return;

I'm not sure this is correct, don't you need to set the bit in the 
exti_pr register regardless it is masked? Else in masked polling mode 
the guest will never see IRQ delivered.

So I'd drop this if statement, ...

> +    }
> +
> +    trace_stm32f4xx_exti_set_irq(irq, level);
> +
> +    if (((1 << irq) & s->exti_rtsr) && level) {
> +        /* Rising Edge */
> +        qemu_irq_pulse(s->irq[irq]);

... do not pulse here, ...

> +        s->exti_pr |= 1 << irq;
> +    }
> +
> +    if (((1 << irq) & s->exti_ftsr) && !level) {
> +        /* Falling Edge */
> +        qemu_irq_pulse(s->irq[irq]);

... do not pulse here, ...

> +        s->exti_pr |= 1 << irq;
> +    }

... and here pulse if not masked:

        if (!((1 << irq) & s->exti_imr)) {
            /* Interrupt is masked */
            return;
        }
        qemu_irq_pulse(s->irq[irq]);

(Or invert the if condition).

> +}
> +
> +static uint64_t stm32f4xx_exti_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    STM32F4xxExtiState *s = opaque;
> +
> +    trace_stm32f4xx_exti_read(addr);
> +
> +    switch (addr) {
> +    case EXTI_IMR:
> +        return s->exti_imr;
> +    case EXTI_EMR:
> +        return s->exti_emr;
> +    case EXTI_RTSR:
> +        return s->exti_rtsr;
> +    case EXTI_FTSR:
> +        return s->exti_ftsr;
> +    case EXTI_SWIER:
> +        return s->exti_swier;
> +    case EXTI_PR:
> +        return s->exti_pr;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "STM32F4XX_exti_read: Bad offset %x\n", (int)addr);
> +        return 0;
> +    }
> +    return 0;
> +}
> +
> +static void stm32f4xx_exti_write(void *opaque, hwaddr addr,
> +                       uint64_t val64, unsigned int size)
> +{
> +    STM32F4xxExtiState *s = opaque;
> +    uint32_t value = (uint32_t) val64;
> +
> +    trace_stm32f4xx_exti_write(addr, value);
> +
> +    switch (addr) {
> +    case EXTI_IMR:
> +        s->exti_imr = value;
> +        return;
> +    case EXTI_EMR:
> +        s->exti_emr = value;
> +        return;
> +    case EXTI_RTSR:
> +        s->exti_rtsr = value;
> +        return;
> +    case EXTI_FTSR:
> +        s->exti_ftsr = value;
> +        return;
> +    case EXTI_SWIER:
> +        s->exti_swier = value;
> +        return;
> +    case EXTI_PR:
> +        /* This bit is cleared by writing a 1 to it */
> +        s->exti_pr &= ~value;
> +        return;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "STM32F4XX_exti_write: Bad offset %x\n", (int)addr);
> +    }
> +}
> +
> +static const MemoryRegionOps stm32f4xx_exti_ops = {
> +    .read = stm32f4xx_exti_read,
> +    .write = stm32f4xx_exti_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void stm32f4xx_exti_init(Object *obj)
> +{
> +    STM32F4xxExtiState *s = STM32F4XX_EXTI(obj);
> +    int i;
> +
> +    for (i = 0; i < NUM_INTERRUPT_OUT_LINES; i++) {
> +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
> +    }
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32f4xx_exti_ops, s,
> +                          TYPE_STM32F4XX_EXTI, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_exti_set_irq,
> +                      NUM_GPIO_EVENT_IN_LINES);
> +}
> +
> +static const VMStateDescription vmstate_stm32f4xx_exti = {
> +    .name = TYPE_STM32F4XX_EXTI,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(exti_imr, STM32F4xxExtiState),
> +        VMSTATE_UINT32(exti_emr, STM32F4xxExtiState),
> +        VMSTATE_UINT32(exti_rtsr, STM32F4xxExtiState),
> +        VMSTATE_UINT32(exti_ftsr, STM32F4xxExtiState),
> +        VMSTATE_UINT32(exti_swier, STM32F4xxExtiState),
> +        VMSTATE_UINT32(exti_pr, STM32F4xxExtiState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void stm32f4xx_exti_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = stm32f4xx_exti_reset;
> +    dc->vmsd = &vmstate_stm32f4xx_exti;
> +}
> +
> +static const TypeInfo stm32f4xx_exti_info = {
> +    .name          = TYPE_STM32F4XX_EXTI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(STM32F4xxExtiState),
> +    .instance_init = stm32f4xx_exti_init,
> +    .class_init    = stm32f4xx_exti_class_init,
> +};
> +
> +static void stm32f4xx_exti_register_types(void)
> +{
> +    type_register_static(&stm32f4xx_exti_info);
> +}
> +
> +type_init(stm32f4xx_exti_register_types)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 02327562bc..91a3794d68 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -90,6 +90,11 @@ stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
>   stm32f4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
>   stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
>   
> +# stm32f4xx_exti
> +stm32f4xx_exti_set_irq(int irq, int leve) "Set EXTI: %d to %d"
> +stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
> +stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
> +
>   # tz-mpc.c
>   tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs read: offset 0x%x data 0x%" PRIx64 " size %u"
>   tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs write: offset 0x%x data 0x%" PRIx64 " size %u"
> diff --git a/include/hw/misc/stm32f4xx_exti.h b/include/hw/misc/stm32f4xx_exti.h
> new file mode 100644
> index 0000000000..707036a41b
> --- /dev/null
> +++ b/include/hw/misc/stm32f4xx_exti.h
> @@ -0,0 +1,60 @@
> +/*
> + * STM32F4XX EXTI
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_STM_EXTI_H
> +#define HW_STM_EXTI_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/hw.h"
> +
> +#define EXTI_IMR   0x00
> +#define EXTI_EMR   0x04
> +#define EXTI_RTSR  0x08
> +#define EXTI_FTSR  0x0C
> +#define EXTI_SWIER 0x10
> +#define EXTI_PR    0x14
> +
> +#define TYPE_STM32F4XX_EXTI "stm32f4xx-exti"
> +#define STM32F4XX_EXTI(obj) \
> +    OBJECT_CHECK(STM32F4xxExtiState, (obj), TYPE_STM32F4XX_EXTI)
> +
> +#define NUM_GPIO_EVENT_IN_LINES 16
> +#define NUM_INTERRUPT_OUT_LINES 16
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +
> +    uint32_t exti_imr;
> +    uint32_t exti_emr;
> +    uint32_t exti_rtsr;
> +    uint32_t exti_ftsr;
> +    uint32_t exti_swier;
> +    uint32_t exti_pr;
> +
> +    qemu_irq irq[NUM_INTERRUPT_OUT_LINES];
> +} STM32F4xxExtiState;
> +
> +#endif
> 


