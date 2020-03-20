Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AF3C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 03:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E182070A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 03:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA+JEIbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E182070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF8Iv-0002qf-5l
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 23:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jF8IG-0002SB-U5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 23:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jF8IE-0002JX-Vo
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 23:25:56 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jF8IE-0002Iy-K5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 23:25:54 -0400
Received: by mail-lj1-x244.google.com with SMTP id a2so4918785ljk.6
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 20:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fogKDweCgcrlNWLOawhV94g4rIJi5aOcmGbqKpT+wdM=;
 b=dA+JEIbpnoWbftj6RUZ0o9rwk8ByNtnXq7KG9ka7vQ50RZ/vxajuI84xNNzcp0lteY
 PNgENY5Kr8oGJTChSqoaFIyrr4Q879VXgAEKvzb9L6XVKt/dEO8WzIBLqtG9jCpuUrzM
 +Ja3fBirhrr42Vo4XR8vztMC/dpC/RywuV5YvRME1Js8zCq2a8nsLZDxYiQ3Q5W+gqx9
 8hwiYKt47Da/uIrXDtuJ+S2FyPyDQvZe8aCVjby3f4Q1mm8LI2T5qWXuhsEKBBD4LynW
 iWv6GpNi4qHVP+VkgP/q0BnD4PG1fJoBBOaUanBs0yksSIblqict0KCagBqKwrIi7Dw5
 1CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fogKDweCgcrlNWLOawhV94g4rIJi5aOcmGbqKpT+wdM=;
 b=L7rlIWWuS01m8LOqqhWR+mIlosMYesHtfZUPY2qm3giQGYy3PK3ho9s05+Xbnx6vCw
 rLic/Ah4+v+N9WXx8pYARDUi/gIIjJL2g5lWW078nDqVXzkFFJnnVGx6K8xVJu9SX7NP
 t2/whqQ8SMoyfMGG6Uc/x5f07wK7RvI8CqdvNujDDOR38wvfH5Mabu25PQHVKuKB2vu5
 iJFjaRy+/uFWsJOcK9QBiB0U/qQDsWyBJ3ByyrH2fNlKXSZobvo9NuHD2X4468pzNrGQ
 Nc3k9aSHFeQyqQAAH27cZtSmXAILQ+f4wueNtIFGdQ2zdjdDwkzgGGBKD9aaBh/udigi
 KkTg==
X-Gm-Message-State: ANhLgQ2TX5Vqq/f4/2dr70kOyqKYAaXdrJ+oRYyK1VNaqNLrm+DpWczG
 mJnB5hM03BwiNLgWhr4PCAkrv5NzoAKwH/m++js=
X-Google-Smtp-Source: ADFU+vv7Ij4iAyvZzLxYF1vLBw6vIKT9gVegqz1u7g9UTSOaa0qyvzDbPo6ik+iJ6Fgb9ZFLvB5rdmLwn4/NJiHWkJw=
X-Received: by 2002:a2e:8994:: with SMTP id c20mr3850542lji.263.1584674752784; 
 Thu, 19 Mar 2020 20:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAPV47zcqvNekcUN=fKu1-dN=Sip3XR3+ohaG22-oNDm1dceJkQ@mail.gmail.com>
 <CAFEAcA_CeGozr3MUA6N=cMQVXLjoLD0ca-gywm+MLU4unfgwGg@mail.gmail.com>
 <39f82991-6d80-ba42-c7e8-4f6120a196ac@redhat.com>
 <CAPV47zfQKCaKS3BQ4+zbFJ1KyATqgOZvtaY9n-Gh_wtFCn4trQ@mail.gmail.com>
 <871rpojto4.fsf@linaro.org>
In-Reply-To: <871rpojto4.fsf@linaro.org>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Fri, 20 Mar 2020 08:55:40 +0530
Message-ID: <CAPV47zeQFEUhFmE6jgsehUUQKrYqjtqnfUfBdaKqaEy_e=fM=g@mail.gmail.com>
Subject: Re: Qemu API documentation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b96ad805a140d730"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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

--000000000000b96ad805a140d730
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Alex, I will check it out.
Have you look at below issue which I mention in my previous email?


>>> *>> qemu-system-arm: Unknown device 'soc' for default sysbusAborted
>>> (core>> dumped)**
>>>
>>

On Thu, 19 Mar 2020 at 20:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

>
> Priyamvad Acharya <priyamvad.agnisys@gmail.com> writes:
>
> > Thanks John and Peter for guiding me, but still it will be hard to
> > understand from source code for a newbie.
> >
> > I basically want to implement a trivial device for arm architecture whi=
ch
> > basically contains register for read/write operation with a program.So
> what
> > are the references?
>
> I would look at hw/misc/unimp.c as a useful template for implementing a
> new device. Many boards instantiate the unimp devices for areas of SoC's
> that are not yet implemented ;-)
>
> >
> > I am providing pointers about my device which I am trying to implement:
> >  - I am implementing a device which will be attached to *versatilepb*
> > board, that board has* ARM926 CPU*.
> > - My device name is "*soc*" , whose description is in
> *qemu/hw/misc/soc.c*
> > file attached below.
> > - I have written below line to make my device available to qemu in
> > *qemu/hw/misc/Makefile.objs*.
> >
> >> *$ common-obj-$(CONFIG_SOC) +=3D soc.o *
> >>
> > - I added following lines in *qemu/hw/arm/versatilepb.c* to attach my
> > device to board.
> >
> >>
> >> *#define DES_BASEADDR        0x101f5000*
> >>
> >>
> >>
> >> *    soc=3Dqdev_create(NULL, "soc");// +    qdev_init_nofail(soc);// +
> >> sysbus_mmio_map(SYS_BUS_DEVICE(soc), 0, DES_BASEADDR);// +*
> >>
> >
> > - Run below commands to build my device
> >
> >> *$ make distclean*
> >> *$ make -j8 -C build *
> >>
> >
> > - Run below command to run a bare metal program on device.
> >
> >> *$ ./qemu-system-arm -M versatilepb -nographic -kernel
> >> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf*
> >>
> >
> > -I get following output in terminal shown below
> >
> >>
> >>
> >> *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb
> >> -nographic -kernel
> >> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf
> >> qemu-system-arm: Unknown device 'soc' for default sysbusAborted (core
> >> dumped)*
> >>
> >
> > -Here des_demo.elf is our *bare metal program* executable for
> *arm(926ej-s)*
> > processor.
> >
> > So how to resolve below issue to run executable
> >
> >>
> >>
> >> *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb
> >> -nographic -kernel
> >> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf
> >> qemu-system-arm: Unknown device 'soc' for default sysbusAborted (core
> >> dumped)*
> >>
> >
> > test.s,test.ld,startup.S,Makefile,des_demo.c are files required for bar=
e
> >> metal program
> >>
> >
> > References:
> >
> >
> https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-devi=
ce-in-qemu/
> >
> > Thanks,
> > Priyamvad
> >
> > On Thu, 19 Mar 2020 at 01:19, John Snow <jsnow@redhat.com> wrote:
> >
> >>
> >>
> >> On 3/18/20 7:09 AM, Peter Maydell wrote:
> >> > On Wed, 18 Mar 2020 at 09:55, Priyamvad Acharya
> >> > <priyamvad.agnisys@gmail.com> wrote:
> >> >>
> >> >> Hello developer community,
> >> >>
> >> >> I am working on implementing a custom device in Qemu, so to impleme=
nt
> >> it I need documentation of functions which are used to emulate a
> hardware
> >> model in Qemu.
> >> >>
> >> >> What are the references to get it ?
> >> >
> >> > QEMU has very little documentation of its internals;
> >> > the usual practice is to figure things out by
> >> > reading the source code. What we do have is in
> >> > docs/devel. There are also often documentation comments
> >> > for specific functions in the include files where
> >> > those functions are declared, which form the API
> >> > documentation for them.
> >> >
> >>
> >> ^ Unfortunately true. One thing you can do is try to pick an existing
> >> device that's close to yours -- some donor PCI, USB etc device and sta=
rt
> >> using that as a reference.
> >>
> >> If you can share (broad) details of what device you are trying to
> >> implement, we might be able to point you to relevant examples to use a=
s
> >> a reference.
> >>
> >> --js
> >>
> >>
>
>
> --
> Alex Benn=C3=A9e
>

--000000000000b96ad805a140d730
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Alex, I will check it out.</div><div>Have you =
look at below issue which I mention in my previous email?</div><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div>
<b>&gt;&gt; qemu-system-arm: Unknown device &#39;soc&#39; for default sysbu=
sAborted (core<br>&gt;&gt; dumped)*</b></div></blockquote></blockquote></bl=
ockquote><div>=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Thu, 19 Mar 2020 at 20:09, Alex Benn=C3=A9e &l=
t;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Priyamvad Acharya &lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" target=
=3D"_blank">priyamvad.agnisys@gmail.com</a>&gt; writes:<br>
<br>
&gt; Thanks John and Peter for guiding me, but still it will be hard to<br>
&gt; understand from source code for a newbie.<br>
&gt;<br>
&gt; I basically want to implement a trivial device for arm architecture wh=
ich<br>
&gt; basically contains register for read/write operation with a program.So=
 what<br>
&gt; are the references?<br>
<br>
I would look at hw/misc/unimp.c as a useful template for implementing a<br>
new device. Many boards instantiate the unimp devices for areas of SoC&#39;=
s<br>
that are not yet implemented ;-) <br>
<br>
&gt;<br>
&gt; I am providing pointers about my device which I am trying to implement=
:<br>
&gt;=C2=A0 - I am implementing a device which will be attached to *versatil=
epb*<br>
&gt; board, that board has* ARM926 CPU*.<br>
&gt; - My device name is &quot;*soc*&quot; , whose description is in *qemu/=
hw/misc/soc.c*<br>
&gt; file attached below.<br>
&gt; - I have written below line to make my device available to qemu in<br>
&gt; *qemu/hw/misc/Makefile.objs*.<br>
&gt;<br>
&gt;&gt; *$ common-obj-$(CONFIG_SOC) +=3D soc.o *<br>
&gt;&gt;<br>
&gt; - I added following lines in *qemu/hw/arm/versatilepb.c* to attach my<=
br>
&gt; device to board.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; *#define DES_BASEADDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x101f5000*<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; *=C2=A0 =C2=A0 soc=3Dqdev_create(NULL, &quot;soc&quot;);// +=C2=A0=
 =C2=A0 qdev_init_nofail(soc);// +<br>
&gt;&gt; sysbus_mmio_map(SYS_BUS_DEVICE(soc), 0, DES_BASEADDR);// +*<br>
&gt;&gt;<br>
&gt;<br>
&gt; - Run below commands to build my device<br>
&gt;<br>
&gt;&gt; *$ make distclean*<br>
&gt;&gt; *$ make -j8 -C build *<br>
&gt;&gt;<br>
&gt;<br>
&gt; - Run below command to run a bare metal program on device.<br>
&gt;<br>
&gt;&gt; *$ ./qemu-system-arm -M versatilepb -nographic -kernel<br>
&gt;&gt; /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf*=
<br>
&gt;&gt;<br>
&gt;<br>
&gt; -I get following output in terminal shown below<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilep=
b<br>
&gt;&gt; -nographic -kernel<br>
&gt;&gt; /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf<=
br>
&gt;&gt; qemu-system-arm: Unknown device &#39;soc&#39; for default sysbusAb=
orted (core<br>
&gt;&gt; dumped)*<br>
&gt;&gt;<br>
&gt;<br>
&gt; -Here des_demo.elf is our *bare metal program* executable for *arm(926=
ej-s)*<br>
&gt; processor.<br>
&gt;<br>
&gt; So how to resolve below issue to run executable<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilep=
b<br>
&gt;&gt; -nographic -kernel<br>
&gt;&gt; /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf<=
br>
&gt;&gt; qemu-system-arm: Unknown device &#39;soc&#39; for default sysbusAb=
orted (core<br>
&gt;&gt; dumped)*<br>
&gt;&gt;<br>
&gt;<br>
&gt; test.s,test.ld,startup.S,Makefile,des_demo.c are files required for ba=
re<br>
&gt;&gt; metal program<br>
&gt;&gt;<br>
&gt;<br>
&gt; References:<br>
&gt;<br>
&gt; <a href=3D"https://devkail.wordpress.com/2014/12/16/emulation-of-des-e=
ncryption-device-in-qemu/" rel=3D"noreferrer" target=3D"_blank">https://dev=
kail.wordpress.com/2014/12/16/emulation-of-des-encryption-device-in-qemu/</=
a><br>
&gt;<br>
&gt; Thanks,<br>
&gt; Priyamvad<br>
&gt;<br>
&gt; On Thu, 19 Mar 2020 at 01:19, John Snow &lt;<a href=3D"mailto:jsnow@re=
dhat.com" target=3D"_blank">jsnow@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 3/18/20 7:09 AM, Peter Maydell wrote:<br>
&gt;&gt; &gt; On Wed, 18 Mar 2020 at 09:55, Priyamvad Acharya<br>
&gt;&gt; &gt; &lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" target=3D"=
_blank">priyamvad.agnisys@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Hello developer community,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I am working on implementing a custom device in Qemu, so =
to implement<br>
&gt;&gt; it I need documentation of functions which are used to emulate a h=
ardware<br>
&gt;&gt; model in Qemu.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; What are the references to get it ?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; QEMU has very little documentation of its internals;<br>
&gt;&gt; &gt; the usual practice is to figure things out by<br>
&gt;&gt; &gt; reading the source code. What we do have is in<br>
&gt;&gt; &gt; docs/devel. There are also often documentation comments<br>
&gt;&gt; &gt; for specific functions in the include files where<br>
&gt;&gt; &gt; those functions are declared, which form the API<br>
&gt;&gt; &gt; documentation for them.<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt; ^ Unfortunately true. One thing you can do is try to pick an exist=
ing<br>
&gt;&gt; device that&#39;s close to yours -- some donor PCI, USB etc device=
 and start<br>
&gt;&gt; using that as a reference.<br>
&gt;&gt;<br>
&gt;&gt; If you can share (broad) details of what device you are trying to<=
br>
&gt;&gt; implement, we might be able to point you to relevant examples to u=
se as<br>
&gt;&gt; a reference.<br>
&gt;&gt;<br>
&gt;&gt; --js<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div>

--000000000000b96ad805a140d730--

