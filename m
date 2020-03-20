Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4F8C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216CB20753
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHvGmRl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216CB20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFE8Z-0007ni-AN
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 05:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jFE7w-0007J3-9r
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jFE7u-0002Kd-02
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:39:40 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jFE7t-0002J6-Jw
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:39:37 -0400
Received: by mail-lj1-x241.google.com with SMTP id a2so5678498ljk.6
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7ZBnENAXY4RdxyCMkJeQ1Fh/nGVU2maE4O6nIDs07D8=;
 b=rHvGmRl8tBN+PAtOxEi7p8dJMMOqHWpVcD+6U/ARuJ2dMgY0xNawsH4u5Op0nb6bCX
 OVQShozY3lxbiNhAm68bxHygsOm1Yw/7t/r1NDpFqwGc5d9P6usILx3lt/0EFTzzScj6
 hTABYXDFFBr5Hl+fTCKPFj2B2AHQr/WqS4xui7SjidnqOci8h597IIgQV+0Scco8XGKq
 5C6ONqSkPw0ENn2rlnBX5wKjxIXpe9BbzPyzN49twGM1h5fyOsPxLgC1M2vksy9elK5p
 K7EV2gbD7AcZh2xMWV8g+zFq74NSPakJIJtxF/q4DiikkcaWmk9ytQZG52kXDaOJTD66
 bKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7ZBnENAXY4RdxyCMkJeQ1Fh/nGVU2maE4O6nIDs07D8=;
 b=MPUz462DcEEOxuAjHWHP99pKpfmpEYhqFDOVGbjgTHHLNH4qd3V3JH9yrxxpaCo1TY
 JCqSZJT59PP0mEC267Wvd6gIyjiLWZKq8/et9HE6KpN9F0ISB/nUk5724iMEY9/kzdHq
 mqAM0BUpXCcAMDRHExtl0OEZc+ugVuffls2Xhm9Obm5NfGDFl0bfv+w1VIdbX0O3QSq4
 9waZAN8+yb8GXU8oZ4QHzkgrYKMlSy0eplrHLmeG7tzFZCvF5wK48tyv9yCGL5WXRjVY
 ra17shtJ6YbWGkvBVqh/7hglRYRutO/FYoBC61WgPuorBz9A1EJjWrySCnFdY/qzxzr7
 oLqw==
X-Gm-Message-State: ANhLgQ0bb86F2GkMY95BBYyaCR+0Df78TAjQaHCsh+q2Qec/QAnpnnNd
 YJuAyw5sgGI2kJPGkWc0kVMHDoyrVp9TuD8YLzA=
X-Google-Smtp-Source: ADFU+vsKtpVnQ1FCUcfHRtf9a1r5jZmSnGm8bGBMbt/npE6peEZf5bfBUerO3rnTtVNWNgjFWnpaUElVzVeJ9lzJDUE=
X-Received: by 2002:a2e:8994:: with SMTP id c20mr4650620lji.263.1584697175886; 
 Fri, 20 Mar 2020 02:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPV47zcqvNekcUN=fKu1-dN=Sip3XR3+ohaG22-oNDm1dceJkQ@mail.gmail.com>
 <CAFEAcA_CeGozr3MUA6N=cMQVXLjoLD0ca-gywm+MLU4unfgwGg@mail.gmail.com>
 <39f82991-6d80-ba42-c7e8-4f6120a196ac@redhat.com>
 <CAPV47zfQKCaKS3BQ4+zbFJ1KyATqgOZvtaY9n-Gh_wtFCn4trQ@mail.gmail.com>
 <871rpojto4.fsf@linaro.org>
 <CAPV47zeQFEUhFmE6jgsehUUQKrYqjtqnfUfBdaKqaEy_e=fM=g@mail.gmail.com>
 <87lfnviez6.fsf@linaro.org>
In-Reply-To: <87lfnviez6.fsf@linaro.org>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Fri, 20 Mar 2020 15:09:22 +0530
Message-ID: <CAPV47ze8XU6RceSrM9LUO58tdvP8mwShM4=_hee467n23eqn9w@mail.gmail.com>
Subject: Re: Qemu API documentation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003ece7005a14610e0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003ece7005a14610e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thansk, I will check it out.

To make my device I have used following link as reference

https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-device=
-in-qemu/

Also I have shared all the necessary files
in previous mails involved in the development and testing process of device=
.

Please check the files and let me know if needed more details.

Regards,
Priyamvad

On Fri, Mar 20, 2020, 14:24 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

>
> Priyamvad Acharya <priyamvad.agnisys@gmail.com> writes:
>
> > Thanks Alex, I will check it out.
> > Have you look at below issue which I mention in my previous email?
>
> Without seeing the full code changes it's hard to make a determination.
> But it looks like you haven't followed the template of defining the
> device type.
>
> Also have a look at tests/tcg/*/Makefile.softmmu-target for examples on
> how we build executables suitable for loading into system emulation.
>
> >
> >
> >>>> *>> qemu-system-arm: Unknown device 'soc' for default sysbusAborted
> >>>> (core>> dumped)**
> >>>>
> >>>
> >
> > On Thu, 19 Mar 2020 at 20:09, Alex Benn=C3=A9e <alex.bennee@linaro.org>
> wrote:
> >
> >>
> >> Priyamvad Acharya <priyamvad.agnisys@gmail.com> writes:
> >>
> >> > Thanks John and Peter for guiding me, but still it will be hard to
> >> > understand from source code for a newbie.
> >> >
> >> > I basically want to implement a trivial device for arm architecture
> which
> >> > basically contains register for read/write operation with a program.=
So
> >> what
> >> > are the references?
> >>
> >> I would look at hw/misc/unimp.c as a useful template for implementing =
a
> >> new device. Many boards instantiate the unimp devices for areas of SoC=
's
> >> that are not yet implemented ;-)
> >>
> >> >
> >> > I am providing pointers about my device which I am trying to
> implement:
> >> >  - I am implementing a device which will be attached to *versatilepb=
*
> >> > board, that board has* ARM926 CPU*.
> >> > - My device name is "*soc*" , whose description is in
> >> *qemu/hw/misc/soc.c*
> >> > file attached below.
> >> > - I have written below line to make my device available to qemu in
> >> > *qemu/hw/misc/Makefile.objs*.
> >> >
> >> >> *$ common-obj-$(CONFIG_SOC) +=3D soc.o *
> >> >>
> >> > - I added following lines in *qemu/hw/arm/versatilepb.c* to attach m=
y
> >> > device to board.
> >> >
> >> >>
> >> >> *#define DES_BASEADDR        0x101f5000*
> >> >>
> >> >>
> >> >>
> >> >> *    soc=3Dqdev_create(NULL, "soc");// +    qdev_init_nofail(soc);/=
/ +
> >> >> sysbus_mmio_map(SYS_BUS_DEVICE(soc), 0, DES_BASEADDR);// +*
> >> >>
> >> >
> >> > - Run below commands to build my device
> >> >
> >> >> *$ make distclean*
> >> >> *$ make -j8 -C build *
> >> >>
> >> >
> >> > - Run below command to run a bare metal program on device.
> >> >
> >> >> *$ ./qemu-system-arm -M versatilepb -nographic -kernel
> >> >> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf*
> >> >>
> >> >
> >> > -I get following output in terminal shown below
> >> >
> >> >>
> >> >>
> >> >> *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb
> >> >> -nographic -kernel
> >> >> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf
> >> >> qemu-system-arm: Unknown device 'soc' for default sysbusAborted (co=
re
> >> >> dumped)*
> >> >>
> >> >
> >> > -Here des_demo.elf is our *bare metal program* executable for
> >> *arm(926ej-s)*
> >> > processor.
> >> >
> >> > So how to resolve below issue to run executable
> >> >
> >> >>
> >> >>
> >> >> *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb
> >> >> -nographic -kernel
> >> >> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf
> >> >> qemu-system-arm: Unknown device 'soc' for default sysbusAborted (co=
re
> >> >> dumped)*
> >> >>
> >> >
> >> > test.s,test.ld,startup.S,Makefile,des_demo.c are files required for
> bare
> >> >> metal program
> >> >>
> >> >
> >> > References:
> >> >
> >> >
> >>
> https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-devi=
ce-in-qemu/
> >> >
> >> > Thanks,
> >> > Priyamvad
> >> >
> >> > On Thu, 19 Mar 2020 at 01:19, John Snow <jsnow@redhat.com> wrote:
> >> >
> >> >>
> >> >>
> >> >> On 3/18/20 7:09 AM, Peter Maydell wrote:
> >> >> > On Wed, 18 Mar 2020 at 09:55, Priyamvad Acharya
> >> >> > <priyamvad.agnisys@gmail.com> wrote:
> >> >> >>
> >> >> >> Hello developer community,
> >> >> >>
> >> >> >> I am working on implementing a custom device in Qemu, so to
> implement
> >> >> it I need documentation of functions which are used to emulate a
> >> hardware
> >> >> model in Qemu.
> >> >> >>
> >> >> >> What are the references to get it ?
> >> >> >
> >> >> > QEMU has very little documentation of its internals;
> >> >> > the usual practice is to figure things out by
> >> >> > reading the source code. What we do have is in
> >> >> > docs/devel. There are also often documentation comments
> >> >> > for specific functions in the include files where
> >> >> > those functions are declared, which form the API
> >> >> > documentation for them.
> >> >> >
> >> >>
> >> >> ^ Unfortunately true. One thing you can do is try to pick an existi=
ng
> >> >> device that's close to yours -- some donor PCI, USB etc device and
> start
> >> >> using that as a reference.
> >> >>
> >> >> If you can share (broad) details of what device you are trying to
> >> >> implement, we might be able to point you to relevant examples to us=
e
> as
> >> >> a reference.
> >> >>
> >> >> --js
> >> >>
> >> >>
> >>
> >>
> >> --
> >> Alex Benn=C3=A9e
> >>
>
>
> --
> Alex Benn=C3=A9e
>

--0000000000003ece7005a14610e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thansk, I will check=C2=A0it out.<div dir=3D"auto"><br></=
div><div dir=3D"auto">To make my device I have used following link as refer=
ence</div><div dir=3D"auto"><br></div><div dir=3D"auto"><a href=3D"https://=
devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-device-in-qemu=
/">https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-dev=
ice-in-qemu/</a><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Als=
o I have shared all the necessary files</div><div dir=3D"auto">in previous =
mails involved in the development and testing process of device.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Please check the files and=C2=A0le=
t me know if needed more=C2=A0details.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Regards,</div><div dir=3D"auto">Priyamvad=C2=A0</div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri,=
 Mar 20, 2020, 14:24 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lin=
aro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br>
Priyamvad Acharya &lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">priyamvad.agnisys@gmail.com</a>&gt; writes:<=
br>
<br>
&gt; Thanks Alex, I will check it out.<br>
&gt; Have you look at below issue which I mention in my previous email?<br>
<br>
Without seeing the full code changes it&#39;s hard to make a determination.=
<br>
But it looks like you haven&#39;t followed the template of defining the<br>
device type.<br>
<br>
Also have a look at tests/tcg/*/Makefile.softmmu-target for examples on<br>
how we build executables suitable for loading into system emulation.<br>
<br>
&gt;<br>
&gt;<br>
&gt;&gt;&gt;&gt; *&gt;&gt; qemu-system-arm: Unknown device &#39;soc&#39; fo=
r default sysbusAborted<br>
&gt;&gt;&gt;&gt; (core&gt;&gt; dumped)**<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;<br>
&gt; On Thu, 19 Mar 2020 at 20:09, Alex Benn=C3=A9e &lt;<a href=3D"mailto:a=
lex.bennee@linaro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@lin=
aro.org</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Priyamvad Acharya &lt;<a href=3D"mailto:priyamvad.agnisys@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">priyamvad.agnisys@gmail.com</a>&gt;=
 writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Thanks John and Peter for guiding me, but still it will be ha=
rd to<br>
&gt;&gt; &gt; understand from source code for a newbie.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I basically want to implement a trivial device for arm archit=
ecture which<br>
&gt;&gt; &gt; basically contains register for read/write operation with a p=
rogram.So<br>
&gt;&gt; what<br>
&gt;&gt; &gt; are the references?<br>
&gt;&gt;<br>
&gt;&gt; I would look at hw/misc/unimp.c as a useful template for implement=
ing a<br>
&gt;&gt; new device. Many boards instantiate the unimp devices for areas of=
 SoC&#39;s<br>
&gt;&gt; that are not yet implemented ;-)<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I am providing pointers about my device which I am trying to =
implement:<br>
&gt;&gt; &gt;=C2=A0 - I am implementing a device which will be attached to =
*versatilepb*<br>
&gt;&gt; &gt; board, that board has* ARM926 CPU*.<br>
&gt;&gt; &gt; - My device name is &quot;*soc*&quot; , whose description is =
in<br>
&gt;&gt; *qemu/hw/misc/soc.c*<br>
&gt;&gt; &gt; file attached below.<br>
&gt;&gt; &gt; - I have written below line to make my device available to qe=
mu in<br>
&gt;&gt; &gt; *qemu/hw/misc/Makefile.objs*.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; *$ common-obj-$(CONFIG_SOC) +=3D soc.o *<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt; - I added following lines in *qemu/hw/arm/versatilepb.c* to a=
ttach my<br>
&gt;&gt; &gt; device to board.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; *#define DES_BASEADDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x101f50=
00*<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; *=C2=A0 =C2=A0 soc=3Dqdev_create(NULL, &quot;soc&quot;);/=
/ +=C2=A0 =C2=A0 qdev_init_nofail(soc);// +<br>
&gt;&gt; &gt;&gt; sysbus_mmio_map(SYS_BUS_DEVICE(soc), 0, DES_BASEADDR);// =
+*<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - Run below commands to build my device<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; *$ make distclean*<br>
&gt;&gt; &gt;&gt; *$ make -j8 -C build *<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - Run below command to run a bare metal program on device.<br=
>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; *$ ./qemu-system-arm -M versatilepb -nographic -kernel<br=
>
&gt;&gt; &gt;&gt; /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_=
demo.elf*<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -I get following output in terminal shown below<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M v=
ersatilepb<br>
&gt;&gt; &gt;&gt; -nographic -kernel<br>
&gt;&gt; &gt;&gt; /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_=
demo.elf<br>
&gt;&gt; &gt;&gt; qemu-system-arm: Unknown device &#39;soc&#39; for default=
 sysbusAborted (core<br>
&gt;&gt; &gt;&gt; dumped)*<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -Here des_demo.elf is our *bare metal program* executable for=
<br>
&gt;&gt; *arm(926ej-s)*<br>
&gt;&gt; &gt; processor.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; So how to resolve below issue to run executable<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M v=
ersatilepb<br>
&gt;&gt; &gt;&gt; -nographic -kernel<br>
&gt;&gt; &gt;&gt; /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_=
demo.elf<br>
&gt;&gt; &gt;&gt; qemu-system-arm: Unknown device &#39;soc&#39; for default=
 sysbusAborted (core<br>
&gt;&gt; &gt;&gt; dumped)*<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; test.s,test.ld,startup.S,Makefile,des_demo.c are files requir=
ed for bare<br>
&gt;&gt; &gt;&gt; metal program<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; References:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; <a href=3D"https://devkail.wordpress.com/2014/12/16/emulation-of-d=
es-encryption-device-in-qemu/" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-de=
vice-in-qemu/</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks,<br>
&gt;&gt; &gt; Priyamvad<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Thu, 19 Mar 2020 at 01:19, John Snow &lt;<a href=3D"mailto=
:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a=
>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On 3/18/20 7:09 AM, Peter Maydell wrote:<br>
&gt;&gt; &gt;&gt; &gt; On Wed, 18 Mar 2020 at 09:55, Priyamvad Acharya<br>
&gt;&gt; &gt;&gt; &gt; &lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">priyamvad.agnisys@gmail.com</a>&gt; wro=
te:<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; Hello developer community,<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; I am working on implementing a custom device in =
Qemu, so to implement<br>
&gt;&gt; &gt;&gt; it I need documentation of functions which are used to em=
ulate a<br>
&gt;&gt; hardware<br>
&gt;&gt; &gt;&gt; model in Qemu.<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; What are the references to get it ?<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; QEMU has very little documentation of its internals;=
<br>
&gt;&gt; &gt;&gt; &gt; the usual practice is to figure things out by<br>
&gt;&gt; &gt;&gt; &gt; reading the source code. What we do have is in<br>
&gt;&gt; &gt;&gt; &gt; docs/devel. There are also often documentation comme=
nts<br>
&gt;&gt; &gt;&gt; &gt; for specific functions in the include files where<br=
>
&gt;&gt; &gt;&gt; &gt; those functions are declared, which form the API<br>
&gt;&gt; &gt;&gt; &gt; documentation for them.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; ^ Unfortunately true. One thing you can do is try to pick=
 an existing<br>
&gt;&gt; &gt;&gt; device that&#39;s close to yours -- some donor PCI, USB e=
tc device and start<br>
&gt;&gt; &gt;&gt; using that as a reference.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; If you can share (broad) details of what device you are t=
rying to<br>
&gt;&gt; &gt;&gt; implement, we might be able to point you to relevant exam=
ples to use as<br>
&gt;&gt; &gt;&gt; a reference.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; --js<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Alex Benn=C3=A9e<br>
&gt;&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div>

--0000000000003ece7005a14610e0--

