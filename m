Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB5FC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38EFB20787
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4uwkIzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EFB20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMq7n-0006I2-Jx
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 05:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jMq7A-0005o0-3Y
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jMq78-0002fu-RX
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:38:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jMq78-0002fB-Iz
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:38:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id v5so1644037wrp.12
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qXKdO8VuMZ0caJ8j3klE5W3SvvElBF6p+Yp2J4ffjZc=;
 b=J4uwkIzp2QOLuk1mqh5RlrCklTwfd0cH4ggZtvjg8uBXras6xDEC0dCeV+FUqqAVuM
 hkMDwIGSXNC27IhkLqnY6RORTw3bWs+qJmoItCDamog1qETrgFu1K2I0/406f+GdP+SG
 sn7heGeVwdMn3jv+R7p9YBr4YOYjiQMn5mE/HpOjmRkTC4rwhkm70XaAYPUa8LCa3fGj
 0Ij3ZXBjrAEH5DKa1thvyQQ16HDOMGQeas4FQZ4pJ+GDgI+uwyuDqAACkBvVqp8zHSLo
 HchVa9jzLjzQasdL7GrPYUDBAwNHzx6hraIMIOQdOI2Yc7SbLKbewJmpoAENLbd5FABC
 vqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qXKdO8VuMZ0caJ8j3klE5W3SvvElBF6p+Yp2J4ffjZc=;
 b=trVv8FGRozJ1AJltuQQnALrMS1prpuHrPHgP1qZZnQ035b1vRZzv5JrwYaop6ky6GH
 uy5F8+JZyU/zoZ3JyMID7/SGE6gf6UiJmSpP1EwIWR8vgFRvimSA1yBvJQcMMyWjalS1
 S1kbpaMrUun7zPUaXDzEgw8M0otjQdNLBGqn9ezBNByaMrK/7+35A6vTRxuWd7iUQOfn
 Ed7gdS9nHYkBSy9DmTPX8O1SLjgpx/tO+mDugwhCDJivrMJSNZZWxw1zzp6rfFbyWTQe
 GRdWOnAQbhWGxJaZcwpfE6eEcbGoIpBXN3PEKYeM2BS+N7BxYtk/andNUnb6MYPyrS2S
 AoFA==
X-Gm-Message-State: AGi0PubZevet/ENZcLG6b9g+RI3l1uQ0F8mzNVgzkR//YfQxLm1W8vY0
 CKmb3A6iepL6hxl8eNOW8bEUwOWY6CAFXPqz7ho=
X-Google-Smtp-Source: APiQypLf0gQE3PA2W89/hBaEWvWQgQdq4crd8EGvY568IsyUuE5PxssRhvGC3Wh4RBjvZdvE6bXoqE/Lo3khjmbGPiI=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr3666406wrw.402.1586511497286; 
 Fri, 10 Apr 2020 02:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200407155118.20139-1-alex.bennee@linaro.org>
 <20200407155118.20139-9-alex.bennee@linaro.org>
In-Reply-To: <20200407155118.20139-9-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 10 Apr 2020 11:38:00 +0200
Message-ID: <CAHiYmc7Eu0XsCe_bkV=tP_S3wyWy4St1RR2AphE7Obko-18mNQ@mail.gmail.com>
Subject: Re: [PULL 08/13] softfloat: Fix BAD_SHIFT from
 normalizeFloatx80Subnormal
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003a57fa05a2ec7ef3"
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003a57fa05a2ec7ef3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

17:55 Uto, 07.04.2020. Alex Benn=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=
=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> All other calls to normalize*Subnormal detect zero input before
> the call -- this is the only outlier.  This case can happen with
> +0.0 + +0.0 =3D +0.0 or -0.0 + -0.0 =3D -0.0, so return a zero of
> the correct sign.
>
> Reported-by: Coverity (CID 1421991)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20200327232042.10008-1-richard.henderson@linaro.org>
> Message-Id: <20200403191150.863-8-alex.bennee@linaro.org>
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 301ce3b537b..ae6ba718540 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -5856,6 +5856,9 @@ static floatx80 addFloatx80Sigs(floatx80 a,
floatx80 b, flag zSign,
>          zSig1 =3D 0;
>          zSig0 =3D aSig + bSig;
>          if ( aExp =3D=3D 0 ) {
> +            if (zSig0 =3D=3D 0) {
> +                return packFloatx80(zSign, 0, 0);
> +            }
>              normalizeFloatx80Subnormal( zSig0, &zExp, &zSig0 );
>              goto roundAndPack;
>          }
> --
> 2.20.1
>
>

We in MIPS have extensive FP tests, that certainly include many cases of
operations with +0 and -0. And they are all correct even before this patch.

Unfortunately, because of my current remote work, I don't havecthese tests
with me, and can't confirm if they work correctly, or perhaps are
unaffected at all.

Alex, from the commit message, it not clear if this is a fix of a bug (in
which case a test example would be useful to have, and the assesment on
what scenarios could be affected), or just a correction for some rare
condition that practically for all intents and purposes was never
triggered, or perhaps something third.

Alex, please explain this in more detail to me.

Secondly, and not related to this patch only, I see more and more patches
integrated into the main tree without "Reviewed-by:" tag. I don't think
this is the best way an open source community works. In my personal
opinion, this must stop.

Regards,
Aleksandar

--0000000000003a57fa05a2ec7ef3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">17:55 Uto, 07.04.2020. Alex Benn=C3=A9e &lt;<a href=3D"mailt=
o:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; From: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro=
.org">richard.henderson@linaro.org</a>&gt;<br>
&gt;<br>
&gt; All other calls to normalize*Subnormal detect zero input before<br>
&gt; the call -- this is the only outlier.=C2=A0 This case can happen with<=
br>
&gt; +0.0 + +0.0 =3D +0.0 or -0.0 + -0.0 =3D -0.0, so return a zero of<br>
&gt; the correct sign.<br>
&gt;<br>
&gt; Reported-by: Coverity (CID 1421991)<br>
&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org">richard.henderson@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lina=
ro.org">alex.bennee@linaro.org</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:20200327232042.10008-1-richard.hende=
rson@linaro.org">20200327232042.10008-1-richard.henderson@linaro.org</a>&gt=
;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:20200403191150.863-8-alex.bennee@lin=
aro.org">20200403191150.863-8-alex.bennee@linaro.org</a>&gt;<br>
&gt;<br>
&gt; diff --git a/fpu/softfloat.c b/fpu/softfloat.c<br>
&gt; index 301ce3b537b..ae6ba718540 100644<br>
&gt; --- a/fpu/softfloat.c<br>
&gt; +++ b/fpu/softfloat.c<br>
&gt; @@ -5856,6 +5856,9 @@ static floatx80 addFloatx80Sigs(floatx80 a, floa=
tx80 b, flag zSign,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zSig1 =3D 0;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zSig0 =3D aSig + bSig;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ( aExp =3D=3D 0 ) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (zSig0 =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return packFl=
oatx80(zSign, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0normalizeFloatx80Subno=
rmal( zSig0, &amp;zExp, &amp;zSig0 );<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto roundAndPack;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -- <br>
&gt; 2.20.1<br>
&gt;<br>
&gt;</p>
<p dir=3D"ltr">We in MIPS have extensive FP tests, that certainly include m=
any cases of operations with +0 and -0. And they are all correct even befor=
e this patch.</p>
<p dir=3D"ltr">Unfortunately, because of my current remote work, I don&#39;=
t havecthese tests with me, and can&#39;t confirm if they work correctly, o=
r perhaps are unaffected at all.</p>
<p dir=3D"ltr">Alex, from the commit message, it not clear if this is a fix=
 of a bug (in which case a test example would be useful to have, and the as=
sesment on what scenarios could be affected), or just a correction for some=
 rare condition that practically for all intents and purposes was never tri=
ggered, or perhaps something third.</p>
<p dir=3D"ltr">Alex, please explain this in more detail to me.</p>
<p dir=3D"ltr">Secondly, and not related to this patch only, I see more and=
 more patches integrated into the main tree without &quot;Reviewed-by:&quot=
; tag. I don&#39;t think this is the best way an open source community work=
s. In my personal opinion, this must stop.</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar</p>

--0000000000003a57fa05a2ec7ef3--

