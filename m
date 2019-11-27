Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BOUND_DIGITS_15,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBC1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA42A2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz6tCNLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA42A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZwKA-0000Ie-4N
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 07:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZwJF-00087l-CR
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZwJD-0007n0-J1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:20:41 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZwJD-0007mL-CQ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:20:39 -0500
Received: by mail-ot1-x343.google.com with SMTP id r27so4363728otc.8
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 04:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=279Fmm/vsf0UQqCpTtaG+gB5Ik8aR3mquYi0KYl8n7s=;
 b=Bz6tCNLP/DfrF6QfcefEfT1/JzKdYR1eKfsl83+jwp3qq/XMUdA0j93GX24U7CmZjY
 RQb6+U21dh7kG5GXvz3WlrA4yt1uocamFJYcrtYJacdX9pn6/l/TNXYXHBq1NnsgTryt
 N+dvn9bgpp2WH1ti/HUPRmMq6Ow0aEF2bmDyRPEXj5lDp11gnX2RmbwkBIqyy0ea2mul
 3UqnLFCUQ6KVQiqjtnpPmasVG5q/L6M7VLHTLSFJpB4KbcWIJl6RP0A6pn1kAs2cysXP
 9YOwIOfvcTktbY6jox7/0Tmfc/8+8yUSPjfXsGtsjd1N8IMY2/bxGX6ZUwZTct8JhQ4o
 j3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=279Fmm/vsf0UQqCpTtaG+gB5Ik8aR3mquYi0KYl8n7s=;
 b=bpsGl1LlI8g8z/RPQB+wtMLLbvQmt/irwcIHiZRT3BI8Os8zg781R9I4gVQREUKXdA
 tm530lsW9Kg3XRvATpzGGS9HMpKLl4PA8H4tEfo9ADrMopDPuvtlYZ7R+D8TPTt0IVOi
 snRf2j1mJxdrXwbHg+Uuv0e2ONTYlYjCDzeoH2dKUMhFPd13rc1KqbPlyuxViFHNugME
 7gHvId/RL1ZSFoeirMj3Ym+CYy23KEg6EkWm3vGUn3LuMF4pxNrrrfFkoT90sglv7RCD
 /4no89jQs3mDNixRfzDPerPqwoyS2w5QRhI2az8yHQYnvBFcVdy82b+6ZRXq1Ju81vBB
 gR3w==
X-Gm-Message-State: APjAAAWYYEr9COT7WzqN+OBdsd2aD1DnqsspsYm1vR+q8OU+xMlKdCg3
 43Vk/z+EpSmD/AidecAk9yfQxP3TtsCSreGg/Mw=
X-Google-Smtp-Source: APXvYqw5oRfRMp5jhFxJhUofzPKkWh7t0YkTxAics1dZ0qc8Iipwm696nLVFi3fiXQsygSztZNZxUjKr9//CbuAhyA4=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr3514745otc.295.1574857238445; 
 Wed, 27 Nov 2019 04:20:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Wed, 27 Nov 2019 04:20:37
 -0800 (PST)
In-Reply-To: <CAMxuvazMYFLqamMw6s=7=fzhNB_6kqnvnAd2_d=2pZCjQwqL3Q@mail.gmail.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-19-marcandre.lureau@redhat.com>
 <CAL1e-=huXgGw-uXtNXqu111O8yE-Jw_+vHXqE7Wfw1efPZATSw@mail.gmail.com>
 <CAMxuvawAL5wK31-BdGWNj4p8ZavMDAvtNgjJN7Yn6EhDyB-=uw@mail.gmail.com>
 <58a5a515-2244-a927-9ca7-c0bb64ceca53@redhat.com>
 <c61a0426-bf43-9afe-3110-51bb11d75bd1@redhat.com>
 <8992c003-5d65-77e9-17eb-592449cf9fdc@redhat.com>
 <CAMxuvazMYFLqamMw6s=7=fzhNB_6kqnvnAd2_d=2pZCjQwqL3Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 27 Nov 2019 13:20:37 +0100
Message-ID: <CAL1e-=i32Wpd1FqL8TD-oDZxwyF+U2P4QGvtFaR+jBi2xktN3w@mail.gmail.com>
Subject: Re: [PATCH v4 18/37] mips: baudbase is 115200 by default
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004504890598530697"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004504890598530697
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 27, 2019, Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Hi
>
> On Mon, Nov 25, 2019 at 5:04 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > On 11/25/19 1:54 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > On 11/25/19 12:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > >> On 11/25/19 11:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> > >>> Hi
> > >>>
> > >>> On Mon, Nov 25, 2019 at 2:07 PM Aleksandar Markovic
> > >>> <aleksandar.m.mail@gmail.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau
> > >>>> <marcandre.lureau@redhat.com> wrote:
> > >>>>>
> > >>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
> > >>>>> ---
> > >>>>>   hw/mips/mips_mipssim.c | 1 -
> > >>>>>   1 file changed, 1 deletion(-)
> > >>>>>
> > >>>>> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> > >>>>> index bfafa4d7e9..3cd0e6eb33 100644
> > >>>>> --- a/hw/mips/mips_mipssim.c
> > >>>>> +++ b/hw/mips/mips_mipssim.c
> > >>>>> @@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)
> > >>>>>       if (serial_hd(0)) {
> > >>>>>           DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
> > >>>>>
> > >>>>> -        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
> > >>>>>           qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> > >>>>>           qdev_set_legacy_instance_id(dev, 0x3f8, 2);
> > >>>>>           qdev_init_nofail(dev);
> > >>>>> --
> > >>>>
> > >>>>
> > >>>> Please mention in your commit message where the default baudbase i=
s
> > >>>> set.
> > >>>
> > >>> ok
> > >>>
> > >>>> Also, is there a guarantie that default value 115200 will never
> > >>>> change in future?
> > >>>
> > >>> The level of stability on properties in general is unclear to me.
> > >>>
> > >>> Given that 115200 is standard for serial, it is unlikely to change
> > >>> though.. We can have an assert there instead?
> > >>>
> > >>> Peter, what do you think? thanks
> >
> > IOW, until we merge Damien's "Clock framework API" series, I'd:
> >
> > - rename 'baudbase' -> 'input_frequency_hz'
> >
> > - set a 0 default value
> >
> >   DEFINE_PROP_UINT32("input-frequency-hz", SerialState,
> >                       input_frequency_hz, 0),
> >
> > - add a check in serial_realize()
> >
> >      if (s->input_frequency_hz =3D=3D 0) {
> >          error_setg(errp,
> >                "serial: input-frequency-hz property must be set");
> >          return;
> >      }
> >
> > [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg642174.html
> >
>
> This is getting further away from this series goal, and my initial
> goal. Let's add this to the backlog. I can drop a FIXME there.


I agree. But please update commit message and/or add FIXME so that future
readers are given at least some background.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


>
> > >> This property confused me by the past. It is _not_ the baudrate.
> > >> It is the input frequency clocking the UART ('XIN' pin, Xtal INput).
> > >>
> > >> Each board has its own frequency, and it can even be variable (the
> > >> clock domain tree can reconfigure it at a different rate).
> > >
> > > Laurent pointed me to the following commit which confirms my
> > > interpretation:
> > >
> > > $ git show 038eaf82c853
> > > commit 038eaf82c853f3bf8d4c106c0677bbf4adada7de
> > > Author: Stefan Weil <weil@mail.berlios.de>
> > > Date:   Sat Oct 31 11:28:11 2009 +0100
> > >
> > >      serial: Add interface to set reference oscillator frequency
> > >
> > >      Many (most?) serial interfaces have a programmable
> > >      clock which provides the reference frequency ("baudbase").
> > >      So a fixed baudbase which is only set once can be wrong.
> > >
> > >      omap1.c is an example which could use the new interface
> > >      to change baudbase when the programmable clock changes.
> > >      ar7 system emulation (still not part of standard QEMU)
> > >      is similar to omap and already uses serial_set_frequency.
> > >
> > >      Signed-off-by: Stefan Weil <weil@mail.berlios.de>
> > >      Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
> > >
> > > diff --git a/hw/pc.h b/hw/pc.h
> > > index 15fff8d103..03ffc91536 100644
> > > --- a/hw/pc.h
> > > +++ b/hw/pc.h
> > > @@ -13,6 +13,7 @@ SerialState *serial_mm_init (target_phys_addr_t bas=
e,
> > > int it_shift,
> > >                                qemu_irq irq, int baudbase,
> > >                                CharDriverState *chr, int ioregister);
> > >   SerialState *serial_isa_init(int index, CharDriverState *chr);
> > > +void serial_set_frequency(SerialState *s, uint32_t frequency);
> > >
> > >   /* parallel.c */
> > >
> > > diff --git a/hw/serial.c b/hw/serial.c
> > > index fa12dcc075..0063260569 100644
> > > --- a/hw/serial.c
> > > +++ b/hw/serial.c
> > > @@ -730,6 +730,13 @@ static void serial_init_core(SerialState *s)
> > >                             serial_event, s);
> > >   }
> > >
> > > +/* Change the main reference oscillator frequency. */
> > > +void serial_set_frequency(SerialState *s, uint32_t frequency)
> > > +{
> > > +    s->baudbase =3D frequency;
> > > +    serial_update_parameters(s);
> > > +}
> > > +
> >
>
>

--0000000000004504890598530697
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, November 27, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Hi<br>
<br>
On Mon, Nov 25, 2019 at 5:04 PM Philippe Mathieu-Daud=C3=A9<br>
&lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<b=
r>
&gt;<br>
&gt; On 11/25/19 1:54 PM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt; On 11/25/19 12:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt;&gt; On 11/25/19 11:12 AM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; &gt;&gt;&gt; Hi<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On Mon, Nov 25, 2019 at 2:07 PM Aleksandar Markovic<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksa=
ndar.m.mail@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lure=
au<br>
&gt; &gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">ma=
rcandre.lureau@redhat.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
<br>
&gt; &gt;&gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0hw/mips/mips_mipssim.c | 1 -<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A01 file changed, 1 deletion(-)<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mip=
s_mipssim.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; index bfafa4d7e9..3cd0e6eb33 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt; --- a/hw/mips/mips_mipssim.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; +++ b/hw/mips/mips_mipssim.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -223,7 +223,6 @@ mips_mipssim_init(MachineStat=
e *machine)<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (serial_hd(0)) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceSta=
te *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32=
(DEVICE(<wbr>dev), &quot;baudbase&quot;, 115200);<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop=
_set_chr(dev, &quot;chardev&quot;, serial_hd(0));<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_=
legacy_instance_id(<wbr>dev, 0x3f8, 2);<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init=
_nofail(dev);<br>
&gt; &gt;&gt;&gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Please mention in your commit message where the defau=
lt baudbase is<br>
&gt; &gt;&gt;&gt;&gt; set.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; ok<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Also, is there a guarantie that default value 115200 =
will never<br>
&gt; &gt;&gt;&gt;&gt; change in future?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The level of stability on properties in general is unclea=
r to me.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Given that 115200 is standard for serial, it is unlikely =
to change<br>
&gt; &gt;&gt;&gt; though.. We can have an assert there instead?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Peter, what do you think? thanks<br>
&gt;<br>
&gt; IOW, until we merge Damien&#39;s &quot;Clock framework API&quot; serie=
s, I&#39;d:<br>
&gt;<br>
&gt; - rename &#39;baudbase&#39; -&gt; &#39;input_frequency_hz&#39;<br>
&gt;<br>
&gt; - set a 0 default value<br>
&gt;<br>
&gt;=C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;input-<wbr>frequency-hz&quot;, Se=
rialState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0input_frequency_hz, 0),<br>
&gt;<br>
&gt; - add a check in serial_realize()<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (s-&gt;input_frequency_hz =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;serial: i=
nput-frequency-hz property must be set&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; [*] <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg6=
42174.html" target=3D"_blank">https://www.mail-archive.com/<wbr>qemu-devel@=
nongnu.org/<wbr>msg642174.html</a><br>
&gt;<br>
<br>
This is getting further away from this series goal, and my initial<br>
goal. Let&#39;s add this to the backlog. I can drop a FIXME there.</blockqu=
ote><div><br></div><div>I agree. But please update commit message and/or ad=
d FIXME so that future readers are given at least some background.</div><di=
v><br></div><div>Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:ama=
rkovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
&gt; &gt;&gt; This property confused me by the past. It is _not_ the baudra=
te.<br>
&gt; &gt;&gt; It is the input frequency clocking the UART (&#39;XIN&#39; pi=
n, Xtal INput).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Each board has its own frequency, and it can even be variable=
 (the<br>
&gt; &gt;&gt; clock domain tree can reconfigure it at a different rate).<br=
>
&gt; &gt;<br>
&gt; &gt; Laurent pointed me to the following commit which confirms my<br>
&gt; &gt; interpretation:<br>
&gt; &gt;<br>
&gt; &gt; $ git show 038eaf82c853<br>
&gt; &gt; commit 038eaf82c853f3bf8d4c106c0677bb<wbr>f4adada7de<br>
&gt; &gt; Author: Stefan Weil &lt;<a href=3D"mailto:weil@mail.berlios.de">w=
eil@mail.berlios.de</a>&gt;<br>
&gt; &gt; Date:=C2=A0 =C2=A0Sat Oct 31 11:28:11 2009 +0100<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 serial: Add interface to set reference oscill=
ator frequency<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Many (most?) serial interfaces have a program=
mable<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 clock which provides the reference frequency =
(&quot;baudbase&quot;).<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 So a fixed baudbase which is only set once ca=
n be wrong.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 omap1.c is an example which could use the new=
 interface<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 to change baudbase when the programmable cloc=
k changes.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 ar7 system emulation (still not part of stand=
ard QEMU)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 is similar to omap and already uses serial_se=
t_frequency.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Signed-off-by: Stefan Weil &lt;<a href=3D"mai=
lto:weil@mail.berlios.de">weil@mail.berlios.de</a>&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Signed-off-by: Anthony Liguori &lt;<a href=3D=
"mailto:aliguori@us.ibm.com">aliguori@us.ibm.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/pc.h b/hw/pc.h<br>
&gt; &gt; index 15fff8d103..03ffc91536 100644<br>
&gt; &gt; --- a/hw/pc.h<br>
&gt; &gt; +++ b/hw/pc.h<br>
&gt; &gt; @@ -13,6 +13,7 @@ SerialState *serial_mm_init (target_phys_addr_t=
 base,<br>
&gt; &gt; int it_shift,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq irq, int baudbase,<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CharDriverState *chr, int ior=
egister);<br>
&gt; &gt;=C2=A0 =C2=A0SerialState *serial_isa_init(int index, CharDriverSta=
te *chr);<br>
&gt; &gt; +void serial_set_frequency(<wbr>SerialState *s, uint32_t frequenc=
y);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0/* parallel.c */<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/serial.c b/hw/serial.c<br>
&gt; &gt; index fa12dcc075..0063260569 100644<br>
&gt; &gt; --- a/hw/serial.c<br>
&gt; &gt; +++ b/hw/serial.c<br>
&gt; &gt; @@ -730,6 +730,13 @@ static void serial_init_core(SerialState *s)=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial_event, s);<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; +/* Change the main reference oscillator frequency. */<br>
&gt; &gt; +void serial_set_frequency(<wbr>SerialState *s, uint32_t frequenc=
y)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 s-&gt;baudbase =3D frequency;<br>
&gt; &gt; +=C2=A0 =C2=A0 serial_update_parameters(s);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt;<br>
<br>
</blockquote>

--0000000000004504890598530697--

