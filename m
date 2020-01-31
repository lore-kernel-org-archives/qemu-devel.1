Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E23C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D36D20707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAfFS7og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D36D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixSjc-0004rX-Ln
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 04:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ixSiU-0003re-JV
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ixSiR-0002iR-Em
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:35:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52412
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ixSiR-0002ev-B0
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580463354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=o10wyNXbrsyrmHJtQ87Wp/6Oe2xHFZtdFah6if3/rZY=;
 b=HAfFS7ogpIEQFojd8JPMqBVSG9ssTrdzKx9iY6CCcmH2DDnJ8Pd0RQ4tBFO7SNcwb+oLua
 ylRcJnGhoCsd1MsVENrbqbO/fUPi5HGZdjROxnpO4YDhJEAvLBTsPe/SDQd8/TTIO89pxK
 Tgu9SGmCNF4zSK+vkHHvcJvF/V0nqds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-SukBFkiKNEm2Mt61jVfH9g-1; Fri, 31 Jan 2020 04:35:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A31E18B9FCB;
 Fri, 31 Jan 2020 09:35:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D91FC60BE0;
 Fri, 31 Jan 2020 09:35:31 +0000 (UTC)
Subject: Re: [PATCH rc4 24/29] hw/avr: Add some ATmega microcontrollers
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-25-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=j3b6Gfo4K56=tXc9jbXAy3fou5Dsxq3ns9C89mpuPXxA@mail.gmail.com>
 <CAAdtpL6F=qbWT7keQxHtacndN+JUM32tyd9vW0ZEEMYYN=a=3g@mail.gmail.com>
 <CAL1e-=hqWdFckhi30iws0_OMEB01dvs=ARTvpWrAJ4bF5qrKbQ@mail.gmail.com>
 <CAL1e-=i-=NkATmB0XJ12mGBOin-OGZ5VMc1BD3O1iheNfbhBAQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <91e475a8-ba43-05da-73d1-d59ca28228bf@redhat.com>
Date: Fri, 31 Jan 2020 10:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i-=NkATmB0XJ12mGBOin-OGZ5VMc1BD3O1iheNfbhBAQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: SukBFkiKNEm2Mt61jVfH9g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/01/2020 05.11, Aleksandar Markovic wrote:
> On Fri, Jan 31, 2020 at 4:45 AM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
>>
>> On Fri, Jan 31, 2020 at 4:09 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
>>>
>>> Hi Aleksandar,
>>>
>>> Cc'ing Thomas & Daniel who are not lawyers but tried to explain me few
>>> times how licensing works.
>>>
>>> On Fri, Jan 31, 2020 at 2:56 AM Aleksandar Markovic
>>> <aleksandar.m.mail@gmail.com> wrote:
>>>> On Fri, Jan 31, 2020 at 1:03 AM Aleksandar Markovic
>>>> <aleksandar.markovic@rt-rk.com> wrote:
>>>>>
>>>>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>>
>>>>> Add some AVR microcontrollers from the ATmega family:
>>>>>
>>>>>   - middle range: ATmega168 and ATmega328
>>>>>   - high range: ATmega1280 and ATmega2560
>>>>>
>>>>> For product comparison:
>>>>>   https://www.microchip.com/wwwproducts/ProductCompare/ATmega168P/ATm=
ega328P
>>>>>   https://www.microchip.com/wwwproducts/ProductCompare/ATmega1280/ATm=
ega2560
>>>>>
>>>>> Datasheets:
>>>>>   http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA=
-168A-PA-328-P-DS-DS40002061A.pdf
>>>>>   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AV=
R-Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf
>>>>>
>>>>> [AM: Remove word 'Atmel' from filenames and all elements of code]
>>>>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>>>> ---
>>>>>  hw/avr/Kconfig       |   5 +
>>>>>  hw/avr/Makefile.objs |   1 +
>>>>>  hw/avr/atmega.c      | 470 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>>>  hw/avr/atmega.h      |  48 ++++++
>>>>>  4 files changed, 524 insertions(+)
>>>>>  create mode 100644 hw/avr/Kconfig
>>>>>  create mode 100644 hw/avr/atmega.c
>>>>>  create mode 100644 hw/avr/atmega.h
>>>>>
>>>>> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
>>>>> new file mode 100644
>>>>> index 0000000..9e6527e
>>>>> --- /dev/null
>>>>> +++ b/hw/avr/Kconfig
>>>>> @@ -0,0 +1,5 @@
>>>>> +config AVR_ATMEGA_MCU
>>>>> +    bool
>>>>> +    select AVR_TIMER16
>>>>> +    select AVR_USART
>>>>> +    select AVR_POWER
>>>>> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
>>>>> index 123f174..af0fdde 100644
>>>>> --- a/hw/avr/Makefile.objs
>>>>> +++ b/hw/avr/Makefile.objs
>>>>> @@ -1 +1,2 @@
>>>>>  obj-y +=3D boot.o
>>>>> +obj-$(CONFIG_AVR_ATMEGA_MCU) +=3D atmega.o
>>>>> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
>>>>> new file mode 100644
>>>>> index 0000000..8cdf28b
>>>>> --- /dev/null
>>>>> +++ b/hw/avr/atmega.c
>>>>> @@ -0,0 +1,470 @@
>>>>> +/*
>>>>> + * QEMU ATmega MCU
>>>>> + *
>>>>> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
>>>>> + *
>>>>> + * This work is licensed under the terms of the GNU GPLv2 or later.
>>>>> + * See the COPYING file in the top-level directory.
>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>> + */
>>>>
>>>> Philippe,
>>>>
>>>> Michael and I already agreed at some moment that the whole target AVR
>>>> should have harmonized licenses, and Sarrah agreed to change her
>>>> license to achieve this. Do you agree to harmonize your licenses with
>>>> the rest of the project? (This would mean changing the preable, but of
>>>> course you remain copyright carrier as is now.)
>>>
>>> What license do you want to use? I always use "GPLv2 or later" with
>>> QEMU, mostly following what the others do.
>>>
>>> Per https://wiki.qemu.org/License:
>>>
>>>   Source files with no licensing information are released under the
>>> GNU General Public License, version 2 or (at your option) any later
>>> version.
>>>
>>> Reading about licensing is not fun :(
>>>
>>
>> Philippe, here is the deal: All new files for AVR platform has the
>> following preamble, that Michael chose from the outset:
>>
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see
>> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>>
>> Now, it is preferable that licenses are harmonized within a module,
>> and I ask you to change the preamble to be the same as the rest of the
>> module, that is all. This practically means LGPL2.1+later instead
>> LGPL2.0+later. I think it is reasonable that we want to simplify out
>> license stuff, not complicate it with different licenses within a
>> module. There are examples of complications in cases of different
>> license within the same module, so it would be ideal if we avoid such
>> situations.
>>
>=20
> I didn't mean to scare you, I am just a developer like you, and I want
> to avoid thinking about licenses, and think of our real work, so, I
> gather, in my layman terms, it is better to have the same license for
> the new platform in its entirety, if possible, that is all. :)

This is all part of QEMU, and QEMU is licensed under the GPLv2. If
someone wants to use a less strict license for their own code that is
still compatible with the GPLv2, like the LGPLv2.1, that's fine. But I
think if Philippe does not like to release his code under the LGPL, and
wants to use GPL instead, you can not force him to use LGPL here. It's
the decision of Philippe what he wants to use for his code.

 Thomas


