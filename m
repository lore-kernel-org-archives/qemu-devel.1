Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E499EC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3AC208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNC2858r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3AC208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVHb-0003Kt-OO
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioVGZ-0001zl-Dm
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioVGX-0008Lb-Ei
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:30:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31900
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioVGX-0008LC-9H
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578328204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OoStX+EzNnlRyteEv6Xxob0VhDKHOpsN1NU/h/095fs=;
 b=TNC2858rFd+1AHM7K2P9+j6iYdIZ1v8ISyxSM4eoDFOzCwW8Fhj8Fxbh0+sbVD4bH+gLCu
 xP0Kkr6HFxRcNve71KAs7XUsN/4+ewtzA4jqiQ715+b5b1b3slrsLXyf2sm/8VuYxu86Jk
 yrJNBOCXV3y0clEICcW7DN9QQXxqJGo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-Bf8dd65-OWK9WrUbDMJRsg-1; Mon, 06 Jan 2020 11:30:03 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so23428880wrp.8
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 08:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eKl8NBB0cFoyUpwdfPIS7QK3pxvfLtAcfoQE77XRlvw=;
 b=mBN1SVpDzfV5i8U5okOxVJh5Ro0lg2ytBWo0MBiCFmOFwwmPkuNIpdib/uhC7nf08z
 6kmMMEFpWv9ehPq871L/twF7PWCVp8jr8cLrtHahX+/JNfMQzbXoOErDwXY/7LRlkUJa
 hrKNdR+X8U7F/MjIv6jriQf7DyU2STcrD7A9y1rJ8GQFcOXoy1jofROhV/aBKf9zTZny
 XzrSQh68QxrDkNILMWuprYdSJU0NZVYabXjvvu1GkjAhHuqleceFnQu/n4P0QuS9CsUf
 Nqou38yjdL4u9B+rrNRwqNvj8+clg7a+RXQp37WXvCjwQ4gEjGZ2LWc2q3I5OGBQD9f2
 Em7g==
X-Gm-Message-State: APjAAAVsJ5MZaXun11UCd6Vul4YnY/7I0j7imsFJUlP8EsOAfy5/2rU2
 RBd4+79ceRnZd/HGl5+LBF+u/+sYwHkxryxc9QwpU52lYIVuMnviexskMJgMZeY/RQNjtEpelae
 kNsZNeU4nqh5fTV0=
X-Received: by 2002:adf:fa12:: with SMTP id
 m18mr100206432wrr.309.1578328201896; 
 Mon, 06 Jan 2020 08:30:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxe7E1NYODl73wIuV0zzkAKDpyf+T8OTcGMNHlEWK5KUcYy+gPlcCKeL3UtCMp2ePBcc/Suqw==
X-Received: by 2002:adf:fa12:: with SMTP id
 m18mr100206408wrr.309.1578328201559; 
 Mon, 06 Jan 2020 08:30:01 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id i5sm23325714wml.31.2020.01.06.08.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 08:30:01 -0800 (PST)
Subject: Re: [PATCH v7 2/4] hw/misc: Add the STM32F4xx EXTI device
To: Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <cover.1576658572.git.alistair@alistair23.me>
 <ef941d59fd8658589d34ed432e1d6dfdcf7fb1d0.1576658572.git.alistair@alistair23.me>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <55816102-3349-3c12-cce4-d137a6985371@redhat.com>
Date: Mon, 6 Jan 2020 17:30:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ef941d59fd8658589d34ed432e1d6dfdcf7fb1d0.1576658572.git.alistair@alistair23.me>
Content-Language: en-US
X-MC-Unique: Bf8dd65-OWK9WrUbDMJRsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 6:22 AM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig                   |   1 +
>   hw/misc/Kconfig                  |   3 +
>   hw/misc/Makefile.objs            |   1 +
>   hw/misc/stm32f4xx_exti.c         | 188 +++++++++++++++++++++++++++++++
>   hw/misc/trace-events             |   5 +
>   include/hw/misc/stm32f4xx_exti.h |  60 ++++++++++
>   6 files changed, 258 insertions(+)
>   create mode 100644 hw/misc/stm32f4xx_exti.c
>   create mode 100644 include/hw/misc/stm32f4xx_exti.h
>=20
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 4660d14715..3d86691ae0 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -315,6 +315,7 @@ config STM32F405_SOC
>       bool
>       select ARM_V7M
>       select STM32F4XX_SYSCFG
> +    select STM32F4XX_EXTI
>  =20
>   config XLNX_ZYNQMP_ARM
>       bool
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 72609650b7..bdd77d8020 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -85,6 +85,9 @@ config STM32F2XX_SYSCFG
>   config STM32F4XX_SYSCFG
>       bool
>  =20
> +config STM32F4XX_EXTI
> +    bool
> +
>   config MIPS_ITU
>       bool
>  =20
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index ea8025e0bb..c6ecbdd7b0 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -59,6 +59,7 @@ common-obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
>   common-obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
>   common-obj-$(CONFIG_STM32F2XX_SYSCFG) +=3D stm32f2xx_syscfg.o
>   common-obj-$(CONFIG_STM32F4XX_SYSCFG) +=3D stm32f4xx_syscfg.o
> +common-obj-$(CONFIG_STM32F4XX_EXTI) +=3D stm32f4xx_exti.o
>   obj-$(CONFIG_MIPS_CPS) +=3D mips_cmgcr.o
>   obj-$(CONFIG_MIPS_CPS) +=3D mips_cpc.o
>   obj-$(CONFIG_MIPS_ITU) +=3D mips_itu.o
> diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
> new file mode 100644
> index 0000000000..02e7810046
> --- /dev/null
> +++ b/hw/misc/stm32f4xx_exti.c
> @@ -0,0 +1,188 @@
> +/*
> + * STM32F4XX EXTI
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
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
> +    STM32F4xxExtiState *s =3D STM32F4XX_EXTI(dev);
> +
> +    s->exti_imr =3D 0x00000000;
> +    s->exti_emr =3D 0x00000000;
> +    s->exti_rtsr =3D 0x00000000;
> +    s->exti_ftsr =3D 0x00000000;
> +    s->exti_swier =3D 0x00000000;
> +    s->exti_pr =3D 0x00000000;
> +}
> +
> +static void stm32f4xx_exti_set_irq(void *opaque, int irq, int level)
> +{
> +    STM32F4xxExtiState *s =3D opaque;
> +
> +    trace_stm32f4xx_exti_set_irq(irq, level);
> +
> +    if (((1 << irq) & s->exti_rtsr) && level) {
> +        /* Rising Edge */
> +        s->exti_pr |=3D 1 << irq;
> +    }
> +
> +    if (((1 << irq) & s->exti_ftsr) && !level) {
> +        /* Falling Edge */
> +        s->exti_pr |=3D 1 << irq;
> +    }
> +
> +    if (!((1 << irq) & s->exti_imr)) {
> +        /* Interrupt is masked */
> +        return;
> +    }
> +    qemu_irq_pulse(s->irq[irq]);

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +}
> +
> +static uint64_t stm32f4xx_exti_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    STM32F4xxExtiState *s =3D opaque;
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
> +                      "STM32F4XX_exti_read: Bad offset %x\n", (int)addr)=
;
> +        return 0;
> +    }
> +    return 0;
> +}
> +
> +static void stm32f4xx_exti_write(void *opaque, hwaddr addr,
> +                       uint64_t val64, unsigned int size)
> +{
> +    STM32F4xxExtiState *s =3D opaque;
> +    uint32_t value =3D (uint32_t) val64;
> +
> +    trace_stm32f4xx_exti_write(addr, value);
> +
> +    switch (addr) {
> +    case EXTI_IMR:
> +        s->exti_imr =3D value;
> +        return;
> +    case EXTI_EMR:
> +        s->exti_emr =3D value;
> +        return;
> +    case EXTI_RTSR:
> +        s->exti_rtsr =3D value;
> +        return;
> +    case EXTI_FTSR:
> +        s->exti_ftsr =3D value;
> +        return;
> +    case EXTI_SWIER:
> +        s->exti_swier =3D value;
> +        return;
> +    case EXTI_PR:
> +        /* This bit is cleared by writing a 1 to it */
> +        s->exti_pr &=3D ~value;
> +        return;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "STM32F4XX_exti_write: Bad offset %x\n", (int)addr=
);
> +    }
> +}
> +
> +static const MemoryRegionOps stm32f4xx_exti_ops =3D {
> +    .read =3D stm32f4xx_exti_read,
> +    .write =3D stm32f4xx_exti_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void stm32f4xx_exti_init(Object *obj)
> +{
> +    STM32F4xxExtiState *s =3D STM32F4XX_EXTI(obj);
> +    int i;
> +
> +    for (i =3D 0; i < NUM_INTERRUPT_OUT_LINES; i++) {
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
> +static const VMStateDescription vmstate_stm32f4xx_exti =3D {
> +    .name =3D TYPE_STM32F4XX_EXTI,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
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
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->reset =3D stm32f4xx_exti_reset;
> +    dc->vmsd =3D &vmstate_stm32f4xx_exti;
> +}
> +
> +static const TypeInfo stm32f4xx_exti_info =3D {
> +    .name          =3D TYPE_STM32F4XX_EXTI,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(STM32F4xxExtiState),
> +    .instance_init =3D stm32f4xx_exti_init,
> +    .class_init    =3D stm32f4xx_exti_class_init,
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
>   stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: =
0x%" PRIx64 " val: 0x%" PRIx64 ""
>  =20
> +# stm32f4xx_exti
> +stm32f4xx_exti_set_irq(int irq, int leve) "Set EXTI: %d to %d"
> +stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
> +stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%=
" PRIx64 " val: 0x%" PRIx64 ""
> +
>   # tz-mpc.c
>   tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC =
regs read: offset 0x%x data 0x%" PRIx64 " size %u"
>   tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC=
 regs write: offset 0x%x data 0x%" PRIx64 " size %u"
> diff --git a/include/hw/misc/stm32f4xx_exti.h b/include/hw/misc/stm32f4xx=
_exti.h
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
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
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
>=20


