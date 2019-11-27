Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C898C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D9820678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f13ANvvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D9820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxwx-0001Zi-Ss
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iZxpr-0006sF-76
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iZxpp-00028H-VX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:58:27 -0500
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:36707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iZxpp-00026x-OW
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:58:25 -0500
Received: by mail-yb1-xb43.google.com with SMTP id v2so9011334ybo.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 05:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z/jrMxtVdJB5m+WkS0BXY8d7oIt0NlqvS1q5vOfhzEQ=;
 b=f13ANvvze6q2HO3NAuhb1fbILMSr5gETfseJK194FfVN2PetJoxr+1aWu6M8saT5Df
 h34aII1BuK/ZUEbdXQN9LnvwUnJvan1w4dZ+y5mJ+eHOAkZ7shqNJqyd5gw761Sn7N+E
 HD877egnKVDm1FQFAbxhw3IIYKO1GdQ/3278CEgIOyjSTQ3U5cDNfpun370BU4lgZ6ls
 oLpVTq1sWW3iyDZspAzazO0LhQFpzxjRyaDbnUHfXyOGIn17plgOXdKtRaQoWAd551xc
 56J11rYIqsCo6vhObhkdT3YKedOHbYYCM+ESeK94Rd/adnYpd5OfPYpj+OvAYzaxeI2o
 lfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z/jrMxtVdJB5m+WkS0BXY8d7oIt0NlqvS1q5vOfhzEQ=;
 b=ZTAPtxF8Wkw390BApIOfZDr8RL5Obe0849ddcjk4oXteF5FO485VZeGfN93sQK3Qx5
 YS+uSnhajVcA3Z2+ZcO5BbFHpRrBWywOArMAtJPoeMdRmeVCnw9xwh5IS0y0vgU85Vjk
 COsvOcjjoGGxA1XrfKn2PP0I4Kbty1uO1EGiatFoa7yAkYwRQa5nTiHBVwxNHwFm8HV0
 NzeLIQ9nBjJ1B4RaIowPSwfs3rHYZUjM88tAxlbOm/NV7DNfs+5kztYh8H1gAYKmeVUB
 QMnC+UxSXjed9Vxy7ML6nPOfzKfTA75LUfBTRFxwUT9L6MvTCNQMDp1ohjT8q4Mxc3fM
 //1A==
X-Gm-Message-State: APjAAAUBgz1Uc2feCUZhPA22fpMcjXERKvD2ERP/hkBwZDmJU7ZoEGji
 e+A5pTs8iAdwudvTi6mht4SdQLP+D/D2BX67XiI=
X-Google-Smtp-Source: APXvYqxWyRFqGFwuSS28SkYpI17LWZJhjP8ehIZXjHw0sk5g5EF6c96okt6S/bFjTMtWnV70qBesmnnKdNOcZEyycP4=
X-Received: by 2002:a25:7443:: with SMTP id p64mr32710425ybc.483.1574863104712; 
 Wed, 27 Nov 2019 05:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20191127132430.3681-1-alex.bennee@linaro.org>
In-Reply-To: <20191127132430.3681-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
 <philippe.mathieu.daude@gmail.com>
Date: Wed, 27 Nov 2019 14:58:12 +0100
Message-ID: <CAAdtpL6HgKCA01LfB0EfbMgHYjy5DsRAo+q2okVpFV1ttvktKA@mail.gmail.com>
Subject: Re: [PATCH for 4.2?] .travis.yml: drop xcode9.4 from build matrix
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ed25040598546358"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ed25040598546358
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 27 nov. 2019 14:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> a =C3=
=A9crit :

> It's broken so it's no longer helping. The latest Xcode is covered by
> Cirrus.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

---
>  .travis.yml | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index c09b6a00143..445b0646c18 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -237,13 +237,7 @@ matrix:
>          - TEST_CMD=3D""
>
>
> -    # MacOSX builds
> -    - env:
> -        - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS}"
> -      os: osx
> -      osx_image: xcode9.4
> -      compiler: clang
> -
> +    # MacOSX builds - cirrus.yml also tests some MacOS builds including
> latest Xcode
>
>      - env:
>          -
> CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-sof=
tmmu,x86_64-softmmu"
> --
> 2.20.1
>
>
>

--000000000000ed25040598546358
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le mer. 27 nov. 2019 14:51, Alex Benn=C3=A9e &lt;<a href=3D"ma=
ilto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; a =C3=A9crit=C2=
=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">It&#39;s broken so it&#39;s no=
 longer helping. The latest Xcode is covered by<br>
Cirrus.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Revie=
wed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com=
">philmd@redhat.com</a>&gt;</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0.travis.yml | 8 +-------<br>
=C2=A01 file changed, 1 insertion(+), 7 deletions(-)<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index c09b6a00143..445b0646c18 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -237,13 +237,7 @@ matrix:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- TEST_CMD=3D&quot;&quot;<br>
<br>
<br>
-=C2=A0 =C2=A0 # MacOSX builds<br>
-=C2=A0 =C2=A0 - env:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - CONFIG=3D&quot;--target-list=3D${MAIN_SOFTMM=
U_TARGETS}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 os: osx<br>
-=C2=A0 =C2=A0 =C2=A0 osx_image: xcode9.4<br>
-=C2=A0 =C2=A0 =C2=A0 compiler: clang<br>
-<br>
+=C2=A0 =C2=A0 # MacOSX builds - cirrus.yml also tests some MacOS builds in=
cluding latest Xcode<br>
<br>
=C2=A0 =C2=A0 =C2=A0- env:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--target-list=3Di386-sof=
tmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu&quot;<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000ed25040598546358--

