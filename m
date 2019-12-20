Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C4C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6C82067C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTB4Eiwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6C82067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHsf-0002NI-8M
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iiHre-0001rq-LK
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iiHrb-0006FM-4S
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:58:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38927
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iiHra-000660-JN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576846716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxRaUKbbs3Qzc8YCQbtGUS57qEYQjfIsGyBA6LyFbGM=;
 b=LTB4Eiwj72LNH2q6uSujtozO88xvq5XpFeOHpaIUBFZySrOZjlbCUNsZEA2OSVX2z+XN3A
 tboUUodEv0VIF+ZWuUc48w1hzpU1BADun9YKZHAN2Y+3EOPkyZx0wsS5vCh/RLhAlxnYFe
 nJaTQmgUsJWfYhabs6qTELOKOA7WKsY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-I1TKZuvaNXyXhamEAuaAZw-1; Fri, 20 Dec 2019 07:58:35 -0500
Received: by mail-ed1-f70.google.com with SMTP id ck15so5793188edb.6
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VJh2z9Rkdt/T8+8tQ1uR/a48BCVzvie/7khpiWQg1Tk=;
 b=SqXnHjXRgAo1x4fWcSl0t9Rbk51GPytf3lVk5JhMK9j2d/486Iz2GNlyCDJ92NiTBe
 dxtctdlpvkt9zmxavC5mIrDcTlEzLDTx58sstTQ+gDKQAWsJ4VKgKp23THT2fQEn8CdL
 rixwKrkKqMS212hxrB0aTQ7fe1cToWVtSBg5B5YRxhfcRuF4eH1uS7eEuyeH5dj30jz1
 0ycFrLts8Tack/7ek9BPZ/radH6wpr8APEzB6qo+//EdjK6ZRaLbBJ/84Stsx/lj6VFy
 QaXcrY9pOxxXjGqZS4dWIYrJ9JIC5oRyYTFD2HGOL1Rbfj91J//b+8qQT6cita/t8DWG
 MzzA==
X-Gm-Message-State: APjAAAXQG36I3KI44YcVoRAVaZCWceIfWAqjTXaZ7W/cgroT3qTBIb8J
 hWRbpAIq2lOD00ZZrS6iqKBaHSF+fV4bRaaLfzLm72Cbs51Qs8T8Q4zkY2wR1f+3DXPlIR+V3UG
 7QjeVOeQIfCfi0mE=
X-Received: by 2002:a17:906:3591:: with SMTP id
 o17mr16356853ejb.209.1576846712828; 
 Fri, 20 Dec 2019 04:58:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxsJjYiy1mfPdlc4udQNw80G7s/3Fc6jHu0CZmdP3q6+9mN5FiOnSOUD/0dmJ9CRDhbOibsdA==
X-Received: by 2002:a17:906:3591:: with SMTP id
 o17mr16356805ejb.209.1576846712411; 
 Fri, 20 Dec 2019 04:58:32 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id e13sm1006135eje.87.2019.12.20.04.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2019 04:58:31 -0800 (PST)
Subject: Re: [RFC PATCH 06/10] hw/avr: Add ATmega microcontrollers
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
 <20191128015030.27543-7-f4bug@amsat.org> <20191220110917.3fccb284@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c8361b39-478e-ceec-0ea1-cc3c9ce8d6c9@redhat.com>
Date: Fri, 20 Dec 2019 13:58:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220110917.3fccb284@redhat.com>
Content-Language: en-US
X-MC-Unique: I1TKZuvaNXyXhamEAuaAZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 12/20/19 11:09 AM, Igor Mammedov wrote:
> On Thu, 28 Nov 2019 02:50:26 +0100
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>=20
>> Add famous ATmega MCUs:
>>
>> - middle range: ATmega168 and ATmega328
>> - high range: ATmega1280 and ATmega2560
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   hw/avr/atmega.h      |  58 +++++++
>>   hw/avr/atmega.c      | 379 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/avr/Makefile.objs |   1 +
>>   3 files changed, 438 insertions(+)
>>   create mode 100644 hw/avr/atmega.h
>>   create mode 100644 hw/avr/atmega.c
>>
>> diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
>> new file mode 100644
>> index 0000000000..d22d90a962
>> --- /dev/null
>> +++ b/hw/avr/atmega.h
>> @@ -0,0 +1,58 @@
>> +/*
>> + * QEMU ATmega MCU
>> + *
>> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
>> + *
>> + * This work is licensed under the terms of the GNU GPLv2 or later.
>> + * See the COPYING file in the top-level directory.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_AVR_ATMEGA_H
>> +#define HW_AVR_ATMEGA_H
>> +
>> +#include "hw/char/avr_usart.h"
>> +#include "hw/char/avr_usart.h"
>> +#include "hw/timer/avr_timer16.h"
>> +#include "hw/misc/avr_mask.h"
>> +#include "target/avr/cpu.h"
>> +
>> +#define TYPE_ATMEGA     "ATmega"
>> +#define TYPE_ATMEGA168  "ATmega168"
>> +#define TYPE_ATMEGA328  "ATmega328"
>> +#define TYPE_ATMEGA1280 "ATmega1280"
>> +#define TYPE_ATMEGA2560 "ATmega2560"
>> +#define ATMEGA(obj)     OBJECT_CHECK(AtmegaState, (obj), TYPE_ATMEGA)
>> +
>> +#define USART_MAX 4
>> +#define TIMER_MAX 6
>> +
>> +typedef struct AtmegaState {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +    /*< public >*/
>> +
>> +    AVRCPU cpu;
>> +    MemoryRegion flash;
>> +    MemoryRegion eeprom;
>> +    MemoryRegion sram;
>> +    DeviceState *io;
>> +    AVRMaskState pwr[2];
>> +    AVRUsartState usart[USART_MAX];
>> +    AVRTimer16State timer[TIMER_MAX];
>> +    uint64_t xtal_freq_hz;
>> +} AtmegaState;
>> +
>> +typedef struct AtmegaInfo AtmegaInfo;
>> +
>> +typedef struct AtmegaClass {
>> +    SysBusDeviceClass parent_class;
>> +    const AtmegaInfo *info;
>> +} AtmegaClass;
>> +
>> +#define ATMEGA_CLASS(klass) \
>> +    OBJECT_CLASS_CHECK(AtmegaClass, (klass), TYPE_ATMEGA)
>> +#define ATMEGA_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(AtmegaClass, (obj), TYPE_ATMEGA)
>> +
>> +#endif /* HW_AVR_ATMEGA_H */
>> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
>> new file mode 100644
>> index 0000000000..1f1b1246ef
>> --- /dev/null
>> +++ b/hw/avr/atmega.c
>> @@ -0,0 +1,379 @@
>> +/*
>> + * QEMU ATmega MCU
>> + *
>> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
>> + *
>> + * This work is licensed under the terms of the GNU GPLv2 or later.
>> + * See the COPYING file in the top-level directory.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/module.h"
>> +#include "qemu/units.h"
>> +#include "qapi/error.h"
>> +#include "exec/memory.h"
>> +#include "exec/address-spaces.h"
>> +#include "sysemu/sysemu.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/boards.h" /* FIXME memory_region_allocate_system_memory fo=
r sram */
>> +#include "hw/misc/unimp.h"
>> +#include "atmega.h"
>> +
>> +enum AtmegaIrq {
>> +    USART0_RXC_IRQ, USART0_DRE_IRQ, USART0_TXC_IRQ,
>> +    USART1_RXC_IRQ, USART1_DRE_IRQ, USART1_TXC_IRQ,
>> +    USART2_RXC_IRQ, USART2_DRE_IRQ, USART2_TXC_IRQ,
>> +    USART3_RXC_IRQ, USART3_DRE_IRQ, USART3_TXC_IRQ,
>> +    TIMER0_CAPT_IRQ, TIMER0_COMPA_IRQ, TIMER0_COMPB_IRQ,
>> +        TIMER0_COMPC_IRQ, TIMER0_OVF_IRQ,
>> +    TIMER1_CAPT_IRQ, TIMER1_COMPA_IRQ, TIMER1_COMPB_IRQ,
>> +        TIMER1_COMPC_IRQ, TIMER1_OVF_IRQ,
>> +    TIMER2_CAPT_IRQ, TIMER2_COMPA_IRQ, TIMER2_COMPB_IRQ,
>> +        TIMER2_COMPC_IRQ, TIMER2_OVF_IRQ,
>> +    TIMER3_CAPT_IRQ, TIMER3_COMPA_IRQ, TIMER3_COMPB_IRQ,
>> +        TIMER3_COMPC_IRQ, TIMER3_OVF_IRQ,
>> +    TIMER4_CAPT_IRQ, TIMER4_COMPA_IRQ, TIMER4_COMPB_IRQ,
>> +        TIMER4_COMPC_IRQ, TIMER4_OVF_IRQ,
>> +    TIMER5_CAPT_IRQ, TIMER5_COMPA_IRQ, TIMER5_COMPB_IRQ,
>> +        TIMER5_COMPC_IRQ, TIMER5_OVF_IRQ,
>> +};
>> +#define IRQ_MAX             64
>> +
>> +#define USART_RXC_IRQ(n)    (3 * n + USART0_RXC_IRQ)
>> +#define USART_DRE_IRQ(n)    (3 * n + USART0_DRE_IRQ)
>> +#define USART_TXC_IRQ(n)    (3 * n + USART0_TXC_IRQ)
>> +#define TIMER_CAPT_IRQ(n)   (5 * n + TIMER0_CAPT_IRQ)
>> +#define TIMER_COMPA_IRQ(n)  (5 * n + TIMER0_COMPA_IRQ)
>> +#define TIMER_COMPB_IRQ(n)  (5 * n + TIMER0_COMPB_IRQ)
>> +#define TIMER_COMPC_IRQ(n)  (5 * n + TIMER0_COMPC_IRQ)
>> +#define TIMER_OVF_IRQ(n)    (5 * n + TIMER0_OVF_IRQ)
>> +
>> +static const uint8_t irq168_328[IRQ_MAX] =3D {
>> +    [TIMER2_COMPA_IRQ]      =3D 8,
>> +    [TIMER2_COMPB_IRQ]      =3D 9,
>> +    [TIMER2_OVF_IRQ]        =3D 10,
>> +    [TIMER1_CAPT_IRQ]       =3D 11,
>> +    [TIMER1_COMPA_IRQ]      =3D 12,
>> +    [TIMER1_COMPB_IRQ]      =3D 13,
>> +    [TIMER1_OVF_IRQ]        =3D 14,
>> +    [TIMER0_COMPA_IRQ]      =3D 15,
>> +    [TIMER0_COMPB_IRQ]      =3D 16,
>> +    [TIMER0_OVF_IRQ]        =3D 17,
>> +    [USART0_RXC_IRQ]        =3D 19,
>> +    [USART0_DRE_IRQ]        =3D 20,
>> +    [USART0_TXC_IRQ]        =3D 21,
>> +}, irq1280_2560[IRQ_MAX] =3D {
>> +    [TIMER2_COMPA_IRQ]      =3D 14,
>> +    [TIMER2_COMPB_IRQ]      =3D 15,
>> +    [TIMER2_OVF_IRQ]        =3D 16,
>> +    [TIMER1_CAPT_IRQ]       =3D 17,
>> +    [TIMER1_COMPA_IRQ]      =3D 18,
>> +    [TIMER1_COMPB_IRQ]      =3D 19,
>> +    [TIMER1_COMPC_IRQ]      =3D 20,
>> +    [TIMER1_OVF_IRQ]        =3D 21,
>> +    [TIMER0_COMPA_IRQ]      =3D 22,
>> +    [TIMER0_COMPB_IRQ]      =3D 23,
>> +    [TIMER0_OVF_IRQ]        =3D 24,
>> +    [USART0_RXC_IRQ]        =3D 26,
>> +    [USART0_DRE_IRQ]        =3D 27,
>> +    [USART0_TXC_IRQ]        =3D 28,
>> +    [TIMER3_CAPT_IRQ]       =3D 32,
>> +    [TIMER3_COMPA_IRQ]      =3D 33,
>> +    [TIMER3_COMPB_IRQ]      =3D 34,
>> +    [TIMER3_COMPC_IRQ]      =3D 35,
>> +    [TIMER3_OVF_IRQ]        =3D 36,
>> +    [USART1_RXC_IRQ]        =3D 37,
>> +    [USART1_DRE_IRQ]        =3D 38,
>> +    [USART1_TXC_IRQ]        =3D 39,
>> +    [USART2_RXC_IRQ]        =3D 52,
>> +    [USART2_DRE_IRQ]        =3D 53,
>> +    [USART2_TXC_IRQ]        =3D 54,
>> +    [USART3_RXC_IRQ]        =3D 55,
>> +    [USART3_DRE_IRQ]        =3D 56,
>> +    [USART3_TXC_IRQ]        =3D 57,
>> +};
>> +
>> +enum AtmegaPeripheralAddress {
>> +    USART0, USART1, USART2, USART3,
>> +    TIMER0, TIMER1, TIMER2, TIMER3, TIMER4, TIMER5,
>> +    DEV_MAX
>> +};
>> +
>> +#define USART_ADDR(n)       (n + USART0)
>> +#define TIMER_ADDR(n)       (n + TIMER0)
>> +
>> +typedef struct {
>> +    uint16_t addr;
>> +    uint16_t prr_addr;
>> +    uint8_t prr_bit;
>> +    /* timer specific */
>> +    uint16_t intmask_addr;
>> +    uint16_t intflag_addr;
>> +    bool is_timer16;
>> +} peripheral_cfg;
>> +
>> +static const peripheral_cfg dev168_328[DEV_MAX] =3D {
>> +    [TIMER0]        =3D {  0x24, 0x64, 5, 0x6e, 0x35, false },
>> +    [TIMER1]        =3D {  0x80, 0x64, 3, 0x6f, 0x36, true },
>> +    [TIMER2]        =3D {  0xb0, 0x64, 6, 0x70, 0x37, false },
>> +    [USART0]        =3D {  0xc0, 0x64, 1 },
>> +}, dev1280_2560[DEV_MAX] =3D {
>> +    [TIMER0]        =3D {  0x24, 0x64, 5, 0x6e, 0x35, false },
>> +    [TIMER1]        =3D {  0x80, 0x64, 3, 0x6f, 0x36, true },
>> +    [TIMER3]        =3D {  0x90, 0x65, 3, 0x71, 0x38, true },
>> +    [TIMER4]        =3D {  0xa0, 0x65, 4, 0x72, 0x39, true },
>> +    [TIMER2]        =3D {  0xb0, 0x64, 6, 0x70, 0x37, false },
>> +    [USART0]        =3D {  0xc0, 0x64, 1 },
>> +    [USART1]        =3D {  0xc8, 0x65, 0 },
>> +    [USART2]        =3D {  0xd0, 0x65, 1 },
>> +    [TIMER5]        =3D { 0x120, 0x65, 5, 0x73, 0x3a, true },
>> +    [USART3]        =3D { 0x130, 0x65, 2 },
>> +};
>> +
>> +struct AtmegaInfo {
>> +    const char *uc_name;
>> +    const char *cpu_type;
>> +    size_t flash_size;
>> +    size_t eeprom_size;
>> +    size_t sram_size;
>> +    size_t io_size;
>> +    size_t uart_count;
>> +    size_t timer_count;
>> +    size_t gpio_count;
>> +    size_t adc_count;
>> +    const uint8_t *irq;
>> +    const peripheral_cfg *dev;
>> +};
>> +
>> +static const AtmegaInfo atmega_mcu[] =3D {
>> +    {
>> +        .uc_name =3D TYPE_ATMEGA168,
>> +        .cpu_type =3D AVR_CPU_TYPE_NAME("avr5"),
>> +        .flash_size =3D 16 * KiB,
>> +        .eeprom_size =3D 512,
>> +        .sram_size =3D 1 * KiB,
>> +        .io_size =3D 256,
>> +        .uart_count =3D 1,
>> +        .gpio_count =3D 23,
>> +        .adc_count =3D 6,
>> +        .irq =3D irq168_328,
>> +        .dev =3D dev168_328,
>> +    },
>> +    {
>> +        .uc_name =3D TYPE_ATMEGA328,
>> +        .cpu_type =3D AVR_CPU_TYPE_NAME("avr5"),
>> +        .flash_size =3D 32 * KiB,
>> +        .eeprom_size =3D 1 * KiB,
>> +        .sram_size =3D 2 * KiB,
>> +        .io_size =3D 256,
>> +        .uart_count =3D 1,
>> +        .timer_count =3D 3,
>> +        .gpio_count =3D 23,
>> +        .adc_count =3D 6,
>> +        .irq =3D irq168_328,
>> +        .dev =3D dev168_328,
>> +    },
>> +    {
>> +        .uc_name =3D TYPE_ATMEGA1280,
>> +        .cpu_type =3D AVR_CPU_TYPE_NAME("avr6"),
>> +        .flash_size =3D 128 * KiB,
>> +        .eeprom_size =3D 4 * KiB,
>> +        .sram_size =3D 8 * KiB,
>> +        .io_size =3D 512,
>> +        .uart_count =3D 4,
>> +        .timer_count =3D 6,
>> +        .gpio_count =3D 86,
>> +        .adc_count =3D 16,
>> +        .irq =3D irq1280_2560,
>> +        .dev =3D dev1280_2560,
>> +    },
>> +    {
>> +        .uc_name =3D TYPE_ATMEGA2560,
>> +        .cpu_type =3D AVR_CPU_TYPE_NAME("avr6"),
>> +        .flash_size =3D 256 * KiB,
>> +        .eeprom_size =3D 4 * KiB,
>> +        .sram_size =3D 8 * KiB,
>> +        .io_size =3D 512,
>> +        .uart_count =3D 4,
>> +        .timer_count =3D 6,
>> +        .gpio_count =3D 54,
>> +        .adc_count =3D 16,
>> +        .irq =3D irq1280_2560,
>> +        .dev =3D dev1280_2560,
>> +    },
>> +};
>> +
>> +static void connect_nonnull_irq(SysBusDevice *sbd, DeviceState *dev,
>> +                                int n, int irq)
>> +{
>> +    if (irq) {
>> +        sysbus_connect_irq(sbd, n, qdev_get_gpio_in(dev, irq));
>> +    }
>> +}
>> +
>> +static void connect_pr_irq(AtmegaState *s, const AtmegaInfo *info,
>> +                           DeviceState *dev, int index)
>> +{
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pwr[info->dev[index].prr_addr=
 & 1]),
>> +                       info->dev[index].prr_bit,
>> +                       qdev_get_gpio_in(dev, 0));
>> +}
>> +
>> +static void atmega_realize(DeviceState *dev, Error **errp)
>> +{
>> +    AtmegaState *s =3D ATMEGA(dev);
>> +    AtmegaClass *bc =3D ATMEGA_GET_CLASS(dev);
>> +    const AtmegaInfo *info =3D bc->info;
>> +    DeviceState *cpudev;
>> +    SysBusDevice *sbd;
>> +    Error *err =3D NULL;
>> +    char *devname;
>> +    size_t i;
>> +
>> +    if (!s->xtal_freq_hz) {
>> +        error_setg(errp, "\"xtal-frequency-hz\" property must be provid=
ed.");
>> +        return;
>> +    }
>> +
>> +    /* CPU */
>> +    object_initialize_child(OBJECT(dev), "cpu", &s->cpu, sizeof(s->cpu)=
,
>> +                            info->cpu_type, &err, NULL);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &error_=
abort);
>> +    cpudev =3D DEVICE(&s->cpu);
>> +
>> +    /* SRAM */
>> +    memory_region_allocate_system_memory(&s->sram, OBJECT(dev),
>> +                                         "sram", info->sram_size);
> with main RAM conversion to hostmem backend, this API will go away
> and RAM memory region will be allocated by generic machine code
> and shall be treated as backend. Users would be able to access it
> via MachineState::ram memory region.
>=20
> Meanwhile I'd suggest to move this line to arduino_machine_init()
> and pass it to MCU as a link property.

Thanks for reviewing this patch.

I think this MCU and few ARM SoC are good case for your RAM conversion.

These chipsets provide onboard RAM (SRAM). This amount of SRAM is enough=20
to run u-boot, FreeRTOS, ... Some ARM boards add DRAM, usually larger=20
than the SRAM amount.

The previous recomendation was to use=20
memory_region_allocate_system_memory() only once, but on the biggest=20
chunk of memory, for performance reasons.

In the previous cases, the RAM is not added by the board/machine, but is=20
present in the MCU/SoC. This looks incorrect to me to allocate the RAM=20
in the board/machine and pass it to the MCU/SoC.

You are saying the machine/board code will have to ask its children how=20
many ram they need, then allocate, then pass it to each?

> Also use MachineState::ram_size and add check that it matches mc->default=
_ram_size.
> Ex: https://github.com/imammedo/qemu/commit/241c65d506ccba1e0239a2bc0632d=
7dc9c3517c1
>=20
>> +    memory_region_add_subregion(get_system_memory(),
>> +                                OFFSET_DATA + 0x200, &s->sram);
>> +
>> +    /* Flash */
>> +    memory_region_init_rom(&s->flash, OBJECT(dev),
>> +                           "flash", info->flash_size, &error_fatal);
>> +    memory_region_add_subregion(get_system_memory(), OFFSET_CODE, &s->f=
lash);
>> +
>> +    /* I/O */
>> +    s->io =3D qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);
>> +    qdev_prop_set_string(s->io, "name", "I/O");
>> +    qdev_prop_set_uint64(s->io, "size", info->io_size);
>> +    qdev_init_nofail(s->io);
>> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, OFFSET_DATA, -123=
4);
>> +
>> +    /* Power */
>> +    for (i =3D 0; i < ARRAY_SIZE(s->pwr); i++) {
>> +        devname =3D g_strdup_printf("pwr%zu", i);
>> +        object_initialize_child(OBJECT(dev), devname,
>> +                                &s->pwr[i], sizeof(s->pwr[i]),
>> +                                TYPE_AVR_MASK, &error_abort, NULL);
>> +        object_property_set_bool(OBJECT(&s->pwr[i]), true, "realized",
>> +                                 &error_abort);
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->pwr[i]), 0, OFFSET_DATA + 0x=
64 + i);
>> +        g_free(devname);
>> +    }
>> +
>> +    /* USART */
>> +    for (i =3D 0; i < info->uart_count; i++) {
>> +        devname =3D g_strdup_printf("usart%zu", i);
>> +        object_initialize_child(OBJECT(dev), devname,
>> +                                &s->usart[i], sizeof(s->usart[i]),
>> +                                TYPE_AVR_USART, &error_abort, NULL);
>> +        qdev_prop_set_chr(DEVICE(&s->usart[i]), "chardev", serial_hd(i)=
);
>> +        object_property_set_bool(OBJECT(&s->usart[i]), true, "realized"=
,
>> +                                 &error_abort);
>> +        sbd =3D SYS_BUS_DEVICE(&s->usart[i]);
>> +        sysbus_mmio_map(sbd, 0, OFFSET_DATA + info->dev[USART_ADDR(i)].=
addr);
>> +        connect_nonnull_irq(sbd, cpudev, 0, info->irq[USART_RXC_IRQ(i)]=
);
>> +        connect_nonnull_irq(sbd, cpudev, 1, info->irq[USART_DRE_IRQ(i)]=
);
>> +        connect_nonnull_irq(sbd, cpudev, 2, info->irq[USART_TXC_IRQ(i)]=
);
>> +        connect_pr_irq(s, info, DEVICE(&s->usart[i]), 0);
>> +        g_free(devname);
>> +    }
>> +
>> +    /* Timer */
>> +    for (i =3D 0; i < info->timer_count; i++) {
>> +        int idx =3D TIMER_ADDR(i);
>> +        if (!info->dev[idx].is_timer16) {
>> +            create_unimplemented_device("avr-timer8",
>> +                                        OFFSET_DATA + info->dev[idx].ad=
dr, 7);
>> +            create_unimplemented_device("avr-timer8-intmask",
>> +                                        OFFSET_DATA
>> +                                        + info->dev[idx].intmask_addr, =
1);
>> +            create_unimplemented_device("avr-timer8-intflag",
>> +                                        OFFSET_DATA
>> +                                        + info->dev[idx].intflag_addr, =
1);
>> +            continue;
>> +        }
>> +        devname =3D g_strdup_printf("timer%zu", i);
>> +        object_initialize_child(OBJECT(dev), devname,
>> +                                &s->timer[i], sizeof(s->timer[i]),
>> +                                TYPE_AVR_TIMER16, &error_abort, NULL);
>> +        object_property_set_uint(OBJECT(&s->timer[i]), s->xtal_freq_hz,
>> +                                 "cpu-frequency-hz", &error_abort);
>> +        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized"=
,
>> +                                 &error_abort);
>> +        sbd =3D SYS_BUS_DEVICE(&s->timer[i]);
>> +        sysbus_mmio_map(sbd, 0, OFFSET_DATA + info->dev[idx].addr);
>> +        sysbus_mmio_map(sbd, 1, OFFSET_DATA + info->dev[idx].intmask_ad=
dr);
>> +        sysbus_mmio_map(sbd, 2, OFFSET_DATA + info->dev[idx].intflag_ad=
dr);
>> +        connect_nonnull_irq(sbd, cpudev, 0, info->irq[TIMER_CAPT_IRQ(i)=
]);
>> +        connect_nonnull_irq(sbd, cpudev, 1, info->irq[TIMER_COMPA_IRQ(i=
)]);
>> +        connect_nonnull_irq(sbd, cpudev, 2, info->irq[TIMER_COMPB_IRQ(i=
)]);
>> +        connect_nonnull_irq(sbd, cpudev, 3, info->irq[TIMER_COMPC_IRQ(i=
)]);
>> +        connect_nonnull_irq(sbd, cpudev, 4, info->irq[TIMER_OVF_IRQ(i)]=
);
>> +        connect_pr_irq(s, info, DEVICE(&s->timer[i]), 0);
>> +        g_free(devname);
>> +    }
>> +}
>> +
>> +static Property atmega_props[] =3D {
>> +    DEFINE_PROP_UINT64("xtal-frequency-hz", AtmegaState,
>> +                       xtal_freq_hz, 0),
>> +    DEFINE_PROP_END_OF_LIST()
>> +};
>> +
>> +static void atmega_class_init(ObjectClass *oc, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
>> +    AtmegaClass *bc =3D ATMEGA_CLASS(oc);
>> +
>> +    bc->info =3D data;
>> +    dc->realize =3D atmega_realize;
>> +    dc->props =3D atmega_props;
>> +    /* Reason: Mapped at fixed location on the system bus */
>> +    dc->user_creatable =3D false;
>> +}
>> +
>> +static const TypeInfo atmega_type_info =3D {
>> +    .name =3D TYPE_ATMEGA,
>> +    .parent =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(AtmegaState),
>> +    .class_size =3D sizeof(AtmegaClass),
>> +    .abstract =3D true,
>> +};
>> +
>> +static void atmega_register_types(void)
>> +{
>> +    size_t i;
>> +
>> +    type_register_static(&atmega_type_info);
>> +    for (i =3D 0; i < ARRAY_SIZE(atmega_mcu); i++) {
>> +        assert(atmega_mcu[i].io_size <=3D 0x200);
>> +        assert(atmega_mcu[i].uart_count <=3D USART_MAX);
>> +        assert(atmega_mcu[i].timer_count <=3D TIMER_MAX);
>> +        TypeInfo ti =3D {
>> +            .name =3D atmega_mcu[i].uc_name,
>> +            .parent =3D TYPE_ATMEGA,
>> +            .class_init =3D atmega_class_init,
>> +            .class_data =3D (void *) &atmega_mcu[i],
>> +        };
>> +        type_register(&ti);
>> +    }
>> +}
>> +
>> +type_init(atmega_register_types)
>> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
>> index 626b7064b3..4b6b911820 100644
>> --- a/hw/avr/Makefile.objs
>> +++ b/hw/avr/Makefile.objs
>> @@ -1 +1,2 @@
>>   obj-y +=3D sample.o
>> +obj-y +=3D atmega.o
>=20
>=20


