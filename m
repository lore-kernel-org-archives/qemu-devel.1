Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8956CC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5199124656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vC1RvILz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5199124656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vHT-0006MJ-IA
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6vG1-0005Dd-DH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6vG0-0007yX-Dh
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:53:41 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j6vG0-0007wc-7e
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:53:40 -0500
Received: by mail-ot1-x342.google.com with SMTP id r16so2713227otd.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=FcNL3je+1fJEwwi50+5xvNveJt0OoVbXEGu9o6nzNNM=;
 b=vC1RvILzZGLwT5JkBtKeGd99qIwvd0nkGBqW3joJyUlA7eVKsbPb6jjrUvgagpSIoS
 DfKzXsz5fVT94AXWisirB36JWwsVTJhbdlX7dSrgym/U2+5PgTpQLDU3IcaiLxPlEuOh
 WDgo/dUlpCj8wfWLKtY9opBxCD9NezKVB1ztX3Y/UDOFqxbMmeZ5+cgdmowDgnjj8oza
 6PQt09jkQMu0RqyoJTVavicl+w3dSHxjKDyV8AbJqXh0QE+eZugTJbG0AtgQFLChLSoV
 R4Tw59FIz+Ry/LuiS/AwpQR64d6+n+V57Dv5ebe6Z2AxibPQ0htmMxovymp8MLNd3xKg
 l8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=FcNL3je+1fJEwwi50+5xvNveJt0OoVbXEGu9o6nzNNM=;
 b=kErFkNO1YuNtS566Nm9bUm6CvSOR30samWnzAC+BRWd2Xxh9oKwh2xyeTkTRgUnySh
 lQ/1zrO5gWwV4Klz8eTT7SuOIFy15unBGRsiLZIrQbo3je5Xs3bRq4RdGt2DMlq2YEuH
 qIfR5lMVhDYuG4R6NrZsebuEEOFNEkOkfP0FIv304uwlQXk6vVO9BZ8yyg/9nIW94ZhR
 RJ1uJm3WfFjXjLaxW6cqQ/01M4HPj8Tt+Bk3Iu6D3IrpGD3Gozz5E1IRiMSFZA2qvX7N
 1AX2jGDd4cFIQShBc2GozsaDosKKk/0Vce+r1Ix9Ln9ixJwf/mXJxOm8d0kZ4GdPMc3T
 weUQ==
X-Gm-Message-State: APjAAAVsKwI1irW9R5L+cm2s1TkhL1QedebIOokT9DbnfxlveOInnUsd
 Ai6EXrttpSbwhi29NMP0Z3SIXN6DrdA3AqL6W5k=
X-Google-Smtp-Source: APXvYqwW3z6yPUCGWQugD3xijpoZObmOSPsPYk96isrK4Y9L4eu3eoBDRCNxQ3dVVec+1mWltlEx8yepfq9k+0KmwuI=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr2515078otb.121.1582718019518; 
 Wed, 26 Feb 2020 03:53:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 26 Feb 2020 03:53:39 -0800 (PST)
In-Reply-To: <20200221162011.26383-1-philmd@redhat.com>
References: <20200221162011.26383-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 26 Feb 2020 12:53:39 +0100
Message-ID: <CAL1e-=jGuEy7kJ4eidi8jG8uEGaESqCH10DV4_Hq3KoHzffuJg@mail.gmail.com>
Subject: Re: [PATCH] hw/mips/mips_int: Simplify cpu_mips_irq_init_cpu()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000554621059f7941f3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000554621059f7941f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, February 21, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> Since commit d8ed887bdc, the cpu_mips_irq_request handler takes
> a pointer to MIPSCPU in its opaque argument.  Directly pass the
> cpu pointer.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Applied to the next MIPS queue.


>  hw/mips/mips_int.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> index 863ed45659..796730b11d 100644
> --- a/hw/mips/mips_int.c
> +++ b/hw/mips/mips_int.c
> @@ -77,7 +77,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
>      qemu_irq *qi;
>      int i;
>
> -    qi =3D qemu_allocate_irqs(cpu_mips_irq_request, env_archcpu(env), 8)=
;
> +    qi =3D qemu_allocate_irqs(cpu_mips_irq_request, cpu, 8);
>      for (i =3D 0; i < 8; i++) {
>          env->irq[i] =3D qi[i];
>      }
> --
> 2.21.1
>
>
>

--000000000000554621059f7941f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, February 21, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Since commit d8ed887bdc, the cpu_mips_irq_request h=
andler takes<br>
a pointer to MIPSCPU in its opaque argument.=C2=A0 Directly pass the<br>
cpu pointer.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---</blockquote><div><br></div><div>Reviewed-by: Aleksandar Markovic &lt;<a=
 href=3D"mailto:amarkovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;<br><=
/div><div><br></div><div>Applied to the next MIPS queue.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
=C2=A0hw/mips/mips_int.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c<br>
index 863ed45659..796730b11d 100644<br>
--- a/hw/mips/mips_int.c<br>
+++ b/hw/mips/mips_int.c<br>
@@ -77,7 +77,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)<br>
=C2=A0 =C2=A0 =C2=A0qemu_irq *qi;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
-=C2=A0 =C2=A0 qi =3D qemu_allocate_irqs(cpu_mips_<wbr>irq_request, env_arc=
hcpu(env), 8);<br>
+=C2=A0 =C2=A0 qi =3D qemu_allocate_irqs(cpu_mips_<wbr>irq_request, cpu, 8)=
;<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 8; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;irq[i] =3D qi[i];<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.21.1<br>
<br>
<br>
</blockquote>

--000000000000554621059f7941f3--

