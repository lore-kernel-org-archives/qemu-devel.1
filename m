Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05478C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B1922419
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoVPB1Py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B1922419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXO0f-0007zM-U6
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iXNxA-00059j-2B
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iXNx8-0004Op-06
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:15:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50684
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iXNx7-0004MU-SE
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574248515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8JScVDCxeFL0hAEAFur6V/NaAmZm80CZ0SXrq1ZfYI=;
 b=XoVPB1PyaeDjp8G88wkCZNWO38KWisuFYfw/G01moJH/wPE7kErXaL5KJdxvPqPAQtB7Bk
 eLdZNXdRJ+t5SdHJEMeERaTKqbKrhhomY2v6U+jGm6zG0qp1rMsP/ZkdUuAHao9XNQuaRO
 kQozs6fIj+aktJQa3qVBs+0Z7cVIUmQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-lmQG4rqpMIa1gdVD-Owkzw-1; Wed, 20 Nov 2019 06:15:10 -0500
Received: by mail-oi1-f197.google.com with SMTP id a193so12324947oib.11
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 03:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F8JScVDCxeFL0hAEAFur6V/NaAmZm80CZ0SXrq1ZfYI=;
 b=lhPnhcpzAs5/Bd65IqsGHimXe18zvPQT0AkTYtRDGry9hgScspsszwM1advzf7nYAU
 xdFF/y6jIycOpP/Roc0n3KoogH0B5b/BIpCVpYi3oIkI1s8WWW08eQ4sEkR5l8Q6mgfj
 dBfrf0o9lxBMQQHS/+s8oa47C3EdPyyC648k3Ed3KyUfr9RVocmi1tZ0ECKjDltp0+PF
 ATnsjBiMJ2WhEhz4cFZrpyxTQUzxZzf5wD6tQ1/KaX4M5b9RI0NlYWL/LpXf0bn2srtb
 2Hc0bt+77mTsrDYY9OD4CqK9faWPDtwOXnOtNpoDQvsvV4YHk/ShrrZkR2GVTceRJSah
 XJlA==
X-Gm-Message-State: APjAAAU+8ReCBemvF2yAc+fnPnrh//GMfaYipxImzybPReRqDirUxREZ
 QFChghBjov6igr/usAu/lRkcJVRNzXGhGYukiQVS1sFw8kbljQokPJtndaAcAruUNPVt0WHUAER
 XfuIxV1UL/V3s/R9WUIEFP+JqW+8ehxU=
X-Received: by 2002:aca:484e:: with SMTP id v75mr2347937oia.6.1574248509362;
 Wed, 20 Nov 2019 03:15:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyq+eNs4/9FDLOsDGkaJ/74CaHB69/rY8dxDHxJLwIPlOXOitqfn0uFP7HtgyOEkOstsOGuwrXCNDnSxMRa+ms=
X-Received: by 2002:aca:484e:: with SMTP id v75mr2347895oia.6.1574248508897;
 Wed, 20 Nov 2019 03:15:08 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-19-marcandre.lureau@redhat.com>
 <CAFEAcA8WacEjmNT93MYyheqh8U=+7zrDbrQ1jzVO+dWdrNkVyw@mail.gmail.com>
In-Reply-To: <CAFEAcA8WacEjmNT93MYyheqh8U=+7zrDbrQ1jzVO+dWdrNkVyw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Nov 2019 15:14:57 +0400
Message-ID: <CAMxuvayF+_cJdzLtSmq6iGCuXErT-fGVxk926sRrNnjv-tXQ0w@mail.gmail.com>
Subject: Re: [PATCH v3 18/33] mips: inline serial_init
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: lmQG4rqpMIa1gdVD-Owkzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 18, 2019 at 7:25 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > The function is specific to mipssim, let's inline it.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/char/serial.c         | 16 ----------------
> >  hw/mips/mips_mipssim.c   | 13 ++++++++++---
> >  include/hw/char/serial.h |  2 --
> >  3 files changed, 10 insertions(+), 21 deletions(-)
> >
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index 84de2740a7..ca95e09ec9 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {
> >      .class_init =3D serial_io_class_init,
> >  };
> >
> > -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> > -                         Chardev *chr, MemoryRegion *system_io)
> > -{
> > -    SerialIO *self =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
> > -
> > -    qdev_prop_set_uint32(DEVICE(self), "baudbase", baudbase);
> > -    qdev_prop_set_chr(DEVICE(self), "chardev", chr);
> > -    qdev_prop_set_int32(DEVICE(self), "instance-id", base);
> > -    qdev_init_nofail(DEVICE(self));
> > -
> > -    sysbus_connect_irq(SYS_BUS_DEVICE(self), 0, irq);
> > -    memory_region_add_subregion(system_io, base, &self->serial.io);
> > -
> > -    return self;
> > -}
> > -
> >  static Property serial_properties[] =3D {
> >      DEFINE_PROP_CHR("chardev", SerialState, chr),
> >      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> > diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> > index 282bbecb24..26fb8fa4de 100644
> > --- a/hw/mips/mips_mipssim.c
> > +++ b/hw/mips/mips_mipssim.c
> > @@ -40,6 +40,7 @@
> >  #include "hw/loader.h"
> >  #include "elf.h"
> >  #include "hw/sysbus.h"
> > +#include "hw/qdev-properties.h"
> >  #include "exec/address-spaces.h"
> >  #include "qemu/error-report.h"
> >  #include "sysemu/qtest.h"
> > @@ -219,9 +220,15 @@ mips_mipssim_init(MachineState *machine)
> >       * A single 16450 sits at offset 0x3f8. It is attached to
> >       * MIPS CPU INT2, which is interrupt 4.
> >       */
> > -    if (serial_hd(0))
> > -        serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
> > -                    get_system_io());
> > +    if (serial_hd(0)) {
> > +        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
> > +
> > +        qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> > +        qdev_prop_set_int32(dev, "instance-id", 0x3f8);
> > +        qdev_init_nofail(dev);
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> > +        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8, &SERIAL_IO(dev)->ser=
ial.io);
> > +    }
>
> The code being inlined here doesn't seem to be identical to the
> code in the function above (it uses sysbus_add_io() rather than
> memory_region_add_subregion()).

sysbus_add_io() is memory_region_add_subregion(get_system_io(), ...).

I went a step too fast, let's make it a seperate patch to clarify it then.

>
> It's also a bit ugly that the code has to reach into the
> internals of the device to get the MemoryRegion pointer.
> Would it work to have the device use sysbus_init_mmio()
> in its init or realize method to register the IO port MemoryRegion,
> and then we could use sysbus_mmio_get_region() to get the
> MemoryRegion pointer ?

Sure, seems fine to me. The caller must have extra knowledge of the
memory region number though. This seems a bit fragile to me, compared
to static compilation checking.

>
> (If that does work, we should someday refactor
> sysbus_add_io() so that all the devices it's used with
> register the MemoryRegions that way, and then sysbus_add_io()
> can just take an 'int n' the way sysbus_mmio_map() does.
> But not today.)

I see, left for another day


