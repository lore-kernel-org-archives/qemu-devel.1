Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD1CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8862087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfiDojkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8862087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itV44-0004MI-7S
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itUsH-0004Hr-L3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itUsC-0003dF-Ud
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:05:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itUsC-0003cm-Qb
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579518335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UIfUQ6ikxT4R8po4vzCXAHQfxQMVj01KjHbkpe4oygU=;
 b=IfiDojkYFo8B3BFlN5gQlFg74mGIGDXn6Hl9GTbuSPxUq23UQmdxvEX0NUDY7gHYkwmpFP
 PV8yIdc/3/GlLQtygKV7mBnwlkFou/+TVXvEW06PLWxGQJLijQelroxkpnHGTF1FLAYFqU
 Yzo8/aUcZKp/oLCqDlCczoHt+bxOA94=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-jhpwY-EUOViCqs81wtGYCA-1; Mon, 20 Jan 2020 06:05:27 -0500
Received: by mail-wr1-f69.google.com with SMTP id f10so14063785wro.14
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 03:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mpjdGFyFRr7IPKbbXbXtxXyYRORDMex5tCojPrmd104=;
 b=XraEW1QfmwvGCMvbpNsTq44mcGAHJdYF1UZD+E8VV8kiTY3lUi1TILOqw2ri0rNZwM
 6MreRrLNuOIqSX6O00OFpyHL+iA2nADBn/sDUlQ7XndVg9uCNYeZoqkBw8eXqrtLMEcZ
 7hLm6z8byVl7X0VDD3Lh3ljRgMkoXP/fqxRWafba5uzmliky1H0Bn1Q35C/t9tdhmCwl
 u0SZG4yCstUALJSKF6H8ikyqvHnXE6wsltg5TZpVviap+b9OoH+2bYhDHCul8F8zmsEE
 BSaU7SKFWbWpKbcErh5fuEJ7fL5z83YsCVG4kfsHexwinvfdSk3JBULcFPzRzBjhGFaK
 1H7A==
X-Gm-Message-State: APjAAAW/o8NXYBILhzlY/RePPUTPk2loE6wEm8OKvDpCKpl1T49W3HLW
 HiuGnW7GbOPUj4AEDyoz1h4EZYkUF1+L14jzo0z1WqGl+vT34iHHPt4kFMOyUYrwRclrUWRBhKG
 DePGGgbuiFZqN8Z0=
X-Received: by 2002:adf:fd84:: with SMTP id d4mr17384874wrr.211.1579518326392; 
 Mon, 20 Jan 2020 03:05:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyY4l7gbzQJ1UuKDMZZKxeAOeIHn74dc+J6ZOz76rcQpkaByBk1b8tt3sclzo5KGwOLVpD6Dg==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr17384826wrr.211.1579518325920; 
 Mon, 20 Jan 2020 03:05:25 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q15sm47128329wrr.11.2020.01.20.03.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 03:05:25 -0800 (PST)
Subject: Re: [PATCH v3 4/8] hw/avr: Add some Arduino boards
To: Igor Mammedov <imammedo@redhat.com>
References: <20191229224505.24466-1-f4bug@amsat.org>
 <20191229224505.24466-5-f4bug@amsat.org> <20200120100335.58f1b7d2@redhat.com>
 <b8a453a4-0aaa-8f85-6073-62abd3f70393@redhat.com>
 <20200120110954.5b1dc3ce@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5520e32-d111-ae71-f546-c3433dcdc9bd@redhat.com>
Date: Mon, 20 Jan 2020 12:05:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120110954.5b1dc3ce@redhat.com>
Content-Language: en-US
X-MC-Unique: jhpwY-EUOViCqs81wtGYCA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phillip Stevens <phillip.stevens@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 11:09 AM, Igor Mammedov wrote:
> On Mon, 20 Jan 2020 10:21:52 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/20/20 10:03 AM, Igor Mammedov wrote:
>>> On Sun, 29 Dec 2019 23:45:01 +0100
>>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>>>   =20
>>>> Arduino boards are build with AVR chipsets.
>>>> Add some of the popular boards:
>>>>
>>>> - Arduino Duemilanove
>>>> - Arduino Uno
>>>> - Arduino Mega
>>>>
>>>> For more information:
>>>>     https://www.arduino.cc/en/Main/Products
>>>>     https://store.arduino.cc/arduino-genuino/most-popular
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> ---
>>>> v2:
>>>> - Reword description adding more information (Aleksandar)
>>>> - Use DEFINE_TYPES (Igor)
>>>>
>>>> Cc: Phillip Stevens <phillip.stevens@gmail.com>
>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>> ---
>>>>    hw/avr/arduino.c     | 177 ++++++++++++++++++++++++++++++++++++++++=
+++
>>>>    hw/avr/Makefile.objs |   1 +
>>>>    2 files changed, 178 insertions(+)
>>>>    create mode 100644 hw/avr/arduino.c
>>>>
>>>> diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
>>>> new file mode 100644
>>>> index 0000000000..ecaaa295d8
>>>> --- /dev/null
>>>> +++ b/hw/avr/arduino.c
>>>> @@ -0,0 +1,177 @@
>>>> +/*
>>>> + * QEMU Arduino boards
>>>> + *
>>>> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPLv2 or later.
>>>> + * See the COPYING file in the top-level directory.
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +/* TODO: Implement the use of EXTRAM */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu-common.h"
>>>> +#include "qapi/error.h"
>>>> +#include "hw/boards.h"
>>>> +#include "hw/loader.h"
>>>> +#include "elf.h"
>>>> +#include "atmega.h"
>>>> +
>>>> +typedef struct ArduinoMachineState {
>>> [...]
>>>> +    MemoryRegion extram;
>>>> +} ArduinoMachineState;
>>>> +
>>>> +typedef struct ArduinoMachineClass {
>>> [...]
>>>> +    size_t extram_size;
>>>
>>> extfoo doesn't seem to be used in this patch
>>
>> Ah leftover from adapting from the 'sample' board which has SIZE_EXMEM=
=3D0
>> so I ended removing a chunk and forgot this field.
>>
>> Can I add your R-b tag when respining this patch without the field?
> sure

Thanks!

> later on we need to make up some generic way for machine to say that
> -m is not supported to avoid useless/confusing option where board
> doesn't care about it.

Does that means that when running this machine with '-m 3G' on top your=20
memdev series, QEMU will still allocate 3G of unnecessary RAM?

>>>> +} ArduinoMachineClass;
>>>> +
>>>> +#define TYPE_ARDUINO_MACHINE \
>>>> +        MACHINE_TYPE_NAME("arduino")
>>>> +#define ARDUINO_MACHINE(obj) \
>>>> +        OBJECT_CHECK(ArduinoMachineState, (obj), TYPE_ARDUINO_MACHINE=
)
>>>> +#define ARDUINO_MACHINE_CLASS(klass) \
>>>> +        OBJECT_CLASS_CHECK(ArduinoMachineClass, (klass), TYPE_ARDUINO=
_MACHINE)
>>>> +#define ARDUINO_MACHINE_GET_CLASS(obj) \
>>>> +        OBJECT_GET_CLASS(ArduinoMachineClass, (obj), TYPE_ARDUINO_MAC=
HINE)
>>>> +
>>>> +static void load_firmware(const char *firmware, uint64_t flash_size)
>>>> +{
>>>> +    const char *filename;
>>>> +    int bytes_loaded;
>>>> +
>>>> +    /* Load firmware (contents of flash) trying to auto-detect format=
 */
>>>> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
>>>> +    if (filename =3D=3D NULL) {
>>>> +        error_report("Unable to find %s", firmware);
>>>> +        exit(1);
>>>> +    }
>>>> +
>>>> +    bytes_loaded =3D load_elf(filename, NULL, NULL, NULL, NULL, NULL,=
 NULL,
>>>> +                            0, EM_NONE, 0, 0);
>>>> +    if (bytes_loaded < 0) {
>>>> +        bytes_loaded =3D load_image_targphys(filename, OFFSET_CODE, f=
lash_size);
>>>> +    }
>>>> +    if (bytes_loaded < 0) {
>>>> +        error_report("Unable to load firmware image %s as ELF or raw =
binary",
>>>> +                     firmware);
>>>> +        exit(1);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void arduino_machine_init(MachineState *machine)
>>>> +{
>>>> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_GET_CLASS(machine);
>>>> +    ArduinoMachineState *ams =3D ARDUINO_MACHINE(machine);
>>>> +
>>>> +    sysbus_init_child_obj(OBJECT(machine), "mcu", &ams->mcu, sizeof(a=
ms->mcu),
>>>> +                          amc->mcu_type);
>>>> +    object_property_set_uint(OBJECT(&ams->mcu), amc->xtal_hz,
>>>> +                             "xtal-frequency-hz", &error_abort);
>>>> +    object_property_set_bool(OBJECT(&ams->mcu), true, "realized",
>>>> +                             &error_abort);
>>>> +
>>>> +    if (machine->firmware) {
>>>> +        load_firmware(machine->firmware, memory_region_size(&ams->mcu=
.flash));
>>>> +    }
>>>> +}
>>>> +
>>>> +static void arduino_machine_class_init(ObjectClass *oc, void *data)
>>>> +{
>>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>>>> +
>>>> +    mc->init =3D arduino_machine_init;
>>>> +    mc->default_cpus =3D 1;
>>>> +    mc->min_cpus =3D mc->default_cpus;
>>>> +    mc->max_cpus =3D mc->default_cpus;
>>>> +    mc->no_floppy =3D 1;
>>>> +    mc->no_cdrom =3D 1;
>>>> +    mc->no_parallel =3D 1;
>>>> +}
>>>> +
>>>> +static void arduino_duemilanove_class_init(ObjectClass *oc, void *dat=
a)
>>>> +{
>>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>>>> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
>>>> +
>>>> +    /* https://www.arduino.cc/en/Main/ArduinoBoardDuemilanove */
>>>> +    mc->desc        =3D "Arduino Duemilanove (ATmega168)",
>>>> +    mc->alias       =3D "2009";
>>>> +    amc->mcu_type   =3D TYPE_ATMEGA168_MCU;
>>>> +    amc->xtal_hz    =3D 16 * 1000 * 1000;
>>>> +};
>>>> +
>>>> +static void arduino_uno_class_init(ObjectClass *oc, void *data)
>>>> +{
>>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>>>> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
>>>> +
>>>> +    /* https://store.arduino.cc/arduino-uno-rev3 */
>>>> +    mc->desc        =3D "Arduino UNO (ATmega328P)";
>>>> +    mc->alias       =3D "uno";
>>>> +    amc->mcu_type   =3D TYPE_ATMEGA328_MCU;
>>>> +    amc->xtal_hz    =3D 16 * 1000 * 1000;
>>>> +};
>>>> +
>>>> +static void arduino_mega_class_init(ObjectClass *oc, void *data)
>>>> +{
>>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>>>> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
>>>> +
>>>> +    /* https://www.arduino.cc/en/Main/ArduinoBoardMega */
>>>> +    mc->desc        =3D "Arduino Mega (ATmega1280)";
>>>> +    mc->alias       =3D "mega";
>>>> +    amc->mcu_type   =3D TYPE_ATMEGA1280_MCU;
>>>> +    amc->xtal_hz    =3D 16 * 1000 * 1000;
>>>> +};
>>>> +
>>>> +static void arduino_mega2560_class_init(ObjectClass *oc, void *data)
>>>> +{
>>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>>>> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
>>>> +
>>>> +    /* https://store.arduino.cc/arduino-mega-2560-rev3 */
>>>> +    mc->desc        =3D "Arduino Mega 2560 (ATmega2560)";
>>>> +    mc->alias       =3D "mega2560";
>>>> +    mc->is_default  =3D true;
>>>> +    amc->mcu_type   =3D TYPE_ATMEGA2560_MCU;
>>>> +    amc->xtal_hz    =3D 16 * 1000 * 1000; /* CSTCE16M0V53-R0 */
>>>> +};
>>>> +
>>>> +static const TypeInfo arduino_machine_types[] =3D {
>>>> +    {
>>>> +        .name          =3D MACHINE_TYPE_NAME("arduino-duemilanove"),
>>>> +        .parent        =3D TYPE_ARDUINO_MACHINE,
>>>> +        .class_init    =3D arduino_duemilanove_class_init,
>>>> +    }, {
>>>> +        .name          =3D MACHINE_TYPE_NAME("arduino-uno"),
>>>> +        .parent        =3D TYPE_ARDUINO_MACHINE,
>>>> +        .class_init    =3D arduino_uno_class_init,
>>>> +    }, {
>>>> +        .name          =3D MACHINE_TYPE_NAME("arduino-mega"),
>>>> +        .parent        =3D TYPE_ARDUINO_MACHINE,
>>>> +        .class_init    =3D arduino_mega_class_init,
>>>> +    }, {
>>>> +        .name          =3D MACHINE_TYPE_NAME("arduino-mega-2560-v3"),
>>>> +        .parent        =3D TYPE_ARDUINO_MACHINE,
>>>> +        .class_init    =3D arduino_mega2560_class_init,
>>>> +    }, {
>>>> +        .name           =3D TYPE_ARDUINO_MACHINE,
>>>> +        .parent         =3D TYPE_MACHINE,
>>>> +        .instance_size  =3D sizeof(ArduinoMachineState),
>>>> +        .class_size     =3D sizeof(ArduinoMachineClass),
>>>> +        .class_init     =3D arduino_machine_class_init,
>>>> +        .abstract       =3D true,
>>>> +    }
>>>> +};
>>>> +
>>>> +DEFINE_TYPES(arduino_machine_types)
>>>> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
>>>> index 4b6b911820..39ee3c32b2 100644
>>>> --- a/hw/avr/Makefile.objs
>>>> +++ b/hw/avr/Makefile.objs
>>>> @@ -1,2 +1,3 @@
>>>>    obj-y +=3D sample.o
>>>>    obj-y +=3D atmega.o
>>>> +obj-y +=3D arduino.o
>>>
>>>   =20
>>
>=20


