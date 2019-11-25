Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31547C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 19:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F074420659
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 19:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsBkldm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F074420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZJpc-0005Ew-Ut
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 14:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iZJnw-0004na-O5
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iZJnt-0002Yw-I2
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:13:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iZJnt-0002Yk-Ct
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574709224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOpmUSH/Q3EnDh/123vmQRfm2DJMSjjY/nJYpXZR/P8=;
 b=hsBkldm721Wh6avHC2YxaD0npMhbpMUYhnkqMIh3whgBE4zGt4wuG830LAwwvnxQlu8m73
 IPUs0SloNmc10nA794fAQaJQXbHT9mx28kruaqHG5jryM3YN3RW8BKLeiP1iiz5xRjgTau
 8oyJ8jeDHoZQ3Ea+m5lkXsyynH/nD2k=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-SQD97dVfPwa-RWsJ4oQuCw-1; Mon, 25 Nov 2019 14:13:43 -0500
Received: by mail-ot1-f71.google.com with SMTP id 109so8674962otv.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 11:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fOpmUSH/Q3EnDh/123vmQRfm2DJMSjjY/nJYpXZR/P8=;
 b=Si277h44rz5FGcayH09iCNcrvyodFenhQA9P7E16QRB9oE5iXUJvJ79WkcKeV1mS4n
 pBMaEcy9FdhsTL3h8oAMWu8ulS504fyPEaMjUsFkeIkvExGPSn2dEvu14o/13RGKzNKg
 joBmX7iEHADO9pG89MT0ajEs1Y0GaKdzM8EcGtG00JiXrD/w5mRE26pjmETkMpYWgg+p
 hdGGiw5wA3QuhlN5neK9j+X5CWZWX1n7MI5nlUtNKyNb3vJMFEk1esrE5tyVj0BXWa/M
 N61AeAoLCbV1FbazDjVI8xj1ed+ajV6R9iOIRcrXvh7HSLCOoDLt/fwN0awLP3spFVdh
 e74g==
X-Gm-Message-State: APjAAAUM6RaT2nvS1FzjVAqL2L8u8Wmx4SmJgCZshjHEotyd+MjOiTrN
 eOYdtdA9G1XVSjHUzGvF1ju2Zgd8lIhki1TKdYFlPd2AtFW8Mm9d2IDhe6Nm0Wx6MvqlgWeDcx1
 zOdiuevMi1cdWzVKjlqarKM47M5mh/3k=
X-Received: by 2002:a05:6830:164a:: with SMTP id
 h10mr20377411otr.62.1574709221990; 
 Mon, 25 Nov 2019 11:13:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqx71uAfRjEkXdM4DhJSIMxpB0i67kpzgSsytiaR1lV+W2T+LqV0Knh98wdLkuiRVI0A6fSHNbrgFkUDtcza/c8=
X-Received: by 2002:a05:6830:164a:: with SMTP id
 h10mr20377389otr.62.1574709221579; 
 Mon, 25 Nov 2019 11:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-18-marcandre.lureau@redhat.com>
 <CAL1e-=iqhBRcscTEDHczoqTGbCZnu386AX-WHnVdq-0uYA25ug@mail.gmail.com>
 <CAMxuvaxeNQae2iN63CvskxjOiug3dTocaqri4rU9fO6nkz+2Hw@mail.gmail.com>
 <CAL1e-=iYiqdo2owtZk=BXwkBYchE8UbfkceZO_ncNJrVCadSUw@mail.gmail.com>
In-Reply-To: <CAL1e-=iYiqdo2owtZk=BXwkBYchE8UbfkceZO_ncNJrVCadSUw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 25 Nov 2019 23:13:24 +0400
Message-ID: <CAMxuvaykny7H++bz06kN6xAPRS40LawF+H-COU+3K01w_Oy-hQ@mail.gmail.com>
Subject: Re: [PATCH v4 17/37] mips: inline serial_init()
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
X-MC-Unique: SQD97dVfPwa-RWsJ4oQuCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 25, 2019 at 5:33 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Monday, November 25, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lureau@re=
dhat.com> wrote:
>>
>> Hi
>>
>> On Mon, Nov 25, 2019 at 2:12 PM Aleksandar Markovic
>> <aleksandar.m.mail@gmail.com> wrote:
>> >
>> >
>> >
>> > On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lur=
eau@redhat.com> wrote:
>> >>
>> >> The function is specific to mipssim, let's inline it.
>> >>
>> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> ---
>> >>  hw/char/serial.c         | 16 ----------------
>> >>  hw/mips/mips_mipssim.c   | 15 ++++++++++++---
>> >>  include/hw/char/serial.h |  2 --
>> >>  3 files changed, 12 insertions(+), 21 deletions(-)
>> >>
>> >> diff --git a/hw/char/serial.c b/hw/char/serial.c
>> >> index 164146ede8..23f0b02516 100644
>> >> --- a/hw/char/serial.c
>> >> +++ b/hw/char/serial.c
>> >> @@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {
>> >>      .class_init =3D serial_io_class_init,
>> >>  };
>> >>
>> >> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
>> >> -                         Chardev *chr, MemoryRegion *system_io)
>> >> -{
>> >> -    SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
>> >> -
>> >> -    qdev_prop_set_uint32(DEVICE(sio), "baudbase", baudbase);
>> >> -    qdev_prop_set_chr(DEVICE(sio), "chardev", chr);
>> >> -    qdev_set_legacy_instance_id(DEVICE(sio), base, 2);
>> >> -    qdev_init_nofail(DEVICE(sio));
>> >> -
>> >> -    sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);
>> >> -    memory_region_add_subregion(system_io, base, &sio->serial.io);
>> >> -
>> >> -    return sio;
>> >> -}
>> >> -
>> >>  static Property serial_properties[] =3D {
>> >>      DEFINE_PROP_CHR("chardev", SerialState, chr),
>> >>      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
>> >> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
>> >> index 282bbecb24..bfafa4d7e9 100644
>> >> --- a/hw/mips/mips_mipssim.c
>> >> +++ b/hw/mips/mips_mipssim.c
>> >> @@ -40,6 +40,7 @@
>> >>  #include "hw/loader.h"
>> >>  #include "elf.h"
>> >>  #include "hw/sysbus.h"
>> >> +#include "hw/qdev-properties.h"
>> >>  #include "exec/address-spaces.h"
>> >>  #include "qemu/error-report.h"
>> >>  #include "sysemu/qtest.h"
>> >> @@ -219,9 +220,17 @@ mips_mipssim_init(MachineState *machine)
>> >>       * A single 16450 sits at offset 0x3f8. It is attached to
>> >>       * MIPS CPU INT2, which is interrupt 4.
>> >>       */
>> >> -    if (serial_hd(0)) a
>> >> -        serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
>> >> -                    get_system_io());
>> >> +    if (serial_hd(0)) {
>> >> +        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
>> >> +
>> >> +        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
>> >> +        qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>> >> +        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>> >> +        qdev_init_nofail(dev);
>> >> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
>> >> +        memory_region_add_subregion(get_system_io(), 0x3f8,
>> >> +                                    &SERIAL_IO(dev)->serial.io);
>> >> +    }
>> >
>> >
>> >
>> > Please explain why the code in the deleted function and the new functi=
on are not identical. Why is the new code better?
>>
>> What differences do you spot?
>>
>> serial_init() looks very generic, but it is not, and this is
>> confusing. QDev users should call qdev_create().
>>
>> If there is a single user, it is better to inline the code where it is
>> being used, or move the function there.
>>
>
> Marc-Andre, you misunderstood me: I am not complaining about inlining at =
all, I would do the same if I were you.
>
> I just see you expressed the same thing from former function in a slightl=
y different way in the inlined version, and they look functionally equivale=
nt to me. But I suppose the new way is better, and I want to know why. Is i=
t a more standard way, or something even more? Please understand that I don=
't come from device emulation background - I want to learn a little bit abo=
ut device-related QEMU customs and conventions, that is all. :)
>
> For example,
>
> in old version:
>
> >> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> >> -                         Chardev *chr, MemoryRegion *system_io)
> >> -{
> >> -    SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
> >> -
> >> -    qdev_prop_set_uint32(DEVICE(sio), "baudbase", baudbase);
> >> -    qdev_prop_set_chr(DEVICE(sio), "chardev", chr);
> >> -    qdev_set_legacy_instance_id(DEVICE(sio), base, 2);
> >> -    qdev_init_nofail(DEVICE(sio));
> >> -
> >> -    sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);
> >> -    memory_region_add_subregion(system_io, base, &sio->serial.io);
> >> -
> >> -    return sio;
> >> -}
>
> in new version:
>
>  >> +    if (serial_hd(0)) {
> >> +        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
> >> +
> >> +        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
> >> +        qdev_prop_set_chr(dev, "chardev", serial_hd(0));   <-- you di=
dn't use here DEVICE(), while it is used in the previous line, and also in =
the old version, and similar questions
> >> +        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
> >> +        qdev_init_nofail(dev);
> >> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> >> +        memory_region_add_subregion(get_system_io(), 0x3f8,
> >> +                                    &SERIAL_IO(dev)->serial.io);
> >> +    }
>
> For you all these details are probably perfectly natural and obvois, but =
not for me.

Oh, there is no big difference between a variable using the base type
DeviceState * or the instance type SerialIO *.

Basically, you need a variable to hold the instance, and then you cast
it with DEVICE() or SERIAL_IO() or event SYS_BUS_DEVICE() as
necessary, depending on what type the function you call expect.

I probably picked DeviceState* because it is the most commonly used,
and it avoids having plenty of DEVICE() casts.


