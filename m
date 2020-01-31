Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD87C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 12:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177B620707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 12:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsRF7h0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177B620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixVax-0001qA-AX
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 07:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1ixVaK-0001Ra-D2
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 07:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1ixVaH-00038y-Qg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 07:39:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1ixVaH-00035I-Dj
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 07:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580474380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2b+QgEzuVKByGjJjhYypMM6H6XjQsw9xG0hUraATwQ=;
 b=JsRF7h0GMt9jUcoKlOj7QM1joex8coEcnUvRZoZ1dCQqAd1fvzTu5H2UqtjWhk790slOdB
 U/gYORQnJ5HRroQE/hLGNJkpWqSwI1LHphVbJAilxghOH1satsVB4Pp77YUGC7XjXtTGdD
 j+nCrRG85Wq3FFdMP2X8fhUvIIhBwxM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-aGyLamc1PACa1lwZQTRh_Q-1; Fri, 31 Jan 2020 07:39:38 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so3261941wrx.22
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 04:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=T2b+QgEzuVKByGjJjhYypMM6H6XjQsw9xG0hUraATwQ=;
 b=jFFg/aqM8VpYimKEjFwTKQLAv5zP1uvGnz9gMVN4vbOIxLJLNdGN7utCZN+vklbTwJ
 HywFkSGWFaodDdm724Y8Zyz1nHlDDTGsehf9Wm6vCWqq5Yme3ZIdL18SyzksrPobdsyo
 tYX28Wm1QqyEk6TGBsEUN4f4A5Ivg1DoDUfldMczQcVJ5outHvKBok4UuTNtDAT/2ufu
 A8pI+e/U05v+hN6vt26AXuvnRGO3vGzFe/HVfkiH5W7yyFRVFKr7JXCeQHKvXDBZe81q
 Prar/SNhpsUViwqoTvY/GFII3I5QsGPxtdedP3RRd7tR+tlvXjJwdG5iUDqB5PcCAqaE
 Juzg==
X-Gm-Message-State: APjAAAW3JNY8G7bCM37JKFiNo8/mQwHev+ViSvPUd6Y1Y+IrpGyGB3kA
 kTRqCgzGjMQbedrgc8vgOZou+tSEXU6Rs0Smjdi4HyHHd+TkM5RGMHJigG4EzlfbIMnUZohYK1O
 wU4HGN4XyoGzwbgzvSnRBb5iY52+nJ/E=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr12480900wmd.39.1580474377616; 
 Fri, 31 Jan 2020 04:39:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwSIH+2vr5NdtYqIZgbb0REIT81SkRGRl/HaNr+3c9fObxbNw8xhLqeDgMhyf4FTVhXSzWZ+1LcPpD4uWrym48=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr12480881wmd.39.1580474377355; 
 Fri, 31 Jan 2020 04:39:37 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200131010941.10636-1-philmd@redhat.com>
 <20200131010941.10636-2-philmd@redhat.com>
 <87sgjv9883.fsf@linaro.org>
In-Reply-To: <87sgjv9883.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 31 Jan 2020 13:39:26 +0100
Message-ID: <CAP+75-WkRVeV3B09C7sTkzzH6DSNzO4vitTf7Q4SYBSxL1CgSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] !fixup "hw/misc: Add limited support for AVR power
 device"
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-MC-Unique: aGyLamc1PACa1lwZQTRh_Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 12:27 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > - convert DB_PRINT() to trace-events
> > - fix style/indentation
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  hw/misc/avr_power.c  | 17 +++++++++--------
> >  hw/misc/trace-events |  4 ++++
> >  2 files changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
> > index 598bc7279c..65ff7c4405 100644
> > --- a/hw/misc/avr_power.c
> > +++ b/hw/misc/avr_power.c
> > @@ -27,9 +27,7 @@
> >  #include "qemu/log.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/irq.h"
> > -
> > -#define DB_PRINT(fmt, args...) /* Nothing */
> > -/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ## =
args)*/
> > +#include "trace.h"
> >
> >  static void avr_mask_reset(DeviceState *dev)
> >  {
> > @@ -48,19 +46,20 @@ static uint64_t avr_mask_read(void *opaque, hwaddr =
offset, unsigned size)
> >      assert(offset =3D=3D 0);
> >      AVRMaskState *s =3D opaque;
> >
> > +    trace_avr_power_read(s->val);
> > +
> >      return (uint64_t)s->val;
> >  }
> >
> >  static void avr_mask_write(void *opaque, hwaddr offset,
> > -                              uint64_t val64, unsigned size)
> > +                           uint64_t val64, unsigned size)
> >  {
> >      assert(size =3D=3D 1);
> >      assert(offset =3D=3D 0);
> >      AVRMaskState *s =3D opaque;
> >      uint8_t val8 =3D val64;
> >
> > -    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
> > -
> > +    trace_avr_power_write(val8);
>
> You've dropped offset in this trace point which is probably worth
> keeping so you track where is being written to. Same with the read.

I dropped it because it is always 0x00, the register is 8bit wide. See
below, memory_region_init_io(...,1).
I thought about adding a "name" property so each instance can display
the device it belongs to, but this was too invasive, so I decided to
keep this change for later.

> >      s->val =3D val8;
> >      for (int i =3D 0; i < 8; i++) {
> >          qemu_set_irq(s->irq[i], (val8 & (1 << i)) !=3D 0);
> > @@ -71,7 +70,9 @@ static const MemoryRegionOps avr_mask_ops =3D {
> >      .read =3D avr_mask_read,
> >      .write =3D avr_mask_write,
> >      .endianness =3D DEVICE_NATIVE_ENDIAN,
> > -    .impl =3D {.max_access_size =3D 1}
> > +    .impl =3D {
> > +        .max_access_size =3D 1,
> > +    },
> >  };
> >
> >  static void avr_mask_init(Object *dev)
> > @@ -80,7 +81,7 @@ static void avr_mask_init(Object *dev)
> >      SysBusDevice *busdev =3D SYS_BUS_DEVICE(dev);
> >
> >      memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s, TYPE_AVR_M=
ASK,
> > -            0x01);
> > +                          0x01);

^ Region has only 1 address: 0x00.

> >      sysbus_init_mmio(busdev, &s->iomem);
> >
> >      for (int i =3D 0; i < 8; i++) {
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index 7f0f5dff3a..f716881bb1 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -179,3 +179,7 @@ via1_rtc_cmd_pram_read(int addr, int value) "addr=
=3D%u value=3D0x%02x"
> >  via1_rtc_cmd_pram_write(int addr, int value) "addr=3D%u value=3D0x%02x=
"
> >  via1_rtc_cmd_pram_sect_read(int sector, int offset, int addr, int valu=
e) "sector=3D%u offset=3D%u addr=3D%d value=3D0x%02x"
> >  via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int val=
ue) "sector=3D%u offset=3D%u addr=3D%d value=3D0x%02x"
> > +
> > +# avr_power.c
> > +avr_power_read(uint8_t value) "power_reduc read value:%u"
> > +avr_power_write(uint8_t value) "power_reduc write value:%u"
>
>
> --
> Alex Benn=C3=A9e
>


