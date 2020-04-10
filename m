Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329F6C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D2C206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6PoOPgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D2C206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMuoD-0006Mu-4y
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 10:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jMumz-0005JG-Qo
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jMumy-0001Aa-5Y
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:37:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jMumx-0001AC-UM
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:37:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id w10so2515221wrm.4
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/2QslIIJwniTYbB1o1fuBPOa0JnOxoRW0cGO9K6jZ2A=;
 b=D6PoOPgD8tOliaur3QfvLW2SCB9mQsTg/Er9FNUyZHx3FF5X9QC6JyBHcAlVjbEnnd
 0V/gOWZ8Y6ChEtUsFHs+hxwvYyX7f5RDUEqp4L1KsO7zXSwk5ouXsCbx+1+NcclynoUL
 gMlh8pRzI2j0YY+uqWwn7NJyBfWGsmF048WaDN4u7TgxtVVJmPfVi9aILpdWERPgtTYg
 UNbq9XgbBMIKDd29bL6Q0zUSPDAVtiQ7YupjgSoI8sAm8uuu9Udb8cjnKuwILlzx+pCL
 V7pnFmcR8DfGJGXTrJleH+IxIcg5TjAq5t0ofW61oM2sUwPr5ks5ST3QjZeeXl8VAkD+
 HPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/2QslIIJwniTYbB1o1fuBPOa0JnOxoRW0cGO9K6jZ2A=;
 b=EQvDjbWTDzb89+yuVzab3kZ7Rm6xIytj+0uLNYyh67kQuDnsEUifSo0ZYA4gW9RxEt
 4u2WmtTfWYz23WGsXsduNVer1bYCnsyQ0A1AgYC7bk5od8AIgLNUjo+0gInMq5VlKdwi
 6bwgLipuIJppQFnJRp1mKAODq4Yh7HA6Q/5Wm98BpyM1/zqd6134glTpMeh+WTmp2CVO
 DmT2eWGHrLUm/yxOCvfw6/Tc8hTGxxnjJ3M5SM5MsWgd+/U1h6lGAo1jITw1NzOqbcOZ
 vIgQMgvyKjaJbQE/CrhpL1AfrJFh1/NooFcANasQIS9gXXwDjDeFlTIhAEGg4Vu+LzxH
 lPyg==
X-Gm-Message-State: AGi0Pub4a6XGBWVL5LJ6G/svDOZwkNojeeVvmFSNB3gTx2HybjPpi8cM
 CFf3stJb0FPPUS4jCIAAc/skNgTP/iL2gI/jrQo=
X-Google-Smtp-Source: APiQypJljaJKoUQjT6ZSGNzzadNYcMarar6IeHbCbKjtb1w0+omYupeIuO/wcFGPVVIObh/cx8B6nQryycf6/XmG7D0=
X-Received: by 2002:adf:efc2:: with SMTP id i2mr4822979wrp.420.1586529466706; 
 Fri, 10 Apr 2020 07:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
 <1586337380-25217-3-git-send-email-chenhc@lemote.com>
 <CAHiYmc61GZSvvwhCaC0B5q0GrEUN3CevDvNTEEWLE9PCJqVbvw@mail.gmail.com>
 <CAAhV-H5moZ8kD5WAM1GvLRmg9spO7m=2DZZL+uUXAoo4iWZyVg@mail.gmail.com>
 <20200409103844.1591548c@flygoat-x1e>
In-Reply-To: <20200409103844.1591548c@flygoat-x1e>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 10 Apr 2020 16:37:30 +0200
Message-ID: <CAHiYmc71dZK9bYOWCQ4aA4_wTnicrpCGkuNp+h5umOwP6Q1xiA@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add myself as fulong2e co-maintainer
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="00000000000049f07a05a2f0ad65"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000049f07a05a2f0ad65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

04:39 =C4=8Cet, 09.04.2020. Jiaxun Yang <jiaxun.yang@flygoat.com> =D1=98=D0=
=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Thu, 9 Apr 2020 10:17:46 +0800
> Huacai Chen <chenhc@lemote.com> wrote:
>
> > Hi, Aleksandar,
> >
> > On Wed, Apr 8, 2020 at 11:30 PM Aleksandar Markovic
> > <aleksandar.qemu.devel@gmail.com> wrote:
> > >
> > > 11:08 Sre, 08.04.2020. Huacai Chen <chenhc@lemote.com> =D1=98=D0=B5
> > > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > > >
> > > > I submitted the MIPS/fulong2e support about ten years ago, and
> > > > after that I became a MIPS kernel developer. Last year, Philippe
> > > > Mathieu- Daud=C3=A9 asked me that whether I can be a reviewer of
> > > > MIPS/fulong2e, and I promised that I will do some QEMU work in
> > > > the next year (i.e., 2020 and later). I think now (and also in
> > > > future) I can have some spare time, so I can finally do some real
> > > > work on QEMU/MIPS. And if possible, I hope I can be a
> > > > co-maintainer of MIPS/fulong2e.
> > > >
> > > > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > > ---
> > > >  MAINTAINERS | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 642c8e0..3281ff2 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -1073,6 +1073,7 @@ F: hw/mips/mips_r4k.c
> > > >  Fulong 2E
> > > >  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > >  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > > > +M: Huacai Chen <chenhc@lemote.com>
> > > >  S: Odd Fixes
> > > >  F: hw/mips/mips_fulong2e.c
> > > >  F: hw/isa/vt82c686.c
> > > > --
> > > > 2.7.0
> > > >
> > >
> > > First of all, I want to express great pleasure and delight seing
> > > your series, and this patch in particular.
> > >
> > > A warm welcome to QEMU developers communities!
> > >
> > > We are currenyly very busy preparing QEMU 5.0 release, and
> > > additionaly, Easter holidays are in next few days or week
> > > (different parts od Christian world have different calendars), so,
> > > fot thay and other reasons, don't expect promot replies from us.
> > >
> > > I would also like to see Jiaxng at least having official reviewer
> > > status, but, of course, only if he wants that.
> > Thank you for your best wishes, I'm also very glad to see Jiaxun be
> > an reviewer.
>
> Thanks, but I was a primary school student at Loongson-2E's era, so I
> can do nothing with 2E.
>
> My experience with Loongson starts from 2F. And I'm more familiar with
> 2K and 3A.
>

OK, it makes sense. But, if you ever become wanting to be a reviewer for
Foolong 2e, just give me an email.

> I'm happy to contribute QEMU support for these platforms.
>

I am happy as well.

Best wishes and best health to you, people from China, and the whole
region!!

Yours,
Aleksandar

> Thanks.
>
> >
> > Regards,
> > Huacai
> > >
> > > Yours,
> > > and wishing you and all people from China best health!
> > >
> > > Aleksandar
>
> --
> Jiaxun Yang

--00000000000049f07a05a2f0ad65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">04:39 =C4=8Cet, 09.04.2020. Jiaxun Yang &lt;<a href=3D"mailt=
o:jiaxun.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On Thu, 9 Apr 2020 10:17:46 +0800<br>
&gt; Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote.com=
</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Hi, Aleksandar,<br>
&gt; &gt; <br>
&gt; &gt; On Wed, Apr 8, 2020 at 11:30 PM Aleksandar Markovic<br>
&gt; &gt; &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar=
.qemu.devel@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 11:08 Sre, 08.04.2020. Huacai Chen &lt;<a href=3D"mailto:che=
nhc@lemote.com">chenhc@lemote.com</a>&gt; =D1=98=D0=B5<br>
&gt; &gt; &gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:=C2=
=A0 <br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I submitted the MIPS/fulong2e support about ten years a=
go, and<br>
&gt; &gt; &gt; &gt; after that I became a MIPS kernel developer. Last year,=
 Philippe<br>
&gt; &gt; &gt; &gt; Mathieu- Daud=C3=A9 asked me that whether I can be a re=
viewer of<br>
&gt; &gt; &gt; &gt; MIPS/fulong2e, and I promised that I will do some QEMU =
work in<br>
&gt; &gt; &gt; &gt; the next year (i.e., 2020 and later). I think now (and =
also in<br>
&gt; &gt; &gt; &gt; future) I can have some spare time, so I can finally do=
 some real<br>
&gt; &gt; &gt; &gt; work on QEMU/MIPS. And if possible, I hope I can be a<b=
r>
&gt; &gt; &gt; &gt; co-maintainer of MIPS/fulong2e.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Cc: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygo=
at.com">jiaxun.yang@flygoat.com</a>&gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc=
@lemote.com">chenhc@lemote.com</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 MAINTAINERS | 1 +<br>
&gt; &gt; &gt; &gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; &gt; &gt; &gt; index 642c8e0..3281ff2 100644<br>
&gt; &gt; &gt; &gt; --- a/MAINTAINERS<br>
&gt; &gt; &gt; &gt; +++ b/MAINTAINERS<br>
&gt; &gt; &gt; &gt; @@ -1073,6 +1073,7 @@ F: hw/mips/mips_r4k.c<br>
&gt; &gt; &gt; &gt;=C2=A0 Fulong 2E<br>
&gt; &gt; &gt; &gt;=C2=A0 M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mai=
lto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 M: Aleksandar Markovic &lt;<a href=3D"mailto:alek=
sandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt;<br>
&gt; &gt; &gt; &gt; +M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com=
">chenhc@lemote.com</a>&gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 S: Odd Fixes<br>
&gt; &gt; &gt; &gt;=C2=A0 F: hw/mips/mips_fulong2e.c<br>
&gt; &gt; &gt; &gt;=C2=A0 F: hw/isa/vt82c686.c<br>
&gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; 2.7.0<br>
&gt; &gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; First of all, I want to express great pleasure and delight s=
eing<br>
&gt; &gt; &gt; your series, and this patch in particular.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; A warm welcome to QEMU developers communities!<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; We are currenyly very busy preparing QEMU 5.0 release, and<b=
r>
&gt; &gt; &gt; additionaly, Easter holidays are in next few days or week<br=
>
&gt; &gt; &gt; (different parts od Christian world have different calendars=
), so,<br>
&gt; &gt; &gt; fot thay and other reasons, don&#39;t expect promot replies =
from us.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I would also like to see Jiaxng at least having official rev=
iewer<br>
&gt; &gt; &gt; status, but, of course, only if he wants that.=C2=A0 <br>
&gt; &gt; Thank you for your best wishes, I&#39;m also very glad to see Jia=
xun be<br>
&gt; &gt; an reviewer.<br>
&gt;<br>
&gt; Thanks, but I was a primary school student at Loongson-2E&#39;s era, s=
o I<br>
&gt; can do nothing with 2E.<br>
&gt;<br>
&gt; My experience with Loongson starts from 2F. And I&#39;m more familiar =
with<br>
&gt; 2K and 3A.<br>
&gt;</p>
<p dir=3D"ltr">OK, it makes sense. But, if you ever become wanting to be a =
reviewer for Foolong 2e, just give me an email.</p>
<p dir=3D"ltr">&gt; I&#39;m happy to contribute QEMU support for these plat=
forms.<br>
&gt;</p>
<p dir=3D"ltr">I am happy as well.</p>
<p dir=3D"ltr">Best wishes and best health to you, people from China, and t=
he whole region!!</p>
<p dir=3D"ltr">Yours,<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; Thanks.<br>
&gt;<br>
&gt; &gt; <br>
&gt; &gt; Regards,<br>
&gt; &gt; Huacai<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Yours,<br>
&gt; &gt; &gt; and wishing you and all people from China best health!<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Aleksandar=C2=A0 <br>
&gt;<br>
&gt; --<br>
&gt; Jiaxun Yang<br>
</p>

--00000000000049f07a05a2f0ad65--

