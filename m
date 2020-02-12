Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CBDC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042C420848
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arEuMBVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042C420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j20pg-0002wV-4a
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 17:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1j20nh-0001Xf-CT
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1j20ne-0003co-Ja
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:48:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46091
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1j20ne-0003aN-B0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581547685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qr50x6WXUegzP8QDAQETMfuqnQLhTICpS5/SjcktxS4=;
 b=arEuMBVHqUl+AirnGgGn9KBH0YFRbytNAAB7HYs4iSKcnSu/zbWMCfenF42EhpW/0/Z+P2
 plWwilVhSA+VwWUjJ29VObe4vgJBtfuG6s+0eSOgdcFCYGMT0fGup/3TN2MiP/47d9I/cR
 9U2TNZlV2+kHwXsxd4KR3rBvQ5DX6Tw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-WdjKvxmZNi6k2qPLEzaFxw-1; Wed, 12 Feb 2020 17:48:00 -0500
Received: by mail-wr1-f69.google.com with SMTP id o9so1461592wrw.14
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 14:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qr50x6WXUegzP8QDAQETMfuqnQLhTICpS5/SjcktxS4=;
 b=adtTMho87+BldETUwyvgP7ZDx+kWegixVQlSKgmbjpw0VVQkfZ5RKxF/IUmTNC0+YT
 b+4wI7S2Uxrx61LZjVGEoVZ+jWzoVOXUUvRvzLyMTWkmKGp9YXaw9skMO/85CXXaWn8L
 Hb1+v+hgKSllb6ihONcTMMtj8C7Kcm+GVG6JbC4x/ANAus4s2rdJl5oUdpCPsR6bmeLp
 18/LYyeuwogv/byuh4pT3bG1TLT8mBYfGqPkG2Nj+vHwFLnzuigJrI7D1Ce4bZEKL9xD
 dv6BUOn8Qo9IUhvpgBIgjvCkSogF5ueYmkOEC9Jfe029OAO9CnLaruaV967NvWwlA5/8
 9gpQ==
X-Gm-Message-State: APjAAAUkUwNhHCsp72IIK+EInDuzMmWh+KaM+ig7c14pEN79TC/9H5h8
 CTlWUsbx5yCFXwDyNOCdU3plqgKHFVuanVzM9h0oegvbtnn04dU2jGBQihJ6ONLbkRydZAnBOSp
 /hozxugEkdGEmX8lG9A4iqgjU/dne8GM=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr1406992wmd.39.1581547679064; 
 Wed, 12 Feb 2020 14:47:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkkkajuOAGQn03d4KVw6IEiwdhEQ+sOUOFwsP9BTOTp+De9/HKqdlfjRuu659vt8sCRZqyKxxftP3pH6RefJA=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr1406969wmd.39.1581547678738; 
 Wed, 12 Feb 2020 14:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-8-nieklinnenbank@gmail.com>
 <8be03fbb-74f2-e688-76b1-ab504f25f8e4@redhat.com>
 <20200120175918.GA2949@minyard.net>
 <CAPan3WpJ_L7OyiC0hod0e436xOUZ2sHCfQqRmAsvD7hTPrBsDg@mail.gmail.com>
 <20200203131017.GE2626@minyard.net>
 <CAPan3Wr=JFwHPChPfN6kng9ZZhrbprc8ZuXjHS5cErPuV-FzJg@mail.gmail.com>
 <CAPan3WrE77GePz-mgz1otf1iiK8nDZ+RK2NF5ueRoHbDmpS1_w@mail.gmail.com>
In-Reply-To: <CAPan3WrE77GePz-mgz1otf1iiK8nDZ+RK2NF5ueRoHbDmpS1_w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 12 Feb 2020 23:47:47 +0100
Message-ID: <CAP+75-XQKisiLaTFXc2JuCvORkfFjfs0UPzjzyj1PrKGScR7Ow@mail.gmail.com>
Subject: Re: [PATCH v3 07/17] hw/arm/allwinner: add Security Identifier device
To: Niek Linnenbank <nieklinnenbank@gmail.com>
X-MC-Unique: WdjKvxmZNi6k2qPLEzaFxw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

)-.On Wed, Feb 12, 2020 at 10:31 PM Niek Linnenbank
<nieklinnenbank@gmail.com> wrote:
>
> Hi Corey,
>
> On Thu, Feb 6, 2020 at 10:09 PM Niek Linnenbank <nieklinnenbank@gmail.com=
> wrote:
>>
>> Hi Corey,
>>
>> On Mon, Feb 3, 2020 at 2:10 PM Corey Minyard <cminyard@mvista.com> wrote=
:
>>>
>>> On Sun, Feb 02, 2020 at 10:27:49PM +0100, Niek Linnenbank wrote:
>>> > Hi Corey,
>>> >
>>> > Thanks for reviewing!
>>> >
>>> > On Mon, Jan 20, 2020 at 6:59 PM Corey Minyard <cminyard@mvista.com> w=
rote:
>>> >
>>> > > On Sat, Jan 18, 2020 at 04:25:08PM +0100, Philippe Mathieu-Daud=C3=
=A9 wrote:
>>> > > > Cc'ing Corey/David for good advices about using UUID.
>>> > >
>>> > > Is there any reason you didn't use the built-in qemu UUID for this?=
  It
>>> > > would simplify things in general.
>>> > >
>>> >
>>> > Currently the Allwinner SID device is using the QemuUUID type from
>>> > include/qemu/uuid.h.
>>> > Is that the build-in UUID you are referring to or should I use someth=
ing
>>> > else?
>>>
>>> You are using the QemuUUID type, which is of course what you should do,
>>> but you aren't using the UUID generated by qemu (at least that I can fi=
nd).
>>> That in include/sysemu/sysemu.h and is named qemu_uuid.  Whether you
>>> should use that or not depends on your needs.  If you just need some
>>> uuid, then that's what you should probably use.  If you need something
>>> the user can individually control for this device, for instance, then
>>> that probably won't do.
>>
>>
>> Ah I did not know about the qemu_uuid variable, thanks for pointing that=
 out.
>> Basically the SID identifier is a number that is unique for each board t=
hat comes
>> out of the factory. It is currently used by U-Boot to as input to genera=
te a MAC address.
>>
>> If I understand correctly, qemu_uuid is optional and by default zero.
>> However the SID value should not be zero, as otherwise U-Boot can't pick=
 a MAC address
>> resulting in a non-working ethernet device.
>>
>> Currently the hw/arm/orangepi.c machine specifies a fixed SID to be used=
 for the emulated board,
>> also containing a prefix (8100c002) that indicates the H3 chipset. One t=
hing that I am strugling with is that

Suggestion while reading this, you might display a warning if the user
provided UUID doesn't start with 8100c002.

>> I'm not able to override the property using '-global', if hw/arm/orangep=
i.c initializes the property with qdev_prop_set_string:
>>
>> $ qemu-system-arm -M orangepi-pc -kernel u-boot -nographic -nic user \
>> -global allwinner-sid.identifier=3D8100c002-0001-0002-0003-000044556688
>>
>> If I don't set the property in hw/arm/orangepi.c, I can set it with '-gl=
obal'. Do you perhaps have a
>> recommendation how to improve that? Basically what is needed is that the=
 machine sets the default
>> property including the chip prefix, and that the user can override it. A=
lthough it is not required for a
>> working emulated board, it would be a nice-to-have that the user can set=
 it.
>
>
> FYI and possibly others who have a similar usecase, I figured out how to =
do this. In the machine init function,
> after creating the new SoC object, simply check if the identifier has a v=
alue:
>
> +    if (qemu_uuid_is_null(&s->h3->sid.identifier)) {
> +        qdev_prop_set_string(DEVICE(s->h3), "identifier",
> +                             "8100c002-0001-0002-0003-000044556677");

Similarly, display a warning "No UUID provided, using default one..."
(or generate one 8100c002-XXX)?

> +    }
>
> That way, if the user passed -global to override it, the machine will not=
 overrule the user's value
> and by default the machine sets an identifier containing the H3 specific =
chip prefix.
>
[...]
>>> > > > > --- /dev/null
>>> > > > > +++ b/hw/misc/allwinner-sid.c
>>> > > > > @@ -0,0 +1,170 @@
>>> > > > > +/*
>>> > > > > + * Allwinner Security ID emulation
>>> > > > > + *
>>> > > > > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.co=
m>
>>> > > > > + *
>>> > > > > + * This program is free software: you can redistribute it and/=
or
>>> > > modify
>>> > > > > + * it under the terms of the GNU General Public License as pub=
lished
>>> > > by
>>> > > > > + * the Free Software Foundation, either version 2 of the Licen=
se, or
>>> > > > > + * (at your option) any later version.
>>> > > > > + *
>>> > > > > + * This program is distributed in the hope that it will be use=
ful,
>>> > > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty=
 of
>>> > > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See t=
he
>>> > > > > + * GNU General Public License for more details.
>>> > > > > + *
>>> > > > > + * You should have received a copy of the GNU General Public L=
icense
>>> > > > > + * along with this program.  If not, see <
>>> > > http://www.gnu.org/licenses/>.
>>> > > > > + */
>>> > > > > +
>>> > > > > +#include "qemu/osdep.h"
>>> > > > > +#include "qemu/units.h"
>>> > > > > +#include "hw/sysbus.h"
>>> > > > > +#include "migration/vmstate.h"
>>> > > > > +#include "qemu/log.h"
>>> > > > > +#include "qemu/module.h"
>>> > > > > +#include "qemu/guest-random.h"
>>> > > > > +#include "qapi/error.h"
>>> > > > > +#include "hw/qdev-properties.h"
>>> > > > > +#include "hw/misc/allwinner-sid.h"
>>> > > > > +#include "trace.h"
>>> > > > > +
>>> > > > > +/* SID register offsets */
>>> > > > > +enum {
>>> > > > > +    REG_PRCTL =3D 0x40,   /* Control */
>>> > > > > +    REG_RDKEY =3D 0x60,   /* Read Key */
>>> > > > > +};
>>> > > > > +
>>> > > > > +/* SID register flags */
>>> > > > > +enum {
>>> > > > > +    REG_PRCTL_WRITE   =3D 0x0002, /* Unknown write flag */
>>> > > > > +    REG_PRCTL_OP_LOCK =3D 0xAC00, /* Lock operation */
>>> > > > > +};
>>> > > > > +
>>> > > > > +static uint64_t allwinner_sid_read(void *opaque, hwaddr offset=
,
>>> > > > > +                                   unsigned size)
>>> > > > > +{
>>> > > > > +    const AwSidState *s =3D AW_SID(opaque);
>>> > > > > +    uint64_t val =3D 0;
>>> > > > > +
>>> > > > > +    switch (offset) {
>>> > > > > +    case REG_PRCTL:    /* Control */
>>> > > > > +        val =3D s->control;
>>> > > > > +        break;
>>> > > > > +    case REG_RDKEY:    /* Read Key */
>>> > > > > +        val =3D s->rdkey;
>>> > > > > +        break;
>>> > > > > +    default:
>>> > > > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offs=
et
>>> > > 0x%04x\n",
>>> > > > > +                      __func__, (uint32_t)offset);
>>> > > > > +        return 0;
>>> > > > > +    }
>>> > > > > +
>>> > > > > +    trace_allwinner_sid_read(offset, val, size);
>>> > > > > +
>>> > > > > +    return val;
>>> > > > > +}
>>> > > > > +
>>> > > > > +static void allwinner_sid_write(void *opaque, hwaddr offset,
>>> > > > > +                                uint64_t val, unsigned size)
>>> > > > > +{
>>> > > > > +    AwSidState *s =3D AW_SID(opaque);
>>> > > > > +
>>> > > > > +    trace_allwinner_sid_write(offset, val, size);
>>> > > > > +
>>> > > > > +    switch (offset) {
>>> > > > > +    case REG_PRCTL:    /* Control */
>>> > > > > +        s->control =3D val;
>>> > > > > +
>>> > > > > +        if ((s->control & REG_PRCTL_OP_LOCK) &&
>>> > > > > +            (s->control & REG_PRCTL_WRITE)) {
>>> > > > > +            uint32_t id =3D s->control >> 16;
>>> > > > > +
>>> > > > > +            if (id < sizeof(QemuUUID)) {
>>> > > > > +                s->rdkey =3D (s->identifier.data[id]) |
>>> > > > > +                           (s->identifier.data[id + 1] << 8) |
>>> > > > > +                           (s->identifier.data[id + 2] << 16) =
|
>>> > > > > +                           (s->identifier.data[id + 3] << 24);

Maybe you want:

  s->rdkey =3D ldl_le_p(s->identifier.data);

>>> > > > > +            }
>>> > > > > +        }
>>> > > > > +        s->control &=3D ~REG_PRCTL_WRITE;
>>> > > > > +        break;
>>> > > > > +    case REG_RDKEY:    /* Read Key */
>>> > > > > +        break;
>>> > > > > +    default:
>>> > > > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offs=
et
>>> > > 0x%04x\n",
>>> > > > > +                      __func__, (uint32_t)offset);
>>> > > > > +        break;
>>> > > > > +    }
>>> > > > > +}
> > > > > +}
[...]


