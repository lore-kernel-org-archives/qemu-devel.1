Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F706C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE2420722
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izKpNSJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE2420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWiuS-00016C-4J
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWiti-0000Oc-IW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWith-00018W-CC
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:25:02 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWith-000187-6G
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:25:01 -0500
Received: by mail-ot1-x342.google.com with SMTP id f10so14838890oto.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 07:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=v7RaaOkRSyWZc/HxElBd8d+wilmynyFLH1nO8DU7E/Y=;
 b=izKpNSJmP+2ovI/frmu5W5BbvQZ0fqs2hx+UJgjkXhuHl3NAOhJ+/sOOOsn6deyqA4
 B3m/hRdzmB1r4noXJ+v9XSJnVoRr5Lq67c/p7EVsNNaWipyl+FFnFgTx8TRjbykmhZCK
 7u2Nl/qFcR8Mjeld1KDq/RCxFk79C1SzHeSGwDkzHZdWCoccwjISuIfkVwZDRs7izNVW
 sPCOJ0Qr6m0Dg5K3ESsZBwVNXBfcMFDIhiN9R2q7KJKHaolJ8J9BugNw9/4lhGKiReSe
 4KAqVLZKEb/rTuitMJfnc8g7HoNvYz3p4bjbo9vtEBupw/Ckpl9tbSAxo3ffwUTK3mFs
 nHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=v7RaaOkRSyWZc/HxElBd8d+wilmynyFLH1nO8DU7E/Y=;
 b=lyBAk0zwp7uT0ogKn8axvjMqgxAxcf7mNXq1jwMRx621uyXm79Uq/tvQJ8+ETcnhM6
 NSxVZWYOO9F2x3sewmRVDTlb3SBqis1UVhNGKN0N3APQc87iUIddqVyjr+NEYnteuFoM
 E0wnddqXPxcNWEnwb0ZXwlQ3Um8te7T2pUvTYwAVTQw9QFsGeaOPgI+U2ygTTNIER82f
 4ijb5y8QUzQh+YxEktHGiz4Hf4aYOFl5GQcoQJ0n39fx/qPBmCA80vbmHYwCDtH7KIT8
 iQ9IZ7nn4SeW5arHPzUfAJ2GfZ+YWon0vZXRXDzG7PL8o2OphOs+RT3q48JXMkk41KWL
 /f7w==
X-Gm-Message-State: APjAAAV+Q6dMpq0za7BXJKM5L2YdCUtrnJ67c9/dfnCP1zklKjI1KgMJ
 1ZqOw1ukcFcUKsdRPDNCJA+a346a4mJqmmS5gLAx/Q==
X-Google-Smtp-Source: APXvYqxzG4bjh091Q64IJGz25V1c0bMeXi+82lcjLw2+fjMdfT3ohEDJMbZxqRUYaP3rFH0ynErIyrR8e1d+vi//+TQ=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr23597811otg.232.1574090700192; 
 Mon, 18 Nov 2019 07:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-19-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-19-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 15:24:48 +0000
Message-ID: <CAFEAcA8WacEjmNT93MYyheqh8U=+7zrDbrQ1jzVO+dWdrNkVyw@mail.gmail.com>
Subject: Re: [PATCH v3 18/33] mips: inline serial_init
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
> The function is specific to mipssim, let's inline it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c         | 16 ----------------
>  hw/mips/mips_mipssim.c   | 13 ++++++++++---
>  include/hw/char/serial.h |  2 --
>  3 files changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 84de2740a7..ca95e09ec9 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {
>      .class_init =3D serial_io_class_init,
>  };
>
> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> -                         Chardev *chr, MemoryRegion *system_io)
> -{
> -    SerialIO *self =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
> -
> -    qdev_prop_set_uint32(DEVICE(self), "baudbase", baudbase);
> -    qdev_prop_set_chr(DEVICE(self), "chardev", chr);
> -    qdev_prop_set_int32(DEVICE(self), "instance-id", base);
> -    qdev_init_nofail(DEVICE(self));
> -
> -    sysbus_connect_irq(SYS_BUS_DEVICE(self), 0, irq);
> -    memory_region_add_subregion(system_io, base, &self->serial.io);
> -
> -    return self;
> -}
> -
>  static Property serial_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", SerialState, chr),
>      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 282bbecb24..26fb8fa4de 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -40,6 +40,7 @@
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> @@ -219,9 +220,15 @@ mips_mipssim_init(MachineState *machine)
>       * A single 16450 sits at offset 0x3f8. It is attached to
>       * MIPS CPU INT2, which is interrupt 4.
>       */
> -    if (serial_hd(0))
> -        serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
> -                    get_system_io());
> +    if (serial_hd(0)) {
> +        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
> +
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +        qdev_prop_set_int32(dev, "instance-id", 0x3f8);
> +        qdev_init_nofail(dev);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> +        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8, &SERIAL_IO(dev)->seria=
l.io);
> +    }

The code being inlined here doesn't seem to be identical to the
code in the function above (it uses sysbus_add_io() rather than
memory_region_add_subregion()).

It's also a bit ugly that the code has to reach into the
internals of the device to get the MemoryRegion pointer.
Would it work to have the device use sysbus_init_mmio()
in its init or realize method to register the IO port MemoryRegion,
and then we could use sysbus_mmio_get_region() to get the
MemoryRegion pointer ?

(If that does work, we should someday refactor
sysbus_add_io() so that all the devices it's used with
register the MemoryRegions that way, and then sysbus_add_io()
can just take an 'int n' the way sysbus_mmio_map() does.
But not today.)

thanks
-- PMM

