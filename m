Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89EEC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE16721A4A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPJrpEsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE16721A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwKp-0002pb-FU
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iDwCJ-0001tN-1m
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iDwCH-0001sT-EP
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:46:34 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iDwCH-0001qk-6N; Fri, 27 Sep 2019 15:46:33 -0400
Received: by mail-ed1-x543.google.com with SMTP id c4so3384411edl.0;
 Fri, 27 Sep 2019 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jOwWvrN151x0DDEdrQrY3RB+nObetgY3tjAATY489o8=;
 b=rPJrpEsUyphW5X37v+48Dkx72u4xiMqAU2tI4jAKEBQV+MIH35D2nfkDyoI4de254o
 FFI/j3jlL/a2kG/TykTqP95lQHWJ0QxxqLWafxAxoZDH3Q4jkLxYgUYDwQUN6k5CfLyH
 Y4EsE7Ujtj9BsG1r3tyTzIJ024PRYC4fJTmjXlHm3sVsYOY+9wVa/qwc4gOiZm785aK5
 4JIij+IWFirG+kZ676W5slSVCcUlas00YN7Iok6w6BxerdrCrri4gZ3jADgLyeNuFKJ1
 cgOZUZfgI0kBn4JqsGDLCbefSpdncoDotOUrB35HQ+134YpfIT7p7LW/kXT1znEoVbZj
 Q0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jOwWvrN151x0DDEdrQrY3RB+nObetgY3tjAATY489o8=;
 b=DO87aiv+qsyCOtWBsg5UT40XUU+rhv3hrZuz68iEfWjIJPhADiSV3BU+LnIU/YIwnO
 tqd2qM0sYG00qNe5TnKMRSLJv8Zqu9sWQUO8THRLU4U2khbHUEXXGI6WnTpfjQOlA43h
 ucVitOO0fep2Sp2cXxAb8mtzKvGmBj3sCeVuA1I+IZz4avUiXESjYO5Js6wkIv7CaOz6
 t4N0m3jzJRCB/B9nEnUTVmGgRbsRfR/9J5Rj+qTtf7dq+GYKAHQPLMuuI+Wua+QwfBpF
 YnmYQj7IyxZpH5UyfhQ0n2o5UHgDUh3+XwNTGW4YCJhiybuYpBK2l1wztxJqzzvmwz72
 FfRA==
X-Gm-Message-State: APjAAAX8QBWj48GTEstg7MZYb03n5a0inoX4SqX6kDSrimjXf/JRc7SU
 DE9axZCSTCBCSAqxUds2JWoLHd7wYgSQA/vK/g8=
X-Google-Smtp-Source: APXvYqziPUpoXDAVoZ8oJ5a55BD0r4I6fULcHp2Wskqi9Qir2FMVrmQjKVwS2qVE6S/7GuCMtK/p40AtFyev6iyaTrw=
X-Received: by 2002:a17:906:ecb6:: with SMTP id
 qh22mr9266527ejb.114.1569613590259; 
 Fri, 27 Sep 2019 12:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-2-f4bug@amsat.org>
In-Reply-To: <20190904171315.8354-2-f4bug@amsat.org>
From: Esteban Bosse <estebanbosse@gmail.com>
Date: Fri, 27 Sep 2019 21:46:19 +0200
Message-ID: <CAGbAg_Du+eVRgZp+ue6zwMknAgJx8zFF6W7DaD8BB5MUkkMoDQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] hw/arm/raspi: Use the IEC binary prefix definitions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000007b6ca105938e24d2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
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
 =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007b6ca105938e24d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Esteban

El mi=C3=A9., 4 sept. 2019 a las 19:13, Philippe Mathieu-Daud=C3=A9 (<f4bug=
@amsat.org>)
escribi=C3=B3:

> IEC binary prefixes ease code review: the unit is explicit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 74c062d05e..615d755879 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -230,7 +230,7 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->max_cpus =3D BCM283X_NCPUS;
>      mc->min_cpus =3D BCM283X_NCPUS;
>      mc->default_cpus =3D BCM283X_NCPUS;
> -    mc->default_ram_size =3D 1024 * 1024 * 1024;
> +    mc->default_ram_size =3D 1 * GiB;
>      mc->ignore_memory_transaction_failures =3D true;
>  };
>  DEFINE_MACHINE("raspi2", raspi2_machine_init)
> @@ -252,7 +252,7 @@ static void raspi3_machine_init(MachineClass *mc)
>      mc->max_cpus =3D BCM283X_NCPUS;
>      mc->min_cpus =3D BCM283X_NCPUS;
>      mc->default_cpus =3D BCM283X_NCPUS;
> -    mc->default_ram_size =3D 1024 * 1024 * 1024;
> +    mc->default_ram_size =3D 1 * GiB;
>  }
>  DEFINE_MACHINE("raspi3", raspi3_machine_init)
>  #endif
> --
> 2.20.1
>
>

--0000000000007b6ca105938e24d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Esteban<br></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">El mi=C3=A9., 4 sept. 2019 a las 1=
9:13, Philippe Mathieu-Daud=C3=A9 (&lt;<a href=3D"mailto:f4bug@amsat.org">f=
4bug@amsat.org</a>&gt;) escribi=C3=B3:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">IEC binary prefixes ease code review: the unit is ex=
plicit.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0hw/arm/raspi.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c<br>
index 74c062d05e..615d755879 100644<br>
--- a/hw/arm/raspi.c<br>
+++ b/hw/arm/raspi.c<br>
@@ -230,7 +230,7 @@ static void raspi2_machine_init(MachineClass *mc)<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;max_cpus =3D BCM283X_NCPUS;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;min_cpus =3D BCM283X_NCPUS;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_cpus =3D BCM283X_NCPUS;<br>
-=C2=A0 =C2=A0 mc-&gt;default_ram_size =3D 1024 * 1024 * 1024;<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_size =3D 1 * GiB;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;ignore_memory_transaction_failures =3D true;<br>
=C2=A0};<br>
=C2=A0DEFINE_MACHINE(&quot;raspi2&quot;, raspi2_machine_init)<br>
@@ -252,7 +252,7 @@ static void raspi3_machine_init(MachineClass *mc)<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;max_cpus =3D BCM283X_NCPUS;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;min_cpus =3D BCM283X_NCPUS;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_cpus =3D BCM283X_NCPUS;<br>
-=C2=A0 =C2=A0 mc-&gt;default_ram_size =3D 1024 * 1024 * 1024;<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_size =3D 1 * GiB;<br>
=C2=A0}<br>
=C2=A0DEFINE_MACHINE(&quot;raspi3&quot;, raspi3_machine_init)<br>
=C2=A0#endif<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div>

--0000000000007b6ca105938e24d2--

