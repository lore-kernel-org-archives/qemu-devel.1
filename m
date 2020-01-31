Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB67C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 04:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA6C20708
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 04:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/ZFn7A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA6C20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixNfT-0002MC-1z
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 23:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixNek-0001xd-DR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 23:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixNeh-0004ij-Db
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 23:11:46 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixNeh-0004hv-6Z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 23:11:43 -0500
Received: by mail-oi1-x243.google.com with SMTP id a22so5964281oid.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 20:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3cASlOeLtV5shwV3o9KiBx7hM6tNYbRzmHDbSAoZZcY=;
 b=p/ZFn7A1LwXZoY7WggfczK1xLrdCBqxOSB/cT/kl8GcmdeYZ59qwGKIJzpkvxmDWzW
 zLYtSHHbSOOesvM+gHSGSkFJuMZKEwzvLNblrhGgAvAxR3PbY1uHkfehcLk74thGd0zg
 Epi7bu8cQ0+hX1X3sZupIJG04uaMsvk+CxlUMXza1lHAavnIS7iolcnF3FlJm/np4sWz
 YthE7y/lrpYxMAs6AE9CevZE90f1EBpX72ycR4kFLi89OYDKl2VyANNlMKxkzwXEr15Y
 HmFOMk9J7g7rHdp0VQchms8rzH0GZJL3yUCk2lYYxSaxy41zz5PrLe7iZdWDuhPnRPx+
 oZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3cASlOeLtV5shwV3o9KiBx7hM6tNYbRzmHDbSAoZZcY=;
 b=jJgMw2vOYitQqSHP1SB44JMHFxB/CM0xewwP41skfMfDShNwyWN4AJEk/yIsVTviR7
 fT8HhbLYyAxsgPmYsAG5hI6DleHhKIXx6K/Qrn86mifHCm+135ruJJc/cyOitAuCLpuZ
 cH1VSFpic6tjCkmyCsJIZjzbsmAjLyfcqwMBp1EcFSzulthUQJVuYSFaRr4V3eZJYAlb
 O4bAfyBoHAz1fSjhM1R2vII+a/4q4xfa4apyS/RXf2QVGQ/kCtNnlc38oA1DM9yOUrvo
 b/E1t3WG2pU7aE2viL97NkfH5H3Cfm6WPLrXI99MnSPxuYIOswJ/ifBK0aqXTBBhkEll
 QDRw==
X-Gm-Message-State: APjAAAWrZoDl7DSWCSO00BgrI0JuqKN012f6D0lVXD+Ilupv5lrZirsY
 YN4Ls/Hj0wuk7/lMsE2TBE5Gs8x5gqnJqPoNkEE=
X-Google-Smtp-Source: APXvYqwOqH4BV4G3gW3dX8eAs8yTCjPGFzI2nJ+SUuuKZlIaNTFsPfJubY8kedeiIBB634r7FZOGTgHm7AjLUGMqKoA=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr4958813oih.79.1580443902032; 
 Thu, 30 Jan 2020 20:11:42 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-25-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=j3b6Gfo4K56=tXc9jbXAy3fou5Dsxq3ns9C89mpuPXxA@mail.gmail.com>
 <CAAdtpL6F=qbWT7keQxHtacndN+JUM32tyd9vW0ZEEMYYN=a=3g@mail.gmail.com>
 <CAL1e-=hqWdFckhi30iws0_OMEB01dvs=ARTvpWrAJ4bF5qrKbQ@mail.gmail.com>
In-Reply-To: <CAL1e-=hqWdFckhi30iws0_OMEB01dvs=ARTvpWrAJ4bF5qrKbQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 31 Jan 2020 05:11:31 +0100
Message-ID: <CAL1e-=i-=NkATmB0XJ12mGBOin-OGZ5VMc1BD3O1iheNfbhBAQ@mail.gmail.com>
Subject: Re: [PATCH rc4 24/29] hw/avr: Add some ATmega microcontrollers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 4:45 AM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Fri, Jan 31, 2020 at 4:09 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> > Hi Aleksandar,
> >
> > Cc'ing Thomas & Daniel who are not lawyers but tried to explain me few
> > times how licensing works.
> >
> > On Fri, Jan 31, 2020 at 2:56 AM Aleksandar Markovic
> > <aleksandar.m.mail@gmail.com> wrote:
> > > On Fri, Jan 31, 2020 at 1:03 AM Aleksandar Markovic
> > > <aleksandar.markovic@rt-rk.com> wrote:
> > > >
> > > > From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > >
> > > > Add some AVR microcontrollers from the ATmega family:
> > > >
> > > >   - middle range: ATmega168 and ATmega328
> > > >   - high range: ATmega1280 and ATmega2560
> > > >
> > > > For product comparison:
> > > >   https://www.microchip.com/wwwproducts/ProductCompare/ATmega168P/A=
Tmega328P
> > > >   https://www.microchip.com/wwwproducts/ProductCompare/ATmega1280/A=
Tmega2560
> > > >
> > > > Datasheets:
> > > >   http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-=
PA-168A-PA-328-P-DS-DS40002061A.pdf
> > > >   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-=
AVR-Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf
> > > >
> > > > [AM: Remove word 'Atmel' from filenames and all elements of code]
> > > > Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> > > >
> > > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > > > Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> > > > ---
> > > >  hw/avr/Kconfig       |   5 +
> > > >  hw/avr/Makefile.objs |   1 +
> > > >  hw/avr/atmega.c      | 470 +++++++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  hw/avr/atmega.h      |  48 ++++++
> > > >  4 files changed, 524 insertions(+)
> > > >  create mode 100644 hw/avr/Kconfig
> > > >  create mode 100644 hw/avr/atmega.c
> > > >  create mode 100644 hw/avr/atmega.h
> > > >
> > > > diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> > > > new file mode 100644
> > > > index 0000000..9e6527e
> > > > --- /dev/null
> > > > +++ b/hw/avr/Kconfig
> > > > @@ -0,0 +1,5 @@
> > > > +config AVR_ATMEGA_MCU
> > > > +    bool
> > > > +    select AVR_TIMER16
> > > > +    select AVR_USART
> > > > +    select AVR_POWER
> > > > diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> > > > index 123f174..af0fdde 100644
> > > > --- a/hw/avr/Makefile.objs
> > > > +++ b/hw/avr/Makefile.objs
> > > > @@ -1 +1,2 @@
> > > >  obj-y +=3D boot.o
> > > > +obj-$(CONFIG_AVR_ATMEGA_MCU) +=3D atmega.o
> > > > diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> > > > new file mode 100644
> > > > index 0000000..8cdf28b
> > > > --- /dev/null
> > > > +++ b/hw/avr/atmega.c
> > > > @@ -0,0 +1,470 @@
> > > > +/*
> > > > + * QEMU ATmega MCU
> > > > + *
> > > > + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> > > > + *
> > > > + * This work is licensed under the terms of the GNU GPLv2 or later=
.
> > > > + * See the COPYING file in the top-level directory.
> > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > + */
> > >
> > > Philippe,
> > >
> > > Michael and I already agreed at some moment that the whole target AVR
> > > should have harmonized licenses, and Sarrah agreed to change her
> > > license to achieve this. Do you agree to harmonize your licenses with
> > > the rest of the project? (This would mean changing the preable, but o=
f
> > > course you remain copyright carrier as is now.)
> >
> > What license do you want to use? I always use "GPLv2 or later" with
> > QEMU, mostly following what the others do.
> >
> > Per https://wiki.qemu.org/License:
> >
> >   Source files with no licensing information are released under the
> > GNU General Public License, version 2 or (at your option) any later
> > version.
> >
> > Reading about licensing is not fun :(
> >
>
> Philippe, here is the deal: All new files for AVR platform has the
> following preamble, that Michael chose from the outset:
>
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>
> Now, it is preferable that licenses are harmonized within a module,
> and I ask you to change the preamble to be the same as the rest of the
> module, that is all. This practically means LGPL2.1+later instead
> LGPL2.0+later. I think it is reasonable that we want to simplify out
> license stuff, not complicate it with different licenses within a
> module. There are examples of complications in cases of different
> license within the same module, so it would be ideal if we avoid such
> situations.
>

I didn't mean to scare you, I am just a developer like you, and I want
to avoid thinking about licenses, and think of our real work, so, I
gather, in my layman terms, it is better to have the same license for
the new platform in its entirety, if possible, that is all. :)

> Aleksandar
>
> > >
> > > Thanks,
> > > Aleksandar

