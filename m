Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7640C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1D72068E
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQDI3Qhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1D72068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPAQx-0004AU-S9
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 16:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAQ1-0003jp-Hz
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 16:15:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAPx-0005yg-S1
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 16:15:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so3663820wre.4
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UBSMf54U53NM/qdrkRx14/uEvub0gH87pOzN/23mg8k=;
 b=EQDI3QhzYN7Ud6EdYpwk6AtuGwP/MGRtJSmbdRaPL/WarNrGviiRS2w171dbZF5qtI
 zDHBpZ6NHU2Tdpn28rczpS8WtSIc0mYhEPHb/BsI1SXOHzpeyLc0uD8/hW/UESBEE/lc
 wG8U7pOn7suCrbge2haZDSfag73cqiHg7fwDjYlAXp3U6nAR3cDH+WL/PwhOSK5HBTuE
 iwfirrJc8ts2pty/ktPSYuXz1rCtyGA5scNiyQpFfSndPMh8R2f/qSgMmgJrYs2VnL9W
 eup1csDk7JXE6be7YekHq174tf1BMK9n+3snrB0Bl/HQr1e24QTw0ZMx87nvhCvkhBGi
 m1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UBSMf54U53NM/qdrkRx14/uEvub0gH87pOzN/23mg8k=;
 b=Hn2BG5lOJ8KN9ZngvPKOZhpfgVSqjxmNvwAzzsgTZpUwOwtLGUn1pY7KWxR27NHTl0
 VaHz2POSv66Kp85s/1sy1t1n0du/wak/z2AjLGBVOk9tV+4RbibRPkWJoe6MfALJwDbZ
 hKNNGzcfW+JZEyyhOsPtMWzETEtI+C/Ps6su2IJaxFZKrqzEZAXm+7dQjfHOTtoygOTi
 r8jGhX4FksqY6Ho/6JCH0F6AR87i9+a3pOeQm+YJjpiMsdhVwP6iZPy5KRMF70hfomR2
 /AjvUgJY5J/0/hnWWwZC7ihJUTu4GsJWpJoS6gruwPsKetwt9oks7qYQ9l0gTgVqeUcR
 KYiA==
X-Gm-Message-State: AOAM533UCMJ5d0HcsujVha0bkr6m3vm7Mhh+V1mlsInyH6psuNjALGFP
 i3XMRIcQk1wBNOsez00grS4=
X-Google-Smtp-Source: ABdhPJw78V5i2XLw72bOBsYkrxzmxzCjbKmlDOe00zAPGj5x2bie40kfL4PE9ir0svVTa3O7KeUNLw==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr13760469wrs.227.1601842536024; 
 Sun, 04 Oct 2020 13:15:36 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u8sm9793117wmj.45.2020.10.04.13.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Oct 2020 13:15:35 -0700 (PDT)
Subject: Re: [PATCH v4] hw/avr: Add limited support for avr gpio registers
To: Heecheol Yang <heecheol.yang@outlook.com>, qemu-devel@nongnu.org
References: <DM6PR16MB2473130E0A6A463C43B66AF0E60F0@DM6PR16MB2473.namprd16.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <70ae97a3-547a-71c1-8a23-945445c7ab06@amsat.org>
Date: Sun, 4 Oct 2020 22:15:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR16MB2473130E0A6A463C43B66AF0E60F0@DM6PR16MB2473.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/20 3:16 PM, Heecheol Yang wrote:
> Add some of these features for avr gpio:

Please rename 'avr gpio' -> 'AVR GPIO".

> 
>   - GPIO I/O : PORTx registers
>   - Data Direction : DDRx registers
> 
> Following things are not supported yet:
>   - PINx registers
>   - MCUR registers
>   - Even though read/write for DDRx registers are
>     implemented, actual direction controls are not
>     supported yet.
> 
> Signed-off-by: Heecheol Yang <heecheol.yang@outlook.com>
> ---
>  hw/avr/Kconfig             |   1 +
>  hw/avr/atmega.c            |   7 ++-
>  hw/avr/atmega.h            |   2 +
>  hw/gpio/Kconfig            |   3 +
>  hw/gpio/avr_gpio.c         | 112 +++++++++++++++++++++++++++++++++++++
>  hw/gpio/meson.build        |   2 +
>  include/hw/gpio/avr_gpio.h |  46 +++++++++++++++
>  7 files changed, 171 insertions(+), 2 deletions(-)
>  create mode 100644 hw/gpio/avr_gpio.c
>  create mode 100644 include/hw/gpio/avr_gpio.h
> 
> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> index d31298c3cc..16a57ced11 100644
> --- a/hw/avr/Kconfig
> +++ b/hw/avr/Kconfig
> @@ -3,6 +3,7 @@ config AVR_ATMEGA_MCU
>      select AVR_TIMER16
>      select AVR_USART
>      select AVR_POWER
> +    select AVR_GPIO
>  
>  config ARDUINO
>      select AVR_ATMEGA_MCU
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index 44c6afebbb..ad942028fd 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -283,8 +283,11 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>              continue;
>          }
>          devname = g_strdup_printf("atmega-gpio-%c", 'a' + (char)i);
> -        create_unimplemented_device(devname,
> -                                    OFFSET_DATA + mc->dev[idx].addr, 3);
> +        object_initialize_child(OBJECT(dev), devname, &s->gpio[i],
> +                                TYPE_AVR_GPIO);

Ideally we'd want to set the port name (A, B, ...). Can be done later.

> +        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &error_abort);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0,
> +            OFFSET_DATA + mc->dev[idx].addr);
>          g_free(devname);
>      }
>  
> diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
> index a99ee15c7e..e2289d5744 100644
> --- a/hw/avr/atmega.h
> +++ b/hw/avr/atmega.h
> @@ -13,6 +13,7 @@
>  
>  #include "hw/char/avr_usart.h"
>  #include "hw/timer/avr_timer16.h"
> +#include "hw/gpio/avr_gpio.h"
>  #include "hw/misc/avr_power.h"
>  #include "target/avr/cpu.h"
>  #include "qom/object.h"
> @@ -44,6 +45,7 @@ struct AtmegaMcuState {
>      DeviceState *io;
>      AVRMaskState pwr[POWER_MAX];
>      AVRUsartState usart[USART_MAX];
> +    AVRGPIOState gpio[GPIO_MAX];
>      AVRTimer16State timer[TIMER_MAX];
>      uint64_t xtal_freq_hz;
>  };
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index b6fdaa2586..1752d0ce56 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -10,3 +10,6 @@ config GPIO_KEY
>  
>  config SIFIVE_GPIO
>      bool
> +
> +config AVR_GPIO
> +    bool
> diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c
> new file mode 100644
> index 0000000000..6ca8e8703a
> --- /dev/null
> +++ b/hw/gpio/avr_gpio.c
> @@ -0,0 +1,112 @@
> +/*
> + * AVR processors GPIO registers emulation.
> + *
> + * Copyright (C) 2020 Heecheol Yang <heecheol.yang@outlook.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +#include "hw/gpio/avr_gpio.h"
> +#include "hw/qdev-properties.h"
> +
> +static void avr_gpio_reset(DeviceState *dev)
> +{
> +    AVRGPIOState *gpio = AVR_GPIO(dev);
> +    gpio->ddr_val = 0u;
> +    gpio->port_val = 0u;
> +}
> +static uint64_t avr_gpio_read(void *opaque, hwaddr offset, unsigned int size)
> +{
> +    AVRGPIOState *s = (AVRGPIOState *)opaque;
> +    switch (offset) {
> +    case GPIO_PIN:
> +        /* Not implemented yet */
> +        break;
> +    case GPIO_DDR:
> +        return s->ddr_val;
> +        break;
> +    case GPIO_PORT:
> +        return s->port_val;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +    return 0;
> +}
> +
> +static void avr_gpio_write(void *opaque, hwaddr offset, uint64_t value,
> +                                unsigned int size)
> +{
> +    AVRGPIOState *s = (AVRGPIOState *)opaque;
> +    switch (offset) {
> +    case GPIO_PIN:
> +        /* Not implemented yet */

This one is easy, it just toggles the output.

> +        break;
> +    case GPIO_DDR:
> +        s->ddr_val = value & 0xF;

OK.

> +        break;
> +    case GPIO_PORT:
> +        s->port_val = value & 0xF;

Here you need to do the logic described in the
"Ports as General Digital I/O" section of the datasheet:
- check direction in DDR
- set value with qemu_set_irq().

> +        break;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps avr_gpio_ops = {
> +    .read = avr_gpio_read,
> +    .write = avr_gpio_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void avr_gpio_init(Object *obj)
> +{
> +    AVRGPIOState *s = AVR_GPIO(obj);
> +    memory_region_init_io(&s->mmio, obj, &avr_gpio_ops, s, TYPE_AVR_GPIO, 3);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);

To be somehow useful, these device needs to propagate the GPIO
level changes. Here you need to create the output GPIOs:

       qdev_init_gpio_out(DEVICE(obj), &s->out, ARRAY_SIZE(s->out));

> +}
> +static void avr_gpio_realize(DeviceState *dev, Error **errp)
> +{
> +    avr_gpio_reset(dev);

No need to call reset() in realize(), because ...

> +}
> +
> +
> +static void avr_gpio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = avr_gpio_reset;

... the handler is already set here and will be called by the generic
QDEV code once the device is realized().

> +    dc->realize = avr_gpio_realize;
> +}
> +
> +static const TypeInfo avr_gpio_info = {
> +    .name          = TYPE_AVR_GPIO,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AVRGPIOState),
> +    .instance_init = avr_gpio_init,
> +    .class_init    = avr_gpio_class_init,
> +};
> +
> +static void avr_gpio_register_types(void)
> +{
> +    type_register_static(&avr_gpio_info);
> +}
> +
> +type_init(avr_gpio_register_types)
> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> index 86cae9a0f3..258bd5dcfc 100644
> --- a/hw/gpio/meson.build
> +++ b/hw/gpio/meson.build
> @@ -11,3 +11,5 @@ softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
>  softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
>  softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
>  softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
> +
> +softmmu_ss.add(when: 'CONFIG_AVR_GPIO', if_true: files('avr_gpio.c'))
> diff --git a/include/hw/gpio/avr_gpio.h b/include/hw/gpio/avr_gpio.h
> new file mode 100644
> index 0000000000..84d783f8fc
> --- /dev/null
> +++ b/include/hw/gpio/avr_gpio.h
> @@ -0,0 +1,46 @@
> +/*
> + * AVR processors GPIO registers definition.
> + *
> + * Copyright (C) 2020 Heecheol Yang <heecheol.yang@outlook.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef AVR_GPIO_H
> +#define AVR_GPIO_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +/* Offsets of registers. */
> +#define GPIO_PIN   0x00
> +#define GPIO_DDR   0x01
> +#define GPIO_PORT  0x02
> +
> +#define TYPE_AVR_GPIO "avr-gpio"
> +OBJECT_DECLARE_SIMPLE_TYPE(AVRGPIOState, AVR_GPIO)

#define AVR_GPIO_COUNT 8

> +
> +struct AVRGPIOState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion mmio;
> +

Hold output GPIOs in the device state:

       qemu_irq out[AVR_GPIO_COUNT];

> +    uint8_t ddr_val;
> +    uint8_t port_val;

Using this can make your code easier to understand:

       struct {
           uint8_t pin;
           uint8_t ddr;
           uint8_t port;
       } reg;

> +
> +};
> +
> +#endif /* AVR_GPIO_H */
> 


