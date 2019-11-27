Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121E4C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E2C2068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e47aSOYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E2C2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZw8k-0003rY-TC
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 07:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iZw6i-0002Nr-7d
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iZw6g-00071X-5T
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:07:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iZw6g-00070n-1T
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574856460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ae7dhec3yI3ra2EH/YTDMxG6Gtfwzptkk8isLD2WRXs=;
 b=e47aSOYSqfjfiFJ9Nr5im6izCabKqbjkxyG3LD4pM6RHdEqAbv0/voJoFKONQMcSrEZKgE
 Y3ZLp4wt2tJibLbITU/3O9gTeIotIJHsFR7Fx9tfkcstO0ylRTjumJ5vGIN4vMgfqmQkOu
 3MdlAzQMuuKaV3qVtb1UjTvgx/owNtY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-8jjOhsKXOmaC3YOmeJjsZQ-1; Wed, 27 Nov 2019 07:07:38 -0500
Received: by mail-ot1-f71.google.com with SMTP id c9so6437762otm.20
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 04:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ae7dhec3yI3ra2EH/YTDMxG6Gtfwzptkk8isLD2WRXs=;
 b=J+Z7BPrTJsw4zV5wpf0zNMZOA9I2U6lyP8LHfgTWs08IID4u3SCHasB857MPlB57SY
 clIVQYH6OflvTuNM6yw7laKuiKtLOqCwKSykYh/mnIm8pbYSEEKlkRTvpPQvylmn2pCS
 Fj2Jj2o41KbyGuQFkt6ZoRwwds5HMdmGA/x9TGvfAbUOaasN1PcpJU/eapr4avY4vFh6
 6ERWzRO+s7FF4gPsuj4K7mbuS+OmECEB3r6inHDvC4tGFGLqEgr2SBzd4WVLGhsWS+46
 s0wgSwmss3q9RDQxjUmoUl7yI3QbqR7bGhwLWOKWqL5RJIz/ZuPXgb85DhmIMSsYUD0f
 aa+Q==
X-Gm-Message-State: APjAAAXoU4TnFKbPaPVfs7adSWmI6El2V9R4OAlPVKoTnV6gPfqtCS7x
 BSVq3VcCqO6wZfHu1I4mhcrYZILPgDx9oVpvxmipCVsQEQCNVEaHPDWW2t7DX+7RBx1D3ZyDs5G
 CWuHSHOJQhVBlJPi18Xn/HWYnuBlXGXM=
X-Received: by 2002:aca:52c4:: with SMTP id g187mr701316oib.76.1574856458045; 
 Wed, 27 Nov 2019 04:07:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4BYDtHZrO3Pb1SPHRsyjO9uUCrJNbHlgQuUmqZZnnqcfJ/KRUHXQb2Gy4uRA9odDd+EG0Uii48OblBPg2AJA=
X-Received: by 2002:aca:52c4:: with SMTP id g187mr701291oib.76.1574856457789; 
 Wed, 27 Nov 2019 04:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-19-marcandre.lureau@redhat.com>
 <CAL1e-=huXgGw-uXtNXqu111O8yE-Jw_+vHXqE7Wfw1efPZATSw@mail.gmail.com>
 <CAMxuvawAL5wK31-BdGWNj4p8ZavMDAvtNgjJN7Yn6EhDyB-=uw@mail.gmail.com>
 <58a5a515-2244-a927-9ca7-c0bb64ceca53@redhat.com>
 <c61a0426-bf43-9afe-3110-51bb11d75bd1@redhat.com>
 <8992c003-5d65-77e9-17eb-592449cf9fdc@redhat.com>
In-Reply-To: <8992c003-5d65-77e9-17eb-592449cf9fdc@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 27 Nov 2019 16:07:26 +0400
Message-ID: <CAMxuvazMYFLqamMw6s=7=fzhNB_6kqnvnAd2_d=2pZCjQwqL3Q@mail.gmail.com>
Subject: Re: [PATCH v4 18/37] mips: baudbase is 115200 by default
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: 8jjOhsKXOmaC3YOmeJjsZQ-1
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 25, 2019 at 5:04 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 11/25/19 1:54 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 11/25/19 12:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 11/25/19 11:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> >>> Hi
> >>>
> >>> On Mon, Nov 25, 2019 at 2:07 PM Aleksandar Markovic
> >>> <aleksandar.m.mail@gmail.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau
> >>>> <marcandre.lureau@redhat.com> wrote:
> >>>>>
> >>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>>> ---
> >>>>>   hw/mips/mips_mipssim.c | 1 -
> >>>>>   1 file changed, 1 deletion(-)
> >>>>>
> >>>>> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> >>>>> index bfafa4d7e9..3cd0e6eb33 100644
> >>>>> --- a/hw/mips/mips_mipssim.c
> >>>>> +++ b/hw/mips/mips_mipssim.c
> >>>>> @@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)
> >>>>>       if (serial_hd(0)) {
> >>>>>           DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
> >>>>>
> >>>>> -        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
> >>>>>           qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> >>>>>           qdev_set_legacy_instance_id(dev, 0x3f8, 2);
> >>>>>           qdev_init_nofail(dev);
> >>>>> --
> >>>>
> >>>>
> >>>> Please mention in your commit message where the default baudbase is
> >>>> set.
> >>>
> >>> ok
> >>>
> >>>> Also, is there a guarantie that default value 115200 will never
> >>>> change in future?
> >>>
> >>> The level of stability on properties in general is unclear to me.
> >>>
> >>> Given that 115200 is standard for serial, it is unlikely to change
> >>> though.. We can have an assert there instead?
> >>>
> >>> Peter, what do you think? thanks
>
> IOW, until we merge Damien's "Clock framework API" series, I'd:
>
> - rename 'baudbase' -> 'input_frequency_hz'
>
> - set a 0 default value
>
>   DEFINE_PROP_UINT32("input-frequency-hz", SerialState,
>                       input_frequency_hz, 0),
>
> - add a check in serial_realize()
>
>      if (s->input_frequency_hz =3D=3D 0) {
>          error_setg(errp,
>                "serial: input-frequency-hz property must be set");
>          return;
>      }
>
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg642174.html
>

This is getting further away from this series goal, and my initial
goal. Let's add this to the backlog. I can drop a FIXME there.

> >> This property confused me by the past. It is _not_ the baudrate.
> >> It is the input frequency clocking the UART ('XIN' pin, Xtal INput).
> >>
> >> Each board has its own frequency, and it can even be variable (the
> >> clock domain tree can reconfigure it at a different rate).
> >
> > Laurent pointed me to the following commit which confirms my
> > interpretation:
> >
> > $ git show 038eaf82c853
> > commit 038eaf82c853f3bf8d4c106c0677bbf4adada7de
> > Author: Stefan Weil <weil@mail.berlios.de>
> > Date:   Sat Oct 31 11:28:11 2009 +0100
> >
> >      serial: Add interface to set reference oscillator frequency
> >
> >      Many (most?) serial interfaces have a programmable
> >      clock which provides the reference frequency ("baudbase").
> >      So a fixed baudbase which is only set once can be wrong.
> >
> >      omap1.c is an example which could use the new interface
> >      to change baudbase when the programmable clock changes.
> >      ar7 system emulation (still not part of standard QEMU)
> >      is similar to omap and already uses serial_set_frequency.
> >
> >      Signed-off-by: Stefan Weil <weil@mail.berlios.de>
> >      Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
> >
> > diff --git a/hw/pc.h b/hw/pc.h
> > index 15fff8d103..03ffc91536 100644
> > --- a/hw/pc.h
> > +++ b/hw/pc.h
> > @@ -13,6 +13,7 @@ SerialState *serial_mm_init (target_phys_addr_t base,
> > int it_shift,
> >                                qemu_irq irq, int baudbase,
> >                                CharDriverState *chr, int ioregister);
> >   SerialState *serial_isa_init(int index, CharDriverState *chr);
> > +void serial_set_frequency(SerialState *s, uint32_t frequency);
> >
> >   /* parallel.c */
> >
> > diff --git a/hw/serial.c b/hw/serial.c
> > index fa12dcc075..0063260569 100644
> > --- a/hw/serial.c
> > +++ b/hw/serial.c
> > @@ -730,6 +730,13 @@ static void serial_init_core(SerialState *s)
> >                             serial_event, s);
> >   }
> >
> > +/* Change the main reference oscillator frequency. */
> > +void serial_set_frequency(SerialState *s, uint32_t frequency)
> > +{
> > +    s->baudbase =3D frequency;
> > +    serial_update_parameters(s);
> > +}
> > +
>


