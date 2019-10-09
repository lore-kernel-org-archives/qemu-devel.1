Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E9ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F09B206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4VU4Lpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F09B206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEzv-0002jW-2u
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iI6Z0-0001ro-UT
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 03:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iI6Yz-00047J-NX
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 03:39:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54733)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iI6Yw-00046e-VM; Wed, 09 Oct 2019 03:39:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id p7so1243596wmp.4;
 Wed, 09 Oct 2019 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8zCFhaOYo4JvZDuTR8LT8ZeRH1glJIoNVNvHzaX7Cqs=;
 b=a4VU4LpmOcvKddw9FNgq6jUIm9m3OHkTQZoJSIfuAgwIZJL33jZPT9qa5rYVcGPHhK
 nWXJDNiKq4b+jqj//mjMZl2HGYM801289uhhZKspOa1NbU1AAyQAnxpB9h4aqGcHcUvO
 pgd0IZ3JTy0nOmt0QGFVOOMDAY8mM3ncYQlC9UCD9gGQcpQjdJxuzNkrk/QEFbq2YpPJ
 Ju3wqHPVmH20nPHgVpUQ8NPZAgmefgIX1AtB9rRpwUyXifjKzErY+Iu2EZeUrGJ9yhLc
 1zGcOVCM6VbI1EUz26u+YNBZQr6QXDmQja8siopQ6u2ZsmwJz6mLPXzYtX2Te8VoeAyE
 L1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8zCFhaOYo4JvZDuTR8LT8ZeRH1glJIoNVNvHzaX7Cqs=;
 b=mCo/T44nsiY9OoJa0TLofm11bBQ0VE6qeU/rPvvI7+3hekQGfPWB2LEtsUuewLM4Ed
 NA2Wv3wZz5a/2VVIJn7FVQbKUPR/SqEUwXd+IbLi19lRV9t/m0cLUc3BVNN3nAT5i6zE
 hUgJn7Xx8G4j0FCoLXnkSULJPs8JvKfWey9pDjioOs+YOOyjhH+73ydUKuZN0F0kTDnW
 voUQb/5N8OadJHe93ncowgpVcemRXt+j1jvEnHysA9oAXNm9gOz8PN24q/Qo3QOlSx1D
 EjRWoZsxIMPIa9vHLrrXnYTXZcnsXFOD8T5qs7n7EJI0k8iTDoDyyu2drAJFbFAO7bc7
 Gifw==
X-Gm-Message-State: APjAAAXtsinz4zPU6smGRY9CS7wGwFgigiZ1mkKUnpKHpnABpHyNppHH
 CFSZO4VY6XPpwNMrrhMhc5Y=
X-Google-Smtp-Source: APXvYqxCyh6EsXBbQxydeZWUVX3A0jT3NOAhxJHLS7Fsfw/nct2c84Y2/WnTkW5f3/eyCuWkKp8Xvg==
X-Received: by 2002:a1c:5946:: with SMTP id n67mr1540645wmb.93.1570606748866; 
 Wed, 09 Oct 2019 00:39:08 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id u6sm1264547wrt.92.2019.10.09.00.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 00:39:07 -0700 (PDT)
Subject: Re: [PATCH 11/19] hw/arm/bcm2835_peripherals: Use the SYS_timer
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-12-f4bug@amsat.org> <87sgo3i7n1.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c4886680-45aa-b039-4baf-b413493f3890@amsat.org>
Date: Wed, 9 Oct 2019 09:39:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87sgo3i7n1.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?= <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 5:22 PM, Alex Bennée wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Connect the recently added SYS_timer.
>> Now U-Boot does not hang anymore polling a free running counter
>> stuck at 0.
>> This timer is also used by the Linux kernel thermal subsystem.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/arm/bcm2835_peripherals.c         | 21 ++++++++++++++++++++-
>>   include/hw/arm/bcm2835_peripherals.h |  3 ++-
>>   2 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
>> index 70bf927a02..965f4c1f3d 100644
>> --- a/hw/arm/bcm2835_peripherals.c
>> +++ b/hw/arm/bcm2835_peripherals.c
>> @@ -58,6 +58,10 @@ static void bcm2835_peripherals_init(Object *obj)
>>       /* Interrupt Controller */
>>       sysbus_init_child_obj(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
>>
>> +    /* SYS Timer */
>> +    sysbus_init_child_obj(obj, "systimer", &s->systmr, sizeof(s->systmr),
>> +                          TYPE_BCM2835_SYSTIMER);
>> +
>>       /* UART0 */
>>       sysbus_init_child_obj(obj, "uart0", &s->uart0, sizeof(s->uart0),
>>                             TYPE_PL011);
>> @@ -171,6 +175,22 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>>                   sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ic), 0));
>>       sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
>>
>> +    /* Sys Timer */
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
> 
> This looks like an extra check because err is checked above and hasn't
> been messed with since.

Oops good catch. Looking at older branch I had this property:

     object_property_set_uint(OBJECT(&s->systmr), 1000000, "freq_hz", &err);

but then when I removed it I forgot to clean the error check. Thanks!

>> +    object_property_set_bool(OBJECT(&s->systmr), true, "realized", &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +    memory_region_add_subregion(&s->peri_mr, ST_OFFSET,
>> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systmr), 0));
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 0,
>> +        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
>> +                               INTERRUPT_ARM_TIMER));
>> +
>>       /* UART0 */
>>       qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
>>       object_property_set_bool(OBJECT(&s->uart0), true, "realized", &err);
>> @@ -352,7 +372,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>>       }
>>
>>       create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
>> -    create_unimp(s, &s->systmr, "bcm2835-systimer", ST_OFFSET, 0x20);
>>       create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
>>       create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
>>       create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
>> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
>> index be7ad9b499..5b9fc89453 100644
>> --- a/include/hw/arm/bcm2835_peripherals.h
>> +++ b/include/hw/arm/bcm2835_peripherals.h
>> @@ -24,6 +24,7 @@
>>   #include "hw/sd/sdhci.h"
>>   #include "hw/sd/bcm2835_sdhost.h"
>>   #include "hw/gpio/bcm2835_gpio.h"
>> +#include "hw/timer/bcm2835_systmr.h"
>>   #include "hw/misc/unimp.h"
>>
>>   #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
>> @@ -39,7 +40,7 @@ typedef struct BCM2835PeripheralState {
>>       MemoryRegion ram_alias[4];
>>       qemu_irq irq, fiq;
>>
>> -    UnimplementedDeviceState systmr;
>> +    BCM2835SysTimerState systmr;
>>       UnimplementedDeviceState armtmr;
>>       UnimplementedDeviceState cprman;
>>       UnimplementedDeviceState a2w;
> 
> 
> --
> Alex Bennée
> 

