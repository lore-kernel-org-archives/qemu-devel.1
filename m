Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC46C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D282071C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAyc5Q+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D282071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWimh-0007UM-9f
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWiln-0006by-Hz
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWilm-000729-3c
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:16:51 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWill-00071q-QF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:16:49 -0500
Received: by mail-oi1-x244.google.com with SMTP id a14so15621288oid.5
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=opeqQ1By8GVGE1cHT+yBFuirg4hVOSqG/qOLZIMdCQA=;
 b=JAyc5Q+SSR/R8qko0HfW5lWMD5NK7N7X0ZDSqqMJ7nR2ilupyhAAgukZyMUP9yVjqw
 QmA9uzqrC+/jyuy2OvI8zs+AQ5BZqmW07zuNMOQ3ED7L8oevk5c5Iy86GT+C0e2rT/b+
 +Vs8XBHIzCwaNwLxLy/MVZgLpY4d4hsF324i8UCMyCbDCN0vPRKd9i2CLDQCrY5iDmgv
 uV0A1xOhKvxH1A9RGzBUMbRdYlAKJS5O4kKoIvfRDZelgSqj1f3kzspA8xEBAdfo8QF1
 QJF0iiXL07ppAKrZjxG33hnX70sHgdBViHPDXch68v40TtXwPcD530zx3fIcGryFTwXU
 1dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=opeqQ1By8GVGE1cHT+yBFuirg4hVOSqG/qOLZIMdCQA=;
 b=IuPV6pydzB922UKaF00XM1RLODOuCBbNEAWs1S4lhaNfJPY7L2fTbXK3lfHoweVeOv
 +iJqpTwuAgUxd9SSlexqjEukSpD3Vnc3MYhnL/QEsMz0mqm8dsDIWNnP+aj3897sUvMK
 1C2vRY0a6SAZnLPviIiTat7JTMlg6S6SgXlJZfH+YXewbHSvGdWHPjUV91zIw/HIgA+M
 axCwBjJPzrGXW6mCA+m+q4V9HmcfI6OwSeCnNo6C3eywcWzoIQu59ECQwUTjJEd2CFSG
 pA27UsKTDHgjNdRsJC0hMNy9WtFoGL0ZvC16EfL5Q1/7+Zb2Q+LC1ujAfAfD1aylcx+c
 FEXg==
X-Gm-Message-State: APjAAAWBSkKEZtWca/LDVa/HREssOSRAlXMqEHo19KnO3LxxFUMRBrPD
 zddkdKQfHMCGElThSewPWd9ImYiziuduqivFevmXDA==
X-Google-Smtp-Source: APXvYqzEo3yX3K05bCOvoHHzy6fjfjwPXNVqByEPwWJqyTqhw7FinPY+Un58yUP5zwpPIAxKzuF9tpgMLwNrrBUMyjE=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr19632781oig.48.1574090208750; 
 Mon, 18 Nov 2019 07:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-18-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-18-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 15:16:37 +0000
Message-ID: <CAFEAcA-raK3HOjQjQCaOpqo0QQdT8WChx-njh_8-26R15tunaA@mail.gmail.com>
Subject: Re: [PATCH v3 17/33] serial: make SerialIO a sysbus device
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Make serial IO a proper sysbus device, similar to serial MM.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c         | 58 ++++++++++++++++++++++++++++++++--------
>  include/hw/char/serial.h | 13 +++++++--
>  2 files changed, 58 insertions(+), 13 deletions(-)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index a40bc3ab81..84de2740a7 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -986,22 +986,57 @@ const MemoryRegionOps serial_io_ops =3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
>
> -SerialState *serial_init(int base, qemu_irq irq, int baudbase,
> -                         Chardev *chr, MemoryRegion *system_io)
> +static void serial_io_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> -    SerialState *s =3D SERIAL(dev);
> +    SerialIO *self =3D SERIAL_IO(dev);

"sio" or something rather than "self".

> +    SerialState *s =3D &self->serial;
>
> -    s->irq =3D irq;
> -    qdev_prop_set_uint32(dev, "baudbase", baudbase);
> -    qdev_prop_set_chr(dev, "chardev", chr);
> -    qdev_prop_set_int32(dev, "instance-id", base);
> -    qdev_init_nofail(dev);
> +    qdev_init_nofail(DEVICE(s));
>
>      memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
> -    memory_region_add_subregion(system_io, base, &s->io);
> +    sysbus_init_irq(SYS_BUS_DEVICE(self), &self->serial.irq);

You could say '&s->irq' here, since you have the local variable.

> +}
> +
> +static void serial_io_class_init(ObjectClass *klass, void* data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D serial_io_realize;

For class methods where the class has no data that needs
to be migrated it's helpful to have a comment
  /* No dc->vmsd: class has no migratable state */
(which lets us know that it's intentional and not a forgotten
thing). Some day I will get round to writing a patch so you
can say "dc->vmsd =3D no_migratable_state;" ...

> +}
> +
> +static void serial_io_instance_init(Object *o)
> +{
> +    SerialIO *self =3D SERIAL_IO(o);
> +
> +    object_initialize_child(o, "serial", &self->serial, sizeof(self->ser=
ial),
> +                            TYPE_SERIAL, &error_abort, NULL);
> +
> +    qdev_alias_all_properties(DEVICE(&self->serial), o);
> +}
> +
> +
> +static const TypeInfo serial_io_info =3D {
> +    .name =3D TYPE_SERIAL_IO,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(SerialIO),
> +    .instance_init =3D serial_io_instance_init,
> +    .class_init =3D serial_io_class_init,
> +};
> +
> +SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> +                         Chardev *chr, MemoryRegion *system_io)
> +{
> +    SerialIO *self =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
>
> -    return s;
> +    qdev_prop_set_uint32(DEVICE(self), "baudbase", baudbase);
> +    qdev_prop_set_chr(DEVICE(self), "chardev", chr);
> +    qdev_prop_set_int32(DEVICE(self), "instance-id", base);
> +    qdev_init_nofail(DEVICE(self));
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(self), 0, irq);
> +    memory_region_add_subregion(system_io, base, &self->serial.io);
> +
> +    return self;
>  }

thanks
-- PMM

