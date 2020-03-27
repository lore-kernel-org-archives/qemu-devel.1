Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E43C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4930420705
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbJJ/cBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4930420705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHm0o-0005bc-Dt
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHm09-0005Bw-Vw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHm08-00023M-V5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:14:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jHm08-00020A-Oy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:14:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id 26so9752013wmk.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S7BPeYs6eeqAts0ky3d4W6qIzgGWrYBgwji9K5y3h1Y=;
 b=HbJJ/cByVywpvxkP8WZVZ/LFONgiIDux2oYwc2YWYSt+VdUUQifzzBDWxf2YrT5qmH
 m0qz30B0wXSR8YOeHQ+AKIsl03ThIlFWBskknfIQK2Ek51wJznHPzcZiG05/BNOdIE6A
 2vvoaoLISJtpk6N9aSYzBeeAmSzXNJTilaL333+IeMhfRE1GlpR6wYPU/sD7jkwoMTK9
 p0/Ug7E8n4XqWdIgJXezQwwU01gspuaE/ZWz2k3BZ9STE73YdJ7QEFhkRiiQ8AsLHaoB
 QcecyQS5x+X3BSYhsupvO+/cSflbzJOcSAPhwDBxg5QGeo2BF6g8eAsEsNrGiHfE5KBG
 kdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S7BPeYs6eeqAts0ky3d4W6qIzgGWrYBgwji9K5y3h1Y=;
 b=jb8ZhvoBImishmHKVovgs02tQBJms+9HHk+Uwar+Slo8xBVfNxv/mUOTMeIEeddYA0
 +YkLDboZYh8PbRCXMlyvjTMQUI5ZhGysaQMG53Az/B2orbJwfxul05p2VOIViyO9X89K
 Br7Xx2Ps9uBznIgoVJMD19hLXxT7Zqts1aFW1I5reCrqeghr/uGONGUauouB7q4w6kF1
 f57cZfCKx+9COj9NtBP80IyKJnu05zVcdY+w0rIdjCtQt5aAPFuVD30YjsfXwAPlh2wU
 ZNiZ1ZKYKgB7Ncl22Xm5gqa+QxPjegTWmPsezjzFvd5nPb4quCMKJxFLqTdxXTYeP/B/
 3UGw==
X-Gm-Message-State: ANhLgQ2PNWgcrTOtgon7k8buEwb4fz+RHZbvabbq8nLLRFMdmlgga0q9
 3K4jDtiibKqPcoA8iSktF+4/taBY51vPHwVVoUw=
X-Google-Smtp-Source: ADFU+vtVKKOXxWNWYPmvplrY6UjWa+yLzBvmCWkmzI7RJm+O2MQ9rCIRKjDOS+s7v5LOllcs6gDs0q8MOPvQYnRSPVA=
X-Received: by 2002:a05:600c:2dd7:: with SMTP id
 e23mr4464342wmh.159.1585304047613; 
 Fri, 27 Mar 2020 03:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200327094945.23768-1-alex.bennee@linaro.org>
 <20200327094945.23768-6-alex.bennee@linaro.org>
In-Reply-To: <20200327094945.23768-6-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 27 Mar 2020 12:13:48 +0200
Message-ID: <CAHiYmc6kw1LYK=97zxvsKdY8VL4CgZMAcWGgRcuoEjHT=qX8zw@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] fpu/softfloat: avoid undefined behaviour when
 normalising empty sigs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009e7a9c05a1d35c76"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009e7a9c05a1d35c76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

11:53 Pet, 27.03.2020. Alex Benn=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=
=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> The undefined behaviour checker

Alex, what exactly is "undefined behaviour checker"? If this is a test, can
you give us a link?

Sincerely,
Aleksandar

> pointed out that a shift of 64 would
> lead to undefined behaviour.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 301ce3b537b..444d35920dd 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -3834,9 +3834,14 @@ void normalizeFloatx80Subnormal(uint64_t aSig,
int32_t *zExpPtr,
>  {
>      int8_t shiftCount;
>
> -    shiftCount =3D clz64(aSig);
> -    *zSigPtr =3D aSig<<shiftCount;
> -    *zExpPtr =3D 1 - shiftCount;
> +    if (aSig) {
> +        shiftCount =3D clz64(aSig);
> +        *zSigPtr =3D aSig << shiftCount;
> +        *zExpPtr =3D 1 - shiftCount;
> +    } else {
> +        *zSigPtr =3D 0;
> +        *zExpPtr =3D 1 - 64;
> +    }
>  }
>
>
 /*------------------------------------------------------------------------=
----
> --
> 2.20.1
>
>

--0000000000009e7a9c05a1d35c76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">11:53 Pet, 27.03.2020. Alex Benn=C3=A9e &lt;<a href=3D"mailt=
o:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; The undefined behaviour checker</p>
<p dir=3D"ltr">Alex, what exactly is &quot;undefined behaviour checker&quot=
;? If this is a test, can you give us a link?</p>
<p dir=3D"ltr">Sincerely,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt; pointed out that a shift of 64 would<br>
&gt; lead to undefined behaviour.<br>
&gt;<br>
&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lina=
ro.org">alex.bennee@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0fpu/softfloat.c | 11 ++++++++---<br>
&gt; =C2=A01 file changed, 8 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/fpu/softfloat.c b/fpu/softfloat.c<br>
&gt; index 301ce3b537b..444d35920dd 100644<br>
&gt; --- a/fpu/softfloat.c<br>
&gt; +++ b/fpu/softfloat.c<br>
&gt; @@ -3834,9 +3834,14 @@ void normalizeFloatx80Subnormal(uint64_t aSig, =
int32_t *zExpPtr,<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0int8_t shiftCount;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 shiftCount =3D clz64(aSig);<br>
&gt; -=C2=A0 =C2=A0 *zSigPtr =3D aSig&lt;&lt;shiftCount;<br>
&gt; -=C2=A0 =C2=A0 *zExpPtr =3D 1 - shiftCount;<br>
&gt; +=C2=A0 =C2=A0 if (aSig) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 shiftCount =3D clz64(aSig);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *zSigPtr =3D aSig &lt;&lt; shiftCount;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *zExpPtr =3D 1 - shiftCount;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *zSigPtr =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *zExpPtr =3D 1 - 64;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0/*--------------------------------------------------------------=
--------------<br>
&gt; -- <br>
&gt; 2.20.1<br>
&gt;<br>
&gt;<br>
</p>

--0000000000009e7a9c05a1d35c76--

