Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BADDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FDF20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiLLWt9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FDF20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeEn-0001SQ-0D
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iNdNi-0002CD-3d
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iNdNg-00061W-6G
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:42:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iNdNb-00060G-TI; Thu, 24 Oct 2019 09:42:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id g7so2901183wmk.4;
 Thu, 24 Oct 2019 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TdqrUktuxA5u4g3NMPEZx5ELAhdVB8wB3lU93EoPCbo=;
 b=hiLLWt9jG7TPYrre/l4GdFdXb5YiZ+pJaBWlD5oZ25YZrcFygKcEKwOVxHAksmlP7I
 GPVLz81oY7/kF69cin6uxzuU/VxHxHKgp6PdIjTjDLF3iE54TY+uYYRvwCguv/yJvFlr
 VHH0im3MpSl8YTdVSWWBRszGBS2/qm2wO2aaPbRLDXPErHKQDv60gZEfRx7gif7VfEP9
 T9h7jxVeNDvoq6QL7/Hke1LxCmLpgWdrSfGPqavNek1DZxi6DP0lshyiSVVnyCM/nlk4
 h+B9IPMVJWU4KoQd6ZhfARvuFH9jgcb3PriE13msqnLR/kJ/Eiho6T+j1oAuuo8ArMdJ
 qDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TdqrUktuxA5u4g3NMPEZx5ELAhdVB8wB3lU93EoPCbo=;
 b=f5TQarZRX66rDesC08djbxHjcQ+2jduRqwcXzc7Nuz4zStNAY+gzyNwj5kCwU3nlYc
 gYD3ONJYqYDFlBqyoIwBJ6UacWbZwNdAkIpzquec7PG2eM8JaSRDttOL0TM9d2sF4B0K
 5RtRdPVXpBjGLwltjmu3BUiu+QKKVOQ94D2ZiHENafYjhecl3/9ZwaNgZeHHfSUx62pq
 6+8SJ5qVXNA1etT2I2+rvV8nMyVYVuoxZ/1077MWvM+TJCX1xxNeomW1iDb79XKqM7ni
 zC9XRtB5Scc9qAGoPagFCgwQKTDuLLnw8iqU2T8QltkPoNwe04O6OfIplGjwPQ5gSlWW
 vMEQ==
X-Gm-Message-State: APjAAAW5J6OwAm8Xk5Q1WJddPW8HBrARNMtKYuReYioOMPEqv8KluAyY
 HprtjzbuVlz3L3DUaL5g4QA=
X-Google-Smtp-Source: APXvYqzvceFvA4AydrVGgqjnLGhRJHOUg3CdfIKDeaJtTFBYmOfvTQabRnwkCESjH9rX6r7DPdOjxw==
X-Received: by 2002:a1c:2407:: with SMTP id k7mr4690199wmk.99.1571924538059;
 Thu, 24 Oct 2019 06:42:18 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id r27sm42137869wrc.55.2019.10.24.06.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 06:42:16 -0700 (PDT)
Subject: Re: [PATCH v3 03/16] hw/timer/bcm2835: Add the BCM2835 SYS_timer
To: Alistair Francis <alistair23@gmail.com>
References: <20191019234715.25750-1-f4bug@amsat.org>
 <20191019234715.25750-4-f4bug@amsat.org>
 <CAKmqyKNHTrOWfyuzG+s=iZ-AifD_OzDrTgvXGCXqXa2bsZiPOg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6ca703f7-d76b-04ca-0386-556391f535e5@amsat.org>
Date: Thu, 24 Oct 2019 15:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNHTrOWfyuzG+s=iZ-AifD_OzDrTgvXGCXqXa2bsZiPOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 10:31 PM, Alistair Francis wrote:
> On Sat, Oct 19, 2019 at 4:47 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Add the 64-bit free running timer. Do not model the COMPARE register
>> (no IRQ generated).
>> This timer is used by Linux kernel and recently U-Boot:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/bcm2835_timer.c?h=v3.7
>> https://github.com/u-boot/u-boot/blob/v2019.07/include/configs/rpi.h#L19
>>
>> Datasheet used:
>> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> v2:
>> - Add status/compare* registers
>> - Add vmstate and reset handler
>>
>> checkpatch warning:
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>> This is OK because the regex are:
>>
>>    F: hw/*/bcm283*
>>    F: include/hw/*/bcm283*
>> ---
>>   hw/timer/Makefile.objs            |   1 +
>>   hw/timer/bcm2835_systmr.c         | 166 ++++++++++++++++++++++++++++++
>>   hw/timer/trace-events             |   5 +
>>   include/hw/timer/bcm2835_systmr.h |  33 ++++++
>>   4 files changed, 205 insertions(+)
>>   create mode 100644 hw/timer/bcm2835_systmr.c
>>   create mode 100644 include/hw/timer/bcm2835_systmr.h
>>
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index 123d92c969..696cda5905 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -47,3 +47,4 @@ common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
>>   common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
>>   common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
>>   common-obj-$(CONFIG_MSF2) += mss-timer.o
>> +common-obj-$(CONFIG_RASPI) += bcm2835_systmr.o
>> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
>> new file mode 100644
>> index 0000000000..49b40b55f9
>> --- /dev/null
>> +++ b/hw/timer/bcm2835_systmr.c
>> @@ -0,0 +1,166 @@
>> +/*
>> + * BCM2835 SYS timer emulation
>> + *
>> + * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * Datasheet: BCM2835 ARM Peripherals (C6357-M-1398)
>> + * https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
>> + *
>> + * Only the free running 64-bit counter is implemented.
>> + * The 4 COMPARE registers and the interruption are not implemented.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qemu/timer.h"
>> +#include "hw/timer/bcm2835_systmr.h"
>> +#include "hw/registerfields.h"
>> +#include "migration/vmstate.h"
>> +#include "trace.h"
>> +
>> +REG32(CTRL_STATUS,  0x00)
>> +REG32(COUNTER_LOW,  0x04)
>> +REG32(COUNTER_HIGH, 0x08)
>> +REG32(COMPARE0,     0x0c)
>> +REG32(COMPARE1,     0x10)
>> +REG32(COMPARE2,     0x14)
>> +REG32(COMPARE3,     0x18)
>> +
>> +static void bcm2835_systmr_update_irq(BCM2835SystemTimerState *s)
>> +{
>> +    bool enable = !!s->reg.status;
>> +
>> +    trace_bcm2835_systmr_irq(enable);
>> +    qemu_set_irq(s->irq, enable);
>> +}
>> +
>> +static void bcm2835_systmr_update_compare(BCM2835SystemTimerState *s,
>> +                                          unsigned timer_index)
>> +{
>> +    /* TODO fow now, since neither Linux nor U-boot use these timers. */
>> +    qemu_log_mask(LOG_UNIMP, "COMPARE register %u not implemented\n",
>> +                  timer_index);
>> +}
>> +
>> +static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
>> +                                    unsigned size)
>> +{
>> +    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
>> +    uint64_t r = 0;
>> +
>> +    switch (offset) {
>> +    case A_CTRL_STATUS:
>> +        r = s->reg.status;
>> +        break;
>> +    case A_COMPARE0 ... A_COMPARE3:
>> +        r = s->reg.compare[(offset - A_COMPARE0) >> 2];
>> +        break;
>> +    case A_COUNTER_LOW:
>> +    case A_COUNTER_HIGH:
>> +        /* Free running counter at 1MHz */
>> +        r = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
>> +        r >>= 8 * (offset - A_COUNTER_LOW);
>> +        r &= UINT32_MAX;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%" HWADDR_PRIx "\n",
>> +                      __func__, offset);
>> +        break;
>> +    }
>> +    trace_bcm2835_systmr_read(offset, r);
>> +
>> +    return r;
>> +}
>> +
>> +static void bcm2835_systmr_write(void *opaque, hwaddr offset,
>> +                                 uint64_t value, unsigned size)
>> +{
>> +    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
>> +
>> +    trace_bcm2835_systmr_write(offset, value);
>> +    switch (offset) {
>> +    case A_CTRL_STATUS:
>> +        s->reg.status &= ~value; /* Ack */
>> +        bcm2835_systmr_update_irq(s);
>> +        break;
>> +    case A_COMPARE0 ... A_COMPARE3:
>> +        s->reg.compare[(offset - A_COMPARE0) >> 2] = value;
>> +        bcm2835_systmr_update_compare(s, (offset - A_COMPARE0) >> 2);
>> +        break;
>> +    case A_COUNTER_LOW:
>> +    case A_COUNTER_HIGH:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read-only ofs 0x%" HWADDR_PRIx "\n",
>> +                      __func__, offset);
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%" HWADDR_PRIx "\n",
>> +                      __func__, offset);
>> +        break;
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps bcm2835_systmr_ops = {
>> +    .read = bcm2835_systmr_read,
>> +    .write = bcm2835_systmr_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    },
>> +};
>> +
>> +static void bcm2835_systmr_reset(DeviceState *dev)
>> +{
>> +    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(dev);
>> +
>> +    s->reg.status = 0;
>> +    for (size_t i = 0; i < ARRAY_SIZE(s->reg.compare); i++) {
>> +        s->reg.compare[i] = 0;
>> +    }
> 
> Can we use meset (or the glib version) here instead?

My first thought was "I'd rather not" because I thought the
COUNTER registers weren't reinitialized on reset, but they
are, so OK. (there is no glib memset AFAIK).

> 
> Otherwise:
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for reviewing this series!

> 
> Alistair
> 
>> +}
>> +
>> +static void bcm2835_systmr_realize(DeviceState *dev, Error **errp)
>> +{
>> +    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(dev);
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_systmr_ops,
>> +                          s, "bcm2835-sys-timer", 0x20);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>> +}
>> +
>> +static const VMStateDescription bcm2835_systmr_vmstate = {
>> +    .name = "bcm2835_sys_timer",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(reg.status, BCM2835SystemTimerState),
>> +        VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState, 4),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void bcm2835_systmr_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->realize = bcm2835_systmr_realize;
>> +    dc->reset = bcm2835_systmr_reset;
>> +    dc->vmsd = &bcm2835_systmr_vmstate;
>> +}
>> +
>> +static const TypeInfo bcm2835_systmr_info = {
>> +    .name = TYPE_BCM2835_SYSTIMER,
>> +    .parent = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(BCM2835SystemTimerState),
>> +    .class_init = bcm2835_systmr_class_init,
>> +};
>> +
>> +static void bcm2835_systmr_register_types(void)
>> +{
>> +    type_register_static(&bcm2835_systmr_info);
>> +}
>> +
>> +type_init(bcm2835_systmr_register_types);
>> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
>> index db02a9142c..0aa399ac69 100644
>> --- a/hw/timer/trace-events
>> +++ b/hw/timer/trace-events
>> @@ -87,3 +87,8 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>>   pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>>   pl031_alarm_raised(void) "alarm raised"
>>   pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
>> +
>> +# bcm2835_systmr.c
>> +bcm2835_systmr_irq(bool enable) "timer irq state %u"
>> +bcm2835_systmr_read(uint64_t offset, uint64_t data) "timer read: offset 0x%" PRIx64 " data 0x%" PRIx64
>> +bcm2835_systmr_write(uint64_t offset, uint64_t data) "timer write: offset 0x%" PRIx64 " data 0x%" PRIx64
>> diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
>> new file mode 100644
>> index 0000000000..c0bc5c8127
>> --- /dev/null
>> +++ b/include/hw/timer/bcm2835_systmr.h
>> @@ -0,0 +1,33 @@
>> +/*
>> + * BCM2835 SYS timer emulation
>> + *
>> + * Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef BCM2835_SYSTIMER_H
>> +#define BCM2835_SYSTIMER_H
>> +
>> +#include "hw/sysbus.h"
>> +#include "hw/irq.h"
>> +
>> +#define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
>> +#define BCM2835_SYSTIMER(obj) \
>> +    OBJECT_CHECK(BCM2835SystemTimerState, (obj), TYPE_BCM2835_SYSTIMER)
>> +
>> +typedef struct {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +
>> +    /*< public >*/
>> +    MemoryRegion iomem;
>> +    qemu_irq irq;
>> +
>> +    struct {
>> +        uint32_t status;
>> +        uint32_t compare[4];
>> +    } reg;
>> +} BCM2835SystemTimerState;
>> +
>> +#endif
>> --
>> 2.21.0
>>
>>

