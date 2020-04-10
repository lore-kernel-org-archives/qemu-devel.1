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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C5EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 15:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DD020CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 15:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tN5muob4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DD020CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMw0R-0004Pn-6b
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 11:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jMvzE-0003x6-MX
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 11:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jMvzC-0003iH-Rx
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 11:54:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jMvzC-0003h6-IY
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 11:54:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id v5so2701454wrp.12
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B8TxbiCwRZnnMMH7pr+97aaQI6o6WzgeP4uG8D+b6Jw=;
 b=tN5muob4Ir0gIDktn7UFwkINtDKy+023wNR3Qe7D8VMlkpEtFjf/ZE2klYyO+vY1vo
 Jk/PP83+PymKoZ9pQ8GHZ/BSJpHtfTYE0UuSdSrzWpFEbJeZX9o1FAbmQa7Ubc/puKgv
 AbtMD28hjV5KbulZUZPySwz13m4vf21gGZl8bCQVKsLKyh5NCTxyI5mf7BFREzOsPt2H
 4aKXG3/SfYJHx8D8YvHQk+rYyGOsDHfWwJJkzbjUP1SetH8FMrnhXR6KMjhcwOvZdMG1
 HzmZyZIFjOD083r9vTbi24Ueh94k/rWBSyBlxzIYCn/Yr+jbt3qtNg+q14dlHPi/WEFR
 5D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B8TxbiCwRZnnMMH7pr+97aaQI6o6WzgeP4uG8D+b6Jw=;
 b=Aycrv2Ffjc398Fn36L04u2s/aIXbeDoXyVkRR8ru7TXPhSHjp5T5+hOU7hfy31t/m3
 6XCUxuvS7Ft4o5QQHui5iWm2wBqfWJCe+daD+VdDXtdV8gKz/ijQt2KovBvIX12KkGIL
 g1yFCp++i5xoFa5GL/Ynehw/vOgU9p2l0UNmiqBh1B6hFSKp2Ub65BjwRsbeF4G6kL85
 oLm/QFr1BaIDS5qZvOcOg1we92E1RhDWHKg7Yn3Ki4qKk3H+aTT/XQVTeCGKQmPiKANd
 DIesxCUlfwz5o6mb7WFYjWV/xno2n8pRIVeqZdarrzopS3cIZFjJ2IlZcmB1PRn3oTwh
 ij2g==
X-Gm-Message-State: AGi0PubWdbrM5o4G8/teQlzAXNVnQ+gNOaay9PJOG/Xu9plRRnmaseGy
 T3xm76diE6cfqhvXEmMvkpuo66RyHntBJ70d+lQ=
X-Google-Smtp-Source: APiQypKhthjNVlTM1RpZtPlT+WConY98VyEFAFF/gWMifiWrz+6ico3H4QDlCR9E3Z+k40AlzZdfGJAe1KMkKTE28Lk=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr5125255wrw.402.1586534068966; 
 Fri, 10 Apr 2020 08:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200407155118.20139-1-alex.bennee@linaro.org>
 <20200407155118.20139-9-alex.bennee@linaro.org>
 <CAHiYmc7Eu0XsCe_bkV=tP_S3wyWy4St1RR2AphE7Obko-18mNQ@mail.gmail.com>
 <45a7fe3b-cede-c8e9-fe98-99914bef0e97@linaro.org>
In-Reply-To: <45a7fe3b-cede-c8e9-fe98-99914bef0e97@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 10 Apr 2020 17:54:13 +0200
Message-ID: <CAHiYmc4+UnBBay+=GyP0fCxefOwB3fT=T6TiTcorvv_2AjCjpw@mail.gmail.com>
Subject: Re: [PULL 08/13] softfloat: Fix BAD_SHIFT from
 normalizeFloatx80Subnormal
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009ad9a105a2f1bf1b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009ad9a105a2f1bf1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

17:17 Pet, 10.04.2020. Richard Henderson <richard.henderson@linaro.org> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 4/10/20 2:38 AM, Aleksandar Markovic wrote:
> > 17:55 Uto, 07.04.2020. Alex Benn=C3=A9e <alex.bennee@linaro.org
> > <mailto:alex.bennee@linaro.org>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> From: Richard Henderson <richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>>
> >>
> >> All other calls to normalize*Subnormal detect zero input before
> >> the call -- this is the only outlier.  This case can happen with
> >> +0.0 + +0.0 =3D +0.0 or -0.0 + -0.0 =3D -0.0, so return a zero of
> >> the correct sign.
> >>
> >> Reported-by: Coverity (CID 1421991)
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org
> > <mailto:alex.bennee@linaro.org>>
> >> Message-Id: <20200327232042.10008-1-richard.henderson@linaro.org
> > <mailto:20200327232042.10008-1-richard.henderson@linaro.org>>
> >> Message-Id: <20200403191150.863-8-alex.bennee@linaro.org
> > <mailto:20200403191150.863-8-alex.bennee@linaro.org>>
> >>
> >> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> >> index 301ce3b537b..ae6ba718540 100644
> >> --- a/fpu/softfloat.c
> >> +++ b/fpu/softfloat.c
> >> @@ -5856,6 +5856,9 @@ static floatx80 addFloatx80Sigs(floatx80 a,
floatx80 b,
> > flag zSign,
> >>          zSig1 =3D 0;
> >>          zSig0 =3D aSig + bSig;
> >>          if ( aExp =3D=3D 0 ) {
> >> +            if (zSig0 =3D=3D 0) {
> >> +                return packFloatx80(zSign, 0, 0);
> >> +            }
> >>              normalizeFloatx80Subnormal( zSig0, &zExp, &zSig0 );
> >>              goto roundAndPack;
> >>          }
> >> --
> >> 2.20.1
> >>
> >>
> >
> > We in MIPS have extensive FP tests, that certainly include many cases o=
f
> > operations with +0 and -0. And they are all correct even before this
patch.
>
> This is for the 80-bit extended-double type, only used on x86 and m68k.
You
> will not execute this path using MIPS.
>

Thanks, Richard!

First and foremost, may health be with you and all people of United States
and all Americas!!

Yes, the fact that m68k also uses 80-bit FP arithmetic was known to me.
Though probably many people think 80-bit FP is limited to x86.

I was just afraid of some strange way that other targets may end up using
the function in question. But again, thanks for reassurances!

> > Alex, from the commit message, it not clear if this is a fix of a bug
(in which
> > case a test example would be useful to have, and the assesment on what
> > scenarios could be affected), or just a correction for some rare
condition that
> > practically for all intents and purposes was never triggered, or perhap=
s
> > something third.
>
> This only avoids a Coverity out-of-range shift warning.
>
> Beforehand, we executed 0 << 64, got 0 as the result (regardless of
whether or
> not the host truncates the shift count), and constructed the correctly
signed
> fp zero in the end.
>
> There was more discussion about this in an earlier thread, associated
with a
> different patch for this same problem:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg08278.html
>

OK. I didn't have a chance to read this pattivular thread. Thanks for the
pointer!

>
> > Secondly, and not related to this patch only, I see more and more
patches
> > integrated into the main tree without "Reviewed-by:" tag. I don't think
this is
> > the best way an open source community works. In my personal opinion,
this must
> > stop.
>
> The only way to avoid this is to have more developers review code outside
their
> own bailiwick.  The patch has been on the list for two weeks and was
pinged
> twice.
>
> Although why Alex didn't add his own R-b to my patch when merging it to
his
> branch, I don't know.
>

I also have a very similar impression as yours, that Alex in fact reviewed
the patch (as if he implicitely gave R-B, but forgot to insert it in a
hurry, given these hectic days around 5.0 final release).

Best regards, and best wishes to all Sietlans, or wherever you happen to
live!

Aleksandar

>
> r~

--0000000000009ad9a105a2f1bf1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">17:17 Pet, 10.04.2020. Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; =D1=
=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 4/10/20 2:38 AM, Aleksandar Markovic wrote:<br>
&gt; &gt; 17:55 Uto, 07.04.2020. Alex Benn=C3=A9e &lt;<a href=3D"mailto:ale=
x.bennee@linaro.org">alex.bennee@linaro.org</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@=
linaro.org</a>&gt;&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; From: Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org">richard.henderson@linaro.org</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; All other calls to normalize*Subnormal detect zero input befo=
re<br>
&gt; &gt;&gt; the call -- this is the only outlier.=C2=A0 This case can hap=
pen with<br>
&gt; &gt;&gt; +0.0 + +0.0 =3D +0.0 or -0.0 + -0.0 =3D -0.0, so return a zer=
o of<br>
&gt; &gt;&gt; the correct sign.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Reported-by: Coverity (CID 1421991)<br>
&gt; &gt;&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richar=
d.henderson@linaro.org">richard.henderson@linaro.org</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.be=
nnee@linaro.org">alex.bennee@linaro.org</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@=
linaro.org</a>&gt;&gt;<br>
&gt; &gt;&gt; Message-Id: &lt;<a href=3D"mailto:20200327232042.10008-1-rich=
ard.henderson@linaro.org">20200327232042.10008-1-richard.henderson@linaro.o=
rg</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:20200327232042.10008-1-richard.hende=
rson@linaro.org">20200327232042.10008-1-richard.henderson@linaro.org</a>&gt=
;&gt;<br>
&gt; &gt;&gt; Message-Id: &lt;<a href=3D"mailto:20200403191150.863-8-alex.b=
ennee@linaro.org">20200403191150.863-8-alex.bennee@linaro.org</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:20200403191150.863-8-alex.bennee@lin=
aro.org">20200403191150.863-8-alex.bennee@linaro.org</a>&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/fpu/softfloat.c b/fpu/softfloat.c<br>
&gt; &gt;&gt; index 301ce3b537b..ae6ba718540 100644<br>
&gt; &gt;&gt; --- a/fpu/softfloat.c<br>
&gt; &gt;&gt; +++ b/fpu/softfloat.c<br>
&gt; &gt;&gt; @@ -5856,6 +5856,9 @@ static floatx80 addFloatx80Sigs(floatx8=
0 a, floatx80 b,<br>
&gt; &gt; flag zSign,<br>
&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zSig1 =3D 0;<br>
&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zSig0 =3D aSig + bSig;<br>
&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ( aExp =3D=3D 0 ) {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (zSig0 =3D=3D 0=
) {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn packFloatx80(zSign, 0, 0);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0normalizeFloa=
tx80Subnormal( zSig0, &amp;zExp, &amp;zSig0 );<br>
&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto roundAnd=
Pack;<br>
&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; 2.20.1<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt; <br>
&gt; &gt; We in MIPS have extensive FP tests, that certainly include many c=
ases of<br>
&gt; &gt; operations with +0 and -0. And they are all correct even before t=
his patch.<br>
&gt;<br>
&gt; This is for the 80-bit extended-double type, only used on x86 and m68k=
.=C2=A0 You<br>
&gt; will not execute this path using MIPS.<br>
&gt;</p>
<p dir=3D"ltr">Thanks, Richard!</p>
<p dir=3D"ltr">First and foremost, may health be with you and all people of=
 United States and all Americas!!</p>
<p dir=3D"ltr">Yes, the fact that m68k also uses 80-bit FP arithmetic was k=
nown to me. Though probably many people think 80-bit FP is limited to x86.<=
/p>
<p dir=3D"ltr">I was just afraid of some strange way that other targets may=
 end up using the function in question. But again, thanks for reassurances!=
</p>
<p dir=3D"ltr">&gt; &gt; Alex, from the commit message, it not clear if thi=
s is a fix of a bug (in which<br>
&gt; &gt; case a test example would be useful to have, and the assesment on=
 what<br>
&gt; &gt; scenarios could be affected), or just a correction for some rare =
condition that<br>
&gt; &gt; practically for all intents and purposes was never triggered, or =
perhaps<br>
&gt; &gt; something third.<br>
&gt;<br>
&gt; This only avoids a Coverity out-of-range shift warning.<br>
&gt;<br>
&gt; Beforehand, we executed 0 &lt;&lt; 64, got 0 as the result (regardless=
 of whether or<br>
&gt; not the host truncates the shift count), and constructed the correctly=
 signed<br>
&gt; fp zero in the end.<br>
&gt;<br>
&gt; There was more discussion about this in an earlier thread, associated =
with a<br>
&gt; different patch for this same problem:<br>
&gt;<br>
&gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-03/ms=
g08278.html">https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg08=
278.html</a><br>
&gt;</p>
<p dir=3D"ltr">OK. I didn&#39;t have a chance to read this pattivular threa=
d. Thanks for the pointer!</p>
<p dir=3D"ltr">&gt;<br>
&gt; &gt; Secondly, and not related to this patch only, I see more and more=
 patches<br>
&gt; &gt; integrated into the main tree without &quot;Reviewed-by:&quot; ta=
g. I don&#39;t think this is<br>
&gt; &gt; the best way an open source community works. In my personal opini=
on, this must<br>
&gt; &gt; stop.<br>
&gt;<br>
&gt; The only way to avoid this is to have more developers review code outs=
ide their<br>
&gt; own bailiwick.=C2=A0 The patch has been on the list for two weeks and =
was pinged<br>
&gt; twice.<br>
&gt;<br>
&gt; Although why Alex didn&#39;t add his own R-b to my patch when merging =
it to his<br>
&gt; branch, I don&#39;t know.<br>
&gt;</p>
<p dir=3D"ltr">I also have a very similar impression as yours, that Alex in=
 fact reviewed the patch (as if he implicitely gave R-B, but forgot to inse=
rt it in a hurry, given these hectic days around 5.0 final release).</p>
<p dir=3D"ltr">Best regards, and best wishes to all Sietlans, or wherever y=
ou happen to live!</p>
<p dir=3D"ltr">Aleksandar</p>
<p dir=3D"ltr">&gt;<br>
&gt; r~<br>
</p>

--0000000000009ad9a105a2f1bf1b--

