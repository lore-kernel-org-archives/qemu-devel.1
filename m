Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE6AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0272D22312
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgLm8H0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0272D22312
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXLOd-0008LT-W5
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 03:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iXLNg-0007g4-Ic
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iXLNe-0002GZ-HG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:30:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27679
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iXLNe-0002FP-1j
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574238629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OUE3rUtxH2aruBzNmueOYuaThREWH+pjVERvEFbZT60=;
 b=YgLm8H0Q5HiGVSCOxyJY3+JQijPrDM+HsACxGA1SuoELtPaZMFiO3MVnIOWnpt1LOu9Ome
 RDvuGPJQZxDDmBa4GnrpSLsz0l+SWj53q8Ddhto0lHc39khuc06d1EpGMuaHuGpEf7Y8kH
 tV4kgRL9+6oC/Fu4SUa9U85qECKKZ8c=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-NkJNgH86Msqz2SsjWmqw3g-1; Wed, 20 Nov 2019 03:30:28 -0500
Received: by mail-oi1-f200.google.com with SMTP id g189so12134372oif.10
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 00:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OUE3rUtxH2aruBzNmueOYuaThREWH+pjVERvEFbZT60=;
 b=LihF4Oem+Sa0vbKBlTyadW9iZqCWJBB+wQFUM9JpHkYeKEtBX5gl7fi7MVOqH1IgfR
 iy6rJhCeH+8VRBVOeEvBdW6NRL/X5ziXSv6NK/+PocfDhKmQoHYqRlmobLsRclPEqONM
 eYj3nRPnQnGB3exh2/7r0Qn3A9bwRb6eH8ZLOnWMKTZj0j1F1KF3mqPqrGLIVGL+6EdU
 qNlS5bvU2BaFObgbhoWnv+FKClyN7eBt/zA7t4NBX9g31jmuTC4+uSMHOFjq5NI9p8Uj
 AdwH+gIIxS3ikdKvevkVRX/+5Pu4nP0VdO3fo00v/faYOJWYQVRAPbrQKdwCtpzs8xqW
 2PoA==
X-Gm-Message-State: APjAAAVeSrEOFzQ1Qu00KRlxgsoZeGGfBWgZ15XCAoRt0pYfpWh36Kmt
 KJajBynjJFkgDEfGUDtHrS8H9Rwhg6O7RuUpjj4BcoXn3RoFxwa+/LSMXwxukw2ceb7HiJDZZNE
 ed300BPplhvptV7Xz0hs7H23K7y5cblk=
X-Received: by 2002:aca:4c14:: with SMTP id z20mr1751550oia.76.1574238627262; 
 Wed, 20 Nov 2019 00:30:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiJsmxSQZ3dIPyyAHCNr5dsR7GnYFDNG5vLABkLZNMCeIuIlfbr485aFA6V2OssFLppRqOjFa3cW6gyc282d0=
X-Received: by 2002:aca:4c14:: with SMTP id z20mr1751505oia.76.1574238626855; 
 Wed, 20 Nov 2019 00:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-17-marcandre.lureau@redhat.com>
 <CAFEAcA-dShnHHGEYrsmc+27aUrH7WUMn3=Pvn92B8XH=qtYFBQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-dShnHHGEYrsmc+27aUrH7WUMn3=Pvn92B8XH=qtYFBQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Nov 2019 12:30:15 +0400
Message-ID: <CAMxuvayKZXnkm_v5V1L=dE2-dJgMjcSBy0aufVjmGhLkuZW0hw@mail.gmail.com>
Subject: Re: [PATCH v3 16/33] serial-mm: use sysbus facilities
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: NkJNgH86Msqz2SsjWmqw3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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

On Mon, Nov 18, 2019 at 7:09 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Make SerialMM a regular sysbus device, by registering the irq, and the
> > mmio region. Reexport the internal serial properties.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/char/serial.c | 35 ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index 2f7667c30c..a40bc3ab81 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -1074,21 +1074,18 @@ SerialMM *serial_mm_init(MemoryRegion *address_=
space,
> >                              Chardev *chr, enum device_endian end)
> >  {
> >      SerialMM *self =3D SERIAL_MM(qdev_create(NULL, TYPE_SERIAL_MM));
> > -    SerialState *s =3D &self->serial;
> > +    MemoryRegion *mr;
> >
> >      qdev_prop_set_uint8(DEVICE(self), "regshift", regshift);
> > -    s->irq =3D irq;
> > -    qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
> > -    qdev_prop_set_chr(DEVICE(s), "chardev", chr);
> > -    qdev_prop_set_int32(DEVICE(s), "instance-id", base);
> > -    qdev_prop_set_uint8(DEVICE(s), "endianness", end);
> > -
> > -    qdev_init_nofail(DEVICE(s));
> > +    qdev_prop_set_uint32(DEVICE(self), "baudbase", baudbase);
> > +    qdev_prop_set_chr(DEVICE(self), "chardev", chr);
> > +    qdev_prop_set_int32(DEVICE(self), "instance-id", base);
> > +    qdev_prop_set_uint8(DEVICE(self), "endianness", end);
>
> (this last line should be in patch 15)
>
> >      qdev_init_nofail(DEVICE(self));
> >
> > -    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], self,
> > -                          "serial", 8 << regshift);
> > -    memory_region_add_subregion(address_space, base, &s->io);
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(self), 0, irq);
> > +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(self), 0);
> > +    memory_region_add_subregion(address_space, base, mr);
> >
> >      return self;
> >  }
> > @@ -1099,6 +1096,8 @@ static void serial_mm_instance_init(Object *o)
> >
> >      object_initialize_child(o, "serial", &self->serial, sizeof(self->s=
erial),
> >                              TYPE_SERIAL, &error_abort, NULL);
> > +
> > +    qdev_alias_all_properties(DEVICE(&self->serial), o);
> >  }
> >
> >  static Property serial_mm_properties[] =3D {
> > @@ -1107,11 +1106,25 @@ static Property serial_mm_properties[] =3D {
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > +static void serial_mm_realize(DeviceState *dev, Error **errp)
> > +{
> > +    SerialMM *self =3D SERIAL_MM(dev);
> > +    SerialState *s =3D &self->serial;
>
> Again, 'self' isn't idiomatic in QOM methods.

I made my argument earlier about why I prefer "self" even though it's
not represented today in hw/

> > +
> > +    qdev_init_nofail(DEVICE(s));
> > +
> > +    memory_region_init_io(&s->io, NULL, &serial_mm_ops[self->endiannes=
s], self,
> > +                          "serial", 8 << self->regshift);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(self), &s->io);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(self), &self->serial.irq);
> > +}
> > +
> >  static void serial_mm_class_init(ObjectClass *klass, void* data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >
> >      dc->props =3D serial_mm_properties;
> > +    dc->realize =3D serial_mm_realize;
> >  }
> >
> >  static const TypeInfo serial_mm_info =3D {
> > --
> > 2.23.0.606.g08da6496b6
>
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Does your r-b stands if I keep "self"? Or do you feel strongly about it?

thanks


