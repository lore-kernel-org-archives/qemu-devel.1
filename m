Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B54CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A182071F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAHour1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A182071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYBPN-00064M-Jf
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iYBI0-0006zC-GI
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iYB3j-0001iU-T3
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:41:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iYB3j-0001iJ-PB
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574437282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4NhcVLjanHXxWrEM9XQABWFRNDYt0GzjnxJCGmxIWY=;
 b=BAHour1uT8O/LC8ci5ItZQRH6XrBdO+HMp6dFsiJ00usK3vUxy8lTHjlvhSESOssZ3sY5x
 LR7h2AJPqPD7FMrygi0p193FSmyf0diRA/ZoocoD8xCorFUG+Aj+XzCkziBzKIuxL+rSbg
 /0W8LEaSezn0a67K6Km9tyOIfayHPh8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-sr5DottpOeGd8ftEVl16Ng-1; Fri, 22 Nov 2019 10:41:20 -0500
Received: by mail-wr1-f70.google.com with SMTP id 90so736934wrq.6
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 07:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QWSSDjfcvEqhFQ8ZMIS/X+6D2fG0JqgkL1r5iTZ4Yrg=;
 b=jQ5Txq7/8EWK8PGaG/5Eb5rFAf8TYSEi/qVIuibeUt+pwU5cYf20KS2HTiRgHW746X
 Lwws6OQwKo1IAWwLu+muahvfZd6busJpbFBjOwcjABzR+G6mXt+B23Au+UBaN4npiZQJ
 OEkpYGar+J3rUEmNJjWhIoLRGR4qzNOIU9t0JmDJ7lJXDgiKKqxXDz3NJGSqamBFn0R/
 5gYHRgyp0GQ8SoIJ9JndTh3pzZDGljgKhmqcLCVOPeHug8qSYeePno5flgd0WQPx7YJy
 e07sWCt7rC3UaCbvzwLn5bzFqKw8adeytXAslTJvdyGBk5yqL25QXlDUFJJOQ+Dv91U1
 loFQ==
X-Gm-Message-State: APjAAAUSCuaeUDpO2/WsodPFH8OweGYyMGm6AVwo5FbpSy94mNZyWcdc
 MkQWDCD5HTbMm5N1+78KBUDOlBRBlpGCeERpGIzLAp6beefeMub7t5EdPD6+gl9K9fGBvzBqN8n
 T0cd4e8wHLUNwgaw=
X-Received: by 2002:a1c:38c3:: with SMTP id f186mr17392661wma.58.1574437278786; 
 Fri, 22 Nov 2019 07:41:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYEH0wq8RuMh1JFnDQpMCfQEeDKyCs3bO1/xGEup85ZKZCg4TZPSBkRoaghhFmrE3JuNk18g==
X-Received: by 2002:a1c:38c3:: with SMTP id f186mr17392630wma.58.1574437278506; 
 Fri, 22 Nov 2019 07:41:18 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id g11sm7977383wro.2.2019.11.22.07.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 07:41:17 -0800 (PST)
Subject: Re: [PATCH v35 10/13] target/avr: Add limited support for USART and
 16 bit timer peripherals
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-11-mrolnik@gmail.com>
 <CAL1e-=g783x53PYxd43e77fSmzokhW-hDvdfRCKn+k7AqQ-Cdg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c5bcd11f-96e3-c6c6-83c1-feffa890e3ba@redhat.com>
Date: Fri, 22 Nov 2019 16:41:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=g783x53PYxd43e77fSmzokhW-hDvdfRCKn+k7AqQ-Cdg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: sr5DottpOeGd8ftEVl16Ng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 3:41 PM, Aleksandar Markovic wrote:
> On Tue, Oct 29, 2019 at 10:25 PM Michael Rolnik <mrolnik@gmail.com> wrote=
:
>>
>> From: Sarah Harris <S.E.Harris@kent.ac.uk>
>>
>> These were designed to facilitate testing but should provide enough func=
tion to be useful in other contexts.
>> Only a subset of the functions of each peripheral is implemented, mainly=
 due to the lack of a standard way to handle electrical connections (like G=
PIO pins).
>>
>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>> ---
>>   hw/char/Kconfig                |   3 +
>>   hw/char/Makefile.objs          |   1 +
>>   hw/char/avr_usart.c            | 324 ++++++++++++++++++
>>   hw/misc/Kconfig                |   3 +
>>   hw/misc/Makefile.objs          |   2 +
>>   hw/misc/avr_mask.c             | 112 ++++++
>>   hw/timer/Kconfig               |   3 +
>>   hw/timer/Makefile.objs         |   2 +
>>   hw/timer/avr_timer16.c         | 605 +++++++++++++++++++++++++++++++++
>>   include/hw/char/avr_usart.h    |  97 ++++++
>>   include/hw/misc/avr_mask.h     |  47 +++
>>   include/hw/timer/avr_timer16.h |  97 ++++++
>>   12 files changed, 1296 insertions(+)
>>   create mode 100644 hw/char/avr_usart.c
>>   create mode 100644 hw/misc/avr_mask.c
>>   create mode 100644 hw/timer/avr_timer16.c
>>   create mode 100644 include/hw/char/avr_usart.h
>>   create mode 100644 include/hw/misc/avr_mask.h
>>   create mode 100644 include/hw/timer/avr_timer16.h
>>
>> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
>> index 40e7a8b8bb..331b20983f 100644
>> --- a/hw/char/Kconfig
>> +++ b/hw/char/Kconfig
>> @@ -46,3 +46,6 @@ config SCLPCONSOLE
>>
>>   config TERMINAL3270
>>       bool
>> +
>> +config AVR_USART
>> +    bool
>> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
>> index 02d8a66925..f05c1f5667 100644
>> --- a/hw/char/Makefile.objs
>> +++ b/hw/char/Makefile.objs
>> @@ -21,6 +21,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_vty.o
>>   obj-$(CONFIG_DIGIC) +=3D digic-uart.o
>>   obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
>>   obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
>> +common-obj-$(CONFIG_AVR_USART) +=3D avr_usart.o
>>
>>   common-obj-$(CONFIG_CMSDK_APB_UART) +=3D cmsdk-apb-uart.o
>>   common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
>> diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
>> new file mode 100644
>> index 0000000000..9ca3c2a1cd
>> --- /dev/null
>> +++ b/hw/char/avr_usart.c
>> @@ -0,0 +1,324 @@
>> +/*
>> + * AVR USART
>> + *
>> + * Copyright (c) 2018 University of Kent
>> + * Author: Sarah Harris
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g a copy
>> + * of this software and associated documentation files (the "Software")=
, to deal
>> + * in the Software without restriction, including without limitation th=
e rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or=
 sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be inclu=
ded in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPR=
ESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SH=
ALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR=
 OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARIS=
ING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALIN=
GS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/char/avr_usart.h"
>> +#include "qemu/log.h"
>> +#include "hw/irq.h"
>> +#include "hw/qdev-properties.h"
>> +
>> +static int avr_usart_can_receive(void *opaque)
>> +{
>> +    AVRUsartState *usart =3D opaque;
>> +
>> +    if (usart->data_valid || !(usart->csrb & USART_CSRB_RXEN)) {
>> +        return 0;
>> +    }
>> +    return 1;

Here we tell the chardev frontend that we can receive at most 1 byte, ...

>> +}
>> +
>> +static void avr_usart_receive(void *opaque, const uint8_t *buffer, int =
size)
>> +{
>> +    AVRUsartState *usart =3D opaque;
>> +    assert(size =3D=3D 1);

... so this condition is true, the frontend will never provide us more=20
than 1 byte.

>=20
> Hello, Michael.
>=20
> I see the line "assert(size =3D=3D 1);" is used here, and in really numer=
ous
> places in USART emulation (as a rule, at the very beginnings of function
> bodies). Could you explain to me the justification for that line? Is ther=
e
> a place in documentation that would expain the need for it? If this is
> justified, why is there the need for argument "int size" in corresponding
> functions? If some external rule/API forces you to have that argument for
> all such functions, can you tell me what rule/API is that?

Some backends have FIFO queues, so can process more chars at once.

>=20
> Yours,
> Aleksandar
>=20
>> +    assert(!usart->data_valid);
>> +    usart->data =3D buffer[0];

Here the model consumes the 1st char of an array of at most 1 byte.

I suppose Sarah wanted to be sure we are not dropping characters.

>> +    usart->data_valid =3D true;
>> +    usart->csra |=3D USART_CSRA_RXC;
>> +    if (usart->csrb & USART_CSRB_RXCIE) {
>> +        qemu_set_irq(usart->rxc_irq, 1);
>> +    }
>> +}
[...]


