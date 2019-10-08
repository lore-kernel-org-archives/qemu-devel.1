Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE8BC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53F5206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsqxOCKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53F5206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHm4U-0000lI-TB
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHm3B-0008Sf-BH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHm39-0007rg-Gf
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:45:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHm1O-0006uU-4Z; Tue, 08 Oct 2019 05:44:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id a6so2374905wma.5;
 Tue, 08 Oct 2019 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sEKYBVgPKenJ354dWN21L7QcGf1JAPyfKvXWJVllcrU=;
 b=fsqxOCKr+NQ0Ip3PYiI/tBzax2aujZGrHNp4NJh7dnZAY/atSKlTsfmDGOncVASCbA
 tVQIgeQePrtuen58NYP912casEKEsZqdK/rZNmy+TTAKxKkW/f/JfwE6GHShEXij1Lkc
 Bj7DsKSYv0v7Iuwj6jB3k2YMAeNA70TRMIaa0Jy4nzHw06ADn5AkdfAr4rPd00Us6J6g
 9KQQx+UOQ4tZypz7pu6mi7ksK6DJPq4fsMEq63L2z9Ayhzc/QTFoeECpYoInLNdBONhh
 Mu1E7d5ul2+3pqWDctlpjEEX5xkQ5F97AyeHqX234saAW7rxx/YdKb8NFFHWw0cSQPtU
 wPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sEKYBVgPKenJ354dWN21L7QcGf1JAPyfKvXWJVllcrU=;
 b=oaR6jECVrXqow8acxVUUSvq05Yl6xEny6/Ml+56E3dA+yhLpX5L1rphhtlvg2OERzV
 xuwDsdx1SSeXu6JJyBsvNifSu6T5t0CHpxPbvNkNLXiN0SBlstRyxK7jKpXysfuWdfD6
 pqF1gL1aKDicvWmTuGfCpSQEcYOZAEY3NcNGciFUV3W5QBhDVA3cAn9hyIax73PDTH72
 qJYdfWpuuLr51+/oMpU9yJZnPHhaoC/0L817W5PJAxacEuhlBesZHFu1Q/hyUlFOAjQi
 pDYv3jnYZP7DnMwh67M7/Uvq2j+uKDMv9m7rGSw/qgHkIzPHVcOjtq4dc6RgtKcq2bhf
 vHfQ==
X-Gm-Message-State: APjAAAUqEqcAQDvc/kUAWO+U7IlA0qKUCOR8jq27x1OH2HaRdxDd+Szs
 fiJdBo+VBRuALOB077QGRh8=
X-Google-Smtp-Source: APXvYqxMnMAhWtq0zEIGn/l2SkkyaDh/ng3AEMVoaboTADB0+/p5Ry6d818Gm395HI+kGi0TxqD4FA==
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr2925133wmf.72.1570527787909; 
 Tue, 08 Oct 2019 02:43:07 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id l7sm18760255wrv.77.2019.10.08.02.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 02:43:06 -0700 (PDT)
Subject: Re: [PATCH 05/19] hw/arm/bcm2835: Add various unimplemented
 peripherals
To: Alistair Francis <alistair23@gmail.com>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-6-f4bug@amsat.org>
 <CAKmqyKP+ABP9J=1UJEA+HEO4+UBuyjOoyzZVEJEDiM7N63bMag@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d2ab9145-cf4e-008c-8351-51f271fa37f8@amsat.org>
Date: Tue, 8 Oct 2019 11:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKP+ABP9J=1UJEA+HEO4+UBuyjOoyzZVEJEDiM7N63bMag@mail.gmail.com>
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
 =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?= <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On 9/27/19 11:42 PM, Alistair Francis wrote:
>   On Thu, Sep 26, 2019 at 10:44 AM Philippe Mathieu-Daudé
> <f4bug@amsat.org> wrote:
>>
>> Base addresses and sizes taken from the "BCM2835 ARM Peripherals"
>> datasheet from February 06 2012:
>> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/arm/bcm2835_peripherals.c         | 31 ++++++++++++++++++++++++++++
>>   include/hw/arm/bcm2835_peripherals.h | 15 ++++++++++++++
>>   include/hw/arm/raspi_platform.h      |  8 +++++++
>>   3 files changed, 54 insertions(+)
>>
>> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
>> index 1bd2ff41d5..fdcf616c56 100644
>> --- a/hw/arm/bcm2835_peripherals.c
>> +++ b/hw/arm/bcm2835_peripherals.c
>> @@ -22,6 +22,20 @@
>>   /* Capabilities for SD controller: no DMA, high-speed, default clocks etc. */
>>   #define BCM2835_SDHC_CAPAREG 0x52134b4
>>
>> +static void create_unimp(BCM2835PeripheralState *ps,
>> +                         UnimplementedDeviceState *uds,
>> +                         const char *name, hwaddr ofs, hwaddr size)
>> +{
>> +    sysbus_init_child_obj(OBJECT(ps), name, uds,
>> +                          sizeof(UnimplementedDeviceState),
>> +                          TYPE_UNIMPLEMENTED_DEVICE);
>> +    qdev_prop_set_string(DEVICE(uds), "name", name);
>> +    qdev_prop_set_uint64(DEVICE(uds), "size", size);
>> +    object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
>> +    memory_region_add_subregion_overlap(&ps->peri_mr, ofs,
>> +                    sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0), -1000);
> 
> Why not just use create_unimplemented_device() and not bother saving
> the UnimplementedDeviceState members in the struct?

create_unimplemented_device() calls
  -> sysbus_mmio_map_overlap()
     -> sysbus_mmio_map_common()
       -> memory_region_del_subregion(get_system_memory())

So it maps the device at *absolute* offset in the system memory.

create_unimp() maps the device at offset *relative* to peri_mr.

Patch 8 of this series maps the PERI (container) block at peri_base 
(fixed at BCM2836_PERI_BASE=0x3F000000 for the 2836/2837), then patch 12 
adds the 2838 which has PERI mapped at 0xfe000000. So we have the same 
"container" block mapped at different addresses.
Not the PERI block itself doesn't know its base address, all offsets are 
relative.

So using create_unimp() allow to use the same block in two different SoCs.

8:  https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00678.html
12: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00684.html

>> +}
>> +
>>   static void bcm2835_peripherals_init(Object *obj)
>>   {
>>       BCM2835PeripheralState *s = BCM2835_PERIPHERALS(obj);
>> @@ -323,6 +337,23 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>>           error_propagate(errp, err);
>>           return;
>>       }
>> +
>> +    create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
>> +    create_unimp(s, &s->systmr, "bcm2835-systimer", ST_OFFSET, 0x20);
>> +    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
>> +    create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
>> +    create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
>> +    create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
>> +    create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
>> +    create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
>> +    create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
>> +    create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
>> +    create_unimp(s, &s->i2c[2], "bcm2835-i2c2", BSC2_OFFSET, 0x20);
>> +    create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
>> +    create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
>> +    create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
>> +    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x1000);
>> +    create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
>>   }
>>
>>   static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
>> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
>> index 6b17f6a382..62a4c7b559 100644
>> --- a/include/hw/arm/bcm2835_peripherals.h
>> +++ b/include/hw/arm/bcm2835_peripherals.h
>> @@ -23,6 +23,7 @@
>>   #include "hw/sd/sdhci.h"
>>   #include "hw/sd/bcm2835_sdhost.h"
>>   #include "hw/gpio/bcm2835_gpio.h"
>> +#include "hw/misc/unimp.h"
>>
>>   #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
>>   #define BCM2835_PERIPHERALS(obj) \
>> @@ -37,6 +38,10 @@ typedef struct BCM2835PeripheralState {
>>       MemoryRegion ram_alias[4];
>>       qemu_irq irq, fiq;
>>
>> +    UnimplementedDeviceState systmr;
>> +    UnimplementedDeviceState armtmr;
>> +    UnimplementedDeviceState cprman;
>> +    UnimplementedDeviceState a2w;
>>       PL011State uart0;
>>       BCM2835AuxState aux;
>>       BCM2835FBState fb;
>> @@ -48,6 +53,16 @@ typedef struct BCM2835PeripheralState {
>>       SDHCIState sdhci;
>>       BCM2835SDHostState sdhost;
>>       BCM2835GpioState gpio;
>> +    UnimplementedDeviceState i2s;
>> +    UnimplementedDeviceState spi[1];
>> +    UnimplementedDeviceState i2c[3];
>> +    UnimplementedDeviceState otp;
>> +    UnimplementedDeviceState dbus;
>> +    UnimplementedDeviceState ave0;
>> +    UnimplementedDeviceState bscsl;
>> +    UnimplementedDeviceState smi;
>> +    UnimplementedDeviceState dwc2;
>> +    UnimplementedDeviceState sdramc;
>>   } BCM2835PeripheralState;
>>
>>   #endif /* BCM2835_PERIPHERALS_H */
>> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
>> index 66969fac5d..cdcbca943f 100644
>> --- a/include/hw/arm/raspi_platform.h
>> +++ b/include/hw/arm/raspi_platform.h
>> @@ -38,6 +38,8 @@
>>                                                         * Doorbells & Mailboxes */
>>   #define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
>>   #define CM_OFFSET               0x101000 /* Clock Management */
>> +#define A2W_OFFSET              0x102000 /* Reset controller */
>> +#define AVS_OFFSET              0x103000 /* Audio Video Standard */
>>   #define RNG_OFFSET              0x104000
>>   #define GPIO_OFFSET             0x200000
>>   #define UART0_OFFSET            0x201000
>> @@ -45,11 +47,17 @@
>>   #define I2S_OFFSET              0x203000
>>   #define SPI0_OFFSET             0x204000
>>   #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
>> +#define OTP_OFFSET              0x20f000
>> +#define BSC_SL_OFFSET           0x214000 /* SPI slave */
>>   #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
>>   #define EMMC1_OFFSET            0x300000
>>   #define SMI_OFFSET              0x600000
>>   #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
>> +#define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
>> +#define DBUS_OFFSET             0x900000
>> +#define AVE0_OFFSET             0x910000
>>   #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
>> +#define SDRAMC_OFFSET           0xe00000
>>   #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
>>
>>   /* GPU interrupts */
>> --
>> 2.20.1
>>
>>

