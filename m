Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA54C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD5E214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wonlk1DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD5E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivzJh-0000jO-9Y
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ivzIt-0008SR-IC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ivzIq-0005d0-Q7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:59:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34516
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ivzIq-0005cd-My
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580111964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3+SHXPeAj57hnU7w/YRi8WR7UKscwicOPv0wTFClrQ=;
 b=Wonlk1DRZNQVpAn85nhqaEHpDHUiY9WD7AO0ot2M9hnyt3Qh4pwBwO3HGEXopJkPGJb2wN
 +CMTyLtBTMhplO4aPCGoDsDAqcm0Q0jitU1kpKrUWDFoprCVrrJ9bza8WyIKj6oGu8u3Qv
 TvOuAtSef5NVrG9182EOWoBWKSmyUF8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-uAm-KHpePIe31CdRYdApqw-1; Mon, 27 Jan 2020 02:59:09 -0500
Received: by mail-wr1-f71.google.com with SMTP id z15so5736985wrw.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2020 23:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=92grBS+Z47aY46bjfiWDPIgbE1GVroRW3nIFN1vUYdk=;
 b=czbWtHIsB0DvdMWJmu7CVBszvZnES1o1EEp0cmM/iVstaao0XKZ/gGGpw3hwk3d79x
 72Tn2uTeO2RWVueZIUOtzMapHeT+gvevKq703vtnCooqACErkI2C+i2y2f+2OHKR09xd
 lmyayYph5S4Cs/8klo6yUBxczZVSseMmE5PF1bw28DH71relYS/zbJPaTkuysuqxtTYh
 SA/BgJ4vIVdQ1bGywcHBgOehfSB7rRaN5wdeBwqXYTu3tKEtMQNEckJqH7E8+jJ07qXW
 5W30OBlFAWSuABip7AFqCqmiiHCiACwDRc7eXcvjth/z1XGq9hRojRhmujLLKRviSeOY
 PNtA==
X-Gm-Message-State: APjAAAWcUz3mA9GPz5UPzGCLDztEc3NnPCPPIhECraNXa1WUtwo65jWc
 UWjOHPI0tuzjjbkfHtjNFFCTN32tyZmoan6r2cKyXR3hfqhQAh85QsdgoWbghIVuvdV8K4zsUXJ
 BoloADXITVXYFs0s=
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr12354281wmj.170.1580111947542; 
 Sun, 26 Jan 2020 23:59:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyL5rSK8cNus/O7pt+ZnN/LGeTFKP56LsRTcPAY/Su5pW/22K18JAT6oNosQaB+X6nmwDV9lQ==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr12354242wmj.170.1580111947139; 
 Sun, 26 Jan 2020 23:59:07 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id e17sm2027961wma.12.2020.01.26.23.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2020 23:59:06 -0800 (PST)
Subject: Re: [PATCH rc2 20/25] hw/avr: Add some ATmega microcontrollers
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-21-f4bug@amsat.org>
 <CAL1e-=ht6NS_ZyGAh59V2HuQkoXm=pyEz20SUPzxQkFkU=iCsQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f27af2f-290b-2f07-b29d-9b7f18345cee@redhat.com>
Date: Mon, 27 Jan 2020 08:59:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ht6NS_ZyGAh59V2HuQkoXm=pyEz20SUPzxQkFkU=iCsQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: uAm-KHpePIe31CdRYdApqw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, "S.E.Harris@kent.ac.uk" <S.E.Harris@kent.ac.uk>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "mrolnik@gmail.com" <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/26/20 3:46 PM, Aleksandar Markovic wrote:
> On Friday, January 24, 2020, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
=20
> <mailto:f4bug@amsat.org>> wrote:
>=20
>     Add some microcontrollers from the megaAVR family (ATmega series):
>=20
>     - middle range: ATmega168 and ATmega328
>     - high range: ATmega1280 and ATmega2560
>=20
>     For product comparison:
>     https://www.microchip.com/wwwproducts/ProductCompare/ATmega168P/ATmeg=
a328P
>     <https://www.microchip.com/wwwproducts/ProductCompare/ATmega168P/ATme=
ga328P>
>     https://www.microchip.com/wwwproducts/ProductCompare/ATmega1280/ATmeg=
a2560
>     <https://www.microchip.com/wwwproducts/ProductCompare/ATmega1280/ATme=
ga2560>
>=20
>     Datasheets:
>     http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-1=
68A-PA-328-P-DS-DS40002061A.pdf
>     <http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-=
168A-PA-328-P-DS-DS40002061A.pdf>
>     http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-=
Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf
>     <http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR=
-Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf>
>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>     Message-Id: <20200120220107.17825-14-f4bug@amsat.org
>     <mailto:20200120220107.17825-14-f4bug@amsat.org>>
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
>     ---
>     rc2:
>     - Squashed Kconfig patch (Thomas)
>     - Correct SRAM base address
>     ---
>      =C2=A0hw/avr/atmel_atmega.h |=C2=A0 48 +++++
>      =C2=A0hw/avr/atmel_atmega.c | 470 ++++++++++++++++++++++++++++++++++=
++++++++
>      =C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +
>      =C2=A0hw/avr/Makefile.objs=C2=A0 |=C2=A0 =C2=A01 +
>      =C2=A04 files changed, 524 insertions(+)
>      =C2=A0create mode 100644 hw/avr/atmel_atmega.h
>      =C2=A0create mode 100644 hw/avr/atmel_atmega.c
>      =C2=A0create mode 100644 hw/avr/Kconfig
>=20
>=20
> This patch introduces a terminology confusion that will be difficult to=
=20
> eliminate once the code is in the tree.
>=20
> "AVR" is the name (or, if someone wishes, the common name prefix) of the=
=20
> family of all MCUs covered in this series. This is reflected in the=20
> existence of the directory "hw/avr", and this is, in my opinion fine.
>=20
> "Atmel" is the company that used to design AVR MCUs (there are hundreds=
=20
> of such MCUs). "Atmel" was acquired several=C2=A0years ago by another=20
> company, "Microchip". Trere is no element in AVR MCUs' docimentation=20
> that reffers to the producers (except title, copyright, etc). In all=20
> recent docs, "Atmel" is complely eradicated.
>=20
> Therefore, using the name of non-existant company "Atmel" is confusing,=
=20
> and, moreover, completely unnecessary. Please, remove references to=20
> "Atmel" from file names, and from the code.

I simply used "Atmel" because this is how I discovered this chips and=20
always called them by the Atmel brand. The Microchip acquisition is=20
quite recent. When I look for datasheet is I still write "Atmel=20
something" and eventually end on the microchip website.

IOW it was not a deliberate name, simply Microchip could not eradicate=20
"Atmel" from my memory =3D)

I'll rename these files at "atmega.{c,h}".

Thanks,

Phil.

>     diff --git a/hw/avr/atmel_atmega.h b/hw/avr/atmel_atmega.h
>     new file mode 100644
>     index 0000000000..391b8b1bf8
>     --- /dev/null
>     +++ b/hw/avr/atmel_atmega.h
>     @@ -0,0 +1,48 @@
>     +/*
>     + * QEMU ATmega MCU
>     + *
>     + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
>     + *
>     + * This work is licensed under the terms of the GNU GPLv2 or later.
>     + * See the COPYING file in the top-level directory.
>     + * SPDX-License-Identifier: GPL-2.0-or-later
>     + */
>     +
>     +#ifndef HW_AVR_ATMEL_ATMEGA_H
>     +#define HW_AVR_ATMEL_ATMEGA_H
>     +
>     +#include "hw/char/atmel_usart.h"
>     +#include "hw/timer/atmel_timer16.h"
>     +#include "hw/misc/atmel_power.h"
>     +#include "target/avr/cpu.h"
>     +
>     +#define TYPE_ATMEGA_MCU=C2=A0 =C2=A0 =C2=A0"ATmega"
>     +#define TYPE_ATMEGA168_MCU=C2=A0 "ATmega168"
>     +#define TYPE_ATMEGA328_MCU=C2=A0 "ATmega328"
>     +#define TYPE_ATMEGA1280_MCU "ATmega1280"
>     +#define TYPE_ATMEGA2560_MCU "ATmega2560"
>     +
>     +#define ATMEGA_MCU(obj) OBJECT_CHECK(AtmegaMcuState, (obj),
>     TYPE_ATMEGA_MCU)
>     +
>     +#define POWER_MAX 2
>     +#define USART_MAX 4
>     +#define TIMER_MAX 6
>     +#define GPIO_MAX 12
>     +
>     +typedef struct AtmegaMcuState {
>     +=C2=A0 =C2=A0 /*< private >*/
>     +=C2=A0 =C2=A0 SysBusDevice parent_obj;
>     +=C2=A0 =C2=A0 /*< public >*/
>     +
>     +=C2=A0 =C2=A0 AVRCPU cpu;
>     +=C2=A0 =C2=A0 MemoryRegion flash;
>     +=C2=A0 =C2=A0 MemoryRegion eeprom;
>     +=C2=A0 =C2=A0 MemoryRegion sram;
>     +=C2=A0 =C2=A0 DeviceState *io;
>     +=C2=A0 =C2=A0 AVRMaskState pwr[POWER_MAX];
>     +=C2=A0 =C2=A0 AVRUsartState usart[USART_MAX];
>     +=C2=A0 =C2=A0 AVRTimer16State timer[TIMER_MAX];
>     +=C2=A0 =C2=A0 uint64_t xtal_freq_hz;
>     +} AtmegaMcuState;
>     +
>     +#endif /* HW_AVR_ATMEL_ATMEGA_H */
>     diff --git a/hw/avr/atmel_atmega.c b/hw/avr/atmel_atmega.c
>     new file mode 100644
>     index 0000000000..790c374dee
>     --- /dev/null
>     +++ b/hw/avr/atmel_atmega.c
>     @@ -0,0 +1,470 @@
>     +/*
>     + * QEMU ATmega MCU
>     + *
>     + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
>     + *
>     + * This work is licensed under the terms of the GNU GPLv2 or later.
>     + * See the COPYING file in the top-level directory.
>     + * SPDX-License-Identifier: GPL-2.0-or-later
>     + */
>     +
>     +#include "qemu/osdep.h"
>     +#include "qemu/module.h"
>     +#include "qemu/units.h"
>     +#include "qapi/error.h"
>     +#include "exec/memory.h"
>     +#include "exec/address-spaces.h"
>     +#include "sysemu/sysemu.h"
>     +#include "hw/qdev-properties.h"
>     +#include "hw/sysbus.h"
>     +#include "hw/boards.h" /* FIXME
>     memory_region_allocate_system_memory for sram */
>     +#include "hw/misc/unimp.h"
>     +#include "atmel_atmega.h"
>     +
>     +enum AtmegaPeripheral {
>     +=C2=A0 =C2=A0 POWER0, POWER1,
>     +=C2=A0 =C2=A0 GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF,
>     +=C2=A0 =C2=A0 GPIOG, GPIOH, GPIOI, GPIOJ, GPIOK, GPIOL,
>     +=C2=A0 =C2=A0 USART0, USART1, USART2, USART3,
>     +=C2=A0 =C2=A0 TIMER0, TIMER1, TIMER2, TIMER3, TIMER4, TIMER5,
>     +=C2=A0 =C2=A0 PERIFMAX
>     +};
>     +
>     +#define GPIO(n)=C2=A0 =C2=A0 =C2=A0(n + GPIOA)
>     +#define USART(n)=C2=A0 =C2=A0 (n + USART0)
>     +#define TIMER(n)=C2=A0 =C2=A0 (n + TIMER0)
>     +#define POWER(n)=C2=A0 =C2=A0 (n + POWER0)
>     +
>     +typedef struct {
>     +=C2=A0 =C2=A0 uint16_t addr;
>     +=C2=A0 =C2=A0 enum AtmegaPeripheral power_index;
>     +=C2=A0 =C2=A0 uint8_t power_bit;
>     +=C2=A0 =C2=A0 /* timer specific */
>     +=C2=A0 =C2=A0 uint16_t intmask_addr;
>     +=C2=A0 =C2=A0 uint16_t intflag_addr;
>     +=C2=A0 =C2=A0 bool is_timer16;
>     +} peripheral_cfg;
>     +
>     +typedef struct AtmegaMcuClass {
>     +=C2=A0 =C2=A0 /*< private >*/
>     +=C2=A0 =C2=A0 SysBusDeviceClass parent_class;
>     +=C2=A0 =C2=A0 /*< public >*/
>     +=C2=A0 =C2=A0 const char *uc_name;
>     +=C2=A0 =C2=A0 const char *cpu_type;
>     +=C2=A0 =C2=A0 size_t flash_size;
>     +=C2=A0 =C2=A0 size_t eeprom_size;
>     +=C2=A0 =C2=A0 size_t sram_size;
>     +=C2=A0 =C2=A0 size_t io_size;
>     +=C2=A0 =C2=A0 size_t gpio_count;
>     +=C2=A0 =C2=A0 size_t adc_count;
>     +=C2=A0 =C2=A0 const uint8_t *irq;
>     +=C2=A0 =C2=A0 const peripheral_cfg *dev;
>     +} AtmegaMcuClass;
>     +
>     +#define ATMEGA_MCU_CLASS(klass) \
>     +=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(AtmegaMcuClass, (klass), TYPE_ATMEG=
A_MCU)
>     +#define ATMEGA_MCU_GET_CLASS(obj) \
>     +=C2=A0 =C2=A0 OBJECT_GET_CLASS(AtmegaMcuClass, (obj), TYPE_ATMEGA_MC=
U)
>     +
>     +static const peripheral_cfg dev168_328[PERIFMAX] =3D {
>     +=C2=A0 =C2=A0 [USART0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xc0, =
POWER0, 1 },
>     +=C2=A0 =C2=A0 [TIMER2]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xb0, =
POWER0, 6, 0x70, 0x37, false },
>     +=C2=A0 =C2=A0 [TIMER1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x80, =
POWER0, 3, 0x6f, 0x36, true },
>     +=C2=A0 =C2=A0 [POWER0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x64 }=
,
>     +=C2=A0 =C2=A0 [TIMER0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x44, =
POWER0, 5, 0x6e, 0x35, false },
>     +=C2=A0 =C2=A0 [GPIOD]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0=
x29 },
>     +=C2=A0 =C2=A0 [GPIOC]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0=
x26 },
>     +=C2=A0 =C2=A0 [GPIOB]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0=
x23 },
>     +}, dev1280_2560[PERIFMAX] =3D {
>     +=C2=A0 =C2=A0 [USART3]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D { 0x130, POWER=
1, 2 },
>     +=C2=A0 =C2=A0 [TIMER5]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D { 0x120, POWER=
1, 5, 0x73, 0x3a, true },
>     +=C2=A0 =C2=A0 [GPIOL]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D { 0x109 }=
,
>     +=C2=A0 =C2=A0 [GPIOK]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D { 0x106 }=
,
>     +=C2=A0 =C2=A0 [GPIOJ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D { 0x103 }=
,
>     +=C2=A0 =C2=A0 [GPIOH]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D { 0x100 }=
,
>     +=C2=A0 =C2=A0 [USART2]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xd0, =
POWER1, 1 },
>     +=C2=A0 =C2=A0 [USART1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xc8, =
POWER1, 0 },
>     +=C2=A0 =C2=A0 [USART0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xc0, =
POWER0, 1 },
>     +=C2=A0 =C2=A0 [TIMER2]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xb0, =
POWER0, 6, 0x70, 0x37, false }, /*
>     TODO async */
>     +=C2=A0 =C2=A0 [TIMER4]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xa0, =
POWER1, 4, 0x72, 0x39, true },
>     +=C2=A0 =C2=A0 [TIMER3]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x90, =
POWER1, 3, 0x71, 0x38, true },
>     +=C2=A0 =C2=A0 [TIMER1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x80, =
POWER0, 3, 0x6f, 0x36, true },
>     +=C2=A0 =C2=A0 [POWER1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x65 }=
,
>     +=C2=A0 =C2=A0 [POWER0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x64 }=
,
>     +=C2=A0 =C2=A0 [TIMER0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x44, =
POWER0, 5, 0x6e, 0x35, false },
>     +=C2=A0 =C2=A0 [GPIOG]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0=
x32 },
>     +=C2=A0 =C2=A0 [GPIOF]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0=
x2f },
>     +=C2=A0 =C2=A0 [GPIOE]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0=
x2c },
>     +=C2=A0 =C2=A0 [GPIOD]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0=
x29 },
>     +=C2=A0 =C2=A0 [GPIOC]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0=
x26 },
>     +=C2=A0 =C2=A0 [GPIOB]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0=
x23 },
>     +=C2=A0 =C2=A0 [GPIOA]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0=
x20 },
>     +};
>     +
>     +enum AtmegaIrq {
>     +=C2=A0 =C2=A0 USART0_RXC_IRQ, USART0_DRE_IRQ, USART0_TXC_IRQ,
>     +=C2=A0 =C2=A0 USART1_RXC_IRQ, USART1_DRE_IRQ, USART1_TXC_IRQ,
>     +=C2=A0 =C2=A0 USART2_RXC_IRQ, USART2_DRE_IRQ, USART2_TXC_IRQ,
>     +=C2=A0 =C2=A0 USART3_RXC_IRQ, USART3_DRE_IRQ, USART3_TXC_IRQ,
>     +=C2=A0 =C2=A0 TIMER0_CAPT_IRQ, TIMER0_COMPA_IRQ, TIMER0_COMPB_IRQ,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER0_COMPC_IRQ, TIMER0_OVF_IRQ,
>     +=C2=A0 =C2=A0 TIMER1_CAPT_IRQ, TIMER1_COMPA_IRQ, TIMER1_COMPB_IRQ,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER1_COMPC_IRQ, TIMER1_OVF_IRQ,
>     +=C2=A0 =C2=A0 TIMER2_CAPT_IRQ, TIMER2_COMPA_IRQ, TIMER2_COMPB_IRQ,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER2_COMPC_IRQ, TIMER2_OVF_IRQ,
>     +=C2=A0 =C2=A0 TIMER3_CAPT_IRQ, TIMER3_COMPA_IRQ, TIMER3_COMPB_IRQ,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER3_COMPC_IRQ, TIMER3_OVF_IRQ,
>     +=C2=A0 =C2=A0 TIMER4_CAPT_IRQ, TIMER4_COMPA_IRQ, TIMER4_COMPB_IRQ,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER4_COMPC_IRQ, TIMER4_OVF_IRQ,
>     +=C2=A0 =C2=A0 TIMER5_CAPT_IRQ, TIMER5_COMPA_IRQ, TIMER5_COMPB_IRQ,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER5_COMPC_IRQ, TIMER5_OVF_IRQ,
>     +=C2=A0 =C2=A0 IRQ_COUNT
>     +};
>     +
>     +#define USART_IRQ_COUNT=C2=A0 =C2=A0 =C2=A03
>     +#define USART_RXC_IRQ(n)=C2=A0 =C2=A0 (n * USART_IRQ_COUNT + USART0_=
RXC_IRQ)
>     +#define USART_DRE_IRQ(n)=C2=A0 =C2=A0 (n * USART_IRQ_COUNT + USART0_=
DRE_IRQ)
>     +#define USART_TXC_IRQ(n)=C2=A0 =C2=A0 (n * USART_IRQ_COUNT + USART0_=
TXC_IRQ)
>     +#define TIMER_IRQ_COUNT=C2=A0 =C2=A0 =C2=A05
>     +#define TIMER_CAPT_IRQ(n)=C2=A0 =C2=A0(n * TIMER_IRQ_COUNT + TIMER0_=
CAPT_IRQ)
>     +#define TIMER_COMPA_IRQ(n)=C2=A0 (n * TIMER_IRQ_COUNT + TIMER0_COMPA=
_IRQ)
>     +#define TIMER_COMPB_IRQ(n)=C2=A0 (n * TIMER_IRQ_COUNT + TIMER0_COMPB=
_IRQ)
>     +#define TIMER_COMPC_IRQ(n)=C2=A0 (n * TIMER_IRQ_COUNT + TIMER0_COMPC=
_IRQ)
>     +#define TIMER_OVF_IRQ(n)=C2=A0 =C2=A0 (n * TIMER_IRQ_COUNT + TIMER0_=
OVF_IRQ)
>     +
>     +static const uint8_t irq168_328[IRQ_COUNT] =3D {
>     +=C2=A0 =C2=A0 [TIMER2_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 8,
>     +=C2=A0 =C2=A0 [TIMER2_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 9,
>     +=C2=A0 =C2=A0 [TIMER2_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 10,
>     +=C2=A0 =C2=A0 [TIMER1_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 11,
>     +=C2=A0 =C2=A0 [TIMER1_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 12,
>     +=C2=A0 =C2=A0 [TIMER1_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 13,
>     +=C2=A0 =C2=A0 [TIMER1_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 14,
>     +=C2=A0 =C2=A0 [TIMER0_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 15,
>     +=C2=A0 =C2=A0 [TIMER0_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 16,
>     +=C2=A0 =C2=A0 [TIMER0_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 17,
>     +=C2=A0 =C2=A0 [USART0_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 19,
>     +=C2=A0 =C2=A0 [USART0_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 20,
>     +=C2=A0 =C2=A0 [USART0_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 21,
>     +}, irq1280_2560[IRQ_COUNT] =3D {
>     +=C2=A0 =C2=A0 [TIMER2_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 14,
>     +=C2=A0 =C2=A0 [TIMER2_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 15,
>     +=C2=A0 =C2=A0 [TIMER2_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 16,
>     +=C2=A0 =C2=A0 [TIMER1_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 17,
>     +=C2=A0 =C2=A0 [TIMER1_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 18,
>     +=C2=A0 =C2=A0 [TIMER1_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 19,
>     +=C2=A0 =C2=A0 [TIMER1_COMPC_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 20,
>     +=C2=A0 =C2=A0 [TIMER1_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 21,
>     +=C2=A0 =C2=A0 [TIMER0_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 22,
>     +=C2=A0 =C2=A0 [TIMER0_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 23,
>     +=C2=A0 =C2=A0 [TIMER0_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 24,
>     +=C2=A0 =C2=A0 [USART0_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 26,
>     +=C2=A0 =C2=A0 [USART0_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 27,
>     +=C2=A0 =C2=A0 [USART0_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 28,
>     +=C2=A0 =C2=A0 [TIMER3_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 32,
>     +=C2=A0 =C2=A0 [TIMER3_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 33,
>     +=C2=A0 =C2=A0 [TIMER3_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 34,
>     +=C2=A0 =C2=A0 [TIMER3_COMPC_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 35,
>     +=C2=A0 =C2=A0 [TIMER3_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 36,
>     +=C2=A0 =C2=A0 [USART1_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 37,
>     +=C2=A0 =C2=A0 [USART1_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 38,
>     +=C2=A0 =C2=A0 [USART1_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 39,
>     +=C2=A0 =C2=A0 [TIMER4_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 42,
>     +=C2=A0 =C2=A0 [TIMER4_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 43,
>     +=C2=A0 =C2=A0 [TIMER4_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 44,
>     +=C2=A0 =C2=A0 [TIMER4_COMPC_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 45,
>     +=C2=A0 =C2=A0 [TIMER4_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 46,
>     +=C2=A0 =C2=A0 [TIMER5_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 47,
>     +=C2=A0 =C2=A0 [TIMER5_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 48,
>     +=C2=A0 =C2=A0 [TIMER5_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 49,
>     +=C2=A0 =C2=A0 [TIMER5_COMPC_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 50,
>     +=C2=A0 =C2=A0 [TIMER5_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 51,
>     +=C2=A0 =C2=A0 [USART2_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 52,
>     +=C2=A0 =C2=A0 [USART2_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 53,
>     +=C2=A0 =C2=A0 [USART2_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 54,
>     +=C2=A0 =C2=A0 [USART3_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 55,
>     +=C2=A0 =C2=A0 [USART3_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 56,
>     +=C2=A0 =C2=A0 [USART3_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 57,
>     +};
>     +
>     +static void connect_peripheral_irq(const AtmegaMcuClass *mc,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SysBusDevice *sb=
d,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceState *dev=
, int n,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned periphe=
ral_irq)
>     +{
>     +=C2=A0 =C2=A0 int irq =3D mc->irq[peripheral_irq];
>     +
>     +=C2=A0 =C2=A0 if (!irq) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 /* FIXME move that to avr_cpu_set_int() once 'sample' =
board is
>     removed */
>     +=C2=A0 =C2=A0 assert(irq >=3D 2);
>     +=C2=A0 =C2=A0 irq -=3D 2;
>     +
>     +=C2=A0 =C2=A0 sysbus_connect_irq(sbd, n, qdev_get_gpio_in(dev, irq))=
;
>     +}
>     +
>     +static void connect_power_reduction_gpio(AtmegaMcuState *s,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const AtmegaMcuClass *mc,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0DeviceState *dev,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0int peripheral_index)
>     +{
>     +=C2=A0 =C2=A0 unsigned power_index =3D mc->dev[peripheral_index].pow=
er_index;
>     +=C2=A0 =C2=A0 assert(mc->dev[power_index].addr);
>     +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&s->pwr[power_index =
- POWER0]),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0mc->dev[peripheral_index].power_bit,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0qdev_get_gpio_in(dev, 0));
>     +}
>     +
>     +static void atmega_realize(DeviceState *dev, Error **errp)
>     +{
>     +=C2=A0 =C2=A0 AtmegaMcuState *s =3D ATMEGA_MCU(dev);
>     +=C2=A0 =C2=A0 const AtmegaMcuClass *mc =3D ATMEGA_MCU_GET_CLASS(dev)=
;
>     +=C2=A0 =C2=A0 DeviceState *cpudev;
>     +=C2=A0 =C2=A0 SysBusDevice *sbd;
>     +=C2=A0 =C2=A0 Error *err =3D NULL;
>     +=C2=A0 =C2=A0 char *devname;
>     +=C2=A0 =C2=A0 size_t i;
>     +
>     +=C2=A0 =C2=A0 assert(mc->io_size <=3D 0x200);
>     +
>     +=C2=A0 =C2=A0 if (!s->xtal_freq_hz) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, "\"xtal-frequency-hz\" =
property must be
>     provided.");
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /* CPU */
>     +=C2=A0 =C2=A0 object_initialize_child(OBJECT(dev), "cpu", &s->cpu,
>     sizeof(s->cpu),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mc->cpu_type, &err, NULL);
>     +=C2=A0 =C2=A0 if (err) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&s->cpu), true, "reali=
zed",
>     &error_abort);
>     +=C2=A0 =C2=A0 cpudev =3D DEVICE(&s->cpu);
>     +
>     +=C2=A0 =C2=A0 /* SRAM */
>     +=C2=A0 =C2=A0 memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
>     mc->sram_size,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&error_abort);
>     +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + mc->io_size, &s=
->sram);
>     +
>     +=C2=A0 =C2=A0 /* Flash */
>     +=C2=A0 =C2=A0 memory_region_init_rom(&s->flash, OBJECT(dev),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"flash", mc->flash_size, &error_fatal);
>     +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), OFFSE=
T_CODE,
>     &s->flash);
>     +
>     +=C2=A0 =C2=A0 /*
>     +=C2=A0 =C2=A0 =C2=A0* I/O
>     +=C2=A0 =C2=A0 =C2=A0*
>     +=C2=A0 =C2=A0 =C2=A0* 0x00 - 0x1f: Registers
>     +=C2=A0 =C2=A0 =C2=A0* 0x20 - 0x5f: I/O memory
>     +=C2=A0 =C2=A0 =C2=A0* 0x60 - 0xff: Extended I/O
>     +=C2=A0 =C2=A0 =C2=A0*/
>     +=C2=A0 =C2=A0 s->io =3D qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE)=
;
>     +=C2=A0 =C2=A0 qdev_prop_set_string(s->io, "name", "I/O");
>     +=C2=A0 =C2=A0 qdev_prop_set_uint64(s->io, "size", mc->io_size);
>     +=C2=A0 =C2=A0 qdev_init_nofail(s->io);
>     +=C2=A0 =C2=A0 sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, OFFS=
ET_DATA,
>     -1234);
>     +
>     +=C2=A0 =C2=A0 /* Power Reduction */
>     +=C2=A0 =C2=A0 for (i =3D 0; i < POWER_MAX; i++) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D POWER(i);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mc->dev[idx].addr) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf("power%zu", =
i);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(OBJECT(dev), dev=
name,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &s->pwr[i], sizeof(s->pwr[i])=
,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AVR_MASK, &error_abort, =
NULL);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(&s->pwr[=
i]), true, "realized",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&error_abort);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&s->pwr[i=
]), 0,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 OFFSET_DATA + mc->dev[idx].addr);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /* GPIO */
>     +=C2=A0 =C2=A0 for (i =3D 0; i < GPIO_MAX; i++) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D GPIO(i);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mc->dev[idx].addr) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf("avr-gpio-%c=
", 'a' + (char)i);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_device(devname,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA +
>     mc->dev[idx].addr, 3);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /* USART */
>     +=C2=A0 =C2=A0 for (i =3D 0; i < USART_MAX; i++) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D USART(i);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mc->dev[idx].addr) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf("usart%zu", =
i);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(OBJECT(dev), dev=
name,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &s->usart[i], sizeof(s->usart=
[i]),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AVR_USART, &error_abort,=
 NULL);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(&s->usart[i]), =
"chardev",
>     serial_hd(i));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(&s->usar=
t[i]), true,
>     "realized",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&error_abort);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sbd =3D SYS_BUS_DEVICE(&s->usart[i]);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc=
->dev[USART(i)].addr);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, =
0, USART_RXC_IRQ(i));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, =
1, USART_DRE_IRQ(i));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, =
2, USART_TXC_IRQ(i));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_power_reduction_gpio(s, mc, DEVI=
CE(&s->usart[i]), idx);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /* Timer */
>     +=C2=A0 =C2=A0 for (i =3D 0; i < TIMER_MAX; i++) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D TIMER(i);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mc->dev[idx].addr) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mc->dev[idx].is_timer16) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_devic=
e("avr-timer8",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O=
FFSET_DATA +
>     mc->dev[idx].addr, 5);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_devic=
e("avr-timer8-intmask",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O=
FFSET_DATA
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +
>     mc->dev[idx].intmask_addr, 1);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_devic=
e("avr-timer8-intflag",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O=
FFSET_DATA
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +
>     mc->dev[idx].intflag_addr, 1);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf("timer%zu", =
i);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(OBJECT(dev), dev=
name,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &s->timer[i], sizeof(s->timer=
[i]),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AVR_TIMER16, &error_abor=
t, NULL);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_uint(OBJECT(&s->time=
r[i]), s->xtal_freq_hz,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"cpu-frequency-hz", &er=
ror_abort);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(&s->time=
r[i]), true,
>     "realized",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&error_abort);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sbd =3D SYS_BUS_DEVICE(&s->timer[i]);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc=
->dev[idx].addr);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 1, OFFSET_DATA +
>     mc->dev[idx].intmask_addr);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 2, OFFSET_DATA +
>     mc->dev[idx].intflag_addr);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, =
0, TIMER_CAPT_IRQ(i));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, =
1, TIMER_COMPA_IRQ(i));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, =
2, TIMER_COMPB_IRQ(i));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, =
3, TIMER_COMPC_IRQ(i));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, =
4, TIMER_OVF_IRQ(i));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_power_reduction_gpio(s, mc, DEVI=
CE(&s->timer[i]), idx);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 create_unimplemented_device("avr-twi",=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 OFFSET_DATA +
>     0x0b8, 6);
>     +=C2=A0 =C2=A0 create_unimplemented_device("avr-adc",=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 OFFSET_DATA +
>     0x078, 8);
>     +=C2=A0 =C2=A0 create_unimplemented_device("avr-ext-mem-ctrl", OFFSET=
_DATA +
>     0x074, 2);
>     +=C2=A0 =C2=A0 create_unimplemented_device("avr-watchdog",=C2=A0 =C2=
=A0 =C2=A0OFFSET_DATA +
>     0x060, 1);
>     +=C2=A0 =C2=A0 create_unimplemented_device("avr-spi",=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 OFFSET_DATA +
>     0x04c, 3);
>     +=C2=A0 =C2=A0 create_unimplemented_device("avr-eeprom",=C2=A0 =C2=A0=
 =C2=A0 =C2=A0OFFSET_DATA +
>     0x03f, 3);
>     +}
>     +
>     +static Property atmega_props[] =3D {
>     +=C2=A0 =C2=A0 DEFINE_PROP_UINT64("xtal-frequency-hz", AtmegaMcuState=
,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0xtal_freq_hz, 0),
>     +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST()
>     +};
>     +
>     +static void atmega_class_init(ObjectClass *oc, void *data)
>     +{
>     +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);
>     +
>     +=C2=A0 =C2=A0 dc->realize =3D atmega_realize;
>     +=C2=A0 =C2=A0 dc->props =3D atmega_props;
>     +=C2=A0 =C2=A0 /* Reason: Mapped at fixed location on the system bus =
*/
>     +=C2=A0 =C2=A0 dc->user_creatable =3D false;
>     +}
>     +
>     +static void atmega168_class_init(ObjectClass *oc, void *data)
>     +{
>     +=C2=A0 =C2=A0 AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
>     +
>     +=C2=A0 =C2=A0 amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr5");
>     +=C2=A0 =C2=A0 amc->flash_size =3D 16 * KiB;
>     +=C2=A0 =C2=A0 amc->eeprom_size =3D 512;
>     +=C2=A0 =C2=A0 amc->sram_size =3D 1 * KiB;
>     +=C2=A0 =C2=A0 amc->io_size =3D 256;
>     +=C2=A0 =C2=A0 amc->gpio_count =3D 23;
>     +=C2=A0 =C2=A0 amc->adc_count =3D 6;
>     +=C2=A0 =C2=A0 amc->irq =3D irq168_328;
>     +=C2=A0 =C2=A0 amc->dev =3D dev168_328;
>     +};
>     +
>     +static void atmega328_class_init(ObjectClass *oc, void *data)
>     +{
>     +=C2=A0 =C2=A0 AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
>     +
>     +=C2=A0 =C2=A0 amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr5");
>     +=C2=A0 =C2=A0 amc->flash_size =3D 32 * KiB;
>     +=C2=A0 =C2=A0 amc->eeprom_size =3D 1 * KiB;
>     +=C2=A0 =C2=A0 amc->sram_size =3D 2 * KiB;
>     +=C2=A0 =C2=A0 amc->io_size =3D 256;
>     +=C2=A0 =C2=A0 amc->gpio_count =3D 23;
>     +=C2=A0 =C2=A0 amc->adc_count =3D 6;
>     +=C2=A0 =C2=A0 amc->irq =3D irq168_328;
>     +=C2=A0 =C2=A0 amc->dev =3D dev168_328;
>     +};
>     +
>     +static void atmega1280_class_init(ObjectClass *oc, void *data)
>     +{
>     +=C2=A0 =C2=A0 AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
>     +
>     +=C2=A0 =C2=A0 amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr6");
>     +=C2=A0 =C2=A0 amc->flash_size =3D 128 * KiB;
>     +=C2=A0 =C2=A0 amc->eeprom_size =3D 4 * KiB;
>     +=C2=A0 =C2=A0 amc->sram_size =3D 8 * KiB;
>     +=C2=A0 =C2=A0 amc->io_size =3D 512;
>     +=C2=A0 =C2=A0 amc->gpio_count =3D 86;
>     +=C2=A0 =C2=A0 amc->adc_count =3D 16;
>     +=C2=A0 =C2=A0 amc->irq =3D irq1280_2560;
>     +=C2=A0 =C2=A0 amc->dev =3D dev1280_2560;
>     +};
>     +
>     +static void atmega2560_class_init(ObjectClass *oc, void *data)
>     +{
>     +=C2=A0 =C2=A0 AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
>     +
>     +=C2=A0 =C2=A0 amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr6");
>     +=C2=A0 =C2=A0 amc->flash_size =3D 256 * KiB;
>     +=C2=A0 =C2=A0 amc->eeprom_size =3D 4 * KiB;
>     +=C2=A0 =C2=A0 amc->sram_size =3D 8 * KiB;
>     +=C2=A0 =C2=A0 amc->io_size =3D 512;
>     +=C2=A0 =C2=A0 amc->gpio_count =3D 54;
>     +=C2=A0 =C2=A0 amc->adc_count =3D 16;
>     +=C2=A0 =C2=A0 amc->irq =3D irq1280_2560;
>     +=C2=A0 =C2=A0 amc->dev =3D dev1280_2560;
>     +};
>     +
>     +static const TypeInfo atmega_mcu_types[] =3D {
>     +=C2=A0 =C2=A0 {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D TYPE_ATMEGA168_MCU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D TYPE_ATMEGA_MCU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D atmeg=
a168_class_init,
>     +=C2=A0 =C2=A0 }, {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D TYPE_ATMEGA328_MCU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D TYPE_ATMEGA_MCU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D atmeg=
a328_class_init,
>     +=C2=A0 =C2=A0 }, {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D TYPE_ATMEGA1280_MCU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D TYPE_ATMEGA_MCU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D atmeg=
a1280_class_init,
>     +=C2=A0 =C2=A0 }, {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D TYPE_ATMEGA2560_MCU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D TYPE_ATMEGA_MCU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D atmeg=
a2560_class_init,
>     +=C2=A0 =C2=A0 }, {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D TYPE_ATMEGA_MCU,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D TYPE_SYS_BUS_DEVICE,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size=C2=A0 =3D sizeof(AtmegaMc=
uState),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size=C2=A0 =C2=A0 =C2=A0=3D sizeo=
f(AtmegaMcuClass),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D atmeg=
a_class_init,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .abstract=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
true,
>     +=C2=A0 =C2=A0 }
>     +};
>     +
>     +DEFINE_TYPES(atmega_mcu_types)
>     diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
>     new file mode 100644
>     index 0000000000..da3b10afec
>     --- /dev/null
>     +++ b/hw/avr/Kconfig
>     @@ -0,0 +1,5 @@
>     +config ATMEL_ATMEGA_MCU
>     +=C2=A0 =C2=A0 bool
>     +=C2=A0 =C2=A0 select ATMEL_TIMER16
>     +=C2=A0 =C2=A0 select ATMEL_USART
>     +=C2=A0 =C2=A0 select ATMEL_POWER
>     diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
>     index 123f174f0e..1f73fd5469 100644
>     --- a/hw/avr/Makefile.objs
>     +++ b/hw/avr/Makefile.objs
>     @@ -1 +1,2 @@
>      =C2=A0obj-y +=3D boot.o
>     +obj-$(CONFIG_ATMEL_ATMEGA_MCU) +=3D atmel_atmega.o
>     --=20
>     2.21.1
>=20


